package com.imchooser.infoms.util;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.infoms.Constants;
import com.imchooser.infoms.entity.sys.TSysButtonRule;
import com.imchooser.util.DateUtil;

/**
 * 模块功能按钮开放时间控制规则辅助工具类
 * @author Yangjianliang
 * datetime 2009-10-27
 */
public class OpenTimeCtrlUtil {

	private static final Log log = LogFactory.getLog(OpenTimeCtrlUtil.class);
	
	/**
	 * 判断当前时间是否符合指定的时间规则
	 * @param tsysButtonRule 指定的时间规则
	 * @return 符合返回true，不符合返回false
	 */
	public static boolean checkButtonPermission(TSysButtonRule tsysButtonRule){
		String lx = tsysButtonRule.getCycleType();
		if(StringUtils.isNotBlank(lx)){
			int cycleType = 0;
			try{
				cycleType = Integer.parseInt(lx);
			}catch (NumberFormatException e) {
				log.error(e);
				throw new RuntimeException(e.getMessage());
			}

			String cycleStart = tsysButtonRule.getCycleStart();
			String cycleEnd = tsysButtonRule.getCycleEnd();
			
			String currDateTime = DateUtil.currentDateTimeString();//2010-10-10 10:10:10
			
			if(Constants.BUTTON_RULE_EACH_DAY == cycleType){//每天。查询当前时间是否在规则定义的时间段范围之内。
				
				String[] currDate_arr = currDateTime.split(" ");
				String currTime = currDate_arr[1];//时间部分
				String[] currTime_arr = currTime.split(":");
				String[] cycleStart_arr = cycleStart.split(":");
				String[] cycleEnd_arr = cycleEnd.split(":");
				if(cycleStart_arr.length==2 && cycleEnd_arr.length==2){//格式验证
					int currentHour = Integer.parseInt(currTime_arr[0]);
					int cycleStartHour = Integer.parseInt(cycleStart_arr[0]);
					int cycleEndHour = Integer.parseInt(cycleEnd_arr[0]);
					
					if( cycleStartHour<currentHour && currentHour<cycleEndHour ){
						
						return true;
					}else if( currentHour < cycleStartHour ){
						
						return false;
					}else if( cycleEndHour < currentHour ){
						
						return false;
					}else if( currentHour == cycleStartHour ){
						//压在了开始小时的时间点上，需要比较分钟确定大小
						int currentMinute = Integer.parseInt(currTime_arr[1]);
						int cycleStartMinute = Integer.parseInt(cycleStart_arr[1]);
						if(cycleStartMinute<=currentMinute){
							return true;
						}else{
							return false;
						}
					}else if( currentHour == cycleEndHour ){
						//压在了结束小时的时间点上，需要比较分钟确定大小
						int currentMinute = Integer.parseInt(currTime_arr[1]);
						int cycleEndMinute = Integer.parseInt(cycleEnd_arr[1]);
						if(currentMinute<=cycleEndMinute){
							return true;
						}else{
							return false;
						}
					}
				}
				
			}else if(Constants.BUTTON_RULE_EACH_MONTH == cycleType){//每月。查询当前日是否在规则定义的日范围之内。
				
				String[] currDateTime_arr = currDateTime.split(" ");
				String currDate = currDateTime_arr[0];//日期部分
				String[] currDate_arr = currDate.split("-");
				if(StringUtils.isNotBlank(cycleStart) && StringUtils.isNotBlank(cycleEnd)){//格式验证
					int currentDay = Integer.parseInt(currDate_arr[2]);//取日
					int cycleStartDay = Integer.parseInt(cycleStart);
					int cycleEndDay = Integer.parseInt(cycleEnd);
					
					if( cycleStartDay<=currentDay && currentDay<=cycleEndDay ){
						
						return true;
					}else if( currentDay < cycleStartDay ){
						
						return false;
					}else if( cycleEndDay < currentDay ){
						
						return false;
					}
				}
				
			}else if(Constants.BUTTON_RULE_EACH_YEAR == cycleType){//每年。查询当前月日是否在规则定义的月日范围之内。

				String[] currDateTime_arr = currDateTime.split(" ");
				String currDate = currDateTime_arr[0];//日期部分
				String[] currDate_arr = currDate.split("-");
				String[] cycleStart_arr = cycleStart.split("-");
				String[] cycleEnd_arr = cycleEnd.split("-");
				if(cycleStart_arr.length==2 && cycleEnd_arr.length==2){//格式验证
					int currentMonth = Integer.parseInt(currDate_arr[1]);//月
					int cycleStartMonth = Integer.parseInt(cycleStart_arr[0]);
					int cycleEndMonth = Integer.parseInt(cycleEnd_arr[0]);
					
					if( cycleStartMonth<currentMonth && currentMonth<cycleEndMonth ){
						
						return true;
					}else if( currentMonth < cycleStartMonth ){
						
						return false;
					}else if( cycleEndMonth < currentMonth ){
						
						return false;
					}else if( currentMonth == cycleStartMonth ){
						//压在了开始月份的时间点上，需要比较日来确定大小
						int currentDay = Integer.parseInt(currDate_arr[2]);
						int cycleStartDay = Integer.parseInt(cycleStart_arr[1]);
						if(cycleStartDay<=currentDay){
							return true;
						}else{
							return false;
						}
					}else if( currentMonth == cycleEndMonth ){
						//压在了结束月份的时间点上，需要比较日来确定大小
						int currentDay = Integer.parseInt(currDate_arr[2]);
						int cycleEndDay = Integer.parseInt(cycleEnd_arr[1]);
						if(currentDay<=cycleEndDay){
							return true;
						}else{
							return false;
						}
					}
				}
				
			}
		}
		
		return true;//默认开放。因为开放只能不会导致业务不能用下去。
	}
		
}
