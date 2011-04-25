package com.imchooser.infoms.service.biz.impl;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportSjhdDbtAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.util.StringUtil;

/**
 * 数据核对模块之 核对代表团数据
 * @author LiuHaiDong 2010-5-25
 */
public class SportSjhdDbtServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportSjhdDbtAction action = (SportSjhdDbtAction) myaction;
		TSportBsxm tsportBsxm = action.getTsportBsxm();
		//运动员成绩表中拿一到八名的人成绩
		String sql1 = "select * from (select (select a.bssj from t_sport_ssrc a where a.wid=t.scbm) as bssj,"
				+ "(t.dxmmc||'，'||t.xxmmc), "
				+ "wmsys.wm_concat( t.mc||'_'||t.ydyxm||'_'||t.dbd||'_'||nvl((t.jps+t.jjjps),0)||'_'||nvl((t.yps+t.jjyps),0)||'_'||nvl((t.tps+t.jjtps),0)||'_'||nvl((t.df+t.jjf),0) )"
				+ " from t_sport_cj_ydy t left join t_sport_ssrc k on t.scbm=k.wid left join t_sport_bsxm l  on k.xmbm=l.wid  where t.mc<=8 and t.sfjs='1' and k.fbzt='3' and t.sfjtxm='0'";
		String sql4 = " group by t.scbm,(t.dxmmc||'，'||t.xxmmc) ";
		//中间拼接
		String sql2 = "union";
		//集体项目表中拿一到八名的地区
		String sql3 = " select (select b.bssj from t_sport_ssrc b where b.wid=m.scbm) as bssj,"
				+ "  (m.dxmmc||'，'||m.xxmmc),"
				+ " wmsys.wm_concat(m.mc||'_'||'---'||'_'||m.dbtmc||'_'||nvl((m.jps+m.jjjps),0)||'_'||nvl((m.yps+m.jjyps),0)||'_'||nvl((m.tps+m.jjtps),0)||'_'||nvl((m.df+m.jjf),0))"
				+ " from t_sport_cj_jt m left join t_sport_ssrc k on m.scbm=k.wid left join t_sport_bsxm l on k.xmbm=l.wid  where m.mc<=8 and m.sfjs='1' and k.fbzt='3' ";
		String sql5 =  " group by m.scbm,(m.dxmmc||'，'||m.xxmmc) )  order by bssj desc ";
		String sql7 = "select count(tt.a1) from (select count(*) a1" +
					" from t_sport_cj_ydy t left join t_sport_ssrc k on t.scbm=k.wid left join t_sport_bsxm l  on k.xmbm=l.wid  " +
					" where t.mc<=8 and t.sfjs='1' and t.sfjtxm='0' and k.fbzt='3'";
		String sql11 = " group by t.scbm,(t.dxmmc||'，'||t.xxmmc) " ;
		String sql8 = " union all " ;
		String sql9 = " select count(*) a1 from t_sport_cj_jt m left join t_sport_ssrc k on m.scbm=k.wid left join t_sport_bsxm l on k.xmbm=l.wid  " +
					" where m.mc<=8 and m.sfjs='1' and k.fbzt='3'";
		String sql10 = " group by m.scbm,(m.dxmmc||'，'||m.xxmmc)) tt " ;
		
		if (tsportBsxm != null) {
			if (StringUtil.isNotBlank(tsportBsxm.getDxmmc())) {
				sql1 += " and l.dxmmc='" + URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
				sql3 += " and l.dxmmc='" + URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
				sql7 += " and l.dxmmc='" + URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
				sql9 += " and l.dxmmc='" + URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getXxmmc())) {
				sql1 += " and l.xxmmc ='" + URLDecoder.decode(tsportBsxm.getXxmmc(), "utf-8") + "'";
				sql3 += " and l.xxmmc ='" + URLDecoder.decode(tsportBsxm.getXxmmc(), "utf-8") + "'";
				sql7 += " and l.xxmmc ='" + URLDecoder.decode(tsportBsxm.getXxmmc(), "utf-8") + "'";
				sql9 += " and l.xxmmc ='" + URLDecoder.decode(tsportBsxm.getXxmmc(), "utf-8") + "'";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getZb())) {
				sql1 += " and l.zb='" + tsportBsxm.getZb() + "' ";
				sql3 += " and l.zb='" + tsportBsxm.getZb() + "' ";
				sql7 += " and l.zb='" + tsportBsxm.getZb() + "' ";
				sql9 += " and l.zb='" + tsportBsxm.getZb() + "' ";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getXbz())) {
				sql1 += " and l.xbz='" + tsportBsxm.getXbz() + "' ";
				sql3 += " and l.xbz='" + tsportBsxm.getXbz() + "' ";
				sql7 += " and l.xbz='" + tsportBsxm.getXbz() + "' ";
				sql9 += " and l.xbz='" + tsportBsxm.getXbz() + "' ";
			}
		}
		if (StringUtils.isNotBlank(action.getParameter("bssj"))) {
			sql1 += " and to_char((select a.bssj from t_sport_ssrc a where a.wid=t.scbm),'yyyy-MM-dd')= '" + action.getParameter("bssj")+"'" ;
			sql3 += " and to_char((select b.bssj from t_sport_ssrc b where b.wid=m.scbm),'yyyy-MM-dd')= '" + action.getParameter("bssj")+"'" ;
			sql7 += " and to_char((select a.bssj from t_sport_ssrc a where a.wid=t.scbm),'yyyy-MM-dd')= '" + action.getParameter("bssj")+"'" ;
			sql9 += " and to_char((select b.bssj from t_sport_ssrc b where b.wid=m.scbm),'yyyy-MM-dd')= '" + action.getParameter("bssj")+"'" ;
		}
		action.setParameter("bssj", action.getParameter("bssj"));
		sql1 = sql1+sql4;
		sql3 = sql3+sql5;
		String sqlc = sql7 + sql11 + sql8 + sql9 + sql10;
		long c = DBUtil.count(sqlc);
		pager.setTotalRows(c);
		pager.setEachPageRows(8);
		String sql  =sql1+sql2+sql3;
		//String xxmmc = tsportBsxm.getXxmmc();
		List<Object[]> list = DBUtil.queryPageList(pager, sql);
		List<String[]> list_dbt = new ArrayList<String[]>();
		//把拼接的字符串转化为数组,方便页面展示
		for(int i=0;i<list.size();i++){
			Object[] line = list.get(i);
			String[] _line = line[2].toString().split(",");//4_刘永祥_盐城市_0_0_0_5,8_王露_盐城市_0_0_0_1, ...
			String[] jg_line = new String[9];
			jg_line[0] = line[0]==null?"--":line[0].toString();
			jg_line[1] = line[1]==null?"--":line[1].toString();

			StringBuilder mcs = new StringBuilder();
			StringBuilder ydyxms = new StringBuilder();
			StringBuilder dbts = new StringBuilder();
			StringBuilder jpss = new StringBuilder();
			StringBuilder ypss = new StringBuilder();
			StringBuilder tpss = new StringBuilder();
			StringBuilder dfs = new StringBuilder();
			
			for(int j=0;j<_line.length;j++){
				String[] sigleInfo = _line[j].split("_");
				
				mcs.append( sigleInfo[0] ).append(",");//名次
				ydyxms.append( sigleInfo[1] ).append(",");//运动员姓名
				dbts.append( sigleInfo[2] ).append(",");//代表地
				jpss.append( sigleInfo[3] ).append(",");//金
				ypss.append( sigleInfo[4] ).append(",");//银
				tpss.append( sigleInfo[5] ).append(",");//铜
				dfs.append( sigleInfo[6] ).append(",");//得分
			}
			if(StringUtils.isNotBlank(mcs.toString())){
				jg_line[2] = mcs.deleteCharAt(mcs.length()-1).toString();//名次
				jg_line[3] = ydyxms.deleteCharAt(ydyxms.length()-1).toString();//运动员姓名
				jg_line[4] = dbts.deleteCharAt(dbts.length()-1).toString();//代表地
				jg_line[5] = jpss.deleteCharAt(jpss.length()-1).toString();//金
				jg_line[6] = ypss.deleteCharAt(ypss.length()-1).toString();//银
				jg_line[7] = tpss.deleteCharAt(tpss.length()-1).toString();//铜
				jg_line[8] = dfs.deleteCharAt(dfs.length()-1).toString();//得分
			}
			
			list_dbt.add(jg_line);
		}
		
		return list_dbt;
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
