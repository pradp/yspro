/**
 * 
 */
package com.imchooser.article.search;

import java.util.List;

import com.imchooser.article.search.model.Article;

/**
 * 文章全文检索服务类接口
 * @author Jason.Yang
 * 2010-8-22
 */
public interface ArticleSearchService {

	/**
	 * 执行检索（根据userid查询权限，只检索有权限查询的数据）
	 * @param qString 要检索的关键字
	 * @param userid 登录门户的用户
	 * @return 查询的结果集
	 */
	public List<Article> search(String qString, String userid);//TODO add pager
}
