package com.ht.article.search.impl;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.util.URIUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.ht.article.search.AbstractSolrSearchService;
import com.ht.article.search.ArticleSearchService;
import com.ht.article.search.model.Article;
import com.ht.article.service.ArticleManager;
import com.ht.pagination.PaginationContext;
import com.ht.pagination.PaginationContextHolder;

/**
 * 
 * @author cdji 2010-5-13
 */
public class ArticleSearchServiceImpl extends AbstractSolrSearchService implements ArticleSearchService {

	Logger logger = Logger.getLogger(ArticleSearchServiceImpl.class);
	ArticleManager articleManager;

	public void setArticleManager(ArticleManager articleManager) {
		this.articleManager = articleManager;
	}

	public List searchPrepared(String term) {
		String queryResult = querySolr(term);
		if (queryResult == null || "".equals(queryResult.trim()))
			return Collections.EMPTY_LIST;
		List result = new ArrayList();
		long start = System.currentTimeMillis();
		SAXReader reader = new SAXReader();
		try {
			Document document = reader.read(new StringReader(queryResult));
			Element resultE = (Element) document.selectSingleNode("//result[@name='response']");
			Iterator docs = resultE.elementIterator("doc");

			while (docs.hasNext()) {
				Element doc = (Element) docs.next();
				Article article = new Article();
				Element artId = (Element) doc.selectSingleNode("str[@name='art_id']");
				if (artId != null) {
					article.setArtId(Integer.parseInt(artId.getTextTrim()));
					result.add(article);
				}
			}

		} catch (Exception e) {
			//log.error(e);
			e.printStackTrace();
			return Collections.EMPTY_LIST;
		}
		long end = System.currentTimeMillis();
		logger.info("search prepared needs" + (end - start) / 1000 + " seconds");
		return result;
	}

	public List searchWithRole(String term) {
		String queryResult = querySolr2(term);
		if (queryResult == null || "".equals(queryResult.trim()))
			return Collections.EMPTY_LIST;
		List result = new ArrayList();
		SAXReader reader = new SAXReader();
		long start = System.currentTimeMillis();
		try {
			Document document = reader.read(new StringReader(queryResult));
			Element resultE = (Element) document.selectSingleNode("//result[@name='response']");
			// 设置分页的记录数

			Iterator docs = resultE.elementIterator("doc");

			while (docs.hasNext()) {
				Element doc = (Element) docs.next();
				Article article = new Article();
				Element title = (Element) doc.selectSingleNode("str[@name='art_title']");
				if (title != null) {
					article.setArtTitle(title.getTextTrim());
					Element url = (Element) doc.selectSingleNode("str[@name='art_url']");
					article.setArtUrl(url.getTextTrim());

					// 日期有问题，暂未处理
					// Element createTimeE = (Element)
					// doc.selectSingleNode("long[@name='art_date']");
					// article.setArtDate(DateUtil.stringToDate(createTimeE.getTextTrim()));
					result.add(article);
				}
			}

		} catch (Exception e) {
			//log.error(e);
			e.printStackTrace();
			return Collections.EMPTY_LIST;
		}
		long end = System.currentTimeMillis();
		logger.info("search key  with role  needs" + (end - start) / 1000 + " seconds");
		return result;
	}

	protected String querySolr(String term) {
		try {
			StringBuffer query = new StringBuffer();
			query.insert(0, "fl=art_id&start=1&rows=1000000&q=");

			if (term != null && !"".equals(term.trim())) {
				query.append(term);
			}

			log.info("query prepared string==" + query);
			return sendGetCommand(URIUtil.encodeQuery(query.toString(), "UTF-8"), solrSelectURL);
		} catch (Exception e) {
			log.error(e);
			return null;
		}
	}

	protected String querySolr2(String term) {
		try {
			StringBuffer query = new StringBuffer();
			query.insert(0, "fl=art_title,art_url&q=");

			if (term != null && !"".equals(term.trim())) {
				query.append(term);
			}

			log.info("query  with role  string==" + query);
			return sendGetCommand(URIUtil.encodeQuery(query.toString(), "UTF-8"), solrSelectURL);
		} catch (Exception e) {
			log.error(e);
			return null;
		}
	}

	public List search(String term, String userid) {
		List resultList = Collections.EMPTY_LIST;
		if (!StringUtils.isEmpty(term)) {
			List preList = searchPrepared(term);
			List articles = getUserReadArticle(userid);
			List userArticles = processArticles(  preList,articles);
			PaginationContext context = PaginationContextHolder.getPaginationContext();
			context.setRecordCount((userArticles.size() < 1) ? 0 : userArticles.size());
			int first = context.getFirst();
			int pageSize = context.getPageSize();
			StringBuffer query = new StringBuffer(term);

			if (userArticles.size() > 0) {

				if (query.length() > 0)
					query.append(" AND  (");
				else
					query.append("(");

				if (userArticles.size() <= pageSize) {
					for (int i = first, j=1; i <  userArticles.size(); i++) {
						if (j != userArticles.size())
							query.append(" art_id:").append(userArticles.get(i)).append(" OR ");
						else
							query.append(" art_id:").append(userArticles.get(i));
						j++;
					}
				} else {
					for (int i = first,j=1; i <  pageSize+first; i++) {
						if (j != pageSize)
							query.append(" art_id:").append(userArticles.get(i)).append(" OR ");
						else
							query.append(" art_id:").append(userArticles.get(i));
						j++;
					}
				}

				query.append(")").append("&start=0").append("&rows=").append(pageSize);

			}
			resultList = searchWithRole(query.toString());
		}

		return resultList;
	}

	protected List getUserReadArticle(String userid) {
		long start = System.currentTimeMillis();
		List articles = articleManager.getUesrArticles(userid);
		long end = System.currentTimeMillis();
		logger.info("getUserReadArticle needs" + (end - start) / 1000 + " seconds");
		return articles;

	}
/**
 * 
 * @param preList 所有的文章 
 * @param articles 可读的文章
 * @return
 */
	protected List processArticles(List preList, List articles) {
		long start = System.currentTimeMillis();
		List fetchArticles = new ArrayList();
		for (Iterator iterator = preList.iterator(); iterator.hasNext();) {
			Article article = (Article) iterator.next();
			for (Iterator iterator1 = articles.iterator(); iterator1.hasNext();) {
				Object obj = ((Map) iterator1.next()).get("article_id");
				int article_id = Integer.parseInt(obj.toString());
				if (article_id == (article.getArtId())) {
					fetchArticles.add(article.getArtId());
				}
			}

		}
		long end = System.currentTimeMillis();
		logger.info("process Articles needs " + (end - start) / 1000 + " seconds");
		return fetchArticles;

	}

}
