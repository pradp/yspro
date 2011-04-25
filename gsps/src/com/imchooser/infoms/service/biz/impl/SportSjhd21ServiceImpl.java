package com.imchooser.infoms.service.biz.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.SportSjhd21Action;

/**
 * 21项数据核对
 * 
 * @author LiuHaiDong 2010-6-9
 */
public class SportSjhd21ServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportSjhd21Action action = (SportSjhd21Action) myaction;
		String departid = null;
		String dbd = action.getParameter("dbd");
		if (StringUtils.isNotBlank(dbd)) {
			String sql_departid = "select t.departid from t_sys_depart t  where t.departname=? ";
			departid = (String) DBUtil.queryFieldValue(sql_departid, dbd);
		} else {
			departid = Constants.AREAID_ZBF;
			String sql_departid = "select t.departname from t_sys_depart t  where t.departid=? ";
			dbd = (String) DBUtil.queryFieldValue(sql_departid, departid);

		}
		String sql_1 = " select  replace( wmsys.wm_concat(max(a.dxmmc)),',','、') as a,'1' as b  from T_Sport_Bsxm a where a.xmdj='1' group by a.dxmmc "
				+ " union "
				+ " select  replace( wmsys.wm_concat(max(a.dxmmc)),',','、') as a,'2' as b  from T_Sport_Bsxm a where a.xmdj='2' group by a.dxmmc "
				+ " union "
				+ " select  replace( wmsys.wm_concat(max(a.dxmmc)),',','、') as a,'3' as b  from T_Sport_Bsxm a where a.xmdj='3' group by a.dxmmc ";
		String sql_2 = "select t.dxmmc,t.xmlx,t.jps,t.yps,t.tps,t.df,t.hjjps,t.hzlx from t_sport_cj_jrpmxm t where t.departid=? ";
		String sql_3 = "select tt.jps,tt.df,tt.bm from ( "
				+ " select t.djxmjps as jps,t.djxmzf as df,'冬季项目' as bm from t_sport_drcjb t where t.yddbm=? "
				+ " union "
				+ "select t.fcfbjps as jps,t.fcfbzf as df,'帆船帆板' as bm from t_sport_drcjb t where t.yddbm=? "
				+ " union "
				+ "select t.xdwdjps as jps,t.xdwdzf as df,'现代五项' as bm from t_sport_drcjb t where t.yddbm=? "
				+ "union "
				+ "select t.phtjps as jps,t.phtzf as df,'皮划艇' as bm from t_sport_drcjb t where t.yddbm=?) tt order by tt.jps desc";
		String sql_4 = "select t.dxmmc,sum(t.jps),sum(t.jps+t.yps+t.tps),sum(t.df) from t_sport_cj_td_mx t  where t.departid=? group by t.dxmmc";
		List<Object[]> xmdj = DBUtil.queryAllList(sql_1);
		List<Object[]> jrpmxm = DBUtil.queryAllList(sql_2, departid);
		List<Object[]> sxdr = DBUtil.queryAllList(sql_3, departid, departid, departid, departid);
		List<Object[]> fjrxm = DBUtil.queryAllList(sql_4, departid);
		List<Object[]> list_dq = new ArrayList<Object[]>();
		for (int i = 0; i < fjrxm.size(); i++) {
			Object[] line = fjrxm.get(i);
			boolean bj = true;
			for(int i1=0;i1<jrpmxm.size();i1++){
				Object[] line1 = jrpmxm.get(i1);
				if (line[0].toString().equals(line1[0].toString()) ){
					bj = false;
					break;
				}
			}
			
			if (bj) {
				Object[] c = new Object[4];
				c[0] = line[0].toString();
				c[1] = line[1].toString();
				c[2] = line[2].toString();
				c[3] = line[3].toString();
				list_dq.add(c);
			}
		}
		String count = "select count(*) as a from t_sport_cj_jrpmxm t where t.departid=? and t.hzlx=? ";
		long count1 = DBUtil.count(count, departid, "1");//金牌汇总方式总项目数
		long count2 = DBUtil.count(count, departid, "2");//得牌汇总方式总项目数
		long count3 = DBUtil.count(count, departid, "3");//得分汇总方式总项目数
		String count12 = "select count(*) as a from t_sport_cj_jrpmxm t where t.departid=? and t.hzlx=? and t.xmlx=? ";
		long count4 = DBUtil.count(count12, departid, "1", "3");
		long count5 = DBUtil.count(count12, departid, "2", "3");
		long count6 = DBUtil.count(count12, departid, "3", "3");
		long count7 = 0;
		long count8 = 0;
		long count9 = 0;
		if(count4==4){
			count7=1;
		}else if(count4==3){
			count7=2;
		}else if(count4==2){
			count7=3;
		}else if(count4==1){
			count7=3;
		}else if(count4==0){
			count7=3;
		}
		if(count5==4){
			count8=1;
		}else if(count5==3){
			count8=2;
		}else if(count5==2){
			count8=3;
		}else if(count5==1){
			count8=3;
		}else if(count5==0){
			count8=3;
		}
		if(count6==4){
			count9=1;
		}else if(count6==3){
			count9=2;
		}else if(count6==2){
			count9=3;
		}else if(count6==1){
			count9=3;
		}else if(count6==0){
			count9=3;
		}
		action.setParameter("count1", count1);
		action.setParameter("count2", count2);
		action.setParameter("count3", count3);
		action.setParameter("count7", count7);
		action.setParameter("count8", count8);
		action.setParameter("count9", count9);
		action.setParameter("xmdj", xmdj);
		action.setParameter("jrpmxm", jrpmxm);
		action.setParameter("sxdr", sxdr);
		action.setParameter("fjrxm", list_dq);

		// 带入成绩
		String sql1 = "select (select a.departname from t_sys_depart a where a.departid=t.yddbm),t.zjdrjps,t.zjdryps,t.zjdrtps,nvl((t.zjdrjps+t.zjdryps+t.zjdrtps),0) as zjp,t.zjdrzf from t_sport_drcjb t where t.yddbm=? ";

		Object[] listDrcj = DBUtil.queryRowColumns(sql1, departid);
		action.setParameter("listDrcj", listDrcj);
		action.setParameter("dbd", dbd);
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#load(java.lang.Object)
	 */
	public void load(Object arg0) throws Exception {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#remove(java.lang.Object)
	 */
	public boolean remove(Object arg0) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.imchooser.framework.service.BaseService#saveOrUpdate(java.lang.Object
	 * )
	 */
	public void saveOrUpdate(Object arg0) throws Exception {
		// TODO Auto-generated method stub

	}
}
