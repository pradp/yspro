package com.yszoe.sys.action;

import com.yszoe.framework.identity.entity.LoginUserVO;

@SuppressWarnings("serial")
public class UserOnlineAction extends BaseActionAbstractSupport {

	private LoginUserVO loginUserVO;

	public LoginUserVO getLoginUserVO() {
		return loginUserVO;
	}

	public void setLoginUserVO(LoginUserVO loginUserVO) {
		this.loginUserVO = loginUserVO;
	}

}
