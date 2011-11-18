package com.yszoe.sys.service.impl;

import java.sql.ResultSet;
import java.text.MessageFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.ysen.tree.entitybean.TreeNode;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.framework.dao.BaseDao;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.entity.ApplicationEnum;
import com.yszoe.sys.service.AjaxService;
import com.yszoe.sys.util.SQLConfigUtil;
import com.yszoe.sys.util.SysPropertiesUtil;

/**
 * 提供客户端用JS通过DWR调用。 注意此类没有做安全控制，且其内的所有方法都对外公开， 所以这些方法实现必须考虑数据安全性，一般只做查询数据用。
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
@SuppressWarnings("unchecked")
public class AjaxSysServiceImpl implements AjaxService {

	private static final Log LOG = LogFactory.getLog(AjaxSysServiceImpl.class);

	private BaseDao baseDao;
	
	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}

	public boolean checkRecordExist(String targetTableObject, String columnName, String columnValue) {

		String hql = "select count(*) from " + targetTableObject + " where " + columnName + "='" + columnValue + "'";
		long i = baseDao.count(hql);
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}

	public Map<String, String> getSelectContents(String sqlmapid, String findValue) throws Exception {

		if (sqlmapid == null) {
			LOG.error("非法SQL语句编号");
			throw new Exception("不存在这样的SQL语句编号！");
		}
		String sql = SQLConfigUtil.getSql(sqlmapid);
		if (sql == null || sql.trim().equals("")) {
			throw new Exception("不存在这样的SQL语句！");
		}
		ResultSet rs = DBUtil.queryRowSet(sql, findValue);
		Map<String, String> map = new HashMap<String, String>();
		if (rs != null) {
			while (rs.next()) {
				map.put(rs.getString(1), rs.getString(2));
			}
		}
		return map;
	}

	/**
	 * 校验新增组织机构是否已存在
	 */
	public boolean checkDepartData(String departname, String updepartid) {
		String hql = "from TSysDepart where departname=? and updepartid=?";
		long c = baseDao.count(hql, departname, updepartid);
		if (c != 0) {
			return false;
		}
		return true;
	}

	/**
	 * 用于系统参数维护页面的刷新
	 */
	public String refreshSysProp() {
		try {
			SysPropertiesUtil.loadSysProps();
			return "true:";
		} catch (Exception e) {
			return "false:" + e.getMessage();
		}
	}

	/**
	 * 获取当前时间的年月
	 * 
	 * @return
	 */
	public String getYearAndMonth() {
		String year_month = null;
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		if (month >= 10) {
			year_month = year + "" + month;
		} else {
			year_month = year + "0" + month;
		}
		return year_month;
	}

	/**
	 * tree 加载子节点 菜单维护 在areaTree模块使用ajax调用
	 * 
	 * @param treeType 数据来源类型：depart, area, menu ...
	 * @param nodeid 上级节点编码
	 * @return
	 */
	public String loadTreeChild(String treeType, String nodeid) {
		String sql = null;
		if (SysConstants.TREETYPE_DEPART_AREA.equals(treeType)) {
			sql = SQLConfigUtil.getSql("sql.departtree.loadMySons");
			sql = MessageFormat.format(sql, "city", " city as ", " city = ?");
		} else if (SysConstants.TREETYPE_DEPART.equals(treeType)) {
			sql = SQLConfigUtil.getSql("sql.departtree.loadMySons");
			sql = MessageFormat.format(sql, "updepartid", "updepartid as ", " updepartid = ?");
		} else if (SysConstants.TREETYPE_AREA.equals(treeType)) {
			sql = SQLConfigUtil.getSql("sql.areatree.loadMySons");
		} else if (SysConstants.TREETYPE_MENU.equals(treeType)) {
			sql = SQLConfigUtil.getSql("sql.menutree.loadMySons");
		} else {
			return "{}";
		}
		return loadTreeChild(sql, new Object[] { nodeid });

	}

	/**
	 * 根据sql返回树结构json字符串
	 * 
	 * @param sql
	 * @param parms 参数
	 * @return
	 */
	protected String loadTreeChild(String sql, Object[] parms) {
		List<TreeNode> list = DBUtil.queryAllBeanList(sql, TreeNode.class, parms);
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		if (list != null && list.size() > 0) {
			for (TreeNode code : list) {
				sb.append("{id:'" + code.getId()).append("',pid:'").append(code.getParentid()).append("',name:'")
						.append(code.getText()).append("',childCount:'").append(code.getChildCount()).append("',url:'")
						.append(code.getValue() == null ? "" : code.getValue()).append("'},");
			}
			sb.setCharAt(sb.toString().length() - 1, ']');
		} else {
			sb.append("]");
		}
		return sb.toString();
	}

	/**
	 * 更新状态 只负责简单的状态变更，比如启用禁用。状态有逻辑控制的，放各自模块里。
	 * 
	 * @param action
	 * @param wid 主键id,可以有多个,用","隔开
	 * @param state 更新的状态值
	 * @param parms 参数 键值对形式,包含表名 主键名 状态字段名 及其他需要更新的时间字段
	 * @throws Exception
	 */
	public void doUniChangeState(String wid, String state, String parms) throws Exception {
		String[] parms_ = parms.split(";");
		// entityName:t_scjc_xx;idName:wid;stateName:state;1:sbsj;2:shsj;-2:shsj
		String entity = null;
		String id_name = "wid";
		String state_name = "state";
		String sql_ = "";
		for (int i = 0; i < parms_.length; i++) {
			String parm = parms_[i];
			String[] parm_ = parm.split(":");
			if ("entityName".equals(parm_[0])) { // 获取表名
				entity = parm_[1];
			} else if ("idName".equals(parm_[0])) {// 获取主键名
				id_name = parm_[1];
			} else if ("stateName".equals(parm_[0])) {// 获取状态字段名
				state_name = parm_[1];
			} else if (state.equals(parm_[0])) {// 获取其他需要更新的时间字段
				if (parm_.length == 2) {
					sql_ += ",a." + parm_[1] + "=sysdate";
				} else {
					sql_ += ",a." + parm_[1] + "=null";
				}
			}
		}
		if (StringUtils.isNotBlank(entity)) {
			String sql = "update " + entity + " a set a." + state_name + " = ?" + sql_ + " where " + id_name + " in ('"
					+ wid.replaceAll(",", "','") + "')";
			DBUtil.executeSQL(sql, state);
		} else {
			throw new Exception("缺少必要信息(表名等)！");
		}
	}

	/**
	 * 根据sql返回json字符串
	 * 
	 * @param sql
	 * @param parms 参数
	 * @param exists_headKey 是否要请选择选项
	 * @return
	 */
	public String loadJsonValue(String sql, Object[] parms, boolean exists_headKey) {
		List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class, parms);
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		if (exists_headKey) {
			sb.append("{id:'',caption:'--请选择--'},");
		}
		if (list != null && list.size() > 0) {
			for (ApplicationEnum code : list) {
				if (StringUtils.isNotBlank(code.getId())) {
					sb.append("{id:'" + code.getId()).append("',caption:'" + code.getCaption()).append("'},");
				}
			}
		}
		sb.setCharAt(sb.toString().length() - 1, ']');
		if (sb.toString().length() == 1) {
			return "[]";
		}
		return sb.toString();
	}

	/**
	 * execl导入 模块 动态加载表字段
	 * 
	 * @param table
	 * @return
	 * @throws Exception
	 */
	public String getFields(String tableName) throws Exception {
		String sql = "SELECT column_name as id,column_name as caption FROM user_tab_columns"
				+ " WHERE table_name=upper(?) order by column_id";
		return loadJsonValue(sql, new Object[] { tableName }, true);
	}
}
