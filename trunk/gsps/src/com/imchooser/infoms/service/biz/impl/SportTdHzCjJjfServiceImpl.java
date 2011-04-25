package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.action.biz.SportTdHzCjJjfAction;
import com.imchooser.infoms.entity.biz.TSportCjTdSxJjfMx;

/**
 * 
 * @author LiuHaiDong
 * 2010-5-4
 */
public class SportTdHzCjJjfServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportTdHzCjJjfAction action =(SportTdHzCjJjfAction) myaction;
		String type = action.getParameter("type");
		action.setParameter("type", type);
		String sqlcolumn ="";
		String sql = "";
		if ("td".equals(type)){
			sqlcolumn = "  select b.departid,b.departname,nvl(a.jjf,0) as jjf,nvl(a.jjjps,0) as jjjps,nvl(a.jjyps,0) as jjyps,nvl(a.jjtps,0) as jjtps,a.bz " ;	
			sql = " from t_sys_depart b left join t_sport_cj_td_sx_jjf a  on b.departid=a.departid where  b.departtype='2' ";
		}else if ("sx".equals(type)){
			sqlcolumn = "  select b.departid,b.departname,nvl(a.jjf,0) as jjf,nvl(a.jjjps,0) as jjjps,nvl(a.jjyps,0) as jjyps,nvl(a.jjtps,0) as jjtps,a.bz ";
			sql = " from t_sys_depart b left join t_sport_cj_td_sx_jjf a  on b.departid=a.departid where (b.departtype='3' or  b.departtype='4') ";
		}
		String departidcx = action.getParameter("departidcx");
		if (StringUtils.isNotBlank(departidcx)) {
			sql += " and b.departname like '%" + action.getParameter("departidcx") + "%' ";
			action.setParameter("departidcx", action.getParameter("departidcx"));
		}
		long c = DBUtil.count("select count(*) as c " + sql);
		sql = sqlcolumn + sql + " order by b.departid ";
		pager.setTotalRows(c);
		List<?> list =DBUtil.queryPageList(pager, sql);
		return list;
	}

	public void load(Object myaction) throws Exception {
		SportTdHzCjJjfAction action =(SportTdHzCjJjfAction) myaction;
		List<TSportCjTdSxJjfMx> tsportCjJjfMx = action.getTsportCjJjfMx();
		String departid = action.getWid();
		String hql = " from TSportCjTdSxJjfMx a where a.departid=? ";
		tsportCjJjfMx = getBaseDao().findByHql(hql, departid);
		action.setParameter("depart1", departid);
		action.setTsportCjJjfMx(tsportCjJjfMx);
	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}
	/**
	 * 加减金银牌及分删除空行
	 * 
	 * @param src
	 * @return
	 * @throws Exception
	 */
	protected List<TSportCjTdSxJjfMx> removeJJFNullElement1(List<TSportCjTdSxJjfMx> src) throws Exception {
		for (int i = 0; i < src.size(); i++) {
			TSportCjTdSxJjfMx d = (TSportCjTdSxJjfMx) src.get(i);
			if (src.get(i) == null || (src.get(i) != null && d.getJjf()==null)) {
				src.remove(i);
				i--;
			}else if(src.get(i) == null || (src.get(i) != null && d.getJjjps()==null)){
				src.remove(i);
				i--;
			}else if(src.get(i) == null || (src.get(i) != null && d.getJjyps()==null)){
				src.remove(i);
				i--;
			}else if(src.get(i) == null || (src.get(i) != null && d.getJjtps()==null)){
				src.remove(i);
				i--;
			}
		}
		return src;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		SportTdHzCjJjfAction action = (SportTdHzCjJjfAction)myaction;
		List<TSportCjTdSxJjfMx> tsportCjJjfMx = action.getTsportCjJjfMx();
		String departid = action.getParameter("depart1");
		if(tsportCjJjfMx!=null){
			tsportCjJjfMx = removeJJFNullElement1(tsportCjJjfMx);
		}
		getBaseDao().executeHql("delete from TSportCjTdSxJjfMx a where a.departid=?",departid);// 加减金银牌及分删除空行信息
			for (int i = 0; i < tsportCjJjfMx.size(); i++) {
				TSportCjTdSxJjfMx jjf = tsportCjJjfMx.get(i);
				if (jjf.getWid() == null || "".equals(jjf.getWid())) {
					jjf.setWid(SeqFactory.getNewSequenceAlone());// 流水号，主键
				}
				jjf.setDepartid(departid);
			}
		getBaseDao().saveAll(tsportCjJjfMx);
		getBaseDao().executeHql("update TSportCjTdSxJjf a set a.jjf=(select sum(t.jjf) from TSportCjTdSxJjfMx t where t.departid=?)," +
				" a.jjjps=(select sum(t.jjjps) from TSportCjTdSxJjfMx t where t.departid=?)," +
				" a.jjyps=(select sum(t.jjyps) from TSportCjTdSxJjfMx t where t.departid=?)," +
				" a.jjtps=(select sum(t.jjtps) from TSportCjTdSxJjfMx t where t.departid=?) where a.departid=?",departid,departid,departid,departid,departid);//更新主表的加减分
		action.setParameter("depart1", departid);
		action.setTsportCjJjfMx(tsportCjJjfMx);
	}

}
