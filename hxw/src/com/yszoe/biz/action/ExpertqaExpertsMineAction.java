package com.yszoe.biz.action;

import java.util.List;

import com.yszoe.biz.entity.TExpertqaExperts;
import com.yszoe.biz.service.ExpertqaExpertsService;
import com.yszoe.sys.action.AbstractBaseActionSupport;

/**
 * 
 * 专家维护个人信息
 * @author chenlu
 * datetime 2011-7-22
 */
@SuppressWarnings("serial")
public class ExpertqaExpertsMineAction extends AbstractBaseActionSupport {		
	
	private TExpertqaExperts texpertqaExperts;
	
	public TExpertqaExperts getTexpertqaExperts() {
		return texpertqaExperts;
	}
	public void setTexpertqaExperts(TExpertqaExperts texpertqaExperts) {
		this.texpertqaExperts = texpertqaExperts;
	}

	private List<TExpertqaExperts> listTExpertqaExperts;	

	public List<TExpertqaExperts> getListTExpertqaExperts() {
		return listTExpertqaExperts;
	}

	public void setListTExpertqaExperts(List<TExpertqaExperts> listTExpertqaExperts) {
		this.listTExpertqaExperts = listTExpertqaExperts;
	}

	public String input(){
		 try {
		        this.getBaseService().load(this);
		      } catch (Throwable e) {
		        addActionError(getText("MESSAGE_LOAD_FAILURE") + " [" + e.getMessage() + "]");
		      }
		      return "entity";
	  }
	
}
