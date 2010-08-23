package com.ht.article.service.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.RowMapperResultSetExtractor;

import com.ht.article.search.model.Article;
import com.ht.article.service.ArticleManager;

/**
 * 
 * @author cdji 2010-5-13
 */
public class GeneralArticleManagerImpl implements ArticleManager {
	Logger logger = Logger.getLogger(GeneralArticleManagerImpl.class);
	private JdbcTemplate jdbcTemplate;
	private String urlPattern;

	public void setUrlPattern(String urlPattern) {
		this.urlPattern = urlPattern;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List getAllArticle(int start, int pageSize) {

		String sql = new StringBuffer("select article_id,title,content  from article ").append("  limit ").append(start).append(",").append(pageSize).toString();
		return (ArrayList) jdbcTemplate.query(sql, new RowMapperResultSetExtractor(new ArticleRowMapper()));

	}

	private class ArticleRowMapper implements RowMapper {
		public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
			Article article = new Article();
			int  artId = rs.getInt("article_id");
			article.setArtId(artId);
			article.setArtContent(rs.getString("content"));
			//article.setArtDate(rs.getTimestamp("upate_time"));
			//article.setArtNavigation(rs.getString("navigation"));
			article.setArtTitle(rs.getString("title"));
			article.setArtUrl(MessageFormat.format(urlPattern, new Object[] { artId }));

			return article;
		}
	}

	public List getUesrArticles(final String userId) {
		//String sql = "select article_id from webcms.article where category_id in (select category_id from webcms.category where category_id in (select category_id from webcms.category_role where role_id in ( select roleid  from  lportal.Users_Roles where userid=? ) ) )";
		String sql = "select article_id from  article where category_id in (select category_id from  category where category_id in (select category_id from category_role where role_id in ( select roleid  from lportal.Users_Roles where userid=? ) ) )";
		logger.info(sql);
		return jdbcTemplate.queryForList(sql, new Object[] { userId });

	}

	public int getArticleCount(){
		String sql = "select count(*) as count from article";
		return jdbcTemplate.queryForInt(sql);
	}
}
