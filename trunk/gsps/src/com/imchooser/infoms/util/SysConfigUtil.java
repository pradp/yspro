package com.imchooser.infoms.util;

import java.util.ResourceBundle;

/**
 * 对应sysconfig.properties文件
 * 
 * @author Yangjianliang
 * datetime 2009-1-20
 */
public class SysConfigUtil {

	private static final ResourceBundle sys_cfg = ResourceBundle.getBundle("sysconfig");

	/**
	 * 根据KEY从配置文件中取值
	 * @param key 
	 * @return
	 */
	public static String getString(String key){

		return sys_cfg.getString(key);
	}

	/**
	 * 根据KEY从配置文件中取值，对应多组值，以数组的形式返回
	 * @param key 
	 * @return
	 */
	public static String[] getStringArray(String key){

		return sys_cfg.getStringArray(key);
	}

}
