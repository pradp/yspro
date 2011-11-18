package com.yszoe.sys.action;

import java.io.File;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.sys.service.impl.ExcelUserImportServiceImpl;

@SuppressWarnings("serial")
public class ExcelUserImportAction extends AbstractBaseActionSupport{
	
	private static final Log LOG = LogFactory.getLog(ExcelUserImportAction.class);

	private File excelFile;//上传上来的excel文件
	private String excelFileContentType;//文件类型 
	private String excelFileFileName;//文件名称
	private String importTempID;//导入要用的模板ID
	private String sheetName;//工作区索引
	private String filePath;//文件路径
	private String className;//类全名

	public String saveContext(){
		//System.out.println("保存");
		ExcelUserImportServiceImpl impl=(ExcelUserImportServiceImpl)this.getBaseService();		
		try {
			impl.saveContext(this);
		} catch (Exception e) {
			LOG.error(e);
			addActionError(e.getMessage());
		}
		return toView("saveContext.jsp");
	}
		
	/**
	 * getting And Setting Method
	 */
	public File getExcelFile() {
		return excelFile;
	}
	public void setExcelFile(File excelFile) {
		this.excelFile = excelFile;
	}
	public String getImportTempID() {
		return importTempID;
	}
	public void setImportTempID(String importTempID) {
		this.importTempID = importTempID;
	}
	public String getSheetName() {
		return sheetName;
	}
	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}

	public String getExcelFileContentType() {
		return excelFileContentType;
	}

	public void setExcelFileContentType(String excelFileContentType) {
		this.excelFileContentType = excelFileContentType;
	}

	public String getExcelFileFileName() {
		return excelFileFileName;
	}

	public void setExcelFileFileName(String excelFileFileName) {
		this.excelFileFileName = excelFileFileName;
	}

}
