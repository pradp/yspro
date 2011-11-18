package com.yszoe.identity.service;

import java.util.List;

import com.yszoe.framework.service.BaseService;
import com.yszoe.identity.entity.TSysButton;
import com.yszoe.identity.entity.TSysMenu;
import com.yszoe.identity.entity.TSysUser;

public interface IdUserService extends BaseService {

	/**
	 * 根据用户登录ID查询用户信息
	 * 
	 * @param loginID 用户登录ID
	 * @return 用户对象User实体
	 */
	public TSysUser entity(String loginID);

	/**
	 * 加载用户权限下的菜单
	 * 
	 * @param user
	 * @return 菜单集合
	 */
	public List<TSysMenu> loadMyMenu(TSysUser user);

	/**
	 * 用户修改密码
	 * 
	 * @param sessionUser session中的用户信息
	 * @param user 用户页面提交上来的用户信息
	 * @return 修改结果（成功、失败，或是其他消息）
	 */
	public String modifyPassword(TSysUser sessionUser, TSysUser user);

	/**
	 * 加载用户权限下的菜单按钮
	 * 
	 * @param user
	 * @return 菜单按钮集合
	 */
	public List<TSysButton> loadMyMenuButton(TSysUser user);
}
