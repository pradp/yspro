<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'execute.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<script type="text/javascript">
function setHeight(){
	var he=document.body.clientHeight;
	document.getElementById("menuFrame").style.height=he;
	document.getElementById("menuContentFrame").style.height=he;
}
window.onload=setHeight;
</script>
  </head>
  
  <body topmargin="0" leftmargin="0">
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
    	<tr>
    		<td width="29%">
    			<iframe id="menuFrame" name="menuFrame" frameborder="0" width="100%" height="500" src="specialty-list.c?gxbm=${departID }"></iframe>
    		</td>
    		<td width="1%" bgcolor="#CCCCCC"></td>
    		<td width="70%" align="right">
    			<iframe id="menuContentFrame" name="menuContentFrame" frameborder="0" width="100%" height="500" marginwidth="0" scrolling="no"></iframe>
    		</td>
    	</tr>
    </table>
  </body>
</html>
