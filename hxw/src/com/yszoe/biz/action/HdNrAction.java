package com.yszoe.biz.action;

import java.io.File;

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
	private File syydt;
	private String syydtContentType;
	private String syydtFileName;

	public THdNr getThdNr() {
		return thdNr;
	}

	public void setThdNr(THdNr thdNr) {
		this.thdNr = thdNr;
	}

	public File getSyydt() {
		return syydt;
	}

	public void setSyydt(File syydt) {
		this.syydt = syydt;
	}

	public String getSyydtContentType() {
		return syydtContentType;
	}

	public void setSyydtContentType(String syydtContentType) {
		this.syydtContentType = syydtContentType;
	}

	public String getSyydtFileName() {
		return syydtFileName;
	}

	public void setSyydtFileName(String syydtFileName) {
		this.syydtFileName = syydtFileName;
	}
	
}

