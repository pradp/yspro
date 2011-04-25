/**
 * 
 */
package com.yszoe.demo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.json.JSONException;
import org.apache.struts2.json.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yszoe.demo.entity.User;
import com.yszoe.demo.service.TestService;

/**
 * 展示前台查询的例子，restful url风格
 * @author ys
 */
@Controller
@RequestMapping("/show")  //url映射的名称
public class YsdemoController {
	protected final Log LOG = LogFactory.getLog(getClass());

	@Autowired
	private ResourceBundleMessageSource messageSource;

	@Autowired
	TestService testService;

	@RequestMapping(value = "/entity/{pid}.htm", method = RequestMethod.GET)
	public String queryEntity(@PathVariable String pid, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) {
		try {
			testService.load2(model);
		} catch (Exception e) {
			LOG.error(e);
		}
		return "test/ysview2"; // 对应 /WEB-INF/jsp 目录下的xxx.jsp 文件
	}

	@RequestMapping(value = "/json/{pid}.action", method = RequestMethod.GET)
	public @ResponseBody String jsonEntity(@PathVariable String pid, HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) {
		modelMap.addAttribute("msg", "ok");
		modelMap.addAttribute("pid", pid);
		User user = new User();
		user.setName(messageSource.getMessage("application_name",null,null));
		modelMap.addAttribute(user);
		
		String jsonString;
		try {
			jsonString = JSONUtil.serialize(modelMap);
		} catch (JSONException e) {
			jsonString = "{msg:'json对象转换异常："+e+"'}";
		}
		return jsonString; 
	}
	
}
