package com.yszoe.biz.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.biz.action.TestTypeAction;
import com.yszoe.biz.entity.TCsLx;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.util.BusinessLogUtil;
import com.yszoe.util.DateUtil;

/**
 * 测试类别
 * 
 * @author Linyang datetime 2011-12-27
 */
public class TestTypeServiceImpl extends AbstractBaseServiceSupport {
	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(TestTypeServiceImpl.class);

	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		TestTypeAction action = (TestTypeAction) myaction;
		TCsLx tcsLx = action.getTcsLx();
		String hql = "from TCsLx a where (cjr like ? or state = '0')";
		if (null != tcsLx) {
			if (StringUtils.isNotBlank(tcsLx.getLx())) {
				hql += " and a.lx like '%" + tcsLx.getLx() + "%'";
			}
		}
		long c = getBaseDao().count(hql, action.getUserloginid());
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql + " order by lx,wid desc", pager, action.getUserloginid());
		return list;
	}

	@Override
	public void openCreate(Object myaction) throws Exception {
		TestTypeAction action = (TestTypeAction) myaction;
		TCsLx tcsLx = new TCsLx();
		action.setTcsLx(tcsLx);
	}

	@Override
	public void load(Object myaction) throws Exception {
		TestTypeAction action = (TestTypeAction) myaction;
		String ids = action.getWid();
		TCsLx tcsLx = getBaseDao().findById(TCsLx.class, ids);
		action.setTcsLx(tcsLx);
	}

	@Override
	public boolean remove(Object myaction) throws Exception {
		TestTypeAction action = (TestTypeAction) myaction;
		String ids = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TCsLx", "wid", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_CS_LX, SysConstants.LOG_ACTION_DEL, action
					.getRequest().getRemoteAddr());
		}
		return deleteSuccess;
	}

	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
		TestTypeAction action = (TestTypeAction) myaction;
		TCsLx tcsLx = action.getTcsLx();
		if (StringUtils.isBlank(tcsLx.getWid())) {
			tcsLx.setWid(SeqFactory.getNewSequenceAlone());
			tcsLx.setCjr(action.getUserloginid());
			tcsLx.setCjsj(DateUtil.currentTime());
			getBaseDao().save(tcsLx);
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_CS_LX, SysConstants.LOG_ACTION_SAVE,
					action.getRequest().getRemoteAddr());
		} else {
			getBaseDao().updateNotNull(tcsLx);
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_CS_LX, SysConstants.LOG_ACTION_UPDATE,
					action.getRequest().getRemoteAddr());
		}
		String syxz = action.getParameter("sfxz");// 保存并新增按钮
		if ("1".equals(syxz)) {
			openCreate(myaction);
		}
	}

	@Override
	public String changeState(Object myaction) throws Exception {
		TestTypeAction action = (TestTypeAction) myaction;
		String ids = action.getWid();
		String shzt = action.getParameter("shzt");
		boolean success = getBaseDao().executeHql(
				"update TCsLx set state = ? where wid in ('" + ids.replaceAll(",", "','") + "')", shzt) > 0;
		if (success)
			return "操作成功";
		else
			return "操作失败";
	}
}
