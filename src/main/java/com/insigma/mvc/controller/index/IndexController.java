package com.insigma.mvc.controller.index;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.insigma.common.listener.AppConfig;
import com.insigma.mvc.MvcHelper;
import com.insigma.mvc.model.SysPermission;
import com.insigma.mvc.service.index.IndexService;
import com.insigma.shiro.realm.SysUserUtil;



/**
 * 工作网首页contoller
 * @author wengsh
 *
 */
@Controller
public class IndexController extends MvcHelper<SysPermission> {
	
	@Resource
    private IndexService indexService;
	
	
	/**
	 * 管理功能主页面
	 * @param request
	 * @return
	 */
	@RequestMapping("/")
	public ModelAndView gotoAdminIndex(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("index/admin_index");
	    String systitle=AppConfig.getProperties("SYS_TITLE");
		if(systitle!=null&&!systitle.equals("")){
			modelAndView.addObject("SYS_TITLE", systitle);
		}else{
			modelAndView.addObject("SYS_TITLE", "待维护");
		}
		modelAndView.addObject("suser", SysUserUtil.getCurrentUser());
    	modelAndView.addObject("permlist",SysUserUtil.getCurrentUser().getPermlist());
        return modelAndView;
	}
	
	
	/**
	 * 系统主页
	 * @param request
	 * @return
	 */
	@RequestMapping("/index")
	public ModelAndView gotoIndex(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("index/index");
        return modelAndView;
	}
	
	/**
	 * http 404 错误
	 * @param request
	 * @return
	 */
	@RequestMapping("/404")
	public ModelAndView error404(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("error/404");
        return modelAndView;
	}
	
	/**
	 * http 500 错误
	 * @param request
	 * @return
	 */
	@RequestMapping("/500")
	public ModelAndView error500(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("error/500");
        return modelAndView;
	}
	
	/**
	 *  未授权
	 * @param request
	 * @return
	 */
	@RequestMapping("/unrecognized")
	public ModelAndView unrecognized(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("error/unrecognized");
        return modelAndView;
	}
	
	/**
	 *  未授权
	 * @param request
	 * @return
	 */
	@RequestMapping("/resubmit")
	public ModelAndView resubmit(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("error/resubmit");
        return modelAndView;
	}
	
	
}
