package com.yszoe.sys.util.excel;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.util.excel.bean.DBTableColumnInfo;
import com.yszoe.sys.util.excel.bean.ExcelTemp;

/**
 * 操作Excel所需的数据库操作类
 * 
 * @author zhuzhonglei
 * @version 0.1
 * @time 2009-12-10
 */

public final class ExcelDBUtil {
	private static final Log log = LogFactory.getLog(ExcelDBUtil.class);

	private static List<ExcelTemp> temp;
	private static Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();

	static {
		try {
			temp = initImportTemp();
		} catch (Exception e) {
			throw new RuntimeException("ExcelDBUtil 初始导入模板表错误!错误信息:\n" + e);
		}
	}

	private ExcelDBUtil() {
	}

	/**
	 * 获取指定表的列详细信息
	 * 
	 * @param tableName
	 * @return
	 * @throws SQLException
	 */
	public static List<DBTableColumnInfo> getTableColumnInfo(String tempID) throws SQLException {

		List<DBTableColumnInfo> list = new ArrayList<DBTableColumnInfo>();
		// String
		// SQL="SELECT t.column_name,t.DATA_LENGTH,t.DATA_TYPE,t.DATA_SCALE,t.NULLABLE,i.isonly,i.fieldalias,i.replacefield,i.replaceselecttable,i.importfield,i.exportfield,i.serialnumber FROM user_tab_columns t LEFT JOIN t_import_tempinfo i ON t.COLUMN_NAME=i.fieldname WHERE t.table_name=upper(?)";
		String SQL = "SELECT t.column_name,t.DATA_LENGTH,t.DATA_TYPE,t.DATA_SCALE,i.isnull,i.isonly,"
				+ "i.fieldalias,i.replacefield,i.replaceselecttable,i.importfield,i.exportfield,"
				+ "i.serialnumber FROM user_tab_columns t LEFT JOIN t_import_tempinfo i ON t.COLUMN_NAME=i.fieldname "
				+ " AND i.tempid=? WHERE t.table_name=upper(?) ORDER BY t.column_id";
		ResultSet rs = DBUtil.queryRowSet(SQL, tempID, getTempMappingTable0(tempID));

		if (rs == null)
			return null;

		while (rs.next()) {
			DBTableColumnInfo info = new DBTableColumnInfo();
			// 基础表信息
			info.setFiledName(rs.getString("column_name"));
			info.setFiledLength(rs.getString("data_length"));
			info.setFiledType(rs.getString("data_type"));
			info.setScale(rs.getInt("data_scale"));
			info.setDBNull(rs.getString("ISNULL"));
			// 管理附加信息
			info.setFiledAlias(rs.getString("fieldalias"));
			info.setReplaceField(rs.getString("replacefield"));
			info.setReplaceSelectTable(rs.getString("replaceselecttable"));
			info.setImportField(rs.getString("importfield"));
			info.setExportField(rs.getString("exportfield"));
			info.setSerialNumber(rs.getInt("serialnumber"));
			info.setDBOnly(rs.getString("ISONLY"));
			list.add(info);
		}
		rs.close();
		return list;
	}

	/**
	 * 获取指定模板ID的列验证信息
	 * 
	 * @param tempID
	 * @return
	 * @throws SQLException
	 */
	private static List<DBTableColumnInfo> getImportExcelColumnRules0(String tempID) throws SQLException {
		List<DBTableColumnInfo> list = new ArrayList<DBTableColumnInfo>();
		String SQL = "SELECT i.fieldname,i.fieldalias,i.fieldlength,i.fieldtype,i.filescale,i.replacefield,i.replaceselecttable,i.importfield,i.exportfield,i.isnull,i.serialnumber,i.isonly FROM t_import_tempinfo i WHERE i.tempid=? ORDER BY i.serialnumber ASC";
		ResultSet rs = DBUtil.queryRowSet(SQL, tempID);
		while (rs.next()) {
			DBTableColumnInfo info = new DBTableColumnInfo();
			// 基础表信息
			info.setFiledName(rs.getString("fieldname"));
			info.setFiledLength(rs.getString("fieldlength"));
			info.setFiledType(rs.getString("fieldtype"));
			info.setScale(rs.getInt("filescale"));
			info.setDBNull(rs.getString("isnull"));
			// 管理附加信息
			info.setFiledAlias(rs.getString("fieldalias"));
			info.setReplaceField(rs.getString("replacefield"));
			info.setReplaceSelectTable(rs.getString("replaceselecttable"));
			info.setImportField(rs.getString("importfield"));
			info.setExportField(rs.getString("exportfield"));
			info.setSerialNumber(rs.getInt("serialnumber"));
			info.setDBOnly(rs.getString("isonly"));
			list.add(info);
		}
		rs.close();
		return list;
	}

	public static List<DBTableColumnInfo> getImportExcelColumnRules(String tempID) throws SQLException {
		return getImportExcelColumnRules0(tempID);
	}

	/**
	 * 将Excel数据保存如零时表
	 * 
	 * @param userID
	 * @param list
	 */
	public synchronized static void saveToTempTable(String userID, List<List<String>> list, boolean isErr,
			String sheetIND) {
		List<Object[]> dbList = new ArrayList<Object[]>();
		for (List<String> sub : list) {
			dbList.add(sub.toArray());
		}
		int index = dbList.get(0).length;
		StringBuffer fields = new StringBuffer();
		StringBuffer signs = new StringBuffer();// 符号标记

		if (isErr)
			index -= 1;
		else
			index -= 2;

		for (int i = 0; i < index; i++) {
			fields.append(",field" + (i + 1));
			signs.append("?,");
		}
		if (index == 2) {
			fields.append(",field1");
			signs.append("?,");
		}

		StringBuffer SQL = new StringBuffer();
		if (isErr)
			SQL = new StringBuffer("INSERT INTO temp_excel(WID" + fields + ",USERID,SHEETIND) VALUES(?," + signs + "'"
					+ userID + "','" + sheetIND + "')");
		else
			SQL = new StringBuffer("INSERT INTO temp_excel(WID" + fields + ",ERROINFO,USERID,SHEETIND) VALUES(?,"
					+ signs + "?,'" + userID + "','" + sheetIND + "')");
		DBUtil.executeBatch(SQL.toString(), dbList);
	}

	/**
	 * 将零时表的数据存入正式库
	 * 
	 * @param userID
	 * @param list
	 * @throws Exception
	 */
	private static void saveToFormalTable0(String userID, String formalTable, List<DBTableColumnInfo> list)
			throws Exception {
		StringBuffer fieldBuffer = new StringBuffer();
		for (DBTableColumnInfo info : list) {
			fieldBuffer.append(info.getFiledName() + ",");
		}
		// StringBuffer SQL=new
		// StringBuffer("INSERT INTO "+formalTable+" (wid,"+fieldBuffer+") SELECT wid,"+1+" FROM temp_excel WHERE userID=?");
	}

	public static void saveToFormalTable(String userID, String tempID) throws Exception {
		saveToFormalTable0(userID, getTempMappingTable0(tempID), getImportExcelColumnRules0(tempID));
	}

	public static void saveToFormalTable(String userID, String mappTable, List<DBTableColumnInfo> list)
			throws Exception {
		saveToFormalTable0(userID, mappTable, list);
	}

	/**
	 * 初始模板表信息
	 * 
	 * @return
	 * @throws Exception
	 */
	private static List<ExcelTemp> initImportTemp() throws Exception {
		List<ExcelTemp> temp = new ArrayList<ExcelTemp>();
		ResultSet rs = DBUtil.queryRowSet("SELECT * FROM t_import_temp");
		while (rs.next()) {
			ExcelTemp eTemp = new ExcelTemp();
			eTemp.setWid(rs.getString("wid"));
			eTemp.setTempName(rs.getString("tempname"));
			eTemp.setMappingTable(rs.getString("mappingtable"));
			temp.add(eTemp);
		}
		return temp;
	}

	/**
	 * 重置模板表信息
	 */
	public static void resetImportTemp() {
		try {
			temp = initImportTemp();
		} catch (Exception e) {
			throw new RuntimeException("重置模板表信息错误,详细信息:\n" + e);
		}
	}

	/**
	 * 根据模板ID获得映射实体表
	 * 
	 * @param tempID
	 * @return
	 */
	private static String getTempMappingTable0(String tempID) {
		StringBuffer mappingTable = new StringBuffer();
		for (ExcelTemp ex : temp) {
			if (ex.getWid().equals(tempID)) {
				mappingTable.append(ex.getMappingTable());
			}
		}
		return mappingTable.toString();
	}

	/**
	 * 返回模板
	 * 
	 * @return
	 */
	public static List<ExcelTemp> getTemp() {
		return temp;
	}

	/**
	 * 返回数据库所有的表
	 * 
	 * @return
	 * @throws Exception
	 */
	public static List<String> getDBTables() throws Exception {
		List<String> list = new ArrayList<String>();
		ResultSet rs = DBUtil.queryRowSet("SELECT table_name FROM user_tables ORDER BY table_name ASC");
		while (rs.next()) {
			list.add(rs.getString("table_name"));
		}
		return list;
	}

	/**
	 * 返回指定表的所有字段
	 * 
	 * @param tableName
	 * @return
	 * @throws Exception
	 */
	private static List<String> getTableFields0(String tableName) throws Exception {
		List<String> list = new ArrayList<String>();
		ResultSet rs = DBUtil.queryRowSet("SELECT column_name FROM user_tab_columns WHERE table_name=upper(?)",
				tableName);
		while (rs.next()) {
			list.add(rs.getString("column_name"));
		}
		return list;
	}

	/**
	 * 返回指定表的所有字段 封装getTableFields0
	 * 
	 * @param tableName
	 * @return
	 * @throws Exception
	 */
	public static List<String> getTableFields(String tableName) throws Exception {
		return getTableFields0(tableName);
	}

	/**
	 * 返回指定表的所有字段 封装getTableFields0
	 * 
	 * @param tableName
	 * @return
	 * @throws Exception
	 */
	public static List<String> getTableFields(int tempID) throws Exception {
		String tableName = null;
		for (ExcelTemp excel : temp) {
			if (String.valueOf(tempID).equals(excel.getWid())) {
				tableName = excel.getMappingTable();
			}
		}
		return getTableFields(tableName);
	}

	/**
	 *保存验证字段的内容
	 * 
	 * @param info
	 * @param tempID
	 * @return
	 */
	public static List<Object[]> saveValidateTableFields(List<DBTableColumnInfo> info, String tempID) {
		List<Object[]> list = new ArrayList<Object[]>();
		for (DBTableColumnInfo message : info) {
			list.add(message.getObjectArray(SeqFactory.getNewSequenceAlone(), tempID));
		}
		return list;
	}

	/**
	 * 转换内容
	 * 
	 * @param context
	 * @param info
	 * @return
	 * @throws Exception
	 */
	public static String getConversionValue(String context, DBTableColumnInfo info) throws Exception {
		if (null == info.getReplaceSelectTable() || "".equals(info.getReplaceSelectTable()))
			return null;

		String replace = info.getReplaceField();
		String key = (null != replace && !"".equals(replace)) ? replace : info.getImportField();
		Map<String, String> subMap = map.get(key); // 获取字段转换值
		if (null == subMap) {// 为空查询数据库
			subMap = new HashMap<String, String>();
			if (null != replace && !"".equals(replace)) {// 有条件字段
				info.setImportField("zdmc");
				info.setExportField("zdbm");
				StringBuilder buliderSQL = new StringBuilder();
				buliderSQL.append("SELECT ");
				buliderSQL.append(info.getExportField() + "," + info.getImportField());
				buliderSQL.append(" FROM " + info.getReplaceSelectTable());
				buliderSQL.append(" WHERE zdlb=?");
				ResultSet rs = DBUtil.queryRowSet(buliderSQL.toString(), key);
				while (rs.next()) {
					subMap.put(rs.getString(info.getImportField()), rs.getString(info.getExportField()));
				}
				map.put(info.getReplaceField(), subMap);
			} else {
				StringBuilder buliderSQL = new StringBuilder();
				buliderSQL.append("SELECT ");
				buliderSQL.append(info.getExportField() + "," + info.getImportField());
				buliderSQL.append(" FROM " + info.getReplaceSelectTable());
				ResultSet rs = DBUtil.queryRowSet(buliderSQL.toString());
				while (rs.next()) {
					subMap.put(rs.getString(info.getImportField()), rs.getString(info.getExportField()));
				}
				map.put(info.getImportField(), subMap);
			}

		}
		String val = subMap.get(context);
		return val;
	}

	/**
	 * 返回模板名称
	 * 
	 * @param tempID
	 * @return
	 */
	public static String getTempMappingTable(String tempID) {
		return getTempMappingTable0(tempID);
	}

	/**
	 * 保存对象到模板中
	 * 
	 * @param userID
	 * @param list
	 */
	public synchronized static void saveObjectToTempTable(String userID, List<Object[]> list) {
		int index = list.get(0).length;
		StringBuffer fields = new StringBuffer();
		StringBuffer signs = new StringBuffer();// 符号标记
		for (int i = 0; i < index - 2; i++) {
			fields.append(",field" + (i + 1));
			signs.append("?,");
		}

		StringBuffer SQL = new StringBuffer("INSERT INTO temp_excel(WID" + fields + ",ERROINFO,USERID) VALUES(?,"
				+ signs + "?,'" + userID + "')");
		log.info("存入临时表的SQL -> " + SQL);
		DBUtil.executeBatch(SQL.toString(), list);
	}

}
