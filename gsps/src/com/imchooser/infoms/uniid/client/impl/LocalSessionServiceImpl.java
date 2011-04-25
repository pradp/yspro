package com.imchooser.infoms.uniid.client.impl;

import javax.servlet.http.HttpSession;

import com.imchooser.framework.identity.entity.LoginUserVO;
import com.imchooser.infoms.uniid.client.LocalSessionService;

/**
 * @see LocalSessionService
 * @author Yangjianliang
 * datetime 2009-12-12
 */
public class LocalSessionServiceImpl implements LocalSessionService {

	/* (non-Javadoc)
	 * @see com.imchooser.infoms.uniid.LocalSessionService#removeThisUserSession(java.lang.String)
	 */
	public int removeThisUserSession(String userLoginID) throws Exception {
		HttpSession session = LoginUserVO.getThisUserSession(userLoginID);
		int result = 0;
		if(session!=null){
			session.invalidate();
			result = 1;
		}
		return result;
	}

}
