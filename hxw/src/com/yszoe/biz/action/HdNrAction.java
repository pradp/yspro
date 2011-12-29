package com.yszoe.biz.action;

import com.yszoe.biz.entity.THdNr;
import com.yszoe.sys.action.AbstractBaseActionSupport;

/**
 * 活动内容维护
 * @author Yangjianliang
 * datetime 2011-12-28
 */
public class HdNrAction extends AbstractBaseActionSupport {

//	private static final Log LOG = LogFactory.getLog(HdNrAction.class);

	private THdNr thdNr;

	public THdNr getThdNr() {
		return thdNr;
	}

	public void setThdNr(THdNr thdNr) {
		this.thdNr = thdNr;
	}
	
}

