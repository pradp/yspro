package com.ht.pagination;

import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

/**
 * ͨ�����Ƶ��߼�ȷ��PageIndex Session Attribute Name�Ľӿ�,ͨ����Spring MVC Controllerʵ�ִ˽ӿ�,�ṩ������߼�,�ο�PaginationContextPortletHandlerInterceptor
 *
 * 
 */

public interface PageIndexPortletSessionAttrNameGenerator {

	public String generate(RenderRequest request, RenderResponse response) throws Exception;

}
