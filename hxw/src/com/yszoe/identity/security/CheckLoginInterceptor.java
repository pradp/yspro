/**
 * 项目：用户权限系统
 * 模块：过滤访问的action url,判断用户身份，检查是否登录，检查是否有权限访问要访问的URL
 * 作者：Yangjianliang
 * 日期：2007-8-31
 */
package com.yszoe.identity.security;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.yszoe.framework.util.FrameWorkCfgUtil;
import com.yszoe.identity.IdConstants;
import com.yszoe.identity.entity.LoginUserVO;
import com.yszoe.identity.entity.TSysMenu;

public final class CheckLoginInterceptor extends AbstractInterceptor {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	private static final Log log = LogFactory.getLog(CheckLoginInterceptor.class);
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.opensymphony.xwork2.interceptor.AbstractInterceptor#intercept(com.opensymphony.xwork2.ActionInvocation)
	 */
	@Override
	public String intercept(ActionInvocation actionInvocation) throws Exception {
//		 对LoginAction不做该项拦截

//        Object action = actionInvocation.getAction();
/*
        if ( action instanceof WebmasterAction ) {

        	log.info("Check Adminstrator Login : Somebody is logining or logout......");

            return actionInvocation.invoke();

        }
*/
		// 确认Session中是否存在LOGIN

//		Map session = actionInvocation.getInvocationContext().getSession();
		HttpServletRequest request = ServletActionContext.getRequest();
		if(request==null){
			return Action.LOGIN;
		}
		HttpSession session = request.getSession();
		if(session==null){
			return Action.LOGIN;
		}
		Object loginUser = session.getAttribute( IdConstants.SESSION_USER );

		if ( loginUser != null ) {

//			return actionInvocation.invoke();
			
			// 检查用户对URL的访问权限。
			if(log.isDebugEnabled()){
				log.debug("Check User Login : already login!");
			}
			
			/** 版权控制start *
			try {
				Copyright.validate();
			} catch (Exception e) {
				Object o = actionInvocation.getAction();
				if(o instanceof BaseAction){
					BaseAction action = (BaseAction)o;
					action.addActionMessage(e.getMessage());
				}else{
					session.invalidate();
					return Action.LOGIN;
				}
			}
			/** 版权控制end */

			/*
			 * 由于经过struts处理后request对象，
			 * getRequestURI()获取的结果会变成/WEB-INF/jsp/xxx/input.jsp。
			 * 所以在CheckLoginInterceptor里提前存入以前的getRequestURI()值。这里直接获取。
			 */
			request.setAttribute(IdConstants.CurrentRequestURI, request.getRequestURI());
			
			if("true".equalsIgnoreCase(FrameWorkCfgUtil.getString(IdConstants.OPEN_CHECK_URL_RIGHT))){
				//ys_jd_framework_cfg.properties文件里配置了 开启URL权限验证 功能
				if( checkHasRightToAccessTheMenu(request) ){
					if(log.isDebugEnabled()){
						log.debug("Check User Menu Right : pass!");
					}
					return actionInvocation.invoke();
				}else{
					//无权访问此URL，清除此人的SESSION，令其重新登录
					session.invalidate();
					return Action.LOGIN;
				}
			}else{
				//ys_jd_framework_cfg.properties文件里没有配置开启URL权限验证，执行粗粒度控制，只要登陆就可以访问当前菜单。
				return actionInvocation.invoke();
			}
			
		} else {

			// 否则终止后续操作，返回LOGIN
			if(log.isDebugEnabled()){
				log.debug("Check User Login : no login, forward login page!");
			}
			return Action.LOGIN;
		}
	}
	
	/**
	 * 检测用户是否有权限访问要访问的URL
	 * @param request 当前访问对象，包含用户可访问URL集合
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private final static boolean checkHasRightToAccessTheMenu(HttpServletRequest request){

		HttpSession session = request.getSession();
		
		List<TSysMenu> tsysMenus = (List<TSysMenu>) session.getAttribute( IdConstants.SESSION_USER_RIGHT_MENUS );
		if(tsysMenus==null || tsysMenus.isEmpty()){
			return false;
		}
		//取用户当前正要访问的URL
		String currentAccessUri = request.getRequestURI().toLowerCase();
		if(request.getQueryString()!=null){
			currentAccessUri += "?" + request.getQueryString();
		}
		for(int i=0,j=tsysMenus.size(); i<j; i++){
			//查找是否有当前访问的菜单权限
			TSysMenu tsysMenu = tsysMenus.get(i);
			String rightMenuPath = tsysMenu.getMenupath();
			if(rightMenuPath==null || rightMenuPath.trim().equals("") || rightMenuPath.trim().equals("/")){
				//上级菜单，没有地址的，直接跳过
				continue;
			}
			
			rightMenuPath = getActionNameFromUrl(rightMenuPath);//目前系统不需要细粒度的菜单控制，控制的栏目授权就可以了
			
			if( currentAccessUri.indexOf( rightMenuPath )!=-1 ){
				return true;
			}
		}
		if(log.isWarnEnabled()){
			LoginUserVO loginUser = (LoginUserVO)session.getAttribute(IdConstants.SESSION_USER);
			String loginid = loginUser.getUserloginid();
			String userName = loginUser.getUsername();
			log.warn("forbid ["+userName+"] login with ["+loginid+"] to access this menu :: [" + currentAccessUri +"]" );
		}
		return false;
	}

	/**
	 * 从url里获取action名称
	 * @param url
	 * @return action name
	 */
	private final static String getActionNameFromUrl(String url){
		
		String actionName = StringUtils.EMPTY;
		//分割?号，去掉后面参数部分
		String[] arr_url = url.split("\\?");
		url = arr_url[0].toLowerCase();
		
		url = url.replaceAll("\\\\", "/");//URL中路径分隔符是/
		
		int lastIndexOfChar = url.lastIndexOf("/");
		if(lastIndexOfChar!=-1){
			url = url.substring(lastIndexOfChar);
			int indexOfChar = url.indexOf("-");
			if(indexOfChar!=-1){
				//处理./system/depart-areaTree.c这样的URI
				actionName = url.substring(1, indexOfChar);//最终取URL的ACTION名部分，即业务模块名
			}else{
				//处理./identity/repwd.c这样的URI
				actionName = url.replaceAll("."+IdConstants.SYS_URI_SUFFIX, "");
			}
		}
		return actionName;
	}

	/**
	 * 获得用户当前访问的URL对应的菜单对象
	 * 注意这个方法的检查规则是完全匹配URL才行。
	 * @param request 当前访问对象，包含用户可访问URL集合
	 * @param currentAccessUri 取用户当前正要访问的URL
	 * @return 用户当前访问的URL对应的菜单对象，不存在就返回null
	 */
	public final static TSysMenu getCurrentAccessedMenuObject(HttpServletRequest request){

		TSysMenu currentAccessedMenu = null;
		HttpSession session = request.getSession();

		@SuppressWarnings("unchecked")
		List<TSysMenu> tsysMenus = (List<TSysMenu>) session.getAttribute( IdConstants.SESSION_USER_RIGHT_MENUS );
		if(tsysMenus==null || tsysMenus.isEmpty()){
			return null;
		}
		
		//取用户当前正要访问的URL
		String currentAccessUri = (String)request.getAttribute(IdConstants.CurrentRequestURI);
		/*
		 * 由于经过struts处理后request对象，获取的结果会变成/WEB-INF/jsp/xxx/input.jsp。
		 * 所以在CheckLoginInterceptor里提前存入以前的getRequestURI()值。这里直接获取。
		 */
		if(request.getQueryString()!=null){
			currentAccessUri += "?" + request.getQueryString();//把URL后面的参数加上
		}
		
		for(int i=0,j=tsysMenus.size(); i<j; i++){
			//迭代查找是否有访问当前菜单的权限
			TSysMenu tsysMenu = tsysMenus.get(i);
			String rightMenuPath = tsysMenu.getMenupath();
			if(rightMenuPath==null || rightMenuPath.trim().equals("") || rightMenuPath.length()<5){
				//没有地址的，可能是上级菜单，直接跳过
				continue;
			}
			rightMenuPath = rightMenuPath.replaceAll("\\\\", "/");//URL中路径分隔符是/
			if(rightMenuPath.startsWith("./")){//本系统使用的地址定义格式
				if( currentAccessUri.indexOf( rightMenuPath.replaceFirst("./", "") )!=-1 ){
					currentAccessedMenu = tsysMenu;
					break;
				}
			}
		}
		
		return currentAccessedMenu;
	}
}
