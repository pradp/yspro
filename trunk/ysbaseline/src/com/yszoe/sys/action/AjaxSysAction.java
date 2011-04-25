package com.yszoe.sys.action;

import java.util.HashMap;
import java.util.Map;

import com.yszoe.sys.service.AjaxService;
import com.yszoe.sys.service.impl.AjaxSysServiceImpl;

/**
 * 直接返回json数据的action类
 * @author Yangjianliang
 * datetime 2011-4-19
 */
@SuppressWarnings("serial")
public class AjaxSysAction extends BaseActionAbstractSupport {

//	private static final Log LOG = LogFactory.getLog(AjaxSysAction.class);
	
	private Map<String, Object> datamap = new HashMap<String, Object>();
	private String param;
	private AjaxService ajaxService;

	/**
	 * @return the ajaxService
	 */
	public AjaxService getAjaxService() {
		return ajaxService;
	}

	/**
	 * @param ajaxService the ajaxService to set
	 */
	public void setAjaxService(AjaxService ajaxService) {
		this.ajaxService = ajaxService;
	}

	/**
	 * @return the datamap
	 */
	public Map<String, Object> getDatamap() {
		return datamap;
	}

	/**
	 * @param datamap the datamap to set
	 */
	public void setDatamap(Map<String, Object> datamap) {
		this.datamap = datamap;
	}

	/**
	 * @return the param
	 */
	public String getParam() {
		return param;
	}

	/**
	 * @param param the param to set
	 */
	public void setParam(String param) {
		this.param = param;
	}

	/**
	 * 加载指定节点的所有下属节点
	 * @param nodeid 树节点的ID
	 * @return
	 */
	public String loadTreeChild(){
		AjaxSysServiceImpl ajaxServiceImpl = (AjaxSysServiceImpl)ajaxService;
		String tree = ajaxServiceImpl.loadTreeChild(param);
		datamap.put("treedata", tree);
		return "loadTreeChild";
	}
}
