package com.yszoe.sys.service.impl;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import uk.ltd.getahead.dwr.WebContextFactory;

import com.yszoe.framework.dao.BaseDao;
import com.yszoe.framework.identity.IdConstants;
import com.yszoe.framework.identity.entity.TSysMenu;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.entity.TSysMessageGxqf;
import com.yszoe.sys.service.AjaxService;
import com.yszoe.sys.util.CommonQuery;
import com.yszoe.sys.util.GenAllStaticHtml;
import com.yszoe.sys.util.PropConfigUtil;
import com.yszoe.sys.util.SQLConfigUtil;
import com.yszoe.sys.util.excel.ExcelDBUtil;

/**
 * 提供客户端用JS通过DWR调用。 注意此类没有做安全控制，且其内的所有方法都对外公开， 所以这些方法实现必须考虑数据安全性，一般只做查询数据用。
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class AjaxSysServiceImpl implements AjaxService {

	private static final Log LOG = LogFactory.getLog(AjaxSysServiceImpl.class);

	private BaseDao baseDao;

	public boolean checkRecordExist(String targetTableObject, String columnName, String columnValue) {

		String hql = "select count(*) from " + targetTableObject + " where " + columnName + "='" + columnValue + "'";
		long i = baseDao.count(hql);
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}

	public boolean changeMsgState(String msgId, String state) {
		if (StringUtils.isNotBlank(msgId) && StringUtils.isNotBlank(state)) {
			TSysMessageGxqf tSysMessageGxqf = (TSysMessageGxqf) baseDao.findById(TSysMessageGxqf.class, msgId);

			tSysMessageGxqf.setXxzt(state);
			tSysMessageGxqf.setXxydsj(new Date());
			baseDao.saveOrUpdate(tSysMessageGxqf);
		}
		return true;
	}

	public String getMsgStat(String userId) throws Exception {
		String hql = "select count(*) from TSysMessageGxqf where xxjsr=? and xxzt=? and fszt='1'";

		String msgSize = String.valueOf(baseDao.findFieldValue(hql, userId, SysConstants.MESSAGE_STATE_UNREAD));
		return msgSize;
	}

	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}

	public String getMsgRefreshTime() throws Exception {
		String refreshTime = CommonQuery.getSysProperty("xxsxsj");
		return refreshTime;
	}

	public Map<String, String> getSelectContents(String sqlmapid, String findValue) throws Exception {

		if (sqlmapid == null) {
			LOG.error("非法SQL语句编号");
			throw new Exception("不存在这样的SQL语句编号！");
		}
		String sql = SQLConfigUtil.getSqlString(sqlmapid);
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
				PropConfigUtil.loadSysProps();
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
	public String year_month() {
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
	 * 动态加载表字段
	 * 
	 * @param table
	 * @return
	 * @throws Exception
	 */
	public Object[] getFields(String table) throws Exception {
		return ExcelDBUtil.getTableFields(table).toArray();
	}

	/**
	 * 系统消息发送
	 * 
	 * @param wid
	 * @return 发送成功与否
	 */
	public boolean sendShortMessage(String wid) {
			String sql = null;
			sql = "update t_sys_message t set t.FSZT = '1' where wid = ?";
			boolean successF = DBUtil.executeSQL(sql, wid) > 0;
			sql = "update t_sys_message_gxqf t set t.FSZT = '1' where message_wid = ?";
			boolean successS = DBUtil.executeSQL(sql, wid) > 0;
			return successF && successS;
	}

	/**
	 * 异步生成静态页面
	 */
	public void genPublicHtmlAsync() {
			// 服务器请求地址
			HttpServletRequest requet = WebContextFactory.get().getHttpServletRequest();
			String serverPath = requet.getScheme() + "://127.0.0.1:" + requet.getServerPort() + requet.getContextPath()
					+ "/";
			// 更新静态页面
			GenAllStaticHtml.gen(serverPath);
	}

	/**
	 * 立即生成静态页面
	 * 
	 * @throws IOException
	 */
	public void genPublicHtmlNow() throws IOException {
			// 服务器请求地址
			HttpServletRequest requet = WebContextFactory.get().getHttpServletRequest();
			String serverPath = requet.getScheme() + "://127.0.0.1:" + requet.getServerPort() + requet.getContextPath()
					+ "/";
			// 更新静态页面
			GenAllStaticHtml.setServerPath(serverPath);
			GenAllStaticHtml.createHtmlAllPages();
	}

	/**
	 * tree 加载子节点 菜单维护
	 * 
	 * @param nodeid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String loadTreeChild(String nodeid) {
		String sql = "select menuid as menuid,menuname as menuName,menupath as menuPath,upmenuid as upMenuId,ordernum as ordernum from t_sys_menu  where upmenuid=? order by ordernum desc";
		List<TSysMenu> list = DBUtil.queryAllBeanList(sql, TSysMenu.class, nodeid);
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		if (list != null && list.size() > 0) {
			for (TSysMenu menu : list) {
				sb.append("{id:'" + menu.getMenuid()).append("',pid:'" + menu.getUpMenuId()).append(
						"',name:'" + menu.getMenuName() + "(" + menu.getOrdernum() + ")").append("',url:'").append(
						menu.getMenuPath()).append("'},");
			}
			sb.setCharAt(sb.toString().length() - 1, ']');
		} else {
			sb.append("]");
		}
		return sb.toString();
	}

	/**
	 * 验证用户名是否可用
	 * 
	 * @throws SQLException
	 */
	public int validateYhm(String userLoginId) throws SQLException {
		String hql = "select count(*) from T_SYS_USER where userLoginId='" + userLoginId + "'";
		int count = DBUtil.count(hql);
		return count;
	}

	/**
	 * 验证验证码输入是否正确 return 0:输入不正确;1:输入正确
	 */
	public String validateYzm(String yzm) {
		HttpSession session = WebContextFactory.get().getSession();
		String v_i_c = (String) session.getAttribute(IdConstants.LOGIN_VALIDATE_IMAGE_CONTENT);
		if (v_i_c.equals(yzm)) {
			return "1";
		}
		return "0";
	}
}
