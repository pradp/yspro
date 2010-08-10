package com.ht.article.search;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.solr.client.solrj.impl.CommonsHttpSolrServer;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.ht.article.service.ArticleManager;

/**
 * 
 * @author cdji 2010-5-13
 */
public class ArticleIndexJob extends QuartzJobBean {

	protected final Log logger = LogFactory.getLog(getClass());

	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		try {

			ArticleIndexService articleIndexService = (ArticleIndexService) context.getJobDetail().getJobDataMap().get("articleIndexService");
			ArticleManager articleManager = (ArticleManager) context.getJobDetail().getJobDataMap().get("articleManager");
			int pageSize = Integer.parseInt((String) context.getJobDetail().getJobDataMap().get("pageSize"));
			int articleCount = articleManager.getArticleCount();
			int start = 1;
			int pages = (articleCount % pageSize == 0) ? articleCount / pageSize : articleCount / pageSize + 1;
			logger.info("all aritcles=== " + articleCount);
			logger.info("needs " + pages + " times to build index ");
			long startTime = System.currentTimeMillis();
			List articles = new ArrayList();
			//创建时先删除所有的索引
			CommonsHttpSolrServer server;
			server = new CommonsHttpSolrServer("http://localhost:7080/solr/");
			server.deleteByQuery("*:*");
			server.commit();
			//********************
			//重建所有的索引
			for (int i = 1; i < pages; i++) {
				logger.info("process times==" + i);
				articles = articleManager.getAllArticle(start, pageSize);
				// articleIndexService.addArticles(articles);
				articleIndexService.rebuildAll(articles);
				start += pageSize;
				articles.clear();

			}
			long endTime = System.currentTimeMillis();

			logger.info("build index spend " + (endTime - startTime) / 1000 + "seconds ");

		} catch (Exception e) {
			logger.error(e);
		}
	}

}
