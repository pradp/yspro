package com.yszoe.sys.util;

import java.util.ResourceBundle;

import com.yszoe.framework.jdbc.DBConn;

/**
 * 提供全局应用获取SQL语句
 * SQL统一管理，便于数据库维护移植等
 * @author Yangjianliang
 * datetime 2011-7-11
 */
public class SQLConfigUtil {

	private static ResourceBundle sqlmap_resource ;
	
	static{
		//DBConn.DATABASE_TYPE是dbconfig.properties文件里定义的当前数据库类型
		sqlmap_resource = ResourceBundle.getBundle("dbsql.sqlmap_" + DBConn.DATABASE_TYPE);
	}
	
	/**
	 * 直接从配置文件中取 sql 语句
	 * @param key 
	 * @return
	 */
	public static String getSql(String key){

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
