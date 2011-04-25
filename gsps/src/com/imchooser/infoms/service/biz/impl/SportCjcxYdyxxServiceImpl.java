package com.imchooser.infoms.service.biz.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.action.biz.SportCjcxYdyxxAction;
import com.imchooser.infoms.entity.biz.TSportCjYdy;
import com.imchooser.infoms.entity.biz.TSportYdyxx;

/**
 * 运动员基本信息维护，包括以此运动员为主线查看相关成绩分布
 * 
 * @author Yangjianliang
 * datetime 2010-5-6
 */
public class SportCjcxYdyxxServiceImpl extends BaseServiceAbstractSupport{

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportCjcxYdyxxAction action =(SportCjcxYdyxxAction) myaction;
		TSportYdyxx tsportYdyxx=action.getTsportYdyxx();
		String hqlcolumn = " select new TSportYdyxx(a.wid,(select c.departname from TSysDepart c where c.departid=a.yddbm ) as yddbm," +
				" a.xm,a.sfzh,a.zch,a.state,(select replace(t.departname,'市','') from TSysDepart t  where t.departid =a.xyjfdq1) as xyjfdqName1," +
				" (select replace(t.departname,'市','') from TSysDepart t  where t.departid =a.xyjfdq3) as xyjfdqName3," +
				" (select replace(t.departname,'市','') from TSysDepart t  where t.departid =a.xyjfdq7) as xyjfdqName7," +
				" (select replace(t.departname,'市','') from TSysDepart t  where t.departid =a.xyjfdq2) as xyjfdqName2," +
				" (select replace(t.departname,'市','') from TSysDepart t  where t.departid =a.xyjfdq5) as xyjfdqName5," +
				" (select t.departname from TSysDepart t  where t.departid =a.xyjfdq4) as xyjfdqName4 ) ";
        String hql = " from TSportYdyxx a where 1=1 ";
		if (tsportYdyxx != null) {
			if (StringUtils.isNotBlank(tsportYdyxx.getXm())) {
				hql +=(" and a.xm like '%" + tsportYdyxx.getXm() + "%' ");
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getSfzh())) {
				hql += " and a.sfzh like '%" + tsportYdyxx.getSfzh() + "%' ";
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getYddbm())) {
				hql += "  and a.yddbm in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getYddbm() + "%') ";
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getZch())) {
				hql +=(" and a.zch like '%" + tsportYdyxx.getZch() + "%' ");
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName1())) {
				hql += "  and a.xyjfdq1 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName1() + "%') ";
			}
			if(StringUtils.isNotBlank(tsportYdyxx.getXyjfdq2isorno())){
				if("0".equals(tsportYdyxx.getXyjfdq2isorno())){
					hql += "  and a.xyjfdq2 in (select s.departid from TSysDepart s where s.departname is null) ";
				}else if("1".equals(tsportYdyxx.getXyjfdq2isorno())){
					if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName2())){
						hql += "  and a.xyjfdq2 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName2() + "%' and s.departname is not null) ";
					}else{
						hql += "  and a.xyjfdq2 in (select s.departid from TSysDepart s where s.departname is not null) ";
					}
				}
				if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName2())) {
					hql += "  and a.xyjfdq2 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName2() + "%') ";
				}
			}
			if(StringUtils.isNotBlank(tsportYdyxx.getXyjfdq7isorno())){
				if("0".equals(tsportYdyxx.getXyjfdq7isorno())){
					hql += "  and a.xyjfdq7 in (select s.departid from TSysDepart s where s.departname is null) ";
				}else if("1".equals(tsportYdyxx.getXyjfdq7isorno())){
					if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName7())){
						hql += "  and a.xyjfdq7 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName7() + "%' and s.departname is not null) ";
					}else{
						hql += "  and a.xyjfdq7 in (select s.departid from TSysDepart s where s.departname is not null) ";
					}
				}
				if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName7())) {
					hql += "  and a.xyjfdq7 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName7() + "%') ";
				}
			}
			if(StringUtils.isNotBlank(tsportYdyxx.getXyjfdq4isorno())){
				if("0".equals(tsportYdyxx.getXyjfdq4isorno())){
					hql += "  and a.xyjfdq4 in (select s.departid from TSysDepart s where s.departname is null) ";
				}else if("1".equals(tsportYdyxx.getXyjfdq4isorno())){
					if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName4())){
						hql += "  and a.xyjfdq4 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName4() + "%' and s.departname is not null) ";
					}else{
						hql += "  and a.xyjfdq4 in (select s.departid from TSysDepart s where s.departname is not null) ";
					}
				}
				if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName4())) {
					hql += "  and a.xyjfdq4 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName4() + "%') ";
				}
			}
			if(StringUtils.isNotBlank(tsportYdyxx.getXyjfdq3isorno())){
				if("0".equals(tsportYdyxx.getXyjfdq3isorno())){
						hql += "  and a.xyjfdq3 in (select s.departid from TSysDepart s where s.departname is null) ";
				}else if("1".equals(tsportYdyxx.getXyjfdq3isorno())){
					if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName3())) {
						hql += "  and a.xyjfdq3 in (select s.departid from TSysDepart s where s.departname like '%"
								+ tsportYdyxx.getXyjfdqName3() + "%' and s.departname is not null) ";
					}else{
						hql += "  and a.xyjfdq3 in (select s.departid from TSysDepart s where s.departname is not null) ";
					}
				}
			}else{
				if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName3())) {
					hql += "  and a.xyjfdq3 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName3() + "%') ";
				}
			}
			if(StringUtils.isNotBlank(tsportYdyxx.getXyjfdq5isorno())){
				if("0".equals(tsportYdyxx.getXyjfdq5isorno())){
					hql += "  and a.xyjfdq5 in (select s.departid from TSysDepart s where s.departname is null) ";
				}else if("1".equals(tsportYdyxx.getXyjfdq5isorno())){
					if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName5())){
						hql += "  and a.xyjfdq5 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName5() + "%' and s.departname is not null) ";
					}else{
						hql += "  and a.xyjfdq5 in (select s.departid from TSysDepart s where s.departname is not null) ";
					}
				}
				if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName5())) {
					hql += "  and a.xyjfdq5 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName5() + "%') ";
				}
			}
		}
		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + " order by a.wid desc ";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	public void load(Object myaction) throws Exception {
		SportCjcxYdyxxAction action =(SportCjcxYdyxxAction) myaction;
		String wid = action.getWid();
//		String ydybm = action.getParameter("ydybm");
		String depardid = action.getUserLoginId();
		if(StringUtils.isNotBlank(depardid)){
			action.setParameter("departid", "1");
		}
		String hql = " select new TSportYdyxx (a.xm,a.zp,a.xb,a.sg,a.tz,a.zch," +
				"( select b.departname from TSysDepart b where b.departid = substr(a.yddbm,0,6) ) as yddbm)" +
				" from TSportYdyxx a where a.wid=? ";//个人信息
		String hql1 ="select distinct(c.dxmmc||'，'||c.xxmmc)" +
				" from T_Sport_Cj_Ydy c,T_Sport_Ydyxx t where c.ydybm=t.wid and t.wid= ? ";//赛前报名项目
		String hql2 ="select new TSportCjYdy((a.dxmmc||'，'||a.xxmmc)as bsxm,a.cj,a.mc,a.sfjtxm,(a.df+a.jjf)as df) " +
				     " from TSportCjYdy a  where a.ydybm= ? and ((a.df+a.jjf)is not null and (a.df+a.jjf)!=0)";//本届赛会得牌得分
		String hql3 = "select (select m.zdmc from t_sys_code m where m.zdlb='MX_DFLX'and m.zdbm=t.dflx)as dflx, " +
				" t.dbtmc,t.yddmc,t.dxmmc,t.xxmmc,t.mc,(t.jps+t.jjjps)as jps,(t.yps+t.jjyps)as yps,(t.tps+t.jjtps)as tps,(t.df+t.jjf)as df " +
				" from  t_sport_cj_zs_mx t where t.shzt='1' and t.dflx!='1' and t.dfly like ? and((t.df+t.jjf)is not null and (t.df+t.jjf)!=0)";
				//登录后可见，计入输送单位（代表团和区县）得分得牌
		
		TSportYdyxx tsportYdyxx = (TSportYdyxx) getBaseDao().findFieldValue(hql, wid);//个人信息
		action.setTsportYdyxx(tsportYdyxx);
		
		List<?> list = DBUtil.queryAllList(hql1, wid); //赛前报名项目
		action.setParameter("result", list);

		List<TSportCjYdy> list1 = getBaseDao().findByHql(hql2, wid);//本届赛会得牌得分
		action.setParameter("result1", list1);
		
		if(StringUtils.isNotBlank(action.getUserLoginId())){//登录后可见，计入输送单位（代表团和区县）得分得牌
		    List<?> list2 = DBUtil.queryAllList(hql3,"%"+wid+"%");
		    action.setParameter("result2", list2);
		}
			
	}

	public boolean remove(Object myaction) throws Exception {
		SportCjcxYdyxxAction action =(SportCjcxYdyxxAction) myaction;
		String wid = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TSportYdyxx", "wid", "=", wid);
		return deleteSuccess;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		SportCjcxYdyxxAction action=(SportCjcxYdyxxAction)myaction;
		TSportYdyxx tsportYdyxx=action.getTsportYdyxx();
		
		if(StringUtils.isBlank(tsportYdyxx.getWid())){
			Date date = new Date();
			tsportYdyxx.setWid(SeqFactory.getNewSequenceAlone());
			tsportYdyxx.setCreatetime(date);
			getBaseDao().save(tsportYdyxx);
		}else{
			getBaseDao().updateNotNull(tsportYdyxx);
		}
		String syxz = action.getParameter("sfxz");// 保存并新增按钮
		if ("1".equals(syxz)) {
			action.setTsportYdyxx(null);
			openCreate(myaction);
		}

     }
}