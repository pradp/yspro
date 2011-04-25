package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportCjcxNbbdAction;

/**
 * 
 * @author LiuHaiDong
 * 2010-4-23
 */
public class SportCjcxNbbdServiceImpl extends BaseServiceAbstractSupport  {


	/* (non-Javadoc)
	 * @see com.imchooser.framework.service.BaseService#list(java.lang.Object, com.imchooser.framework.util.Pager)
	 */
	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportCjcxNbbdAction action = (SportCjcxNbbdAction) myaction;
		// 金牌榜
		String jpbSql = "select rank() over(order by jp.jps desc,jp.yps desc,jp.tps desc) as mc,jp.*,(jp.jps+jp.yps+jp.tps) as hj from (" +
						"select replace(b.departname,'市',''),b.departid," +
						"nvl((nvl(sum(a.df+a.jjf),0) + nvl(h.zfhj,0) + nvl(j.jjf,0) ),0) as df," +
						"nvl((nvl(sum(a.jps+a.jjjps),0) + nvl(h.jphj,0) + nvl(j.jjjps,0) ),0) as jps," +
						"nvl((nvl(sum(a.yps+a.jjyps),0) + nvl(j.jjyps,0) ),0) as yps," +
						"nvl((nvl(sum(a.tps+a.jjtps),0) + nvl(j.jjtps,0) ),0) as tps " +
						"from t_sys_depart b join t_sport_drcjb h on b.departid=h.yddbm join t_sport_cj_td_sx_jjf j on j.departid=b.departid " +
						"left join T_Sport_Cj_Td_Mx a on b.departid=a.departid where b.departtype='2' " +
						"group by b.departid,b.departname,h.zfhj,h.jphj,j.jjf,j.jjjps,j.jjyps,j.jjtps ) jp ";
		
		// 奖牌榜
		String sumSql = "select rank() over(order by (jp.jps+jp.yps+jp.tps) desc,jp.jps desc,jp.yps desc,jp.tps desc) as mc,jp.*,(jp.jps+jp.yps+jp.tps) as hj from (" +
						"select replace(b.departname,'市',''),b.departid," +
						"nvl((nvl(sum(a.df+a.jjf),0) + nvl(h.zfhj,0) + nvl(j.jjf,0) ),0) as df," +
						"nvl((nvl(sum(a.jps+a.jjjps),0) + nvl(h.jphj,0) + nvl(j.jjjps,0) ),0) as jps," +
						"nvl((nvl(sum(a.yps+a.jjyps),0) + nvl(j.jjyps,0) ),0) as yps," +
						"nvl((nvl(sum(a.tps+a.jjtps),0) + nvl(j.jjtps,0) ),0) as tps " +
						"from t_sys_depart b join t_sport_drcjb h on b.departid=h.yddbm join t_sport_cj_td_sx_jjf j on j.departid=b.departid " +
						"left join T_Sport_Cj_Td_Mx a on b.departid=a.departid where b.departtype='2' " +
						"group by b.departid,b.departname,h.zfhj,h.jphj,j.jjf,j.jjjps,j.jjyps,j.jjtps ) jp";
		
		//总积分榜
		String jfbSql = "select rank() over(order by jp.df desc,(jp.jps+jp.yps+jp.tps) desc,jp.jps desc,jp.yps desc,jp.tps desc) as mc,jp.*,(jp.jps+jp.yps+jp.tps) as hj from (" +
						"select replace(b.departname,'市',''),b.departid," +
						"nvl((nvl(sum(a.df+a.jjf),0) + nvl(h.zfhj,0) + nvl(j.jjf,0) ),0) as df," +
						"nvl((nvl(sum(a.jps+a.jjjps),0) + nvl(h.jphj,0) + nvl(j.jjjps,0) ),0) as jps," +
						"nvl((nvl(sum(a.yps+a.jjyps),0) + nvl(j.jjyps,0) ),0) as yps," +
						"nvl((nvl(sum(a.tps+a.jjtps),0) + nvl(j.jjtps,0) ),0) as tps " +
						"from t_sys_depart b join t_sport_drcjb h on b.departid=h.yddbm join t_sport_cj_td_sx_jjf j on j.departid=b.departid " +
						"left join T_Sport_Cj_Td_Mx a on b.departid=a.departid where b.departtype='2' " +
						"group by b.departid,b.departname,h.zfhj,h.jphj,j.jjf,j.jjjps,j.jjyps,j.jjtps ) jp ";
		
		// 江苏优势项目积分榜
		String ysjfbSql = "select replace(x.departname,'市',''),x.departid,nvl(f.df,0) as dff " +
						"from t_sys_depart x left join (select a.departid as departid,sum(a.df) as df from t_sport_ssrc b,t_sport_bsxm c, T_Sport_Cj_Td_Mx a " +
						"where a.scbm=b.wid and c.wid=b.xmbm and c.xmdj='1' group by a.departid) f on f.departid=x.departid " +
						"where x.departtype='2' order by dff desc,x.departid ";

		
		List<?> list_jpb = DBUtil.queryAllList(jpbSql);
		List<?> list_sum = DBUtil.queryAllList(sumSql);
		List<?> list_jfb = DBUtil.queryAllList(jfbSql);
		List<?> list_ysjfb = DBUtil.queryAllList(ysjfbSql);
		action.setParameter("list_jpb", list_jpb);
		action.setParameter("list_sum", list_sum);
		action.setParameter("list_jfb", list_jfb);
		action.setParameter("list_ysjfb", list_ysjfb);
		return null;
	}

	/* (non-Javadoc)
	 * @see com.imchooser.framework.service.BaseService#load(java.lang.Object)
	 */
	public void load(Object arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.imchooser.framework.service.BaseService#remove(java.lang.Object)
	 */
	public boolean remove(Object arg0) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	/* (non-Javadoc)
	 * @see com.imchooser.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	public void saveOrUpdate(Object arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
