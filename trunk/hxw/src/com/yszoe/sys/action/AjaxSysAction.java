package com.yszoe.sys.action;

import java.util.HashMap;
import java.util.Map;

import com.yszoe.sys.service.AjaxService;
import com.yszoe.sys.service.impl.AjaxSysServiceImpl;

/**
 * 直接返回json数据的action类
 * 
 * @author Yangjianliang datetime 2011-4-19
 */
@SuppressWarnings("serial")
public class AjaxSysAction extends AbstractBaseActionSupport {

	// private static final Log LOG = LogFactory.getLog(AjaxSysAction.class);

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
	 * 
	 * @param nodeid 树节点的ID
	 * @return
	 */
	public String loadTreeChild() {
		String treeType = getRequest().getParameter("treeType");
		AjaxSysServiceImpl ajaxServiceImpl = (AjaxSysServiceImpl) ajaxService;
		String tree = ajaxServiceImpl.loadTreeChild(treeType, param);
		datamap.put("treedata", tree);
		return "loadTreeChild";
	}

	/**
	 * 更新状态
	 * 
	 * @return
	 * @throws Exception
	 */
	public void doUniChangeState() {
		String parms = getRequest().getParameter("parms");
		String wid = getRequest().getParameter("wid");
		String state = getRequest().getParameter("state");
		AjaxSysServiceImpl ajaxServiceImpl = (AjaxSysServiceImpl) ajaxService;
		try {
			ajaxServiceImpl.doUniChangeState(wid, state, parms);
		} catch (Exception e) {
			putResultStringToView(e.getMessage());
			// addActionError(e.getMessage());
		}
	}

	/**
	 * 动态加载表字段
	 * 
	 * @param table
	 * @return
	 * @throws Exception
	 */
	public String getFields() {
		String tableName = getRequest().getParameter("tableName");
		AjaxSysServiceImpl ajaxServiceImpl = (AjaxSysServiceImpl) ajaxService;
		try {
			String fields = ajaxServiceImpl.getFields(tableName);
			datamap.put("fields", fields);
		} catch (Exception e) {
			putResultStringToView(e.getMessage());
		}
		return "SUCCESS";
	}

	/**
	 * 校验输入的信息是否存在
	 * 
	 * @return
	 */
	public String checkDuplicate() {
		String entityName = getRequest().getParameter("entityName");
		String column = getRequest().getParameter("column");
		String value = getRequest().getParameter("value");
		String wid = getRequest().getParameter("wid");
		AjaxSysServiceImpl ajaxServiceImpl = (AjaxSysServiceImpl) ajaxService;
		String tree = ajaxServiceImpl.checkDuplicate(entityName, column, value, wid);
		datamap.put("exists", tree);
		return "SUCCESS";
	}
}
