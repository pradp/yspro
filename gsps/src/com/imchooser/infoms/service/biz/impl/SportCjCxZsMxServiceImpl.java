package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportCjCxZsMxAction;
import com.imchooser.infoms.entity.biz.TSportCjYdy;

/**
 * 数据核对协议地(协议地成绩分布)
 * @author LiBing
 * DateTime 2010-5-27
 */
public class SportCjCxZsMxServiceImpl extends BaseServiceAbstractSupport{


	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportCjCxZsMxAction action =(SportCjCxZsMxAction) myaction;
		TSportCjYdy tsportCjYdy =action.getTsportCjYdy();
		// 金银牌约束（数据核对传入的参数）
		String lx = action.getParameter("lx");
		action.setParameter("lx", lx);
		String sqlcolumn =" select to_char(e.bssj, 'yyyy-MM-dd')  AS bssj, (t.dxmmc || '，' || t.xxmmc)xxmmc , x.xm xm, (select t.departname from t_sys_depart t where t.departid=substr(x.yddbm,0,6)) dbd, " +
				" (t.jps+t.jjjps) jps,(t.yps+t.jjyps) yps,(t.tps+t.jjtps) tps,(t.df+t.jjf) df, " +
				" replace(wmsys.wm_concat( (select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq3)" +
				" ||'_'|| (select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq7)" +
				" ||'_'|| (select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq2)" +
				" ||'_'||(select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq4)),',','_')as ydyxxb," +
				" replace(wmsys.wm_concat( (select e.zdmc from t_sys_code e where e.zdlb='MX_DFLX' and e.zdbm=b.dflx)||'_'|| b.dbtmc " +
				" ||'_'||(b.jps+b.jjjps+1)||'_'||(b.yps+b.jjyps+1)||'_'||(b.tps+b.jjtps+1)||'_'||(b.df+b.jjf+1)),',','_') as zsb, b.mc mc, case when length(b.departid)>6 then"+
                   " ((SELECT to_char(c.departname) FROM t_sys_depart c  WHERE c.departid = b.departid)||'_'||sum(b.jps+b.jjjps+1)||'_'||sum(b.yps+b.jjyps+1)||'_'||sum(b.tps+b.jjtps+1)||'_'||sum(b.df+b.jjf+1)) else 'none' end sxzs ";
		String sql = "  from t_sport_cj_zs_mx b left join t_sport_ssrc e on b.scbm=e.wid left join t_sport_bsxm f on f.wid=e.xmbm left join t_sport_cj_ydy t on t.ydybm=b.dfly and b.scbm=t.scbm left join t_sport_ydyxx x on t.ydybm=x.wid where b.dflx!=1 ";
		
		//集体项目
		String jtxm = "select  nvl(sum(t.jps+t.jjjps),0) jps, nvl(sum(t.yps+t.jjyps),0) yps,nvl(sum(t.tps+t.jjtps),0) tps,nvl(sum(t.df+t.jjf),0)df "+
		"from t_sport_cj_jt t left join  t_sport_ssrc a on t.scbm=a.wid "+
		"left join  t_sport_bsxm c on  c.wid=a.xmbm where a.fbzt=3 and a.scbm='2' and t.shzt=1 ";
		
		//非集体项目
		String fjtxm = "select  nvl(sum(t.jps+t.jjjps),0) jps, nvl(sum(t.yps+t.jjyps),0) yps,nvl(sum(t.tps+t.jjtps),0) tps,nvl(sum(t.df+t.jjf),0)df "+
		" from t_sport_cj_ydy t left join t_sport_ssrc a on t.scbm=a.wid left join t_sport_bsxm c on c.wid=a.xmbm where a.fbzt=3 and t.sfjtxm=0 and a.scbm='2' and t.shzt=1 ";
		
		//折算的 金银铜
		String zs=" select  nvl(sum(t.jps+t.jjjps),0) jps, nvl(sum(t.yps+t.jjyps),0) yps,nvl(sum(t.tps+t.jjtps),0) tps,nvl(sum(t.df+t.jjf),0)df from t_sport_cj_td_mx t left join t_sport_ssrc a on a.wid=t.scbm  left join  t_sport_bsxm c on  c.wid=a.xmbm   where 1=1 ";
		
		if (tsportCjYdy != null) {
			// and  c.dxmmc='篮球' and c.xxmmc='篮球' and c.zb='2' and c.xbz='2'
			if (StringUtils.isNotBlank(tsportCjYdy.getDxmmc())) {
				tsportCjYdy.setDxmmc(java.net.URLEncoder.encode(java.net.URLDecoder.decode(tsportCjYdy.getDxmmc().trim(),"utf-8"),"utf-8"));
				sql += " and b.dxmmc ='" +java.net.URLDecoder.decode(tsportCjYdy.getDxmmc(), "utf-8")  + "' ";
				jtxm += " and c.dxmmc = '" + java.net.URLDecoder.decode(tsportCjYdy.getDxmmc(), "utf-8") + "' ";
				fjtxm += " and c.dxmmc = '" +java.net.URLDecoder.decode(tsportCjYdy.getDxmmc(), "utf-8") + "' ";
				zs += " and c.dxmmc = '" + java.net.URLDecoder.decode(tsportCjYdy.getDxmmc(), "utf-8") + "' ";
				
			}
			if (StringUtils.isNotBlank(tsportCjYdy.getXxmmc())) {
				sql += " and b.xxmmc like '%" + tsportCjYdy.getXxmmc() + "%' ";
				jtxm += " and c.xxmmc like '%" + tsportCjYdy.getXxmmc() + "%' ";
				fjtxm += " and c.xxmmc like '%" + tsportCjYdy.getXxmmc() + "%' ";
				zs += " and c.xxmmc like '%" + tsportCjYdy.getXxmmc() + "%' ";
			}
			if (StringUtils.isNotBlank(tsportCjYdy.getYdyxm())) {
				sql += " and t.ydyxm like '%" + tsportCjYdy.getYdyxm() + "%' ";
				jtxm +=" and exists(select 1 from  t_sport_cj_ydy b where t.scbm=b.scbm and t.departid=b.departid and (b.sfjtxm=1 or b.sfjtxm=2) and b.ydyxm like '%" + tsportCjYdy.getYdyxm() + "%' )";
				fjtxm += "  and t.ydyxm  like '%" + tsportCjYdy.getYdyxm() + "%' ";
				zs +=" and exists(select 1 from  t_sport_cj_ydy b where t.scbm=b.scbm and t.departid=b.departid and b.ydyxm like '%" + tsportCjYdy.getYdyxm() + "%' )";
			}
			if (StringUtils.isNotBlank(tsportCjYdy.getZb())) {
				sql += " and f.zb='" + tsportCjYdy.getZb() + "' ";
				jtxm += " and  c.zb='" + tsportCjYdy.getZb() + "' ";
				fjtxm += " and  c.zb='" + tsportCjYdy.getZb() + "' ";
				zs += " and  c.zb='" + tsportCjYdy.getZb() + "' ";
			}
			if (StringUtils.isNotBlank(tsportCjYdy.getXbz())) {
				sql += " and f.xbz='" + tsportCjYdy.getXbz() + "' ";
				jtxm += " and  c.xbz='" + tsportCjYdy.getXbz() + "' ";
				fjtxm += " and  c.xbz='" + tsportCjYdy.getXbz() + "' ";
				zs += " and  c.xbz='" + tsportCjYdy.getXbz() + "' ";
			}
			if (StringUtils.isNotBlank(tsportCjYdy.getDbd())) {
				sql += " and b.departid like '" + tsportCjYdy.getDbd() + "%' and b.dflx!=1  "; 
				jtxm += " and  t.departid='" + tsportCjYdy.getDbd() + "' ";
				fjtxm += " and  t.departid='" + tsportCjYdy.getDbd() + "' ";
				zs += " and  t.departid='" + tsportCjYdy.getDbd() + "' ";
				String depart = " select t.departname from t_sys_depart t where t.departid=? ";
				Object obj = DBUtil.queryFieldValue(depart, tsportCjYdy.getDbd());
				action.setParameter("departname", obj);
			}
		}
		if(tsportCjYdy==null || StringUtils.isBlank(tsportCjYdy.getDbd()) ){
			String departid = action.getDepart().getDepartid();
			tsportCjYdy = new TSportCjYdy();
			tsportCjYdy.setDbd(departid);
			action.setTsportCjYdy(tsportCjYdy);
			sql += " and b.departid like '" + tsportCjYdy.getDbd() + "%' and b.dflx!=1  "; 
			jtxm += " and  t.departid='" + tsportCjYdy.getDbd() + "' ";
			fjtxm += " and  t.departid='" + tsportCjYdy.getDbd() + "' ";
			zs += " and  t.departid='" + tsportCjYdy.getDbd() + "' ";
			String depart = " select t.departname from t_sys_depart t where t.departid=? ";
			Object obj = DBUtil.queryFieldValue(depart, tsportCjYdy.getDbd());
			action.setParameter("departname", obj);
		}
		
		
		//是否 承训地
		if(StringUtils.isNotBlank(action.getIscxd())){
			if( "1".equals(action.getIscxd())){
				sql += " and b.dflx=3 ";
				jtxm += "   and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx=3 )  ";
				fjtxm += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx=3 ) ";
				zs += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx=3 ) ";
			}else{
				sql += " and b.dflx!=3 ";
				jtxm += "   and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx!=3 )  ";
				fjtxm += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx!=3 ) ";
				zs += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx!=3 ) ";
			}
			
		}
		//是否 原注册地
		if(StringUtils.isNotBlank(action.getIsyzcd())){
			if( "1".equals(action.getIsyzcd())){
				sql += " and b.dflx=2 ";
				jtxm += "   and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx=2 )  ";
				fjtxm += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx=2 ) ";
				zs += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx=2 ) ";
			}else{
				sql += " and b.dflx!=2 ";
				jtxm += "   and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx!=2 )  ";
				fjtxm += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx!=2 ) ";
				zs += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx!=2 ) ";
			}
		
		}
		//是否 原籍
		if(StringUtils.isNotBlank(action.getIsyj())){
			if( "1".equals(action.getIsyj())){
				sql += " and b.dflx=4 ";
				jtxm += "   and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx=4 )  ";
				fjtxm += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx=4 ) ";
				zs += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx=4 ) ";
			}else{
				sql += " and b.dflx!=4 ";
				jtxm += "   and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx!=4 )  ";
				fjtxm += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx!=4 ) ";
				zs += "  and exists(select 1 from t_sport_cj_zs_mx d where d.scbm=t.scbm and d.dflx!=4 ) ";
			}
			
		}
		if (StringUtils.isNotBlank(action.getParameter("bssj"))) {
			sql += " and to_char((select b.bssj from t_sport_ssrc b where b.wid=t.scbm),'yyyy-MM-dd')= '" + action.getParameter("bssj")+"'" ;
			jtxm += " and   to_char(a.bssj,'yyyy-MM-dd')='" +action.getParameter("bssj")+ "' ";
			fjtxm += " and  to_char(a.bssj,'yyyy-MM-dd')='" +action.getParameter("bssj")+ "' ";
			zs += " and  to_char(a.bssj,'yyyy-MM-dd')='" +action.getParameter("bssj")+ "' ";
		}
		
		// 大于0.5 是 总体情况  各半计牌 对应总体而言无增减
		if("1".equals(lx)){
			sql+= " and (b.jps+b.jjjps)>0.5 ";
			jtxm +=" and (t.jps+t.jjjps)>0 ";
			fjtxm += " and (t.jps+t.jjjps)>0 ";
			zs += " and (t.jps+t.jjjps)>0 ";
		}else if("2".equals(lx)){
			sql+= " and (b.yps+b.jjyps)>0.5 ";
			jtxm += " and (t.yps+t.jjyps)>0 ";
			fjtxm += " and (t.yps+t.jjyps)>0 ";
			zs +=  " and (t.yps+t.jjyps)>0 ";
		}else if("3".equals(lx)){
			sql+= " and (b.tps+b.jjtps)>0.5 ";
			jtxm +=  " and (t.tps+t.jjtps)>0 ";
			fjtxm +=  " and (t.tps+t.jjtps)>0 ";
			zs +=  " and (t.tps+t.jjtps)>0 ";
		}else if("4".equals(lx)){
			sql+= " and (b.df+b.jjf)>0.5 ";
			jtxm +=  " and (t.df+t.jjf)>0 ";
			fjtxm += " and (t.df+t.jjf)>0 ";
			zs +=  " and (t.df+t.jjf)>0 ";
		}
		action.setParameter("bssj", action.getParameter("bssj"));
		sql += " group by e.bssj, t.scbm,t.dxmmc,t.xxmmc,  x.xm,x.yddbm, (t.jps + t.jjjps), (t.yps + t.jjyps),  (t.tps + t.jjtps), (t.df + t.jjf) ,b.mc,b.departid order by bssj desc ";
		sql = sqlcolumn+sql;
		sql = " select aa.bssj,aa.xxmmc,aa.xm,aa.dbd,aa.jps,aa.yps,aa.tps,aa.df,aa.ydyxxb,max(aa.zsb),aa.mc,max(aa.sxzs) from ( "+sql+" )aa group by aa.bssj,aa.xxmmc,aa.xm,aa.dbd,aa.jps,aa.yps,aa.tps,aa.df,aa.ydyxxb,aa.mc ";
		 long c = DBUtil.count("select count(*) as c  from (" + sql+")");//分页
         pager.setTotalRows(c);
         pager.setEachPageRows(8);
         List<?> resultData =DBUtil.queryPageList(pager, sql);
         //折算
         List<?>  zsData = DBUtil.queryAllList(zs);
         action.setParameter("zsData", zsData);
         //折算前（ 实际产生数据）
         String sjSql = "select sum(aa.jps+bb.jps) jps, sum(aa.yps+bb.yps) yps,sum(aa.tps+bb.tps)tps,sum(aa.df+bb.df)df  from ("+jtxm+")aa,("+fjtxm+" )bb";
         List<?>  sjData = DBUtil.queryAllList(sjSql);
         action.setParameter("sjData", sjData);
         return resultData;
	}

	
	public void load(Object arg0) throws Exception {
		
	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {
		
	}


}
