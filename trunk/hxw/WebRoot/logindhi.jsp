<%@page import="com.yszoe.util.crypto.CipherUtil"%>
<%@page import="com.yszoe.sys.util.SysConfigUtil"%>
<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.yszoe.identity.entity.LoginUserVO"%>
<%
Object u = session.getAttribute(com.yszoe.identity.IdConstants.SESSION_USER);
if( null != u ){
	LoginUserVO user = (LoginUserVO)u;
	String userLoginId = user.getUserloginid();
	String key = SysConfigUtil.getString("DhiKey");
	String str = CipherUtil.encryptByAES("fd" + userLoginId, key);//生成加密字符串。fd是伪码。
	String DhiLoginUrl = SysConfigUtil.getString("DhiLoginUrl");
	//System.out.println(DhiLoginUrl + "?id=" + str);
	response.sendRedirect( DhiLoginUrl + "?id=" + str );
}else{
	//out.println("<script>alert('您访问的资源需要登录后才有权限使用，请先登录！');location.href='./'</script>");
	response.sendRedirect("identity/index.action");
	//response.sendRedirect( SysConfigUtil.getString("DhiLoginPageUrl") );
}

%>
