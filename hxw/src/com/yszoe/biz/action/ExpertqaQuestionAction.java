package com.yszoe.biz.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.biz.entity.TExpertqaAppeal;
import com.yszoe.biz.entity.TExpertqaAppealadd;
import com.yszoe.biz.service.ExpertqaAppealService;
import com.yszoe.biz.service.ExpertqaQuestionService;
import com.yszoe.sys.action.AbstractBaseActionSupport;
import com.yszoe.sys.entity.ApplicationEnum;

/**
 * 
 * 向专家提问
 * 
 * @author chenlu datetime 2011-7-22
 */

@SuppressWarnings("serial")
public class ExpertqaQuestionAction extends AbstractBaseActionSupport {
	private static final Log LOG = LogFactory.getLog(ExpertqaQuestionAction.class);

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

	public void update() {
		ExpertqaAppealService service = (ExpertqaAppealService) this.getBaseService();
		boolean f = service.doupdate(this);
		if (f) {
			putResultStringToView("提交成功");
		} else {
			putResultStringToView("提交失败");
		}

	}

	public String lookup() {
		ExpertqaQuestionService service = (ExpertqaQuestionService) this.getBaseService();
		try {
			service.lookup(this);
		} catch (Exception e) {
			LOG.error(e);
		}
		return toView("lookup.jsp");
	}

	/**
	 * 系统字典
	 * 
	 * @return
	 */

	public List<ApplicationEnum> getExpertqaExpert() {
		ExpertqaAppealService service = (ExpertqaAppealService) this.getBaseService();
		List<ApplicationEnum> list = null;
		String sql = "select t.userid,t.name,c.zdmc photo from T_Expertqa_Experts t ";
		sql += " left join T_Sys_Code c on c.zdbm=t.sort_Id and c.zdlb='sort_id' order by c.zdmc";

		list = service.getApplicationEnums(sql);

		return list;
	}

}
