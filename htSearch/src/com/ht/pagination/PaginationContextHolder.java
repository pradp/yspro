package com.ht.pagination;

/**
 * 分页上下文对象的Hodler,基于ThreadLocal
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
