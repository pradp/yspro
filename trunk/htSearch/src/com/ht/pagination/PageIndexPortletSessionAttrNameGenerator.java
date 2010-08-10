package com.ht.pagination;

import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

/**
 * 通过定制的逻辑确定PageIndex Session Attribute Name的接口,通常由Spring MVC Controller实现此接口,提供具体的逻辑,参考PaginationContextPortletHandlerInterceptor
 *
 * 
 */

public interface PageIndexPortletSessionAttrNameGenerator {

	public String generate(RenderRequest request, RenderResponse response) throws Exception;

}
