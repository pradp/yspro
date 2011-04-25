package com.imchooser.infoms.service.biz.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.SportCjcxDbtAction;
import com.imchooser.infoms.entity.sys.TSysArea;

/**
 * 代表团成绩查询
 * 
 * @author LiuHaiDong
 * @date 2010-5-20
 * 
 */
public class SportCjcxDbtServiceImpl extends BaseServiceAbstractSupport {
	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(SportCjcxDbtServiceImpl.class);
	public List<?> list(Object myaction, Pager arg1) throws Exception {
		SportCjcxDbtAction action = (SportCjcxDbtAction) myaction;
		String sx = action.getParameter("sx");
		String departid = action.getParameter("departid");
		List<TSysArea> list = action.getDbt();

		if (StringUtils.isBlank(departid) && !"1".equals(sx)) {
			// 查看代表团成绩分布，但是没有选哪个代表团，则默认选中一个代表团
			departid = Constants.AREAID_ZBF;
		}
		// TODO 可以去掉的SQL
		// String sql1 =
		// "select replace(t.areaname,'市','') from t_sys_area t where t.areaid=? ";
		// String departname = (String) DBUtil.queryFieldValue(sql1,
		// departid);// 当前查询地区名称

		if (departid.length() == 6) {
			// 查看指定代表团的成绩分布
			queryDbtCjfb(action, departid);

		} else if (departid.length() == 9) {
			// 查看区县成绩分布
			String hql_list = " select a.dxmmc,a.xxmmc,nvl((a.jps+a.jjjps),0) as jps,"
					+ "nvl((a.yps+a.jjyps),0) as yps,"
					+ "nvl((a.tps+a.jjtps),0) as tps,"
					+ "a.dbtmc,(select f.bssj from t_sport_ssrc f where a.scbm=f.wid and a.departid=?) as bssj ,"
					+ "(select t.bscd from T_Sport_Ssrc t where t.wid=a.scbm) as scbm,"
					+ "(select wmsys.wm_concat(m.wid||'_'||m.xm) from T_Sport_Ydyxx m where a.dfly like '%'||m.wid||'%') as xm, "
					+
					// "(select wmsys.wm_concat(m.ydybm) from T_Sport_Cj_Ydy m where a.scbm=m.scbm and m.departid=?) as ydybm,a.yddmc,"
					// +
					"a.dfly as ydybm, a.yddmc,"
					+ "(select wmsys.wm_concat(m.sfjtxm) from T_Sport_Cj_Ydy m where a.scbm=m.scbm and m.departid=?) as sfjtxm, "
					+ "(select t.cdzy from T_Sport_Ssrc t where t.wid=a.scbm) as cdzy,a.scbm,nvl((a.df+a.jjf),0)as df,a.dflx,a.sfjrzcj, "
					+ "(select wmsys.wm_concat(c.sfbjydhcj)  from t_sport_cj_ydy c where c.scbm=a.scbm and c.departid=? ) as sfbjydhcj "
					// "(select wmsys.wm_concat(m.xm) from T_Sport_Ydyxx m where m.wid like a.dfly) as dflyXm "
					// +
					+ "  from T_Sport_Cj_Sx_Mx a,t_sport_ssrc b  where a.departid=?  and b.fbzt='3' and a.shzt='1' and b.wid=a.scbm order by b.bssj desc ";
			String sql_drcj = "select t.aydrjps,t.aydryps,t.aydrtps,t.aydrzf,t.qydrjps,t.qydryps,t.qydrtps,t.qydrzf,t.ssrs,t.sszsdrjps,t.zjdrjps,t.zjdryps,t.zjdrtps,t.zjdrzf,t.yddbm "
					+ " from t_sport_drcjb t where t.yddbm=? ";// 带入成绩查询
			String sql_hz1 = "select tt.df+nvl((select b.jjf  from t_sport_cj_td_sx_jjf b where b.departid=? ),0),"
					+ "tt.jps+nvl((select b.jjjps  from t_sport_cj_td_sx_jjf b where b.departid=? ),0),"
					+ "tt.yps+nvl((select b.jjyps  from t_sport_cj_td_sx_jjf b  where b.departid=?),0),"
					+ "tt.tps+nvl((select b.jjjps  from t_sport_cj_td_sx_jjf b where b.departid=? ),0)"
					+ " from ( "
					+ " select  nvl(sum(a.df+nvl((select b.jjf  from t_sport_cj_td_sx_jjf b where a.departid=b.departid ),0)),0) as df,"
					+ "nvl(sum((a.jps+nvl(a.jjjps,0))),0) as jps," + "nvl(sum((a.yps+nvl(a.jjyps,0))),0) as yps,"
					+ "nvl(sum((a.tps+nvl(a.jjtps,0))),0) as tps "
					+ " from T_Sport_Cj_Sx_Mx a where a.departid=? ) tt    ";
			// 汇总加减分
			String sql_hzjjf = " select t.jjjps,t.jjyps,t.jjtps,t.jjf from t_sport_cj_td_sx_jjf t where t.departid=? ";
			List<Object[]> listHz1 = DBUtil.queryAllList(sql_hz1, departid, departid, departid, departid, departid);
			List<Object[]> listDrcj = DBUtil.queryAllList(sql_drcj, departid);
			List<Object[]> listCj = DBUtil.queryAllList(hql_list, departid, departid, departid, departid);
			List<Object[]> listHzjjf = DBUtil.queryAllList(sql_hzjjf, departid);
			action.setParameter("listDrcj", listDrcj);
			action.setParameter("listHz1", listHz1);
			action.setParameter("listHzjjf", listHzjjf);
			action.setListCj(listCj);
			//页面根据大项目名称分组合并 显示   -- 大项目种类
			List<Object[]> dxmmcs = new ArrayList<Object[]>();
			if(listCj!=null && listCj.size()>0){
				for(Object[] obj : listCj){
					
					if(obj!=null && obj[0]!=null){
						boolean bool = true;
						if(!dxmmcs.isEmpty()){
								for(Object[] str : dxmmcs){
									if(String.valueOf(str[0]).equals(String.valueOf(obj[0]))){
										addAll(str,obj);
										bool = false;
									}
								}
						}
						
						if(bool){
							Object [] strs = new Object[6];
							strs[0]=obj[0];
							if(obj[2]!=null){
								strs[1]=obj[2];
							}else{
								strs[1]="0";
							}
							if(obj[3]!=null){
								strs[2]=obj[3];
							}else{
								strs[2]="0";
							}
							if(obj[4]!=null){
								strs[3]=obj[4];
							}else{
								strs[3]="0";
							}
							if(obj[14]!=null){
								strs[4]=obj[14];
							}else{
								strs[4]="0";
							}
							if(obj[15]!=null){
								strs[5]=obj[15];
							}else{
								strs[5]="";
							}
							dxmmcs.add(strs);
						}
					}
				}
			}
			action.setParameter("dxmmcs",dxmmcs);

		}
		if ("1".equals(sx) && departid.length() >= 6) {
			// 成绩上方列出各个地区，作为导航
			departid = departid.substring(0, 6);
			// action.setParameter("departid_bj", departid);//代表团编号
			String sql_cx1 = " select t.areaid,substr(t.areaname,length((select a.areaname from T_Sys_Area a where a.areaid=? ))+1,length(t.areaname)) as areaname"
					+ " from T_Sys_Area t where (t.arealevel='3' or t.arealevel='4') and t.upareaid=? ";
			List<Object[]> listdq = DBUtil.queryAllList(sql_cx1, departid, departid);
			action.setParameter("re", listdq);// 区县名称列表
		}
		// action.setParameter("departid_bj", departid);//代表团编号
		action.setParameter("departid", departid);
		// action.setParameter("departname", departname);
		action.setParameter("sx", sx);
		return list;
	}

	/**
	 * 查看指定代表团的成绩分布
	 * 
	 * @param action
	 * @param departid 代表团编号
	 */
	private void queryDbtCjfb(SportCjcxDbtAction action, String departid) {
		String hql_list = null;
		String sql_drcj = null;
		String sql_hzjp = null;
		String sql_hz = null;
		String sql_fbc = null;
		String sql_hz1 = null;
		// String sql_sxdr = null;
		String sql_hzjjf = null;
		// 主干查询金银铜等list信息,下面在else中出现相同名字,是查询相同的内容
		hql_list = " select a.dxmmc,a.xxmmc,nvl((a.jps+a.jjjps),0) as jps,"
				+ "nvl((a.yps+a.jjyps),0) as yps,"
				+ "nvl((a.tps+a.jjtps),0) as tps,"
				+ "a.dbtmc,(select f.bssj from t_sport_ssrc f where a.scbm=f.wid and a.departid=?) as bssj ,"
				+ "(select t.bscd from T_Sport_Ssrc t where t.wid=a.scbm) as scbm,"
				+ "(select wmsys.wm_concat(m.wid||'_'||m.xm) from T_Sport_Ydyxx m where a.dfly like '%'||m.wid||'%') as xm, "
				+ "a.dfly as ydybm, a.yddmc,"
				+ "(select wmsys.wm_concat(m.sfjtxm) from T_Sport_Cj_Ydy m where a.scbm=m.scbm and m.departid=?) as sfjtxm, "
				+ "(select t.cdzy from T_Sport_Ssrc t where t.wid=a.scbm) as cdzy,a.scbm,nvl((a.df+a.jjf),0)as df,a.dflx,a.sfjrzcj, "
				+ "(select wmsys.wm_concat(c.sfbjydhcj)  from t_sport_cj_ydy c where c.scbm=a.scbm and c.departid=? ) as sfbjydhcj " 
				+ "  from T_Sport_Cj_Td_Mx a,t_sport_ssrc b  where a.departid=?  and b.fbzt='3' and a.shzt='1' and b.wid=a.scbm order by b.bssj desc ";
		String sql_sfjr21 = "select tt.dxmmc,tt.hzlx  from (select t.dxmmc,t.hzlx from t_sport_cj_jrpmxm t where t.hzlx='1' and t.departid=?"
				+ " union "
				+ "select t.dxmmc,t.hzlx from t_sport_cj_jrpmxm t where t.hzlx='2' and t.departid=?"
				+ " union "
				+ "select t.dxmmc,t.hzlx from t_sport_cj_jrpmxm t where t.hzlx='3' and t.departid=?) tt order by tt.hzlx";
		// 界面下方带入成绩查询以及四项带入成绩,下面在else中出现相同名字,是查询相同的内容
		sql_drcj = "select t.aydrjps,t.aydryps,t.aydrtps,t.aydrzf,t.qydrjps,t.qydryps,t.qydrtps,t.qydrzf,t.ssrs,t.sszsdrjps,t.zjdrjps,t.zjdryps,t.zjdrtps,t.zjdrzf,t.yddbm,"
				+ " t.djxmjps,t.djxmzf,t.fcfbjps,t.fcfbzf,t.xdwdjps,t.xdwdzf,t.phtjps,t.phtzf,t.jphj,t.zfhj "
				+ " from t_sport_drcjb t where t.yddbm=? ";
		// 四项带入成绩,只有代表团可以查看
		// sql_sxdr =
		// "select t.djxmjps,t.djxmzf,t.fcfbjps,t.fcfbzf,t.xdwdjps,t.xdwdzf,t.phtjps,t.phtzf,t.jphj,t.zfhj from t_sport_drcjb t where t.yddbm=?";
		// 本届赛会成绩金银铜汇总奖牌,下面在else中出现相同名字,是查询相同的内容
		sql_hzjp = " select sum(a.jps+(select b.jjjps  from t_sport_cj_td_sx_jjf b  where a.departid=b.departid)) as zjps,"
				+ "sum(a.yps+(select b.jjyps  from t_sport_cj_td_sx_jjf b  where a.departid=b.departid)) as zyps,"
				+ "sum(a.tps+(select b.jjtps  from t_sport_cj_td_sx_jjf b where a.departid=b.departid)) as ztps from T_Sport_Cj_Td_Mx a where a.departid=?";
		// 团队成绩汇总,下面在else中出现相同名字,是查询相同的内容
		sql_hz = " select nvl(t.df,0) as df,"
				+ "nvl(sum((t.jps+nvl((select b.jjjps  from t_sport_cj_td_sx_jjf b where t.departid=b.departid ),0))),0) as jps,"
				+ "nvl(sum((t.yps+nvl((select b.jjyps  from t_sport_cj_td_sx_jjf b  where t.departid=b.departid),0))),0) as yps,"
				+ "nvl(sum((t.tps+nvl((select b.jjjps  from t_sport_cj_td_sx_jjf b where t.departid=b.departid ),0))),0) as tps "
				+ " from t_sport_cj_td_hz t where t.departid=? group by t.df ";
		// 明细表汇总,下面在else中出现相同名字,是查询相同的内容
		sql_hz1 = "select tt.df+nvl(b.jjf,0), " + "tt.jps+nvl(b.jjjps,0), " + "tt.yps+nvl(b.jjyps,0), "
				+ " tt.tps+nvl(b.jjtps,0) " + " from (  " + " select  nvl(sum(a.df),0) as df, "
				+ "nvl(sum((a.jps+nvl(a.jjjps,0))),0) as jps, " + " nvl(sum((a.yps+nvl(a.jjyps,0))),0) as yps, "
				+ " nvl(sum((a.tps+nvl(a.jjtps,0))),0) as tps," + " a.departid  "
				+ "from T_Sport_Cj_Td_Mx a where a.departid=? group by a.departid) tt  "
				+ " left join t_sport_cj_td_sx_jjf b on tt.departid=b.departid ";
		// 非本届运动会竞赛得分,下面在else中出现相同名字,是查询相同的内容
		sql_fbc = " select count(t.df) as c from t_sport_cj_td_mx t where t.dflx='5' and t.departid=? ";
		// 汇总加减分
		sql_hzjjf = " select t.jjjps,t.jjyps,t.jjtps,t.jjf from t_sport_cj_td_sx_jjf t where t.departid=? ";
		List<Object[]> listCj = DBUtil.queryAllList(hql_list, departid, departid, departid, departid);
		List<Object[]> listDrcj = DBUtil.queryAllList(sql_drcj, departid);
		List<Object[]> listSfjr21 = DBUtil.queryAllList(sql_sfjr21, departid, departid, departid);
		// List<Object[]> listSxDrcj = DBUtil.queryAllList(sql_sxdr, departid);
		List<Object[]> listHzjp = DBUtil.queryAllList(sql_hzjp, departid);
		List<Object[]> listHz = DBUtil.queryAllList(sql_hz, departid);
		List<Object[]> listFbcdr = DBUtil.queryAllList(sql_fbc, departid);
		List<Object[]> listHz1 = DBUtil.queryAllList(sql_hz1, departid);
		List<Object[]> listHzjjf = DBUtil.queryAllList(sql_hzjjf, departid);
		action.setListCj(listCj);
		//页面根据大项目名称分组合并 显示   -- 大项目种类
		List<Object[]> dxmmcs = new ArrayList<Object[]>();
		if(listCj!=null && listCj.size()>0){
			for(Object[] obj : listCj){
				
				if(obj!=null && obj[0]!=null){
					boolean bool = true;
					if(!dxmmcs.isEmpty()){
							for(Object[] str : dxmmcs){
								if(String.valueOf(str[0]).equals(String.valueOf(obj[0]))){
									addAll(str,obj);
									bool = false;
								}
							}
					}
					if(bool){
						Object [] strs = new Object[6];
						strs[0]=obj[0];
						if(obj[2]!=null){
							strs[1]=obj[2];
						}else{
							strs[1]="0";
						}
						if(obj[3]!=null){
							strs[2]=obj[3];
						}else{
							strs[2]="0";
						}
						if(obj[4]!=null){
							strs[3]=obj[4];
						}else{
							strs[3]="0";
						}
						if(obj[14]!=null){
							strs[4]=obj[14];
						}else{
							strs[4]="0";
						}
						if(obj[15]!=null){
							strs[5]=obj[15];
						}else{
							strs[5]="";
						}
						dxmmcs.add(strs);
					}
					
					
					
				}
			}
		}
		action.setParameter("dxmmcs",dxmmcs);
		action.setParameter("listSfjr21", listSfjr21);
		action.setParameter("listDrcj", listDrcj);
		// action.setParameter("listSxDrcj", listSxDrcj);
		action.setParameter("listHzjp", listHzjp);
		action.setParameter("listHz", listHz);
		action.setParameter("listFbcdr", listFbcdr);
		action.setParameter("listHz1", listHz1);
		action.setParameter("listHzjjf", listHzjjf);
	}

	public void load(Object arg0) throws Exception {

	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {

	}

	/**
	 * 集合数组数据相加（金、银、铜、得分、得牌总数）
	 * @param list1
	 * @param list2
	 * @return
	 */
	public void addAll(Object[] obj, Object[] obj2) {
		// 相同项目数据相加
										// 金牌相加
										if (obj[1] != null && StringUtils.isNotBlank(String.valueOf(obj[1]))) {
											if (obj2[2] != null && StringUtils.isNotBlank(String.valueOf(obj2[2]))) {
												obj[1] = Double.parseDouble(String
														.valueOf(obj[1]).trim())
														+ Double.parseDouble(String.valueOf(obj2[2]).trim());
											}
										} else if (obj2[2] != null && StringUtils.isNotBlank(String.valueOf(obj2[2]))) {
											obj[1] = String.valueOf(obj2[2]);
										}else{
											obj[1] = "0";
										}
										// 银牌相加
										if (obj[2] != null && StringUtils.isNotBlank(String.valueOf(obj[2]))) {
											if (obj2[3] != null && StringUtils.isNotBlank(String.valueOf(obj2[3]))) {
												obj[2] =Double.parseDouble(String
														.valueOf(obj[2]).trim())
														+ Double.parseDouble(String.valueOf(obj2[3]).trim());
											}
										} else if (obj2[3] != null && StringUtils.isNotBlank(String.valueOf(obj2[3]))) {
											obj[2] = String.valueOf(obj2[3]);
										}else{
											obj[2] = "0";
										}
										// 铜牌相加
										if (obj[3] != null && StringUtils.isNotBlank(String.valueOf(obj[3]))) {
											if (obj2[4] != null && StringUtils.isNotBlank(String.valueOf(obj2[4]))) {
												obj[3] =Double.parseDouble(String
														.valueOf(obj[3]).trim())
														+ Double.parseDouble(String.valueOf(obj2[4]).trim());
											}
										} else if (obj2[4] != null && StringUtils.isNotBlank(String.valueOf(obj2[4]))) {
											obj[3] =String.valueOf(obj2[4]);
										}else{
											obj[3] ="0";
										}
										// 得分相加
										if (obj[4] != null && StringUtils.isNotBlank(String.valueOf(obj[4]))) {
											if (obj2[14] != null && StringUtils.isNotBlank(String.valueOf(obj2[14]))) {
												obj[4] =Double.parseDouble(String
														.valueOf(obj[4]).trim())
														+ Double.parseDouble(String.valueOf(obj2[14]).trim());
											}
										} else if (obj2[14] != null && StringUtils.isNotBlank(String.valueOf(obj2[14]))) {
											obj[4] =String.valueOf(obj2[14]);
										}else{
											obj[4] = "0";
										}
									
		}
	
}
