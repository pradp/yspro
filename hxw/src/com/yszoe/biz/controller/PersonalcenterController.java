package com.yszoe.biz.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 个人中心控制器
 * @author Yangjianliang
 * datetime 2012-1-4
 */
@Controller
public class PersonalcenterController {

//	private static final Log LOG = LogFactory.getLog(PersonalcenterController.class);


	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap model) {
		
		return "usercenter/personal/index.jsp";
	}
	
}

