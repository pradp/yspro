package com.imchooser.infoms.action.sys;

import com.imchooser.infoms.entity.sys.TSysButtonEnumRule;
import com.imchooser.infoms.entity.sys.TSysButtonRule;

public class ButtonEnumRuleAction extends BaseActionAbstractSupport {
	private TSysButtonRule tsysButtonRule;
	private TSysButtonEnumRule tsysButtonEnumRule;

	public TSysButtonEnumRule getTsysButtonEnumRule() {
		return tsysButtonEnumRule;
	}

	public void setTsysButtonEnumRule(TSysButtonEnumRule tsysButtonEnumRule) {
		this.tsysButtonEnumRule = tsysButtonEnumRule;
	}

	public TSysButtonRule getTsysButtonRule() {
		return tsysButtonRule;
	}

	public void setTsysButtonRule(TSysButtonRule tsysButtonRule) {
		this.tsysButtonRule = tsysButtonRule;
	}

}
