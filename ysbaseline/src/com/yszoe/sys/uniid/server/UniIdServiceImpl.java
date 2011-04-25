package com.yszoe.sys.uniid.server;

import java.rmi.Naming;
import java.sql.SQLException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.framework.identity.IdConstants;
import com.yszoe.framework.identity.entity.LoginUserVO;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.sys.uniid.client.LocalSessionService;
import com.yszoe.sys.util.PropConfigUtil;
import com.yszoe.uniid.UniIdService;

/**
 * 统一身份认证类
 * 
 * @author Yangjianliang 
 * datetime 2009-12-14
 */
public class UniIdServiceImpl implements UniIdService {

	private static final Log LOG = LogFactory.getLog(UniIdServiceImpl.class);

	/**
	 * 集群内全部在线用户数
	 * 
	 * @return 集群内全部在线用户数
	 */
	public int getSize() {

		return getOnlineUserCount();
	}

	/**
	 * 集群内全部在线用户数
	 * 
	 * @return 集群内全部在线用户数
	 */
	public static int getOnlineUserCount() {
		String sql = "select count(*) from T_SYS_ONLINE";
		int onlineSize = 0;
		try {
			Object val = DBUtil.queryFieldValue(sql);
			String s_val = String.valueOf(val);
			if (s_val != null) {
				onlineSize = Integer.parseInt(s_val);
			}
		} catch (SQLException e) {
			LOG.error(e);
		}
		return onlineSize;
	}

	/**
	 * 指定的用户是否已经登录
	 * 
	 * @param userLoginId 用户登录账号
	 * @return 已登记返回true
	 */
	public boolean isThisUserlogined(String userLoginId) {

		return isThisUserAlreadyLogined(userLoginId);
	}

	/**
	 * 指定的用户是否已经登录
	 * 
	 * @param userLoginId 用户登录账号
	 * @return 已登记返回true
	 */
	public static boolean isThisUserAlreadyLogined(String userLoginId) {

		if (PropConfigUtil.getBoolean(IdConstants.SINGLE_LOGIN)) {
			// 集群全局登录控制
			String userLoginServerIP = getUserLoginServerIP(userLoginId);
			return userLoginServerIP != null;
		} else {
			// 单应用节点登录控制
			return LoginUserVO.isThisUserLogined(userLoginId);
		}
	}

	/**
	 * 从SSO服务器上移除一个用户
	 * 
	 * @param userLoginId 用户登录账号
	 * @throws Exception
	 */
	public void removeThisUser(String userLoginId) throws Exception {

		String userLoginServerIP = getUserLoginServerIP(userLoginId);
		if (userLoginServerIP == null) {
			// 在线用户表里查不到相关记录，说明此账户目前就一个在登陆
		} else {
			int sl = userLoginServerIP.split("\\.").length;
			if (sl != 4) {
				throw new Exception("移除在线用户失败：因为获取在线用户的登录服务器的IP地址不正确！");
			}
			String serverAddress = "rmi://" + userLoginServerIP + ":1199/NodeSessionService";
			LocalSessionService localSessionService = null;
			try {
				Object remoteObject = Naming.lookup(serverAddress);
				localSessionService = (LocalSessionService) remoteObject;
			} catch (Exception e) {
				LOG.error(e);
				throw new Exception("移除在线用户失败：因为获取远程SESSION操作接口失败！");
			}
			localSessionService.removeThisUserSession(userLoginId);// 移除远程节点上的用户SESSION信息
		}
	}

	/**
	 * 查询在线用户表，获得指定用户登录节点的IP地址
	 * 
	 * @param userLoginId
	 * @return 获得指定用户登录节点的IP地址；如果不存在指定用户登录信息，返回NULL
	 * @throws SQLException
	 */
	protected static String getUserLoginServerIP(String userLoginId) {
		String sql = "select SERVER_IP from T_SYS_ONLINE where LOGINID=?";
		String userLoginServerIP = null;
		try {
			userLoginServerIP = (String) DBUtil.queryFieldValue(sql, userLoginId);
		} catch (SQLException e) {
			LOG.error(e);
		}
		return userLoginServerIP;
	}

}
