package com.yszoe.identity.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.identity.IdConstants;
import com.yszoe.identity.action.IdUserAction;
import com.yszoe.identity.entity.TSysButton;
import com.yszoe.identity.entity.TSysGroup;
import com.yszoe.identity.entity.TSysMenu;
import com.yszoe.identity.entity.TSysUser;
import com.yszoe.identity.entity.TSysUserGroup;
import com.yszoe.identity.entity.TSysUserMenu;
import com.yszoe.identity.service.IdUserCustomExtService;
import com.yszoe.identity.service.IdUserService;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.util.BusinessLogUtil;
import com.yszoe.util.StringUtil;

public class IdUserServiceImpl extends AbstractBaseServiceSupport implements IdUserService {

	private IdUserCustomExtService idUserCustomExtService;

	public TSysUser entity(String userLoginId) {
		// 登录时候查询用户信息
		String hql = "from TSysUser where userloginid = ?";
		TSysUser user = (TSysUser) getBaseDao().findFieldValue(hql, userLoginId);
		return user;
	}

	public List<TSysMenu> loadMyMenu(TSysUser user) {

		List<TSysMenu> tsysMemues = null;
		if (IdConstants.USER_STATE_ALLOW_ROLEMEMU.equals(user.getState())) {

			tsysMemues = loadMenuOnlyByRole(user.getUserid());
		} else if (IdConstants.USER_STATE_ALLOW_USERMEMU.equals(user.getState())) {

			tsysMemues = loadMenuOnlyByUser(user.getUserid());
		} else if (IdConstants.USER_STATE_ALLOW_DOUBLEMEMU.equals(user.getState())) {

			tsysMemues = loadMenuByDoubleModel(user.getUserid());
		} else {
			tsysMemues = new ArrayList<TSysMenu>(0);
		}
		// 去除重复元素
		if (tsysMemues != null) {
			tsysMemues = new ArrayList<TSysMenu>(new LinkedHashSet<TSysMenu>(tsysMemues));
		}
		return tsysMemues;
	}

	public List<?> list(Object myaction, Pager pager) throws Exception {
		IdUserAction action = (IdUserAction) myaction;
		TSysUser tsysUser = action.getTsysUser();
		String mydepartid = action.getLoginuser().getDepart().getDepartid();

		String hql = null;
		String qgroup = action.getRequest().getParameter("qgroup");// 按用户组查询
		if (qgroup == null || qgroup.trim().equals("")) {
			hql = "from TSysUser as a inner join a.depart as b where b.departid like ?";
		} else {
			hql = "from TSysUser as a inner join a.depart as b, TSysUserGroup as c where a.userid=c.userid and b.departid like ?";
			hql += " and c.groupid='" + qgroup + "'";
		}

		if (tsysUser != null) {
			if (tsysUser.getDepart() != null && tsysUser.getDepart().getDepartname() != null
					&& !tsysUser.getDepart().getDepartname().equals("")) {

				hql += " and b.departname like '%" + tsysUser.getDepart().getDepartname() + "%'";
			}
			if (tsysUser.getUserloginid() != null && !tsysUser.getUserloginid().equals("")) {
				hql += " and a.userloginid like '%" + tsysUser.getUserloginid() + "%'";
			}
			if (tsysUser.getUsername() != null && !tsysUser.getUsername().equals("")) {
				hql += " and a.username like '%" + tsysUser.getUsername() + "%'";
			}
			if (tsysUser.getState() != null && !tsysUser.getState().equals("") && !tsysUser.getState().equals("-1")) {

				if (tsysUser.getState().equals("0")) {
					hql += " and a.state='0'";
				} else {
					hql += " and a.state!='0'";
				}
			}
		}

		pager.setTotalRows(getBaseDao().count("select count(*) " + hql, mydepartid + "%"));

		hql = "select new TSysUser(a.userid, a.userloginid, a.username, a.state, b.departname) " + hql
				+ " order by a.userid desc";
		List<TSysUser> tsysUsers = getBaseDao().findPageByHql(hql, pager, mydepartid + "%");

		action.setParameter("allGroups", queryGroups());
		return tsysUsers;
	}

	public void load(Object myaction) throws Exception {
		// 打开一个用户的信息
		IdUserAction action = (IdUserAction) myaction;
		String userid = action.getParameter("wid");
		String hql = "from TSysUser where userid = ?";
		TSysUser user = (TSysUser) getBaseDao().findFieldValue(hql, userid);
		action.setTsysUser(user);

		action.setParameter("menues", queryUserMenuid(userid));
		action.setParameter("allGroups", queryGroups());
		action.setParameter("groups", queryUserGroupsId(userid));

	}

	@Override
	public void openCreate(Object myaction) throws Exception {

		IdUserAction action = (IdUserAction) myaction;
		action.setParameter("allGroups", queryGroups());
	}

	/**
	 * 事务控制交给spring
	 */
	public boolean remove(Object myaction) throws Exception {
		IdUserAction action = (IdUserAction) myaction;
		String ids = action.getParameter("wid");
		if (StringUtil.isBlank(ids)) {
			throw new Exception("缺少参数！");
		}
		String userid = action.getLoginuser().getUserid();
		if (ids.equals(userid)) {
			throw new Exception("不能删除自己！");
		}
		removeMenu(ids);

		removeGroup(ids);

		List<TSysUser> sysUsers = null;
		if (idUserCustomExtService != null) {
			// spring容器配置了用户自定义扩展类
			String hql = "from TSysUser where " + DBUtil.spellSqlWhere("userid", "=", ids.split(","));
			sysUsers = getBaseDao().findByHql(hql);
		}
		boolean deleteSuccess = getBaseDao().deleteAll("TSysUser", "userid", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_USER,
					SysConstants.LOG_ACTION_DEL, action.getRequest().getRemoteAddr());
			if (idUserCustomExtService != null) {
				// 本系统删除成功，通知客户端方法
				idUserCustomExtService.afterRemove(sysUsers);
			}
		}
		return deleteSuccess;
	}

	private boolean removeMenu(String ids) throws Exception {

		return getBaseDao().deleteAll("TSysUserMenu", "userid", "=", ids);
	}

	private boolean removeGroup(String ids) throws Exception {

		return getBaseDao().deleteAll("TSysUserGroup", "userid", "=", ids);
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		IdUserAction action = (IdUserAction) myaction;
		TSysUser tsysUser = action.getTsysUser();

		// 下面把菜单保存到页面显示
		action.setParameter("menues", action.getParameter("menues"));
		action.setParameter("allGroups", queryGroups());
		action.setParameter("groups", action.getParameters("groups"));

		if (tsysUser.getUserid() == null || tsysUser.getUserid().equals("")) {

			String hql = "select count(*) from TSysUser where userloginid=?";
			long i = getBaseDao().count(hql, tsysUser.getUserloginid());
			if (i > 0) {
				// 登录账户不允许重复
				throw new Exception("登录账号已经存在，请更换其他账号！");
			}
			tsysUser.setUserid(SeqFactory.getNewSequenceAlone());
			if (tsysUser.getUserpwd() == null) {
				// 如果用户没有指定密码，则使用初始化密码
				tsysUser.setUserpwd("");
			}
			getBaseDao().save(tsysUser);

			saveUserGroups(action);

			// 新增用户菜单
			saveUserMenues(action);
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_USER,
					SysConstants.LOG_ACTION_SAVE, action.getRequest().getRemoteAddr());
			//判断用户状态是否为禁用，如果禁用不调用同步；
			if (idUserCustomExtService != null&&!tsysUser.getState().equals("0")) {
				// spring容器配置了用户自定义扩展类
				idUserCustomExtService.afterAdd(tsysUser);
			}
		} else {

			String hql = "select userloginid from TSysUser where userid=?";
			String userLoginId = (String) getBaseDao().findFieldValue(hql, tsysUser.getUserid());
			if (!userLoginId.equals(tsysUser.getUserloginid())) {
				// 登录账户不允许重复
				throw new Exception("登录账号不可更改，请恢复先前的账号再提交！");
			}
			removeUserGroups(action);

			saveUserGroups(action);

			// 更新用户菜单
			updateUserMenues(action);

			getBaseDao().update(tsysUser);
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_USER,
					SysConstants.LOG_ACTION_UPDATE, action.getRequest().getRemoteAddr());
			//判断用户状态是否为禁用，如果禁用不调用同步；
			if (idUserCustomExtService != null&&!tsysUser.getState().equals("0")) {
				// spring容器配置了用户自定义扩展类
				idUserCustomExtService.afterUpdate(tsysUser);
			}
		}
	}

	/**
	 * 取得此用户的权限菜单
	 * 
	 * @param userid
	 * @return
	 */
	protected String queryUserMenuid(String userid) {

		String hql = "select menuid from TSysUserMenu where userid=?";
		List<TSysUserMenu> menues__ = getBaseDao().findByHql(hql, userid);
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
	 * 取得此用户的所属组
	 * 
	 * @param userid
	 * @return
	 */
	protected String[] queryUserGroupsId(String userid) {

		String hql = "select a from TSysGroup a, TSysUserGroup b where a.groupid=b.groupid and b.userid=?";
		// String hql = "select roleid from TSysGroupRole where groupid=?";
		List<TSysGroup> groups = getBaseDao().findByHql(hql, userid);
		String[] ss = new String[groups.size()];
		for (int i = 0; i < groups.size(); i++) {
			TSysGroup o = groups.get(i);
			ss[i] = o.getGroupid();
		}
		return ss;
	}

	/**
	 * 取得此用户的所属组
	 * 
	 * @param userid
	 * @return
	 */
	protected List<TSysGroup> queryGroups() {

		String hql = "from TSysGroup where state = '1' order by groupid";
		List<TSysGroup> groups = getBaseDao().findByHql(hql);
		return groups;
	}

	/**
	 * 插入用户和用户组关联关系
	 * 
	 * @param action
	 */
	protected void saveUserGroups(IdUserAction action) {

		TSysUser tsysUser = action.getTsysUser();
		Object[] groups = action.getParameters("groups");

		if (groups != null) {
			// 更新权限，用户所属组表
			for (Object group : groups) {
				TSysUserGroup userGroup = new TSysUserGroup();
				userGroup.setId(SeqFactory.getNewSequenceAlone());
				userGroup.setUserid(tsysUser.getUserid());
				userGroup.setGroupid(group.toString().trim());
				getBaseDao().save(userGroup);
			}
		}
	}

	/**
	 * 删除用户和用户组关联关系
	 * 
	 * @param action
	 */
	protected void removeUserGroups(IdUserAction action) {

		TSysUser tsysUser = action.getTsysUser();
		getBaseDao().deleteAll("TSysUserGroup", "userid", "=", tsysUser.getUserid());
	}

	/**
	 * 更新权限，添加用户菜单关联
	 * 
	 * @param action
	 */
	protected void saveUserMenues(IdUserAction action) {

		String menues = action.getParameter("menues");
		if (menues != null && !menues.equals("") && !menues.equals("000")) {
			// 更新权限，用户菜单关联表
			TSysUser tsysUser = action.getTsysUser();
			menues = menues.replaceAll("000,", "");// 000节点是树的根节点，在权限菜单表中不需要保存

			String[] menues__ = menues.split(",");
			List<TSysUserMenu> userMenues = new ArrayList<TSysUserMenu>(menues__.length);
			for (int i = 0; i < menues__.length; i++) {
				String o = menues__[i];
				TSysUserMenu usermenu = new TSysUserMenu();
				usermenu.setId(SeqFactory.getNewSequenceAlone());
				usermenu.setUserid(tsysUser.getUserid());
				usermenu.setMenuid(o.trim());
				userMenues.add(usermenu);
				/*
				 * if(i%10==0 || i==menues__.length-1){ //满10，或者到最后一个了，做批量保存
				 * getBaseDao
				 * ().getHibernateTemplate().saveOrUpdateAll(userMenues);
				 * userMenues.clear(); }
				 */
			}
			getBaseDao().saveAll(userMenues);
			// do_menues.delete( do_menues.length()-1, do_menues.length() );

			/*
			 * String menues_return =
			 * DBUtil.execOracleProcQueryString(Config.getProcName
			 * ("proc_id_add_usermenues"), tsysUser.getUserid(),
			 * do_menues.toString()); if(menues_return==null ||
			 * !menues_return.equals( Constants.MESSAGE_RETURN_SUCCESS_CODE )){
			 * throw new Exception("用户修改失败。原因：设置权限菜单失败！"); }
			 */
		}
	}

	/**
	 * 更新权限，更新用户菜单关联
	 * 
	 * @param action
	 */
	protected void updateUserMenues(IdUserAction action) {

		String menues = action.getParameter("menues");
		if (menues == null) {
			return;
		} else if (!menues.equals("") && !menues.equals("000")) {
			// 用户修改部分菜单的情况。考虑到效率，采用只删除用户去掉的菜单，新增用户新选的菜单
			TSysUser tsysUser = action.getTsysUser();
			// 更新权限菜单表。把数据库中的和用户新提交的菜单比较，采用删除没有的，只添加新增的菜单的策略，提高效率
			menues = menues.replaceAll("000,", "");// 000节点是树的根节点，在权限菜单表中不需要保存

			String hql = "select menuid from TSysUserMenu where userid=?";
			List<TSysUserMenu> db_menues = getBaseDao().findByHql(hql, tsysUser.getUserid());
			if (db_menues != null && !db_menues.isEmpty()) {
				db_menues.remove("000");
			} else if (db_menues == null) {
				db_menues = Collections.emptyList();
			}
			List<TSysUserMenu> db_menues__clone = new ArrayList<TSysUserMenu>(db_menues);

			Object[] curr_menu = menues.split(",");
			List<String> curr_menues = new ArrayList<String>(curr_menu.length);
			for (Object o : curr_menu) {
				curr_menues.add(o.toString());
			}

			db_menues.removeAll(curr_menues);
			// 剩下的是需要删除的菜单
			if (db_menues.isEmpty() == false) {

				StringBuffer do_menues = new StringBuffer(" and (");
				hql = "delete from TSysUserMenu where userid=?";
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
				getBaseDao().delete(hql, tsysUser.getUserid());
			}

			curr_menues.removeAll(db_menues__clone);
			// 剩下的是需要增加的菜单
			if (curr_menues.isEmpty() == false) {

				// StringBuffer do_menues = new StringBuffer("");
				List<TSysUserMenu> userMenues = new ArrayList<TSysUserMenu>(curr_menues.size());
				for (int i = 0; i < curr_menues.size(); i++) {
					Object o = curr_menues.get(i);
					// do_menues.append(o.toString()).append(",");
					TSysUserMenu usermenu = new TSysUserMenu();
					usermenu.setId(SeqFactory.getNewSequenceAlone());
					usermenu.setUserid(tsysUser.getUserid());
					usermenu.setMenuid(o.toString().trim());
					userMenues.add(usermenu);
				}
				getBaseDao().saveAll(userMenues);
			}
		} else if (menues.equals("")) {

			TSysUser tsysUser = action.getTsysUser();
			getBaseDao().deleteAll("TSysUserMenu", "userid", "=", tsysUser.getUserid());
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.imchooser.framework.identity.service.IdUserService#modifyPassword
	 * (com.imchooser.framework.identity.entity.TSysUser,
	 * com.imchooser.framework.identity.entity.TSysUser)
	 */
	public String modifyPassword(TSysUser sessionUser, TSysUser user) {

		String mess = null;
		if (sessionUser == null || user == null) {
			mess = "用户信息不存在！";
		} else {
			if (sessionUser.getUserpwd().equals(user.getUsername())) {
				// getUserName存储用户提交的原密码
				String hql = "update TSysUser set userpwd=? where userid=?";
				String pwd = user.getUserpwd();
				String userid = sessionUser.getUserid();
				pwd = pwd == null ? "" : pwd;
				userid = userid == null ? "" : userid;
				try {
					getBaseDao().executeHql(hql, pwd, userid);
					mess = "修改成功";
					sessionUser.setUserpwd(pwd);// 更新session中的为新密码
				} catch (Exception e) {
					mess = "修改失败：" + e.getMessage();
				}
			} else {
				mess = "您输入的原密码错误！";
			}
		}
		return mess;
	}

	/**
	 * 加载用户拥有的菜单（指所属用户组拥有的菜单）
	 * 
	 * @param userid 登录用户的编号
	 * @return
	 */
	private List<TSysMenu> loadMenuOnlyByRole(String userid) {

		String hql = "select new TSysMenu(x.menuid, x.menuname, x.menupath, x.upmenuid, x.depth, x.state,x.ordernum, x.share2enterprise,"
				+ "(select count(*) from TSysMenu where upmenuid=x.menuid) as childMenuCount) "
				+ "from TSysMenu x, TSysRoleMenu a, TSysRole b, TSysGroupRole c, TSysGroup g, TSysUserGroup d "
				+ "where a.roleid=b.roleid and b.roleid=c.roleid and c.groupid=g.groupid and g.groupid=d.groupid and d.userid=? and x.menuid=a.menuid "
				+ "and g.state=1 and b.state=1 and x.state=1 order by x.upmenuid,x.ordernum desc ";
		List<TSysMenu> tsysMemues = getBaseDao().findByHql(hql, userid);
		return tsysMemues;
	}

	/**
	 * 加载用户拥有的菜单（指为某个用户单独指定的菜单）
	 * 
	 * @param userid 登录用户的编号
	 * @return
	 */
	private List<TSysMenu> loadMenuOnlyByUser(String userid) {

		String hql = "select x from TSysMenu x, TSysUserMenu m where x.state=1 and m.userid=? and x.menuid=m.menuid order by x.upmenuid,x.ordernum desc";
		List<TSysMenu> tsysMemues = getBaseDao().findByHql(hql, userid);
		return tsysMemues;
	}

	/**
	 * 加载用户拥有的菜单（包含为某个用户单独指定的菜单 和 通过用户组继承的菜单）
	 * 
	 * @param userid 登录用户的编号
	 * @return
	 */
	private List<TSysMenu> loadMenuByDoubleModel(String userid) {
		// HQL 不支持 union 语句
		String hql = "select x from TSysMenu x where x.state=1 and (x.menuid in ( "
				+ "select distinct a.menuid from TSysRoleMenu a, TSysRole b, TSysGroupRole c, TSysGroup g, TSysUserGroup d "
				+ "where a.roleid=b.roleid and b.roleid=c.roleid and c.groupid=g.groupid and g.groupid=d.groupid and g.state=1 and b.state=1 and x.state=1 and d.userid=?) "
				+ "or x.menuid in ( select distinct m.menuid from TSysUserMenu m where m.userid=? ) ) "
				+ "order by x.upmenuid, x.ordernum desc";

		List<TSysMenu> tsysMemues = getBaseDao().findByHql(hql, userid, userid);

		return tsysMemues;
	}

	@Override
	public List<TSysButton> loadMyMenuButton(TSysUser user) {
		String hql = " select new TSysButton(b.buttonid, b.buttonname, b.buttonevent,"
				+ " b.buttonicon, b.state,b.share2enterprise, b.memo, b.ordernum, a.menuid)"
				+ " from TSysRoleMenuButton a,TSysButton b,TSysGroupRole c,TSysUserGroup d,TSysUser e"
				+ " where a.roleid=c.roleid and a.buttonid=b.buttonid and c.groupid=d.groupid and d.userid=e.userid"
				+ " and e.userloginid=? and b.state=1 order by b.ordernum desc";
		return getBaseDao().findByHqlWithSecondCache(true, hql, user.getUserloginid());
	}

	public IdUserCustomExtService getIdUserCustomExtService() {
		return idUserCustomExtService;
	}

	public void setIdUserCustomExtService(IdUserCustomExtService idUserCustomExtService) {
		this.idUserCustomExtService = idUserCustomExtService;
	}

}
