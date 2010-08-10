package com.ht.pagination;

/**
 * 分页上下文对象,对分页相关数据进行封装,并提供一些便利方法。
 *
 *  
 */

public class PaginationContextImpl implements PaginationContext {

	private int recordCount;

	private int pageSize = 20;

	private int showIndexCount = 5;

	private int pageIndex = 1;

	public PaginationContextImpl() {
	}

	public PaginationContextImpl(int pageSize, int showIndexCount) {
		this.pageSize = pageSize;
		this.showIndexCount = showIndexCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getShowIndexCount() {
		return showIndexCount;
	}

	public void setShowIndexCount(int showIndexCount) {
		this.showIndexCount = showIndexCount;
	}

	public int getRecordCount() {
		return recordCount;
	}

	public void setRecordCount(int recordCount) {
		this.recordCount = recordCount;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		if (pageIndex < 1)
			this.pageIndex = 1;
		else
			this.pageIndex = pageIndex;
	}

	public void setPageIndexToLast() {
		int lastPageIndex = getPageCount();
		setPageIndex(lastPageIndex);
	}

	public int getPageCount() {
		return (recordCount % pageSize == 0) ? recordCount / pageSize : recordCount / pageSize + 1;
	}

	public int getFirst() {
		int result = (pageIndex - 1) * pageSize;
		return (result < 0 ? 0 : result);
	}

	public int getShowStartIndex() {
		return (pageIndex - 1) / showIndexCount * showIndexCount + 1;
	}

	public int getShowEndIndex() {
		int i = (pageIndex - 1) / showIndexCount * showIndexCount + showIndexCount;
		int pageCount = getPageCount();
		return (i < pageCount ? i : pageCount);
	}

}
