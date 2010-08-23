package com.imchooser.article.index;

/**
 * 为文章创建索引，具体创建方式客户端实现，可以是直接lucene接口，可以是solr的接口
 * @author Yangjianliang
 * datetime 2010-8-14
 */
public interface IndexArticleService {

	void doIndex();
}
