package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportPrintDxmmcAction;
import com.imchooser.infoms.util.PropConfigUtil;

/**
 * 根据大项目打印报表
 * @author LiBing
 * DateTime 2010-10-18
 */
public class SportPrintDxmmcServiceImpl extends BaseServiceAbstractSupport{

	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(SportPrintDxmmcServiceImpl.class);

	public List<?> list(Object myaction, Pager arg1) throws Exception {
		SportPrintDxmmcAction action = (SportPrintDxmmcAction) myaction;
		String reportServer = PropConfigUtil.get("reportServer");
		action.setParameter("reportServer", reportServer);
		String dxmmc =getDxmmc();
		action.setDxmmc(dxmmc);
		action.setParameter("type", action.getParameter("type"));
		return null;
	}

	public void load(Object arg0) throws Exception {
		
	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {
		
	}
	/**
	 * 查询比赛项目中的项目名称
	 * 
	 * @param dxmmc
	 * @return
	 * @throws Exception
	 */
	public String getDxmmc() throws Exception {
		String sql = "select max(a.wid),max(a.dxmmc) from T_Sport_Bsxm a where 1=1 group by a.dxmmc order by max(a.wid) desc ";
		List<Object[]> listapp = DBUtil.queryAllList(sql);
		return String.valueOf(listapp);
	}
}
