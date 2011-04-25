package com.imchooser.infoms.uniid.client;

import java.rmi.Remote;

/**
 * 本地SESSION操作服务类。
 * 集群环境下，WEBSPHERE的session共享能感知其他节点的session，但不能移除其他服务器上的用户SESSION。
 * 所以采用本类，对外提供一个RMI服务，统一身份认证服务器在接受到用户退出（失效等），
 * 调用各个节点的此方法，来达到移除集群节点上的用户SESSION。
 * @author Yangjianliang
 * datetime 2009-12-11
 */
public interface LocalSessionService extends Remote{

	/**
	 * 提供给外部程序移除本节点应用上的用户session的功能。
	 * @param userLoginId 要移除的用户的登录账号
	 * @return 移除成功，返回1；失败则返回0
	 * @throws Exception
	 */
	int removeThisUserSession(String userLoginId) throws Exception;
	
}
