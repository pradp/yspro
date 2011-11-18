package com.yszoe.sys.service.impl;

/**
 * 用户导入操作
 * @author zhuzhonglei
 * @time 2009-11-20
 */
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.sys.action.ExcelUserImportAction;
import com.yszoe.sys.service.ExcelImportCustomService;
import com.yszoe.sys.util.excel.ExcelDBUtil;
import com.yszoe.sys.util.excel.ExcelImportUtil;
import com.yszoe.sys.util.excel.bean.DBTableColumnInfo;
import com.yszoe.util.Char2spell;
import com.yszoe.util.FileUtil;

public class ExcelUserImportServiceImpl extends AbstractBaseServiceSupport {

	private static final Logger logger = Logger.getLogger(ExcelUserImportServiceImpl.class);

	/**
	 * 读取excel数据显示在列表页面上
	 */
	public List<?> list(Object arg0, Pager page) throws Exception {
		ExcelUserImportAction action = (ExcelUserImportAction) arg0;
		boolean isImport = true;

		List<DBTableColumnInfo> rule = ExcelDBUtil.getImportExcelColumnRules(action.getImportTempID());

		if ( StringUtils.isBlank(action.getFilePath()) ) {
			List<String> headerValue = new ArrayList<String>();
			for (DBTableColumnInfo info : rule) {
				headerValue.add(info.getFiledAlias());
			}
			// headerValue.add("信息提示");
			action.setParameter("headerValue", headerValue);
			page.setTotalRows(0);
			return null;
		}

		if ( StringUtils.isNotBlank(action.getFilePath()) && StringUtils.isNotBlank(action.getSheetName()) ) {
			char c = File.separator.toCharArray()[0];
			Object obj = DBUtil.queryFieldValue("SELECT COUNT(*) FROM temp_excel WHERE userid=? AND sheetIND=?", action
					.getUserloginid(), action.getSheetName());
			if (null != obj && 0 == Integer.parseInt(obj.toString())) {// 判断该索引的数据，库中是否存在

				ExcelImportUtil util = new ExcelImportUtil();
				BigDecimal o = null;
				try {
					o = (BigDecimal) DBUtil.queryFieldValue("SELECT importrow FROM t_import_temp WHERE wid=?", action.getImportTempID() );
				} catch (Exception ex) {
					action.setParameter("content", "此导入模板已删除,请与管理员联系!");
					action.setParameter("isImport", "false");
					return null;
				}

				if (null!=o) {
					int start = o.intValue();
					if (start > 0)
						util.setStartRow(start - 1);// 设置从第几行开始
				}

				logger.info("第几行开始：" + util.getStartRow());

				// 获取Excel内容并对其进行验证，将验证结果返回
				Map<String, List<List<String>>> map = util.validateFastExcelContentList(action.getFilePath().replace(
						'*', c), Integer.parseInt(action.getSheetName()), rule);

				if (null == map) {
					action.setParameter("content", "数据标题错误!");
					action.addActionError("数据标题错误!");
					action.setParameter("isImport", "false");
					return null;
				}

				if (map.get("err").size() > 0) {// 判断是否有错误数据
					ExcelDBUtil.saveToTempTable(action.getUserloginid(), map.get("err"), false, action.getSheetName());// 保存入临时库
				} else {
					ExcelDBUtil.saveToTempTable(action.getUserloginid(), map.get("suc"), true, action.getSheetName());
					DBUtil.executeSQL("UPDATE temp_excel SET ERROINFO='可以导入' WHERE userid=?", action.getUserloginid());
				}
			}

		}

		if ("".equals(action.getSheetName()) && page.getCurrentPageno() == 1)
			return null;

		StringBuffer fields = new StringBuffer();
		StringBuffer fieldSource = new StringBuffer();
		for (int i = 0; i < rule.size(); i++) {
			if (null != rule.get(i).getReplaceSelectTable() && !"".equals(rule.get(i).getReplaceSelectTable())) {// 需要转换的字段
				if (null != rule.get(i).getReplaceField() && !"".equals(rule.get(i).getReplaceField())) {// 数字字典转换
					fields.append("(SELECT zdmc FROM t_sys_code where zdbm=field"
							+ (i + 1) + " AND zdlb='" + rule.get(i).getReplaceField() + "') field" + (i + 1) + ",");
				} else {
					fields.append("(SELECT " + rule.get(i).getImportField() + " FROM "
							+ rule.get(i).getReplaceSelectTable() + " WHERE " + rule.get(i).getExportField() + "=field"
							+ (i + 1) + ") field" + (i + 1) + ",");
				}
			} else {
				fields.append("field" + (i + 1) + ",");
			}
			fieldSource.append("field" + (i + 1) + ",");
		}

		fields.append("ERROINFO");
		fieldSource.append("ERROINFO");
		String[] fieldsStr = fieldSource.toString().split(",");
		page.setTotalRows(Long.parseLong(DBUtil.queryFieldValue("SELECT COUNT(*) FROM temp_excel WHERE userid=?",
				action.getUserloginid()).toString()));

		StringBuffer pageSQL = new StringBuffer();
		pageSQL.append("SELECT * FROM (SELECT a.*,ROWNUM rn FROM (SELECT " + fields
				+ " FROM temp_excel WHERE userid=? AND sheetIND=? ORDER BY wid ASC) a WHERE rownum<=?) WHERE rn>?");

//		logger.info("执行SQL：" + pageSQL + "userID=" + action.getUserLoginId() + ",sheetIndex=" + action.getSheetName());

		ResultSet rs = DBUtil.queryRowSet(pageSQL.toString(), action.getUserloginid(), action.getSheetName(), page
				.getCurrentPageno()
				* page.getEachPageRows(), (page.getCurrentPageno() - 1) * page.getEachPageRows());// 查询临时库
		ResultSet rsG = DBUtil.queryRowSet("SELECT * FROM (SELECT a.*,ROWNUM rn FROM (SELECT " + fieldSource
				+ " FROM temp_excel WHERE userid=? AND sheetIND=? ORDER BY wid ASC) a WHERE rownum<=?) WHERE rn>?",
				action.getUserloginid(), action.getSheetName(), page.getCurrentPageno() * page.getEachPageRows(), (page
						.getCurrentPageno() - 1)
						* page.getEachPageRows());
		List<List<String>> returnData = new ArrayList<List<String>>();

		action.setParameter("isImport", "true");

		while (rs.next()) {
			rsG.next();
			List<String> list = new ArrayList<String>();
			for (String field : fieldsStr) {
//				logger.info("遍历值：" + rs.getString(field));
//				logger.info("原始值：" + rsG.getString(field));
				if (rs.getString(field) != null && !"".equals(rs.getString(field))) {// 判断转换后的值是否为空，为空表示转换失败，使用else中的原始数据填入
					list.add(rs.getString(field));
				} else {
					list.add(rsG.getString(field) != null && !"".equals(rsG.getString(field)) ? rsG.getString(field)
							: "");
				}
				// list.add(rs.getString(field) != null&&
				// !"".equals(rs.getString(field)) ? rs.getString(field) :
				// rsG.getString(field));

				if (field.equals("ERROINFO") && isImport) {
					String val = rs.getString(field);
					if (null != val && !"".equals(val) && !"可以导入".equals(val)) {
						isImport = false;
						action.setParameter("isImport", "false");
					}
				}
			}
			returnData.add(list);
		}

		rs.close();
		rsG.close();

		// // 获取标题
		List<String> headerValue = new ArrayList<String>();
		for (DBTableColumnInfo info : rule) {
			headerValue.add(info.getFiledAlias());
		}
		headerValue.add("信息提示");
		action.setParameter("headerValue", headerValue);
		action.setParameter("content", returnData);
		action.setParameter("importTempID", action.getImportTempID());
		action.setParameter("filePath", action.getFilePath().replace('\\', '*'));

		return null;
	}

	public void load(Object myaction) throws Exception {
		ExcelUserImportAction action = (ExcelUserImportAction) myaction;
		String tempId = action.getImportTempID();
        String sql = "select DISTINCT p.tempname from t_Import_Tempinfo o,T_IMPORT_TEMP p " +
        		     "where p.wid = o.tempid and tempid = ?";
		String tempname = (String)getBaseDao().findFieldValue(sql, tempId);
		String tempwid = Char2spell.getPYString(tempname);

		action.setParameter("tempwid", tempwid);
	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {

	}

	@Override
	public void openCreate(Object obj) {
		// 导入的客户端。初次进入和上传都是这个方法
		ExcelUserImportAction action = (ExcelUserImportAction) obj;

		String tempId = action.getImportTempID();
        String sql = "select DISTINCT p.tempname from t_Import_Tempinfo o,T_IMPORT_TEMP p " +
        		     "where p.wid = o.tempid and tempid = ?";
		String tempname = "";
		try {
			tempname = (String) DBUtil.queryFieldValue(sql, tempId);
		} catch (SQLException e1) {
//			LOG.error(e1);
			// TODO Auto-generated catch block
		}
		String tempwid = Char2spell.getPYString(tempname);
        action.setParameter("tempwid", tempwid);
		
		File file = action.getExcelFile();
		Map<String, String> sheetNames = new HashMap<String, String>(0);
		if (null == file) {// 没有上传文件，只是初次进入页面
			action.setParameter("sheetNames", sheetNames);
			action.setParameter("className", action.getClassName());
			return;
		}
		String ext = FileUtil.getFileExt(action.getExcelFileFileName());
		if(!"xls".equals(ext) && !"xlsx".equals(ext) && !"csv".equals(ext)){
			action.setParameter("sheetNames", sheetNames);
			action.setParameter("className", action.getClassName());
			throw new RuntimeException("文件类型不正确！");
		}
		DBUtil.executeSQL("DELETE FROM temp_excel WHERE userid=?", action.getUserloginid());// 删除临时库该用户以前导入的数据
		ExcelImportUtil util = new ExcelImportUtil();
		// 复制文件
		String path = file.getAbsolutePath();
		char c = File.separator.toCharArray()[0];
		path = path.substring(0, path.lastIndexOf(File.separator));
		String fileName = action.getUserloginid();
		File newFile = new File(path + File.separator + fileName);
		try {

			InputStream in = new FileInputStream(file);
			OutputStream out = new FileOutputStream(newFile);
			byte[] buffer = new byte[1024];
			int length = 0;
			while ((length = in.read(buffer)) != -1) {
				out.write(buffer, 0, length);
			}
			out.close();
			in.close();
		} catch (Exception e) {
			throw new RuntimeException("复制文件错误:\n" + e);
		}

		try {
			sheetNames = util.getExcelSheetNames(newFile);
		} catch (Exception e) {
			action.setParameter("sheetNames", sheetNames);
			logger.error(e);
		}
		action.setParameter("sheetNames", sheetNames);
		action.setParameter("filePath", newFile.getAbsolutePath().replace(c, '*'));
		action.setParameter("className", action.getClassName());
	}

	/**
	 * 保存内容
	 * 
	 * @param obj
	 * @throws Exception
	 */
	public void saveContext(Object obj) throws Exception {
		ExcelUserImportAction action = (ExcelUserImportAction) obj;
		ExcelImportCustomService object = null;

		Object temp = DBUtil.queryFieldValue("SELECT classname FROM t_import_temp WHERE wid=?", action
				.getImportTempID());

		action.setClassName((String) temp);

		if (null != action.getClassName() && !"".equals(action.getClassName())) {
			Class<?> clazz = Class.forName(action.getClassName());
			Class<?>[] interfaces = clazz.getInterfaces();
			for (Class<?> inter : interfaces) {
				String name = inter.getName().substring(inter.getName().lastIndexOf('.') + 1, inter.getName().length());
				if ("ExcelImportCustomService".toUpperCase().equals(name.toUpperCase())) {
					object = (ExcelImportCustomService) clazz.newInstance();
					break;
				}
			}
		}
		List<DBTableColumnInfo> rules = ExcelDBUtil.getImportExcelColumnRules(action.getImportTempID());
		String table = ExcelDBUtil.getTempMappingTable(action.getImportTempID());
		// 组装SQL
		StringBuffer SQL = new StringBuffer();
		SQL.append("INSERT INTO " + table + "(wid");
		for (DBTableColumnInfo info : rules) {
			SQL.append("," + info.getFiledName());
		}
		SQL.append(") SELECT wid");
		for (int i = 0; i < rules.size(); i++) {
			if ("DATE".equals(rules.get(i).getFiledType().toUpperCase()))
				SQL.append(",to_date(field" + (i + 1) + ",'dd/mm/yyyy')");
			else
				SQL.append(",field" + (i + 1));
		}
		SQL.append(" FROM temp_excel WHERE userid=? AND sheetIND=?");
		if (null != object) {
			try {
				object.customMethodBeforeImport();
			} catch (RuntimeException ex) {
				action.setParameter("info", ex.getMessage());
				return;
			}
		}
		DBUtil.executeSQL(SQL.toString(), action.getUserloginid(), action.getSheetName());// 导入正式表里
		DBUtil.executeSQL("DELETE FROM temp_excel WHERE userid=?", action.getUserloginid());//删除临时表里的数据
		if (null != object) {
			try {
				object.customMethodAfterImport();
			} catch (RuntimeException ex) {
				action.setParameter("info", ex.getMessage());
				return;
			}
		}
		// 删除文件
		action.setParameter("info", "可以导入");

	}

}
