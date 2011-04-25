package com.imchooser.infoms.action.biz;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;

/**
 * 打印报表
 * 
 * @author LiBing DateTime 2010-10-10
 */
@SuppressWarnings("serial")
public class SportPrintAction extends BaseActionAbstractSupport {

	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(SportPrintAction.class);
	String bssj;

	public String getBssj() {
		return bssj;
	}

	public void setBssj(String bssj) {
		this.bssj = bssj;
	}

}
