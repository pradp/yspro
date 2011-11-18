package com.yszoe.biz.service;

import com.yszoe.framework.service.BaseService;

/**
 * 
 * 
 * @author chenlu
 * datetime 2011-7-22
 */
 
public interface ExpertqaAnswerService extends BaseService {	
	/**
	 * 改变状态
	 * @param myaction
	 * @return
	 */
	public boolean doupdate(Object myaction);
}
