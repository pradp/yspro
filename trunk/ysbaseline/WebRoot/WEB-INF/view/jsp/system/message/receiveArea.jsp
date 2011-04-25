<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="com.yszoe.sys.service.impl.AreaTreeSupport"%>
<%     
java.util.List list = (java.util.List)request.getAttribute("list");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>tree</title>

	<link rel="stylesheet" href="/resources/css/webface.css" type="text/css">
	
	<style type="text/css">
	body{
		background-color:#eeeee2;
	}
	th{
		font-size: 12px;
	}
	td{
		font-size: 12px;
	}
	</style>
  </head>
  
  <body style="padding-top:3%;padding-left:7%">
	<table border="1" cellspacing="0" cellpadding="0"   style="border-collapse: collapse" bordercolor="#FFFFFF" align="center">
		<thead>
  			<tr>
  			    <th height="20px" width="30%" >接收人</th>
    	        <s:if test="#jslx==2">
    	        <th width="30%" >接收人身份证号</th>
    	        </s:if>
  			    <%if(("1").equals(request.getParameter("xxzt"))){ %>
    	        <th width="40%" >阅读时间</th>
    	        <%} %>
    	    </tr>
    	 </thead>
    	 <tbody>
		    <%if(list!=null&&list.size()>0){ 
		    	for(int i=0;i<list.size();i++){
		    	Object[] o = (Object[])(list.get(i));
		    %>
		    <tr>
		    	<td align="center">
		    		<font face="宋体"><%=String.valueOf(o[0]) %></font>
		    	</td>
    	        <s:if test="#jslx==2">
		    	<td align="center">
		    		<font face="宋体"><%=String.valueOf(o[2]) %></font>
		    	</td>
    	        </s:if>
  			    <%if(("1").equals(request.getParameter("xxzt"))){ %>
		    	<td align="center">
		    		<%if(String.valueOf(o[1]).length()>19){ %>
		    			<%=String.valueOf(o[1]).substring(0,19) %>
		    		<%}else{ %>
		    			<%=String.valueOf(o[1]) %>
		    		<%} %>
		    	</td>
		    	<%} %>
		    </tr>
		    <%}} %>
    </tbody>
    </table>
  </body>
</html>
