package com.ht.pagination.impl;

public class DB2PaginationSQLGetter extends GeneralPaginationSQLGetter {

	public String getPaginationSQL(String originalSql, int first, int pageSize) {
		int end = first + pageSize;
		first++;
		StringBuffer sb = new StringBuffer();
		sb.append("select * from ( ").append("select db2_t1.*,rownumber() over() as row_next from (").append(originalSql).append(") as db2_t1) as db2_t2  where row_next between ");
		sb.append(first).append(" and ").append(end);
		return sb.toString();
	}

	public String getCountSQL(String originalSql) {
		StringBuffer sql = new StringBuffer(" SELECT count(*) as num FROM ( ");
		sql.append(originalSql);
		sql.append(" ) as db2_cause ");
		return sql.toString();
	}

}
