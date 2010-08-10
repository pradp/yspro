package com.ht.pagination;

/**
 * 分页上下文对象,对分页相关数据进行封装,并提供一些便利方法。
 *
 *  
 */

public interface PaginationContext {

	public int getPageSize();

	public void setPageSize(int pageSize);

	public int getShowIndexCount();

	public void setShowIndexCount(int showIndexCount);

	public int getRecordCount();

	public void setRecordCount(int recordCount);

	public int getPageIndex();

	public void setPageIndex(int pageIndex);

	public void setPageIndexToLast();

	public int getPageCount();

	public int getFirst();

	public int getShowStartIndex();

	public int getShowEndIndex();

}
