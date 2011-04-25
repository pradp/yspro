package com.imchooser.infoms.service.biz.impl;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportSjhdJtxmYjAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.util.StringUtil;

/**
 * 多人集体原籍地数据核对
 * @author LiuHaiDong 2010-6-9
 */
public class SportSjhdJtxmYjServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportSjhdJtxmYjAction action = (SportSjhdJtxmYjAction) myaction;
		TSportBsxm tsportBsxm = action.getTsportBsxm();

		String sql1 = " select yy.bssj,yy.scbm,yy.xmmc,yy.departid,yy.ydyxm,yy.jps,yy.yps,yy.tps,yy.df from ( "
				+ "select (select a.bssj from t_sport_ssrc a where a.wid=t.scbm) as bssj, t.scbm as scbm,"
				+ " (t.dxmmc||'，'||t.xxmmc) as xmmc,  (select h.departname from t_sys_depart h where h.departid=x.xyjfdq4) as departid, "
				+ " (select wmsys.wm_concat( b.ydyxm||'_'||(select h.departname from t_sys_depart h where h.departid= u.departid)||'_'||(u.jps+u.jjjps)||'_'||(u.yps+u.jjyps)||'_'||(u.tps+u.jjtps)||'_'||(u.df+u.jjf) )"
				+ " from t_sport_cj_ydy b,t_sport_cj_zs_mx u "
				+ " where b.scbm=t.scbm and b.departid=t.departid  and u.dfly=b.ydybm and u.departid=x.xyjfdq4 and u.scbm=b.scbm) as ydyxm,"
				+ " u.jps+u.jjjps as jps,u.yps+u.jjyps as yps,u.tps+u.jjtps as tps,u.df+u.jjf as df ";
		String sql = " from  t_sport_cj_ydy b,t_sport_ydyxx x,t_sport_cj_zs_mx u,t_sport_cj_td_mx r,t_sport_cj_jt t "
				+ "  left join t_sport_ssrc k on t.scbm=k.wid left join t_sport_bsxm l  on k.xmbm=l.wid "
				+ " where b.ydybm=x.wid and x.xyjfdq4 is not null "
				+ " and t.scbm=b.scbm and u.scbm=b.scbm and r.scbm=b.scbm and t.departid=b.departid and u.dfly=b.ydybm and r.departid=u.departid and r.dflx='4' "
				+ " ) yy where  1=1 group by yy.bssj,yy.scbm,yy.xmmc,yy.departid,yy.ydyxm,yy.jps,yy.yps,yy.tps,yy.df ";

		String sql2 = " select (select a.bssj from t_sport_ssrc a where a.wid=t.scbm) as bssj, (t.dxmmc||'，'||t.xxmmc),"
				+ " t.scbm as scbm ";
		String sql3 = " from  t_sport_cj_ydy b,t_sport_ydyxx x,t_sport_cj_zs_mx u,t_sport_cj_td_mx r,t_sport_cj_jt t "
				+ " left join t_sport_ssrc k on t.scbm=k.wid left join t_sport_bsxm l  on k.xmbm=l.wid "
				+ " where b.ydybm=x.wid and x.xyjfdq4 is not null "
				+ " and t.scbm=b.scbm and u.scbm=b.scbm and r.scbm=b.scbm and t.departid=b.departid and u.dfly=b.ydybm and r.departid=u.departid and r.dflx='4'";
		String sql4 = " group by t.scbm,(t.dxmmc||'，'||t.xxmmc)";
		if (tsportBsxm != null) {
			if (StringUtil.isNotBlank(tsportBsxm.getDxmmc())) {
				sql += " and l.dxmmc='" + URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getXxmmc())) {
				sql += " and l.xxmmc ='" + URLDecoder.decode(tsportBsxm.getXxmmc(), "utf-8") + "'";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getZb())) {
				sql += " and l.zb='" + tsportBsxm.getZb() + "' ";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getXbz())) {
				sql += " and l.xbz='" + tsportBsxm.getXbz() + "' ";
			}
		}
		if (StringUtils.isNotBlank(action.getParameter("bssj"))) {
			sql += " and to_char((select a.bssj from t_sport_ssrc a where a.wid=t.scbm),'yyyy-MM-dd')= '"
					+ action.getParameter("bssj") + "'";
		}
		action.setParameter("bssj", action.getParameter("bssj"));
		long count = DBUtil.count("select count(tt.c) from　( select count(*) as c " + sql3 + sql4 + " ) tt");
		pager.setTotalRows(count);
		pager.setEachPageRows(5);
		// String xxmmc = tsportBsxm.getXxmmc();
		action.setPager(pager);
		List<Object[]> list = DBUtil.queryAllList(sql1 + sql);
		List<Object[]> list_xm = DBUtil.queryPageList(pager, sql2 + sql3 + sql4);
		List<Object[]> list_dq = new ArrayList<Object[]>();
		// 把拼接的字符串转化为数组,方便页面展示
		action.setParameter("list", list);
		for (int i = 0; i < list.size(); i++) {
			Object[] line = list.get(i);
			boolean bj = true;
			for (Object[] b : list_dq) {
				if (b[0].toString().equals(line[1].toString()) && b[1].toString().equals(line[3].toString())) {
					bj = false;
					break;
				}
			}

			if (bj) {
				Object[] c = new Object[6];
				c[0] = line[1].toString();
				c[1] = line[3].toString();
				c[2] = line[5].toString();
				c[3] = line[6].toString();
				c[4] = line[7].toString();
				c[5] = line[8].toString();
				list_dq.add(c);
			}
		}
		action.setParameter("listdq", list_dq);
		return list_xm;
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
