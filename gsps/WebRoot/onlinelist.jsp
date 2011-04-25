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


		<script type="text/javascript">
	</script>
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
					<%=users.size()%>
					人在线，点击查看详细信息
				</td>
			</tr>
		</table>
		<table id="listTable" align="center" border="1" cellspacing="0" cellpadding="0"
			width="80%">
			<thead id="listHead">
				<tr>
					<td width="25%">
						<b>用户名称</b>
					</td>
					<td width="15%">
						<b>登录账号</b>
					</td>
					<td width="25%">
						<b>所属部门</b>
					</td>
					<td width="15%">
						<b>登录IP</b>
					</td>
					<td>
						<b>登录时间</b>
					</td>
				</tr>
			</thead>
			<tbody id="listData">
				<%
						for (int i = 0, j = users.size(); i < j; i++) {
						LoginUserVO user = (LoginUserVO) users.get(i);
				%>
				<tr>
					<td>
						<a href="superdepart.jsp?updepartid=<%=user.getDepart().getUpdepartid() %>">
						<%=user.getUserName()%></a>
					</td>
					<td>
						<%=user.getUserLoginId()%>
					</td>
					<td>
						<%=user.getDepart().getDepartname() %>
					</td>
					<td>
						<%=user.getClientIP() %>
					</td>
					<td>
						<%= DateUtil.formatDate(user.getLoginTime()) %>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</body>
</html>
