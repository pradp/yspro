package com.imchooser.infoms.util.excel.bean;

import org.apache.commons.lang.StringUtils;

/**
 * 数据库表内列字段详细信息
 * 
 * @author zhuzhonglei
 * @version 0.1
 * @time 2009-11-24
 */
public class DBTableColumnInfo {
	private String filedName;// 字段名
	private String filedAlias;// 字段别名
	private String filedLength;// 字段长度
	private String filedType;// 字段类型
	private int Scale;// 小数点右侧位数
	private boolean isNull;// 字段是否允许为空，true:允许
	// 是否必转
	private char isOnly = 'N';
	// 数字字典转换所需内容
	private String replaceField;// 需要进行数字字典转换(替换)的字段
	private String replaceSelectTable;// 替换查询的表
	private String importField;// 文件导入的数据对应的字段
	private String exportField;// 转换对应的字段
	private int serialNumber;// 排列顺序
	// 页面用参数
	private boolean isImportField;// 导入字段，true:导入

	public boolean getIsImportField() {
		return isImportField;
	}

	public void setIsImportField(boolean isImportField) {
		this.isImportField = isImportField;
	}

	public int getScale() {
		return Scale;
	}

	public void setScale(int scale) {
		Scale = scale;
	}

	public String getFiledExcelType() {
		if (this.filedType.equals("NUMBER") || this.filedType.equals("LONG")) {
			return "NUMBER";
		} else if (this.filedType.equals("DATE")) {
			return "DATE";
		} else {
			return "LABEL";
		}
	}

	public String getFiledType() {
		return this.filedType;
	}

	public void setFiledType(String filedType) {
		this.filedType = filedType;
	}

	public String getFiledName() {
		return filedName;
	}

	public void setFiledName(String filedName) {
		this.filedName = filedName;
	}

	public String getFiledAlias() {
		return filedAlias;
	}

	public void setFiledAlias(String filedAlias) {
		this.filedAlias = filedAlias;
	}

	public String getFiledLength() {
		return filedLength;
	}

	public void setFiledLength(String filedLength) {
		this.filedLength = filedLength;
	}

	public String getReplaceField() {
		return replaceField;
	}

	public void setReplaceField(String replaceField) {
		this.replaceField = replaceField;
	}

	public String getReplaceSelectTable() {
		return replaceSelectTable;
	}

	public void setReplaceSelectTable(String replaceSelectTable) {
		this.replaceSelectTable = replaceSelectTable;
	}

	public String getImportField() {
		return importField;
	}

	public void setImportField(String importField) {
		this.importField = importField;
	}

	public String getExportField() {
		return exportField;
	}

	public void setExportField(String exportField) {
		this.exportField = exportField;
	}

	public int getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(int serialNumber) {
		this.serialNumber = serialNumber;
	}

	public boolean getIsNull() {
		return isNull;
	}

	public void setIsNull(boolean isNull) {
		this.isNull = isNull;
	}

	public void setDBNull(String isNull) {
		if (StringUtils.isBlank(isNull) || "true".equals(isNull) || "Y".equals(isNull)) {
			this.isNull = true;
		} else {
			this.isNull = false;
		}
	}

	public boolean getIsOnly() {
		if (this.isOnly == 'Y')
			return true;
		else
			return false;
	}

	public void setIsOnly(boolean isOnly) {
		if (isOnly)
			this.isOnly = 'Y';
		else
			this.isOnly = 'N';
	}

	public void setDBOnly(String isOnly) {
		if (null == isOnly)
			return;
		this.isOnly = isOnly.charAt(0);
	}

	public char getDBOnly() {
		return this.isOnly;
	}

	// 返回对象数组
	public Object[] getObjectArray(String wID, String tempID) {
		return new Object[] { wID, tempID, filedName, filedAlias, filedLength, filedType, String.valueOf(Scale),
				String.valueOf(isNull), String.valueOf(isOnly), replaceField, replaceSelectTable, importField,
				exportField, String.valueOf(serialNumber) };
	}
}
