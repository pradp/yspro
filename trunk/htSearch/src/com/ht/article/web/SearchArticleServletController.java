package com.ht.article.web;

import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import com.ht.article.search.ArticleSearchService;
import com.ht.article.service.ArticleManager;

public class SearchArticleServletController extends AbstractController {
	protected ArticleSearchService articleSearchService;
	protected ArticleManager articleManager;

	public void setArticleManager(ArticleManager articleManager) {
		this.articleManager = articleManager;
	}

	public void setArticleSearchService(ArticleSearchService articleSearchService) {
		this.articleSearchService = articleSearchService;
	}

	private String[] splitListToArray(List list) {
		String[] result = new String[list.size()];
		int i = 0;
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Map mp = (Map) iterator.next();

			result[i] = mp.get("article_id").toString();
			//(String) Integer.toString((Integer) mp.get("article_id"));
			i++;

		}

		return result;

	}

 
	protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
				Map info = (Map) request.getAttribute(PortletRequest.USER_INFO);
				String userId = info.get("liferay.user.id").toString();
		*/
		String userId = "10133";
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
		List articles = articleManager.getUesrArticles(userId);
		if (articles.size() > 0) {
			String groups[] = splitListToArray(articles);

			logger.info("current login user can read artid==" + StringUtils.join(groups, "|"));
			if (groups != null && groups.length > 0) {
				if (query.length() > 0)
					query.append(" AND  (art_id:").append(StringUtils.join(groups, " OR art_id:")).append(")");
				else
					query.append("  (art_id:").append(StringUtils.join(groups, " OR art_id:")).append(")");
			}
		}
		Map model = new HashMap();
		searchResultList = articleSearchService.search(query.toString(),userId);
		model.put("searchResultList", searchResultList);
		return new ModelAndView("searchServletArticle", "model", model);
	}
}
