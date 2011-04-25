<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.imchooser.framework.identity.entity.LoginUserVO"%>
<%@ page import="com.imchooser.util.*"%>
<%@ page import="java.net.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	List users = LoginUserVO.getOnlineUsers();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>在线人列表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet" href="resources/css/zxdk.css" type="text/css">

	</head>

	<body>
		<table id="buttonTable" align="center" border="0" cellspacing="3" cellpadding="0"
			width="80%">
			<tr>
				<td colspan="3">
					<%
					try {
						   Enumeration interfaces = NetworkInterface.getNetworkInterfaces();
						   while (interfaces.hasMoreElements()) {
						    NetworkInterface interfaceN = (NetworkInterface)interfaces.nextElement();
						    Enumeration ienum = interfaceN.getInetAddresses();
						    while (ienum.hasMoreElements()) {
						     InetAddress ia = (InetAddress)ienum.nextElement();
						     if(ia instanceof Inet4Address){
						      if(ia.getHostAddress().toString().startsWith("127")) {
						       continue;
						      }
						      else {
						       out.println(ia.getHostAddress()+"、");
						       break;
						      }
						      
						     } 
						     //if(ia instanceof Inet6Address){
						     // System.out.println(ia.getHostAddress()+"---ipv6");
						     //}
						    }
						   }
						  }
						  catch (Exception e) {
							  out.println(e.getMessage());
						  }
					%>上，
					共有
					<a href="../infoms/onlinelist.jsp"><font color="blue"><%=users.size()%></font></a>
					人在线，点击查看详细信息
				</td>
			</tr>
		</table>
	</body>
</html>
