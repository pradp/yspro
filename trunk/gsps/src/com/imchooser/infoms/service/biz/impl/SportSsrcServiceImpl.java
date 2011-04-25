package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.SportSsrcAction;
import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportSsrc;
import com.imchooser.infoms.util.BusinessLogUtil;
import com.imchooser.util.DateUtil;

/**
 * 赛事日程
 * 
 * @author DaiQinggao
 * @date 2010-03-24
 */
public class SportSsrcServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportSsrcAction action = (SportSsrcAction) myaction;
		TSportSsrc tsportSsrc = action.getTsportSsrc();
		String hqlcolumn = "select new TSportSsrc(a.wid,a.xmbm,"
				+ "(select c.dxmmc from TSportBsxm c where c.wid=a.xmbm ) as dxmmc,"
				+ "(select c.xxmmc from TSportBsxm c where c.wid=a.xmbm ) as xxmmc,"
				+ "(select cc.zdmc from TSysCode cc where cc.zdbm=(select c.zb from TSportBsxm c where c.wid=a.xmbm )and cc.zdlb='BSXM_ZB') as zb,"
				+ "(select cc.zdmc from TSysCode cc where cc.zdbm=(select c.xbz from TSportBsxm c where c.wid=a.xmbm )and cc.zdlb='BSXM_XBZ') as xbz, "
				+ "(select cc.zdmc from TSysCode cc where cc.zdbm=(select c.xmdj from TSportBsxm c where c.wid=a.xmbm )and cc.zdlb='BSXM_XMDJ') as xmdj, "
				+ "(select cc.zdmc from TSysCode cc where cc.zdbm=a.cjdw and cc.zdlb='SSRC_CJDW' ) as cjdw,a.bssj, "
				+ "(select cc.zdmc from TSysCode cc where cc.zdbm=a.bpfz and cc.zdlb='SSRC_BPFZ' ) as bpfz, "
				+ "(select cc.zdmc from TSysCode cc where cc.zdbm=a.scbm and cc.zdlb='SSRC_SCBM' ) as scbm,a.bscd,a.cdzy,"
				+ "(select cc.zdmc from TSysCode cc where cc.zdbm=a.fbzt and cc.zdlb='FBZT') as fbzt)";
		String hql = " from TSportSsrc a where 1=1 ";
		if (tsportSsrc != null) {
			if (StringUtils.isNotBlank(tsportSsrc.getDxmmc())) {
				hql += " and a.xmbm in (select wid from TSportBsxm where dxmmc = '" + tsportSsrc.getDxmmc().trim()
						+ "') ";
			}
			if (StringUtils.isNotBlank(tsportSsrc.getXxmmc())) {
				hql += " and a.xmbm in (select wid from TSportBsxm where xxmmc='" + java.net.URLDecoder.decode(tsportSsrc.getXxmmc().trim(),"utf-8")
						+ "') ";
			}
			if (StringUtils.isNotBlank(tsportSsrc.getZb())) {
				hql += " and a.xmbm in (select wid from TSportBsxm where zb='" + tsportSsrc.getZb().trim() + "') ";
			}
			if (StringUtils.isNotBlank(tsportSsrc.getXbz())) {
				hql += " and a.xmbm in (select wid from TSportBsxm where xbz='" + tsportSsrc.getXbz().trim() + "') ";
			}
			if (StringUtils.isNotBlank(tsportSsrc.getScbm())) {
				hql += " and a.xmbm in (select wid from TSportBsxm where scbm='" + tsportSsrc.getScbm().trim() + "') ";
			}
		}
		if (StringUtils.isNotBlank(action.getParameter("startTime"))) {
			hql += " and to_char(a.bssj,'yyyy-MM-dd HH24:mi:ss')>= '" + action.getParameter("startTime") + "'";
		}
		if (StringUtils.isNotBlank(action.getParameter("endTime"))) {
			hql += "and to_char(a.bssj,'yyyy-MM-dd HH24:mi:ss')<='" + action.getParameter("endTime") + "'";
		}
		action.setParameter("startTime", action.getParameter("startTime"));
		action.setParameter("endTime", action.getParameter("endTime"));
		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + " order by a.bssj desc,a.xmbm ";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	public void load(Object myaction) throws Exception {
		SportSsrcAction action = (SportSsrcAction) myaction;
		String wid = action.getWid();
		action.setParameter("type", action.getParameter("type"));
		String hql = "select new TSportSsrc(a.wid,a.xmbm,"
				+ "(select b.dxmmc from TSportBsxm b where b.wid=a.xmbm ) as dxmmc, "
				+ "(select b.xxmmc from TSportBsxm b where b.wid=a.xmbm ) as xxmmc, "
				+ "(select c.zdmc from TSysCode c where c.zdbm=(select b.zb from TSportBsxm b where b.wid=a.xmbm )and c.zdlb='BSXM_ZB') as zb, "
				+ "(select c.zdmc from TSysCode c where c.zdbm=(select b.xbz from TSportBsxm b where b.wid=a.xmbm )and c.zdlb='BSXM_XBZ') as xbz, "
				+ "(select c.zdmc from TSysCode c where c.zdbm=(select b.xmdj from TSportBsxm b where b.wid=a.xmbm )and c.zdlb='BSXM_XMDJ') as xmdj, "
				+ "(select c.zdmc from TSysCode c where c.zdbm=a.cjdw and c.zdlb='SSRC_CJDW' ) as cjdw,a.bssj, "
				+ "(select c.zdmc from TSysCode c where c.zdbm=a.bpfz and c.zdlb='SSRC_BPFZ' ) as bpfz, "
				+ "(select c.zdmc from TSysCode c where c.zdbm=a.scbm and c.zdlb='SSRC_SCBM' ) as scbm,a.bscd,a.cdzy,a.sysc,a.xysc,a.djjd,a.sfxnsc)"
				+ " from TSportSsrc a where a.wid = ?";
		List<TSportSsrc> tsportSsrc_list = getBaseDao().findByHql(hql, wid);
		TSportSsrc tsportSsrc = null;
		if (tsportSsrc_list != null && tsportSsrc_list.size() > 0) {
			tsportSsrc = tsportSsrc_list.get(0);
		}
		if (tsportSsrc != null) {
			String xmbmSsrc = tsportSsrc.getDxmmc() + tsportSsrc.getXxmmc() + tsportSsrc.getZb() + tsportSsrc.getXbz()
					+ tsportSsrc.getXmdj();
			String sxyscSsrc = tsportSsrc.getSysc();
			String sxyscSsrc1 = tsportSsrc.getXysc();
			action.setParameter("xxjsrName", xmbmSsrc);
			action.setParameter("sxyscName", sxyscSsrc);
			action.setParameter("sxyscName1", sxyscSsrc1);
			action.setParameter("xmbm", tsportSsrc.getXmbm());
		}
		TSportSsrc bean = getBaseDao().findById(TSportSsrc.class, wid);
		action.setTsportSsrc(bean);

	}

	@SuppressWarnings("static-access")
	public boolean remove(Object myaction) throws Exception {
		SportSsrcAction action = (SportSsrcAction) myaction;
		String ids = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TSportSsrc", "wid", "=", ids);
		if (deleteSuccess) {
			action.setListDate(null);
			action.getListDate();
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_SSRC,
					Constants.LOG_ACTION_DEL);
		}
		return deleteSuccess;
	}

	@SuppressWarnings("static-access")
	public void saveOrUpdate(Object myaction) throws Exception {
		SportSsrcAction action = (SportSsrcAction) myaction;
		TSportSsrc object = action.getTsportSsrc();
		// 传递 项目编码到input(针对保存并新增);
		action.setParameter("xmbm", object.getXmbm());
		String xxjsrName = action.getParameter("xxjsrName");
		String sxyscName = action.getParameter("sxyscName");
		String sxyscName1 = action.getParameter("sxyscName1");
		if (StringUtils.isBlank(object.getWid())) {
			object.setWid(SeqFactory.getNewSequenceAlone());
			object.setFbzt("0");
			object.setSysc(sxyscName);
			object.setXysc(sxyscName1);
			String bssj1 = object.getBssj1() + ":00";
			object.setBssj(DateUtil.parseDate(bssj1));
			getBaseDao().save(object);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_SSRC,
					Constants.LOG_ACTION_SAVE);
		} else {
			object.setSysc(sxyscName);
			object.setXysc(sxyscName1);
			String bssj1 = object.getBssj1() + ":00";
			object.setBssj(DateUtil.parseDate(bssj1));
			getBaseDao().updateNotNull(object);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_SSRC,
					Constants.LOG_ACTION_UPDATE);
		}
		action.setParameter("xxjsrName", xxjsrName);
		action.setParameter("sxyscName", sxyscName);
		action.setParameter("sxyscName1", sxyscName1);
		String syxz = action.getParameter("sfxz");// 保存并新增按钮
		if ("1".equals(syxz)) {
			//action.setTsportSsrc(null);
			//openCreate(myaction);
			//保留上次新增的数据 便于添加
			object.setWid("");
			action.setTsportSsrc(object);
		}
		action.setListDate(null);
		action.getListDate();
		
		//刷新缓存--首页日历比赛场次
		BaseActionAbstractSupport.setListDate(null);
		
	}

	// public void xmjdsz(Object myaction) throws Exception{
	//		 
	// }
	// //用于批量修改赛程信息
	public void submitXmjdsz(Object myaction) throws Exception {
		SportSsrcAction action = (SportSsrcAction) myaction;
		TSportSsrc tsportSsrc = action.getTsportSsrc();
		if ((tsportSsrc.getBssj() == null) && StringUtils.isBlank(tsportSsrc.getScbm())
				&& StringUtils.isBlank(tsportSsrc.getBscd()) && StringUtils.isBlank(tsportSsrc.getCjdw())
				&& (tsportSsrc.getDjjd() == null)) {

			throw new Exception("操作失败,设置赛程不能都为空!");
		} else {// 设置要修改字段的值
			int i = 0;
			StringBuffer sqlColumn = new StringBuffer("update t_sport_ssrc a set ");
			if (tsportSsrc.getBssj() != null) {
				i++;
				sqlColumn.append(" a.bssj =to_date('" + DateUtil.formatDate(tsportSsrc.getBssj())
						+ "','yyyy-mm-dd hh24:mi:ss')");
			}
			if (StringUtils.isNotBlank(tsportSsrc.getScbm())) {
				if (i > 0) {
					sqlColumn.append(" ,a.scbm ='" + tsportSsrc.getScbm()+"' ");
				} else {
					sqlColumn.append(" a.scbm ='" + tsportSsrc.getScbm()+"' ");
				}
				i++;
			}
			if (StringUtils.isNotBlank(tsportSsrc.getBscd())) {
				if (i > 0) {
					sqlColumn.append(", a.bscd ='" + tsportSsrc.getBscd()+"' ");
				} else {
					sqlColumn.append(" a.bscd ='" + tsportSsrc.getBscd()+"' ");
				}
				i++;
			}
			if (StringUtils.isNotBlank(tsportSsrc.getCjdw())) {
				if (i > 0) {
					sqlColumn.append(", a.cjdw ='" + tsportSsrc.getCjdw()+"' ");
				} else {
					sqlColumn.append(" a.cjdw ='" + tsportSsrc.getCjdw()+"' ");
				}
				i++;
			}
			if (tsportSsrc.getDjjd() != null) {
				if (i > 0) {
					sqlColumn.append(" ,a.djjd ='" + tsportSsrc.getDjjd()+"' ");
				} else {
					sqlColumn.append(" a.djjd ='" + tsportSsrc.getDjjd()+"' ");
				}
			}
			// 下面是拼接查询条件
			String sql = " where  1=1 ";
			if (tsportSsrc != null) {
				if (StringUtils.isNotBlank(tsportSsrc.getDxmmc())) {
					sql += " and a.xmbm in (select wid from T_Sport_Bsxm where dxmmc = '" + tsportSsrc.getDxmmc()
							+ "') ";
				}
				if (StringUtils.isNotBlank(tsportSsrc.getXxmmc())) {
					sql += " and a.xmbm in (select wid from T_Sport_Bsxm where xxmmc='" + tsportSsrc.getXxmmc() + "') ";
				}
				if (StringUtils.isNotBlank(tsportSsrc.getZb())) {
					sql += " and a.xmbm in (select wid from T_Sport_Bsxm where zb='" + tsportSsrc.getZb() + "') ";
				}
				if (StringUtils.isNotBlank(tsportSsrc.getXbz())) {
					sql += " and a.xmbm in (select wid from T_Sport_Bsxm where xbz='" + tsportSsrc.getXbz() + "') ";
				}
				if (StringUtils.isNotBlank(tsportSsrc.getScbmQuery())) {
					sql += " and a.xmbm in (select wid from T_Sport_Bsxm where scbm='" + tsportSsrc.getScbmQuery()
							+ "') ";
				}
				if (StringUtils.isNotBlank(tsportSsrc.getBpfz())) {
					sql += " and a.xmbm in (select wid from T_Sport_Bsxm where bpfz='" + tsportSsrc.getBpfz() + "') ";
				}
			}
			if (StringUtils.isNotBlank(action.getParameter("startTime"))
					&& StringUtils.isNotBlank(action.getParameter("endTime"))) {
				sql += " and a.bssj between  to_date('" + action.getParameter("startTime")
						+ "','yyyy-MM-dd HH24:mi') and to_date('" + action.getParameter("endTime")
						+ "','yyyy-MM-dd HH24:mi')";
				action.setParameter("startTime", action.getParameter("startTime"));
				action.setParameter("endTime", action.getParameter("endTime"));
			}
			sql = sqlColumn + sql;
			boolean success = DBUtil.executeSQL(sql) > 0;
			if (success) {
				//刷新缓存--首页日历比赛场次
				BaseActionAbstractSupport.setListDate(null);
				BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_SSRC,
						Constants.LOG_ACTION_UPDATE);
			}
		}
		throw new Exception("操作成功");
	}
}
