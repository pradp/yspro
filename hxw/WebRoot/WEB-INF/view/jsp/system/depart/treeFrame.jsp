<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	
<script type="text/javascript">
function setHeight(){
	var he=document.body.clientHeight;
	document.getElementById("menuFrame").style.height=he;
	document.getElementById("menuContentFrame").style.height=he;
	
	var type = '<s:property value="%{#parameters.type[0]}"/>';
	var src = document.getElementById("menuFrame").src;
	document.getElementById("menuFrame").src = src + "&type="+type;
}
window.onload=setHeight;
</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
<body topmargin="0" leftmargin="0"> 
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
    	<tr>
    		<td width="23%">
    			<iframe id="menuFrame" name="menuFrame" frameborder="0" width="100%" height="500" src="depart-departTree.action?isEditSelf=true"></iframe>
    		</td>
    		<td width="77%" align="right">
    			<iframe id="menuContentFrame" name="menuContentFrame" frameborder="0" width="100%" height="500" marginwidth="0" scrolling="no"></iframe>
    		</td>
    	</tr>
    </table>
  </body>
</html>

