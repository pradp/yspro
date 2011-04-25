package com.yszoe.demo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yszoe.demo.service.TestService;

/**
 * 展示 CRUD 操作的例子
 * @author ys
 * 
 */
@Controller
@RequestMapping("/show")  //url映射的名称
public class YsCrudDemoController {
	protected final Log logger = LogFactory.getLog(getClass());

	@Autowired
	private ResourceBundleMessageSource messageSource;

	@Autowired
	private TestService testService;
	
	@RequestMapping(value = "/{pid}.action", method = RequestMethod.GET)
	public String showEntity(@PathVariable String pid, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) {
		request.setAttribute("message", "You request pid is: <b>" + pid
				+ "</b>");
		logger.info("===="+pid);
		return "ysview"; // 对应 /WEB-INF/jsp 目录下的 topic.jsp 文件
	}
	
	@RequestMapping(value="/add.action")
    public String add(HttpServletRequest request,   
            HttpServletResponse response){
        System.out.println("Hello www.JavaBloger.com ");
        request.setAttribute("message", "Hello JavaBloger ! ,@RequestMapping(value='/add')"); 
        return "ysview";  // 对应 /WEB-INF/jsp 目录下的 topic.jsp 文件
    }

	@RequestMapping(value="/list.action")
    public String list(HttpServletRequest request,   
            HttpServletResponse response, ModelMap modelMap){

		modelMap.addAttribute("results", "Hello JavaBloger ! ,@RequestMapping(value='/add')");
        testService.list(modelMap);
        return "cruddemo/list"; 
    }
}
