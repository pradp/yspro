package com.ht.article.web;

import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.portlet.PortletPreferences;
import javax.portlet.PortletRequest;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.portlet.ModelAndView;
import org.springframework.web.portlet.mvc.AbstractController;

import com.ht.article.search.ArticleSearchService;
import com.ht.article.service.ArticleManager;

public class SearchArticleController extends AbstractController {
	protected ArticleSearchService articleSearchService;
	protected ArticleManager articleManager;

	public void setArticleManager(ArticleManager articleManager) {
		this.articleManager = articleManager;
	}

	public void setArticleSearchService(ArticleSearchService articleSearchService) {
		this.articleSearchService = articleSearchService;
	}

	public ModelAndView handleRenderRequestInternal(RenderRequest request, RenderResponse response) throws Exception {
		Map info = (Map) request.getAttribute(PortletRequest.USER_INFO);
		String userId = info.get("liferay.user.id").toString();
		logger.info("current login user==" + userId);

		String term = request.getParameter("term");
		if (term != null)
			term = term.trim();
		StringBuffer query = new StringBuffer();

		List searchResultList = Collections.EMPTY_LIST;
		if (term != null && !"".equals(term.trim())) {
			// query.append("( ").append(new
			// BASE64Encoder().encode(term.getBytes())).append(" )");
			query.append("(").append(term).append(")");
		}

		Map model = new HashMap();
		searchResultList = articleSearchService.search(query.toString(), userId);
		model.put("searchResultList", searchResultList);
		return new ModelAndView("searchArticle", "model", model);
	}

}
