package com.ht.pagination.impl;

public class OraclePaginationSQLGetter extends GeneralPaginationSQLGetter {

	public String getCountSQL(String originalSql) {
		StringBuffer sql = new StringBuffer(" SELECT count(*) FROM ( ");
		sql.append(originalSql);
		sql.append(" )");
		return sql.toString();
	}

	public String getPaginationSQL(String originalSql, int first, int pageSize) {
		StringBuffer sql = new StringBuffer(" SELECT * FROM ( ");
		sql.append(" SELECT temp.* ,ROWNUM num FROM ( ");
		sql.append(originalSql);
		int last = first + pageSize;
		sql.append("¡¡) temp where ROWNUM <= ").append(last);
		sql.append(" ) WHERE¡¡num > ").append(first);
		return sql.toString();
	}
}
