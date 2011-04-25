package com.yszoe.sys.action;

import com.yszoe.sys.entity.TSysMessage;

/**
 * 
 * @author <a href="cdji.jundu@gmail.com">chundongji</a> 2008-11-3 ����07:30:12
 * 
 */
@SuppressWarnings("serial")
public class MessageManagerAction extends BaseActionAbstractSupport {

	private TSysMessage tsysMessage;

	public TSysMessage getTsysMessage() {
		return tsysMessage;
	}

	public void setTsysMessage(TSysMessage sysMessage) {
		tsysMessage = sysMessage;
	}

}
