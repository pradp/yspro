package com.yszoe.biz.action;

import java.util.HashMap;
import java.util.Map;

import com.yszoe.biz.service.AjaxBizService;
import com.yszoe.biz.service.impl.AjaxBizServiceImpl;
import com.yszoe.sys.action.AjaxSysAction;

/**
 * 
 * 直接返回json数据的action类 业务模块
 * 
 * @author Linyang datetime 2011-5-1
 */
@SuppressWarnings("serial")
public class AjaxBizAction extends AjaxSysAction {
	private Map<String, Object> datamap = new HashMap<String, Object>();
	private String param;
	private AjaxBizService ajaxBizService;

	public Map<String, Object> getDatamap() {
		return datamap;
	}

	public void setDatamap(Map<String, Object> datamap) {
		this.datamap = datamap;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public AjaxBizService getAjaxBizService() {
		return ajaxBizService;
	}

	public void setAjaxBizService(AjaxBizService ajaxBizService) {
		this.ajaxBizService = ajaxBizService;
	}

	/**
	 * 加载指定节点的所有下属节点
	 * 
	 * @return
	 */
	public String loadTreeChild() {
		String treeType = getRequest().getParameter("treeType");
		AjaxBizServiceImpl ajaxServiceImpl = (AjaxBizServiceImpl) ajaxBizService;
		String tree = ajaxServiceImpl.loadTreeChild(treeType, param);
		datamap.put("treedata", tree);
		return "SUCCESS";
	}
}
