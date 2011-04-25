package com.yszoe.sys.action;

import com.yszoe.sys.entity.TSysButtonEnumRule;
import com.yszoe.sys.entity.TSysButtonRule;

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
