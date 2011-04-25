package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportPrintAction;
import com.imchooser.infoms.util.PropConfigUtil;
import com.imchooser.util.DateUtil;

/**
 * 打印报表
 * @author LiBing 
 * DateTime 2010-10-10
 */
public class SportPrintServiceImpl extends BaseServiceAbstractSupport {

	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(SportPrintServiceImpl.class);

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportPrintAction action = (SportPrintAction) myaction;
		String reportServer = PropConfigUtil.get("reportServer");
		action.setParameter("reportServer", reportServer);
		String bssj =getRecentDate();
		action.setBssj(bssj);
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
	 * 获取距离今天最近的比赛时间
	 * 
	 * @param action
	 * @return
	 * @throws Exception
	 */
	public String getRecentDate() throws Exception {
		String sql = " select ss.times from  (select distinct to_char(a.bssj,'yyyyMMdd') times from t_sport_cj_td_mx t,t_sport_ssrc a  where t.scbm=a.wid ) ss order by ss.times";
		List<Object[]> listapp = DBUtil.queryAllList(sql);
		int index = 0;
		if (!listapp.isEmpty()) {
			long min = DateUtil.dateDayInteval(DateUtil.currentDateString(), listapp.get(0)[0].toString());
			for (int i = 0; i < listapp.size(); i++) {
				long c = DateUtil.dateDayInteval(DateUtil.currentDateString(), listapp.get(i)[0].toString());
				if (!(c > Math.abs(min))) {
					index = i;
					min = c;
				}
			}
		}
		return String.valueOf(listapp.get(index)[0]);
	}
}
