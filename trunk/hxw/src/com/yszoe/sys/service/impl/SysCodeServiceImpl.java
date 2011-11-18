package com.yszoe.sys.service.impl;

import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.action.SysCodeAction;
import com.yszoe.sys.entity.TSysCode;
import com.yszoe.sys.service.SysCodeService;
import com.yszoe.sys.util.BusinessLogUtil;

/**
 * 标准维护
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class SysCodeServiceImpl extends AbstractBaseServiceSupport implements SysCodeService {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SysCodeAction action = (SysCodeAction) myaction;
		TSysCode bean = action.getTsysCode();

		List<Object> params = new LinkedList<Object>();

		String hqlColumn = "select new TSysCode(a.wid, a.zdbm, a.zdmc, a.zdcc, a.sjdm, a.sfsy, a.zdlb,a.zs, b.lbmc)";
		String hql = " from TSysCode a,TSysCodesort b where a.zdlb=b.zdlb";
		if (bean != null) {
			if (StringUtils.isNotBlank(bean.getZdbm())) {
				hql += " and a.zdbm = ?";
				params.add(bean.getZdbm());
			}
			if (StringUtils.isNotBlank(bean.getZdmc())) {
				hql += " and a.zdmc like ?";
				params.add("%" + bean.getZdmc() + "%");
			}
			if (StringUtils.isNotBlank(bean.getZdlb())) {
				hql += " and a.zdlb = ?";
				params.add(bean.getZdlb());
			}
		}
		String chql = "select count(*) " + hql;
		pager.setTotalRows(getBaseDao().count(chql, params.toArray()));

		hql = hqlColumn + hql + " order by a.zdlb, length(a.zdbm),a.zdbm";
		List<?> tsysCodes = getBaseDao().findPageByHql(hql, pager, params.toArray());
		return tsysCodes;
	}

	public void openCreate(Object obj) throws Exception {
		SysCodeAction action = (SysCodeAction) obj;
		String zdlb = action.getParameter("zdlb");
		TSysCode bean = action.getTsysCode();
		if (null == bean) {
			bean = new TSysCode();
			bean.setZdlb(zdlb);
		}
		action.setTsysCode(bean);
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

			action.addActionError(SysConstants.MESSAGE_SAVE_FAILURE + "[ 被保存的对象为null ]");
		} else if (bean.getWid() == null || bean.getWid().equals("")) {

			bean.setWid(SeqFactory.getNewSequenceAlone());
			getBaseDao().save(bean);
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_CODE,
					SysConstants.LOG_ACTION_SAVE, action.getRequest().getRemoteAddr());
		} else {
			getBaseDao().merge(bean);
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_CODE,
					SysConstants.LOG_ACTION_UPDATE, action.getRequest().getRemoteAddr());
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
		boolean deleteSuccess = getBaseDao().deleteAll("TSysCode", "wid", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_CODE, SysConstants.LOG_ACTION_DEL,
					action.getRequest().getRemoteAddr());
		}
		return deleteSuccess;
	}
}
