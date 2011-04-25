package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportCjcxXscjbAction;

/**
 * 区县成绩榜
 * 
 * @author DaiQinggao
 * @date 2010-4-8
 * 
 */
public class SportCjcxXscjbServiceImpl extends BaseServiceAbstractSupport {

	@SuppressWarnings("unchecked")
	public List list(Object myaction, Pager pager) throws Exception {
		SportCjcxXscjbAction action = (SportCjcxXscjbAction) myaction;
		// 直辖区成绩榜
		String zxqSql = "select (select tsa.areaname from t_sys_area tsa where tsa.areaid=t.departid) g ,"
				+ "sum((t.jps+nvl((select b.jjjps  from t_sport_cj_td_sx_jjf b where t.departid=b.departid ),0))) a,"
				+ "t.departid,t.mc "
				+ " from  t_sport_cj_sx_hz t "
				+ " where length(t.departid)=9 and t.shzt = '1' and t.hzlx='1' and t.sxlx='2'  "
				+	" group by t.departid,t.mc order by t.mc,a desc ";
		// 区县成绩
		String qxSql = "select (select tsa.areaname from t_sys_area tsa where tsa.areaid=t.departid) g ,"
				+ "sum((t.jps+nvl((select b.jjjps  from t_sport_cj_td_sx_jjf b where t.departid=b.departid ),0))) a,"
				+ "t.departid,t.mc "
				+ " from  t_sport_cj_sx_hz t "
				+ " where length(t.departid)=9 and t.shzt = '1' and t.hzlx='1' and t.sxlx='1'  "
				+ "group by t.departid,t.mc order by t.mc,a desc  ";
		List list_zxq = DBUtil.queryAllList(zxqSql);
		List list_qx = DBUtil.queryAllList(qxSql);
		action.setParameter("list_zxq", list_zxq);
		action.setParameter("list_qx", list_qx);
		return null;
	}

	public void load(Object arg0) throws Exception {

	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {

	}

}
