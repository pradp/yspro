<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
<script type="text/javascript">
function setHeight(){
	var he=document.body.clientHeight;
	document.getElementById("menuFrame").style.height=he;
	document.getElementById("menuContentFrame").style.height=he;
}
window.onload=setHeight;
</script>
  </head>
  
  <body topmargin="0" leftmargin="0" rightmargin="0">
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
    	<tr>
    		<td width="29%">
    			<iframe id="menuFrame" name="menuFrame" frameborder="0" width="100%" height="500" src="idMenu-list.c"></iframe>
    		</td>
    		<td width="1%" bgcolor="#CCCCCC"></td>
    		<td width="70%" align="right" height="100%">
    			<iframe id="menuContentFrame" name="menuContentFrame" frameborder="0" width="100%" height="500" marginwidth="0" scrolling="no"></iframe>
    		</td>
    	</tr>
    </table>
  </body>
</html>
