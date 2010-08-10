package com.ht.pagination;

/**
 * 产生分页查询语句的接口。
 *
 * 
 */

public interface PaginationSQLGetter {

	public String getPaginationSQL(String originalSql, int first, int pageSize);

	public String getCountSQL(String originalSql);

}
