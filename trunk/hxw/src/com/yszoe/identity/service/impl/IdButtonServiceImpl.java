package com.yszoe.identity.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.identity.action.IdButtonAction;
import com.yszoe.identity.entity.TSysButton;
import com.yszoe.identity.service.IdButtonService;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.util.BusinessLogUtil;

/**
 * 系统管理员维护全站菜单中的按钮字典
 * 
 * @author Yangjianliang datetime 2011-5-14
 */
public class IdButtonServiceImpl extends AbstractBaseServiceSupport implements IdButtonService {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		IdButtonAction action = (IdButtonAction) myaction;
		TSysButton tsysButton = action.getTsysButton();
		String hqlColumn = "select new TSysButton(a.buttonid, a.buttonname, "
				+ "(select zdmc from TSysCode where zdlb='ansj' and zdbm=a.buttonevent) as buttonevent,"
				+ "a.buttonicon,(select zdmc from TSysCode where zdlb='qyyf' and zdbm=a.state) as state,"
				+ "(select zdmc from TSysCode where zdlb='qyyf' and zdbm=a.share2enterprise) as share2enterprise,a.memo,a.ordernum) ";
		String hql = "from TSysButton a where 1=1";
		if (tsysButton != null) {
			if (StringUtils.isNotBlank(tsysButton.getState())) {
				hql += " and state = '" + tsysButton.getState() + "'";
			}
		}
		pager.setTotalRows(getBaseDao().count("select count(*) " + hql));

		hql = hqlColumn + hql + " order by ordernum desc,a.buttonid";
		List<TSysButton> tsysButtons = getBaseDao().findPageByHql(hql, pager);

		return tsysButtons;
	}

	public void load(Object myaction) throws Exception {
		// query a entity
		IdButtonAction action = (IdButtonAction) myaction;
		String wid = action.getParameter("wid");
		String hql = "from TSysButton where buttonid = ?";
		TSysButton button = (TSysButton) getBaseDao().findFieldValue(hql, wid);
		action.setTsysButton(button);
	}

	/**
	 * 删除按钮需要同时删除关系表中的按钮引用数据 事务的控制交给spring配置
	 */
	public boolean remove(Object myaction) throws Exception {

		IdButtonAction action = (IdButtonAction) myaction;
		String ids = action.getParameter("wid");

		removeRoleMenuButton(ids);

		boolean deleteSuccess = getBaseDao().deleteAll("TSysButton", "buttonid", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_BUTTON,
					SysConstants.LOG_ACTION_DEL, action.getRequest().getRemoteAddr());
		}
		return deleteSuccess;
	}

	private boolean removeRoleMenuButton(String ids) throws Exception {

		return getBaseDao().deleteAll("TSysRoleMenuButton", "buttonid", "=", ids);
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		IdButtonAction action = (IdButtonAction) myaction;
		TSysButton tsysButton = action.getTsysButton();
		if (tsysButton == null) {

			action.addActionError("保存失败[ 被保存的对象为null ]");
		} else {

			if (StringUtils.isBlank(tsysButton.getButtonid())) {
				long c = getBaseDao().count("select count(*) from TSysButton where buttonname = ?",
						tsysButton.getButtonname());
				if (c > 0) {
					throw new Exception("该按钮名已存在!");
				}
				tsysButton.setButtonid(SeqFactory.getNewSequenceAlone());

				getBaseDao().save(tsysButton);
				BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_BUTTON,
						SysConstants.LOG_ACTION_SAVE, action.getRequest().getRemoteAddr());

			} else {
				long c = getBaseDao().count("select count(*) from TSysButton where buttonname = ? and buttonid != ?",
						tsysButton.getButtonname(), tsysButton.getButtonid());
				if (c > 0) {
					throw new Exception("该按钮名已存在!");
				}
				getBaseDao().update(tsysButton);
				BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_BUTTON,
						SysConstants.LOG_ACTION_UPDATE, action.getRequest().getRemoteAddr());
			}
		}
	}

}
