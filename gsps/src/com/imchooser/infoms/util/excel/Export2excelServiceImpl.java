package com.imchooser.infoms.util.excel;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;

import com.imchooser.framework.service.Export2excelService;

/**
 * @see Export2excelService
 * @author Yangjianliang datetime 2009-12-5
 */
public class Export2excelServiceImpl implements Export2excelService {

	private final static Log log = LogFactory.getLog(Export2excelServiceImpl.class);
	private HSSFWorkbook wb = new HSSFWorkbook();
	private String[] sheetNames;// 生成文件的各个sheet页名称
	private int dataSheetIndex = 0;// 数据存放在哪个sheet页，默认第一个sheet页
	private String[] headColmuns;// sheet页里的行头
	private String excelFileTitle;// 不指定文件名，就默认使用日期
	private boolean headStyleEnabled = true;

	public Export2excelServiceImpl(String[] sheetNames, String[] headColmuns) {
		this.sheetNames = sheetNames;
		this.headColmuns = headColmuns;
	}

	public Export2excelServiceImpl(String[] sheetNames, String[] headColmuns, String excelFileTitle, int dataSheetIndex) {
		this.sheetNames = sheetNames;
		this.dataSheetIndex = dataSheetIndex;
		this.headColmuns = headColmuns;
		this.excelFileTitle = excelFileTitle;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.imchooser.framework.service.Export2excelService#getExportExcelStream
	 * ()
	 */
	public InputStream getExportExcelStream() {

		byte[] b = wb.getBytes();
		InputStream is = new ByteArrayInputStream(b, 0, b.length);
		return is;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.Export2excelService#doExportData()
	 */
	public void doExportData(HttpServletResponse response) throws IOException {

		ServletOutputStream out = response.getOutputStream();
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;fileName=" + getExportExcelFileName() + ".xls");
		wb.write(out);
		response.flushBuffer();
		out.close();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.imchooser.framework.service.Export2excelService#getExportExcelFileName
	 * ()
	 */
	public String getExportExcelFileName() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
		String fileName = format.format(new Date());
		if (StringUtils.isNotBlank(excelFileTitle)) {
			fileName = excelFileTitle + "(" + fileName + ")";
		}

		// 设置编码格式为ISO8859-1要不然文件名会乱码
		try {
			fileName = new String(fileName.getBytes("gb2312"), "ISO8859-1");
		} catch (UnsupportedEncodingException e) {
			log.error(e);
		}
		return fileName;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.imchooser.framework.service.Export2excelService#writeData2ExportExcel
	 * ()
	 */
	public void writeData2ExportExcel(ResultSet rs) throws SQLException {

		if (sheetNames == null) {
			throw new RuntimeException("没有提供excel中sheet页的名称");
		}
		if (headColmuns == null) {
			throw new RuntimeException("没有提供excel中行头的名称");
		}
		HSSFSheet mainDataSheet = null;// 可以建立多个sheet页，但是只有一个sheet有数据。
		for (int i = 0; i < sheetNames.length; i++) {
			if (i == dataSheetIndex) {
				mainDataSheet = wb.createSheet(sheetNames[i]);
			} else {
				wb.createSheet(sheetNames[i]);
			}
		}
		if (mainDataSheet == null) {
			throw new RuntimeException("没有得到excel中存储数据的sheet对象");
		}
		mainDataSheet.setActive(true);
		// 选中这个sheet页
		// mainDataSheet.setSelected(true);
		// 生成一个样式

		HSSFCellStyle style = null;
		if (headStyleEnabled) {
			style = wb.createCellStyle();
			// 设置这些样式
			style.setFillForegroundColor(HSSFColor.YELLOW.index);
			style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			style.setBorderRight(HSSFCellStyle.BORDER_THIN);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			// 生成一个字体
			HSSFFont font = wb.createFont();
			font.setColor(HSSFColor.BLACK.index);
			font.setFontHeightInPoints((short) 11);
			font.setBoldweight(Font.BOLDWEIGHT_BOLD);
			// 把字体应用到当前的样式
			style.setFont(font);
		}

		CreationHelper createHelper = wb.getCreationHelper();
		HSSFRow headerRow = mainDataSheet.createRow(0);// 创建excel的行头
		for (int i = 0; i < headColmuns.length; i++) {
			HSSFCell cell = headerRow.createCell(i);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			if (headStyleEnabled) {
				cell.setCellStyle(style);
			}
			cell.setCellValue(createHelper.createRichTextString(headColmuns[i]));
		}

		int curRowIndex = 1;
		while (rs.next()) {
			HSSFRow curRow = mainDataSheet.createRow(curRowIndex);// 第一行前面已经创建了
			// 结果集最后位置 i 的值
			for (int i = 0; i < headColmuns.length; i++) {
				if (i == 8) {
					break;
				}
				HSSFCell cell = curRow.createCell(i);
				cell.setCellValue(createHelper.createRichTextString(rs.getString(i + 1)));
			}
			String str = (String)rs.getObject(9);
			String strs[] = null;
			if(str!=null){
				strs = str.split(",");
			}
			if (strs != null && strs.length > 0) {
				for (int t=0;t<strs.length;t++) {
					String temp = strs[t];
					HSSFCell cell = curRow.createCell(8+t);
					cell.setCellValue(createHelper.createRichTextString(temp));
				}
			}
			curRowIndex++;
		}

		
	}

	public String[] getSheetNames() {
		return sheetNames;
	}

	public void setSheetNames(String[] sheetNames) {
		this.sheetNames = sheetNames;
	}

	public int getDataSheetIndex() {
		return dataSheetIndex;
	}

	public void setDataSheetIndex(int dataSheetIndex) {
		this.dataSheetIndex = dataSheetIndex;
	}

	public String getExcelFileTitle() {
		return excelFileTitle;
	}

	public void setExcelFileTitle(String excelFileTitle) {
		this.excelFileTitle = excelFileTitle;
	}

	public String[] getHeadColmuns() {
		return headColmuns;
	}

	public void setHeadColmuns(String[] headColmuns) {
		this.headColmuns = headColmuns;
	}

	public boolean isHeadStyleEnabled() {
		return headStyleEnabled;
	}

	public void setHeadStyleEnabled(boolean headStyleEnabled) {
		this.headStyleEnabled = headStyleEnabled;
	}

}
