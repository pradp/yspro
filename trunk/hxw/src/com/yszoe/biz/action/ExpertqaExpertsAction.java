package com.yszoe.biz.action;

import java.util.List;

import com.yszoe.biz.entity.TExpertqaExperts;
import com.yszoe.biz.service.ExpertqaExpertsService;
import com.yszoe.sys.action.AbstractBaseActionSupport;

/**
 * 
 * 维护专家资料
 * @author chenlu
 * datetime 2011-7-22
 */
@SuppressWarnings("serial")
public class ExpertqaExpertsAction extends AbstractBaseActionSupport {		
	
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
	public void checkusername() throws Exception {
		ExpertqaExpertsService service = (ExpertqaExpertsService) this.getBaseService();
		boolean f=service.checkusername(this);
		if (f){
			putResultStringToView("true");
		}else{
			putResultStringToView("false");
		}
	}
	 public String save()
	  {
	    try
	    {
	      this.getBaseService().saveOrUpdate(this);
	      addActionMessage(getText("MESSAGE_SAVE_SUCCESS"));
	    } catch (Throwable e) {
	      addActionError(getText("MESSAGE_SAVE_FAILURE") + " [" + e.getMessage() + "]");
	    }
	    String syxz = this.getParameter("sfxz");// 保存并新增按钮
		if ("1".equals(syxz)) {
			texpertqaExperts=new TExpertqaExperts();
			return "input";
		}
	    return "entity";
	  }
	
	 public void checkemail() throws Exception {
		ExpertqaExpertsService service = (ExpertqaExpertsService) this.getBaseService();
		boolean f=service.checkemail(this);
		if (f){
			putResultStringToView("true");
		}else{
			putResultStringToView("false");
		}
	}
	
}
