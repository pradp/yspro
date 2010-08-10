package com.ht.pagination;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.ServletRequestUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PaginationContextServletHandlerInterceptor extends HandlerInterceptorAdapter {

	private static final String DEFAULT_PAGE_INDEX_PARAMETER = "pageIndex";

	private static final String DEFAULT_PAGING_CONTEXT_ATTRIBUTE_NAME = "paginationContext";

	private static final String PAGE_INDEX_SESSION_ATTRIBUTE_NAME_PREFIX = "com.ht.pagination.pageIndex";

	private String pageIndexParameterName = DEFAULT_PAGE_INDEX_PARAMETER;

	private String paginationContextAttributeName = DEFAULT_PAGING_CONTEXT_ATTRIBUTE_NAME;

	private int pageSize = 20;

	private int showIndexCount = 5;

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public void setShowIndexCount(int showIndexCount) {
		this.showIndexCount = showIndexCount;
	}

	public void setPageIndexParameterName(String pageIndexParameterName) {
		this.pageIndexParameterName = pageIndexParameterName;
	}

	public void setPaginationContextAttributeName(String paginationContextAttributeName) {
		this.paginationContextAttributeName = paginationContextAttributeName;
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		PaginationContext context = new PaginationContextImpl(pageSize, showIndexCount);
		PaginationContextHolder.setPaginationContext(context);
		int pageIndex = ServletRequestUtils.getIntParameter(request, pageIndexParameterName, Integer.MIN_VALUE);
		if (pageIndex == Integer.MIN_VALUE) {
			Integer pageIndexFromSession = null;
			String pageIndexSessionAttributeName = getPageIndexSessionAttributeName(request, response, handler);
			if (pageIndexSessionAttributeName != null)
				pageIndexFromSession = (Integer) request.getSession().getAttribute(pageIndexSessionAttributeName);
			pageIndex = (pageIndexFromSession == null ? 1 : pageIndexFromSession.intValue());
		}
		context.setPageIndex(pageIndex);
		return true;
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		PaginationContext context = PaginationContextHolder.getPaginationContext();
		request.setAttribute(paginationContextAttributeName, context);
	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		PaginationContext context = PaginationContextHolder.getPaginationContext();
		if (context != null) {
			int pageIndex = context.getPageIndex();
			String pageIndexSessionAttributeName = getPageIndexSessionAttributeName(request, response, handler);
			if (pageIndexSessionAttributeName != null)
				request.getSession().setAttribute(pageIndexSessionAttributeName, new Integer(pageIndex));
			PaginationContextHolder.setPaginationContext(null);
		}
	}

	protected String getPageIndexSessionAttributeName(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if (handler instanceof PageIndexServletSessionAttrNameGenerator) {
			String pageIndexSessionAttrName = ((PageIndexServletSessionAttrNameGenerator) handler).generate(request, response);
			if (pageIndexSessionAttrName != null && !"".equals(pageIndexSessionAttrName.trim()))
				return PAGE_INDEX_SESSION_ATTRIBUTE_NAME_PREFIX + "|" + pageIndexSessionAttrName;
		}
		return null;
	}

}
