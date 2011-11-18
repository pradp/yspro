package com.yszoe.sys.action;
/**
 * 导入模板设置Action
 * @author zhuzhonglei
 * @time 2010-01-20
 */
@SuppressWarnings("serial")
public class ExcelImprotAdminSetTempAction extends AbstractBaseActionSupport{
	private String tempName;
	private String tableName;
		
	/**
	 * setting and getting
	 */
	public String getTempName() {
		return tempName;
	}
	public void setTempName(String tempName) {
		this.tempName = tempName;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
}
