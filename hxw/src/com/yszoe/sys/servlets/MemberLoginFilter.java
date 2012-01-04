package com.yszoe.sys.servlets;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.identity.IdConstants;

/**
 * 会员是否登录过滤器
 * @author Yangjianliang
 * datetime 2012-1-4
 */
public class MemberLoginFilter implements Filter {

	private static final Log LOG = LogFactory.getLog(MemberLoginFilter.class);

	/* (non-Javadoc)
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	@Override
	public void init(FilterConfig paramFilterConfig) throws ServletException {

	}

	/* (non-Javadoc)
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	@Override
	public void doFilter(ServletRequest paramServletRequest, ServletResponse paramServletResponse,
			FilterChain paramFilterChain) throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) paramServletRequest;
		HttpServletResponse response = (HttpServletResponse) paramServletResponse;
		HttpSession session = request.getSession();
		if (session == null) {
			response.sendRedirect( request.getContextPath() + "/identity/index.action" );
			return;
		}
		Object loginUser = session.getAttribute(IdConstants.SESSION_USER);

		if (loginUser != null) {
			// 检查用户对URL的访问权限。
			if (LOG.isDebugEnabled()) {
				LOG.debug("Check User Login : already login!");
			}
			paramFilterChain.doFilter(request, response);
		} else {
			// 否则终止后续操作，返回LOGIN
			if (LOG.isDebugEnabled()) {
				LOG.debug("Check User Login : no login, forward login page!");
			}
			response.sendRedirect( request.getContextPath() + "/identity/index.action" );
			return;
		}

	}

	/* (non-Javadoc)
	 * @see javax.servlet.Filter#destroy()
	 */
	@Override
	public void destroy() {

	}

}

