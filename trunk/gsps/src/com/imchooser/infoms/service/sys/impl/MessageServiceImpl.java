package com.imchooser.infoms.service.sys.impl;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.sys.MessageAction;
import com.imchooser.infoms.entity.sys.TSysMessage;
import com.imchooser.infoms.entity.sys.TSysMessageGxqf;
import com.imchooser.infoms.util.BusinessLogUtil;
import com.imchooser.infoms.util.CommonQuery;
import com.imchooser.util.FileUtil;

/**
 * 消息平台 省中心发送广播、普通用户（目前是部门间）互发消息等
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class MessageServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		MessageAction action = (MessageAction) myaction;
		TSysMessage tSysMessage = action.getTsysMessage();
		String mydepartid = action.getDepartID();
		String hqlcolumn = "select new TSysMessage(a.wid ,"
				+ "(select b.zdmc from TSysCode b where b.zdbm=a.xxly and b.zdlb='xxly') as xxly, "
				+ "a.xxfssj, a.xxnr, a.xxbt, "
				+ "(select count(*) from TSysMessageGxqf aa where a.wid=aa.messageWid and xxzt='1') as ydrs,"
				+ "(select count(*) from TSysMessageGxqf aa where a.wid=aa.messageWid and xxzt='0') as wdrs,"
				+ "a.xxfsr as xxfsrDepartid,a.wid as realWid)";
		String hql = " from TSysMessage a " + " where a.fxxsc is null and a.xxfsr='" + mydepartid + "'";
		if (tSysMessage != null && StringUtils.isNotBlank(tSysMessage.getXxbt())) {
			hql += " and a.xxbt like '%" + tSysMessage.getXxbt() + "%'";
		}
		long c = getBaseDao().count("select count(*) as c " + hql);
		pager.setTotalRows(c);
		hql = hqlcolumn + hql + " order by wid desc";
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	public void load(Object myaction) throws Exception {
		MessageAction action = (MessageAction) myaction;
		String id = action.getWid();
		TSysMessage tsysMessage = (TSysMessage) getBaseDao().findById(TSysMessage.class, id);
		action.setTsysMessage(tsysMessage);
		action.setParameter("tsysMessage", tsysMessage);
	}

	public void openCreate(Object myaction) throws Exception {
		MessageAction action = (MessageAction) myaction;
		action.setParameter("msgLy", action.getParameter("msgLy"));
		TSysMessage object = action.getTsysMessage();
		if (action.getTsysMessage() != null && StringUtils.isNotBlank(action.getTsysMessage().getXxjsr())) {
			String xxjsr = object.getXxjsr();
			object.setXxjsrName(getChinese(xxjsr));
			action.setTsysMessage(object);
		}
	}

	/**
	 * 中学用户及院系用户 根据部门编号获得上级部门中文名
	 * 
	 * @param code
	 * @return
	 */
	protected String getChineseUpDepart(String code) {
		String name = (String) getBaseDao().findFieldValue("select departname from TSysDepart where departid=?",
				code.substring(0, 9));
		return name;
	}

	/**
	 * 根据部门编码获得中文名
	 * 
	 * @param code
	 * @return
	 */
	protected String getChinese(String code) {
		String name = (String) getBaseDao().findFieldValue("select departname from TSysDepart where departid=?", code);
		return name;
	}

	/**
	 * 回复消息
	 * 
	 * @param wid 要回复的消息的WID
	 * @return
	 * @throws Exception
	 */
	public Object reMsg(Object myaction) throws Exception {

		return false;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		MessageAction action = (MessageAction) myaction;
		TSysMessage object = action.getTsysMessage();
		File file = action.getMyFile();
		String str_maxfilesize = CommonQuery.getSysProperty(Constants.MESSAGE_FILE_SIZE);
		long maxFileSize;
		if (StringUtils.isBlank(str_maxfilesize)) {
			maxFileSize = Constants.FILE_SIZE_1M;// 用系统默认，已经按字节计算
		} else {
			maxFileSize = Integer.parseInt(str_maxfilesize) * 1024;// kb转为字节
		}
		if (file != null) {
			// 有文件上传
			FileUtil.checkFileSize(file.length(), maxFileSize);
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
			object.setFj(Hibernate.createBlob(in));
			object.setFjm(System.currentTimeMillis() + "." + object.getFjm());
		}
		// if(action.getRequest().getParameter("reMsg")!=null){
		// //回复消息
		// return reMsg(myaction);
		// }
		// TSysMessageGxqf tsysMessageGxqf = action.getTsysMessageGxqf();
		String xxjsrs = object.getXxjsr();
		String[] xxjsr = xxjsrs.split(",");
		if (StringUtils.isBlank(xxjsrs) && (xxjsr == null || xxjsr.length == 0)) {
			throw new Exception("没有接收人！");
		}
		String wid = SeqFactory.getNewSequenceAlone();
		object.setXxfssj(new Date());
		object.setXxfsr(action.getDepartID());
		object.setWid(wid);
		object.setXxly("097");
		getBaseDao().save(object);
		if (!Constants.SYSCODE_XXLY_QFXSXX.equals(object.getXxly())) {
			for (int i = 0; i < xxjsr.length; i++) {
				TSysMessageGxqf tsysMessageGxqf = new TSysMessageGxqf();
				tsysMessageGxqf.setXxzt(Constants.MESSAGE_STATE_UNREAD);
				tsysMessageGxqf.setXxjsr(xxjsr[i]);
				tsysMessageGxqf.setWid(SeqFactory.getNewSequenceAlone());
				tsysMessageGxqf.setMessageWid(wid);
				tsysMessageGxqf.setFszt(object.getFszt());
				getBaseDao().save(tsysMessageGxqf);
			}
			object.setXxjsr(xxjsrs);// 恢复多个接收人
		}
		BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_MESSAGE,
				Constants.LOG_ACTION_SAVE);

	}

	/*
	 * (non-Javadoc)
	 * @see com.imchooser.framework.service.BaseService#remove(java.lang.Object)
	 * 发件人删除时不影响收件人,反之亦然,都删除时数据库也删除改数据
	 */
	public boolean remove(Object myaction) throws Exception {
		MessageAction action = (MessageAction) myaction;
		String ids = action.getWid();
		String sql = null;
		boolean deleteSuccess = false;
		if (ids != null) {
			deleteSuccess = getBaseDao().deleteAll("TSysMessage", "wid", "=", ids);
			DBUtil.executeSQL("delete from t_sys_message_gxqf where message_wid = ? ", ids);
		} else {
			String czsj = action.getParameter("czsj");
			sql = "delete from t_sys_message t where xxfssj<to_date(?,'yyyy-mm-dd')";
			deleteSuccess = DBUtil.executeSQL(sql, czsj) > 0;
		}
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_MESSAGE,
					Constants.LOG_ACTION_DEL);
		}
		return deleteSuccess;
	}

	public void msgbody(Object myaction) {

		MessageAction action = (MessageAction) myaction;
		String wid = action.getParameter("wid");

		if (null == wid || "".equals(wid))
			return;

		String SQL = "select t.wid,t.xxbt,t.xxnr,t.fjm from t_sys_message t where t.wid=?";
		Object[] obj = DBUtil.queryRowColumns(SQL, wid);

		action.setParameter("con", obj);
	}
}
