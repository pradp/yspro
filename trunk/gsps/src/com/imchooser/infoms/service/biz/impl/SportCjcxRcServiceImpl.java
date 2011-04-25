package com.imchooser.infoms.service.biz.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportCjcxRcAction;
import com.imchooser.infoms.entity.biz.TSportCjJt;
import com.imchooser.infoms.entity.biz.TSportCjTdHz;
import com.imchooser.infoms.entity.biz.TSportSsrc;
import com.imchooser.infoms.entity.sys.ApplicationEnum;
import com.imchooser.util.DateUtil;
import com.imchooser.util.StringUtil;

/**
 * 赛程成绩查询
 * 包括各种项目的成绩展示
 * @author Yangjianliang
 * datetime 2010-5-22
 */
public class SportCjcxRcServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportCjcxRcAction action = (SportCjcxRcAction) myaction;
		// 获取查询日程的时间
		String scDateTime = action.getBssj();
		if (StringUtil.isBlank(scDateTime)) {
			scDateTime = getRecentDate(action);
		}else if("all".equals(scDateTime)){
			scDateTime = "";
		}
		String paixu = action.getPaixu();
		if(StringUtil.isBlank(paixu)){
			paixu = "0";
			action.setPaixu("0");
		}
		String xmmc = action.getParameter("dxmmc");
		action.setParameter("dxmmc", xmmc);
		// 用于 界面 点击 秩序单 或成绩 到 二级 页面 滚动时间 的 默认选中 （传值）
		action.setParameter("bssj", scDateTime);
		action.setBssj(scDateTime);
		if (StringUtil.isNotBlank(xmmc)) {
			action.setDxmmc(java.net.URLEncoder.encode(xmmc, "UTF-8"));
		}
		//List<TSportCjTdHz> list_hz = new ArrayList<TSportCjTdHz>();
		String sql = "";
		List<ApplicationEnum> list = new ArrayList<ApplicationEnum>();

		String departid = action.getParameter("departid");
		action.setParameter("departid", departid);
		action.setParameter("mi", action.getParameter("mi"));
		TSportSsrc ssrc = action.getSportSsrc();
	
		if (StringUtil.isNotBlank(xmmc)) {
			// 传递了项目名称过来查询
			String sql_isdzxm = " select max(h.sfdzxm) from t_sport_bsxm h  where h.dxmmc=? ";
			String isdzxm = String.valueOf(DBUtil.queryFieldValue(sql_isdzxm, xmmc));

			if ("1".equals(isdzxm)) {
				// 是对战项目
				sql = "select to_char(a.bssj,'HH24:mi') bssj,( select b.zdmc from t_sys_code b where b.zdlb='SSRC_SCBM' and b.zdbm=a.scbm) scbm,"
						+ "(select v.zdmc from t_sys_code v where v.zdlb='BSXM_ZB' and v.zdbm=e.zb) zb,"
						+ " (select v.zdmc from t_sys_code v where v.zdlb='BSXM_XBZ' and v.zdbm=e.xbz) xbz,"
						+ " e.xxmmc xxmmc, '' jps,"
						+ " case when a.scbm='2' then (select replace(regexp_replace(replace(wmsys.wm_concat(pp.dbtmc||' '||pp.cj ||'@'||pp.dbtmc ),',','：'),'@(.){2,}:(.){2,} ',':'),'@', ' ') v from T_SPORT_CJ_JT pp where pp.shzt='1' and pp.scbm=(select  k.wid from T_Sport_Ssrc k where k.wid=a.wid and k.fbzt='3' ))else (select replace(regexp_replace(replace(wmsys.wm_concat(pp.dbtmc||' '||pp.cj ||'@'||pp.dbtmc ),',','：'),'@(.){2,}：(.){2,} ','：'),'@', ' ') v from T_SPORT_CJ_JT pp where pp.shzt='1' and pp.scbm=(select k.wid from T_Sport_Ssrc k where k.wid=a.wid and k.fbzt='3' )) end,"
						+ " a.bscd bscd, a.fbzt fbzt,"
						+ " a.wid wid,to_char(a.bssj,'yyyy-MM-dd') bssj_y, e.sfdzxm, e.dxmmc dxmmc, '', a.sfxnsc, a.cdzy,(select g.zdmc from  t_sys_code  g where g.zdlb='SSRC_BPFZ' and g.zdbm=a.bpfz),e.sfjtxm,a.xmbm " +
						" ,(select replace(regexp_replace(replace(wmsys.wm_concat(pp.dbtmc||'@' ),',','：'),'@(.){2,}:(.){2,} ',':'),'@', '') v from T_SPORT_CJ_JT pp where  pp.scbm=(select  k.wid from T_Sport_Ssrc k where k.wid=a.wid  ))" +
								" from T_Sport_Ssrc a  inner join t_sport_bsxm e on e.wid=a.xmbm where 1=1 ";
				action.setParameter("jtxmbs", "1");
			} else {
				//非对战项目
				sql = "select to_char(a.bssj,'HH24:mi') bssj,"+
				"(select b.zdmc from t_sys_code b where b.zdlb='SSRC_SCBM' and b.zdbm=a.scbm) scbm,"+
				"(select v.zdmc from t_sys_code v where v.zdlb='BSXM_ZB' and v.zdbm=e.zb) zb,"+
				"(select v.zdmc from t_sys_code v where v.zdlb='BSXM_XBZ' and v.zdbm=e.xbz) xbz, e.xxmmc xxmmc,"+
				"'' jps, (select max( k.cj) from T_SPORT_CJ_YDY k where k.scbm=(select  h.wid from T_Sport_Ssrc h where h.wid=a.wid and h.fbzt='3' ) and k.shzt='1'), a.bscd, a.fbzt fbzt,"+
				" a.wid, to_char(a.bssj,'yyyy-MM-dd'), e.sfdzxm, e.dxmmc dxmmc, '', a.sfxnsc, a.cdzy,(select g.zdmc from  t_sys_code  g where g.zdlb='SSRC_BPFZ' and g.zdbm=a.bpfz),e.sfjtxm,a.xmbm,'' "+
				" from T_Sport_Ssrc a inner join t_sport_bsxm e on e.wid=a.xmbm where 1=1 "; 
			}
			// 决定显示的界面
			action.setParameter("type", "1");
		} else {
			//不点击具体的某个项目，通过传递日期查询
			sql = "select to_char(a.bssj,'HH24:mi') bssj,"
					+ "(select b.zdmc from t_sys_code b where b.zdlb='SSRC_SCBM' and b.zdbm=a.scbm) scbm,"
					+ "(select v.zdmc from t_sys_code v where v.zdlb='BSXM_ZB' and v.zdbm=e.zb) zb,"
					+ "(select v.zdmc from t_sys_code v where v.zdlb='BSXM_XBZ' and v.zdbm=e.xbz) xbz,"
					+ "e.xxmmc xxmmc, '' jps, "
					+ "case when a.xmbm in (select g.wid from T_Sport_Bsxm g where g.sfjtxm='1' and g.sfdzxm='1') "
					+ "then(case when a.scbm='2' then (select replace(regexp_replace(replace(wmsys.wm_concat(pp.dbtmc||' '||pp.cj ||'@'||pp.dbtmc ),',','：'),'@(.){2,}：(.){2,} ','：'),'@', ' ') v from T_SPORT_CJ_JT pp where pp.shzt='1' and pp.scbm=(select  k.wid from T_Sport_Ssrc k where k.wid=a.wid and k.fbzt='3' )) "
					+ " else (select replace(regexp_replace(replace(wmsys.wm_concat(pp.dbtmc||' '||pp.cj ||'@'||pp.dbtmc ),',','：'),'@(.){2,}：(.){2,} ','：'),'@', ' ') v from T_SPORT_CJ_JT pp where pp.shzt='1' and pp.scbm=(select  k.wid from T_Sport_Ssrc k where k.wid=a.wid and k.fbzt='3')) end ) "
					+ " else (select to_char(max(p.cj)) from t_sport_cj_ydy p where p.scbm=a.wid) end ," 
					+ " a.bscd  bscd, a.fbzt fbzt,"
					+ " a.wid wid, to_char(a.bssj,'yyyy-MM-dd') bssj_y, e.sfdzxm, e.dxmmc dxmmc, '', a.sfxnsc, a.cdzy,(select g.zdmc from  t_sys_code  g where g.zdlb='SSRC_BPFZ' and g.zdbm=a.bpfz),e.sfjtxm,a.xmbm " +
					" ,(select replace(regexp_replace(replace(wmsys.wm_concat(pp.dbtmc||'@' ),',','：'),'@(.){2,}:(.){2,} ',':'),'@', '') v from T_SPORT_CJ_JT pp where  pp.scbm=(select  k.wid from T_Sport_Ssrc k where k.wid=a.wid  ))" +
							"from T_Sport_Ssrc a inner join t_sport_bsxm e on e.wid=a.xmbm where 1=1 ";
		}
		
		String sql_dxmmc_date = " select e.dxmmc from t_sport_ssrc t left join t_sport_bsxm e on e.wid=t.xmbm where 1=1 ";
		
		if (StringUtil.isNotBlank(scDateTime)) {
			sql += "and to_char(a.bssj,'yyyy-MM-dd')='" + scDateTime + "' ";
			sql_dxmmc_date += " and to_char(t.bssj,'yyyy-MM-dd')='" + scDateTime + "' ";
		}
		if (StringUtil.isNotBlank(xmmc)) {
			sql += "and e.dxmmc='" + xmmc + "' ";
		}
		if(ssrc!=null){
			if (StringUtil.isNotBlank(ssrc.getXxmmc())) {
				sql += "and e.xxmmc='" + ssrc.getXxmmc() + "' ";
			}
			if (StringUtil.isNotBlank(ssrc.getZb())) {
				sql += "and e.zb='" + ssrc.getZb() + "' ";
			}
			if (StringUtil.isNotBlank(ssrc.getXbz())) {
				sql += "and e.xbz='" + ssrc.getXbz() + "' ";
			}
			if (StringUtil.isNotBlank(ssrc.getScbm())) {
				sql += "and a.scbm='" + ssrc.getScbm() + "' ";
			}
			if (StringUtil.isNotBlank(ssrc.getBpfz())) {
				sql += "and a.bpfz='" + ssrc.getBpfz() + "' ";
			}
		}
		if (StringUtil.isNotBlank(action.getSfjsbs())) {
			//已结束比赛
			if("1".equals(action.getSfjsbs())){
				sql += " and a.fbzt='3' ";
			}else{
				sql += " and a.fbzt!='3'  ";
			}
		}
		sql += " order by a.bssj , case when a.scbm=2 then '0' else a.scbm end ,a.bpfz ";
		sql_dxmmc_date += " group by e.dxmmc";
		// 辅助 页面遍历 临时的
		List<Object[]> list_obj = DBUtil.queryAllList(sql);
		
		// 页面合并小项目用 
		List<String[]> list_xmbm = new ArrayList<String[]>();
		
		if (list_obj != null) {
			boolean bool = true;
			boolean bool2 = true;
			for (Object[] obj : list_obj) {
				// 页面 按时间遍历 当日数据 主遍历（辅助）
				int length = obj.length;
				bool = true;
				bool2 = true;
				for(ApplicationEnum app : list){
					if(app.getId().equals(String.valueOf(obj[10]))){
						bool = false;
					}
				}
				for(String[] str : list_xmbm){
					if("1".equals(paixu)){
						if(str[6]!=null && obj[length-2]!=null ){
							if(str[6].equals(String.valueOf(obj[length-2]))){
								bool2 = false;
							}
							
						}
					}else if("0".equals(paixu)){
						if(str[6]!=null && obj[length-2]!=null && str[5]!=null && obj[10]!=null ){
							if(str[6].equals(String.valueOf(obj[length-2])) && str[5].equals(String.valueOf(obj[10]))){
								bool2 = false;
							}
							
						}
					}
					
				}
				if(bool2){
					String [] strs = new String[7];
					if(obj[0]==null){
						strs[0]= "";
					}else{
						strs[0]= obj[0].toString();
					}
					if(obj[12]==null){
						strs[1]= "";
					}else{
						strs[1]= obj[12].toString();
					}
					if(obj[2]==null){
						strs[2]= "";
					}else{
						strs[2]= obj[2].toString();
					}
					if(obj[3]==null){
						strs[3]= "";
					}else{
						strs[3]= obj[3].toString();
					}
					if(obj[4]==null){
						strs[4]= "";
					}else{
						strs[4]= obj[4].toString();
					}
					if(obj[10]==null){
						strs[5]= "";
					}else{
						strs[5]= obj[10].toString();
					}
					if(obj[length-2]==null){
						strs[6]= "";
					}else{
						strs[6]= obj[length-2].toString();
					}
					list_xmbm.add(strs);
				}
				if(bool){
					ApplicationEnum a = new ApplicationEnum();
					a.setId(String.valueOf(String.valueOf(obj[10])));
					a.setCaption(dateFomart(String.valueOf(String.valueOf(obj[10]))));
					list.add(a);
				}
			}
		}
		if(ssrc!=null && ssrc.getXxmmc()!=null && !"".equals(ssrc.getXxmmc())){
			ssrc.setXxmmc(java.net.URLEncoder.encode(ssrc.getXxmmc(),"utf8"));
		}
		if(!list_xmbm.isEmpty()){
			action.setParameter("xmfz", list_xmbm);
		}
		action.setSportSsrc(ssrc);
		action.setParameter("listData", list_obj);
		
		if (StringUtil.isNotBlank(scDateTime)) {
			// 查询今日比赛项目的大项目名称，在  快捷导航栏用于  上色！
			List<Object[]> dxmmcList = DBUtil.queryAllList(sql_dxmmc_date);
			action.setParameter("dxmmcList", dxmmcList);
		}
		
		return list;
	}
	


	/**
	 * 2010-03-20 格式为 2010年3月20日
	 * 
	 * @param str
	 * @return
	 */
	public String dateFomart(String str) {
		if (StringUtil.isNotBlank(str)) {
			String strs[] = str.split("-");
			if (strs.length == 3) {
				return strs[0] + "年" + Integer.parseInt(strs[1]) + "月" + Integer.parseInt(strs[2]) + "日";
			} else {
				return "";
			}
		} else {
			return "";
		}
	}

	@SuppressWarnings("unchecked")
	public void load(Object myaction) throws Exception {
		SportCjcxRcAction action = (SportCjcxRcAction) myaction;
		String scbm = action.getParameter("scbm");
		String type = action.getParameter("type");
		action.setParameter("type", type);
		String sfxnsc = action.getParameter("sfxnsc");
		//页面用于显示 时间 项目 组别 性别 级（赛）别 、赛次、分组信息 
		String totalXm = action.getParameter("totalXm");
		action.setParameter("totalXm", totalXm);
		//是否虚拟赛次
		action.setParameter("sfxnsc", sfxnsc);
		//String sjdzxm = " select max(h.sfdzxm) from t_sport_bsxm h  where h.dxmmc=? ";
		//String xmtype = String.valueOf(DBUtil.queryFieldValue(sjdzxm, xmmc));
		String xmtype = action.getParameter("sfdzxm");
		action.setParameter("xmtype", xmtype);
		String sfjtxm = action.getParameter("sfjtxm");
		action.setParameter("sfjtxm", sfjtxm);
		List<TSportCjTdHz> listCjmx = null;//成绩明细
		String sql = "";
		String sql_dwlx = "select t.cjdw from t_sport_ssrc t where t.wid=?";//从赛事日程里面拿单位类型,3,4,5为时间类型,需要特殊处理
		String cjdw = DBUtil.queryFieldValue(sql_dwlx, scbm).toString();
		//查找场馆信息
		String cd = "select t.bscd,t.cdzy from t_sport_ssrc t where t.wid=?";
		List<Object[]> cdxx = DBUtil.queryAllList(cd, scbm);
		if(cdxx.isEmpty()){
			action.setParameter("cdxx",Collections.EMPTY_LIST);
		}else{
			action.setParameter("cdxx", cdxx);
		}
		
		action.setParameter("cdxx",cdxx);
		action.setParameter("dxmmc",action.getParameter("dxmmc"));
		if ("cj".equals(type)) {
			//非决赛的成绩
			if ("1".equals(xmtype)&&"1".equals(sfjtxm)) {
				listCjmx = new  ArrayList<TSportCjTdHz>();
				notNomal(action, listCjmx, scbm,null);
				//多人项目
			}else if("2".equals(sfjtxm)){
				if("3".equals(cjdw)||"4".equals(cjdw)||"5".equals(cjdw)){
					sql = "select (select  wmsys.wm_concat(a.ydybm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and a.jtwid=t.wid and t.shzt='1' ) as ydybm," +
					" t.mc, t.dbtmc as dbtmc ,(select  wmsys.wm_concat(a.ydyxm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and a.jtwid=t.wid and t.shzt='1') as ydymc ," +
					" (t.jps+t.jjjps) as jps,(t.yps+t.jjyps) as yps,(t.tps+t.jjtps)  as tps,t.bpxh as bpxh ,t.cj as cj ,t.bz as bz ,t.df as df,t.SFBJYDHCJ as sfbjydhcj  from t_sport_cj_jt t where   t.scbm=? order by " +
					" case when (t.dxmmc='羽毛球' or t.dxmmc='乒乓球') and t.sfjs<>'1' then t.bpxh end,   case when length(t.cj)=6  then '00:00:'||t.cj when length(t.cj)=9 then '00:'||t.cj when t.cj is null then '99:99:99.999'||t.cj " +
					" else t.cj end , t.cj asc,case when t.mc=0 and t.bz is not null  then 100 else t.mc end , t.mc asc";
				}
				//排球的 成绩单位为0 不受控制
				//else if ("0".equals(cjdw)){
				//	sql = "select (select  wmsys.wm_concat(a.ydybm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and t.shzt='1' ) as ydybm," +
				//	" t.mc, t.dbtmc as dbtmc ,(select  wmsys.wm_concat(a.ydyxm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and t.shzt='1') as ydymc ," +
				//	" (t.jps+t.jjjps) as jps,(t.yps+t.jjyps) as yps,(t.tps+t.jjtps)  as tps,t.bpxh as bpxh ,t.cj as cj ,t.bz as bz ,t.df as df,t.SFBJYDHCJ as sfbjydhcj  from t_sport_cj_jt t where   t.scbm=? order by t.bpxh, case when t.mc=0 and t.bz is not null  then 100 else t.mc end , t.mc asc ";
				//}
				else{
					sql = "select (select  wmsys.wm_concat(a.ydybm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and a.jtwid=t.wid and t.shzt='1' ) as ydybm," +
					" t.mc, t.dbtmc as dbtmc ,(select  wmsys.wm_concat(a.ydyxm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and a.jtwid=t.wid and t.shzt='1') as ydymc ," +
					" (t.jps+t.jjjps) as jps,(t.yps+t.jjyps) as yps,(t.tps+t.jjtps)  as tps,t.bpxh as bpxh ,t.cj as cj ,t.bz as bz ,t.df as df,t.SFBJYDHCJ as sfbjydhcj  from t_sport_cj_jt t where   t.scbm=? order by case when (t.dxmmc='羽毛球' or t.dxmmc='乒乓球') and t.sfjs<>'1' then t.bpxh end, case when t.mc=0 and t.bz is not null  then 100 else t.mc end , t.mc asc," +
					" t.cj desc";
				}
				
				listCjmx = DBUtil.queryAllBeanList(sql, TSportCjTdHz.class, scbm);
			}/*else if("0".equals(sfjtxm)&& "0".equals(sfxnsc)&& "1".equals(xmtype)){
				listCjmx = new  ArrayList<TSportCjTdHz>();
				notNomal(action, listCjmx, scbm,"1");
			}*/else  {
				
				if("3".equals(cjdw)||"4".equals(cjdw)||"5".equals(cjdw)){
					sql = "select t.ydybm,t.mc,(select  a.departname from t_sys_depart a where a.departid=substr(t.departid,0,6)) as dbtmc,t.ydyxm as ydymc,(t.jps+t.jjjps) as jps," +
							"(t.yps+t.jjyps) as yps,(t.tps+t.jjtps) as tps,t.bpxh,t.cj,t.bz ,t.SFBJYDHCJ as sfbjydhcj " +
							" from T_SPORT_CJ_YDY t where t.scbm=?  and t.shzt='1' order by " +
							" case when (t.dxmmc='羽毛球' or t.dxmmc='乒乓球') and t.sfjs<>'1' then t.bpxh end, case when length(t.cj)=6  then '00:00:'||t.cj when length(t.cj)=9 then '00:'||t.cj when t.cj is null then '99:99:99.999'||t.cj " +
							" else t.cj end , t.cj asc,case when t.mc=0 and t.bz is not null  then 100 else t.mc end , t.mc asc";
					
					//排球的 成绩单位为0 不受控制
				}
				//else if ("0".equals(cjdw)){
				//	sql = "select t.ydybm,t.mc,(select  a.departname from t_sys_depart a where a.departid=substr(t.departid,0,6)) as dbtmc,t.ydyxm as ydymc,(t.jps+t.jjjps) as jps,(t.yps+t.jjyps) as yps,(t.tps+t.jjtps) as tps,t.bpxh,t.cj,t.bz ,t.SFBJYDHCJ as sfbjydhcj " +
				//	" from T_SPORT_CJ_YDY t where t.scbm=?  and t.shzt='1' order by  t.bpxh, case when t.mc=0 and t.bz is not null  then 100 else t.mc end , t.mc asc ";
				//}
				else{
					sql = "select t.ydybm,t.mc,(select  a.departname from t_sys_depart a where a.departid=substr(t.departid,0,6)) as dbtmc,t.ydyxm as ydymc,(t.jps+t.jjjps) as jps,(t.yps+t.jjyps) as yps,(t.tps+t.jjtps) as tps,t.bpxh,t.cj,t.bz ,t.SFBJYDHCJ as sfbjydhcj " +
							" from T_SPORT_CJ_YDY t where t.scbm=?  and t.shzt='1' order by case when (t.dxmmc='羽毛球' or t.dxmmc='乒乓球') and t.sfjs<>'1' then t.bpxh end, case when t.mc=0 and t.bz is not null  then 100 else t.mc end , t.mc asc,t.cj desc";
				}
				
				listCjmx = DBUtil.queryAllBeanList(sql, TSportCjTdHz.class, scbm);
			}

		} else if ("md".equals(type)) {
			//秩序单
			if ("1".equals(xmtype)&&"1".equals(sfjtxm)) {
				listCjmx = new  ArrayList<TSportCjTdHz>();
				notNomal(action, listCjmx, scbm,null);
			}else if("2".equals(sfjtxm)){
				sql = "select (select  wmsys.wm_concat(a.ydybm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and a.jtwid=t.wid and t.shzt='1' ) as ydybm," +
				" t.mc, t.dbtmc as dbtmc ,(select  wmsys.wm_concat(a.ydyxm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and a.jtwid=t.wid and t.shzt='1') as ydymc ," +
				" (t.jps+t.jjjps) as jps,(t.yps+t.jjyps) as yps,(t.tps+t.jjtps)  as tps,t.bpxh as bpxh ,t.cj as cj ,t.bz as bz ,t.df as df,t.SFBJYDHCJ as sfbjydhcj  from t_sport_cj_jt t where   t.scbm=? order by  case when (t.dxmmc='羽毛球' or t.dxmmc='乒乓球') and t.sfjs<>'1' then t.bpxh end, case when t.mc=0 then 100 else t.mc end , t.mc asc ";
				listCjmx = DBUtil.queryAllBeanList(sql, TSportCjTdHz.class, scbm);
			} else {
				sql = "select (select  a.departname from t_sys_depart a where a.departid=substr(a.departid,0,6)) as dbtmc, b.xm as ydymc, b.zch, a.bpxh, b.wid as ydybm, a.departid ,t.SFBJYDHCJ as sfbjydhcj from t_sport_cj_ydy a left join t_sport_ydyxx b on a.ydybm=b.wid where a.scbm=? order by a.bpxh";
				listCjmx = DBUtil.queryAllBeanList(sql, TSportCjTdHz.class, scbm);
				
			}

		} else if ("jscj".equals(type)) {
			//决赛成绩
			if ("1".equals(xmtype)) {
				//虚拟赛次
				if("1".equals(sfxnsc)&&"1".equals(sfjtxm)){
					String hql = " from TSportCjJt t where t.scbm=? order by t.bpxh, case when t.mc=0 then 100 else t.mc end , t.mc asc ";
					List<TSportCjJt> list = getBaseDao().findByHql(hql, scbm);
					action.setParameter("jscjList", list);
				}else if("2".equals(sfjtxm)){
					sql = "select (select  wmsys.wm_concat(a.ydybm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and a.jtwid=t.wid and t.shzt='1' ) as ydybm," +
					" t.mc, t.dbtmc as dbtmc ,(select  wmsys.wm_concat(a.ydyxm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and a.jtwid=t.wid and t.shzt='1') as ydymc ," +
					" (t.jps+t.jjjps) as jps,(t.yps+t.jjyps) as yps,(t.tps+t.jjtps)  as tps,t.bpxh as bpxh ,t.cj as cj ,t.bz as bz ,t.df as df ,t.SFBJYDHCJ as sfbjydhcj from t_sport_cj_jt t where   t.scbm=? order by case when (t.dxmmc='羽毛球' or t.dxmmc='乒乓球') and t.sfjs<>'1' then t.bpxh end, case when t.mc=0 then 100 else t.mc end , t.mc asc";
					listCjmx = DBUtil.queryAllBeanList(sql, TSportCjTdHz.class, scbm);
				}else if("0".equals(sfjtxm)||"1".equals(sfjtxm)){
					sql = "select t.ydybm,t.mc,(select  a.departname from t_sys_depart a where a.departid=substr(t.departid,0,6)) as dbtmc,t.ydyxm as ydymc,(t.jps+t.jjjps) as jps,(t.yps+t.jjyps) as yps,(t.tps+t.jjtps) as tps,t.bpxh,t.cj,t.bz ,t.SFBJYDHCJ as sfbjydhcj,t.df as df " +
					"from T_SPORT_CJ_YDY t where t.scbm=? and t.shzt='1' order by case when (t.dxmmc='羽毛球' or t.dxmmc='乒乓球') and t.sfjs<>'1' then t.bpxh end, case when t.mc=0 then 100 else t.mc end , t.mc asc";
					listCjmx = DBUtil.queryAllBeanList(sql, TSportCjTdHz.class, scbm);
				}else{
					//非虚拟赛次
					listCjmx = new  ArrayList<TSportCjTdHz>();
					notNomal(action, listCjmx, scbm,null);
				}
			}else{
				if("2".equals(sfjtxm)){
					sql = "select (select  wmsys.wm_concat(a.ydybm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and a.jtwid=t.wid and t.shzt='1' ) as ydybm," +
							" t.mc, t.dbtmc as dbtmc ,(select  wmsys.wm_concat(a.ydyxm) from t_sport_cj_ydy a where a.scbm=t.scbm and a.departid=t.departid and a.jtwid=t.wid and t.shzt='1') as ydymc ," +
							" (t.jps+t.jjjps) as jps,(t.yps+t.jjyps) as yps,(t.tps+t.jjtps)  as tps,t.bpxh as bpxh ,t.cj as cj ,t.bz as bz ,t.df as df,t.SFBJYDHCJ as sfbjydhcj  from t_sport_cj_jt t where   t.scbm=? order by case when (t.dxmmc='羽毛球' or t.dxmmc='乒乓球') and t.sfjs<>'1' then t.bpxh end, case when t.mc=0 then 100 else t.mc end , t.mc asc";
					listCjmx = DBUtil.queryAllBeanList(sql, TSportCjTdHz.class, scbm);
				}else{
					sql = "select t.ydybm,t.mc,(select  a.departname from t_sys_depart a where a.departid=substr(t.departid,0,6)) as dbtmc,t.ydyxm as ydymc," +
					"(nvl(t.jps,0)+nvl(t.jjjps,0)) as jps,(nvl(t.yps,0)+nvl(t.jjyps,0)) as yps,(nvl(t.tps,0)+nvl(t.jjtps,0)) as tps," +
					"t.bpxh,t.cj,t.bz,t.df,t.SFBJYDHCJ as sfbjydhcj  " +
					"from T_SPORT_CJ_YDY t where t.scbm=? and t.shzt='1' order by case when (t.dxmmc='羽毛球' or t.dxmmc='乒乓球') and t.sfjs<>'1' then t.bpxh end, case when t.mc=0 then 100 else t.mc end , t.mc asc";
					listCjmx = DBUtil.queryAllBeanList(sql, TSportCjTdHz.class, scbm);
				}
				
			}
			
		}
		action.setListSportCjTdHz(listCjmx==null?Collections.EMPTY_LIST:listCjmx);
	}

	/**
	 * 类似球类 的集体性质的项目处理
	 * 
	 * @param action
	 * @param list_hz 传入页面数据的 TSportCjTdHz 集合
	 * @param state 表示是 球类对仗 还是  非集体对仗 1： 非集体对仗
	 * @param scbm 赛程编码
	 */
	public void notNomal(SportCjcxRcAction action, List<TSportCjTdHz> list_hz, String scbm,String state) {
		// 查看所有运动员
		String sql = "select a.ydybm, a.ydyxm,a.bpxh,a.departid from t_sport_cj_ydy a where a.scbm=?";
		List<Object[]> list_obj = DBUtil.queryAllList(sql, scbm);
	
		if (list_obj != null) {
			for (Object[] obj : list_obj) {
				TSportCjTdHz stc = new TSportCjTdHz();
				// 运动员编码
				if (obj[0] != null) {
					stc.setYdybm(String.valueOf(obj[0]));
				} else {
					stc.setYdybm("");
				}
				// 运动员名称
				if (obj[1] != null) {
					stc.setYdymc(String.valueOf(obj[1]));
				} else {
					stc.setYdymc("");
				}
				// 编排序号
				if (obj[2] != null) {
					stc.setBpxh(String.valueOf(obj[2]));
				} else {
					stc.setBpxh("");
				}

				if (obj[3] != null) {
					stc.setDepartid(String.valueOf(obj[3]));
				} else {
					stc.setDepartid("");
				}

				list_hz.add(stc);
			}
		}
		// 查询成绩
		String sql2 = "select t.dbtmc ,t.cj,t.departid from t_sport_cj_jt t where t.scbm=?";
		if("1".equals(state)){
			sql2 = "select (select  a.departname from t_sys_depart a where a.departid=substr(t.departid,0,6)) ,t.cj,t.departid from t_sport_cj_ydy t where t.scbm=?";
		}
		List<Object[]> list_cj = DBUtil.queryAllList(sql2, scbm);
		if (list_cj != null && list_cj.size() > 0) {
			Object[] obj = list_cj.get(0);
			Object[] obj2 = list_cj.get(1);
			action.setParameter("tuandui1", obj);
			action.setParameter("tuandui2", obj2);
		}
	}

	public boolean remove(Object myaction) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
	}
	
	/**
	 * 获取距离今天最近的比赛时间
	 * 
	 * @param action
	 * @return
	 * @throws Exception
	 */
	public String getRecentDate(SportCjcxRcAction action) throws Exception {
		List<ApplicationEnum> listapp = action.getBssjList();
		int index = 0;
		if (!listapp.isEmpty()) {
			long min = DateUtil.dateDayInteval(DateUtil.currentDateString(), listapp.get(0).getId());
			for (int i = 0; i < listapp.size(); i++) {
				long c = DateUtil.dateDayInteval(DateUtil.currentDateString(), listapp.get(i).getId());
				if (!(c > Math.abs(min))) {
					index = i;
					min = c;
				}
			}
		}
		return String.valueOf(listapp.get(index).getId());
	}
	
	public void tdry (Object myaction){
		SportCjcxRcAction action = (SportCjcxRcAction) myaction;
		String departid = action.getParameter("departid");
		String scbm = action.getParameter("scbm");
		String dbtmc = action.getParameter("dbtmc");
		action.setParameter("totalXm", action.getParameter("totalXm"));
		action.setParameter("dbtmc", action.getParameter("dbtmc"));
		String sql = "select b.ydyxm,b.ydybm,b.bpxh, a.dbtmc from t_sport_cj_jt a,t_sport_cj_ydy  b where a.scbm=b.scbm and a.wid=b.jtwid and a.departid=b.departid and (b.sfjtxm=1 or b.sfjtxm=2) and a.departid=?  and a.scbm=?";
		List<?> list = DBUtil.queryAllList(sql, departid,scbm);
		action.setParameter("tdry", list);
	}
}
