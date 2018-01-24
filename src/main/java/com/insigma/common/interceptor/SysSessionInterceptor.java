package com.insigma.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NamedThreadLocal;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.insigma.common.util.MD5Util;
import com.insigma.dto.MessageType;
import com.insigma.mvc.component.log.LogUtil;
import com.insigma.mvc.model.SysLog;
import com.insigma.mvc.model.SysUser;
import com.insigma.mvc.service.sysmanager.log.SysLogService;
import com.insigma.mvc.service.sysmanager.login.SysLoginService;
import com.insigma.shiro.realm.SysUserUtil;

/**
 * ͨ�õ�¼���session Interceptor������
 * @author wengsh
 * @date 2015-8-17
 *
 */
public class SysSessionInterceptor extends HandlerInterceptorAdapter {

	Log log=LogFactory.getLog(SysSessionInterceptor.class);

    private static int OVERTIME = 500;
    
	@Autowired
	private SysLoginService sysloginservice;
	
	@Autowired
	private SysLogService logservice;
	
	private NamedThreadLocal<Long> startTimeThreadLocal = new NamedThreadLocal<Long>("StopWatch-StartTime");
	
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	 long beginTime = System.currentTimeMillis();//1����ʼʱ��
         startTimeThreadLocal.set(beginTime);//�̰߳󶨱�����������ֻ�е�ǰ������߳̿ɼ���
    	if (handler instanceof HandlerMethod) {
			request.setAttribute("contextpath", request.getContextPath());
			Subject subject = SecurityUtils.getSubject();  
			if(subject.isAuthenticated()){
				//����ǰ��¼��Ϣ���õ�threadlocal��
				SysUserUtil.setCurrentUser ((SysUser)subject.getSession().getAttribute(SysUserUtil.SHIRO_CURRENT_USER_INFO));  
				if(sysloginservice.findLoginInfoByhashcode(getReqeustHashcode(request))!=null){
					return true;
				}else{
					return false;
				}
			}
            return true;
        } else {
            return super.preHandle(request, response, handler);
        }
    }
    
	/**
	 * ��ȡip+usergent+sessionid��hashcode
	 * @param request
	 * @return
	 */
	public String getReqeustHashcode(HttpServletRequest request ){
		String ip=request.getRemoteHost();
		String useragent=request.getHeader("User-Agent");
		String sessionid=request.getSession().getId();
		return MD5Util.MD5Encode(ip+useragent+sessionid);
	}
	
	  /**
     * afterCompletion
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        //2������ʱ��
        long endTime = System.currentTimeMillis();
        //�õ��̰߳󶨵ľֲ���������ʼʱ�䣩
        long beginTime = startTimeThreadLocal.get();
        //3�����ĵ�ʱ��
        long consumeTime = endTime - beginTime;
        //�˴���Ϊ����ʱ�䳬��500���������Ϊ������
        if (consumeTime > OVERTIME) {
            log.info(String.format("%s consume %d millis", request.getRequestURI(), consumeTime));
        }
        SysLog slog = LogUtil.parseRequestToLog(request, response, ex);
        slog.setInterfacetype("");
        slog.setMessage("��־��¼");
        slog.setCost(Long.toString(endTime - beginTime));
        slog.setSuccess("true");
        slog.setUserid(SysUserUtil.getCurrentUser()!=null?SysUserUtil.getCurrentUser().getUserid():"");
        slog.setToken("");
        slog.setMessagetype(MessageType.MESSAGE_TYPE_LOG.getCode());//ϵͳ��־
        logservice.saveLogInfo(slog);
    }
}
