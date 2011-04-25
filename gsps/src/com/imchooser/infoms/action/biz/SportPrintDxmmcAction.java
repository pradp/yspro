package com.imchooser.infoms.action.biz;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;

/**
 * 根据大项目打印报表
 * @author LiBing
 * DateTime 2010-10-18
 */
@SuppressWarnings("serial")
public class SportPrintDxmmcAction extends BaseActionAbstractSupport{

	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(SportPrintDxmmcAction.class);
	String dxmmc;
	public String getDxmmc() {
		return dxmmc;
	}
	public void setDxmmc(String dxmmc) {
		this.dxmmc = dxmmc;
	}

}
