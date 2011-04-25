package com.yszoe.sys.util.excel;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 
 * 导出excel数据的工具类
 * 支持直接导出的HttpServletResponse中，让用户直接下载。也可以返回一个文件流，供上层应用处理。
 * @author yangjianliang
 * datetime 2009-12-5
 */
public interface Export2excelService {

	Log log = LogFactory.getLog( Export2excelService.class );
	
	/**
	 * 把要导出的数据写入excel文件对象
	 * @param rs 要导出给用户的数据
	 * @return 包含导出数据的excel文件流
	 * @throws SQLException
	 */
	public void writeData2ExportExcel(ResultSet rs) throws Exception;
	
	/**
	 * 获得导出的excel文件的流，给上一层应用自行处理。比如用struts2的下载
	 * @param data 要导出给用户的数据
	 * @return 包含导出数据的excel文件流
	 */
	public InputStream getExportExcelStream();

	/**
	 * 把要导出的文件放入HttpServletResponse输出流，提供用户下载文件
	 * @param data 用户要看的数据
	 * @param response HttpServletResponse
	 * @throws IOException
	 */
	public void doExportData(HttpServletResponse response) throws IOException;

	/**
	 * 生成要导出的文件的文件名
	 * @param excelFileTitle 要导出的文件的内容标题
	 * @return 要导出的文件的文件名
	 * @throws UnsupportedEncodingException
	 */
	public String getExportExcelFileName();
	
}
