package com.ht.pagination;

import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;

/**
 * JdbcDaoSupport的扩展类,可注入PaginationSQLGetter,可获取JdbcTemplateWithPagination。
 *
 *  
 */

public class JdbcDaoSupportWithPagination extends JdbcDaoSupport {

	private PaginationSQLGetter paginationSQLGetter;

	public void setPaginationSQLGetter(PaginationSQLGetter paginationSQLGetter) {
		this.paginationSQLGetter = paginationSQLGetter;
	}

	protected JdbcTemplate createJdbcTemplate(DataSource dataSource) {
		return new JdbcTemplateWithPagination(dataSource);
	}

	public JdbcTemplateWithPagination getJdbcTemplateWithPagination() {
		JdbcTemplate jdbcTemplate = getJdbcTemplate();
		if (jdbcTemplate instanceof JdbcTemplateWithPagination) {
			((JdbcTemplateWithPagination) jdbcTemplate).setPaginationSQLGetter(this.paginationSQLGetter);
			return (JdbcTemplateWithPagination) jdbcTemplate;
		}
		throw new IllegalStateException("The Type of JdbcTemplate is not JdbcTemplateWithPagination");
	}

}
