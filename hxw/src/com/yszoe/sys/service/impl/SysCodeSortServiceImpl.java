package com.yszoe.sys.service.impl;

import java.util.List;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.action.SysCodeSortAction;
import com.yszoe.sys.entity.TSysCodesort;
import com.yszoe.sys.util.BusinessLogUtil;
import com.yszoe.util.StringUtil;

/**
 * 系统字典类别维护
 * 
 * @author Linyang datetime 2009-8-1
 */
public class SysCodeSortServiceImpl extends AbstractBaseServiceSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SysCodeSortAction action = (SysCodeSortAction) myaction;
		TSysCodesort tsysCodeSort = action.getTsysCodesort();
		String hql = " from TSysCodesort where 1=1 ";
		if (tsysCodeSort != null) {
			if (tsysCodeSort.getZdlb() != null && !"".equals(tsysCodeSort.getZdlb())) {
				hql += " and zdlb ='" + tsysCodeSort.getZdlb() + "'";
			}
		}
		long c = getBaseDao().count(" select count(*) as c " + hql);
		pager.setTotalRows(c);
		hql = hql + " order by zdlb";
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	public void load(Object myaction) throws Exception {
		SysCodeSortAction action = (SysCodeSortAction) myaction;
		String wid = action.getWid();
		TSysCodesort tsysCodeSort = (TSysCodesort) getBaseDao().findById(TSysCodesort.class, wid);

		action.setTsysCodesort(tsysCodeSort);
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		SysCodeSortAction action = (SysCodeSortAction) myaction;
		TSysCodesort bean = action.getTsysCodesort();
		String newzdlb = action.getParameter("tsysCodesort.zdlb");
		if (bean == null) {
			action.addActionError(SysConstants.MESSAGE_SAVE_FAILURE + "[ 被保存的对象为null ]");
		} else {
			if (StringUtil.isBlank(newzdlb)) {
				throw new Exception("请输入字典类别编码！");
			}

			if (StringUtil.isBlank(action.getWid())) {
				TSysCodesort sort = (TSysCodesort) getBaseDao().findById(TSysCodesort.class, newzdlb);
				if (sort != null) {
					throw new Exception("您要保存的类别编码已经被【" + sort.getLbmc() + "】使用！");
				}
				bean.setZdlb(newzdlb);
				getBaseDao().save(bean);
				BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_CODESORT,
						SysConstants.LOG_ACTION_SAVE, action.getRequest().getRemoteAddr());
			} else {
				String oldzdlb = action.getWid();
				if (!newzdlb.equals(bean.getZdlb())) {
					// 类别编码被修改了，要检查新编码是否已经存在于数据中
					TSysCodesort sort = (TSysCodesort) getBaseDao().findById(TSysCodesort.class, newzdlb);
					if (sort != null) {
						throw new Exception("您要保存的类别编码已经被【" + sort.getLbmc() + "】使用！");
					}
				}
				getBaseDao().executeHql("update TSysCode set zdlb=? where zdlb=?", newzdlb, oldzdlb);
				getBaseDao().executeHql("update TSysCodesort set zdlb=?,lbmc=? where zdlb=?", newzdlb, bean.getLbmc(),
						oldzdlb);
				BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_CODESORT,
						SysConstants.LOG_ACTION_UPDATE, action.getRequest().getRemoteAddr());
			}
		}

	}

	public boolean remove(Object myaction) throws Exception {
		SysCodeSortAction action = (SysCodeSortAction) myaction;
		String ids = action.getWid();
		getBaseDao().deleteAll("TSysCode", "zdlb", "=", ids);
		boolean deleteSuccess = getBaseDao().deleteAll("TSysCodesort", "zdlb", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_CODESORT, SysConstants.LOG_ACTION_DEL,
					action.getRequest().getRemoteAddr());
		}
		return deleteSuccess;
	}
}
