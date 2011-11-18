package com.yszoe.sys.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.action.SysMessageCtrlAction;
import com.yszoe.sys.entity.TSysMessageCtrl;
import com.yszoe.sys.util.BusinessLogUtil;

/**
 * 登录时提示消息管理
 * 
 * @author Linyang datetime 2011-7-27
 */
public class SysMessageCtrlServiceImpl extends AbstractBaseServiceSupport {

	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		SysMessageCtrlAction action = (SysMessageCtrlAction) myaction;
		TSysMessageCtrl tsysMessageCtrl = action.getTsysMessageCtrl();
		String hqlColumn = "select new TSysMessageCtrl(a.wid,"
				+ "(select zdmc from TSysCode where zdlb='departtype' and zdbm=a.departtype) as departtype,"
				+ "a.name,a.sql,a.menuid,a.description,a.state,a.ordernum,"
				+ "(select menupath from TSysMenu where menuid=a.menuid) as menupath,"
				+ "(select menuname from TSysMenu where menuid=a.menuid) as menuname,"
				+ "(select menuname from TSysMenu where menuid=substr(a.menuid,0,6)) as upmenuname)";
		String hql = " from TSysMessageCtrl a where 1=1";
		if (null != tsysMessageCtrl) {
			if (StringUtils.isNotBlank(tsysMessageCtrl.getDeparttype())) {
				hql += " and a.departtype = '" + tsysMessageCtrl.getDeparttype() + "'";
			}
			if (StringUtils.isNotBlank(tsysMessageCtrl.getMenuname())) {
				hql += " and a.menuid in (select menuid from TSysMenu where menuname like '%"
						+ tsysMessageCtrl.getMenuname() + "%')";
			}
			if (StringUtils.isNotBlank(tsysMessageCtrl.getUpmenuname())) {
				hql += " and substr(a.menuid,0,6) in (select menuid from TSysMenu where menuname like '%"
						+ tsysMessageCtrl.getUpmenuname() + "%') and length(a.menuid)=9";
			}
			if (StringUtils.isNotBlank(tsysMessageCtrl.getState())) {
				hql += " and a.state = '" + tsysMessageCtrl.getState() + "'";
			}
		}
		long c = getBaseDao().count("select count(*) " + hql);
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findByHql(hqlColumn + hql + " order by ordernum desc");
		return list;
	}

	@Override
	public void load(Object myaction) throws Exception {
		SysMessageCtrlAction action = (SysMessageCtrlAction) myaction;
		String ids = action.getWid();
		TSysMessageCtrl tsysMessageCtrl = getBaseDao().findById(TSysMessageCtrl.class, ids);
		tsysMessageCtrl.setMenuname((String) getBaseDao().findFieldValue(
				"select menuname from TSysMenu where menuid = ?", tsysMessageCtrl.getMenuid()));
		action.setTsysMessageCtrl(tsysMessageCtrl);
	}

	@Override
	public boolean remove(Object myaction) throws Exception {
		SysMessageCtrlAction action = (SysMessageCtrlAction) myaction;
		String ids = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TSysMessageCtrl", "wid", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_MESSAGE_CTRL,
					SysConstants.LOG_ACTION_DEL, action.getRequest().getRemoteAddr());
		}
		return deleteSuccess;
	}

	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
		SysMessageCtrlAction action = (SysMessageCtrlAction) myaction;
		TSysMessageCtrl tsysMessageCtrl = action.getTsysMessageCtrl();
		if (StringUtils.isBlank(tsysMessageCtrl.getWid())) {
			tsysMessageCtrl.setWid(SeqFactory.getNewSequenceAlone());

			try {
				DBUtil.count(tsysMessageCtrl.getSql(), action.getDepartid() + "%");
			} catch (SQLException e) {
				throw new Exception("不是有效的sql语句,请参照示例！");
			}
			getBaseDao().save(tsysMessageCtrl);
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_MESSAGE_CTRL,
					SysConstants.LOG_ACTION_SAVE, action.getRequest().getRemoteAddr());
		} else {
			try {
				DBUtil.count(tsysMessageCtrl.getSql(), action.getDepartid() + "%");
			} catch (Exception e) {
				throw new Exception("不是有效的sql语句,请参照示例！");
			}
			getBaseDao().updateNotNull(tsysMessageCtrl);
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_MESSAGE_CTRL,
					SysConstants.LOG_ACTION_UPDATE, action.getRequest().getRemoteAddr());
		}
	}

}
