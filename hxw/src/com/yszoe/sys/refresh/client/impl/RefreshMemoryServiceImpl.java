package com.yszoe.sys.refresh.client.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.sys.SysConstants;
import com.yszoe.sys.refresh.client.RefreshMemoryService;
import com.yszoe.sys.util.SysPropertiesUtil;

/**
 * 刷新内存
 * 
 * @author Linyang datetime 2010-11-19
 */
public class RefreshMemoryServiceImpl implements RefreshMemoryService {
	private static final Log LOG = LogFactory.getLog(RefreshMemoryServiceImpl.class);

	/**
	 * 刷新内存
	 * 
	 * @param type 刷新类型
	 * @throws Exception
	 */
	public void doRefresh(String type) throws Exception {
		if (SysConstants.REFRESH_PROP.equals(type)) {
			SysPropertiesUtil.loadSysProps();
		} else if (SysConstants.REFRESH_ALL.equals(type)) {
			SysPropertiesUtil.loadSysProps();
		} else {
			LOG.error("刷新类型不存在!");
		}
	}

}
