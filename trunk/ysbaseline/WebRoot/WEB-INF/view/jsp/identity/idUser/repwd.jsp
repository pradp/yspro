<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
<base target="_self">
<title>密码修改</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
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
		
		
		function doreset(){
		document.getElementById("userPwdOld").value="";
		document.getElementById("userPwd").value="";
		document.getElementById("dlmmnew2").value="";
		
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
<form name="form1" action="repwd!modifyPassword.c" method="post">
<div align="center">

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="200" height="34" class="wintitle_left"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="40%">&nbsp;<b>&nbsp;&nbsp;密码修改</b></td>
            <td width="60%">&nbsp;</td>
          </tr>
        </table>
		</td>
        <td height="34" class="wintitle_right"><table width="72" border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>
		</td>
      </tr>
    </table>
	</td>
  </tr>
  <tr>
    <td>
    
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="winmain_left">
        
      
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="7" rowspan="2"></td>
            <td style="background-color:#fff;border:1px solid #d7d8d9">
            
<table align="center" border="0" cellpadding="0" cellspacing="0" >
           <tr>
            <td height="35" align="right" width="20%"><br></br>&nbsp;原密码：<strong>&nbsp; 
              </strong></td>
            <td valign="middle" width="20%"><br></br><s:password id="userPwdOld" name="tsysUser.userName" tabindex="2" maxlength="50" theme="simple" size="15"/><font color="#FF0000">*</font> </td>
            <td width="5%"></td>
            <td align="left" valign="middle" style="color:#666666"><br></br>输入您正在使用的密码，用于确认您的身份！</td>
          </tr>
           <tr>
            <td height="35" align="right" width="20%">&nbsp;新密码：<strong>&nbsp; 
              </strong></td>
            <td valign="middle" width="20%"><s:password id="userPwd" name="tsysUser.userPwd" tabindex="2" maxlength="50" theme="simple" size="15"/><font color="#FF0000">*</font> </td>
            <td width="5%"></td>
            <td align="left" valign="middle" style="color:#666666">输入新密码！</td>
          </tr>
		  <tr> 
            <td height="35" align="right">&nbsp;确认新密码：<strong>&nbsp; 
              </strong></td>
            <td valign="middle"><input name="dlmmnew2" type="password" id="dlmmnew2" size="15" maxlength="50"><font color="#FF0000">*</font> </td>
            <td></td>
            <td valign="middle" style="color:#666666">请再输入一次上面写的新密码！</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td height="50" colspan="3" align="left"> 
            
            	<ul class="btn_gn">
    			<li><a href="#" title="提交" onClick="dataCheck();" name="ok1" id="ok1"><span>提交</span></a></li>
	    		<li><a href="#" title="清除"  onclick="doreset();"><span>清除</span></a></li>
	    	</ul>
          </td>
          </tr>
          <tr>
          	<td height="165">&nbsp;</td>
          </tr>
</table>


	</td>
          </tr>
          <tr>
            <td height="35">


            </td>
          </tr>
        </table></td>
        <td width="7" class="winmain_right" style="width:7px"></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
</form>
</body>

</html>
