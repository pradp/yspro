<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

	<!--footer_begin-->
	<div class="footer" align="center">
		<img src="<%=request.getContextPath() %>/UI/webui/img/index_90.jpg" border="0" height="6" width="960" />
		版权所有     护心网   
		<%
		Calendar calendar=Calendar.getInstance();//不能用new方法。
		     int year=calendar.get(Calendar.YEAR); 
		     if( year != 2011){
		%> 
		©2011-<%=year %><br />
		<%
		     }else{
		%>
		©2011<br />
		<%	 
		     }
		%>
		电话：025-88888888&nbsp;&nbsp;&nbsp;　  地址：南京市白下区光华路1号       
		邮编 210107<br/><br/>
		
	</div>
	<!--footer_end-->
