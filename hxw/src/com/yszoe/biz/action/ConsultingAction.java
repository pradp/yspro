package com.yszoe.biz.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.sys.action.AbstractBaseActionSupport;
import com.yszoe.sys.entity.TSysUserExt;

/**
 * 显示咨询列表
 * 
 * @author Linyang datetime 2011-12-8
 */
@SuppressWarnings("serial")
public class ConsultingAction extends AbstractBaseActionSupport {
	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(ConsultingAction.class);
	
	private TSysUserExt tsysUserExt;

	public TSysUserExt getTsysUserExt() {
		return tsysUserExt;
	}

	public void setTsysUserExt(TSysUserExt tsysUserExt) {
		this.tsysUserExt = tsysUserExt;
	}
}
