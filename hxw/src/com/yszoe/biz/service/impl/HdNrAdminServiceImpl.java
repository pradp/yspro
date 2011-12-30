package com.yszoe.biz.service.impl;

import com.yszoe.biz.action.HdNrAdminAction;
import com.yszoe.biz.entity.THdNr;
import com.yszoe.framework.util.DBUtil;

/**
 * 活动内容 管理员
 * @author Yangjianliang
 * datetime 2011-12-28
 */
public class HdNrAdminServiceImpl extends HdNrServiceImpl {

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	@Override
	public void load(Object myaction) throws Exception {
		HdNrAdminAction action = (HdNrAdminAction)myaction;
		String wid = action.getWid();
		THdNr bean = getBaseDao().findById(THdNr.class, wid);
		String uname = (String)DBUtil.queryFieldValue("select username from t_sys_user where userid=?", bean.getCjr());
		bean.setCjrName(uname);
		action.setThdNr(bean);
	}

}

