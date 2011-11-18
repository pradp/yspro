/***********************************************************
 * 
 * 说 明：身份系统常量字典表
 * 作 者：杨建亮
 * 日 期：2007-10-29
 *
 **********************************************************/
package com.yszoe.identity;

public interface IdConstants {

	String SYS_URI_SUFFIX = "action";//URI的后缀名
	
	String SESSION_USER = "ys_LoginUser";//用户对象

	String SESSION_USER_RIGHT_MENUS = "ys_MyRightMenues";//用户有权限可以访问的菜单
	
	String SESSION_USER_RIGHT_MENUBUTTONS = "ys_MyRightMenueButtons";//用户有权限可以访问的菜单下自定义按钮
	
	String LOGIN_VALIDATE_IMAGE_CONTENT = "ys_image4login_rand";//登录验证码图片内容存在session里，此session的id键名
	
	String OPEN_CHECK_URL_RIGHT = "open_checkUrlRight";//ys_jd_framework_cfg.properties文件里配置 是否开启URL权限验证 功能
	
	String OPEN_U_V_I_C = "open_U_V_I_C";//ys_jd_framework_cfg.properties文件里配置 是否开启登录验证码功能
	
	String SINGLE_LOGIN = "singleLogin";//是否开启了同一用户同一时间所有节点上只能登录一个的要求

	String NO_SINGLE_LOGIN_USERTYPE = "noSingleLogin.userType";//允许同时登陆的账户类型
	
	String MAX_ONLINE_COUNT = "maxOnlineCount";//单个节点应用下允许同时登录的最大人数
	
	String AREA_TO_DEPART = "areaToDepart"; //新增区域时是否关联部门

	/**
	 * 用户状态：0
	 * 禁用，不能登录
	 */
	String USER_STATE_FORBID = "0";
	/**
	 * 用户状态：1
	 * 可用，同时开启用户关联菜单和角色关联菜单（默认模式） 
	 */
	String USER_STATE_ALLOW_DOUBLEMEMU = "1";
	/**
	 * 用户状态：2
	 * 可用，仅使用授权菜单到角色的菜单(经典模式)
	 */
	String USER_STATE_ALLOW_ROLEMEMU = "2";
	/**
	 * 用户状态：3
	 * 可用，仅使用授权菜单到用户的菜单（扩展模式）
	 */
	String USER_STATE_ALLOW_USERMEMU = "3";
	
	/**
	 * 身份类型：无特殊身份
	 * 空字符串，不是null
	 */
	String USER_TYPE_NULL = "";

	/**
	 * 身份类型：业务主管
	 * 对应值为1
	 */
	String USER_TYPE_BIZ_DIRECTOR = "1";

	/**
	 * 用于传递request.getRequestURI()值
	 */
	String CurrentRequestURI = "CurrentRequestURI";
}
