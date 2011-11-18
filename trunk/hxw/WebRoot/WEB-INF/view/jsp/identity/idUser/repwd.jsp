<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>密码修改</title>
	<%@include file="../../common/Include_input_head.jsp" %>
	
	<script language="JavaScript" type="text/JavaScript">
	
		$(document).ready(function(){
			detailPageStyle();
		});
		function dataCheck(){
		    if (document.getElementById("userPwdOld").value==""){
			   alert("请输入原密码！");
			   document.getElementById("userPwdOld").focus();
			   return false;
		    }
		    if (document.getElementById("userPwd").value==""){
			   alert("请输入新密码！");
			   document.getElementById("userPwd").focus();
			   return false;
		    }
		 	if (document.getElementById("dlmmnew2").value==""){
			   alert("请再输入一次新密码！");
			   document.getElementById("dlmmnew2").focus();
			   return false;
		    }
			if (document.getElementById("userPwd").value!=document.getElementById("dlmmnew2").value){
			   alert("两次输入的新密码不一致，请检查！");
			   document.getElementById("dlmmnew2").focus();
			   return false;
		    }
			 document.forms[0].submit();
		}
		
	</script>
</head>
<body>
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px" align="center">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>
<form name="form1" action="../id/idUser-modifyPassword.action" method="post">
<div class="box1" panelWidth="99%">

 <fieldset> 
　 <legend>密码修改</legend>
  <table class="tableStyle" transMode="true"  footer="normal">
           <tr>
            <td height="35" align="right" width="30%"><br></br>&nbsp;原密码：<strong>&nbsp; 
              </strong></td>
            <td align="left" width="70%"><br></br><s:password id="userPwdOld" name="tsysUser.username" tabindex="2" maxlength="50" theme="simple" size="15"/><font color="#FF0000">*</font>
            	<font color="#666666">输入您正在使用的密码，用于确认您的身份！</font>
            </td>
          </tr>
           <tr>
            <td height="35" align="right" width="30%">&nbsp;新密码：<strong>&nbsp; 
              </strong></td>
            <td align="left" width="70%"><s:password id="userPwd" name="tsysUser.userpwd" tabindex="2" maxlength="50" theme="simple" size="15"/><font color="#FF0000">*</font> 
            	<font color="#666666">输入新密码！</font>
            </td>
          </tr>
		  <tr> 
            <td height="35" align="right" width="30%">&nbsp;确认新密码：<strong>&nbsp; 
              </strong></td>
            <td align="left" width="70%"><input name="dlmmnew2" type="password" id="dlmmnew2" size="15" maxlength="50"><font color="#FF0000">*</font>
            	<font color="#666666">请再输入一次上面写的新密码！</font>
            </td>
          </tr>
  </table>
  </fieldset>
	<div class="padding_top10">
	  	<table  class="tableStyle" transMode="true">
	          <tr> 
	            <td height="50" colspan="4" align="left" width="80%"> 
				<input type="button" id="datecheckButton" value=" 提交 " onclick="dataCheck()"/>
				<input type="button" id="doresetButton" value=" 清除" onclick="doreset()"/>
	          </td>
	          <td width="20%">&nbsp;</td>
	          </tr>
		</table>
	</div>
</div>
</form>
</body>

</html>
