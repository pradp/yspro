package com.yszoe.identity.service.impl;

import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

import net.ysen.tree.entitybean.TreeNode;
import net.ysen.tree.impl.YstreeLightImpl;

import com.yszoe.framework.util.DBUtil;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.util.SQLConfigUtil;

/**
 * 
 * @author Linyang datetime 2011-7-20
 */
@SuppressWarnings("unchecked")
public class TreeSupport extends YstreeLightImpl {

	/**
	 * 取树结构数据源
	 * 
	 * @throws SQLException
	 */
	public static List<TreeNode> QueryTreeData(String type, final String menuid) throws SQLException {
		String sql = null;
		Object[] parms = null;
		if (SysConstants.TREETYPE_DEPART_AREA.equals(type)) { // 区域部门数
			sql = SQLConfigUtil.getSql("sql.departtree.initAjaxTree");
			sql = MessageFormat.format(sql, "city", "city as", " (departtype = '0' or city='110')");
			parms = new Object[2];
			parms[0] = menuid + "%";
			parms[1] = menuid;
		} else if (SysConstants.TREETYPE_DEPART.equals(type)) {// 部门树
			sql = SQLConfigUtil.getSql("sql.departtree.initAjaxTree");
			sql = MessageFormat.format(sql, "updepartid", "updepartid as", " departtype!='3'");
			parms = new Object[2];
			parms[0] = menuid + "%";
			parms[1] = menuid;
		} else if (SysConstants.TREETYPE_AREA.equals(type)) { // 区域树
			sql = SQLConfigUtil.getSql("sql.areatree.initAjaxTree");
		} else if (SysConstants.TREETYPE_MENU.equals(type)) { // 菜单树
			sql = SQLConfigUtil.getSql("sql.menutree.initAjaxTree");
			parms = new Object[1];
			parms[0] = menuid + "%";
		} else {
			return new ArrayList<TreeNode>();
		}
		List<TreeNode> list = DBUtil.queryAllBeanList(sql, TreeNode.class, parms);
		return list;
	}

}
