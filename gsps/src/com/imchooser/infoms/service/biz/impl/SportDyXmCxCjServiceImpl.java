package com.imchooser.infoms.service.biz.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportDyXmCxCjAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;

/**
 * 按项目查询成绩（打印）
 * 
 * @author Wangjunjun 2010-7-19
 */
public class SportDyXmCxCjServiceImpl extends BaseServiceAbstractSupport {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#list(java.lang.Object,
	 * com.imchooser.framework.util.Pager)
	 */
	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportDyXmCxCjAction action = (SportDyXmCxCjAction) myaction;
		TSportBsxm  bsxm = action.getBsxm();
		String xmmc = null;
		if(bsxm!=null){
			 xmmc = action.getBsxm().getDxmmc();
		}
		if(StringUtils.isNotBlank(xmmc)){
			xmmc = java.net.URLDecoder.decode(xmmc, "utf-8");
		}
		String sql = " select  k.departname, k.jps,k.yps,k.tps,k.zf,k.jpzs,rank() over( order by k.jps desc) as jpmc,"
				+ " rank() over( order by (k.jps+k.yps+k.tps) desc) as jppmc,"
				+ " rank() over( order by (k.zf) desc) as zfmc, k.departcode"
				+ " from (select  nvl(sum(t.jps+t.jjjps),0) as jps, nvl(sum(t.yps+t.jjyps),0) as yps , nvl(sum(t.tps+t.jjtps),0) as tps ,nvl(sum(t.df+t.jjf),0) as zf ,"
				+ " nvl(sum(t.jps+t.jjjps+t.yps+t.jjyps+t.tps+t.jjtps),0) as jpzs, max(c.departname) departname, max(c.departcode) departcode  from t_sys_depart c left join  t_sport_cj_td_mx t on t.departid=c.departid ";
		String sql_hz = " select nvl(sum(k.jps),0),nvl(sum(k.yps),0),nvl(sum(k.tps),0),nvl(sum(k.zf),0),nvl(sum(k.jpzs),0) "
			+ " from (select  nvl(sum(t.jps+t.jjjps),0) as jps, nvl(sum(t.yps+t.jjyps),0) as yps , nvl(sum(t.tps+t.jjtps),0) as tps ,nvl(sum(t.df+t.jjf),0) as zf ,"
			+ " nvl(sum(t.jps+t.jjjps+t.yps+t.jjyps+t.tps+t.jjtps),0) as jpzs, max(c.departname) departname, max(c.departcode) departcode  from t_sys_depart c left join  t_sport_cj_td_mx t on t.departid=c.departid ";
		
		if (StringUtils.isNotBlank(xmmc)) {
			sql += " and t.dxmmc='" + xmmc + "' ";
			sql_hz += " and t.dxmmc='" + xmmc + "' ";
		}
		sql += "  where  c.updepartid='320' group by c.departid,c.departcode order by c.departcode) k order by k.departcode";
		sql_hz += "  where  c.updepartid='320' group by c.departid,c.departcode order by c.departcode) k order by k.departcode";
		List<?> list = DBUtil.queryAllList(sql);
		List<?> list_hz = DBUtil.queryAllList(sql_hz);
		//汇总数据
		action.setParameter("listHz", list_hz);
		//用于页面打印 标题  中是  ”按排球查询成绩“
		action.setParameter("xmmc", xmmc);
		
		//用于显示打印时间
		Date date = new  Date();
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

}
