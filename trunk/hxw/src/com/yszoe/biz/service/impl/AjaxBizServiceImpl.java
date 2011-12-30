package com.yszoe.biz.service.impl;

import java.text.MessageFormat;

import org.apache.commons.lang.StringUtils;

import com.yszoe.biz.service.AjaxBizService;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.service.impl.AjaxSysServiceImpl;
import com.yszoe.sys.util.SQLConfigUtil;

/**
 * 提供AJAX支持的类，返回字符串结果，可以是JSON，客户端用AJAX直接调用。
 * 
 * @author Linyang datetime 2011-5-1
 */
public class AjaxBizServiceImpl extends AjaxSysServiceImpl implements AjaxBizService {

	/**
	 * tree 加载子节点 菜单维护 在areaTree模块使用ajax调用
	 * 
	 * @param treeType 数据来源类型：depart, area, menu ...
	 * @param nodeid 上级节点编码
	 * @return
	 */
	public String loadTreeChild(String treeType, String nodeid) {
		if (null != treeType && treeType.indexOf("_") != -1) {
			String[] types = treeType.split("_");
			if (types.length > 0) {
				String type = types[0];
				String dutyid = types.length > 1 ? types[1] : null;
				String jcxl = types.length > 2 ? types[2] : null;
				if (SysConstants.TREETYPE_DEPART.equals(type) || SysConstants.TREETYPE_DEPART_AREA.equals(type)) {
					return loadDepartTreeChild(nodeid, type, dutyid, jcxl);
				}
			}
		}
		return "{}";
	}

	/**
	 * tree 加载子节点 单位树维护 在departTree模块使用ajax调用
	 * 
	 * @param nodeid 上级部门编码
	 * @param type 类型,1为区域部门树,0为部门数
	 * @return
	 */
	private String loadDepartTreeChild(String nodeid, String type, String dutyid, String jcxl) {
		String sql = SQLConfigUtil.getSql("sql.departtree.loadMySons");
		if (SysConstants.TREETYPE_DEPART_AREA.equals(type)) {
			if (StringUtils.isBlank(dutyid)) {
				sql = MessageFormat.format(sql, "city", " city as ", " city = ? and state='1'");
			} else {
				sql = MessageFormat.format(sql, "city", " city as ", " city = ? and state='1' ####");
			}
		} else {
			if (StringUtils.isBlank(dutyid)) {
				sql = MessageFormat.format(sql, "updepartid", " updepartid as ", " updepartid = ? and state='1'");
			} else {
				sql = MessageFormat.format(sql, "updepartid", " updepartid as ", " updepartid = ? and state='1' ####");
			}
		}
		if (StringUtils.isNotBlank(dutyid)) {
			if (StringUtils.isBlank(jcxl)) {
				sql = sql.replaceAll("####", " and exists (select null from t_scjc_depart where dutyid='" + dutyid
						+ "' and departid = a.departid)");
			} else {
				sql = sql.replaceAll("####",
						" and exists (select null from t_scjc_depart b where b.departid = a.departid"
								+ " and exists (select null from t_scjc_duty where wid = b.dutyid and (wid ='" + dutyid
								+ "' or parentid = '" + dutyid + "')))");
			}
		}
		return loadTreeChild(sql, new Object[] { nodeid });
	}
}
