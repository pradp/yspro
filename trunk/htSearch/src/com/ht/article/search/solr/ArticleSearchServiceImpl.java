/**
 * 
 */
package com.ht.article.search.solr;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrException;
import org.apache.solr.common.SolrException.ErrorCode;

import com.ht.article.search.ArticleSearchService;
import com.ht.article.search.model.Article;
import com.ht.util.DateUtil;

/**
 * 全文检索服务实现
 * 
 * @author Jason.Yang 2010-8-22
 */
public class ArticleSearchServiceImpl extends AbstractSolrSearch implements
		ArticleSearchService {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.ht.article.search.ArticleSearchService#search(java.lang.String,
	 * java.lang.String)
	 */
	public List<?> search(String term, String userid) {
		SolrDocumentList queryResult = null;
		try {
			SolrServer server = getSolrServer();
			SolrQuery query = getSolrQuery(term, userid);
			QueryResponse qr = server.query(query);
			queryResult = qr.getResults();
			long passTime = qr.getElapsedTime();
			long numFound = queryResult.getNumFound();
			//below also support, because Article add solr @Field
//			return qr.getBeans(Article.class);
			return solrList2bizList(queryResult);
		} catch (SolrServerException e) {
			throw new SolrException(ErrorCode.SERVER_ERROR, "error when querying data", e);
		}
		
	}
	
	/**
	 * 查询结果格式化 工具
	 * @param queryResult solr的查询结果
	 * @return 业务数据对象集合
	 */
	public static List<Article> solrList2bizList(SolrDocumentList queryResult) {
		if(queryResult==null || queryResult.isEmpty()){
			return Collections.emptyList();
		}
		List<Article> articles = new ArrayList<Article>(queryResult.size());
		for (Iterator<SolrDocument> it = queryResult.iterator(); it.hasNext();) {
			SolrDocument doc = it.next();
			Article article = new Article();
			article.setArtId( Integer.parseInt(String.valueOf(doc.getFieldValue("art_id"))) );
			article.setArtTitle( String.valueOf(doc.getFieldValue("art_title")) );
			article.setArtContent( String.valueOf(doc.getFieldValue("art_content")) );
			article.setArtUrl( String.valueOf(doc.getFieldValue("art_url")) );
			try {
				article.setArtDate( DateUtil.stringToDate(String.valueOf(doc.getFieldValue("art_date"))) );
			} catch (ParseException e) {
				log.error(e);
			}
			article.setArtNavigation( String.valueOf(doc.getFieldValue("art_navigation")) );
			articles.add(article);
		}
		return articles;
	}

	/**
	 * 根据业务特点构建并返回solr的query对象实例
	 * @param term 查询关键字
	 * @param userid 查询人userid
	 * @return solr的query对象实例
	 */
	public SolrQuery getSolrQuery(String term, String userid) {
		//TODO 构建业务查询    分页处理
		SolrQuery query = new SolrQuery();
		String queryStr = "atr_sort:"
				
				+ " AND text:"
				+ term;
		// SolrUtil.filterStringValue(locContent.getContent());
		// locContent.getContent() 是从数据库里得到的数据 可能包含中文 数据库编码是（UTF8）
		// SolrUtil.filterStringValue 是对数据库里的数据进行过滤 把一些特殊字符转义 在这里也没有进行什么编码
		query.setQuery(queryStr);
		query.setFields("*,score");
		query.setRows(10);//TODO

		return query;
	}
}
