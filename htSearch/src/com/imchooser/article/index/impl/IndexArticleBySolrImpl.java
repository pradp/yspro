package com.imchooser.article.index.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.article.index.IndexArticleService;

/**
 * 为文章创建索引，使用solr api
 * solr提供了dataimporthander方式，已经实现类似功能。
 * @author Yangjianliang
 * datetime 2010-8-14
 */
public class IndexArticleBySolrImpl implements IndexArticleService{

	private static final Log LOG = LogFactory.getLog(IndexArticleBySolrImpl.class);
	
	/**
	 * i use solr DataImportHandler
	 */
	public void doIndex(){
		
	}

}
