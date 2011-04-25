package com.imchooser.infoms.service.sys.impl;

import java.util.List;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.sys.SysCodeSortAction;
import com.imchooser.infoms.entity.sys.TSysCodeSort;
import com.imchooser.infoms.util.BusinessLogUtil;

/**
 * 系统字典类别维护
 * 
 * @author Linyang datetime 2009-8-1
 */
public class SysCodeSortServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SysCodeSortAction action = (SysCodeSortAction) myaction;
		TSysCodeSort tsysCodeSort = action.getTsysCodeSort();
		String hql = " from TSysCodeSort where 1=1 ";
		if (tsysCodeSort != null) {
			if (tsysCodeSort.getZdlb() != null && !"".equals(tsysCodeSort.getZdlb())) {
				System.out.println(tsysCodeSort.getZdlb());
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
		TSysCodeSort tsysCodeSort = (TSysCodeSort) getBaseDao().findById(TSysCodeSort.class, wid);

		action.setTsysCodeSort(tsysCodeSort);
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		SysCodeSortAction action = (SysCodeSortAction) myaction;
		TSysCodeSort bean = action.getTsysCodeSort();
		String newzdlb = action.getParameter("tsysCodeSort.zdlb");
		if (bean == null) {
			action.addActionError(Constants.MESSAGE_SAVE_FAILURE + "[ 被保存的对象为null ]");
		} else {
			if (newzdlb == null || "".equals(newzdlb)) {
				throw new Exception("请输入字典类别编码！");
			}

			if (action.getWid() == null || "".equals(action.getWid().trim())) {
				TSysCodeSort sort = (TSysCodeSort) getBaseDao().findById(TSysCodeSort.class, newzdlb);
				if (sort != null) {
					throw new Exception("您要保存的类别编码已经被【" + sort.getLbmc() + "】使用！");
				}
				bean.setZdlb(newzdlb);
				getBaseDao().save(bean);
				BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_CODESORT,
						Constants.LOG_ACTION_SAVE);
			} else {
				String oldzdlb = action.getWid();
				if (!newzdlb.equals(bean.getZdlb())) {
					// 类别编码被修改了，要检查新编码是否已经存在于数据中
					TSysCodeSort sort = (TSysCodeSort) getBaseDao().findById(TSysCodeSort.class, newzdlb);
					if (sort != null) {
						throw new Exception("您要保存的类别编码已经被【" + sort.getLbmc() + "】使用！");
					}
				}
				getBaseDao().executeHql("update TSysCode set zdlb=?,lbmc=? where zdlb=?", newzdlb, bean.getLbmc(),
						oldzdlb);
				getBaseDao().executeHql("update TSysCodeSort set zdlb=?,lbmc=? where zdlb=?", newzdlb, bean.getLbmc(),
						oldzdlb);
				BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_CODESORT,
						Constants.LOG_ACTION_UPDATE);
			}
		}

	}

	public boolean remove(Object myaction) throws Exception {
		SysCodeSortAction action = (SysCodeSortAction) myaction;
		String ids = action.getWid();
		getBaseDao().deleteAll("TSysCode", "zdlb", "=", ids);
		boolean deleteSuccess = getBaseDao().deleteAll("TSysCodeSort", "zdlb", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_CODESORT,
					Constants.LOG_ACTION_DEL);
		}
		return deleteSuccess;
	}
}
