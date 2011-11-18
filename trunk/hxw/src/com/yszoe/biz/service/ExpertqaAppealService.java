package com.yszoe.biz.service;

import java.util.List;

import com.yszoe.framework.service.BaseService;
import com.yszoe.sys.entity.ApplicationEnum;

/**
 *  * 
 * @author chenlu
 * datetime 2011-7-22
 */
 
public interface ExpertqaAppealService extends BaseService {	
	/**
	 * 改变状态
	 * @param myaction
	 * @return
	 */
	public boolean doupdate(Object myaction);
	
	/**
	 * 专家字典 
	 * @param myaction
	 * @return
	 */
	public List<ApplicationEnum> getApplicationEnums(String sql);
}
