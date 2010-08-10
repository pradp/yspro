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
	 * ��������ʱ������
	 * 
	 * @param article
	 */
	public void addUpdateArticle(Article article);

	/**
	 * ɾ������ʱɾ������
	 * 
	 * @param artId
	 */
	public void removeArticle(String artId);

	/**
	 * �ؽ�������������
	 * 
	 * @param articles
	 */

	public void rebuildAll(List articles);
}
