package com.yszoe.sys.util;

import java.sql.SQLException;
import java.util.Calendar;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.framework.util.DBUtil;

/**
 * 公共查询快速帮助类
 * @author yangjianliang
 *
 */
public class CommonQuery {
	
	private static final Log LOG = LogFactory.getLog(CommonQuery.class);
	
	/**
	 * 返回系统表参数值
	 * @return
	 */
	public static String getSysProperty(String csmc){
		String val = null;
		try {
			val = PropConfigUtil.get(csmc);
		} catch (RuntimeException e) {
			LOG.error(e);
		}
		return val;
	}

	/**
	 * 调用存储过程，返回一个提示信息
	 * @param procName
	 * @param param
	 * @return
	 */
	public static String getProceduresString(String procName , Object... param){
		
		String mess = null;
		try {
			mess = DBUtil.execOracleProcQueryString(procName, param);
		} catch (SQLException e) {
			LOG.error(e);
		}
		return mess;
	}
	
	/**
	 * 取得指定高校的在校生总人数
	 * @param gxbm 要查询的高校的编码
	 * @return 此学校的在校生总人数，没有数据，返回0
	 */
	public static int getZxsrs(String gxbm){
		int result = 0;
		String sql = "select sum(XNZXXSRS) from T_GX_XNTQZZ where GXBM=?";
		try {
			Object val = DBUtil.queryFieldValue(sql, gxbm);
			if( val!=null ){
				result = Integer.parseInt(val.toString());
			}
		} catch (SQLException e) {
			LOG.error(e);
		}
		return result;
	}
	
	/**
	 * 获取当前学年
	 * @return 学年的开始年度，比如2009-2010学年，则返回2009
	 */
	public static String getThisSchoolYear(){
        Calendar cal = Calendar.getInstance(); 
        int year = cal.get(Calendar.YEAR);//当前年度
        int month = cal.get(Calendar.MONTH)+1;//当前月份
        if(month<9){
        	return String.valueOf(year-1);
        }else{
        	return String.valueOf(year);
        }
	}
	
	/**
	 * 这里根据当前月份计算上个月的年度
	 * @return 月份，比如现在是2010年12月，则返回2009
	 */
	public static int getPreYear(){
        Calendar cal = Calendar.getInstance(); 
        int year = cal.get(Calendar.YEAR);//当前年份
        int month= cal.get(Calendar.MONTH)+1;//当前月份
		if (month == 1) {
			year = cal.get(Calendar.YEAR)-1;//上个月的年度
		} else {
			year = cal.get(Calendar.YEAR);//上个月的年度
		}
        return year;
	}
	
	/**
	 * 这里根据当前月份计算上个月的月份
	 * @return 月份，比如现在是1月，则返回12
	 */
	public static int getPreMonth(){
        Calendar cal = Calendar.getInstance(); 
        int month = cal.get(Calendar.MONTH)+1;//当前月份
		if (month == 1) {
			month = 12;
		} else {
			month = month - 1;
		}
        return month;
	}
}
