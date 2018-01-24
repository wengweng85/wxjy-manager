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
 * 通用登录相关session Interceptor过滤器
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
    	 long beginTime = System.currentTimeMillis();//1、开始时间
         startTimeThreadLocal.set(beginTime);//线程绑定变量（该数据只有当前请求的线程可见）
    	if (handler instanceof HandlerMethod) {
			request.setAttribute("contextpath", request.getContextPath());
			Subject subject = SecurityUtils.getSubject();  
			if(subject.isAuthenticated()){
				//将当前登录信息设置到threadlocal中
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
	 * 获取ip+usergent+sessionid的hashcode
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
        //2、结束时间
        long endTime = System.currentTimeMillis();
        //得到线程绑定的局部变量（开始时间）
        long beginTime = startTimeThreadLocal.get();
        //3、消耗的时间
        long consumeTime = endTime - beginTime;
        //此处认为处理时间超过500毫秒的请求为慢请求
        if (consumeTime > OVERTIME) {
            log.info(String.format("%s consume %d millis", request.getRequestURI(), consumeTime));
        }
        SysLog slog = LogUtil.parseRequestToLog(request, response, ex);
        slog.setInterfacetype("");
        slog.setMessage("日志记录");
        slog.setCost(Long.toString(endTime - beginTime));
        slog.setSuccess("true");
        slog.setUserid(SysUserUtil.getCurrentUser()!=null?SysUserUtil.getCurrentUser().getUserid():"");
        slog.setToken("");
        slog.setMessagetype(MessageType.MESSAGE_TYPE_LOG.getCode());//系统日志
        logservice.saveLogInfo(slog);
    }
}
