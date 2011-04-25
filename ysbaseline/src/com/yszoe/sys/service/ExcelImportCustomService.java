package com.yszoe.sys.service;

public interface ExcelImportCustomService {
	
	/**
	 * 用通用数据导入功能导入数据的，在执行数据导入正式库之前，调用此方法
	 */
	void customMethodBeforeImport();

	/**
	 * 用通用数据导入功能导入数据的，在执行数据导入正式库之后，调用此方法
	 */
	void customMethodAfterImport();
	
}
