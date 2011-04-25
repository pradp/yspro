package com.imchooser.infoms.servlets;

import java.io.File;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.util.DBUtil;
import com.imchooser.util.FileUtil;

/**
 * 用于启动服务时生成登录背景图片和首页标题图片,保存省份名称,并清空在线用户列表
 * 
 * @author LinYang
 * 
 */
@SuppressWarnings("serial")
public class SysInitAutoLoad extends HttpServlet {

	private static final Log log = LogFactory.getLog(SysInitAutoLoad.class);

	public static String PROVINCE = ""; // 省份名称
	public static String PROVINCE_CODE = ""; //省份编码
	public static String APP_SERVER_URL = ""; //HTTP://218.1.1.1/SPORTS

	public void init() throws ServletException {
		getBackgroundImage();
		emptyOnlineUserList();
		APP_SERVER_URL = this.getServletContext().getRealPath("/");
		String d = APP_SERVER_URL;
		String da;
	}

	/**
	 * 用于启动服务时生成登录背景图片和首页标题图片,并保存省份名称
	 */
	private void getBackgroundImage() {
		String sql = "select a.sfbm,a.sfmc from T_Sys_Init a";
		List<Object[]> list = DBUtil.queryAllList(sql);
		Object[] o = list.get(0);
		PROVINCE_CODE = o[0].toString();
		PROVINCE = o[1].toString();
		// path为图片文件所在路径
		String path = getServletContext().getRealPath("") + File.separator + "resources" + File.separator + "images"
				+ File.separator;
		String bjtempPath = path + "login" + File.separator + "loginbg_" + PROVINCE_CODE + ".jpg";
		String bjPath = path + "login" + File.separator + "loginbg.jpg";
		File tbj = new File(bjtempPath);
		File bj = new File(bjPath);
		if (bj.exists()) {
			bj.delete();
		}
		FileUtil.copy(tbj, bj);
		String tttempPath = path + "vista" + File.separator + "headermain_" + PROVINCE_CODE + ".jpg";
		String ttPath = path + "vista" + File.separator + "headermain.jpg";
		File ttt = new File(tttempPath);
		File tt = new File(ttPath);
		if (tt.exists()) {
			tt.delete();
		}
		FileUtil.copy(ttt, tt);
	}

	/**
	 * 清空在线用户列表
	 */
	private void emptyOnlineUserList() {
		try {
			String sql = "delete from t_sys_online t where server_ip = ?";
			String strip = InetAddress.getLocalHost().getHostAddress();
			DBUtil.executeSQL(sql, strip);
		} catch (UnknownHostException e) {
			log.error("清空在线用户列表出错!" + e);
		}
	}
}
