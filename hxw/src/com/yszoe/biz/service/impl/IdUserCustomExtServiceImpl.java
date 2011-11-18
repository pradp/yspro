package com.yszoe.biz.service.impl;

import java.util.List;

import com.yszoe.framework.dao.BaseDao;
import com.yszoe.identity.entity.TSysUser;
import com.yszoe.identity.service.IdUserCustomExtService;

/**
 * 根据业务需求，扩展系统中添加、删除修改用户后的处理。
 * 这里主要是通知DHI。如果是奶牛场用户，要把用户同步到DHI里。
 * @author Yangjianliang
 * datetime 2011-8-11
 */
public class IdUserCustomExtServiceImpl implements IdUserCustomExtService {

//	private static final Log LOG = LogFactory.getLog(IdUserCustomExtServiceImpl.class);

	private BaseDao baseDao;
	
	/* (non-Javadoc)
	 * @see com.yszoe.identity.service.IdUserCustomExtService#afterRemove(java.util.List)
	 */
	@Override
	public void afterRemove(List<TSysUser> sysUsers) {

	}

	/* (non-Javadoc)
	 * @see com.yszoe.identity.service.IdUserCustomExtService#afterAdd(com.yszoe.identity.entity.TSysUser)
	 */
	@Override
	public void afterAdd(TSysUser sysUser) {

	}

	/* (non-Javadoc)
	 * @see com.yszoe.identity.service.IdUserCustomExtService#afterUpdate(com.yszoe.identity.entity.TSysUser)
	 */
	@Override
	public void afterUpdate(TSysUser sysUser) {

	}

	public BaseDao getBaseDao() {
		return baseDao;
	}

	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}

}
