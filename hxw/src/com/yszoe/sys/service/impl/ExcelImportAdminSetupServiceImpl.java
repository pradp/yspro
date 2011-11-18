package com.yszoe.sys.service.impl;
/**
 * 管理员模板控制
 * @author zhuzhonglei
 * @time 2009-11-20
 */
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.sys.action.ExcelImportAdminSetupAction;
import com.yszoe.sys.util.excel.ExcelDBUtil;
import com.yszoe.sys.util.excel.bean.DBTableColumnInfo;

public class ExcelImportAdminSetupServiceImpl extends AbstractBaseServiceSupport{
	
	private static final Logger logger=Logger.getLogger(ExcelImportAdminSetupServiceImpl.class); 

	public List<?> list(Object obj, Pager arg1) throws Exception {

		ExcelImportAdminSetupAction action=(ExcelImportAdminSetupAction)obj;	
		List<DBTableColumnInfo> list=ExcelDBUtil.getTableColumnInfo(action.getTempID());
		action.setParameter("DBTables", ExcelDBUtil.getDBTables());
		return list;
	}
	
	@Override
	public void openCreate(Object obj){

		ExcelImportAdminSetupAction action=(ExcelImportAdminSetupAction)obj;	
		List<DBTableColumnInfo> listInfo;
		if(null==action.getTempID()||"".equals(action.getTempID()))
			return ;
		
		try {
			listInfo = ExcelDBUtil.getTableColumnInfo(action.getTempID());	
			List<Object[]> temp=DBUtil.queryAllList("SELECT importrow,classname FROM t_import_temp WHERE wid=?", action.getTempID());
			action.setParameter("DBTables", ExcelDBUtil.getDBTables());		
			action.setParameter("listInfo", listInfo);
			action.setParameter("tempID",action.getTempID());
			action.setParameter("importrow", temp.get(0)[0]);
			action.setParameter("classname", temp.get(0)[1]);
		} catch (Exception e) {
			logger.error(e);
		}		
	}

	public void load(Object arg0) throws Exception {
		
	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object obj) throws Exception {

		ExcelImportAdminSetupAction action =(ExcelImportAdminSetupAction)obj;	
		String tempID=action.getTempID();//所属模板ID	
		
		String importRow=action.getParameter("import");
		String className=action.getParameter("className");
		
		logger.info("import:"+importRow+"/className:"+className+"/wid:"+tempID);
		
		List<DBTableColumnInfo> list=action.getListInfo();
		List<DBTableColumnInfo> saveList=new ArrayList<DBTableColumnInfo>();
		for(DBTableColumnInfo info:list){
			if(info.getIsNull())
				info.setIsNull(false);
			else
				info.setIsNull(true);
			if(info.getIsImportField())
				saveList.add(info);
		}
		DBUtil.executeSQL("UPDATE t_import_temp SET IMPORTROW=?,CLASSNAME=? WHERE wid=?", importRow,className,tempID);
		DBUtil.executeSQL("DELETE FROM t_import_tempinfo WHERE tempid=?",tempID);
		DBUtil.executeBatch("INSERT INTO t_import_tempinfo (WID,TEMPID,FIELDNAME,FIELDALIAS,FIELDLENGTH,FIELDTYPE,FILESCALE,ISNULL,ISONLY,REPLACEFIELD,REPLACESELECTTABLE,IMPORTFIELD,EXPORTFIELD,SERIALNUMBER) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)", ExcelDBUtil.saveValidateTableFields(saveList, tempID));
				
		List<Object[]> temp=DBUtil.queryAllList("SELECT importrow,classname FROM t_import_temp WHERE wid=?", action.getTempID());
		
		action.setParameter("importrow", temp.get(0)[0]);
		action.setParameter("classname", temp.get(0)[1]);
		action.setParameter("DBTables", ExcelDBUtil.getDBTables());		
		action.setParameter("listInfo", list);

	}
	
	/**
	 * 获取导入模板对象
	 * @param obj
	 */
	public void getTemplateName(Object obj){
		ExcelImportAdminSetupAction action = (ExcelImportAdminSetupAction) obj;
		action.setParameter("temp", ExcelDBUtil.getTemp());
	}
}
