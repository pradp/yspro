package com.yszoe.sys.service.impl;

import java.util.List;

import com.yszoe.framework.identity.entity.TSysUser;
import com.yszoe.framework.service.impl.BaseServiceAbstractSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.sys.action.userExtAction;

/**
 * 管理员管理会员基本信息
 * @author wangxianchao datetime 2010-2-16
 */
public class userExtServiceImpl extends BaseServiceAbstractSupport{

	public List<?> list(Object myaction, Pager pager) throws Exception {
		userExtAction action = (userExtAction) myaction;
		TSysUser tsysUser = action.getTsysUser();
		String hqlcolumn = "select new TSysUser(t.userid,t.userloginid,t.username,t.state," +
				"( select y.cgmc from TQmjsCgxx y " +
				"where y.wid=(select x.zxdlwid from TQmjsCgxx x " +
				"where x.wid=(select a.cgid from TQmjsHydlHyxx a where a.userid=t.userloginid )) as cgmc ) ";
		
		String hql = " from TSysUser t where t.state!=0";
		if (tsysUser == null) {//做初始化数据处理
//			bbnd = CommonQuery.getSysProperty(Constants.SYS_PROPERTY_GZZZSBND);
//			tgzZfzxj = new TGzZfzxj();
//			tgzZfzxj.setBbnd(bbnd);
//			action.setTgzZfzxj(tgzZfzxj);
		} else {
//			if (tsysDeaprt.getYdxm() != null && !"".equals(tsysDeaprt.getYdxm())) {
//				hql += " and t.ydxm  = '" + tqmjsCgyd.getYdxm() + "'";
//			}
//			if (tqmjsCgyd.getYdrq() != null && !"".equals(tqmjsCgyd.getYdrq())) {
//				hql += " and t.ydrq  = '" + tqmjsCgyd.getYdrq() + "'";
//			}
//			if (tqmjsCgyd.getYdcd() != null && !"".equals(tqmjsCgyd.getYdcd())) {
//				hql += " and t.ydcd  = '" + tqmjsCgyd.getYdcd() + "'";
//			}
//			if (tqmjsCgyd.getYdsf() != null && !"".equals(tqmjsCgyd.getYdsf())) {
//				hql += " and t.ydsf  = '" + tqmjsCgyd.getYdsf() + "'";
//			}
		} 
		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql;
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	/**
	 * 返回会员的基本信息
	 */
	public void load(Object myaction) throws Exception {
		userExtAction action = (userExtAction)myaction;
		
		String userid = action.getWid();
		
		String sqlHydl = "select wid,userid,mmbhwt,wtda,dzyx,xgcs"
			+ ",sfzx,hyjf,createtime,(select usertype from t_sys_user t  where t.userloginid = q.userid) as usertype from T_Qmjs_Hydl q where userid ='"
			+userid + "'";
		
		String sqlHyxx = "select * from T_Qmjs_Hydl_Hyxx where userid ='"
			+ userid + "'";
		
		String sql ="select usertype from t_sys_user where userloginid='"+userid+"'";
		String usertype = (String)DBUtil.queryFieldValue(sql);
		
		action.setUsertype(usertype);
		
	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	/**
	 * 保存修改的信息
	 */
	public void saveOrUpdate(Object myaction) throws Exception {
		userExtAction action = (userExtAction)myaction;
		String usertype = action.getUsertype();
		String userid = action.getWid();
		
		String sql = "update t_sys_user set usertype='"+usertype+"' where userloginid='"+userid+"'";
		DBUtil.executeSQL(sql);
		
	}
	
}
