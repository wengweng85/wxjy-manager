package com.insigma.mvc.controller.sercatalogue.SER_MGMT_001_001;


import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.insigma.mvc.MvcHelper;



/**
 * 服务目录管理contoller
 * @author wengsh
 *
 */
@Controller
public class SerCatalogueController extends MvcHelper {
	
	/**
	 *跳转至 服务目录列表页
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/ser/catalogues",method=RequestMethod.GET)
	public ModelAndView catalogues(HttpServletRequest request,Model model) throws Exception {
		ModelAndView modelAndView=new ModelAndView("sercatalogue/SER_MGMT_001_001/serCatalogueList");
        return modelAndView;
	}
	
	/**
	 *跳转至服务目录新增页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/ser/to/catalogues/{cataId}",method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request,Model model,@ PathVariable String cataId) throws Exception {
		ModelAndView modelAndView=new ModelAndView("sercatalogue/SER_MGMT_001_001/serCatalogueEdit");
        return modelAndView;
	}
	
}
