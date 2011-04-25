package com.yszoe.demo.service;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.ModelMap;

import com.yszoe.demo.action.TestAction;
import com.yszoe.demo.entity.User;

/**
 * 测试服务
 * @author Yangjianliang
 * datetime 2011-3-29
 */
public class TestService {

	private static final Log LOG = LogFactory.getLog(TestService.class);

	public List list(ModelMap modelMap){
		LOG.info(modelMap.get("results"));
		modelMap.addAttribute("aaa", "yangjl");
		return null;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	public void load(Object arg0) throws Exception {
		TestAction ta = (TestAction)arg0;
		User user = new User();
		ta.setUser(user);
		user.setId(100);
		user.setName("yangjl");
	}

	public void load2(ModelMap model) throws Exception {
		User user = new User();
		model.addAttribute("user", user);
		user.setId(100);
		user.setName("yangjl");
	}
	
	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#remove(java.lang.Object)
	 */
	public boolean remove(Object arg0) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	public void saveOrUpdate(Object arg0) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
