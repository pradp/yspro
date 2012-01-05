package com.yszoe.sys.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.biz.Constants;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.PropDbUtil;
import com.yszoe.identity.IdConstants;
import com.yszoe.identity.entity.TSysDepart;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.action.AreaAction;
import com.yszoe.sys.entity.TSysArea;
import com.yszoe.sys.util.BusinessLogUtil;
import com.yszoe.util.Char2spell;

/**
 * 部门信息维护。 配合AreaTreeSupport.java类（部门按树展现）使用，所以此处的list方法没有用到。
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class AreaServiceImpl extends AbstractBaseServiceSupport {

	// private static final Log LOG = LogFactory.getLog(AreaServiceImpl.class);
	
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
				object.setAreaid(getNewAreaid(object.getUpareaid()));
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
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_AREA, SysConstants.LOG_ACTION_DEL,
					action.getRequest().getRemoteAddr());
		} else {
			mess = "删除失败";
			throw new Exception(mess);
		}
		return deleteSuccess;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		AreaAction action = (AreaAction) myaction;
		TSysArea object = action.getTsysArea();
		String isEditSelf = action.getParameter("isEditSelf");
		if (StringUtils.isBlank(isEditSelf)) {
			String deptid = object.getAreaid();
			if (StringUtils.isBlank(deptid)) {
				deptid = getNewAreaid(object.getUpareaid());
			}
			if (deptid.length() != object.getAreaid().length()) {
				throw new Exception("区域编号长度不对!");
			} else {
				long c = getBaseDao().count("select count(*) from TSysArea where areaid = ?", object.getAreaid());
				if (c > 0) {
					throw new Exception("区域编号已存在,请重新输入!");
				}
			}
			long c = getBaseDao().count("select count(*) from TSysArea where areaname = ?", object.getAreaname());
			if (c > 0) {
				throw new Exception("已登记该区域,请登记其他区域!");
			}
			object.setArealevel(String.valueOf(deptid.length() / SysConstants.DEPART_CODE_STEP));
			getBaseDao().save(object);	
			// 初始化区域到部门中
			boolean areaToDepart = PropDbUtil.getBoolean(IdConstants.AREA_TO_DEPART);
			if (areaToDepart) {
				TSysDepart t = new TSysDepart();
				t.setDepartid(deptid);
				t.setDepartname(object.getAreaname());
				t.setUpdepartid(object.getUpareaid());
				t.setCity(object.getUpareaid());
//				t.setDeparttype(Constants.DEPARTTYPE_AREA);
				t.setDepartnamePy(Char2spell.getPYString(object.getAreaname()).toUpperCase());
				t.setDepth(String.valueOf(deptid.length() / SysConstants.DEPART_CODE_STEP));
				t.setState("1");
				getBaseDao().save(t);
			}
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_AREA, SysConstants.LOG_ACTION_SAVE,
					action.getRequest().getRemoteAddr());		
			
		} else {
			long c = getBaseDao().count("select count(*) from TSysArea where areaname = ? and areaid != ?",
					object.getAreaname(), object.getAreaid());
			if (c > 0) {
				throw new Exception("已登记该区域,请登记其他区域!");
			}
			getBaseDao().updateNotNull(object);
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_AREA, SysConstants.LOG_ACTION_UPDATE,
					action.getRequest().getRemoteAddr());			
		}
		//向DHI平台同步区域信息；
		
	}

	/**
	 * 根据上级区域号自动生成新区域号
	 * 
	 * @param parentQueryid 上级区域号
	 * @return
	 */
	public final String getNewAreaid(final String parentQueryid) {

		String ResultID = null;
		String hql = " select substr(max(areaid)," + (parentQueryid.length() + 1) + ") from TSysArea where upareaid='"
				+ parentQueryid + "' ";
		Object tmp = null;
		tmp = getBaseDao().findFieldValue(hql);

		if (tmp == null) {
			ResultID = parentQueryid + "001";
		} else {
			ResultID = "00" + (Integer.parseInt(tmp.toString()) + 1);
			ResultID = parentQueryid + ResultID.substring(ResultID.length() - 3);
		}

		return ResultID;
	}

}
