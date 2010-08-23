package com.imchooser.article.index;

import com.imchooser.article.index.impl.IndexArticleBySolrImpl;

/**
 * 文章索引创建实现类的工厂
 * @author Yangjianliang
 * datetime 2010-8-14
 */
public class IndexArticleFactory {

//	private static final Log LOG = LogFactory.getLog(IndexArticleFactory.class);

	public static IndexArticleService getInstance(){
		//TODO change if need control...
		return new IndexArticleBySolrImpl();
	}
}
