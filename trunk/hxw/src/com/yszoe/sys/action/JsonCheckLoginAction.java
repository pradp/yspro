package com.yszoe.sys.action;

import java.sql.SQLException;

import com.yszoe.identity.IdConstants;
import com.yszoe.identity.entity.TSysUser;
import com.yszoe.util.StringUtil;


@SuppressWarnings("serial")
public class JsonCheckLoginAction extends AbstractBaseActionSupport {
	private String userLoginId;
	private String type;

	public String getUserLoginId() {
		return userLoginId;
	}

	public void setUserLoginId(String userLoginId) {
		this.userLoginId = userLoginId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String checkLogin() throws SQLException {
		TSysUser tsysUser = (TSysUser) this.getSession().getAttribute(IdConstants.SESSION_USER);
		if(tsysUser!=null && StringUtil.isNotBlank(tsysUser.getUserloginid())){
			setUserName(tsysUser);
			this.setType("cgyh");
		}else if(tsysUser!=null && StringUtil.isNotBlank(tsysUser.getUserloginid())){
			setUserName(tsysUser);
			this.setType("fcgyh");
		}else{
			this.setType("null");
		}
		return "checkLogin";
	}
	
	/**
	 * 设置用户名在页面上显示-----用户昵称为空是 显示 登录账号
	 * @param user
	 */
	public void setUserName(TSysUser user){
		String useridDis  = user.getUsername();
			if(StringUtil.isBlank(useridDis)){
				useridDis = user.getUserloginid();
			}
			if(StringUtil.isBlank(useridDis)){
				useridDis = "null";
			}
		this.setUserLoginId(useridDis);
	}
}
