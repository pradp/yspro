package com.yszoe.sys.util;

import java.util.ResourceBundle;


public class SQLConfigUtil {

	private static final ResourceBundle sqlmap_resource = ResourceBundle.getBundle("sqlmap");

	/**
	 * 直接从配置文件中取 sql 语句
	 * @param key 
	 * @return
	 */
	public static String getSqlString(String key){

		String pd = sqlmap_resource.getString( key );
		return pd;
	}

	/**
	 * 直接从配置文件中取 存储过程名称
	 * @param key 
	 * @return
	 */
	public static String getProcName(String key){

		String pd = sqlmap_resource.getString( key );
		return pd;
	}
}
