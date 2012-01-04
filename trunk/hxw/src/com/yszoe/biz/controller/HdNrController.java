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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.yszoe.biz.entity.THdNr;
import com.yszoe.biz.service.impl.HdNrServiceImpl;
import com.yszoe.cms.CmsEnum;
import com.yszoe.framework.util.Pager;
import com.yszoe.util.JSONUtils;

/**
 * 活动内容 控制器，包括会员CRUD和前台查看。管理员管理由struts2完成。
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
	@RequestMapping(value = "/activities", method = RequestMethod.GET)
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
			model.put("bean", hdNrService.detail(id));
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}

		return "public/activity/detail.jsp";
	}

	/**
	 * 查看活动列表
	 * @param request
	 * @param model
	 * @param pager
	 * @return
	 */
	@RequestMapping(value = "/myactivities", method = RequestMethod.GET)
	public String list(HttpServletRequest request, ModelMap model, Pager pager, THdNr thdNr) {
		List<?> list = null;
		model.put("pager", pager);//must，后续页面要从model里取
		model.put("bean", thdNr);
		model.put("basePath", request.getContextPath());
		try {
			list = hdNrService.list(model, request, pager);
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}
		model.put("resultList", list);
		return "usercenter/activity/list.jsp";
	}

	/**
	 * 查看某个活动详情
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/myactivity/{id}", method = RequestMethod.GET)
	public String load(@PathVariable String id, HttpServletRequest request, ModelMap model) {
		model.put("wid", id);
		try {
			hdNrService.load(model);
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}

		return "usercenter/activity/entity.jsp";
	}
	
	/**
	 * 新增或修改某个活动详情
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/myactivity", method = RequestMethod.POST)
	public String save(MultipartHttpServletRequest request, ModelMap model, THdNr thdNr) {
		model.put("bean", thdNr);
		model.put("request", request);
		try {
			hdNrService.saveOrUpdate(model);
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}
		return "usercenter/activity/entity.jsp";
	}

	/**
	 * 删除活动
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/myactivity", method = RequestMethod.DELETE)
	public @ResponseBody String delete(HttpServletRequest request, ModelMap model) {

		String wid = (String)request.getParameter("wid");
		model.put("wid", wid);
		try {
			boolean f = hdNrService.remove(model);
			if(f){
				model.put("msg", "ok");
			}else{
				model.put("msg", "no");
			}
		} catch (Exception e) {
			LOG.error(e);
			model.put("msg", e.getMessage());
		}
		return JSONUtils.castToString(model);
	}
	
}

