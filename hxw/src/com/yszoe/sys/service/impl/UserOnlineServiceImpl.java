package com.yszoe.sys.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.identity.entity.LoginUserVO;
import com.yszoe.sys.action.UserOnlineAction;
import com.yszoe.util.CollectionUtil;

public class UserOnlineServiceImpl extends AbstractBaseServiceSupport {

	@SuppressWarnings("unchecked")
	public List list(Object arg0, Pager arg1) throws Exception {
		UserOnlineAction action = (UserOnlineAction) arg0;
		LoginUserVO queryuser = action.getLoginUserVO();

		List<LoginUserVO> users = LoginUserVO.getOnlineUsers();
		List<LoginUserVO> userResultSet = null;
		// 对数组中的信息进行过滤查询
		if (queryuser != null) {
			userResultSet = new ArrayList<LoginUserVO>();
			for (int i = 0, j = users.size(); i < j; i++) {
				LoginUserVO user = (LoginUserVO) users.get(i);
				String username = user.getUsername();
				String userLoginId = user.getUserloginid();
				String departName = user.getDepart().getDepartname();
				boolean isAllEmpty = true;
				if ((StringUtils.isNotBlank(queryuser.getUsername()))
						&& (StringUtils.isBlank(queryuser.getUserloginid()))
						&& (StringUtils.isBlank(queryuser.getDepart()
								.getDepartname()))) {
					isAllEmpty = false;
					if (username.indexOf(queryuser.getUsername()) != -1) {
						userResultSet.add(user);
					} else {
						continue;
					}
				} else if ((StringUtils.isNotBlank(queryuser.getUserloginid()))
						&& (StringUtils.isBlank(queryuser.getUsername()))
						&& (StringUtils.isBlank(queryuser.getDepart()
								.getDepartname()))) {
					isAllEmpty = false;
					if (userLoginId.indexOf(queryuser.getUserloginid()) != -1) {
						userResultSet.add(user);
					} else {
						continue;
					}
				} else if ((StringUtils.isNotBlank(queryuser.getDepart()
						.getDepartname()))
						&& (StringUtils.isBlank(queryuser.getUserloginid()))
						&& (StringUtils.isBlank(queryuser.getUsername()))) {
					isAllEmpty = false;
					if (departName.indexOf(queryuser.getDepart()
							.getDepartname()) != -1) {
						userResultSet.add(user);
					} else {
						continue;
					}
				} else if ((StringUtils.isNotBlank(queryuser.getUsername()))
						&& (StringUtils.isNotBlank(queryuser.getUserloginid()))
						&& (StringUtils.isBlank(queryuser.getDepart()
								.getDepartname()))) {
					isAllEmpty = false;
					if (username.indexOf(queryuser.getUsername()) != -1
							&& userLoginId.indexOf(queryuser.getUserloginid()) != -1) {
						userResultSet.add(user);
					} else {
						continue;
					}
				} else if ((StringUtils.isBlank(queryuser.getUsername()))
						&& (StringUtils.isNotBlank(queryuser.getUserloginid()))
						&& (StringUtils.isNotBlank(queryuser.getDepart()
								.getDepartname()))) {
					isAllEmpty = false;
					if (departName.indexOf(queryuser.getDepart()
							.getDepartname()) != -1
							&& userLoginId.indexOf(queryuser.getUserloginid()) != -1) {
						userResultSet.add(user);
					} else {
						continue;
					}
				} else if ((StringUtils.isNotBlank(queryuser.getUsername()))
						&& (StringUtils.isBlank(queryuser.getUserloginid()))
						&& (StringUtils.isNotBlank(queryuser.getDepart()
								.getDepartname()))) {
					isAllEmpty = false;
					if (username.indexOf(queryuser.getUsername()) != -1
							&& departName.indexOf(queryuser.getDepart()
									.getDepartname()) != -1) {
						userResultSet.add(user);
					} else {
						continue;
					}
				} else if ((StringUtils.isNotBlank(queryuser.getUsername()))
						&& (StringUtils.isNotBlank(queryuser.getUserloginid()))
						&& (StringUtils.isNotBlank(queryuser.getDepart()
								.getDepartname()))) {
					isAllEmpty = false;
					if (userLoginId.indexOf(queryuser.getUserloginid()) != -1
							&& departName.indexOf(queryuser.getDepart()
									.getDepartname()) != -1
							&& username.indexOf(queryuser.getUsername()) != -1) {
						userResultSet.add(user);
					} else {
						continue;
					}
				}
				if (isAllEmpty) {
					userResultSet.add(user);
				}
			}
		} else {
			userResultSet = users;
		}
		// 对查询出的信息有重复的,只显示一次
		userResultSet = CollectionUtil.removeRepeat(userResultSet);
		action.setParameter("users", users);
		return userResultSet;
	}

	public void load(Object arg0) throws Exception {

	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {

	}

}
