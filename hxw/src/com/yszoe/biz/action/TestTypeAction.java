package com.yszoe.biz.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.biz.entity.TCsLx;
import com.yszoe.sys.action.AbstractBaseActionSupport;

/**
 * 测试类别
 * 
 * @author Linyang datetime 2011-12-27
 */
@SuppressWarnings("serial")
public class TestTypeAction extends AbstractBaseActionSupport {
	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(TestTypeAction.class);
	private TCsLx tcsLx;

	public TCsLx getTcsLx() {
		return tcsLx;
	}

	public void setTcsLx(TCsLx tcsLx) {
		this.tcsLx = tcsLx;
	}
}
