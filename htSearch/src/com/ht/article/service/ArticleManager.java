package com.ht.article.service;

import java.util.List;

/**
 * 
 * @author cdji 2010-5-13
 */
public interface ArticleManager {
	/**
	 * 
	 * @param start TODO
	 * @param pageSize TODO
	 * @return 所有文章
	 */
	public List getAllArticle(int start, int pageSize);

	/**
	 * 
	 * @return 文章总数
	 */
	public int getArticleCount();

	/**
	 * 
	 * @param userId
	 * @return 当前登录用户可查看的文章ID
	 */
	public List getUesrArticles(final String userId);

}
