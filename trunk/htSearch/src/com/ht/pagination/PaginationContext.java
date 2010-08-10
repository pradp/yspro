package com.ht.pagination;

/**
 * ��ҳ�����Ķ���,�Է�ҳ������ݽ��з�װ,���ṩһЩ����������
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
