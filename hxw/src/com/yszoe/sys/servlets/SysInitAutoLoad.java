package com.yszoe.sys.servlets;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.yszoe.framework.util.DBUtil;
import com.yszoe.sys.entity.TSysMessageCtrl;

/**
 * 用于启动服务时生成登录背景图片和首页标题图片,保存省份名称,并清空在线用户列表
 * 
 * @author LinYang
 * 
 */
@SuppressWarnings( { "serial", "unchecked" })
public class SysInitAutoLoad extends HttpServlet {

	// private static final Log log = LogFactory.getLog(SysInitAutoLoad.class);

	public static String APP_SERVER_URL = null; // HTTP://218.1.1.1/SPORTS

	public static List<TSysMessageCtrl> listMessageCtrl = new ArrayList<TSysMessageCtrl>();

	public void init() throws ServletException {
		APP_SERVER_URL = this.getServletContext().getRealPath("/");

		getListMessageCtrl();
	}

	/**
	 * 刷新内存
	 */
	public static void refreshListMessageCtrl() {
		listMessageCtrl.clear();
		getListMessageCtrl();
	}

	/**
	 * 获取消息提示信息
	 * 
	 * @return
	 */
	public static List<TSysMessageCtrl> getListMessageCtrl() {
		if (listMessageCtrl.isEmpty()) {
			String sql = "select a.wid,a.departtype,a.name,a.sql,a.menuid,a.description,a.ordernum,"
					+ "b.menupath as menupath,b.menuname as menuname"
					+ " from t_sys_message_ctrl a left join t_sys_menu b on a.menuid=b.menuid"
					+ " where a.state='1' order by ordernum desc";
			listMessageCtrl = DBUtil.queryAllBeanList(sql, TSysMessageCtrl.class);
		}
		return listMessageCtrl;
	}

}
