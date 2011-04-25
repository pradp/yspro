package com.imchooser.util;



/**
 * 数字格式处理类
 * @author Yangjianliang
 * datetime 2010-4-15
 */
public class NumberUtil {

	//private static final Log LOG = LogFactory.getLog(NumberUtil.class);

	/**
	 * 格式化数字，去掉小数点后无用的.0部分
	 * @param num
	 * @return 格式化后的不含.0的字符串
	 */
	public static String formatPoint(double num){
		String _num = String.valueOf(num);
		_num = _num.replaceAll("\\.0", "");
		return _num;
	}
}
