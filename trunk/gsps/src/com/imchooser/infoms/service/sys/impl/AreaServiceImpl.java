package com.imchooser.infoms.service.sys.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.sys.AreaAction;
import com.imchooser.infoms.entity.sys.TSysArea;
import com.imchooser.infoms.util.BusinessLogUtil;

/**
 * 部门信息维护。 配合AreaTreeSupport.java类（部门按树展现）使用，所以此处的list方法没有用到。
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class AreaServiceImpl extends BaseServiceAbstractSupport {

	private static final Log LOG = LogFactory.getLog(AreaServiceImpl.class);
	
	public List<?> list(Object myaction, Pager pager) throws Exception {
		return null;
	}

	@Override
	public void openCreate(Object myaction) throws Exception {
		AreaAction action = (AreaAction) myaction;
		TSysArea object = action.getTsysArea();
		if (object != null) {
			String areaid = object.getAreaid();
			if (areaid != null) {
				object = (TSysArea) getBaseDao().findById(TSysArea.class, areaid);
				action.setTsysArea(object);
				if ("1".equals(object.getArealevel())) {// 省中心
					object.setUpareaid("0");
					object.setUpareaname("");
				} else {
					TSysArea upobject = (TSysArea) getBaseDao().findById(TSysArea.class, object.getUpareaid());
					object.setUpareaid(upobject.getAreaid());
					object.setUpareaname(upobject.getAreaname());
				}
			} else if (object.getUpareaid() != null) {
				TSysArea upobject = (TSysArea) getBaseDao().findById(TSysArea.class, object.getUpareaid());
				object.setUpareaid(upobject.getAreaid());
				object.setUpareaname(upobject.getAreaname());
			}
		}
	}

	public void load(Object myaction) throws Exception {

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#remove(java.lang.Object)
	 */
	public boolean remove(Object myaction) throws Exception {
		AreaAction action = (AreaAction) myaction;
		String mess = null;
		String wid = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TSysArea", "areaid", "=", wid);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_AREA,
					Constants.LOG_ACTION_DEL);
		} else {
			mess = "删除失败";
			throw new Exception(mess);
		}
		return deleteSuccess;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		AreaAction action = (AreaAction) myaction;
		TSysArea object = action.getTsysArea();

		if (StringUtils.isBlank(object.getAreaid())) {
			String deptid = getNewAreaid(object.getUpareaid());
			object.setAreaid(deptid);

			getBaseDao().save(object);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_AREA,
					Constants.LOG_ACTION_SAVE);

		} else {

			getBaseDao().updateNotNull(object);
		}
	}

	public static final String getNewAreaid(final String parentQueryid) {

		String ResultID = null;
		String sql = " select max(departid) from t_sys_area where upareaid='"+parentQueryid+"' ";
		Object tmp = null;
		try {
			tmp = DBUtil.queryFieldValue(sql);
		} catch (SQLException e) {
			LOG.error(e);
		}

		if (tmp == null) {
			ResultID = parentQueryid + "001";
		}else{
			ResultID = String.valueOf(Integer.parseInt(tmp.toString())+1);
		}

		return ResultID;
	}
	
}
