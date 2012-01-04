package com.yszoe.biz.action;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.biz.entity.TCsTm;
import com.yszoe.biz.entity.TCsXm;
import com.yszoe.biz.service.TestProjectService;
import com.yszoe.sys.action.AbstractBaseActionSupport;
import com.yszoe.sys.entity.ApplicationEnum;

/**
 * 测试项目
 * 
 * @author Linyang datetime 2011-12-27
 */
@SuppressWarnings("serial")
public class TestProjectAction extends AbstractBaseActionSupport {
	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(TestProjectAction.class);

	private TCsXm tcsXm;
	private List<TCsTm> listTcstm;

	public TCsXm getTcsXm() {
		return tcsXm;
	}

	public void setTcsXm(TCsXm tcsXm) {
		this.tcsXm = tcsXm;
	}

	public List<TCsTm> getListTcstm() {
		return listTcstm;
	}

	public void setListTcstm(List<TCsTm> listTcstm) {
		this.listTcstm = listTcstm;
	}

	/**
	 * 
	 * @return
	 */
	public String lookup() {
		TestProjectService service = (TestProjectService) this.getBaseService();
		try {
			service.lookup(this);
		} catch (Throwable e) {
			addActionError(getText("MESSAGE_QUERY_FAILURE") + " [" + e.getMessage() + "]");
		}
		return toView("lookup.jsp");
	}

	/**
	 * 获取测试类型
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getType() {
		String hql = "select new ApplicationEnum(a.wid as id,a.lx as caption) from TCsLx a where a.state='1'";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		list.add(0, new ApplicationEnum("", "----请选择----"));
		return list;
	}
}
