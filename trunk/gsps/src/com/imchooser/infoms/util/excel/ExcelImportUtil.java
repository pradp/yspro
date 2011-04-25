package com.imchooser.infoms.util.excel;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jxl.Cell;
import jxl.DateCell;
import jxl.NumberCell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.util.excel.bean.DBTableColumnInfo;

/**
 * Excel导入工具类
 * @author zhuzhonglei
 * @version 0.1
 * @time 2009-12-11
 */
public class ExcelImportUtil {

	private int startRow=0;//开始行
	private static final Log LOG = LogFactory.getLog(ExcelImportUtil.class);

	/**
	 * 返回Excel所有工作区名称
	 * 
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
	public String[] getExcelSheetNames0(String filePath) throws Exception {
		Workbook wookBook = Workbook.getWorkbook(new File(filePath));
		String[] sheetName = wookBook.getSheetNames();
		wookBook.close();
		return sheetName;
	}

	/**
	 * 封装getExcelSheetNames0(),不同的实现
	 * 
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
	public String[] getExcelSheetNames(String filePath) throws Exception {
		return this.getExcelSheetNames0(filePath);
	}

	/**
	 * 封装getExcelSheetNames0(),不同的实现
	 * 
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getExcelSheetNames(File excelFile) throws Exception {
		String[] names = this.getExcelSheetNames0(excelFile.getAbsolutePath());
		Map<String, String> map = new HashMap<String, String>();
		for (int i = 0; i < names.length; i++) {
			map.put(String.valueOf(i), names[i]);
		}
		return map;
	}

	/**
	 * validateExcelContent0()，封装其不同的实现方式
	 * 
	 * @param filePath
	 * @param sheetIndex
	 * @param tempID
	 * @throws Exception
	 */
	public Map<String, List<List<String>>> validateExcelContent(String filePath, int sheetIndex, String tempID)
			throws Exception {
		List<DBTableColumnInfo> list = ExcelDBUtil.getImportExcelColumnRules(tempID);// 从数据库获取验证规则
		return this.validateExcelContent0(filePath, sheetIndex, list);
	}

	/**
	 * 验证Excel文件选中工作区的内容正确性
	 * 
	 * @param filePath
	 * @param sheetIndex
	 * @param list
	 * @return
	 * @throws Exception
	 */
	private Map<String, List<List<String>>> validateExcelContent0(String filePath, int sheetIndex,
			List<DBTableColumnInfo> list) throws Exception {
		Map<String, List<List<String>>> map = new HashMap<String, List<List<String>>>();

		StringBuffer bufferHeader = new StringBuffer();
		for (DBTableColumnInfo info : list) {// 获取数据库保存的文件标题顺序
			bufferHeader.append(info.getFiledAlias());
		}
		Workbook wookBook = Workbook.getWorkbook(new File(filePath));// 获取Excel文件
		Sheet sheet = wookBook.getSheet(sheetIndex);// 获取指定工作区
		Cell[] cell = sheet.getRow(0);// return first line all cell
		StringBuffer excelHeader = new StringBuffer();
		for (Cell c : cell) {
			excelHeader.append(c.getContents());
		}
		if (!bufferHeader.toString().equals(excelHeader.toString()))// 判断标题是否相同
			return null;

		List<List<String>> importInfo = new ArrayList<List<String>>();
		List<List<String>> importInfoAfter = new ArrayList<List<String>>();// 转换后的集合数据
		int rows = sheet.getRows(), cols = sheet.getColumns();
		// 如果标题判断正确，下面对内容的正确性进行验证
		for (int row = 1; row < rows; row++) {
			boolean isNullRow = false;
			Cell[] cells = sheet.getRow(row);
			List<String> record = new ArrayList<String>();// 结构顺序
			// (WID,filed1,filed2,...,erroInfo)
			List<String> recordAfter = new ArrayList<String>();// 转换后的数据
			StringBuffer bufferErr = new StringBuffer("");
			String r = SeqFactory.getNewSequenceAlone(), ra = SeqFactory.getNewSequenceAlone();
			LOG.error(r + ":" + ra);
			record.add(r);// 加入WID(主键)
			recordAfter.add(ra);
			// record.add(String.valueOf(row));//保存行号
			for (int col = 0; col < cols; col++) {
				String cellType = cells[col].getType().toString().toUpperCase();
				if (cellType.equals(list.get(col).getFiledExcelType().toUpperCase())) {// 判断Excel单元类型与数据库的对应列类型是否匹配
					if (cellType.equals("NUMBER")) {
						try {
							String number = ((NumberCell) cells[col]).getContents();
							record.add(number);
							recordAfter.add(number);
						} catch (Exception e) {
							record.add(cells[col].getContents());
							recordAfter.add(cells[col].getContents());
							bufferErr.append(list.get(col).getFiledAlias() + "值错误;");
						}
					} else if (cellType.equals("DATE")) {
						try {
							Date date = ((DateCell) cells[col]).getDate();
							SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
							record.add(format.format(date));
							recordAfter.add(format.format(date));
						} catch (Exception e) {
							record.add(cells[col].getContents());
							recordAfter.add(cells[col].getContents());
							bufferErr.append(list.get(col).getFiledAlias() + "值错误;");
						}
					} else {
						String tempStr = cells[col].getContents();
						if (tempStr.length() != Integer.parseInt(list.get(col).getFiledLength())) {
							record.add(tempStr);
							String isSuccess = ExcelDBUtil.getConversionValue(tempStr, list.get(col));
							if (null != isSuccess) {// 判断是否转换成功
								recordAfter.add(isSuccess);
							} else {
								recordAfter.add(tempStr);
								if (null != list.get(col).getReplaceSelectTable()
										&& !"".equals(list.get(col).getReplaceSelectTable()))
									bufferErr.append(list.get(col).getFiledAlias() + "字典转换错误;");
							}
						} else {
							record.add(tempStr);
							recordAfter.add(tempStr);
							bufferErr.append(list.get(col).getFiledAlias() + "超过了最大字数;");
						}
					}
				} else if ("EMPTY".equals(cellType)) {
					// boolean isNullRow=false;
					if (col == 0) {// 判断第一列是不是就为空
						for (int c = 1; c < cols; c++) {// 一次判断该行所有列是不是为空
							if (!"EMPTY".equals(cells[c].getType().toString().toUpperCase())) {
								break;
							}
							if (c == cols - 1)
								isNullRow = true;
						}
					}
					if (isNullRow) {
						row += 1;
						break;
					} else {
						if (list.get(col).getIsNull()) {
							record.add("");
							recordAfter.add("");
						} else {
							record.add("");
							recordAfter.add("");
							bufferErr.append(list.get(col).getFiledAlias() + "不能为空;");
						}
					}
				} else {
					record.add(cells[col].getContents());
					recordAfter.add(cells[col].getContents());
					bufferErr.append(list.get(col).getFiledAlias() + "错误;");
				}
			}
			if (isNullRow)
				continue;

			record.add(bufferErr.toString());
			recordAfter.add("1");
			importInfo.add(record);
			importInfoAfter.add(recordAfter);
		}
		wookBook.close();

		map.put("err", importInfo);
		map.put("suc", importInfoAfter);

		return map;
	}

	/**
	 * validateExcelContent0()，封装其不同的实现方式
	 * 
	 * @param filePath
	 * @param sheetIndex
	 * @param list
	 * @return
	 * @throws Exception
	 */
	public Map<String, List<List<String>>> validateExcelContent(String filePath, int sheetIndex,
			List<DBTableColumnInfo> list) throws Exception {
		return this.validateExcelContent0(filePath, sheetIndex, list);
	}

	/**
	 * fastExcel获取文件内容
	 * 
	 * @param filePath
	 * @param sheetIndex
	 * @return
	 * @throws Exception
	 */
	private List<String[]> getFastExcelContext(String filePath, int sheetIndex) throws Exception {		
		List<String[]> list = new ArrayList<String[]>();
		/*edu.npu.fastexcel.Workbook workBook = FastExcel.createReadableWorkbook(new File(filePath));
		workBook.setSSTType(BIFFSetting.SST_TYPE_DEFAULT);

		try {
			workBook.open();
			edu.npu.fastexcel.Sheet sheet = workBook.getSheet(sheetIndex);
			for (int row = startRow; row < sheet.getLastRow(); row++) {
				if (null != sheet.getRow(row)) {// filter null row
					String[] temp = sheet.getRow(row);
					for (String s : temp) {
						if (null != s && !"".equals(s)) {
							list.add(sheet.getRow(row));
							break;
						}
					}
				}
			}
		} catch (Exception e) {
			LOG.error(e);
		} finally{
			workBook.close();
		}

		workBook.close();*/
		
		Workbook wookBook = Workbook.getWorkbook(new File(filePath));// 获取Excel文件
		Sheet sheet = wookBook.getSheet(sheetIndex);// 获取指定工作区
		int colNumber=0;
		boolean isFirst=true;
		for(int i=startRow;i<sheet.getRows();i++){			
			if(isFirst){
				colNumber=sheet.getRow(i).length;
				isFirst=false;
			}
			Cell[] cell=sheet.getRow(i);
			String[] sub=new String[colNumber];
			for(int s=0;s<cell.length;s++){				
				sub[s]=cell[s].getContents();
				//String str=cell[s].getContents();					
			}		
			for(String s:sub){
				if(null!=s&&!"".equals(s)){
					list.add(sub);
					break;
				}
			}			
		}
		wookBook.close();
		
		return list;
	}

	/**
	 * 初步验证数据的合法性
	 * 
	 * @param excelContent
	 * @param list
	 * @param id
	 * @return
	 * @throws Exception
	 */
	private Map<String, List<Object[]>> validateFastExcelContent0(List<String[]> excelContent,
			List<DBTableColumnInfo> list, String id) throws Exception {
		Map<String, List<Object[]>> map = new HashMap<String, List<Object[]>>();

		String[] dbHeader = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			dbHeader[i] = list.get(i).getFiledAlias();
		}

		if (!isAlike(dbHeader, excelContent.get(0)))
			return null;

		List<Object[]> importInfo = new ArrayList<Object[]>();
		List<Object[]> importInfoAfter = new ArrayList<Object[]>();
		for (int row = 1; row < excelContent.size(); row++) {// iteration
																// validate data
			String[] cols = excelContent.get(row);
			if(cols==null){
				LOG.error("通用导入出现null");
				return null;
			}
			StringBuffer errInfo = new StringBuffer("");
			int arrLength = cols.length + 3;// 比数据数组多出3个,分别存放wid,userid,erroinfo

			// record page content
			Object[] record = new Object[arrLength];
			record[0] = SeqFactory.getNewSequenceAlone();
			record[1] = id;
			Object[] recordAfter = new Object[arrLength];// 转换后的数据
			recordAfter[0] = SeqFactory.getNewSequenceAlone();
			recordAfter[1] = id;

			if (null != cols) {// 判断本行是否为空
				for (int col = 0; col < cols.length; col++) {
					String val = cols[col];// currently cell value
					if (null != val) {
						if ("NUMBER".equals(list.get(col).getFiledExcelType())) {
							for (Character c : val.toCharArray()) {
								if (!Character.isDigit(c)) {
									errInfo.append(list.get(col).getFiledAlias() + "错误;");
									break;
								}
							}
							// add value
							record[col + 2] = val;
							recordAfter[col + 2] = val;
						} else if ("DATE".equals(list.get(col).getFiledExcelType())) {
							SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
							try {
								format.parse(val);
							} catch (Exception e) {
								errInfo.append(list.get(col).getFiledAlias() + "错误;");
							}
							// add value
							record[col + 2] = val;
							recordAfter[col + 2] = val;
						} else {
							// 数字字典转换
							if (val.length() <= Integer.parseInt(list.get(col).getFiledLength())) {
								record[col + 2] = val;
								String isSuccess = ExcelDBUtil.getConversionValue(val, list.get(col));
								if (null != isSuccess) {// 判断是否转换成功
									recordAfter[col + 2] = isSuccess;
								} else {
									recordAfter[col + 2] = val;
									if (null != list.get(col).getReplaceSelectTable()
											&& !"".equals(list.get(col).getReplaceSelectTable()))
										errInfo.append(list.get(col).getFiledAlias() + "字典转换错误;");
								}
							} else {
								record[col + 2] = val;
								recordAfter[col + 2] = val;
								errInfo.append(list.get(col).getFiledAlias() + "超过了最大字数;");
							}

							// add value
							record[col + 2] = val;
							recordAfter[col + 2] = val;
						}
					} else {

						if (!list.get(col).getIsNull()) {// allow is null
							errInfo.append(list.get(col).getFiledAlias() + "不能为空;");
						}
						// add value
						record[col + 2] = "";
						recordAfter[col + 2] = "";
					}

				}
				// add error information
				record[record.length - 1] = errInfo;
				recordAfter[recordAfter.length - 1] = "1";
				// add row
				importInfo.add(record);
				importInfoAfter.add(recordAfter);
			}
		}

		map.put("err", importInfo);
		map.put("suc", importInfoAfter);

		return map;
	}

	/**
	 * 验证两个数组是否相同
	 * 
	 * @param source  数据库中的字段
	 * @param target  execl里的标题
	 * @return
	 */
	private boolean isAlike(String[] source, String[] target) {
		if (source.length != target.length)
			return false;

		boolean isAlike = true;
		for (int i = 0; i < source.length; i++) {
			if (!source[i].trim().toUpperCase().equals(target[i].trim().toUpperCase())) {
				isAlike = false;
				break;
			}
		}

		return isAlike;
	}

	/**
	 * validateFastExcelContent0(),扩充实现方式
	 * 
	 * @param excelContent
	 * @param list
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Map<String, List<Object[]>> validateFastExcelContent(List<String[]> excelContent,
			List<DBTableColumnInfo> list, String id) throws Exception {
		return this.validateFastExcelContent0(excelContent, list, id);
	}

	/**
	 * 初步验证数据的合法性
	 * 
	 * @param excelContent
	 * @param list
	 * @return
	 * @throws Exception
	 */
	public Map<String, List<List<String>>> validateFastExcelContent0(List<String[]> excelContent,
			List<DBTableColumnInfo> list) throws Exception {
		Map<String, List<List<String>>> map = new HashMap<String, List<List<String>>>();

		String[] dbHeader = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			dbHeader[i] = list.get(i).getFiledAlias();
		}

		if (!isAlike(dbHeader, excelContent.get(0)))
			return null;

		List<List<String>> importInfo = new ArrayList<List<String>>();
		List<List<String>> importInfoAfter = new ArrayList<List<String>>();// 转换后的集合数据
		for (int row = 1; row < excelContent.size(); row++) {// iteration
																// validate data
			String[] cols = excelContent.get(row);
			StringBuffer errInfo = new StringBuffer("");
			// record page content
			List<String> record = new ArrayList<String>();
			record.add(SeqFactory.getNewSequenceAlone());
			List<String> recordAfter = new ArrayList<String>();// 转换后的数据
			recordAfter.add(SeqFactory.getNewSequenceAlone());

			if (null != cols) {
				for (int col = 0; col < cols.length; col++) {
					String val = cols[col];// currently cell value
					if (StringUtils.isNotBlank(val)) {
						if ("NUMBER".equals(list.get(col).getFiledExcelType())) {
							val = val.trim();
							if (list.get(col).getScale() > 0) {
								int sign = 0;
								for (Character c : val.toCharArray()) {
									if (!Character.isDigit(c)) {
										if (c != '.' || sign > 1) {
											errInfo.append(list.get(col).getFiledAlias() + "错误;");
											break;
										}
									}
								}
							} else {
								if (val.indexOf('.') != -1)
									errInfo.append(list.get(col).getFiledAlias() + "必须是整数;");
								for (Character c : val.toCharArray()) {
									if (!Character.isDigit(c)) {
										errInfo.append(list.get(col).getFiledAlias() + "错误;");
										break;
									}
								}
							}

							// add value
							record.add(val);
							recordAfter.add(val);
						} else if ("DATE".equals(list.get(col).getFiledExcelType())) {
							val = val.trim();
							SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
							try {
								format.parse(val);
							} catch (Exception e) {
								errInfo.append(list.get(col).getFiledAlias() + "错误;");
							}
							// add value
							record.add(val);
							recordAfter.add(val);
						} else {
							String isSuccess = null;
							if ("VARCHAR2".equals(list.get(col).getFiledType().toUpperCase())) {
								// 数字字典转换
								if (val.length() <= Integer.parseInt(list.get(col).getFiledLength())) {
									if (null != list.get(col).getReplaceSelectTable()
											&& !"".equals(list.get(col).getReplaceSelectTable())) {
										try{
											isSuccess = ExcelDBUtil.getConversionValue(val, list.get(col));
										}catch(Exception ex){
											LOG.error("转换字典异常，可能没有选择转换字段！");
										}
										if (null == isSuccess) {// 判断是否转换成功
											if(!list.get(col).getIsNull())//判断是否为空
												errInfo.append(list.get(col).getFiledAlias() + "字典转换错误;");											
										}
									}
								} else {
									errInfo.append(list.get(col).getFiledAlias() + "超过了最大字数;");
								}
							}

							// add value
							if (null != isSuccess)
								recordAfter.add(isSuccess);
							else
								recordAfter.add(val);
							record.add(val);
							// recordAfter.add(val);
						}
					} else {
						LOG.info("isNull:"+list.get(col).getIsNull());
						if (!list.get(col).getIsNull()) {// allow is null
							errInfo.append(list.get(col).getFiledAlias() + "不能为空;");
						}
						// add value
						record.add(val);
						recordAfter.add(val);
					}

				}
				if (cols.length != list.size()) {
					int len = list.size() - cols.length;
					while (len > 0) {
						record.add("");
						recordAfter.add("");
						len--;
					}
				}
				// add error information
				if (null != errInfo && !"".equals(errInfo.toString())) {
					record.add(errInfo.toString());
					// add row
					importInfo.add(record);
				} else {
					// add row
					// importInfo.add(record);
					importInfoAfter.add(recordAfter);
				}
			}
		}

		map.put("err", importInfo);
		map.put("suc", importInfoAfter);

		return map;
	}

	/**
	 * validateFastExcelContent0(),扩充实现方式
	 * 
	 * @param filePath
	 * @param sheetIndex
	 * @param list
	 * @return
	 * @throws Exception
	 */
	public Map<String, List<List<String>>> validateFastExcelContentList(String filePath, int sheetIndex,
			List<DBTableColumnInfo> list) throws Exception {
		return this.validateFastExcelContent0(this.getFastExcelContext(filePath, sheetIndex), list);
	}

	/**
	 * setting and getting
	 */
	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
}
