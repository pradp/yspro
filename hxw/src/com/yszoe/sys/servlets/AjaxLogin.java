package com.yszoe.sys.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.json.JSONException;
import org.apache.struts2.json.JSONUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.opensymphony.xwork2.Action;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.PropDbUtil;
import com.yszoe.identity.IdConstants;
import com.yszoe.identity.action.IdUserAction;
import com.yszoe.identity.entity.LoginUserVO;
import com.yszoe.identity.entity.TSysUser;

/**
 * 用户登录处理类。包括系统管理员也集成在此登录。
 * 
 * @author Yangjianliang datetime 2011-2-26
 */
@SuppressWarnings("serial")
public class AjaxLogin extends HttpServlet {

	private static Log LOG = LogFactory.getLog(AjaxLogin.class);

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/plain;charset=UTF-8");

		Map<String, Object> outData = new HashMap<String, Object>();
		HttpSession session = request.getSession(true);
		String act = request.getParameter("act");
		if ("login".equals(act)) {
			TSysUser user = (TSysUser) session.getAttribute(IdConstants.SESSION_USER);
			String userLoginId = request.getParameter("yonghu");
			if (user != null) {// 已经登录的直接转到里面
				if (user.getUserloginid().equals(userLoginId)) {
					outData.put("msg", "already");// 由客户端处理已登录的，进行转向。

				} else {
					outData.put("msg", "本地已有其他账户登录，如需切换用户请先退出登陆！");
				}
			} else {
				String passWord = request.getParameter("mima");
				if (StringUtils.isBlank(userLoginId) || StringUtils.isBlank(passWord)) {
					outData.put("msg", "缺少参数：姓名和密码不能为空！");
				} else {
					String sql = "select * from t_sys_user t where t.userloginid =? ";
					TSysUser loginuser = (TSysUser) DBUtil.queryBean(sql, TSysUser.class, userLoginId);
					// TODO 对于账户密码错误次数需要记录，防止客户端穷举破解账户
					if (loginuser == null) {
						outData.put("msg", "用户名不存在！");
					} else {
						if (passWord.equals(loginuser.getUserpwd())) {
							if (IdConstants.USER_STATE_FORBID.equals(loginuser.getState())) {
								outData.put("msg", "该帐号暂时不能使用，如您是刚注册用户，请稍后再来登陆！");
							} else {
								int maxOnlineCount = PropDbUtil.getInteger(IdConstants.MAX_ONLINE_COUNT);// 单个节点允许最大在线数
								if (maxOnlineCount < 1) {
									LOG.error("没有取到最大在线人数值，将使用默认最大人数1000！");
									maxOnlineCount = 1000;
								}
								if (LoginUserVO.getCurrentOnlineCount() >= maxOnlineCount) {
									// 目前在线人数达到最大数
									outData.put("msg", "此服务器在线人数已达到最大数，请稍候再登录系统！");
								} else {
									ApplicationContext ctx = WebApplicationContextUtils
											.getWebApplicationContext(getServletContext());
									IdUserAction idUserAction = (IdUserAction) ctx.getBean("idUserAction");
									idUserAction.setServletRequest(request);// 必须传入
									idUserAction.setTsysUser(loginuser);

									String ss = idUserAction.login(false);// 参数一定要传。false表示服务端登录
									if (Action.SUCCESS.equals(ss)) {
										outData.put("msg", "ok");
										outData.put("usertype",loginuser.getUsertype());
										outData.put("loginuser", loginuser);
										TSysUser user_ = (TSysUser) session.getAttribute(IdConstants.SESSION_USER);
										outData.put("userdepart", user_.getDepart().getDepartname());
										outData.put("userdepartid", user_.getDepart().getDepartid());
									} else {
										outData.put("msg", "登录失败！");
									}
								}

							}
						} else {
							outData.put("msg", "密码错误！");
						}
					}
				}
			}

		} else if ("logout".equals(act)) {
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
			IdUserAction idUserAction = (IdUserAction) ctx.getBean("idUserAction");
			idUserAction.setServletRequest(request);// 必须传入
			String ss = idUserAction.logout();
			if (Action.LOGIN.equals(ss)) {
				outData.put("msg", "ok");
			} else {
				outData.put("msg", "退出失败！");
			}
		} else if ("checklogin".equals(act)) {
			TSysUser user = (TSysUser) session.getAttribute(IdConstants.SESSION_USER);
			if (null == user) {
				outData.put("msg", "no");
			} else {
				outData.put("msg", "ok");
			}
		}
		String outMsg;
		try {
			outMsg = JSONUtil.serialize(outData);
		} catch (JSONException e) {
			outMsg = "{msg:'json对象转换异常：" + e + "'}";
		}
		PrintWriter out = response.getWriter();
		out.print(outMsg);
		out.flush();
		out.close();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
}
