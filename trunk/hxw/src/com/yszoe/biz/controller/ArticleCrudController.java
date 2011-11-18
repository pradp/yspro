package com.yszoe.biz.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yszoe.biz.service.impl.ArticleCrudServiceImpl;
import com.yszoe.cms.CmsEnum;
import com.yszoe.cms.entity.TXxfbWz;
import com.yszoe.framework.util.Pager;
import com.yszoe.util.JSONUtils;

/**
 * spring crud example
 * @author Yangjianliang
 * datetime 2011-9-9
 */
@Controller
public class ArticleCrudController {

	private static final Log LOG = LogFactory.getLog(ArticleCrudController.class);

	@Autowired
	ArticleCrudServiceImpl articleCrudService;

	/**
	 * 输出集合实例
	 * @param articlesorten
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/article/list.jhtm")
	public String list(HttpServletRequest request, ModelMap model, Pager pager) {
		List<?> list = null;
		model.put("request", request);
		model.put("pager", pager);//must
		try {
			list = articleCrudService.list(model, pager);
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}
		model.put("resultList", list);
		return "demo/springmvc/list.jsp";
	}

	/**
	 * 查看某篇文章的详细内容
	 * @param wid 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/article/input.jhtm", method = RequestMethod.GET)
	public String input(HttpServletRequest request, ModelMap model) {
		model.put("request", request);
		String wid = (String)request.getParameter("wid");
		model.put("wid", wid);
		try {
			if(StringUtils.isBlank(wid)){
				articleCrudService.openCreate(model);
			}else{
				articleCrudService.load(model);
			}
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}
		return "demo/springmvc/input.jsp";
	}

	@RequestMapping(value = "/article/save.jhtm", method = RequestMethod.POST)
	public String save(HttpServletRequest request, ModelMap model, @ModelAttribute("entityBean") TXxfbWz entityBean) {

		model.put("request", request);
		model.put("entityBean", entityBean);
		try {
			articleCrudService.saveOrUpdate(model);
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}
		return "demo/springmvc/input.jsp";
	}

	@RequestMapping(value = "/article/remove.jhtm", method = RequestMethod.POST)
	public @ResponseBody String remove(HttpServletRequest request, ModelMap model) {

		String wid = (String)request.getParameter("wid");
		model.put("wid", wid);
		try {
			boolean f = articleCrudService.remove(model);
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
