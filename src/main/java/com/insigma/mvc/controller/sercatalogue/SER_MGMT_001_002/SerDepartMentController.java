package com.insigma.mvc.controller.sercatalogue.SER_MGMT_001_002;


import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.insigma.mvc.MvcHelper;
import com.insigma.shiro.realm.SysUserUtil;



/**
 * 服务受理机构管理contoller
 * @author wengsh
 *
 */
@Controller
public class SerDepartMentController extends MvcHelper {
	
	/**
	 *跳转至 服务目录列表页
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/ser/departments",method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("demo/demoQuery");
		//更新当前用户权限
		SysUserUtil.updateCurrentUserPerms();
        return modelAndView;
	}
	
}
