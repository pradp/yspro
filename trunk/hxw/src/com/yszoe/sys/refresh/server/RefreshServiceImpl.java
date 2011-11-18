package com.yszoe.sys.refresh.server;

import java.rmi.Naming;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.sys.refresh.client.RefreshMemoryService;
import com.yszoe.sys.util.SysConfigUtil;

/**
 * 刷新内存
 * 
 * @author Linyang datetime 2010-11-19
 */
public class RefreshServiceImpl {

	private static final Log LOG = LogFactory.getLog(RefreshServiceImpl.class);

	/**
	 * @param type 刷新类型 Constants.EFRESH_ 开头的
	 * @throws Exception
	 */
	public static void doRefreshMemory(String type) throws Exception {
		String userLoginServerIP = null;
		RefreshMemoryService refreshMemoryService = null;
		String serverIP = SysConfigUtil.getString("ServerIP");
		
		if (StringUtils.isNotBlank(serverIP)) {
			for (int i = 0; i < serverIP.split(",").length; i++) {
				userLoginServerIP = serverIP.split(",")[i];
				String serverAddress = "rmi://" + userLoginServerIP + ":1198/RefreshSessionService";
				try {
					Object remoteObject = Naming.lookup(serverAddress);
					refreshMemoryService = (RefreshMemoryService) remoteObject;
				} catch (Exception e) {
					LOG.error(e);
					throw new Exception("同步内存失败：因为获取远程SESSION操作接口失败！");
				}
				refreshMemoryService.doRefresh(type);// 移除远程节点上的用户SESSION信息
			}
		} else {
			LOG.error("未成功获取省份编码！");
		}
	}

}
