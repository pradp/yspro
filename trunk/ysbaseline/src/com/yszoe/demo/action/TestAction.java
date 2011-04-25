package com.yszoe.demo.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.yszoe.demo.entity.User;
import com.yszoe.demo.service.TestService;

/**
 * 
 * @author Yangjianliang
 * datetime 2011-4-2
 */
public class TestAction extends ActionSupport{

	private static final Log LOG = LogFactory.getLog(TestAction.class);
	
	User user;
	
	String targetView;
	
	/**
	 * @return the user
	 */
	public User getUser() {
		return user;
	}

	/**
	 * @param user the user to set
	 */
	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * @return the targetView
	 */
	public String getTargetView() {
		return targetView;
	}

	/**
	 * @param targetView the targetView to set
	 */
	public void setTargetView(String targetView) {
		this.targetView = targetView;
	}

	TestService testService;

	/**
	 * @return the testService
	 */
	public TestService getTestService() {
		return testService;
	}

	/**
	 * @param testService the testService to set
	 */
	public void setTestService(TestService testService) {
		this.testService = testService;
	}

	public String load(){
		try {
			testService.load(this);
		} catch (Exception e) {
			LOG.error(e);
			// TODO Auto-generated catch block
		}
		targetView = "ysview";
		return SUCCESS;
	}
}
