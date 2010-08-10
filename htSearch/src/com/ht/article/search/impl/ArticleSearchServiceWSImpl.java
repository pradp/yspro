package com.ht.article.search.impl;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.httpclient.util.URIUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.ht.article.search.AbstractSolrSearchService;
import com.ht.article.search.ArticleSearchService;
import com.ht.article.search.model.Article;
import com.ht.pagination.PaginationContext;
import com.ht.pagination.PaginationContextHolder;

/**
 * 
 * @author cdji
 * 2010-5-23
 */
public class ArticleSearchServiceWSImpl extends AbstractSolrSearchService implements ArticleSearchService {

	protected Log log = LogFactory.getFactory().getInstance(getClass());

	public List search(String term) {
		String queryResult = querySolr(term);
		if (queryResult == null || "".equals(queryResult.trim()))
			return Collections.EMPTY_LIST; 
		List result = new ArrayList();
		SAXReader reader = new SAXReader();
		try {
			Document document = reader.read(new StringReader(queryResult));
			Element resultE = (Element) document.selectSingleNode("//result[@name='response']");
		 
			Iterator docs = resultE.elementIterator("doc");
			while (docs.hasNext()) {
				Element doc = (Element) docs.next();
				Article article = new Article();
				Element title = (Element) doc.selectSingleNode("str[@name='art_title']");
				article.setArtTitle(title.getTextTrim());

				Element navigation = (Element) doc.selectSingleNode("str[@name='art_navigation']");
				article.setArtNavigation(navigation.getTextTrim());
				Element url = (Element) doc.selectSingleNode("str[@name='art_url']");
				article.setArtUrl(url.getTextTrim());
				// ���������⣬��δ����
				// Element createTimeE = (Element)
				// doc.selectSingleNode("long[@name='art_date']");
				// article.setArtDate(DateUtil.stringToDate(createTimeE.getTextTrim()));
				result.add(article);
			}

		} catch (Exception e) {
			log.error(e);
			return Collections.EMPTY_LIST;
		}
		return result;
	}

	protected String querySolr(String term) {
		try {
			StringBuffer query = new StringBuffer();
			query.insert(0, "fl=art_title,art_content,art_navigation,art_date,art_url&hl=true&hl.fl=url,art_title&hl.simple.pre=<font color='red'>&hl.simple.post=</font>&hl.snippets=2&q=");

			if (term != null && !"".equals(term.trim())) {
				query.append(term);
			}
		 
			return sendGetCommand(URIUtil.encodeQuery(query.toString(), "UTF-8"), solrSelectURL);
		} catch (Exception e) {
			log.error(e);
			return null;
		}
	}

	public List search(String term, String userid) {
		// TODO Auto-generated method stub
		return null;
	}

}
