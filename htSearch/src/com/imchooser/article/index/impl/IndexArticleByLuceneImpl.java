package com.imchooser.article.index.impl;

import java.util.ResourceBundle;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.article.index.IndexArticleService;

/**
 * 为文章创建lucene索引
 * @author Yangjianliang
 * datetime 2010-8-14
 */
public class IndexArticleByLuceneImpl implements IndexArticleService{

	private static final Log LOG = LogFactory.getLog(IndexArticleByLuceneImpl.class);
	private static final ResourceBundle searchResourceFile = ResourceBundle.getBundle("search");
	
	public void doIndex(){
		
	}

	public static String getSolrIndexDataDir(){
		return searchResourceFile.getString("solr.indexDataDir");
	}
}
