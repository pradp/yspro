package com.yszoe.sys.action;

import java.util.ArrayList;
import java.util.List;

import com.yszoe.sys.entity.ApplicationEnum;
import com.yszoe.sys.service.impl.ExcelImportAdminSetupServiceImpl;
import com.yszoe.sys.util.excel.ExcelDBUtil;
import com.yszoe.sys.util.excel.bean.DBTableColumnInfo;

@SuppressWarnings("serial")
public class ExcelImportAdminSetupAction extends AbstractBaseActionSupport{
	
	private String tempID;
	private List<DBTableColumnInfo> listInfo;

	/**
	 * 获取导入模板信息
	 */
	public void templateName(){
		ExcelImportAdminSetupServiceImpl admin=(ExcelImportAdminSetupServiceImpl)this.getBaseService();
		admin.getTemplateName(this);		
	}	
	
	public List<ApplicationEnum> getTableFields(String tableName){		
		List<ApplicationEnum> list = new ArrayList<ApplicationEnum>();
		if(null==tableName||"".equals(tableName))
			return list;
		
		try {
			List<String> sub=ExcelDBUtil.getTableFields(tableName);
			for(String s:sub){
				ApplicationEnum a=new ApplicationEnum();
				a.setId(s);
				a.setCaption(s);
				list.add(a);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new RuntimeException("Action 获取表字段错误:\n"+e);
		}
		return list;
	}
	
	/**
	 * setting And getting
	 */
	public String getTempID() {
		return tempID;
	}

	public void setTempID(String tempID) {
		this.tempID = tempID;
	}
	
	public List<DBTableColumnInfo> getListInfo() {
		return listInfo;
	}

	public void setListInfo(List<DBTableColumnInfo> listInfo) {
		this.listInfo = listInfo;
	}
}
