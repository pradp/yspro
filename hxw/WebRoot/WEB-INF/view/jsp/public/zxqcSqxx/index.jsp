<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	
%>
<script type="text/javascript">
alert("注册成功，等待管理员审核！");
window.location.href="<%=basePath%>/index.jsp"; 
</script>



