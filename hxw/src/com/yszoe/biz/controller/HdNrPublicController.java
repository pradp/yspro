package com.yszoe.biz.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yszoe.biz.service.impl.HdNrServiceImpl;
import com.yszoe.cms.CmsEnum;
import com.yszoe.framework.util.Pager;

/**
 * 活动内容 前台控制器
 * @author Yangjianliang
 * datetime 2011-12-28
 */
@Controller
public class HdNrPublicController {

	private static final Log LOG = LogFactory.getLog(HdNrPublicController.class);

	@Autowired
	HdNrServiceImpl hdNrService;
	
	/**
	 * 查看活动列表
	 * @param request
	 * @param model
	 * @param pager
	 * @return
	 */
	@RequestMapping(value = "/activity/index", method = RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap model, Pager pager) {
		List<?> list = null;
		model.put("request", request);
		model.put("pager", pager);//must
		try {
			list = hdNrService.index(model, pager);
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}
		model.put("resultList", list);
		return "public/activity/index.jsp";
	}
	
	/**
	 * 查看某个活动详情
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/activity/{id}", method = RequestMethod.GET)
	public String detail(@PathVariable String id, HttpServletRequest request, ModelMap model) {
		
		try {
			model.put("bean", hdNrService.load(id));
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}

		return "public/activity/detail.jsp";
	}
	
}

