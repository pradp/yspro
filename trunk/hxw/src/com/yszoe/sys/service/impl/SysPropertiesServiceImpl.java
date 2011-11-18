package com.yszoe.sys.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.action.SysPropertiesAction;
import com.yszoe.sys.entity.TSysPropertity;
import com.yszoe.sys.util.BusinessLogUtil;
import com.yszoe.util.StringUtil;

/**
 * 系统参数维护
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class SysPropertiesServiceImpl extends AbstractBaseServiceSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SysPropertiesAction action = (SysPropertiesAction) myaction;
		String hqlcolumn = "select new TSysPropertity(a.wid,a.csmc, a.cs,a.csfl,a.cslx,a.cssm )";
		String hql = " from TSysPropertity a where 1=1";
		TSysPropertity tsysPropertity = action.getTsysPropertity();
		if (null != tsysPropertity) {
			if (StringUtils.isNotBlank(tsysPropertity.getCsfl())) {
				hql += " and csfl like '%" + tsysPropertity.getCsfl() + "%'";
			}
		}
		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + " order by a.wid desc ";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);

		return list;
	}

	public boolean remove(Object myaction) throws Exception {
		SysPropertiesAction action = (SysPropertiesAction) myaction;
		String ids = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TSysPropertity", "wid", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_PROPERTITY,
					SysConstants.LOG_ACTION_DEL, action.getRequest().getRemoteAddr());
		}
		return deleteSuccess;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		SysPropertiesAction action = (SysPropertiesAction) myaction;
		TSysPropertity object = action.getTsysPropertity();
		if (StringUtil.isBlank(object.getWid())) {
			object.setWid(SeqFactory.getNewSequenceAlone());
			getBaseDao().save(object);
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_PROPERTITY,
					SysConstants.LOG_ACTION_SAVE, action.getRequest().getRemoteAddr());
		} else {
			getBaseDao().update(object);
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_PROPERTITY,
					SysConstants.LOG_ACTION_UPDATE, action.getRequest().getRemoteAddr());
		}
		// PropConfigUtil.loadSysProps();//刷新内存数据

	}

	public void load(Object myaction) throws Exception {
		SysPropertiesAction action = (SysPropertiesAction) myaction;
		String id = action.getParameter("wid");
		TSysPropertity object = (TSysPropertity) getBaseDao().findById(TSysPropertity.class, id);
		action.setTsysPropertity(object);
	}
}
