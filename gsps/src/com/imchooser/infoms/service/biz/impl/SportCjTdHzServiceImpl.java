package com.imchooser.infoms.service.biz.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportCjTdHzAction;

/**
 * 团队成绩汇总表(网站首页显示)
 * 
 * @author DaiQinggao
 * @date 2010-4-2
 * 
 */
public class SportCjTdHzServiceImpl extends BaseServiceAbstractSupport {

	@SuppressWarnings("unchecked")
	public List list(Object myaction, Pager pager) throws Exception {
		SportCjTdHzAction action = (SportCjTdHzAction) myaction;
		// 金牌榜
		String jpbSql = "select rank() over(order by a.jps+b.jjjps desc,a.yps+b.jjyps desc,a.tps+b.jjtps desc),replace(a.dbtmc,'市',''),nvl((a.jps+nvl( b.jjjps, 0)),0) as jps," +
				"nvl((a.yps+nvl(b.jjyps,0)),0) as yps," +
				"nvl((a.tps+nvl(b.jjtps,0)),0) as tps,a.departid ," +
				"nvl((a.jps+a.yps+a.tps+nvl(b.jjjps+b.jjyps+b.jjtps,0)),0) as hj" +
				" from  t_sport_cj_td_hz a left join t_sport_cj_td_sx_jjf b on a.departid=b.departid where a.hzlx='1' ";
//		String jpbSql = "select a.dbtmc,nvl((a.jps+a.jjjps),0) as jps,nvl((a.yps+a.jjyps),0) as yps,nvl((a.tps+a.jjtps),0) as tps,a.departid ,nvl((a.jps+a.yps+a.tps+a.jjjps+a.jjyps+a.jjtps),0) as hj" +
//        " from  t_sport_cj_td_hz a  where a.hzlx='1' order by jps desc";
		// 奖牌榜 
		String sumSql = " select rank() over(order by (nvl(b.jjjps+b.jjyps+b.jjtps,0)+a.jps+a.yps+a.tps) desc,a.jps+b.jjjps desc,a.yps+b.jjyps desc,a.tps+b.jjtps desc) as mc," +
				"replace(a.dbtmc,'市',''),nvl((a.jps+nvl(b.jjjps,0)),0) as jps,nvl((a.yps+nvl(b.jjyps,0)),0) as yps," +
				"nvl((a.tps+nvl(b.jjtps,0)),0) as tps,a.departid," +
				"nvl((a.jps+a.yps+a.tps+nvl(b.jjjps+b.jjyps+b.jjtps,0)),0) as hj" +
				" from  t_sport_cj_td_hz a left join t_sport_cj_td_sx_jjf b on a.departid=b.departid where a.hzlx='2' ";
//		String sumSql = "select a.mc,a.dbtmc,nvl((a.jps+a.jjjps),0) as jps,nvl((a.yps+a.jjyps),0) as yps,nvl((a.tps+a.jjtps),0) as tps,a.departid,nvl((a.jps+a.yps+a.tps+a.jjjps+a.jjyps+a.jjtps),0) as hj " +
//				        " from  t_sport_cj_td_hz a  where a.hzlx='2' order by a.mc ";
		// 江苏优势项目积分榜
		String jfbSql = "select rank() over(order by a.df+nvl(b.jjf,0) desc,(nvl(b.jjjps+b.jjyps+b.jjtps,0)+a.jps+a.yps+a.tps) desc,a.jps+b.jjjps desc,a.yps+b.jjyps desc,a.tps+b.jjtps desc)," +
				"replace(a.dbtmc,'市',''),nvl((a.df+nvl(b.jjf,0)),0) as jf,a.departid " +
				"from t_sport_cj_td_hz a left join t_sport_cj_td_sx_jjf b on a.departid=b.departid where a.hzlx='3' ";
//		String jfbSql = "select a.dbtmc,nvl((a.df+a.jjf),0) as jf,a.departid " +
//				        " from t_sport_cj_td_hz a  where a.hzlx='3'  order by jf desc";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		action.setParameter("bssj", sdf.format(new Date()));
		List list_jpb = DBUtil.queryAllList(jpbSql);
		List list_sum = DBUtil.queryAllList(sumSql);
		List list_jfb = DBUtil.queryAllList(jfbSql);
		action.setParameter("list_jpb", list_jpb);
		action.setParameter("list_sum", list_sum);
		action.setParameter("list_jfb", list_jfb);
		return null;
	}

	public void load(Object arg0) throws Exception {

	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {

	}

}
