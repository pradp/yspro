package com.yszoe.sys.service.impl;

import java.util.List;

import org.apache.log4j.Logger;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.action.ExcelImprotAdminSetTempAction;
import com.yszoe.sys.util.excel.ExcelDBUtil;
/**
 * 操作导入模板项服务类
 * @author zhuzhonglei
 * @time 2009-01-10
 */
public class ExcelImprotAdminSetTempServiceImpl extends AbstractBaseServiceSupport{
	
	private static final Logger logger=Logger.getLogger(ExcelImprotAdminSetTempServiceImpl.class); 
	
	public List<?> list(Object arg0, Pager pager) throws Exception {
		
		pager.setTotalRows(DBUtil.count("SELECT COUNT(wid) FROM t_import_temp"));		
		return DBUtil.queryPageList(pager, "SELECT wid,tempname,mappingtable FROM t_import_temp ORDER BY mappingtable ASC,wid");
	}
	
	public void load(Object arg0) throws Exception {		

		ExcelImprotAdminSetTempAction action=(ExcelImprotAdminSetTempAction)arg0;
		
		List<Object[]> list=DBUtil.queryAllList("SELECT tempname,mappingtable FROM t_import_temp WHERE wid=?", action.getWid());
		
		action.setTempName((String)list.get(0)[0]);
		action.setTableName((String)list.get(0)[1]);
		action.setParameter("DBTables", ExcelDBUtil.getDBTables());	
		
	}
	
	public boolean remove(Object arg0) throws Exception {

		String[] wids=((ExcelImprotAdminSetTempAction) arg0).getParameter("wid").split(",");
		
		StringBuilder SQL=new StringBuilder();
		StringBuilder infoSQL=new StringBuilder();
		if(wids.length>1){
			for(String wid : wids){
				SQL.append(" OR wid='"+wid+"'");
				infoSQL.append(" OR tempid='"+wid+"'");
			}
			SQL.delete(0, 3);
			infoSQL.delete(0, 3);
		}else{
			SQL.append("wid='"+wids[0]+"'");
			infoSQL.append("tempid='"+wids[0]+"'");
		}

		DBUtil.executeSQL("DELETE FROM t_import_temp WHERE " + SQL);
		DBUtil.executeSQL("DELETE FROM t_import_tempinfo WHERE " + infoSQL);
		ExcelDBUtil.resetImportTemp();
		return false;
	}
	
	public void saveOrUpdate(Object arg0) throws Exception {	
	
		ExcelImprotAdminSetTempAction action=(ExcelImprotAdminSetTempAction)arg0;		
		
		String wid=action.getWid();
		if(null!=wid&&!"".equals(wid)){
			logger.info("更新");
			DBUtil.executeSQL("UPDATE t_import_temp SET tempname=?,mappingtable=? WHERE wid=?",action.getTempName(),action.getTableName(),wid);
		}else{
			DBUtil.executeSQL("INSERT INTO t_import_temp(wid,tempname,mappingtable) VALUES(?,?,?)",SeqFactory.getNewSequenceAlone(),action.getTempName(),action.getTableName());
		}		
		ExcelDBUtil.resetImportTemp();
		action.setParameter("DBTables", ExcelDBUtil.getDBTables());	
	}
	
	@Override
	public void openCreate(Object myaction) throws Exception {

		ExcelImprotAdminSetTempAction action=(ExcelImprotAdminSetTempAction)myaction;		
		action.setParameter("DBTables", ExcelDBUtil.getDBTables());	
	}
}
