package com.yszoe.biz.service.impl;


import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.biz.action.QuestionAction;
import com.yszoe.biz.entity.TExpertqaAppeal;
import com.yszoe.biz.entity.TExpertqaAppealadd;
import com.yszoe.biz.entity.TExpertqaExperts;
import com.yszoe.biz.service.ExpertqaAppealService;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.identity.IdConstants;
import com.yszoe.identity.entity.TSysUser;
import com.yszoe.sys.entity.ApplicationEnum;
import com.yszoe.util.DateUtil;
import com.yszoe.util.SendMail;
import com.yszoe.util.StringUtil;

/**
 * 
 * @author Linyang datetime 2011-6-30
 */
public class QuestionImpl extends AbstractBaseServiceSupport implements ExpertqaAppealService {

	 private static final Log LOG = LogFactory.getLog(QuestionImpl.class);

	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		QuestionAction action = (QuestionAction) myaction;
		TExpertqaAppeal expertqaAppeal = action.getTexpertqaAppeal();
		TSysUser tsysuser=(TSysUser)action.getSession().getAttribute(IdConstants.SESSION_USER);
		String sqlColumn =" select t.wid,t.writer,t.identity,t.dateofinput,t.content,t.contact,(select zdmc from t_sys_code where zdlb='sort_id' and zdbm=t.sort_id) as sortId," 
						 +"t.relationtel,t.address,t.email,t.answer,t.ispublish,t.digest ,(select name from t_expertqa_experts where userid=t.accepter) as accepter,t.read,t.title,t.attach,t.dateofreply,t.replyexpert";
		String sql = " from t_expertqa_appeal t where 1=1 and ispublish='1' ";		
		if (null != expertqaAppeal) {
			if (StringUtils.isNotBlank(expertqaAppeal.getTitle())) {
				sql += " and t.title like '%" + expertqaAppeal.getTitle() + "%'";
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
		QuestionAction action = (QuestionAction) myaction;
		String wid = action.getWid();
		boolean f = getBaseDao().deleteAll("TExpertqaAppealadd", "appealid", "=", wid);
		if(f){
			f = getBaseDao().deleteAll("TExpertqaAppeal", "wid", "=", wid);
		}
		return f;
	}
	
	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		QuestionAction action = (QuestionAction) myaction;
		TExpertqaAppeal expertqaAppeal = action.getTexpertqaAppeal();		
		if(StringUtil.isBlank(expertqaAppeal.getWid())){
			//do insert
			TSysUser tsysuser=(TSysUser)action.getSession().getAttribute(IdConstants.SESSION_USER);
			if (tsysuser!=null&&tsysuser.getUserloginid()!=null){
				expertqaAppeal.setWriter(tsysuser.getUserid());
			}			
			expertqaAppeal.setWid(SeqFactory.getNewSequenceAlone());
			expertqaAppeal.setDateofinput(getTsByStr(new SimpleDateFormat("yyyy-MM-dd").format(new Date())));
			getBaseDao().save(expertqaAppeal);
			this.sentMail(expertqaAppeal);
		}else{
			//do update
			getBaseDao().updateNotNull(expertqaAppeal);
		}
		action.setTexpertqaAppeal(new TExpertqaAppeal());
	}

	@Override
	public void load(Object myaction) throws Exception {
		QuestionAction action = (QuestionAction) myaction;
		String wid = action.getWid();
		TExpertqaAppeal texpertqaAppeal = getBaseDao().findById(TExpertqaAppeal.class, wid);
		String sqlColumn =" select  t.wid,t.appealid,(select name from t_expertqa_experts where userid=t.expertid) as expertid,t.answer,t.dateofreply,t.attach ";
		String sql = " from t_expertqa_appealadd t where 1=1 ";
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
		QuestionAction action = (QuestionAction) myaction;
		String wid = action.getWid();		
		String entity = action.getParameter("entityName");	
		String itemname = action.getParameter("itemname");
		String state = action.getParameter("state")!=null?action.getParameter("state"):"1";
		String id_name = action.getParameter("id_name");
		String sql = "update " + entity + " set "+itemname+" = ? where " + id_name + " in ('" + wid.replaceAll(",", "','")
		+ "')";
		return DBUtil.executeSQL(sql, state)>0 ;
	}
	@Override
	public List<ApplicationEnum> getApplicationEnums(String sql) {
		ApplicationEnum aenum=null;
		TExpertqaExperts texpertqaExperts =new TExpertqaExperts();
	    List<ApplicationEnum> lista=new ArrayList<ApplicationEnum>();
		List<?> list = DBUtil.queryAllBeanList(sql,TExpertqaExperts.class);
		for (int i=0;i<list.size();i++){
			texpertqaExperts=(TExpertqaExperts)list.get(i);
			aenum=new ApplicationEnum();
			aenum.setId(texpertqaExperts.getUserid());	
			aenum.setCaption(texpertqaExperts.getName()+"["+texpertqaExperts.getPhoto()+"]");
			lista.add(aenum);
		}
		return lista;
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
	
	private void sentMail(TExpertqaAppeal expertqaAppeal){

		String hql=" from TExpertqaExperts where userid=?";
		List list = getBaseDao().findByHql(hql, expertqaAppeal.getAccepter());
		if (list!=null&&list.size()>0){
			SendMail sm=new SendMail();
			sm.readyMailConfig();
			TExpertqaExperts texpertqaExperts=(TExpertqaExperts)list.get(0);
			sm.getMailTemplate().setAccepter(texpertqaExperts.getEmail());		
			sm.getMailTemplate().setSubject(expertqaAppeal.getTitle());
			String text = texpertqaExperts.getName() + sm.getMailTemplate().getBody();
			text += "\r\n \t\t\t\t\t\t\t\t"+DateUtil.formatDate(expertqaAppeal.getDateofinput(), DateUtil.PATTERN_DATE);			
			sm.getMailTemplate().setBody(text);
			sm.send();
		}
		
	}
}
