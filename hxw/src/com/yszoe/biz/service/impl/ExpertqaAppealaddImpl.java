package com.yszoe.biz.service.impl;


import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.biz.action.ExpertqaAppealaddAction;
import com.yszoe.biz.entity.TExpertqaAppealadd;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.util.StringUtil;

/**
 * 问题信息维护
 * 
 * @author chenlu
 * datetime 2011-7-22
 */
public class ExpertqaAppealaddImpl extends AbstractBaseServiceSupport  {

	// private static final Log LOG =
	// LogFactory.getLog(yourCurrentClassHere.class);

	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		ExpertqaAppealaddAction action = (ExpertqaAppealaddAction) myaction;
		TExpertqaAppealadd expertqaAppealadd = action.getTexpertqaAppealadd();		
		String sqlColumn =" select t.wid,t.Appealaddid,(select name from t_expertqa_experts where userid=t.expertid) as expertid,t.answer,t.dateofreply,t.attach " ;						 
		String sql = " from t_expertqa_Appealaddapp t where 1=1 ";
		if (null != expertqaAppealadd) {
			if (StringUtils.isNotBlank(expertqaAppealadd.getExpertid())) {
				sql += " and t.expertid = '" + expertqaAppealadd.getExpertid() + "%'";
			}
			if (StringUtils.isNotBlank(expertqaAppealadd.getAppealid())) {
				sql += " and t.Appealaddid='" + expertqaAppealadd.getAppealid() + "'";
			}
			if (StringUtils.isNotBlank(expertqaAppealadd.getWid())) {
				sql += " and t.wid ='" + expertqaAppealadd.getWid() + "'";
			}				
		}
		long c = DBUtil.count("select count(*) " + sql);
		pager.setTotalRows(c);
		sql = sqlColumn + sql + " order by t.wid";
		List<?> list = DBUtil.queryPageBeanList(pager, sql, TExpertqaAppealadd.class);
		return list;
	}
	
	@Override
	public boolean remove(Object myaction) throws Exception {
		ExpertqaAppealaddAction action = (ExpertqaAppealaddAction) myaction;		
		String wid = action.getWid();
		boolean hql = getBaseDao().deleteAll("TExpertqaAppealadd", "wid", "=", wid);
		return hql;
	}
	
	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
		ExpertqaAppealaddAction action = (ExpertqaAppealaddAction) myaction;			
		TExpertqaAppealadd expertqaAppealadd = action.getTexpertqaAppealadd();
		if(StringUtil.isBlank(expertqaAppealadd.getWid())){
			//do insert
			expertqaAppealadd.setWid(SeqFactory.getNewSequenceAlone());
			getBaseDao().save(expertqaAppealadd);
		}else{
			//do update
			getBaseDao().updateNotNull(expertqaAppealadd);
		}
	}

	@Override
	public void load(Object myaction) throws Exception {
		ExpertqaAppealaddAction action = (ExpertqaAppealaddAction) myaction;
		String wid = action.getWid();
		TExpertqaAppealadd texpertqaAppealadd = getBaseDao().findById(TExpertqaAppealadd.class, wid);
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
