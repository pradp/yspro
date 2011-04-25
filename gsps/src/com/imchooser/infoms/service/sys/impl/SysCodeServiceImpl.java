package com.imchooser.infoms.service.sys.impl;

import java.util.List;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.sys.SysCodeAction;
import com.imchooser.infoms.entity.sys.TSysCode;
import com.imchooser.infoms.service.sys.SysCodeService;
import com.imchooser.infoms.util.BusinessLogUtil;

/**
 * 标准维护
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class SysCodeServiceImpl extends BaseServiceAbstractSupport implements
		SysCodeService {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SysCodeAction action = (SysCodeAction) myaction;
		TSysCode bean = action.getTsysCode();

		String hql = "from TSysCode where 1=1";
		if (bean != null) {
			if (bean.getZdbm() != null && !bean.getZdbm().equals("")) {
				hql += " and zdbm = '" + bean.getZdbm() + "'";
			}
			if (bean.getZdmc() != null && !bean.getZdmc().equals("")) {
				hql += " and zdmc like '%" + bean.getZdmc() + "%'";
			}
			if (bean.getZdlb() != null && !bean.getZdlb().equals("")) {
				hql += " and zdlb = '" + bean.getZdlb() + "'";
			}
		}
		String chql = "select count(*) " + hql;
		pager.setTotalRows(getBaseDao().count(chql));

		hql += " order by zdlb, wid desc";
		List<?> tsysCodes = getBaseDao().findPageByHql(hql, pager);
		return tsysCodes;
	}

	public void load(Object myaction) throws Exception {
		SysCodeAction action = (SysCodeAction) myaction;
		String wid = action.getWid();
		TSysCode bean = (TSysCode) getBaseDao().findById(TSysCode.class, wid);

		action.setTsysCode(bean);
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		SysCodeAction action = (SysCodeAction) myaction;
		TSysCode bean = action.getTsysCode();

		if (bean == null) {

			action.addActionError(Constants.MESSAGE_SAVE_FAILURE
					+ "[ 被保存的对象为null ]");
		} else if (bean.getWid() == null || bean.getWid().equals("")) {

			bean.setWid(SeqFactory.getNewSequenceAlone());
			String lbmc = (String) getBaseDao().findFieldValue(
					"select lbmc from TSysCodeSort where zdlb=?",
					bean.getZdlb());
			bean.setLbmc(lbmc);
			getBaseDao().save(bean);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
					Constants.CZDX_T_SYS_CODE, Constants.LOG_ACTION_SAVE);
		} else {
			String lbmc = (String) getBaseDao().findFieldValue(
					"select lbmc from TSysCodeSort where zdlb=?",
					bean.getZdlb());
			bean.setLbmc(lbmc);
			getBaseDao().merge(bean);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
					Constants.CZDX_T_SYS_CODE, Constants.LOG_ACTION_UPDATE);
		}
		String syxz = action.getParameter("sfxz");// 保存并新增按钮
		if ("1".equals(syxz)) {
			TSysCode object = new TSysCode();
			object.setZdlb(bean.getZdlb());
			action.setTsysCode(object);
			openCreate(myaction);
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#remove(java.lang.Object)
	 */
	public boolean remove(Object myaction) throws Exception {
		SysCodeAction action = (SysCodeAction) myaction;
		String ids = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TSysCode", "wid", "=",
				ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
					Constants.CZDX_T_SYS_CODE, Constants.LOG_ACTION_DEL);
		}
		return deleteSuccess;
	}
}
