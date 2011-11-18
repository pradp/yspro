package com.yszoe.biz.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.biz.Constants;
import com.yszoe.biz.action.ExpertqaExpertsAction;
import com.yszoe.biz.entity.TExpertqaExperts;
import com.yszoe.biz.service.ExpertqaExpertsService;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.identity.action.IdUserAction;
import com.yszoe.identity.entity.TSysDepart;
import com.yszoe.identity.entity.TSysUser;
import com.yszoe.identity.entity.TSysUserGroup;
import com.yszoe.identity.service.IdUserService;
import com.yszoe.util.StringUtil;

/**
 * 管理员维护专家资料
 * 
 * @author chenlu
 * datetime 2011-8-22
 */
public class ExpertqaExpertsImpl extends AbstractBaseServiceSupport implements ExpertqaExpertsService  {

	private static final Log LOG = LogFactory.getLog(ExpertqaExpertsImpl.class);
	
	private IdUserService idUserService ;

	public IdUserService getIdUserService() {
		return idUserService;
	}

	public void setIdUserService(IdUserService idUserService) {
		this.idUserService = idUserService;
	}

	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		ExpertqaExpertsAction action = (ExpertqaExpertsAction) myaction;
		TExpertqaExperts expertqaExperts = action.getTexpertqaExperts();
		String sqlColumn = "select t.wid,t.userid,t.name,t.sex,(select zdmc from t_sys_code where zdlb='sort_id' and zdbm=t.sort_id) as sortId,t.email,t.memo,t.photo,t.isshowprivate," 
						  + " t.relationmethod,t.telnum,t.mobilenum,t.submitnum,t.solved,t.unit,t.identity,t.position,t.fax,t.lxdz,t.yzbm," 
						  + " t.jianjie,t.gzly,t.sx";
		String sql = " from t_expertqa_experts t where 1=1 ";
		if (null != expertqaExperts) {
			if (StringUtils.isNotBlank(expertqaExperts.getUserid())) {
				sql += " and t.userid='" + expertqaExperts.getUserid() + "'";
			}
			if (StringUtils.isNotBlank(expertqaExperts.getName())) {
				sql += " and t.name='" + expertqaExperts.getName() + "'";
			}	
			if (StringUtils.isNotBlank(expertqaExperts.getSortId())) {
				sql += " and t.sort_id='" + expertqaExperts.getSortId() + "'";
			}
		}
		long c = DBUtil.count("select count(*) " + sql);
		pager.setTotalRows(c);
		sql = sqlColumn + sql + " order by t.wid";
		List<?> list = DBUtil.queryPageBeanList(pager, sql, TExpertqaExperts.class);
		return list;
	}
	
	@Override
	public boolean remove(Object myaction) throws Exception {

		ExpertqaExpertsAction action = (ExpertqaExpertsAction) myaction;		
		String userid = action.getWid();
		String hql = "select count(*) from TExpertqaAppeal where accepter=?";
		long i = getBaseDao().count(hql, userid);
		if (i > 0) {
			// 登录账户不允许重复
			throw new Exception("该专家已经有人提问，请先删除相关提问信息，或者禁用账号！");
		}
		IdUserAction useraction = new IdUserAction();
		useraction.setParameter("wid", userid);
		useraction.setUser(action.getLoginuser());
		idUserService.remove(useraction);
		boolean f = getBaseDao().deleteAll("TExpertqaExperts", "userid", "=", userid);		
		return f;
	}
	
	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
		ExpertqaExpertsAction action = (ExpertqaExpertsAction) myaction;	
		TExpertqaExperts expertqaExperts = action.getTexpertqaExperts();
		TSysUser tsysuser =new TSysUser();
		TSysUserGroup tsysuserGroup =new TSysUserGroup();
		TSysDepart depart=new TSysDepart();
		if(StringUtil.isBlank(expertqaExperts.getWid())){
			//do insert
			String hql = "select count(*) from TSysUser where userloginid=?";
			long i = getBaseDao().count(hql, expertqaExperts.getUsername());
			if (i > 0) {
				// 登录账户不允许重复
				throw new Exception("登录账号已经存在，请更换其他账号！");
			}
			expertqaExperts.setWid(SeqFactory.getNewSequenceAlone());
			//添加登记用户信息
			tsysuser.setUserloginid(expertqaExperts.getUsername());
			tsysuser.setUserpwd(expertqaExperts.getPasswd());
			tsysuser.setUsername(expertqaExperts.getName());
			tsysuser.setUsertype("1");//1表示专家
			tsysuser.setUserid(SeqFactory.getNewSequenceAlone());
			tsysuser.setState(Constants.EXPERTSTATE);
			depart.setDepartid(Constants.USERDEPART);
			tsysuser.setDepart(depart);
			//添加登记用户用户组信息
			tsysuserGroup.setGroupid(Constants.EXPERTTEAM);
			tsysuserGroup.setId(SeqFactory.getNewSequenceAlone());
			tsysuserGroup.setUserid(tsysuser.getUserid());

			getBaseDao().save(tsysuser);//先创建用户账户
			expertqaExperts.setUserid(tsysuser.getUserid());
			getBaseDao().save(expertqaExperts);//再创建专家信息
			getBaseDao().save(tsysuserGroup);//最后分配权限
		}else{
			//do update
			getBaseDao().updateNotNull(expertqaExperts);
		}		
	}
	public void openCreate(Object myaction) throws Exception {
		ExpertqaExpertsAction action = (ExpertqaExpertsAction) myaction;			
		TExpertqaExperts bean = action.getTexpertqaExperts();
		if (null == bean) {
			bean = new TExpertqaExperts();			
		}
		action.setTexpertqaExperts(bean);
	}
	
	@Override
	public void load(Object myaction) throws Exception {
		ExpertqaExpertsAction action = (ExpertqaExpertsAction) myaction;
		String wid = action.getWid();
		TExpertqaExperts texpertqaExperts = getBaseDao().findBean("from TExpertqaExperts where USERID=?", wid);
		String hql = "select userloginid from TSysUser where userid=?";
		texpertqaExperts.setUsername( (String)getBaseDao().findFieldValue(hql, texpertqaExperts.getUserid()) );
		action.setTexpertqaExperts(texpertqaExperts);		
	}

	@Override
	public boolean checkusername(Object myaction) {
		ExpertqaExpertsAction action = (ExpertqaExpertsAction) myaction;
		String userloginid = action.getParameter("username");
		String sql = " from t_sys_user where userloginid ='"+userloginid+"'";
		long c=0l;
		try {
			c = DBUtil.count("select count(*) " + sql);
		} catch (SQLException e) {
			LOG.error(e);
		}
		return c==0 ;
	}
	@Override
	public boolean checkemail(Object myaction) {
		ExpertqaExpertsAction action = (ExpertqaExpertsAction) myaction;
		String email = action.getParameter("email");
		String username = action.getParameter("username");
		String sql = " from t_expertqa_experts where email ='"+email+"'";
		if (StringUtil.isNotBlank(username)){
			//TODO 字符串能比较大小？
//			sql+=" and (username>'"+username+"' or username<'"+username+"')";
		}
		long c=0l;
		try {
			c = DBUtil.count("select count(*) " + sql);
		} catch (SQLException e) {
			LOG.error(e);
		}
		return c==0 ;
	}
	
}
