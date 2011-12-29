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
 * 活动内容 CRUD控制器
 * @author Yangjianliang
 * datetime 2011-12-28
 */
@Controller
public class HdNrController {

	private static final Log LOG = LogFactory.getLog(HdNrController.class);

	@Autowired
	HdNrServiceImpl hdNrService;

	/**
	 * 查看活动列表
	 * @param request
	 * @param model
	 * @param pager
	 * @return
	 */
	@RequestMapping(value = "/usercenter/activities", method = RequestMethod.GET)
	public String list(HttpServletRequest request, ModelMap model, Pager pager) {
		List<?> list = null;
		model.put("request", request);
		model.put("pager", pager);//must
		try {
			list = hdNrService.list(model, pager);
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}
		model.put("resultList", list);
		return "activity/list.jsp";
	}
	
	/**
	 * 新增某个活动详情
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/usercenter/activity", method = RequestMethod.POST)
	public String create(HttpServletRequest request, ModelMap model) {

		return "public/activity/entity.jsp";
	}

	/**
	 * 修改某个活动详情
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/usercenter/activity/{id}", method = RequestMethod.PUT)
	public String modity(@PathVariable String id, HttpServletRequest request, ModelMap model) {

		return "public/activity/entity.jsp";
	}

	/**
	 * 删除活动
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/usercenter/activity", method = RequestMethod.DELETE)
	public String delete(HttpServletRequest request, ModelMap model) {

		return "public/activity/delete.jsp";
	}
	
}

