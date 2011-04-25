package com.yszoe.sys.service.impl;

import java.util.List;

import com.yszoe.framework.service.impl.BaseServiceAbstractSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.action.PropertityAction;
import com.yszoe.sys.entity.TSysPropertity;
import com.yszoe.sys.util.BusinessLogUtil;

/**
 * 系统参数维护
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class PropertityServiceImpl extends BaseServiceAbstractSupport {


	public List<?> list(Object myaction, Pager pager) throws Exception {

		String hqlcolumn = "select new TSysPropertity(a.wid,a.csmc, a.cs,a.csfl,a.cslx,a.cssm )";
		String hql = " from TSysPropertity a";

		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + " order by a.wid desc ";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);

		return list;
	}

	public boolean remove(Object myaction) throws Exception {
		PropertityAction action = (PropertityAction) myaction;
		String ids = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TSysPropertity", "wid",
				"=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
					SysConstants.CZDX_T_SYS_PROPERTITY, SysConstants.LOG_ACTION_DEL);
		}
		return deleteSuccess;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		PropertityAction action = (PropertityAction) myaction;
		TSysPropertity object = action.getTsysPropertity();
		if (object.getWid() == null || "".equals(action.getWid())) {
			object.setWid(SeqFactory.getNewSequenceAlone());
			getBaseDao().save(object);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
					SysConstants.CZDX_T_SYS_PROPERTITY, SysConstants.LOG_ACTION_SAVE);
		} else {
			getBaseDao().update(object);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
					SysConstants.CZDX_T_SYS_PROPERTITY,
					SysConstants.LOG_ACTION_UPDATE);
		}
		// PropConfigUtil.loadSysProps();//刷新内存数据

	}

	public void load(Object myaction) throws Exception {
		PropertityAction action = (PropertityAction) myaction;
		String id = action.getParameter("wid");
		TSysPropertity object = (TSysPropertity) getBaseDao().findById(
				TSysPropertity.class, id);
		action.setTsysPropertity(object);
	}
}
