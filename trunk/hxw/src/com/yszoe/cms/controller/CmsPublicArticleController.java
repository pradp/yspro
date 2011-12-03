package com.yszoe.cms.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yszoe.cms.CmsEnum;
import com.yszoe.cms.service.impl.CmsPublicArticleServiceImpl;
import com.yszoe.framework.util.Pager;
import com.yszoe.identity.IdConstants;

/**
 * CMS展示前台部分，restful url风格
 * @author Yangjianliang
 * datetime 2011-7-8
 */
@Controller
public class CmsPublicArticleController {

	private static final Log LOG = LogFactory.getLog(CmsPublicArticleController.class);

	@Autowired
	CmsPublicArticleServiceImpl cmsPublicArticleService;

	/**
	 * 查看某篇文章的详细内容
	 * @param articlesorten 文章栏目英文名。
	 * @param articleindexid 文章索引号
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/html/{channelpinyin}-{articleindexid}.jhtm", method = RequestMethod.GET)
	public String queryEntity(@PathVariable String channelpinyin, @PathVariable String articleindexid, 
			HttpServletRequest request, ModelMap model, Pager pager) {
		if("zlxz".equals(channelpinyin)){//资料下载栏目需要登录后才能用
			HttpSession session = request.getSession();
			if(session.getAttribute(IdConstants.SESSION_USER)==null){
				return "cms/public/forbid.jsp";
			}
		}
		model.put("wid", articleindexid);
		model.put("pager", pager);
		try {
			cmsPublicArticleService.load(model);
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}
		return "cms/public/cmsViewArticle.jsp"; // 对应 /WEB-INF/jsp/public 目录下的xxx.jsp 文件
	}

	/**
	 * 某频道下的新闻列表
	 * @param articlesorten
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/channel/{channelpinyin}.jhtm", method = RequestMethod.GET)
	public String queryList(@PathVariable String channelpinyin, 
			HttpServletRequest request, ModelMap model, Pager pager) {
		List<?> list = Collections.EMPTY_LIST;
		model.put("channelpinyin", channelpinyin);
		model.put("bt", request.getParameter("q"));
		pager.setEachPageRows(20);
		try {
			list = cmsPublicArticleService.list(model, pager);
			model.put("resultList", list);
		} catch (Exception e) {
			LOG.error(e);
			model.addAttribute(CmsEnum.AppError.toString(), e);
		}
		return "cms/public/cmsChannelArticle.jsp"; // 对应 /WEB-INF/jsp/public 目录下的xxx.jsp 文件
	}

}
