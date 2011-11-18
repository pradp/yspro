package com.yszoe.identity.springinterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.yszoe.identity.IdConstants;

/**
 * 项目：用户权限系统
 * 模块：登录安全验证,检查是否已登录
 * 作者：Yangjianliang
 * 日期：2007-8-31
 */
public final class CheckLoginInterceptor4springmvc extends HandlerInterceptorAdapter {

	private static final Log log = LogFactory
			.getLog(CheckLoginInterceptor4springmvc.class);

	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		HttpSession session = request.getSession();
		if (session == null) {
			response.sendRedirect( request.getContextPath() + "/identity/index.action" );
			return false;
		}
		Object loginUser = session.getAttribute(IdConstants.SESSION_USER);

		if (loginUser != null) {
			// 检查用户对URL的访问权限。
			if (log.isDebugEnabled()) {
				log.debug("Check User Login : already login!");
			}
			return true;
		} else {
			// 否则终止后续操作，返回LOGIN
			if (log.isDebugEnabled()) {
				log.debug("Check User Login : no login, forward login page!");
			}
			response.sendRedirect( request.getContextPath() + "/identity/index.action" );
			return false;
		}
	}

}
