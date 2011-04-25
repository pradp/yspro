package com.imchooser.infoms.service.sys;

import java.util.Map;

public interface AjaxService {

	/**
	 * 删除某个表中的记录
	 * @param targetTableObject hibernate bean name
	 * @param columnName column name
	 * @param columnValue cloumn values
	 * @return
	 */
//	public boolean remove(String targetTableObject, String columnName, String columnValue);

	/**
	 * 删除某个表中的记录。用于模糊匹配删除
	 * @param targetTableObject hibernate bean name
	 * @param columnName column name
	 * @param columnValue cloumn values
	 * @return
	 */
//	public boolean removeLike(String targetTableObject, String columnName, String columnValue);
	
	/**
	 * 改变记录的状态
	 * @param targetTableObject 对象名称
	 * @param keyColumnName 主键名称
	 * @param keyValue 主键值
	 * @param stateColumnName 要改变的状态的字段名称
	 * @param stateValue 改变后的值
	 * @return
	 */
//	public boolean changeState(String targetTableObject, String keyColumnName, String keyValue, String stateColumnName, String stateValue);
	
	/**
	 * 根据给定值检查表中是否存在这样的记录
	 * @param targetTable 要查询的表名 
	 * @param columnName 字段名称
	 * @param columnValue 值
	 * @return
	 */
	public boolean checkRecordExist(String targetTable, String columnName, String columnValue);
	
	/**
	 * 用于级联选择，返回html控件select需要的数据
	 * @param sqlmapid 要执行的SQL，存在与sqlmap.properties中。
	 * @param findValue 
	 * @return
	 */
	public Map<String,String> getSelectContents(String sqlmapid, String findValue) throws Exception;
 
	
	/**
	 * 查询比赛项目中的小项目名称
	 * @param dxmmc
	 * @return
	 * @throws Exception 
	 */
	public Map<String, String> getSelectDxmmc(String dxmmc) throws Exception;
	
	/**
	 * 查询比赛项目中的组别名称
	 * @param dxmmc
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getSelectZb(String dxmmc) throws Exception;
	/**
	 * 查询比赛项目中的性别组名称
	 * @param dxmmc
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getSelectXbz(String dxmmc) throws Exception;
	
	
}
