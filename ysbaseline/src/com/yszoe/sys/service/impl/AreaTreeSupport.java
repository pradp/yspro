package com.yszoe.sys.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import net.ysen.tree.entitybean.TreeNode;
import net.ysen.tree.impl.YstreeLightImpl;

import com.yszoe.framework.identity.entity.TSysDepart;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.sys.SysConstants;

/**
 * 支持区域以树的形式展示
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class AreaTreeSupport extends YstreeLightImpl {

	/**
	 * 取数据源
	 * 
	 * @throws SQLException
	 */
	public static List<TSysDepart> QueryTreeData(final String menuid)
			throws SQLException {

		// String sql = "select departid,departName from T_Sys_Depart where
		// cc='1' or cc='3' or (cc='4' and departtype='7' and departid like ?)
		// order by departid";
		String sql = "select departid,departName from T_Sys_depart where departid like ? order by length(departid), departid";
		List<Object[]> list = DBUtil.queryAllList(sql, menuid + "%");
		if (list == null) {
			return new ArrayList<TSysDepart>(0);
		}
		List<TSysDepart> nodes = new ArrayList<TSysDepart>();
		for (Object[] line : list) {
			TSysDepart node = new TSysDepart();
			String line0 = String.valueOf(line[0]);
			node.setDepartid(line0);
			node.setDepartname(String.valueOf(line[1]));
			node.setUpdepartid(line0.substring(0, line0.length()
					- SysConstants.DEPART_CODE_STEP));
			nodes.add(node);
		}
		return nodes;
	}

	/**
	 * 取树的数据源。区域数据。
	 * 
	 * @throws SQLException
	 */
	public static List<TSysDepart> QueryAreaData() throws SQLException {

		// String sql = "select departid,departName,updepartid from T_Sys_Depart
		// where cc='1' or cc='2' or ((cc='3' or cc='4') and departtype='7')
		// order by departid";
		String sql = " select areaid,areaname,upareaid from t_sys_area where state=1 order by areaid ";
		List<Object[]> list = DBUtil.queryAllList(sql);
		if (list == null) {
			return new ArrayList<TSysDepart>(0);
		}
		List<TSysDepart> nodes = new ArrayList<TSysDepart>();
		for (Object[] line : list) {
			TSysDepart node = new TSysDepart();
			String line0 = String.valueOf(line[0]);
			node.setDepartid(line0);
			node.setDepartname(String.valueOf(line[1]));
			node.setUpdepartid(line0.substring(0, line0.length()
					- SysConstants.DEPART_CODE_STEP));
			nodes.add(node);
		}
		return nodes;
	}

	/**
	 * 取数据源，列出省中心、市县教育局、高校、院系。用于消息发送时的接收人选择。
	 * 
	 * @throws SQLException
	 */
	public static List<TSysDepart> QueryDepartData() throws SQLException {

		// String sql = "select departid,departName from T_Sys_Depart where
		// cc='1' or cc='3' or (cc='4' and departtype='7' and departid like ?)
		// order by departid";
		String sql = "select departid,departName from T_Sys_Depart where (Departtype='6' or Departtype='7' or Departtype='9') and sfsn=1 order by departid";
		List<Object[]> list = DBUtil.queryAllList(sql);
		if (list == null) {
			return new ArrayList<TSysDepart>(0);
		}
		List<TSysDepart> nodes = new ArrayList<TSysDepart>();
		for (Object[] line : list) {
			TSysDepart node = new TSysDepart();
			String line0 = String.valueOf(line[0]);
			node.setDepartid(line0);
			node.setDepartname(String.valueOf(line[1]));
			node.setUpdepartid(line0.substring(0, line0.length()
					- SysConstants.DEPART_CODE_STEP));
			nodes.add(node);
		}
		return nodes;
	}

	/**
	 * 转换数据对象，支持ystree数据源
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<TreeNode> treeBeanConversion(List list) {
		List<TreeNode> sons = new ArrayList<TreeNode>();
		for (int i = 0, j = list.size(); i < j; i++) {
			TSysDepart o = (TSysDepart) list.get(i);
			TreeNode treeson = new TreeNode();
			treeson.setId(o.getDepartid());
			treeson.setParentid(o.getUpdepartid());
			treeson.setText(o.getDepartname());
			treeson.setValue(o.getDepartid());
			sons.add(treeson);
		}
		return sons;
	}

}
