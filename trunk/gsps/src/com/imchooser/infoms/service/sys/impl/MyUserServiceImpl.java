/**
 * MyUserServiceImpl.java
 */
package com.imchooser.infoms.service.sys.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.identity.action.IdUserAction;
import com.imchooser.framework.identity.entity.TSysUser;
import com.imchooser.framework.identity.service.impl.IdUserServiceImpl;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.sys.MyUserAction;
import com.imchooser.infoms.util.BusinessLogUtil;
import com.imchooser.infoms.util.PropConfigUtil;
import com.imchooser.infoms.util.SQLConfigUtil;

/**
 * 高校、市县用户可以增加下级账户。 高校添加院系用户，市县添加中学用户。
 * 
 * @author Yangjianliang datetime 2009-2-11
 */
public class MyUserServiceImpl extends IdUserServiceImpl {

	private static final Log log = LogFactory.getLog(MyUserServiceImpl.class);

	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		IdUserAction action = (IdUserAction) myaction;
		TSysUser tsysUser = action.getTsysUser();
		String mydepartid = action.getLoginUser().getDepart().getDepartid();

		String hql = null;
		String qgroup = action.getRequest().getParameter("qgroup");// 按用户组查询
		if (qgroup == null || qgroup.trim().equals("")) {
			// hql = "from TSysUser as a inner join a.depart as b where
			// b.departid like ? and b.departid!=?";
			// modify by yangjianliang at 20090506 市县多用户需求，放开可以为本部门去添加其他账户
			hql = "from TSysUser as a inner join a.depart as b where b.departid like ?";
		} else {
			hql = "from TSysUser as a inner join a.depart as b, TSysUserGroup as c where a.userid=c.userid and b.departid like ?";
			hql += " and c.groupid='" + qgroup + "'";
		}

		if (tsysUser != null) {
			if (tsysUser.getDepart() != null
					&& tsysUser.getDepart().getDepartname() != null
					&& !tsysUser.getDepart().getDepartname().equals("")) {

				hql += " and b.departname like '%"
						+ tsysUser.getDepart().getDepartname() + "%'";
			}
			if (tsysUser.getUserLoginId() != null
					&& !tsysUser.getUserLoginId().equals("")) {
				hql += " and a.userLoginId like '%" + tsysUser.getUserLoginId()
						+ "%'";
			}
			if (tsysUser.getUserName() != null
					&& !tsysUser.getUserName().equals("")) {
				hql += " and a.userName like '%" + tsysUser.getUserName()
						+ "%'";
			}
			if (tsysUser.getState() != null && !tsysUser.getState().equals("")
					&& !tsysUser.getState().equals("-1")) {

				if (tsysUser.getState().equals("0")) {
					hql += " and a.state='0'";
				} else {
					hql += " and a.state!='0'";
				}
			}
		}

		pager.setTotalRows(getBaseDao().count("select count(*) " + hql,
				mydepartid + "%"));

		hql = "select new TSysUser(a.userid, a.userLoginId, a.userName, a.state, b.departname) "
				+ hql + " order by a.userid desc";
		List<?> tsysUsers = getBaseDao().findPageByHql(hql, pager,
				mydepartid + "%");

		action.setParameter("allGroups", queryGroups());
		return tsysUsers;
	}

	@Override
	public boolean remove(Object myaction) throws Exception {
		MyUserAction action = (MyUserAction) myaction;
		String userid = action.getParameter("wid");
		String proceduceName = SQLConfigUtil.getProcName("procd.deleteuser");
		String mes = DBUtil.execOracleProcQueryString(proceduceName, userid);
		boolean f = false;
		if (Constants.MESSAGE_RETURN_SUCCESS_CODE.equals(mes)) {
			f = super.remove(myaction);
		} else if (Constants.MESSAGE_RETURN_FAILURE_CODE.equals(mes)) {
			action.addActionMessage("用户已在使用中，目前不能删除！");
			f = false;
		}
		if (f) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
					Constants.CZDX_T_SYS_USER, Constants.LOG_ACTION_DEL);
		}
		return f;
	}

	@Override
	public void openCreate(Object myaction) throws Exception {

		super.openCreate(myaction);

	}

	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
		MyUserAction action = (MyUserAction) myaction;
		TSysUser tsysUser = action.getTsysUser();
		String myLoginid = action.getUserLoginId();

		// Object o = super.saveOrUpdate(myaction);
		if (tsysUser == null) {

			action.addActionError("保存失败[ 被保存的对象为null ]");
		} else {

			// 下面把菜单保存到页面显示
			action.setParameter("menues", action.getParameter("menues"));
			action.setParameter("allGroups", queryGroups());
			action.setParameter("groups", action.getParameters("groups"));

			if (tsysUser.getUserid() == null || tsysUser.getUserid().equals("")) {

				String uuloginid = tsysUser.getUserLoginId();
				tsysUser.setUserLoginId(myLoginid.split("-")[0] + "-"
						+ uuloginid);// 下级用户登录名自动带上上级名称

				String hql = "select count(*) from TSysUser where userloginid=?";
				long i = getBaseDao().count(hql, tsysUser.getUserLoginId());
				if (i > 0) {
					// 登录账户不允许重复
					action.setParameter("pleaseChange", true);
					tsysUser.setUserLoginId(uuloginid);
					throw new Exception("登录账号已经存在，请更换其他账号！");
				}
				/** ** 限制一个部门下的账户不能多于x个 **** */
				hql = "select count(*) from TSysUser where depart.departid=?";
				i = getBaseDao().count(hql, tsysUser.getDepart().getDepartid());
				if ("7".equals(action.getDepart().getDeparttype())
						&& action.getDepartID().equals(
								tsysUser.getDepart().getDepartid())) {
					// 区县用户可以添加多个同级账户
					String count = PropConfigUtil.get(Constants.QXTJYHZDS);
					int a = 0;
					if (count != null) {
						try {
							a = Integer.parseInt(count);
						} catch (Exception e) {
							log.error("没有取到市县添加本级用户最大数限制，将使用默认最大人数5！");
							a = 5;
						}
					}
					if (i >= a ) {
						action.setParameter("pleaseChange", true);
						tsysUser.setUserLoginId(uuloginid);
						throw new Exception("市县添加本级用户最大数，限只能有" + a + "个同级的登录用户！");
					}
				} else {
					// 区县以外用户默认添加同一部门下的账户
					String count = PropConfigUtil.get(Constants.TJZHZDS);
					int a = 0;
					if (count != null) {
						try {
							a = Integer.parseInt(count);
						} catch (Exception e) {
							log.error("没有取到同一部门下添加用户最大数限制，将使用默认最大人数4！");
							a = 4;
						}
					}
					if (i >= a ) {
						action.setParameter("pleaseChange", true);
						tsysUser.setUserLoginId(uuloginid);
						throw new Exception("同一部门下，限只能有" + a + "个同级的登录用户！");
					}
				}

				tsysUser.setUserid(SeqFactory.getNewSequenceAlone());
				if (tsysUser.getUserPwd() == null) {
					// 如果用户没有指定密码，则使用初始化密码
					tsysUser.setUserPwd("");
				}
				getBaseDao().save(tsysUser);
				// 新增的时候执行初始化菜单，修改不用执行
				String proceduceName = SQLConfigUtil
						.getProcName("procd.adduser");
				DBUtil.execOracleProcQueryString(proceduceName, tsysUser
						.getUserid(), tsysUser.getDepart().getDepartid());
				BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
						Constants.CZDX_T_SYS_USER, Constants.LOG_ACTION_SAVE);

			} else {

				String hql = "select userLoginId from TSysUser where userid=?";
				String userLoginId = (String) getBaseDao().findFieldValue(hql,
						tsysUser.getUserid());
				if (!userLoginId.equals(tsysUser.getUserLoginId())) {
					// 登录账户不允许重复
					throw new Exception("登录账号不可更改，请恢复先前的账号再提交！");
				}

				getBaseDao().update(tsysUser);
				BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
						Constants.CZDX_T_SYS_USER, Constants.LOG_ACTION_UPDATE);
			}
		}

	}

}
