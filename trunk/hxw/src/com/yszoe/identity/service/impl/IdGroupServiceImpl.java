package com.yszoe.identity.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.identity.action.IdGroupAction;
import com.yszoe.identity.entity.TSysGroup;
import com.yszoe.identity.entity.TSysGroupRole;
import com.yszoe.identity.entity.TSysRole;
import com.yszoe.identity.service.IdGroupService;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.util.BusinessLogUtil;

public class IdGroupServiceImpl extends AbstractBaseServiceSupport implements IdGroupService {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		IdGroupAction action = (IdGroupAction) myaction;
		TSysGroup tsysGroup = action.getTsysGroup();
		String hql = "from TSysGroup where 1=1";
		if (tsysGroup != null) {
			if (tsysGroup.getGroupid() != null && !tsysGroup.getGroupid().equals("")) {
				hql += " and groupid = '" + tsysGroup.getGroupid() + "'";
			}
			if (tsysGroup.getGroupname() != null && !tsysGroup.getGroupname().equals("")) {
				hql += " and groupname like '%" + tsysGroup.getGroupname() + "%'";
			}
			if (tsysGroup.getState() != null && !tsysGroup.getState().equals("")) {
				hql += " and state = '" + tsysGroup.getState() + "'";
			}
		}
		pager.setTotalRows(getBaseDao().count("select count(*) " + hql));

		hql = hql + " order by groupid";
		List<TSysGroup> tsysGroups = getBaseDao().findPageByHql(hql, pager);

		return tsysGroups;
	}

	/**
	 * 初始化页面数据
	 */
	@Override
	public void openCreate(Object myaction) throws Exception {

		IdGroupAction action = (IdGroupAction) myaction;

		// 下面取得所有加入该组的角色
		action.setParameter("myRoles", Collections.emptyList());
		action.setParameter("myRoles_id", new String[0]);

	}

	public void load(Object myaction) throws Exception {
		// query a Group
		IdGroupAction action = (IdGroupAction) myaction;
		String groupid = action.getParameter("wid");
		String hql = "from TSysGroup where groupid = ?";
		TSysGroup group = (TSysGroup) getBaseDao().findFieldValue(hql, groupid);
		action.setTsysGroup(group);

		// 下面取得所有加入该组的角色
		List<TSysRole> myRoles = queryGroupRoles(groupid);
		action.setParameter("myRoles", myRoles);

		String[] myRoles_id = getGroupRolesId(myRoles);
		action.setParameter("myRoles_id", myRoles_id);

	}

	/**
	 * 删除组同时删除关系表中的组数据：菜单与角色关联表、组与角色关联表 事务的控制交给spring配置
	 */
	public boolean remove(Object myaction) throws Exception {

		IdGroupAction action = (IdGroupAction) myaction;
		String ids = action.getParameter("wid");

		removeMenu(ids);

		removeGroup(ids);

		boolean deleteSuccess = getBaseDao().deleteAll("TSysGroup", "groupid", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_GROUP,
					SysConstants.LOG_ACTION_DEL, action.getRequest().getRemoteAddr());
		}
		return deleteSuccess;
	}

	private boolean removeMenu(String ids) throws Exception {

		return getBaseDao().deleteAll("TSysGroupRole", "groupid", "=", ids);
	}

	private boolean removeGroup(String ids) throws Exception {

		return getBaseDao().deleteAll("TSysUserGroup", "groupid", "=", ids);
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		IdGroupAction action = (IdGroupAction) myaction;
		TSysGroup tsysGroup = action.getTsysGroup();
		if (tsysGroup == null) {

			action.addActionError("保存失败 [ 被保存的对象为null ]");
		} else {

			if (tsysGroup.getGroupid() == null || tsysGroup.getGroupid().equals("")) {
				long c = getBaseDao().count("select count(*) from TSysGroup where groupname = ?",
						tsysGroup.getGroupname());
				if (c > 0) {
					throw new Exception("该用户组名已存在!");
				}
				tsysGroup.setGroupid(SeqFactory.getNewSequenceAlone());
				getBaseDao().save(tsysGroup);

				String[] roles__ = (String[]) action.getParameters("myRoles_id");

				if (roles__ != null && roles__.length > 0) {

					List<TSysGroupRole> groupRoles = new ArrayList<TSysGroupRole>(roles__.length);
					for (int i = 0; i < roles__.length; i++) {
						String o = roles__[i];
						TSysGroupRole role = new TSysGroupRole();
						role.setId(SeqFactory.getNewSequenceAlone());
						role.setGroupid(tsysGroup.getGroupid());
						role.setRoleid(o.trim());
						groupRoles.add(role);
					}
					getBaseDao().saveAll(groupRoles);
				}

				BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_GROUP,
						SysConstants.LOG_ACTION_SAVE, action.getRequest().getRemoteAddr());
			} else {
				long c = getBaseDao().count("select count(*) from TSysGroup where groupname=? and groupid!=?",
						tsysGroup.getGroupname(), tsysGroup.getGroupid());
				if (c > 0) {
					throw new Exception("该用户组名已存在!");
				}

				String[] roles__ = (String[]) action.getParameters("myRoles_id");

				if (roles__ != null && roles__.length > 0) {
					// 说明组拥有的角色修改过，否则页面层会判断，并不提交角色
					String hql = "delete from TSysGroupRole where groupid=? ";
					getBaseDao().delete(hql, tsysGroup.getGroupid());

					List<TSysGroupRole> groupRoles = new ArrayList<TSysGroupRole>(roles__.length);
					for (int i = 0; i < roles__.length; i++) {
						String o = roles__[i];
						TSysGroupRole role = new TSysGroupRole();
						role.setId(SeqFactory.getNewSequenceAlone());
						role.setGroupid(tsysGroup.getGroupid());
						role.setRoleid(o.trim());
						groupRoles.add(role);
					}
					getBaseDao().saveAll(groupRoles);
				}

				getBaseDao().update(tsysGroup);
				BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_GROUP,
						SysConstants.LOG_ACTION_UPDATE, action.getRequest().getRemoteAddr());
			}

			// 下面取得所有加入该组的角色，传递给页面显示
			List<TSysRole> myRoles = queryGroupRoles(tsysGroup.getGroupid());
			action.setParameter("myRoles", myRoles);

			String[] myRoles_id = getGroupRolesId(myRoles);
			action.setParameter("myRoles_id", myRoles_id);

		}
	}

	/**
	 * 取得此角色的权限菜单
	 * 
	 * @param Groupid
	 * @return
	 */
	private String[] getGroupRolesId(List<TSysRole> roles) {

		String[] id = new String[roles.size()];
		for (int i = 0; i < roles.size(); i++) {
			id[i] = roles.get(i).getRoleid();
		}
		return id;
	}

	private List<TSysRole> queryGroupRoles(String groupid) {

		String hql = "select a from TSysRole a, TSysGroupRole b where a.roleid=b.roleid and b.groupid=?";
		// String hql = "select roleid from TSysGroupRole where groupid=?";
		List<TSysRole> roles = getBaseDao().findByHql(hql, groupid);

		return roles;
	}
}
