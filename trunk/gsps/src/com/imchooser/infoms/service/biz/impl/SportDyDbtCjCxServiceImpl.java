package com.imchooser.infoms.service.biz.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.SportDyDbtCjCxAction;
import com.imchooser.infoms.entity.biz.TSportCjTdMx;
import com.imchooser.infoms.entity.sys.TSysArea;
import com.imchooser.util.DateUtil;

/**
 * 代表团成绩查询(打印)
 * 
 * @author Wangjunjun 2010-7-21
 */
public class SportDyDbtCjCxServiceImpl extends BaseServiceAbstractSupport {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#list(java.lang.Object,
	 * com.imchooser.framework.util.Pager)
	 */
	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportDyDbtCjCxAction action = (SportDyDbtCjCxAction) myaction;
		TSportCjTdMx cjtdmx = action.getCjTdMx();
		Object sfjtxm = null;
		if (cjtdmx == null) {
			cjtdmx = new TSportCjTdMx();
		}
		if (StringUtils.isBlank(cjtdmx.getDepartid())) {
			// 管理员登录
			if ("1".equals(action.getDepart().getDeparttype())) {
				// 第一个代表团 "南京"
				cjtdmx.setDepartid(Constants.AREAID_ZBF);
				cjtdmx.setDbtmc(Constants.AREAID_ZBF_NAME);
			} else {
				cjtdmx.setDepartid(action.getDepartID());
			}
		}else {
			String hql = " from TSysArea t where t.areaid=? ";
			List<TSysArea> tsa = this.getBaseDao().findByHql(hql,cjtdmx.getDepartid() );
			if(tsa!=null && tsa.size()>0){
				cjtdmx.setDbtmc(tsa.get(0).getAreaname());
			//	action.setCjTdMx(cjtdmx);
			}
		}
	
		// 据今天最近的 团队比赛时间
		if (StringUtils.isBlank(cjtdmx.getCreatetime1())) {
			cjtdmx.setCreatetime1("all");
		}
		action.setCjTdMx(cjtdmx);
		String sql = "";
		String sql2 ="";
		// 通过大项目 改变要查询的内容
		if (cjtdmx != null && StringUtils.isNotBlank(cjtdmx.getDxmmc())) {
			
			//非集体项目
				sql = "select  t.scbm scbm, t.dflx dflx, b.sfjtxm, t.xxmmc, c.ydyxm,nvl(c.mc,0) mc, c.ydybm, t.dfly, "+
    "(select wmsys.wm_concat(m.xm) from T_Sport_Ydyxx m where t.dfly like '%'||m.wid||'%') as xms, "+ 
     "nvl(c.cj,0), nvl(d.jps+d.jjjps,0), nvl(d.yps+d.jjyps,0), nvl(d.tps+d.jjtps,0), nvl(d.df,0)," +
     "case t.dflx "+
                   " when '2' then '新注册地：'||(select distinct to_char(replace (f.departname,'市')) from t_sport_cj_zs_mx r,t_sport_ydyxx e,t_sys_depart f where  r.scbm=t.scbm and e.wid=c.ydybm and r.departid=e.xyjfdq1 and r.departid=f.departid ) "+
                    " when '3' then '输送地：'||(select  distinct to_char(replace (f.departname,'市')) from t_sport_cj_zs_mx r,t_sport_ydyxx e,t_sys_depart f where  r.scbm=t.scbm and e.wid=c.ydybm and r.departid=e.xyjfdq1 and r.departid=f.departid  ) "+
                    " when '4' then '新籍地：'||(select  distinct to_char(replace (f.departname,'市')) from t_sport_cj_zs_mx r,t_sport_ydyxx e,t_sys_depart f where  r.scbm=t.scbm and e.wid=c.ydybm and r.departid=e.xyjfdq1 and r.departid=f.departid  ) "+
                    " end ,to_char(a.bssj,'yyyy-MM-dd') bssj "+
     "from t_sport_cj_td_mx t inner join  t_sport_ssrc a on a.wid=t.scbm  inner join  t_sport_bsxm b on a.xmbm=b.wid "+
     "inner join  t_sport_cj_ydy c on c.scbm=t.scbm and t.dfly like '%'||c.ydybm||'%' "+
     "left join t_sport_cj_zs_mx d on t.scbm=d.scbm and d.dfly=c.ydybm and d.departid=t.departid  left join t_sys_code n on n.zdlb='MX_DFLX' and n.zdbm=t.dflx  where b.sfjtxm=0 ";
		//集体项目
		sql2 =" union  SELECT d.scbm scbm, d.dflx dflx, b.sfjtxm, d.xxmmc, c.ydyxm,"+
                 "NVL (d.mc, 0) mc, c.ydybm,  wmsys.wm_concat (d.dfly), (SELECT wmsys.wm_concat (m.xm)FROM t_sport_ydyxx m WHERE m.wid=d.dfly) AS xms,"+
                 " '0', NVL (sum(d.jps + d.jjjps), 0),  NVL (sum(d.yps + d.jjyps), 0), NVL (sum(d.tps + d.jjtps), 0), NVL (sum(d.df), 0),CASE d.dflx "+
                  "  WHEN '2' "+
                   "    THEN    '新注册地：'|| (SELECT DISTINCT TO_CHAR(REPLACE (f.departname,'市') ) FROM t_sport_cj_zs_mx r,t_sport_ydyxx e,t_sys_depart f WHERE r.scbm = d.scbm AND e.wid =d.dfly AND r.departid = e.xyjfdq1 AND r.departid = f.departid) "+
                   " WHEN '3' "+
                    "   THEN    '输送地：'||(SELECT DISTINCT TO_CHAR(REPLACE (f.departname,'市') ) FROM t_sport_cj_zs_mx r,t_sport_ydyxx e,t_sys_depart f WHERE r.scbm = d.scbm AND e.wid =d.dfly AND r.departid = e.xyjfdq1 AND r.departid = f.departid) "+
                   " WHEN '4' "+
                    "   THEN    '新籍地：'||(SELECT DISTINCT TO_CHAR(REPLACE (f.departname,'市') ) FROM t_sport_cj_zs_mx r,t_sport_ydyxx e,t_sys_depart f WHERE r.scbm = d.scbm AND e.wid =d.dfly AND r.departid = e.xyjfdq1 AND r.departid = f.departid) "+
                 " END  ,to_char(a.bssj,'yyyy-MM-dd') bssj "+
            " FROM  t_sport_cj_zs_mx d  LEFT JOIN t_sport_ssrc a ON a.wid = d.scbm LEFT JOIN t_sport_bsxm b ON a.xmbm = b.wid LEFT JOIN t_sport_cj_ydy c ON c.scbm = a.scbm LEFT JOIN t_sys_code n ON n.zdlb = 'MX_DFLX'  AND n.zdbm = d.dflx  "+
           " WHERE (b.sfjtxm = 1 or b.sfjtxm = 2 )   ";
			
			
		} else {
			sql = " select t.dxmmc dxmmc, nvl(sum(t.jps+t.jjjps),0) as jps, nvl(sum(t.yps+t.jjyps),0) as yps , nvl(sum(t.tps+t.jjtps),0) as tps ,nvl(sum(t.df+t.jjf),0) as zf ,"
					+ "nvl(sum(t.jps+t.jjjps+t.yps+t.jjyps+t.tps+t.jjtps),0) as jpzs,b.pxh "
					+ "from t_sport_cj_td_mx t, t_sport_ssrc a  ,t_sport_bsxm b where  t.scbm=a.wid and a.xmbm=b.wid ";
		}

		if (cjtdmx != null) {
			// all 代表选择全部时间
			if (StringUtils.isNotBlank(cjtdmx.getDepartid()) ) {
				sql += " and t.departid='" + cjtdmx.getDepartid() +"' ";
				sql2 += " and d.departid='" + cjtdmx.getDepartid() +"' ";
			}
			if (StringUtils.isNotBlank(cjtdmx.getDxmmc())) {
				sql += " and t.dxmmc='" + java.net.URLDecoder.decode(cjtdmx.getDxmmc(), "utf-8") + "'";
				sql2 += " and d.dxmmc='" + java.net.URLDecoder.decode(cjtdmx.getDxmmc(), "utf-8") + "'";
				// 打印标题用的大项目名称
				action.setParameter("cxDxmmc", java.net.URLDecoder.decode(cjtdmx.getDxmmc(), "utf-8"));
			}
			// 判断是否是日期的截止
			if (StringUtils.isNotBlank(cjtdmx.getCreatetime1()) && "all".equals(cjtdmx.getCreatetime1())){
				
				String recentDate = getRecentDate(cjtdmx) ;
				sql += " and to_char(a.bssj,'yyyy-MM-dd')<='" + recentDate+ "'";
				sql2 += " and to_char(a.bssj,'yyyy-MM-dd')<='" + recentDate+ "'" ;
				action.setParameter("recentDate", recentDate);
			
			}else if (StringUtils.isNotBlank(cjtdmx.getCreatetime1())) {
				sql += " and to_char(a.bssj,'yyyy-MM-dd')='" + cjtdmx.getCreatetime1() + "'";
				sql2 += " and to_char(a.bssj,'yyyy-MM-dd')='" + cjtdmx.getCreatetime1() + "'";
			}
			if (StringUtils.isNotBlank(cjtdmx.getZb())) {
				sql += " and b.zb='" + cjtdmx.getZb() + "' ";
				sql2 += " and b.zb='" + cjtdmx.getZb() + "' ";
			}
			if (StringUtils.isNotBlank(cjtdmx.getXbz())) {
				sql += " and b.xbz='" + cjtdmx.getXbz() + "' ";
				sql2 += " and b.xbz='" + cjtdmx.getXbz() + "' ";
			}

		}
		if (cjtdmx != null && StringUtils.isBlank(cjtdmx.getDxmmc())) {
			sql += " group by t.dxmmc,b.xmdj,b.pxh  order by b.pxh, b.xmdj ";
			String sql_hz= " select sum(aa.jps),sum(aa.yps),sum(aa.tps),sum(aa.jpzs),sum(aa.zf) from ( "+sql+") aa ";
			List<Object[]> listHz = DBUtil.queryAllList(sql_hz);
			action.setParameter("listHz", listHz);
		}else{
			sql = " select * from ("+sql+ sql2+" group by  d.scbm, d.dflx , b.sfjtxm, d.xxmmc, c.ydyxm,d.mc, c.ydybm, d.dfly, a.bssj)   g  order by g.bssj desc,case when g.mc=0  then 100 else g.mc end";
		}
		
		List<Object[]> list = DBUtil.queryAllList(sql);
		if (cjtdmx != null && StringUtils.isNotBlank(cjtdmx.getDxmmc()) && list!=null && list.size()>0) {
			//项目编码种类
		//	Set<String[]> xmbmKind = new HashSet<String[]>();
			List<String[]> mainList = new ArrayList<String[]>();
			for(Object[] obj : list){
				boolean bool = true;
				for(String[] str : mainList){
					if(str[0].equals(String.valueOf(obj[0]))){
						bool = false;
					}
				}
				if(bool){
					String [] str = new String[4];
					str[0] = String.valueOf(obj[0]);
					str[1] =  String.valueOf(obj[3]);
					str[2] =  String.valueOf(obj[2]);
					str[3] =  String.valueOf(obj[15]);
					mainList.add(str);
				}
			
			}
			action.setParameter("mainList", mainList);
		}
		// 用于显示打印时间
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
		String dateF = sdf.format(date);
		action.setParameter("printDate", dateF);

		return list;
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

	/**
	 * 获取距离今天最近的比赛时间
	 * 
	 * @param action
	 * @return
	 * @throws Exception
	 */
	public String getRecentDate(TSportCjTdMx cjtdmx) throws Exception {
		String sql = " select ss.times from  (select distinct to_char(a.bssj,'yyyy-MM-dd') times from t_sport_cj_td_mx t,t_sport_ssrc a  where t.scbm=a.wid and  t.departid=? ) ss order by ss.times";
		List<Object[]> listapp = DBUtil.queryAllList(sql, cjtdmx.getDepartid());
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
