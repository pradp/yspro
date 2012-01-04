package com.yszoe.biz.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.biz.action.TestProjectAction;
import com.yszoe.biz.action.TestTypeAction;
import com.yszoe.biz.entity.TCsTm;
import com.yszoe.biz.entity.TCsXm;
import com.yszoe.biz.service.TestProjectService;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.util.BusinessLogUtil;
import com.yszoe.util.DateUtil;

/**
 * 测试项目
 * 
 * @author Linyang datetime 2011-12-27
 */
public class TestProjectServiceImpl extends AbstractBaseServiceSupport implements TestProjectService {
	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(TestProjectServiceImpl.class);

	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		TestProjectAction action = (TestProjectAction) myaction;
		TCsXm tcsXm = action.getTcsXm();
		String hqlColumn = "select new TCsXm(a.wid, a.name, a.jj, (select b.lx from TCsLx b where a.lx=b.wid) as lx,"
				+ "a.jg, a.sycs, a.cjr, a.cjsj, a.state, a.cssj, a.ts, a.xxxx)";
		String hql = " from TCsXm a where a.cjr like ?";
		if (null != tcsXm) {
			if (StringUtils.isNotBlank(tcsXm.getLx())) {
				hql += " and a.lx = '" + tcsXm.getLx() + "'";
			}
			if (StringUtils.isNotBlank(tcsXm.getName())) {
				hql += " and a.name like '%" + tcsXm.getName() + "%'";
			}
		}
		long c = getBaseDao().count(hql, action.getUserloginid());
		pager.setTotalRows(c);
		hql = hqlColumn + hql + " order by a.lx,a.wid desc";
		List<?> list = getBaseDao().findByHql(hql, action.getUserloginid());
		return list;
	}

	@Override
	public void openCreate(Object myaction) throws Exception {
		TestProjectAction action = (TestProjectAction) myaction;
		TCsXm tcsXm = new TCsXm();
		action.setTcsXm(tcsXm);
	}

	@Override
	public void load(Object myaction) throws Exception {
		TestProjectAction action = (TestProjectAction) myaction;
		String ids = action.getWid();
		TCsXm tcsXm = getBaseDao().findById(TCsXm.class, ids);
		action.setTcsXm(tcsXm);
		List<TCsTm> listTcstm = getBaseDao().findByHql(" from TCsTm where xmid = ?", ids);
		action.setListTcstm(listTcstm);
	}

	@Override
	public boolean remove(Object myaction) throws Exception {
		TestProjectAction action = (TestProjectAction) myaction;
		String ids = action.getWid();
		boolean deleteSuccess_xm = getBaseDao().deleteAll("TCsXm", "wid", "=", ids);
		boolean deleteSuccess_tm = getBaseDao().deleteAll("TCsTm", "xmid", "=", ids);
		if (deleteSuccess_xm && deleteSuccess_tm) {
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_CS_XM, SysConstants.LOG_ACTION_DEL, action
					.getRequest().getRemoteAddr());
		}
		return deleteSuccess_xm && deleteSuccess_tm;
	}

	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
		TestProjectAction action = (TestProjectAction) myaction;
		TCsXm tcsXm = action.getTcsXm();
		List<TCsTm> listTcstm = action.getListTcstm();
		StringBuffer xxxx = new StringBuffer("");
		String ids = SeqFactory.getNewSequenceAlone();
		for (int i = 0; i < listTcstm.size(); i++) {
			TCsTm t = listTcstm.get(i);
			t.setWid(SeqFactory.getNewSequenceAlone());
			t.setXmid(StringUtils.isNotBlank(tcsXm.getWid()) ? tcsXm.getWid() : ids);
			t.setCjr(action.getUserloginid());
			t.setCjsj(DateUtil.currentTime());
			xxxx.append(t.getXsxx());
		}
		tcsXm.setXxxx(xxxx.toString());
		tcsXm.setTs(((Integer) (listTcstm.size())).shortValue());
		if (StringUtils.isBlank(tcsXm.getWid())) {
			tcsXm.setWid(ids);
			tcsXm.setCjr(action.getUserloginid());
			tcsXm.setCjsj(DateUtil.currentTime());
			getBaseDao().save(tcsXm);
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_CS_XM, SysConstants.LOG_ACTION_SAVE,
					action.getRequest().getRemoteAddr());
		} else {
			getBaseDao().deleteAll("TCsTm", "xmid", "=", tcsXm.getWid());
			getBaseDao().updateNotNull(tcsXm);
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_CS_XM, SysConstants.LOG_ACTION_UPDATE,
					action.getRequest().getRemoteAddr());
		}
		getBaseDao().saveAll(listTcstm);
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
				"update TCsXm set state = ? where wid in ('" + ids.replaceAll(",", "','") + "')", shzt) > 0;
		if (success)
			return "操作成功";
		else
			return "操作失败";
	}

	@Override
	public void lookup(Object myaction) throws Exception {
		TestProjectAction action = (TestProjectAction) myaction;
		String ids = action.getWid();
		TCsXm tcsXm = getBaseDao().findById(TCsXm.class, ids);
		action.setTcsXm(tcsXm);
	}
}
