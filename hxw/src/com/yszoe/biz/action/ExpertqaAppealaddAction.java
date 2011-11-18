package com.yszoe.biz.action;

import java.util.List;

import com.yszoe.biz.entity.TExpertqaAppeal;
import com.yszoe.biz.entity.TExpertqaAppealadd;
import com.yszoe.sys.action.AbstractBaseActionSupport;

/**
 * 
 * 问题信息维护
 * @author chenlu
 * datetime 2011-7-22
 */
@SuppressWarnings("serial")
public class ExpertqaAppealaddAction extends AbstractBaseActionSupport {		
	
	private TExpertqaAppeal texpertqaAppeal;
	
	private TExpertqaAppealadd texpertqaAppealadd;
	
	private List<TExpertqaAppeal> listTExpertqaAppeal;	

	private List<TExpertqaAppealadd> listTExpertqaAppealadd;	

	
	public List<TExpertqaAppealadd> getListTExpertqaAppealadd() {
		return listTExpertqaAppealadd;
	}
	public void setListTExpertqaAppealadd(List<TExpertqaAppealadd> listTExpertqaAppealadd) {
		this.listTExpertqaAppealadd = listTExpertqaAppealadd;
	}
	public TExpertqaAppealadd getTexpertqaAppealadd() {
		return texpertqaAppealadd;
	}
	public void setTexpertqaAppealadd(TExpertqaAppealadd texpertqaAppealadd) {
		this.texpertqaAppealadd = texpertqaAppealadd;
	}
	public TExpertqaAppeal getTexpertqaAppeal() {
		return texpertqaAppeal;
	}
	public void setTexpertqaAppeal(TExpertqaAppeal texpertqaAppeal) {
		this.texpertqaAppeal = texpertqaAppeal;
	}

	
	public List<TExpertqaAppeal> getListTExpertqaAppeal() {
		return listTExpertqaAppeal;
	}

	public void setListTExpertqaAppeal(List<TExpertqaAppeal> listTExpertqaAppeal) {
		this.listTExpertqaAppeal = listTExpertqaAppeal;
	}
	
}
