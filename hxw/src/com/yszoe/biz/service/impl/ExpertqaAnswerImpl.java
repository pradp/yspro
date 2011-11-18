package com.yszoe.biz.service.impl;


import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.biz.action.ExpertqaAnswerAction;
import com.yszoe.biz.entity.TExpertqaAppeal;
import com.yszoe.biz.entity.TExpertqaAppealadd;
import com.yszoe.biz.service.ExpertqaAnswerService;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.identity.IdConstants;
import com.yszoe.identity.entity.TSysUser;
import com.yszoe.util.StringUtil;

/**
 * 专家答疑
 * 
 * @author chenlu
 * datetime 2011-7-22
 */

public class ExpertqaAnswerImpl extends AbstractBaseServiceSupport implements ExpertqaAnswerService {

	// private static final Log LOG =
	// LogFactory.getLog(yourCurrentClassHere.class);

	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		ExpertqaAnswerAction action = (ExpertqaAnswerAction) myaction;
		TExpertqaAppeal expertqaAppeal = action.getTexpertqaAppeal();	
		String sqlColumn =" select t.wid,nvl2(translate(t.writer, '\\1234567890 ', '\\'), t.writer, u.username) as writer,t.identity,t.dateofinput,t.content,t.contact,(select zdmc from t_sys_code where zdlb='sort_id' and zdbm=t.sort_id) as sortId," 
						 +"t.relationtel,t.address,t.email,t.answer,t.ispublish,t.digest ,t.accepter,t.read,t.title,t.attach,t.dateofreply,t.replyexpert";
		String sql = " from t_expertqa_appeal t left join t_sys_user u on t.writer=u.userid where 1=1 ";
		TSysUser tsysuser=(TSysUser)action.getSession().getAttribute(IdConstants.SESSION_USER);
		sql += " and t.accepter='" + tsysuser.getUserid() + "'";
		if (null != expertqaAppeal) {
			if (StringUtils.isNotBlank(expertqaAppeal.getTitle())) {
				sql += " and t.title like '%" + expertqaAppeal.getTitle() + "%'";
			}			
			if (StringUtils.isNotBlank(expertqaAppeal.getWriter())) {
				sql += " and t.writer like '%" + expertqaAppeal.getWriter() + "%'";
			}	
			if (StringUtils.isNotBlank(expertqaAppeal.getSortId())) {
				sql += " and t.sort_id='" + expertqaAppeal.getSortId() + "'";
			}
		}
		long c = DBUtil.count("select count(*) " + sql);
		pager.setTotalRows(c);
		sql = sqlColumn + sql + " order by t.wid";
		List<?> list = DBUtil.queryPageBeanList(pager, sql, TExpertqaAppeal.class);
		return list;
	}
	
	@Override
	public boolean remove(Object myaction) throws Exception {
		ExpertqaAnswerAction action = (ExpertqaAnswerAction) myaction;
		String wid = action.getWid();
		boolean f = getBaseDao().deleteAll("TExpertqaAppealadd", "appealid", "=", wid);
		if(f){
			f = getBaseDao().deleteAll("TExpertqaAppeal", "wid", "=", wid);
		}
		return f;
	}
	
	
	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
		ExpertqaAnswerAction action = (ExpertqaAnswerAction) myaction;
		TExpertqaAppeal expertqaAppeal = action.getTexpertqaAppeal();
		expertqaAppeal = getBaseDao().findById(TExpertqaAppeal.class, expertqaAppeal.getWid());
		TSysUser tsysuser=(TSysUser)action.getSession().getAttribute(IdConstants.SESSION_USER);
		TExpertqaAppealadd expertqaAppealadd = action.getTexpertqaAppealadd();
		if(StringUtil.isBlank(expertqaAppealadd.getWid())){
			//do insert
			expertqaAppeal.setDateofreply(getTsByStr(new SimpleDateFormat("yyyy-MM-dd").format(new Date())));
			expertqaAppealadd.setWid(SeqFactory.getNewSequenceAlone());
			expertqaAppealadd.setAppealid(expertqaAppeal.getWid());			
			expertqaAppealadd.setDateofreply(expertqaAppeal.getDateofreply());				
			expertqaAppealadd.setExpertid(tsysuser.getUserid());
			getBaseDao().updateNotNull(expertqaAppeal);
			getBaseDao().save(expertqaAppealadd);
		}else{
			//do update
			getBaseDao().updateNotNull(expertqaAppealadd);
		}
	}

	@Override
	public void load(Object myaction) throws Exception {
		ExpertqaAnswerAction action = (ExpertqaAnswerAction) myaction;
		String wid = action.getWid();
		String sql = "select wid, (select username from t_sys_user u where u.userid=a.writer) as writer, identity, " +
				"dateofinput, content, contact, answer, ispublish, " +
				"(select username from t_sys_user u where u.userid=a.accepter) as accepter, title, dateofreply, replyexpert " +
				"from T_Expertqa_Appeal a where wid=? ";
		TExpertqaAppeal texpertqaAppeal = (TExpertqaAppeal)DBUtil.queryBean(sql, TExpertqaAppeal.class, wid);
//		TExpertqaAppeal texpertqaAppeal = getBaseDao().find(TExpertqaAppeal.class, wid);
		String sqlColumn =" select  t.wid,t.appealid,(select name from t_expertqa_experts where userid=t.expertid) as expertid,t.answer,t.dateofreply,t.attach ";
		sql = " from t_expertqa_appealadd t where 1=1 ";
		if (null != texpertqaAppeal) {			
			if (StringUtils.isNotBlank(texpertqaAppeal.getWid())) {
				sql += " and appealid='" + texpertqaAppeal.getWid() + "'";
			}			
		}
		sql = sqlColumn + sql + " order by t.wid";
		List<?> list = DBUtil.queryAllBeanList(sql,TExpertqaAppealadd.class);
		action.setTexpertqaAppeal(texpertqaAppeal);			
        action.setParameter("listTExpertqaAppealadd", list); 
	}

	@Override
	public boolean doupdate(Object myaction) {
		ExpertqaAnswerAction action = (ExpertqaAnswerAction) myaction;		
		String wid = action.getParameter("wid");	
		String entity = action.getParameter("entityName");		
		String state = action.getParameter("state")!=null?action.getParameter("state"):"";
		String id_name = action.getParameter("id_name");
		String sql = "update " + entity + " set accepter = ? where " + id_name + " in ('" + wid.replaceAll(",", "','")
		+ "')";
		return DBUtil.executeSQL(sql, state)>0 ;
	}
	private Timestamp getTsByStr(String str) throws Exception {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date date = format.parse(str);
			return getTsByDate(date);
		} catch (ParseException e) {
			System.out.println("非法的日期输入：" + str + "，正确格式：yyyy-MM-dd！");
			throw e;
		}
	}
	private Timestamp getTsByDate(Date date) {
		return new Timestamp(date.getTime());
	}
}
