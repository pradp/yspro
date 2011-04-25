package com.yszoe.sys.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
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
import com.yszoe.framework.identity.IdConstants;
import com.yszoe.framework.identity.action.IdUserAction;
import com.yszoe.framework.identity.entity.LoginUserVO;
import com.yszoe.framework.identity.entity.TSysDepart;
import com.yszoe.framework.identity.entity.TSysUser;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.PropDbUtil;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.SysConstants;

/**
 * 用户登录处理类。包括系统管理员也集成在此登录。
 *
 * @author Yangjianliang
 * datetime 2011-2-26
 */
@SuppressWarnings("serial")
public class AjaxLogin extends HttpServlet {

	private static Log LOG = LogFactory.getLog(AjaxLogin.class);

	@SuppressWarnings("unchecked")
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/javascript;charset=UTF-8");

		Map outData = new HashMap();
		HttpSession session = request.getSession(true);
		TSysUser user = (TSysUser)session.getAttribute(IdConstants.SESSION_USER);
		String userLoginId = request.getParameter("yonghu");
		if(user!=null){//已经登录的直接转到里面
			if(user.getUserLoginId().equals(userLoginId)){
				outData.put("msg", "already");//由客户端处理已登录的，进行转向。
				putGo2url(user.getUsertype(), outData);

			}else{
				outData.put("msg", "本地已有其他账户登录，如需切换用户请先退出登陆！");
			}
		}else{
			String passWord = request.getParameter("mima");
			if (StringUtils.isBlank(userLoginId) || StringUtils.isBlank(passWord)) {
				outData.put("msg", "缺少参数：姓名和密码不能为空！");
			}else{
				String sql = "select t.userloginid, t.userpwd, x.mc as username, t.state, t.usertype from t_sys_user t left join t_qmjs_hydl_hyxx x on x.userid=t.userloginid where t.userloginid =? ";
				TSysUser loginuser = (TSysUser)DBUtil.queryBean(sql, TSysUser.class, userLoginId);
				//TODO 对于账户密码错误次数需要记录，防止客户端穷举破解账户
				if (loginuser==null) {
					outData.put("msg", "用户名不存在！");
				} else {
					if (passWord.equals(loginuser.getUserPwd())) {
						if( IdConstants.USER_STATE_FORBID.equals(loginuser.getState()) ){
							outData.put("msg", "该帐号暂时不能使用，如您是刚注册用户，请稍后再来登陆！");
						}else{
								int maxOnlineCount = PropDbUtil.getInteger( IdConstants.MAX_ONLINE_COUNT );//单个节点允许最大在线数
								if( maxOnlineCount < 1 ){
									LOG.error("没有取到最大在线人数值，将使用默认最大人数1000！");
									maxOnlineCount = 1000;
								}
								if(LoginUserVO.getCurrentOnlineCount()>=maxOnlineCount){
									//目前在线人数达到最大数
									outData.put("msg", "此服务器在线人数已达到最大数，请稍候再登录系统！");
								}else{
									if(loginuser.getUsertype().equals(SysConstants.YHLX_ADMIN)){//系统管理员，使用框架登录方法加载权限

										ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
										IdUserAction idUserAction = (IdUserAction)ctx.getBean("idUserAction");
										idUserAction.setServletRequest(request);//必须传入
										idUserAction.setTsysUser(loginuser);

										String ss = idUserAction.login(false);//参数一定要传。false表示服务端登录
										if(Action.SUCCESS.equals(ss)){

											outData.put("msg", "ok");
											outData.put("loginuser", loginuser);
											putGo2url(loginuser.getUsertype(), outData);

										}else{

											outData.put("msg", "登录失败！");
										}
									}else if(loginuser.getUsertype().equals(SysConstants.YHLX_UNLABELLED)){

										outData.put("msg", "登录失败，用户身份类型未审核！");
									}else{

										LoginUserVO loginUserVO = new LoginUserVO();
										loginUserVO.setDepart(loginuser.getDepart());
										loginUserVO.setState(loginuser.getState());
										loginUserVO.setUserid(loginuser.getUserid());
										loginUserVO.setUserLoginId(loginuser.getUserLoginId());
										loginUserVO.setUserName(loginuser.getUserName());
										loginUserVO.setUserPwd(loginuser.getUserPwd());
										loginUserVO.setUsertype(loginuser.getUsertype());
										loginUserVO.setClientIP(request.getRemoteAddr());
										loginUserVO.setLoginTime(new Date());
										loginUserVO.setSession(session);
										try {
											//如果是场馆，把场馆基本信息保存在session
											String susertype = loginuser.getUsertype();

											int usertype = putGo2url(susertype, outData);

											if(usertype>4 && usertype<9){//是场馆，还要查出场馆信息放入depart对象
												String sql_cgmc = "select c.wid, case when c.cgbm is null then c.cgmc else c.cgbm end,c.cgdj from t_qmjs_hydl_hyxx t, t_qmjs_cgxx c where c.wid=t.cgid and t.userid=? ";
												Object[] cgmc = DBUtil.queryRowColumns(sql_cgmc, loginuser.getUserLoginId());
												if(cgmc!=null){
													loginUserVO.setUserName( String.valueOf(cgmc[1]) );//场馆名称
													loginuser.setUserName( String.valueOf(cgmc[1]) );
													TSysDepart depart = new TSysDepart();
													depart.setDepartid( String.valueOf(cgmc[0]) );//场馆WID
													depart.setDepartname( String.valueOf(cgmc[1]) );//场馆名称
													//depart.setDeparttype( String.valueOf(cgmc[2]) );
													if( "1".equals(cgmc[2]) ){//表示是中心：1中心，2普通场馆
														depart.setUpdepartid( depart.getDepartid() );//给个是中心的标记，身份切换成普通馆，这个属性的值保留不变。
													}
													loginUserVO.setDepart(depart);
												}
											}

											//登录信息写入session
											loginUserVO.setServerIP(InetAddress.getLocalHost().getHostAddress());
											session.setAttribute(IdConstants.SESSION_USER, loginUserVO);
											outData.put("msg", "ok");
											outData.put("loginuser", loginuser);

											//记录登录时间信息
											String sql1 = "insert into t_qmjs_hyfl_hpy_hyzj(wid,hyid,sj,nr,createtime,sfck,cgwid,type,zjtype)" +
													" values('"+SeqFactory.getNewSequenceAlone()+"','"+loginuser.getUserLoginId()+"',sysdate,'',sysdate,'0','','0','1')";
											DBUtil.executeSQL(sql1);

											String sql2 = "update t_qmjs_hydl_hyxx set hyzjs=hyzjs+1 where userid in(select hyid from t_qmjs_hyfl_hpy where userid='"+loginuser.getUserLoginId()+"')";
											DBUtil.executeSQL(sql2);
										} catch (UnknownHostException e1) {
											LOG.error(e1);
											outData.put("msg", "请联系管理员解决：获取登录服务节点地址出错！"+e1.getMessage());
										}
									}
								}

						}
					} else {
						outData.put("msg", "密码错误！");
					}
				}
			}
		}

		String outMsg;
		try {
			outMsg = JSONUtil.serialize(outData);
		} catch (JSONException e) {
			outMsg = "{msg:'json对象转换异常："+e+"'}";
		}
//		String outMsg = JSONUtils.valueToString(outData);
		PrintWriter out = response.getWriter();
		out.print(outMsg);
		out.flush();
		out.close();
	}

	@SuppressWarnings("unchecked")
	private int putGo2url(String susertype, Map outData){

		int usertype = Integer.parseInt(susertype);
		if(usertype>0 && usertype<5){
			//爱好者
			outData.put("go2url", "business/qmjsHpyXxs-list.c");
		}else if(usertype>4 && usertype<9){
			//场馆
			outData.put("go2url", "business/qmjsCgydHy-list.c?yd=1");
		}else if(usertype==999){
			//系统管理员
			outData.put("go2url", "identity/index.c");
		}else{
			outData.put("go2url", "");
		}
		return usertype;
	}
}
