package com.imchooser.infoms.util.excel.bean;
/**
 * 模板类
 * @author zhuzhonglei 
 * @time 2009-11-24
 */
public class ExcelTemp {
	private String wid;//模板主键
	private String tempName;//模板名
	private String mappingTable;//模板映射实体表
	
	public String getWid() {
		return wid;
	}
	public void setWid(String wid) {
		this.wid = wid;
	}
	public String getTempName() {
		return tempName;
	}
	public void setTempName(String tempName) {
		this.tempName = tempName;
	}
	public String getMappingTable() {
		return mappingTable;
	}
	public void setMappingTable(String mappingTable) {
		this.mappingTable = mappingTable;
	}
	
	
}
