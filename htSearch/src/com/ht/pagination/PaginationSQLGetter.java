package com.ht.pagination;

/**
 * ������ҳ��ѯ���Ľӿڡ�
 *
 * 
 */

public interface PaginationSQLGetter {

	public String getPaginationSQL(String originalSql, int first, int pageSize);

	public String getCountSQL(String originalSql);

}
