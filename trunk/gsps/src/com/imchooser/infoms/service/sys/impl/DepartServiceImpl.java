package com.imchooser.infoms.service.sys.impl;

import java.util.List;
import java.util.ResourceBundle;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.identity.entity.TSysDepart;
import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.sys.DepartAction;
import com.imchooser.infoms.entity.sys.TDepartDetail;
import com.imchooser.infoms.util.BusinessLogUtil;
import com.imchooser.infoms.util.CommonQuery;
import com.imchooser.infoms.util.SQLConfigUtil;
import com.imchooser.util.Char2spell;

/**
 * 部门信息维护。 配合AreaTreeSupport.java类（部门按树展现）使用，所以此处的list方法没有用到。
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class DepartServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		return null;
	}

	/**
	 * 用于发送消息时选择接收部门
	 * 
	 * @param myaction
	 * @param pager
	 * @return
	 * @throws Exception
	 */
	public List<?> selectDeparts(Object myaction, Pager pager) throws Exception {
		DepartAction action = (DepartAction) myaction;
		TSysDepart tSysDepart = action.getTsysDepart();
		String depid = action.getParameter("depid");
		String hqlcolumn = "select new TSysDepart(a.departid,a.departname, "
				+ "(select c.departname from TSysDepart c where c.departid=a.updepartid) as updepartid,"
				+ "'','','','','','')";
		String hql = " from TSysDepart a where state='1' and sfsn='1'";// 省内可用的部门
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

	public List<?> search(Object myaction, Pager pager) throws Exception {
		DepartAction action = (DepartAction) myaction;
		TSysDepart tSysDepart = action.getTsysDepart();
		TDepartDetail tDepartDetail = action.getDepartDetail();
		String sqlcolumn = "select a.departid,a.departname, "
				+ "(select c.departname from T_Sys_Depart c where c.departid=a.updepartid) as updepartid,"
				+ "b.linkman,b.linktel,b.email,b.fax ";
		String sql = " from T_Sys_Depart a left join T_Depart_Detail b on a.departid=b.departid where a.departid like '"
				+ action.getDepartID() + "%' and a.sfsn='1'";

		if (tSysDepart != null) {
			if (StringUtils.isNotBlank(tSysDepart.getDepartname())) {
				sql += " and a.departname like '%" + tSysDepart.getDepartname() + "%'";
			}
			if (StringUtils.isNotBlank(tSysDepart.getDepartid())) {
				sql += " and a.departid like '" + tSysDepart.getDepartid() + "%'";
			}
			if (StringUtils.isNotBlank(tSysDepart.getUpdepartid())) {
				sql += " and a.updepartid in (select c.departid from T_Sys_Depart c where c.departname like '%"
						+ tSysDepart.getUpdepartid() + "%')";
			}
		}
		if (tDepartDetail != null) {
			if (StringUtils.isNotBlank(tDepartDetail.getLinkman())) {
				sql += " and b.linkman like '%" + tDepartDetail.getLinkman() + "%'";
			}
		}
		long c = DBUtil.count(" select count(*) as c " + sql);
		pager.setTotalRows(c);
		sql = sqlcolumn + sql + "  order by a.departid ,a.cc desc ";
		List<?> list = DBUtil.queryPageList(pager, sql);
		return list;
	}

	public void departdetail(Object myaction) throws Exception {
		openCreate(myaction);
	}

	@Override
	public void openCreate(Object myaction) throws Exception {
		DepartAction action = (DepartAction) myaction;
		if (action.getTsysDepart() != null) {
			String departid = action.getTsysDepart().getDepartid();
			String updepartid = action.getTsysDepart().getUpdepartid();
			if (departid != null) {
				TSysDepart object = (TSysDepart) getBaseDao().findById(TSysDepart.class, departid);
				action.setTsysDepart(object);
				if ("1".equals(object.getDeparttype())) {// 省中心
					action.setUpdepartid("0");
					action.setUpdepartname("");
				} else {
					TSysDepart upobject = (TSysDepart) getBaseDao().findById(TSysDepart.class, object.getUpdepartid());
					action.setUpdepartid(upobject.getDepartid());
					action.setUpdepartname(upobject.getDepartname());
				}
				TDepartDetail tdepartDetail = (TDepartDetail) getBaseDao().findById(TDepartDetail.class, departid);
				action.setDepartDetail(tdepartDetail);
			} else if (updepartid != null) {
				TSysDepart object = (TSysDepart) getBaseDao().findById(TSysDepart.class, updepartid);
				action.setUpdepartid(object.getDepartid());
				action.setUpdepartname(object.getDepartname());
			}
		}
	}

	public void load(Object myaction) throws Exception {
		DepartAction action = (DepartAction) myaction;
		if (action.getDepart() != null) {
			String departid = action.getDepart().getDepartid();
			if (departid != null) {
				TSysDepart object = (TSysDepart) getBaseDao().findById(TSysDepart.class, departid);
				action.setTsysDepart(object);
			}
			String updepartid = action.getDepart().getUpdepartid();
			if (updepartid != null) {
				TSysDepart object = (TSysDepart) getBaseDao().findById(TSysDepart.class, updepartid);
				object.setDepartid(null);
				object.setDepartcode(null);
				object.setDepartname(null);
				action.setTsysDepart(object);
			}
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
		mess = DBUtil.execOracleProcQueryString("prc_sys_deletedepartid(?,?,?)", action.getTsysDepart().getDepartid(),
				action.getDepartID());
		boolean deleteSuccess = "1".equals(mess);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_DEPART,
					Constants.LOG_ACTION_DEL);
		} else {
			throw new Exception(mess);
		}
		return deleteSuccess;
	}

	public String getNewDepartid(String departid) throws Exception {
		String mess = null;
		ResourceBundle resourceBundle = ResourceBundle.getBundle("sqlmap");
		String pd = resourceBundle.getString("procd.maxdepartid");
		mess = DBUtil.execOracleProcQueryString(pd, departid);
		return mess;
	}

	public Object saveOrUpdate11(Object myaction) throws Exception {
		
		return null;
	}

	/**
	 * 得到部门属性
	 * 
	 * @param departtype
	 * @return
	 */
	private static String getDeparttype(String departtype) {
		String result = "";
		if ("2".equals(departtype)) {
			result = "7";
		} else if ("7".equals(departtype)) {
			result = "8";
		} else if ("3".equals(departtype)) {
			result = "6";
		} else if ("6".equals(departtype)) {
			result = "9";
		}
		return result;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		DepartAction action = (DepartAction) myaction;
		TSysDepart object = action.getTsysDepart();
		object.setUpdepartid(action.getUpdepartid());
		if (object.getDepartname() != null && object.getDepartnamePy() == null) {
			object.setDepartnamePy(Char2spell.getPYString(object.getDepartname()));
		}
		TDepartDetail tDepartDetail = action.getDepartDetail();

		String proceduceName = SQLConfigUtil.getProcName("procd.changeDepart");
		if (object.getDepartid() == null || "".equals(object.getDepartid())) {
			String deptid = getNewDepartid(action.getUpdepartid());
			/**
			 * String deptid=""; String sql="select max(departid) from
			 * t_sys_depart where updepartid='"+object.getUpdepartid()+"'";
			 * String id=(String)DBUtil.queryField(sql); if(id==null) {
			 * deptid=object.getUpdepartid()+"001"; } else { Long
			 * nl=Long.parseLong(id)+1L; deptid=String.valueOf(nl); }
			 */
			object.setDepartid(deptid);
			if ("0".equals(object.getUpdepartid())) {
				object.setCc("1");
				object.setDeparttype("1");
			} else {
				// 查询上级部门
				TSysDepart updepart = (TSysDepart) getBaseDao().findById(TSysDepart.class, action.getUpdepartid());
				if (updepart == null)
					return;
				object.setCc(String.valueOf(Integer.parseInt(updepart.getCc()) + 1));
				object.setDeparttype(getDeparttype(updepart.getDeparttype()));
			}
			getBaseDao().save(object);
			tDepartDetail.setDepartid(deptid);
			getBaseDao().save(tDepartDetail);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_DEPART,
					Constants.LOG_ACTION_SAVE);
			action.setSuccessFlag("1");

			DBUtil.execUniProcNoneQuery(proceduceName, deptid, "1");// 调用存储过程更新相关业务数据
		} else {
			// 动态更新
			TSysDepart olddepart = (TSysDepart) getBaseDao().findById(TSysDepart.class, object.getDepartid());
			// 如果不为空则更新部门名称
			if (StringUtils.isNotBlank(object.getDepartname())) {
				olddepart.setDepartname(object.getDepartname());
			}
			// 如果不为空则更新上级部门ID
			if (StringUtils.isNotBlank(action.getUpdepartid())) {
				olddepart.setUpdepartid(action.getUpdepartid());
			}
			// 如果不为空则更新部门ID
			// if(StringUtils.isNotBlank(action.getTsysDepart().getDepartid())){
			// olddepart.setDepartid(action.getTsysDepart().getDepartid());
			// }
			olddepart.setSfsn(object.getSfsn());
			olddepart.setState(object.getState());
			getBaseDao().update(olddepart);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_DEPART,
					Constants.LOG_ACTION_UPDATE);
			// 动态更新
			TDepartDetail olddetail = (TDepartDetail) getBaseDao().findById(TDepartDetail.class, object.getDepartid());
			// 如果不为空则更新部门ID
			// if(StringUtils.isNotBlank(action.getTsysDepart().getDepartid())){
			// tDepartDetail.setDepartid(action.getTsysDepart().getDepartid());
			// }
			if (olddetail == null) {
				olddetail = new TDepartDetail();
				olddetail.setDepartid(object.getDepartid());
				// throw new Exception("数据不完整，缺少此部门的扩展信息数据。请联系技术人员解决此问题！");
			}
			olddetail.setAccount1(tDepartDetail.getAccount1());
			olddetail.setAccount2(tDepartDetail.getAccount2());
			olddetail.setHh(tDepartDetail.getHh());
			olddetail.setHh2(tDepartDetail.getHh2());
			olddetail.setZhmc(tDepartDetail.getZhmc());
			olddetail.setZhmc2(tDepartDetail.getZhmc2());
			olddetail.setAddress(tDepartDetail.getAddress());
			olddetail.setBank1(tDepartDetail.getBank1());
			olddetail.setBank2(tDepartDetail.getBank2());
			olddetail.setEmail(tDepartDetail.getEmail());
			olddetail.setFax(tDepartDetail.getFax());
			olddetail.setLinkman(tDepartDetail.getLinkman());
			olddetail.setLinktel(tDepartDetail.getLinktel());
			olddetail.setPostcode(tDepartDetail.getPostcode());
			//
			getBaseDao().saveOrUpdate(olddetail);
			//
			action.setSuccessFlag("1");
			DBUtil.execUniProcNoneQuery(proceduceName, object.getDepartid(), "2");// 调用存储过程更新相关业务数据
		}

		DBUtil.execOracleProcQueryString("prc_sys_init(?,?,?)", CommonQuery.getThisSchoolYear(), '0');

	}

}
