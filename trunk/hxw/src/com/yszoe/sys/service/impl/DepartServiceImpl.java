package com.yszoe.sys.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.biz.Constants;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.identity.entity.TSysDepart;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.action.DepartAction;
import com.yszoe.sys.entity.TDepartDetail;
import com.yszoe.sys.util.BusinessLogUtil;
import com.yszoe.util.Char2spell;

/**
 * 部门信息维护。 配合AreaTreeSupport.java类（部门按树展现）使用，所以此处的list方法没有用到。
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class DepartServiceImpl extends AbstractBaseServiceSupport {

	// private static final Log LOG =
	// LogFactory.getLog(DepartServiceImpl.class);

	/**
	 * 用于发送消息时选择接收部门
	 * 
	 * @param myaction
	 * @param pager
	 * @return
	 * @throws Exception
	 */
	public List<?> list(Object myaction, Pager pager) throws Exception {
		DepartAction action = (DepartAction) myaction;
		TSysDepart tSysDepart = action.getTsysDepart();
		String depid = action.getParameter("depid");
		String hqlcolumn = "select new TSysDepart(a.departid, "
				+ "(select c.departname from TSysDepart c where c.departid=a.updepartid) as updepartid"
				+ ", a.departname, '', '', '', '')";
		String hql = " from TSysDepart a where state='1' ";// 省内可用的部门
		if (StringUtils.isNotBlank(depid)) {
			hql += " and departid like '" + depid + "___'";
		}
		if (tSysDepart != null) {
			if (StringUtils.isNotBlank(tSysDepart.getDepartname())) {
				hql += " and a.departname like '%" + tSysDepart.getDepartname() + "%'";
			}
			if (StringUtils.isNotBlank(tSysDepart.getDepartid())) {
				hql += " and a.departid like '" + tSysDepart.getDepartid() + "%'";
			}
			if (StringUtils.isNotBlank(tSysDepart.getDeparttype())) {
				hql += " and a.departtype = '" + tSysDepart.getDeparttype() + "'";
			}
			if (StringUtils.isNotBlank(tSysDepart.getUpdepartid())) {
				hql += " and a.updepartid in (select c.departid from TSysDepart c where c.departname like '%"
						+ tSysDepart.getUpdepartid() + "%')";
			}
		}

		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + " order by a.updepartid";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	public void load(Object myaction) throws Exception {
		DepartAction action = (DepartAction) myaction;
		String departid = action.getWid();
		TSysDepart object = (TSysDepart) getBaseDao().findById(TSysDepart.class, departid);
		if (departid.length() / 3 == 1) {// 省中心
			object.setUpdepartid("0");
			object.setUpdepartname("");
		} else {
			TSysDepart upobject = (TSysDepart) getBaseDao().findById(TSysDepart.class, object.getUpdepartid());
			object.setUpdepartid(upobject.getDepartid());
			object.setUpdepartname(upobject.getDepartname());
		}
		object.setCityname(getCityName(object.getCity()));
		action.setTsysDepart(object);
	}

	@Override
	public void openCreate(Object myaction) throws Exception {
		DepartAction action = (DepartAction) myaction;
		if (action.getTsysDepart() != null) {
			String updepartid = action.getTsysDepart().getUpdepartid();
			TSysDepart upobject = (TSysDepart) getBaseDao().findById(TSysDepart.class, updepartid);
			TSysDepart object = new TSysDepart();
			object.setUpdepartid(upobject.getDepartid());
			object.setUpdepartname(upobject.getDepartname());
			object.setDeparttype(Constants.DEPARTTYPE_MEMBER);
			action.setTsysDepart(object);
			action.setParameter("type", action.getParameter("type"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#remove(java.lang.Object)
	 */
	public boolean remove(Object myaction) throws Exception {
		DepartAction action = (DepartAction) myaction;
		String mess = null;
		mess = DBUtil.callProcQueryString("prc_sys_deletedepartid(?,?,?)", action.getTsysDepart().getDepartid(), action
				.getDepartid());
		boolean deleteSuccess = "1".equals(mess);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginuser().getUserloginid(), SysConstants.CZDX_T_SYS_DEPART,
					SysConstants.LOG_ACTION_DEL, action.getRequest().getRemoteAddr());
		} else {
			throw new Exception(mess);
		}
		return deleteSuccess;
	}

	/**
	 * 根据上级部门号自动生成新部门编号
	 * 
	 * @param parentQueryid 上级区域号
	 * @return
	 */
	public final String getNewDepartid(String parentQueryid) {

		String ResultID = null;
		String hql = " select substr(max(departid)," + (parentQueryid.length() + 1)
				+ ") from TSysDepart where updepartid='" + parentQueryid + "' ";
		Object tmp = null;
		tmp = getBaseDao().findFieldValue(hql);

		if (tmp == null) {
			ResultID = parentQueryid + "00001".substring("00001".length() - SysConstants.DEPART_CODE_STEP);
		} else {
			/*
			 * 部门表添加部门时默认从201开始,前面的1-199用于添加区域时自动初始化到部门表
			 */
			if (parentQueryid.length() == SysConstants.DEPART_CODE_STEP) {
				int max_id = Integer.parseInt(tmp.toString());
				if (max_id < 200) {
					ResultID = "201";
				} else {
					ResultID = "0000" + (Integer.parseInt(tmp.toString()) + 1);
				}
			} else {
				ResultID = "0000" + (Integer.parseInt(tmp.toString()) + 1);
			}
			ResultID = parentQueryid + ResultID.substring(ResultID.length() - SysConstants.DEPART_CODE_STEP);
		}

		return ResultID;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		DepartAction action = (DepartAction) myaction;
		TSysDepart object = action.getTsysDepart();
		if (StringUtils.isNotBlank(object.getDepartname())) {
			object.setDepartnamePy(Char2spell.getPYString(object.getDepartname()).toUpperCase());
		}
		action.setParameter("type", action.getParameter("type"));
		if (StringUtils.isBlank(object.getDepartid())) {
			long c = getBaseDao().count("select count(*) as c from TSysDepart a where a.departname = ? ",
					object.getDepartname());
			if (c > 0) {
				throw new Exception("部门名重复!");
			}
			object.setDepartnamePy( getCheckedDepartnamePy( object.getDepartnamePy() ) );//找到唯一的拼音
			
			String deptid = getNewDepartid(object.getUpdepartid());
			object.setDepartid(deptid);
			object.setDepth(String.valueOf(deptid.length() / SysConstants.DEPART_CODE_STEP));
			getBaseDao().save(object);
			// 添加部门时自动添加部门信息表空记录
			TDepartDetail tdepartDetail = new TDepartDetail(deptid);
			getBaseDao().save(tdepartDetail);
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_DEPART, SysConstants.LOG_ACTION_SAVE,
					action.getRequest().getRemoteAddr());
			// action.setSuccessFlag("1");

		} else {
			long c = getBaseDao().count(
					"select count(*) as c from TSysDepart a where a.departname = ? and a.departid != ?",
					object.getDepartname(), object.getDepartid());
			if (c > 0) {
				throw new Exception("部门名重复!");
			}
			object.setDepartnamePy( getCheckedDepartnamePy( object.getDepartnamePy() ) );//找到唯一的拼音
			getBaseDao().updateNotNull(object);
			BusinessLogUtil.log(action.getUserloginid(), SysConstants.CZDX_T_SYS_DEPART,
					SysConstants.LOG_ACTION_UPDATE, action.getRequest().getRemoteAddr());
			// action.setSuccessFlag("1");
		}
	}

	/**
	 * 根据区域编码获取区域名
	 * 
	 * @param city 区域编码
	 * @return 区域名
	 * @throws SQLException
	 */
	public String getCityName(String city) throws SQLException {
		String sql = "select areaname from TSysArea where areaid =?";
		String cityname = null;
		if (StringUtils.isNotBlank(city)) {
			cityname = (String) getBaseDao().findFieldValue(sql, city);
		}
		return cityname;
	}
	
	/**
	 * 检查生成的部门拼音是否在数据库已经存在。
	 * 存在就在后面加1，递归检查，直到找到唯一的值
	 * @param departnamePy
	 * @return
	 * @throws SQLException 
	 */
	public static String getCheckedDepartnamePy(String departnamePy) throws SQLException{
		long c = DBUtil.count("from t_sys_depart where departname_py = ?", departnamePy);
		if (c > 0) {
			departnamePy = departnamePy + "1";
			departnamePy = getCheckedDepartnamePy( departnamePy );//重复直到找到唯一的值
		}
		return departnamePy;
	}
}
