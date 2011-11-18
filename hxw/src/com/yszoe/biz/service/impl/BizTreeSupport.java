package com.yszoe.biz.service.impl;

import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.List;

import net.ysen.tree.entitybean.TreeNode;

import org.apache.commons.lang.StringUtils;

import com.yszoe.framework.util.DBUtil;
import com.yszoe.identity.service.impl.TreeSupport;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.util.SQLConfigUtil;

/**
 * 树结构数据源 业务类型
 * 
 * @author Linyang datetime 2011-7-20
 */
@SuppressWarnings("unchecked")
public class BizTreeSupport extends TreeSupport {
	/**
	 * 取部门树数据源
	 * 
	 * @param menuid
	 * @param type
	 * @param state
	 * @param dutyid
	 * @param onlyCompany
	 * @return
	 * @throws SQLException
	 */
	public static List<TreeNode> QueryDepartTreeData(String menuid, String type, String state, String dutyid,
			String onlyCompany, String jcxl) throws SQLException {
		String sql = SQLConfigUtil.getSql("sql.departtree.initAjaxTree");
		if (SysConstants.TREETYPE_DEPART_AREA.equals(type)) {
			if (StringUtils.isBlank(dutyid)) {
				sql = MessageFormat.format(sql, "city", "city as", " (departtype='0' or city='110') and state='1'");
			} else {
				if ("0".equals(jcxl)) {
					sql = MessageFormat.format(sql, "city", "city as",
							" departtype!='1' and state='1' and (departtype = '0' or exists (select null from t_sys_depart b"
									+ " where (a.departid=b.departid or a.departid = b.city or a.departid='" + menuid
									+ "') " + " and exists (select null from t_scjc_depart where dutyid = '" + dutyid
									+ "' and departid=b.departid)))");
				} else {
					sql = MessageFormat.format(sql, "city", "city as",
							" departtype!='1' and state='1' and (departtype = '0' or exists (select null from t_sys_depart b"
									+ " where (a.departid=b.departid or a.departid = b.city or a.departid='" + menuid
									+ "') " + " and exists (select null from t_scjc_depart c where departid=b.departid"
									+ " and exists (select null from t_scjc_duty where (wid = '" + dutyid
									+ "' or parentid = '" + dutyid + "') and wid=c.dutyid))))");
				}
			}
			sql = sql.replaceAll("departid like ", "city = '" + menuid + "' or departid like ");
		} else {
			if (StringUtils.isBlank(dutyid)) {
				if (StringUtils.isBlank(onlyCompany)) {
					sql = MessageFormat.format(sql, "updepartid", "updepartid as", " departtype!='3' and state='1'");
				} else {
					sql = MessageFormat.format(sql, "departname", "updepartid as",
							" departtype in ('0','1') and state='1'");
					menuid = menuid.substring(0, 3);
				}
			} else {
				if (StringUtils.isBlank(onlyCompany)) {
					if ("0".equals(jcxl)) {
						sql = MessageFormat.format(sql, "updepartid", "updepartid as",
								" departtype!='3' and state='1' and (departtype = '0' or exists (select null from t_sys_depart b"
										+ " where (a.departid=b.departid or a.departid = b.updepartid or a.departid='"
										+ menuid + "') "
										+ " and exists (select null from t_scjc_depart where dutyid = '" + dutyid
										+ "' and departid=b.departid)))");
					} else {
						sql = MessageFormat.format(sql, "updepartid", "updepartid as",
								" departtype!='3' and state='1' and (departtype = '0' or exists (select null from t_sys_depart b"
										+ " where (a.departid=b.departid or a.departid = b.updepartid or a.departid='"
										+ menuid + "') "
										+ " and exists (select null from t_scjc_depart c where departid=b.departid"
										+ " and exists (select null from t_scjc_duty where c.dutyid=wid and (wid = '"
										+ dutyid + "' or parentid = '" + dutyid + "')) )))");
					}
				} else {
					if ("0".equals(jcxl)) {
						sql = MessageFormat.format(sql, "departname", "updepartid as",
								" departtype in ('0','1') and state='1' and (departtype='0' or exists (select null from t_sys_depart b"
										+ " where (a.departid=b.departid or a.departid = b.updepartid or a.departid='"
										+ menuid + "') "
										+ " and exists (select null from t_scjc_depart where dutyid = '" + dutyid
										+ "' and departid=b.departid)))");
					} else {
						sql = MessageFormat.format(sql, "departname", "updepartid as",
								" departtype in ('0','1') and state='1' and (departtype='0' or exists (select null from t_sys_depart b"
										+ " where (a.departid=b.departid or a.departid = b.updepartid or a.departid='"
										+ menuid + "') "
										+ " and exists (select null from t_scjc_depart c where departid=b.departid"
										+ " and exists (select null from t_scjc_duty where c.dutyid=wid and (wid = '"
										+ dutyid + "' or parentid = '" + dutyid + "')) )))");
					}
				}
			}
		}
		// menuid = "110";
		sql = sql.replace("length(departid)<9", "length(departid)<=12");
		List<TreeNode> list = DBUtil.queryAllBeanList(sql, TreeNode.class, menuid + "%", menuid);
		return list;
	}

	/**
	 * 取区域树
	 */
	public static List<TreeNode> QueryAreaTreeData(String dutyid, String jcxl) throws SQLException {
		String sql = SQLConfigUtil.getSql("sql.areatree.initAjaxTree");
		if (StringUtils.isNotBlank(dutyid)) {
			String sql_1 = sql.substring(0, sql.lastIndexOf("where"));
			String sql_2 = sql.substring(sql.lastIndexOf("where") + 6);
			if (StringUtils.isBlank(jcxl)) {
				sql = sql_1 + " where (exists (select null from t_sys_depart b where b.city=a.areaid and exists"
						+ " (select null from t_scjc_depart c where c.departid=b.departid and (c.dutyid='" + dutyid
						+ "') )) or areaid='110') and " + sql_2;
			} else {
				sql = sql_1 + " where (exists (select null from t_sys_depart b where b.city=a.areaid and exists"
						+ " (select null from t_scjc_depart c where c.departid=b.departid and (c.dutyid='" + dutyid
						+ "' or exists (select null from t_scjc_duty where parentid = '" + dutyid
						+ "' and wid=c.dutyid)) )) or areaid='110') and " + sql_2;
			}
		}
		List<TreeNode> list = DBUtil.queryAllBeanList(sql, TreeNode.class);
		return list;
	}
}
