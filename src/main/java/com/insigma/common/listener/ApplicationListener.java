package com.insigma.common.listener;

import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import net.sf.ehcache.Element;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.insigma.common.util.DateUtil;
import com.insigma.common.util.EhCacheUtil;
import com.insigma.mvc.component.appcontext.MyApplicationContextUtil;
import com.insigma.mvc.model.CodeType;
import com.insigma.mvc.model.CodeValue;
import com.insigma.mvc.model.SysParam;
import com.insigma.mvc.service.sysmanager.codetype.SysCodeTypeService;
import com.insigma.mvc.service.sysmanager.param.SysParamService;
import com.insigma.redis.RedisManager;

/**
 * 项目初始化
 * 
 * @author wengsh
 * 
 */
public class ApplicationListener implements   ServletContextListener  {
	Log log=LogFactory.getLog(ApplicationListener.class);


	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		
		
	}
	private static String redisswitch;
	
	static {
        Properties pro = new Properties();
        try {
            InputStream fis = ApplicationListener.class.getClassLoader().getResourceAsStream("/config/app/app.properties");
            pro.load(fis);
            redisswitch = pro.getProperty("redisswitch");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	/**
	 * 基于ehcache
	 */
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		//通过MyApplicationContextUtil获取bean
		SysParamService sysParamService= MyApplicationContextUtil.getContext().getBean(SysParamService.class);
		SysCodeTypeService sysCodeTypeService= MyApplicationContextUtil.getContext().getBean(SysCodeTypeService.class);
		
		//s_param同步
		List <SysParam> list_param=sysParamService.getList();
		for(SysParam sparam:list_param){
			EhCacheUtil.getManager().getCache("webcache").put(new Element(sparam.getParamtype(),sparam.getParamvalue()));
		}
		  //使用redis
        if (redisswitch.equals("on")) {
            log.info("使用redis加载参数");
          //通过MyApplicationContextUtil获取bean
    		RedisManager redismanager= MyApplicationContextUtil.getContext().getBean(RedisManager.class);
    		redismanager.init();
    		//是否同步标志 如果上一次同步时间是1小时之内，不同步下载代码
    		boolean syn_flag=true;
    		Date code_value_last_update_time=(Date)redismanager.get("code_value_last_update_time"); 
    		if(code_value_last_update_time!=null){
    			if(!DateUtil.compare(new Date(), code_value_last_update_time, 3600*1000)){
    				syn_flag=false;
    			}
    		}
    		
			//code_type code_value同步
			List <CodeType> list_code_type=sysCodeTypeService.getInitcodetypeList();
			if(syn_flag){
    			for(CodeType codetype : list_code_type){
    				String code_type=codetype.getCode_type();
    				codetype.setCode_type(code_type);
    				List<CodeValue> list_code_value =sysCodeTypeService.getInitCodeValueList(codetype);
    				if (list_code_value.size() > 0) {
    					//将代码参加加载到redis缓存中
    					try{
    						redismanager.set(code_type, list_code_value);
    					}catch(Exception e){
    						e.printStackTrace();
    					}
    				}
    			}
    			//上一次更新时间
    			redismanager.set("code_value_last_update_time", new Date());
			}else{
				for(CodeType codetype : list_code_type){
    				String code_type=codetype.getCode_type();
    				//将代码参加加载到redis缓存中
    				try{
    					//将代码参加加载到ehcache缓存中
    					EhCacheUtil.getManager().getCache("webcache").put(new Element(code_type,redismanager.get(code_type)));
    				}catch(Exception e){
    					e.printStackTrace();
    				}
    			}
			}
        }else{
    		//是否同步标志 如果上一次同步时间是1小时之内，不同步下载代码
    		boolean syn_flag=true;
    		Object object=EhCacheUtil.getParamFromCache("code_value_last_update_time");
    		if(object!=null){
    			Date code_value_last_update_time=(Date)object;
    			if(code_value_last_update_time!=null){
    				if(!DateUtil.compare(new Date(), code_value_last_update_time, 3600*1000)){
    					syn_flag=false;
    				}
    			}
    		}
    		if(syn_flag){
    			
    			//code_type code_value同步
    			List <CodeType> list_code_type=sysCodeTypeService.getInitcodetypeList();
    			for(CodeType codetype : list_code_type){
    				String code_type=codetype.getCode_type();
    				List<CodeValue> list_code_value =sysCodeTypeService.getInitCodeValueList(codetype);
    				if (list_code_value.size() > 0) {
    					//将代码参加加载到redis缓存中
    					try{
    						//将代码参加加载到ehcache缓存中
    						EhCacheUtil.getManager().getCache("webcache").put(new Element(code_type,list_code_value));
    					}catch(Exception e){
    						e.printStackTrace();
    					}
    				}
    			}
    			//上一次更新时间
    			EhCacheUtil.getManager().getCache("webcache").put(new Element("code_value_last_update_time",new Date()));
    		}
        }
	}
}