package com.ht.pagination.impl;

public class MysqlPaginationSQLGetter extends GeneralPaginationSQLGetter {

	public String getPaginationSQL(String originalSql, int first, int pageSize) {
		return new StringBuffer().append(originalSql).append(" limit ").append(first).append(",").append(pageSize).toString();
	}
}
