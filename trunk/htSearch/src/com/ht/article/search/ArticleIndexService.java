package com.ht.article.search;

import java.util.List;

import com.ht.article.search.model.Article;

/**
 * 
 * @author cdji
 * 
 */
public interface ArticleIndexService {
	/**
	 * 新增公告时建索引
	 * 
	 * @param article
	 */
	public void addUpdateArticle(Article article);

	/**
	 * 删除公告时删除索引
	 * 
	 * @param artId
	 */
	public void removeArticle(String artId);

	/**
	 * 重建公告所有索引
	 * 
	 * @param articles
	 */

	public void rebuildAll(List articles);
}
