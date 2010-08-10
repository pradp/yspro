package com.ht.pagination;

/**
 * ��ҳ�����Ķ����Hodler,����ThreadLocal
 *
 * 
 */

public class PaginationContextHolder {

	private static ThreadLocal paginationContextHolder = new InheritableThreadLocal();

	public static PaginationContext getPaginationContext() {
		return (PaginationContext) paginationContextHolder.get();
	}

	public static void setPaginationContext(PaginationContext paginationContext) {
		paginationContextHolder.set(paginationContext);
	}

}
