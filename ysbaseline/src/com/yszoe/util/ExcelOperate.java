package com.yszoe.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

/**
 * 操作excel的工具类
 * 
 * @author yangjianliang
 * 
 */
public class ExcelOperate {

	private File excelfile;
	POIFSFileSystem fs = null;
	HSSFWorkbook wb = null;
	private short readWhichSheet;//读取哪一个sheet
	private int startReadRowNum;//从第几行开始读取
	private int endReadRowNum;//读到第几行结束
	private short startReadCellNum;//从第几列开始读取
	private short endReadCellNum;//读到第几列结束

	public ExcelOperate(){
	}
	
	public ExcelOperate(File excelfile) throws FileNotFoundException, IOException {
		this.excelfile = excelfile;
		loadExcelFile();
	}

	public void loadExcelFile() throws FileNotFoundException, IOException{
		fs = new POIFSFileSystem(new FileInputStream( excelfile ));
		wb = new HSSFWorkbook(fs);
	}

	/**
	 * 读取excel的值，以List<String[]>返回
	 * @return
	 */
	public List<String[]> readExcelData(){
		int allsheet = wb.getNumberOfSheets();
		if( readWhichSheet >= allsheet ){
			return new ArrayList<String[]>(0);
		}
		HSSFSheet sheet = wb.getSheetAt( readWhichSheet );
		if(sheet==null){
			return new ArrayList<String[]>(0);
		}
		int rowNum = sheet.getLastRowNum() + 1;
		//这里比较特殊，cell个数计算正确，row个数需要加1才对
//		System.out.println("rownum:"+rowNum);
		List<String[]> resultList = new ArrayList<String[]>( rowNum );
		for(int i=startReadRowNum;i<=endReadRowNum && i<rowNum;i++){
			HSSFRow row = sheet.getRow(i);
			if(row==null){
				break;
			}
			short cellsnum = row.getLastCellNum();
//			System.out.println("cellnum:"+cellsnum);
			String[] cells = new String[ cellsnum ];
			for(int k= startReadCellNum;k<=endReadCellNum && k<cellsnum;k++){
				HSSFCell cell = row.getCell(k);
				Object val = getCellValue(cell);
				cells[k] = val==null?null:val.toString() ;
			}
			resultList.add(cells);
		}
		return resultList;
	}

	/**
	 * 读取excel的值，以List<String[]>返回
	 * 专用于数据导入模块，当输入的身份证号列为空，能认为以后的数据没有了。
	 * @return
	 */
	public List<String[]> readExcelDataByCheckSfzh(){
		int allsheet = wb.getNumberOfSheets();
		if( readWhichSheet >= allsheet ){
			return new ArrayList<String[]>(0);
		}
		HSSFSheet sheet = wb.getSheetAt( readWhichSheet );
		if(sheet==null){
			return new ArrayList<String[]>(0);
		}

		int rowNum = sheet.getLastRowNum() + 1;
		//这里比较特殊，cell个数计算正确，row个数需要加1才对
//		System.out.println("rownum:"+rowNum);
		List<String[]> resultList = new ArrayList<String[]>( rowNum );
		for(int i=startReadRowNum;i<=endReadRowNum && i<rowNum;i++){
			HSSFRow row = sheet.getRow(i);
			if(row==null){
				break;
			}
			if(row.getCell(5)==null || row.getCell(5).getRichStringCellValue().getString().equals("")){
				//第五列是身份证号，必填的
				if(i>endReadRowNum){
					//用设定的允许的最大行数里的身份证列判断
					throw new RuntimeException("一次限导入"+endReadRowNum+"条数据，请拆分文件，多次导入！");
				}
				break;
			}
			short cellsnum = row.getLastCellNum();
//			System.out.println("cellnum:"+cellsnum);
			String[] cells = new String[ cellsnum ];
			for(int k= startReadCellNum;k<=endReadCellNum && k<cellsnum;k++){
				HSSFCell cell = row.getCell(k);
				Object val = getCellValueAsString(cell);
				cells[k] = val==null?null:val.toString() ;
			}
			resultList.add(cells);
		}
		return resultList;
	}

	/**
	 * 测试用
	 * @throws IOException
	 */
	void writeDataTest() throws IOException{

		HSSFSheet sheet = wb.getSheetAt(0);
		HSSFRow row = sheet.getRow(2);
		HSSFCell cell = row.getCell( 3 );
		if (cell == null)
			cell = row.createCell( 3 );
		cell.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell.setCellValue(new HSSFRichTextString("a test"));

		FileOutputStream fileOut = new FileOutputStream("workbook.xls");
		wb.write(fileOut);
		fileOut.close();
	}
	
	/**
	 * 根据Cell类型返回正确的值
	 * @param cell
	 * @return
	 */
	public static Object getCellValue(HSSFCell cell){
		
		if(cell==null){
			return null;
		}else if(HSSFCell.CELL_TYPE_BLANK == cell.getCellType()){
			return "";
		}else if(HSSFCell.CELL_TYPE_BOOLEAN == cell.getCellType()){
			return cell.getBooleanCellValue();
		}else if(HSSFCell.CELL_TYPE_FORMULA == cell.getCellType()){
			return cell.getCellFormula();
		}else if(HSSFCell.CELL_TYPE_NUMERIC == cell.getCellType()){
			if(HSSFDateUtil.isCellDateFormatted(cell)){
				return formatDate(cell.getDateCellValue());
			}else{
				return cell.getNumericCellValue();
			}
		}else if(HSSFCell.CELL_TYPE_STRING == cell.getCellType()){
			return cell.getRichStringCellValue().getString();
		}else{
			return cell.getRichStringCellValue().getString();
		}
		
	}

	/**
	 * 根据Cell类型返回正确的值
	 * @param cell
	 * @return
	 */
	public static String getCellValueAsString(HSSFCell cell){
		
		if(cell==null){
			return null;
		}else if(HSSFCell.CELL_TYPE_BLANK == cell.getCellType()){
			return "";
		}else if(HSSFCell.CELL_TYPE_BOOLEAN == cell.getCellType()){
			return String.valueOf( cell.getBooleanCellValue() );
		}else if(HSSFCell.CELL_TYPE_NUMERIC == cell.getCellType()){
			if(HSSFDateUtil.isCellDateFormatted(cell)){
				return formatDate(cell.getDateCellValue());
			}else{
				DecimalFormat df = new DecimalFormat("#00");
				return df.format(cell.getNumericCellValue());
			}
		}else if(HSSFCell.CELL_TYPE_STRING == cell.getCellType()){
			return cell.getRichStringCellValue().getString();
		}else{
			return cell.getRichStringCellValue().getString();
		}
		
	}
	
	public static String formatDate(Date date){
		
		return new SimpleDateFormat("yyyy-MM-dd").format(date);
	}
	
	public int getEndReadRowNum() {
		return endReadRowNum;
	}

	/**
	 * 下面的set都要减一，excel程序是从0开始计数的
	 * @param endReadRowNum
	 */
	public void setEndReadRowNum(int endReadRowNum) {
		this.endReadRowNum = endReadRowNum - 1;
	}

	public File getExcelfile() {
		return excelfile;
	}

	public void setExcelfile(File excelfile) {
		this.excelfile = excelfile;
	}

	public int getStartReadRowNum() {
		return startReadRowNum;
	}

	public void setStartReadRowNum(int startReadRowNum) {
		this.startReadRowNum = startReadRowNum - 1;
	}

	public short getReadWhichSheet() {
		return readWhichSheet;
	}

	public void setReadWhichSheet(short readWhichSheet) {
		this.readWhichSheet = (short)(readWhichSheet - (short)1);
	}

	public short getEndReadCellNum() {
		return endReadCellNum;
	}

	public void setEndReadCellNum(short endReadCellNum) {
		this.endReadCellNum = (short)(endReadCellNum - (short)1);
	}

	public short getStartReadCellNum() {
		return startReadCellNum;
	}

	public void setStartReadCellNum(short startReadCellNum) {
		this.startReadCellNum = (short)(startReadCellNum - (short)1);
		
	}

	public HSSFWorkbook getWb() {
		return wb;
	}

	public void setWb(HSSFWorkbook wb) {
		this.wb = wb;
	}

}
