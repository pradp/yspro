package com.yszoe.identity.service;

import java.util.List;

import com.yszoe.identity.entity.TSysUser;

/**
 * IdUserService类里的增删改每个方法执行前和执行后都会调用这里的接口。具体实现在spring里注入。
 * @author Yangjianliang
 * datetime 2011-8-11
 */
public interface IdUserCustomExtService {

	/**
	 * IdUserService类里的删方法执行成功后调用该接口
	 * @param idUser
	 */
	void afterRemove(List<TSysUser> sysUsers);

	/**
	 * IdUserService类里的增方法执行成功后调用该接口
	 * @param idUser
	 */
	void afterAdd(TSysUser sysUser);

	/**
	 * IdUserService类里的改方法执行成功后调用该接口
	 * @param idUser
	 */
	void afterUpdate(TSysUser sysUser);
}
