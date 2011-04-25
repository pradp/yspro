package com.imchooser.infoms.service.sys.impl;

import java.util.List;

import com.imchooser.framework.dao.BaseDao;
import com.imchooser.infoms.service.sys.ApplicationEnumService;

/**
 * 字典对象，一般用于JSP页面配合select标签显示数据
 * 
 * @author Administrator
 * 
 */
public class ApplicationEnumImpl implements ApplicationEnumService {

	// private transient static final Log log =
	// LogFactory.getLog(ApplicationEnumImpl.class);

	private BaseDao baseDao;

	@SuppressWarnings("unchecked")
	public List getApplicationEnums(boolean useSecondCache,
			String hsql, Object... params) {

		return baseDao.findByHqlWithSecondCache(useSecondCache, hsql, params);
	}

	public Object getFieldValue(String hql, Object... params) {

		return baseDao.findFieldValue(hql, params);
	}

	public BaseDao getBaseDao() {
		return baseDao;
	}

	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}

}
