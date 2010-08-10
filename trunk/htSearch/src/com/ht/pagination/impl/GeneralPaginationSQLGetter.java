package com.ht.pagination.impl;

import com.ht.pagination.PaginationSQLGetter;

public abstract class GeneralPaginationSQLGetter implements PaginationSQLGetter {

	public String getCountSQL(String originalSql) {
		StringBuffer sql = new StringBuffer(" SELECT count(*) FROM ( ");
		sql.append(originalSql);
		sql.append(" ) as originalResult ");
		return sql.toString();
	}

}
