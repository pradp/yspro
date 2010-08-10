package com.ht.pagination;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface PageIndexServletSessionAttrNameGenerator {

	public String generate(HttpServletRequest request, HttpServletResponse response) throws Exception;

}
