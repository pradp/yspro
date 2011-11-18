package com.yszoe.identity.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.identity.action.IdRoleAction;
import com.yszoe.identity.entity.TSysRole;
import com.yszoe.identity.entity.TSysRoleMenu;
import com.yszoe.identity.entity.TSysRoleMenuButton;
import com.yszoe.identity.service.IdRoleService;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.entity.ApplicationEnum;
import com.yszoe.sys.util.BusinessLogUtil;

public class IdRoleServiceImpl extends AbstractBaseServiceSupport implements IdRoleService {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		IdRoleAction action = (IdRoleAction) myaction;
		TSysRole tsysRole = action.getTsysRole();
		String hql = "from TSysRole where 1=1";
		if (tsysRole != null) {
			if (tsysRole.getRoleid() != null && !tsysRole.getRoleid().equals("")) {
				hql += " and roleid = '" + tsysRole.getRoleid() + "'";
			}
			if (tsysRole.getRolename() != null && !tsysRole.getRolename().equals("")) {
				hql += " and rolename like '%" + tsysRole.getRolename() + "%'";
			}
			if (tsysRole.getState() != null && !tsysRole.getState().equals("")) {
				hql += " and state = '" + tsysRole.getState() + "'";
			}
		}
		pager.setTotalRows(getBaseDao().count("select count(*) " + hql));

		hql = hql + " order by roleid";
		List<TSysRole> tsysRoles = getBaseDao().findPageByHql(hql, pager);

		return tsysRoles;
	}

	public void openCreate(Object myaction) throws Exception {
		IdRoleAction action = (IdRoleAction) myaction;
		// 获取二级菜单名
		action.setListMenuDepth2(queryAllMenu());
		if (!queryAllMenu().isEmpty() && queryAllMenu().get(0) != null
				&& StringUtils.isNotBlank(queryAllMenu().get(0).getId())) {
			action.setParameter("defaultMenuid", queryAllMenu().get(0).getId());
		}
	}

	public void load(Object myaction) throws Exception {
		// query a role
		IdRoleAction action = (IdRoleAction) myaction;
		String roleid = action.getParameter("wid");
		String hql = "from TSysRole where roleid = ?";
		TSysRole role = (TSysRole) getBaseDao().findFieldValue(hql, roleid);
		action.setTsysRole(role);

		// 下面取得权限菜单
		// action.setParameter("menues", queryRoleMenuid(roleid));
		setMenuAndButton(action, roleid);
	}

	/**
	 * 获取二级菜单名 及 角色菜单信息 角色菜单按钮信息
	 * 
	 * @param myaction
	 * @param roleid
	 * @throws Exception
	 */
	private void setMenuAndButton(Object myaction, String roleid) throws Exception {
		IdRoleAction action = (IdRoleAction) myaction;
		// 获取二级菜单名
		action.setListMenuDepth2(queryAllMenu());
		if (!queryAllMenu().isEmpty() && queryAllMenu().get(0) != null
				&& StringUtils.isNotBlank(queryAllMenu().get(0).getId())) {
			action.setParameter("defaultMenuid", queryAllMenu().get(0).getId());
		}
		String hqlb = "from TSysRoleMenuButton a where 1=1";
		String hqlm = "from TSysRoleMenu a where 1=1";
		String hql = "";
		if (StringUtils.isNotBlank(roleid)) {
			hql += " and roleid = '" + roleid + "'";
			action.setParameter("roleid", roleid);
			StringBuffer menuButtons = new StringBuffer();
			List<TSysRoleMenuButton> listMenuButtons = getBaseDao().findByHql(hqlb + hql);
			if (!listMenuButtons.isEmpty()) {
				for (int i = 0; i < listMenuButtons.size(); i++) {
					TSysRoleMenuButton o = listMenuButtons.get(i);
					if (null != o)
						menuButtons.append(o.getMenuid()).append("_").append(o.getButtonid());
					if (i != listMenuButtons.size() - 1)
						menuButtons.append(",");
				}
			}
			action.setParameter("menuebuttons", menuButtons.toString());
			StringBuffer menues = new StringBuffer();
			List<TSysRoleMenu> listMenues = getBaseDao().findByHql(hqlm + hql);
			if (!listMenues.isEmpty()) {
				for (int i = 0; i < listMenues.size(); i++) {
					TSysRoleMenu o = listMenues.get(i);
					if (null != o)
						menues.append(o.getMenuid());
					if (i != listMenues.size() - 1)
						menues.append(",");
				}
			}
			action.setParameter("menues", menues.toString());
		}
	}

	/**
	 * 删除角色需要同时删除关系表中的角色数据：菜单与角色关联表、组与角色关联表 事务的控制交给spring配置
	 */
	public boolean remove(Object myaction) throws Exception {

		IdRoleAction action = (IdRoleAction) myaction;
		String ids = action.getParameter("wid");

		removeMenuButton(ids);
		removeMenu(ids);
		removeGroup(ids);

		boolean deleteSuccess = getBaseDao().deleteAll("TSysRole", "roleid", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_ROLE,
					SysConstants.LOG_ACTION_DEL, action.getRequest().getRemoteAddr());
		}
		return deleteSuccess;
	}

	private boolean removeMenu(String ids) throws Exception {

		return getBaseDao().deleteAll("TSysRoleMenu", "roleid", "=", ids);
	}

	private boolean removeGroup(String ids) throws Exception {

		return getBaseDao().deleteAll("TSysGroupRole", "roleid", "=", ids);
	}

	private boolean removeMenuButton(String ids) throws Exception {

		return getBaseDao().deleteAll("TSysRoleMenuButton", "roleid", "=", ids);
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		IdRoleAction action = (IdRoleAction) myaction;
		TSysRole tsysRole = action.getTsysRole();
		if (tsysRole == null) {

			action.addActionError("保存失败[ 被保存的对象为null ]");
		} else {

			if (tsysRole.getRoleid() == null || tsysRole.getRoleid().equals("")) {
				boolean isRoleNameExist = getBaseDao().count("select count(*) as c from TSysRole where roleName = ?",
						tsysRole.getRolename().trim()) > 0;
				if (isRoleNameExist) {
					throw new Exception("角色名重复!");
				}
				tsysRole.setRoleid(SeqFactory.getNewSequenceAlone());

				getBaseDao().save(tsysRole);
				// 保存角色菜单
				saveOrUpdateMenu(action, tsysRole.getRoleid(), SysConstants.CZLX_XZ);
				// 保存角色菜单按钮
				saveOrUpdateMenuButton(action, tsysRole.getRoleid(), SysConstants.CZLX_XZ);
				BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_ROLE,
						SysConstants.LOG_ACTION_SAVE, action.getRequest().getRemoteAddr());
			} else {
				// 更新角色菜单
				saveOrUpdateMenu(action, tsysRole.getRoleid(), SysConstants.CZLX_XG);
				// 更新角色菜单按钮
				saveOrUpdateMenuButton(action, tsysRole.getRoleid(), SysConstants.CZLX_XG);
				getBaseDao().update(tsysRole);
				BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_ROLE,
						SysConstants.LOG_ACTION_UPDATE, action.getRequest().getRemoteAddr());
			}
		}
		// 获取二级菜单名
		action.setListMenuDepth2(queryAllMenu());
		if (!queryAllMenu().isEmpty() && queryAllMenu().get(0) != null
				&& StringUtils.isNotBlank(queryAllMenu().get(0).getId())) {
			action.setParameter("defaultMenuid", queryAllMenu().get(0).getId());
		}

	}

	/**
	 * 保存或更新角色菜单
	 * 
	 * @param myaction
	 * @param roleid 角色id
	 * @param type 操作类型 保存/修改
	 * @throws Exception
	 */
	public void saveOrUpdateMenu(Object myaction, String roleid, String type) throws Exception {
		IdRoleAction action = (IdRoleAction) myaction;
		String menues = action.getParameter("menues");
		if (SysConstants.CZLX_XZ.equals(type)) {
			if (menues != null && !menues.equals("") && !menues.equals("000")) {
				// 更新权限表
				menues = menues.replaceAll("000,", "");// 000节点是树的根节点，在权限菜单表中不需要保存

				String[] menues__ = menues.split(",");
				List<TSysRoleMenu> roleMenues = new ArrayList<TSysRoleMenu>();
				for (int i = 0; i < menues__.length; i++) {
					String o = menues__[i];
					TSysRoleMenu roleMenu = new TSysRoleMenu();
					roleMenu.setId(SeqFactory.getNewSequenceAlone());
					roleMenu.setRoleid(roleid);
					roleMenu.setMenuid(o.trim());
					roleMenues.add(roleMenu);
				}
				getBaseDao().saveAll(roleMenues);

			}
		} else {
			// 更新权限菜单表。把数据库中的和用户新提交的菜单比较，采用删除没有的，只添加新增的菜单的策略，提高效率
			menues = menues.replaceAll("000,", "");// 000节点是树的根节点，在权限菜单表中不需要保存

			String hql = "select menuid from TSysRoleMenu where roleid=?";
			List<String> db_menues = getBaseDao().findByHql(hql, roleid);
			if (db_menues != null && !db_menues.isEmpty()) {
				db_menues.remove("000");// 去掉根节点
			} else if (db_menues == null) {
				db_menues = Collections.emptyList();
			}
			List<String> db_menues__clone = new ArrayList<String>(db_menues);// 复制一份
			List<String> curr_menues = new ArrayList<String>(0);
			if (StringUtils.isNotBlank(menues)) {
				Object[] curr_menu = menues.split(",");
				curr_menues = new ArrayList<String>(curr_menu.length);
				for (Object o : curr_menu) {
					curr_menues.add(o.toString());
				}
			}

			db_menues.removeAll(curr_menues);
			// 剩下的是需要删除的菜单
			if (db_menues.isEmpty() == false) {

				StringBuffer do_menues = new StringBuffer(" and (");
				hql = "delete from TSysRoleMenu where roleid=?";
				for (Object o : db_menues) {
					if (null != o) {
						do_menues.append(" menuid='").append(o.toString()).append("' or ");
					}
				}
				int _s = do_menues.lastIndexOf(" or ");
				if (_s > 0) {
					do_menues.delete(_s, do_menues.length());
					do_menues.append(")");
					hql = hql + do_menues;
				}
				getBaseDao().delete(hql, roleid);
			}

			curr_menues.removeAll(db_menues__clone);
			// 剩下的是需要增加的菜单
			if (!curr_menues.isEmpty()) {
				List<TSysRoleMenu> roleMenues = new ArrayList<TSysRoleMenu>();
				for (int i = 0; i < curr_menues.size(); i++) {
					String o = curr_menues.get(i);
					TSysRoleMenu roleMenu = new TSysRoleMenu();
					roleMenu.setId(SeqFactory.getNewSequenceAlone());
					roleMenu.setRoleid(roleid);
					roleMenu.setMenuid(o.trim());
					roleMenues.add(roleMenu);
				}
				getBaseDao().saveAll(roleMenues);

			}
		}
		action.setParameter("menues", menues);

	}

	/**
	 * 保存或更新角色菜单按钮
	 * 
	 * @param myaction
	 * @param roleid 角色id
	 * @param type 操作类型 保存/修改
	 * @throws Exception
	 */
	public void saveOrUpdateMenuButton(Object myaction, String roleid, String type) throws Exception {
		IdRoleAction action = (IdRoleAction) myaction;
		String menuebuttons = action.getParameter("menuebuttons");
		String[] curr_menuebutton = menuebuttons.split(",");
		if (SysConstants.CZLX_XZ.equals(type)) {
			List<TSysRoleMenuButton> roleMenueButtons = new ArrayList<TSysRoleMenuButton>();
			for (int i = 0; i < curr_menuebutton.length; i++) {
				if (curr_menuebutton[i].indexOf("_") != -1) {
					TSysRoleMenuButton roleMenuButton = new TSysRoleMenuButton();
					roleMenuButton.setId(SeqFactory.getNewSequenceAlone());
					roleMenuButton.setRoleid(roleid);
					roleMenuButton.setMenuid(curr_menuebutton[i].split("_")[0].trim());
					roleMenuButton.setButtonid(curr_menuebutton[i].split("_")[1].trim());
					roleMenueButtons.add(roleMenuButton);
				}
			}
			getBaseDao().saveAll(roleMenueButtons);
		} else {
			String hql = "select new ApplicationEnum(menuid as id,buttonid as caption) from TSysRoleMenuButton where roleid=?";
			List<ApplicationEnum> db_menuebuttons = getBaseDao().findByHql(hql, roleid);

			List<ApplicationEnum> db_menuebuttons__clone = new ArrayList<ApplicationEnum>(db_menuebuttons);// 复制一份
			// 需要删除的菜单按钮
			List<ApplicationEnum> curr_menuebuttons = new ArrayList<ApplicationEnum>(0);
			if (StringUtils.isNotBlank(menuebuttons)) {
				curr_menuebuttons = new ArrayList<ApplicationEnum>(curr_menuebutton.length);
				for (String str : curr_menuebutton) {
					if (str.indexOf("_") != -1) {
						ApplicationEnum ap = new ApplicationEnum();
						ap.setId(str.split("_")[0].trim());
						ap.setCaption(str.split("_")[1].trim());
						curr_menuebuttons.add(ap);
					}
				}
			}
			db_menuebuttons.removeAll(curr_menuebuttons);
			if (!db_menuebuttons.isEmpty()) {
				StringBuffer do_delete = new StringBuffer(" and (");
				hql = "delete from TSysRoleMenuButton where roleid=?";
				for (ApplicationEnum ap : db_menuebuttons) {
					if (null != ap) {
						do_delete.append(" (menuid='").append(ap.getId()).append("' and buttonid ='").append(
								ap.getCaption()).append("') or ");
					}
				}
				int _s = do_delete.lastIndexOf(" or ");
				if (_s > 0) {
					do_delete.delete(_s, do_delete.length());
					do_delete.append(")");
					hql = hql + do_delete;
				}
				getBaseDao().delete(hql, roleid);
			}
			curr_menuebuttons.removeAll(db_menuebuttons__clone);
			// 剩下的是需要增加的菜单按钮
			if (!curr_menuebuttons.isEmpty()) {

				List<TSysRoleMenuButton> roleMenueButtons = new ArrayList<TSysRoleMenuButton>();
				for (int i = 0; i < curr_menuebuttons.size(); i++) {
					ApplicationEnum ap = curr_menuebuttons.get(i);
					TSysRoleMenuButton roleMenuButton = new TSysRoleMenuButton();
					roleMenuButton.setId(SeqFactory.getNewSequenceAlone());
					roleMenuButton.setRoleid(roleid);
					roleMenuButton.setMenuid(ap.getId());
					roleMenuButton.setButtonid(ap.getCaption());
					roleMenueButtons.add(roleMenuButton);
				}
				getBaseDao().saveAll(roleMenueButtons);

			}

		}
		action.setParameter("menuebuttons", menuebuttons);
	}

	/**
	 * 取得此角色的权限菜单
	 * 
	 * @param roleid
	 * @return
	 */
	@SuppressWarnings("unused")
	private String queryRoleMenuid(String roleid) {

		String hql = "select menuid from TSysRoleMenu where roleid=?";
		List<TSysRoleMenu> menues__ = getBaseDao().findByHql(hql, roleid);
		StringBuffer menues = new StringBuffer("");
		for (Object menu : menues__) {
			if (menu != null) {
				menues.append(menu).append(",");
			}
		}
		if (menues.length() > 0) {
			menues.delete(menues.length() - 1, menues.length());
		}
		return menues.toString();
	}

	/**
	 * 获取二级菜单名
	 * 
	 * @throws Exception
	 */
	private List<ApplicationEnum> queryAllMenu() throws Exception {
		String hql = "select new ApplicationEnum(menuid,menuname) from TSysMenu where state=1 and depth=2 order by ordernum desc";
		List<ApplicationEnum> list = getBaseDao().findByHql(hql);
		return list;
	}
}
