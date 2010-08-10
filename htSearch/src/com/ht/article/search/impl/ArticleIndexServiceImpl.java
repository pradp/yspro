package com.ht.article.search.impl;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Locale;

import org.apache.log4j.Logger;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.embedded.EmbeddedSolrServer;
import org.apache.solr.client.solrj.impl.CommonsHttpSolrServer;
import org.apache.solr.common.SolrInputDocument;
import org.apache.solr.core.SolrCore;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.ht.article.search.AbstractSolrIndexService;
import com.ht.article.search.ArticleIndexService;
import com.ht.article.search.model.Article;
import com.ht.article.service.ArticleManager;

/**
 * 
 * @author cdji 2010-5-13
 */
public class ArticleIndexServiceImpl extends AbstractSolrIndexService implements ArticleIndexService {

	Logger logger = Logger.getLogger(ArticleIndexServiceImpl.class);
	protected static SimpleDateFormat solrFormatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS", Locale.US);

	ArticleManager articleManager;

	public void setArticleManager(ArticleManager articleManager) {
		this.articleManager = articleManager;
	}

	private void addArticle(Article article, boolean commit) {
		Document document = DocumentHelper.createDocument();
		Element add = document.addElement("add");
		Element doc = add.addElement("doc");

		// base64简单加密，解决某些特殊字符在建索引用dom解析时会抛错。
		// 在查询的时候将查询条件也需要用base64加密查询，返回结果需要将所有字符解密 new
		// String(Base64.encodeBase64(s.getBytes()));

		Element art_id = doc.addElement("field").addAttribute("name", "art_id");
		//art_id.setText(new BASE64Encoder().encode(article.getArtId().getBytes()));
		art_id.setText(String.valueOf(article.getArtId()));
		Element url = doc.addElement("field").addAttribute("name", "art_url");
		url.setText(article.getArtUrl());
		Element title = doc.addElement("field").addAttribute("name", "art_title");
		//title.setText(new BASE64Encoder().encode(article.getArtTitle().getBytes()));
		title.setText(article.getArtTitle());
		Element content = doc.addElement("field").addAttribute("name", "art_content");

		//content.setText(new BASE64Encoder().encode(article.getArtContent().getBytes()));
		//content.setText(article.getArtContent());
		//Element navigation = doc.addElement("field").addAttribute("name", "art_navigation");
		//navigation.setText(new BASE64Encoder().encode(article.getArtNavigation().getBytes()));
		//navigation.setText(article.getArtNavigation());
		//Element artPubDate = doc.addElement("field").addAttribute("name", "art_date");
		//artPubDate.setData(new BASE64Encoder().encode(DateUtil.formatIso8601(article.getArtDate()).getBytes()));
		//artPubDate.setData(solrFormatter.format(article.getArtDate()) + "Z");
		sendPostCommand(document.asXML(), solrUpdateURL);
		if (commit)
			processCommit();

	}

	private void addArticleSolrJ(Article article, boolean commit) {
		SolrCore core = SolrCore.getSolrCore();
		SolrServer server = new EmbeddedSolrServer(core);

		SolrInputDocument doc1 = new SolrInputDocument();
		doc1.addField("id", "id1", 1.0f);
		doc1.addField("name", "doc1", 1.0f);
		doc1.addField("price", 10);
		if (commit)
			processCommit();

	}

	private void removeArticle(int artId, boolean commit) {
		Document document = DocumentHelper.createDocument();
		Element delete = document.addElement("delete");

		Element query = delete.addElement("query");
		query.setText("art_id:" + artId);
		sendPostCommand(document.asXML(), solrUpdateURL);
		if (commit)
			processCommit();

	}

	private void addArticles(final List articles) {

		CommonsHttpSolrServer server;
		try {
			server = new CommonsHttpSolrServer("http://localhost:7080/solr/");

			Collection<SolrInputDocument> docs = new ArrayList<SolrInputDocument>();
			long start1 = System.currentTimeMillis();
			for (int i = 0; i < articles.size(); i++) {
				long start = System.currentTimeMillis();
			 
				Article article = (Article) articles.get(i);
				SolrInputDocument doc = new SolrInputDocument();
				doc.addField("art_id", article.getArtId());
				doc.addField("art_url", article.getArtUrl());
				doc.addField("art_title", article.getArtTitle());
				doc.addField("art_content", article.getArtContent());
				docs.add(doc);
				
				 

				if (i % 500 == 0) {
				 
					server.add(docs);
				 	server.commit();
				 	docs.clear();
					server=null;
					server=	new CommonsHttpSolrServer("http://localhost:7080/solr/");
				  
					docs = new ArrayList<SolrInputDocument>();
					long end = System.currentTimeMillis();
					logger.info("index 500 docs needs  " + (end - start) / 1000 + " second");
				}

			}
			long end1 = System.currentTimeMillis();
			logger.info("process 1W records need" + (end1 - start1) / 1000 + " second");
			server.commit();

		} catch (SolrServerException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();

		}

	}

	private void removeArticles(final List articles) {
		for (int i = 0; i < articles.size(); i++) {
			try {
				removeArticle(((Article) articles.get(i)).getArtId(), false);
			} catch (Exception e) {
				log.error(e);
			}
		}
		processCommit();

	}

	public void rebuildAll(final List articles) {

		//	 removeArticles(articles);
		//logger.info("article index deleted successfully.");
		addArticles(articles);
		logger.info("article index rebuilded successfully.");

	}

	public void addUpdateArticle(Article article) {
		addArticle(article, true);
	}

	public void removeArticle(String artId) {
		//nothing to do 

	}

}
