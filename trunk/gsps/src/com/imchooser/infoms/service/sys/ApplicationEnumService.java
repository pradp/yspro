/***********************************************************
 * 
 * 说 明：
 * 作 者：Andly
 * 日 期：2007-11-13
 *
 **********************************************************/
package com.imchooser.infoms.service.sys;

import java.util.List;

import com.imchooser.framework.dao.BaseDao;

public interface ApplicationEnumService {

	/**
	 * 得到一组数据列表
	 * @param hql hibernate查询语句
	 * @param useSecondCache
	 *            是否针对此查询结果使用二级缓存，默认为false。
	 *            当查询的表是系统的字典表时，建议使用二级缓存。
	 *            其他业务表一般不用此缓存（特别是经常更新数据的表），开启反而影响性能。
	 * @param params 动态参数
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getApplicationEnums(boolean useSecondCache, String hql, Object... params);

	/**
	 * 查询某个字段的值
	 * @param hql hibernate查询语句
	 * @param params 参数
	 * @return
	 */
	public Object getFieldValue(String hql, Object... params);
	
	/**
	 * 
	 * @return BaseDao
	 */
	public BaseDao getBaseDao();
}
