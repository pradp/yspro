package com.yszoe.sys.service.impl;

import java.util.List;

import com.yszoe.framework.service.impl.BaseServiceAbstractSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.action.MessageAction;
import com.yszoe.sys.action.MessageManagerAction;
import com.yszoe.sys.entity.TSysMessage;
import com.yszoe.sys.util.BusinessLogUtil;

/**
 * 消息管理
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class MessageManagerServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		MessageManagerAction action = (MessageManagerAction) myaction;
		TSysMessage tSysMessage = action.getTsysMessage();
		String hqlcolumn = "select new TSysMessage(a.wid ,(select b.zdmc from  TSysCode b where b.zdbm=a.xxly and b.zdlb='xxly') as xxly,"
				+ " a.xxjsr,(select b.userName from  TSysUser b where b.userLoginId=a.xxfsr ) as  xxfsr,xxfssj,xxydsj,(select b.zdmc from  TSysCode b where b.zdbm=a.xxzt and b.zdlb='xxzt') as xxzt,xxnr,xxbt  )  ";

		String hql = " from TSysMessage  a where 1=1  ";
		if (tSysMessage != null) {
			hql += "  and   a.xxbt  like '%" + tSysMessage.getXxbt() + "%'";
			hql += "  and   a.xxly  like '%" + tSysMessage.getXxly() + "%'";
			hql += "  and   a.xxfsr  like '%" + tSysMessage.getXxfsr() + "%'";
		}

		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + "  order by a.xxzt,a.wid desc ";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	public void load(Object myaction) throws Exception {

	}

	public void saveOrUpdate(Object myaction) throws Exception {

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#remove(java.lang.Object)
	 */
	public boolean remove(Object myaction) throws Exception {
		MessageAction action = (MessageAction) myaction;
		String ids = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TSysMessage", "wid", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), SysConstants.CZDX_T_SYS_MESSAGE,
					SysConstants.LOG_ACTION_DEL);
		}
		return true;
	}

}
