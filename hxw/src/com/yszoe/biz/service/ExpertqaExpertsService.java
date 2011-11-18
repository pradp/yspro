package com.yszoe.biz.service;

import java.util.List;

import com.yszoe.framework.service.BaseService;
import com.yszoe.sys.entity.ApplicationEnum;

/**
 * 
 * @author Linyang datetime 2011-7-1
 */
public interface ExpertqaExpertsService extends BaseService {
	/**
	 * 改变状态
	 * @param myaction
	 * @return
	 */	 
	public boolean checkusername(Object myaction);	
	
	/**
	 * 查询EMAIL是否唯一
	 * @param myaction
	 * @return
	 */	
	public boolean checkemail(Object myaction);
	
	
}
