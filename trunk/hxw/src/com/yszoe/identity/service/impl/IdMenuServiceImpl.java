package com.yszoe.identity.service.impl;

import java.util.List;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.identity.action.IdMenuAction;
import com.yszoe.identity.entity.TSysMenu;
import com.yszoe.identity.service.IdMenuService;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.util.BusinessLogUtil;
import com.yszoe.util.StringUtil;

public class IdMenuServiceImpl extends AbstractBaseServiceSupport implements IdMenuService {

	public List<?> list(Object myaction, Pager pager) throws Exception {

		IdMenuAction action = (IdMenuAction) myaction;
		action.getRequest().setAttribute("showCheckBox", action.getParameter("showCheckBox"));
		// 采用控件展示树，数据给控件去取，这里直接转向过去
		return null;
	}

	public void load(Object myaction) throws Exception {
		IdMenuAction action = (IdMenuAction) myaction;
		String menuid = action.getParameter("wid");
		TSysMenu tsysMenu = (TSysMenu) getBaseDao().findById(TSysMenu.class, menuid);
		action.setTsysMenu(tsysMenu);
	}

	/**
	 * 支持传统的页面提交方式删除菜单
	 */
	public boolean remove(Object myaction) throws Exception {

		IdMenuAction action = (IdMenuAction) myaction;
		String menuid = action.getParameter("menuid");

		removeUserUseMenu(menuid);

		removeRoleUseMenuButton(menuid);

		removeRoleUseMenu(menuid);

		boolean deleteSuccess = getBaseDao().deleteAll("TSysMenu", "menuid", "like", menuid);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_MENU,
					SysConstants.LOG_ACTION_DEL, action.getRequest().getRemoteAddr());
		}
		return deleteSuccess;
	}

	private boolean removeUserUseMenu(String menuid) throws Exception {

		return getBaseDao().deleteAll("TSysUserMenu", "menuid", "like", menuid);
	}

	private boolean removeRoleUseMenu(String menuid) throws Exception {

		return getBaseDao().deleteAll("TSysRoleMenu", "menuid", "like", menuid);
	}

	private boolean removeRoleUseMenuButton(String menuid) throws Exception {

		return getBaseDao().deleteAll("TSysRoleMenuButton", "menuid", "like", menuid);
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		IdMenuAction action = (IdMenuAction) myaction;
		TSysMenu menu = action.getTsysMenu();
		if (null == menu) {

			action.addActionError("保存失败[ 被保存的对象为null ]");
		} else {
			if (StringUtil.isBlank(menu.getMenuid())) {

				String newMenuid = getNewMenuIdByParentMenuId(menu.getUpmenuid());
				menu.setMenuid(newMenuid);
				menu.setDepth((short) (newMenuid.length() / 3));
				if (menu.getState() == null || menu.getState().equals("")) {
					menu.setState("1");
				}
				getBaseDao().save(menu);
				BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_MENU,
						SysConstants.LOG_ACTION_SAVE, action.getRequest().getRemoteAddr());
			} else {

				getBaseDao().update(menu);
				BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_MENU,
						SysConstants.LOG_ACTION_UPDATE, action.getRequest().getRemoteAddr());
			}
			action.setParameter("refresh", true);
		}
	}

	/**
	 * 生成新的ID号 规则：根据父ID查询其下一级最大的ID号，然后增加一。
	 * 
	 * @param parentid
	 * @return 新的ID号
	 * @throws Exception
	 */
	private static String getNewMenuIdByParentMenuId(String parentid) throws Exception {

		return SeqFactory.getNewTreeIdByParentId("T_Sys_Menu", "menuid", "upMenuId", parentid);
	}
}
