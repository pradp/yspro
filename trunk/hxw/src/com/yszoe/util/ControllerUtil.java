package com.yszoe.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.yszoe.identity.IdConstants;
import com.yszoe.identity.entity.TSysUser;

/**
 * spring mvc的controller控制器的辅助类
 * @author Yangjianliang
 * datetime 2011-12-31
 */
public class ControllerUtil {

//	private static final Log LOG = LogFactory.getLog(ControllerUtil.class);

	/**
	 * 获取当前登录用户对象
	 * @param request
	 * @return 不存在就返回null
	 */
	public static final TSysUser getLoginUser(HttpServletRequest request){
		HttpSession session = (HttpSession) request.getSession(true);
		TSysUser user = (TSysUser)session.getAttribute(IdConstants.SESSION_USER);
		return user;
	}

	/**
	 * 获取当前登录用户的userid。不是userloginid
	 * @param request
	 * @return 不存在就返回null
	 */
	public static final String getLoginUserid(HttpServletRequest request){

		TSysUser user = getLoginUser(request);
		if(user!=null){
			return user.getUserid();
		}
		return null;
	}
}

