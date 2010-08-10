package com.ht.util.spring;

import org.springframework.context.ApplicationContext;

public class ComponentManager {

	private ApplicationContext appContext;

	private static ComponentManager instance = new ComponentManager();

	public static ComponentManager getInstance() {
		return instance;
	}

	public void setAppContext(ApplicationContext appContext) {
		this.appContext = appContext;
	}

	public Object getComponent(Object componentName) {
		if (appContext == null)
			throw new IllegalStateException(
					"Spring ApplicationContext not initialized yet.");
		if (componentName instanceof Class) {
			return appContext.getBean(((Class) componentName).getName());
		} else {
			return appContext.getBean(componentName.toString());
		}
	}

}
