package com.yszoe.sys.refresh.client;

import java.rmi.Remote;

/**
 * @author Linyang datetime 2010-11-19
 */
public interface RefreshMemoryService extends Remote {
	/**
	 * 刷新内存
	 * 
	 * @param type 刷新类型
	 * @throws Exception
	 */
	void doRefresh(String type) throws Exception;

}
