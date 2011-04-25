package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.SportSjhdMxHzAction;
import com.imchooser.infoms.entity.biz.TSportCjYdy;

/**
 * 
 * @author LiuHaiDong 2010-6-1
 */
public class SportSjhdMxHzServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportSjhdMxHzAction action = (SportSjhdMxHzAction) myaction;
		String departid = null;
		String dbd = action.getParameter("dbd");
		if(StringUtils.isNotBlank(dbd)){
			String sql_departid = "select t.departid from t_sys_depart t  where t.departname=? " ;
			departid = (String)DBUtil.queryFieldValue(sql_departid, dbd);
		}else{
			departid = Constants.AREAID_ZBF;
			String sql_departid = "select t.departname from t_sys_depart t  where t.departid=? " ;
			dbd = (String)DBUtil.queryFieldValue(sql_departid, departid);
			
		}
		// 带入成绩
		String sql1 = "select (select a.departname from t_sys_depart a where a.departid=t.yddbm),t.zjdrjps,t.zjdryps,t.zjdrtps,nvl((t.zjdrjps+t.zjdryps+t.zjdrtps),0) as zjp,t.zjdrzf from t_sport_drcjb t where t.yddbm=? ";
		// 全项成绩
		String sql2 = " select nvl(sum((a.jps+nvl(a.jjjps,0))),0) as jps,"
				+ "nvl(sum((a.yps+nvl(a.jjyps,0))),0) as yps,"
				+ "nvl(sum((a.tps+nvl(a.jjtps,0))),0) as tps,"
				+ "( nvl(sum((a.jps+nvl(a.jjjps,0))),0)"
				+ "+nvl(sum((a.yps+nvl(a.jjyps,0))),0)"
				+ "+nvl(sum((a.tps+nvl(a.jjtps,0))),0)) as zjp,"
				+ " nvl(sum((a.df+nvl(a.jjf,0))),0) as df "
				+ " from T_Sport_Cj_Td_Mx a where a.departid=? and a.dflx!='5' ";
		// 汇总表中加减分,牌
		String sql3 = " select (select t.departname from t_sys_depart t where b.departid=t.departid),"
				+ "b.jjjps,b.jjyps,b.jjtps,(b.jjjps+b.jjyps+b.jjtps) as jps,b.jjf  from t_sport_cj_td_sx_jjf b where b.departid=? ";
		//汇总表实际值
		String sql4 = "select t.jps+(select b.jjjps  from t_sport_cj_td_sx_jjf b where t.departid=b.departid )," +
				"t.yps+(select b.jjyps  from t_sport_cj_td_sx_jjf b where t.departid=b.departid )," +
				"t.tps+(select b.jjtps  from t_sport_cj_td_sx_jjf b where t.departid=b.departid )," +
				"t.hjjps+(select b.jjjps  from t_sport_cj_td_sx_jjf b where t.departid=b.departid )+(select b.jjyps  from t_sport_cj_td_sx_jjf b where t.departid=b.departid )+(select b.jjtps  from t_sport_cj_td_sx_jjf b where t.departid=b.departid )," +
				"t.df+(select b.jjf  from t_sport_cj_td_sx_jjf b where t.departid=b.departid )" +
				" from t_Sport_Cj_Td_Hz t where t.departid=? and t.hzlx='1'";
		//21项计算中,查看有多少项项目
		//---open
		String sql6 = null;
		Object[] listHz21 = null;
		//String count = "select count(*) as a from t_sport_cj_jrpmxm t where t.departid=? and t.hzlx=? ";
		//long count1 = DBUtil.count(count, departid, "1");//金牌汇总方式总项目数
		//long count2 = DBUtil.count(count, departid, "2");//得牌汇总方式总项目数
		//long count3 = DBUtil.count(count, departid, "3");//得分汇总方式总项目数
		String count12 = "select count(*) as a from t_sport_cj_jrpmxm t where t.departid=? and t.hzlx=? and t.xmlx=? ";
		long count4 = DBUtil.count(count12, departid, "1", "3");
		//long count5 = DBUtil.count(count12, departid, "2", "3");
		//long count6 = DBUtil.count(count12, departid, "3", "3");
		//long count7 = 0;
		//long count8 = 0;
		//long count9 = 0;
		if(count4==4){
			//count7=1;
			sql6 = "select y.jps+(select x.jp1 from v_drcj x where x.departid=?),y.yps,y.tps,y.hjjps+(select x.jp1 from v_drcj x where x.departid=?)," +
				"y.df+(select x.zf1 from v_drcj x where x.departid=?) from (select sum(t.jps) as jps,sum(t.yps) as yps,sum(t.tps) as tps," +
				" sum(t.hjjps) as hjjps,sum(t.df) as df from t_sport_cj_jrpmxm t where t.departid=? and t.hzlx='1' ) y ";
		}else if(count4==3){
			//count7=2;
			sql6 = "select y.jps+(select x.jp2 from v_drcj x where x.departid=?),y.yps,y.tps,y.hjjps+(select x.jp2 from v_drcj x where x.departid=?)," +
				"y.df+(select x.zf2 from v_drcj x where x.departid=?) from (select sum(t.jps) as jps,sum(t.yps) as yps,sum(t.tps) as tps," +
				" sum(t.hjjps) as hjjps,sum(t.df) as df from t_sport_cj_jrpmxm t where t.departid=? and t.hzlx='1' ) y ";	
		}else if(count4==2){
			//count7=3;
			sql6 ="select y.jps+(select x.jp3 from v_drcj x where x.departid=?),y.yps,y.tps,y.hjjps+(select x.jp3 from v_drcj x where x.departid=?)," +
				"y.df+(select x.zf3 from v_drcj x where x.departid=?) from (select sum(t.jps) as jps,sum(t.yps) as yps,sum(t.tps) as tps," +
				" sum(t.hjjps) as hjjps,sum(t.df) as df from t_sport_cj_jrpmxm t where t.departid=? and t.hzlx='1' ) y ";
		}else if(count4==1){
			//count7=3;
			sql6 = "select y.jps+(select x.jp3 from v_drcj x where x.departid=?),y.yps,y.tps,y.hjjps+(select x.jp3 from v_drcj x where x.departid=?)," +
				"y.df+(select x.zf3 from v_drcj x where x.departid=?) from (select sum(t.jps) as jps,sum(t.yps) as yps,sum(t.tps) as tps," +
				" sum(t.hjjps) as hjjps,sum(t.df) as df from t_sport_cj_jrpmxm t where t.departid=? and t.hzlx='1' ) y ";
		}else if(count4==0){
			//count7=3;
			sql6 = "select y.jps+(select x.jp3 from v_drcj x where x.departid=?),y.yps,y.tps,y.hjjps+(select x.jp3 from v_drcj x where x.departid=?)," +
				"y.df+(select x.zf3 from v_drcj x where x.departid=?) from (select sum(t.jps) as jps,sum(t.yps) as yps,sum(t.tps) as tps," +
				" sum(t.hjjps) as hjjps,sum(t.df) as df from t_sport_cj_jrpmxm t where t.departid=? and t.hzlx='1' ) y ";
		}
		listHz21 = DBUtil.queryRowColumns(sql6, departid, departid, departid, departid);
//		if(count5==4){
//			count8=1;
//		}else if(count5==3){
//			count8=2;
//		}else if(count5==2){
//			count8=3;
//		}else if(count5==1){
//			count8=3;
//		}else if(count5==0){
//			count8=3;
//		}
//		if(count6==4){
//			count9=1;
//		}else if(count6==3){
//			count9=2;
//		}else if(count6==2){
//			count9=3;
//		}else if(count6==1){
//			count9=3;
//		}else if(count6==0){
//			count9=3;
//		}
		
		//---end
		///String sql5 = "select count(a.a1) from (select count(*) a1 from t_sport_cj_td_mx v where v.dflx!='5' and v.departid=? group by v.dxmmc) a";
		///long c = DBUtil.count(sql5, departid);
//		if(c<=18){
//			sql6 = "select y.jps1+(select x.jp3 from v_drcj x where x.departid=?),y.yps1,y.tps1,y.hjjp1+(select x.jp3 from v_drcj x where x.departid=?),y.df1+(select x.zf3 from v_drcj x " +
//					" where x.departid=?) from " +
//					" (select sum(t.jps) as jps1,sum(t.yps) as yps1,sum(t.tps) as tps1,sum(t.hjjp) as hjjp1,sum(t.df) as df1 from " +
//					" (select sum(nvl(t.jps,0)) as jps,sum(nvl(t.yps,0)) as yps,sum(nvl(t.tps,0)) as tps,sum(nvl(t.jps,0)+nvl(t.yps,0)+nvl(t.tps,0)) as hjjp,sum(nvl(t.df,0)) as df " +
//					" from t_sport_cj_td_mx t where t.dflx!='5' and  t.departid=?  group by t.dxmmc order by jps desc) t " +
//					" where rownum<19) y";
//			listHz21 = DBUtil.queryRowColumns(sql6, departid, departid, departid, departid);
//		}else if(c<20){
//			sql6 = "select y.jps1+(select x.jp2 from v_drcj x where x.departid=?),y.yps1,y.tps1,y.hjjp1+(select x.jp2 from v_drcj x where x.departid=?),y.df1+(select x.zf2 from v_drcj x " +
//					" where x.departid=?) from " +
//					" (select sum(t.jps) as jps1,sum(t.yps) as yps1,sum(t.tps) as tps1,sum(t.hjjp) as hjjp1,sum(t.df) as df1 from " +
//					" (select sum(nvl(t.jps,0)) as jps,sum(nvl(t.yps,0)) as yps,sum(nvl(t.tps,0)) as tps,sum(nvl(t.jps,0)+nvl(t.yps,0)+nvl(t.tps,0)) as hjjp,sum(nvl(t.df,0)) as df " +
//					" from t_sport_cj_td_mx t where t.dflx!='5' and  t.departid=?  group by t.dxmmc order by jps desc) t " +
//					" where rownum<20) y";
//			listHz21 = DBUtil.queryRowColumns(sql6, departid, departid, departid, departid);
//		}else if(c<21){
//			sql6 = "select y.jps1+(select x.jp1 from v_drcj x where x.departid=?),y.yps1,y.tps1,y.hjjp1+(select x.jp1 from v_drcj x where x.departid=?),y.df1+(select x.zf1 from v_drcj x " +
//					" where x.departid=?) from " +
//					" (select sum(t.jps) as jps1,sum(t.yps) as yps1,sum(t.tps) as tps1,sum(t.hjjp) as hjjp1,sum(t.df) as df1 from " +
//					" (select sum(nvl(t.jps,0)) as jps,sum(nvl(t.yps,0)) as yps,sum(nvl(t.tps,0)) as tps,sum(nvl(t.jps,0)+nvl(t.yps,0)+nvl(t.tps,0)) as hjjp,sum(nvl(t.df,0)) as df " +
//					" from t_sport_cj_td_mx t where t.dflx!='5' and  t.departid=?  group by t.dxmmc order by jps desc) t " +
//					" where rownum<21) y";
//			listHz21 = DBUtil.queryRowColumns(sql6, departid, departid, departid, departid);
//		}else if(c>=21){
//			sql6 = "select y.jps1,y.yps1,y.tps1,y.hjjp1,y.df1 " +
//					"  from " +
//					" (select sum(t.jps) as jps1,sum(t.yps) as yps1,sum(t.tps) as tps1,sum(t.hjjp) as hjjp1,sum(t.df) as df1 from " +
//					" (select sum(nvl(t.jps,0)) as jps,sum(nvl(t.yps,0)) as yps,sum(nvl(t.tps,0)) as tps,sum(nvl(t.jps,0)+nvl(t.yps,0)+nvl(t.tps,0)) as hjjp,sum(nvl(t.df,0)) as df " +
//					" from t_sport_cj_td_mx t where t.dflx!='5' and  t.departid=?  group by t.dxmmc order by jps desc) t " +
//					" where rownum<22) y";
//			listHz21 = DBUtil.queryRowColumns(sql6, departid);
//		}
		
		
		
		Object[] listDrcj = DBUtil.queryRowColumns(sql1, departid);
		Object[] listQxcj = DBUtil.queryRowColumns(sql2, departid);
		Object[] listHzjj = DBUtil.queryRowColumns(sql3, departid);
		Object[] listHzsj = DBUtil.queryRowColumns(sql4, departid);
	    String[] listlj = new String[5];
	    listlj[0]=String.valueOf(Double.parseDouble(listDrcj[1].toString())+Double.parseDouble(listHz21[0].toString())+Double.parseDouble(listHzjj[1].toString()));
	    listlj[1]=String.valueOf(Double.parseDouble(listDrcj[2].toString())+Double.parseDouble(listHz21[1].toString())+Double.parseDouble(listHzjj[2].toString()));
	    listlj[2]=String.valueOf(Double.parseDouble(listDrcj[3].toString())+Double.parseDouble(listHz21[2].toString())+Double.parseDouble(listHzjj[3].toString()));
	    listlj[3]=String.valueOf(Double.parseDouble(listDrcj[4].toString())+Double.parseDouble(listHz21[3].toString())+Double.parseDouble(listHzjj[4].toString()));
	    listlj[4]=String.valueOf(Double.parseDouble(listDrcj[5].toString())+Double.parseDouble(listHz21[4].toString())+Double.parseDouble(listHzjj[5].toString()));
	    action.setParameter("listDrcj", listDrcj);
	    action.setParameter("listQxcj", listQxcj);
		action.setParameter("listHzjj", listHzjj);
		action.setParameter("listHzsj", listHzsj);
		action.setParameter("listHz21", listHz21);
		action.setParameter("listlj", listlj);
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
