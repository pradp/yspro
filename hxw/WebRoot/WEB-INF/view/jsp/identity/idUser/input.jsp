<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
    	<title>维护用户</title>

	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.bgiframe.min.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.ajaxQueue.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/thickbox-compressed.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.css"/>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/lib/thickbox.css"/>
	
	<script type="text/javascript">
	detailPageStyle();
	$(document).ready(function(){
		$("#userPwd").val($("#userPwd_hide").val());//这里重新设置一下，因为UUR界面会把password清空。
		//alert(document.getElementById("userPwd").value);
		var departid = '<s:property value="getDepartid()"/>';
		var url = "<s:property value="basePath"/>/suggest?aim=mydepart&departid="+departid;
		getSuggest("departname","departid",url);
		
		changeRightCtrl();
	});
	
	var menues_init = '<s:property value="menues"/>';

	function doSave(){

	    var userLoginId = $("#userLoginId").val();
	    var userPwd = $("#userPwd").val();

	    if( userLoginId=="" ){
	        alert("用户登录账号不允许为空！");
	        document.getElementById("userLoginId").focus();
	        return false;
	    }
	    if ( isContainSpecialChar(userLoginId) ) {
	        alert("用户登录账号不允许包含特殊字符！");
	        document.getElementById("userLoginId").focus();
	        return false;
	    }
		if (isContainChinese(userLoginId)) {
	        alert("用户登录账号不接受中文！");
	        document.getElementById("userLoginId").focus();
	        return false;
	    }
	    if( getLength(userLoginId)>50 ){
			alert("用户登录账号长度不能超过50！");
			document.getElementById("userLoginId").focus();
			return false;
		}
	    if( userPwd=="" ){
	        alert("用户登录密码不允许为空！");
	        document.getElementById("userPwd").focus();
	        return false;
	    }
	    if ( isContainSpecialChar(userPwd) ) {
	        alert("用户登录密码不允许包含特殊字符！");
	        document.getElementById("userPwd").focus();
	        return false;
	    }
		if (isContainChinese(userPwd)) {
		    alert("验证码不接受中文！");
		    document.getElementById("userPwd").focus();
		    return false;
		}
		if( getLength(userPwd)>50 ){
			alert("用户登录密码长度不能超过50！");
			document.getElementById("userPwd").focus();
			return false;
		}
		//var menues = window.frames["menuFrame"].document.getElementById("nodeid").value;
		//if(menues!=="" && menues !== menues_init){
			//document.getElementById("menues").value = menues; 
		//}
		return super_doSave();
		
	}

	function changeRightCtrl(){
		/*
		var userState = $("#userState").val();
		if(userState=="1"){
			$("#userRightCtrl_group").show();
			$("#userRightCtrl_menu").show();
		}else if(userState=="2"){
			$("#userRightCtrl_group").show();
			$("#userRightCtrl_menu").hide();
		}else if(userState=="3"){
			$("#userRightCtrl_group").hide();
			$("#userRightCtrl_menu").show();
		}else{
			//$("#userRightCtrl_group").hide();
			//$("#userRightCtrl_menu").hide();
		}
		*/
	}
	</script>
  </head>
  
  <body style="text-align:center;">

<div class="box1" panelWidth="100%" >
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tsysUser.userid" />
  <s:hidden id="userPwd_hide" value="%{tsysUser.userpwd}" />
  <s:hidden id="departid" name="tsysUser.depart.departid" />
  <s:hidden id="menues" name="menues" />

  <table width="100%" border="0" align="center">
    <tr> 
      <td width="3%">&nbsp;</td>
      <td align="center" width="28%" nowrap="nowrap">登录帐号：<s:textfield id="userLoginId" name="tsysUser.userloginid" maxlength="50" size="15"/> <label style="color:red">*</label></td>
      <td align="left" width="30%" nowrap="nowrap">登录密码：<input type="password" value="<s:property value="tsysUser.userpwd"/>" id="userPwd" name="tsysUser.userpwd" maxlength="30" size="15" /> <label style="color:red">*</label></td>
	<td align="left">用户状态：<s:select id="userState" name="tsysUser.state" value="%{tsysUser==null?'2':tsysUser.state}" list="#{'2':'可用','0':'禁用'}" listKey="key" listValue="value" onchange="changeRightCtrl()"/>
	</td>
      <td width="3%">&nbsp;</td>
    </tr>
  </table>
  <table width="96%" border="0" align="center">
    <tr>
    	<td height="1" style="background-color: silver"></td>
    </tr>
  </table>
  
  <table width="100%" border="0" align="center">
    <tr> 
      <td width="3%">&nbsp;</td>
      <td align="center" width="28%" nowrap="nowrap">用户名称：<s:textfield id="userName" name="tsysUser.username" maxlength="50" size="30"/> <label style="color:red">*</label></td>
      <td align="left" width="30%" nowrap="nowrap">所属部门：<s:textfield id="departname" name="tsysUser.depart.departname" maxlength="25" size="30" /> <label style="color:red">*</label></td>
      <td align="left" nowrap="nowrap">身份类型：<s:select id="usertype" name="tsysUser.usertype"  list="#{'':'无特殊身份','1':'专家'}" listKey="key" listValue="value"/></td>
	<td>&nbsp;</td>
    </tr>
  </table>

  <table width="96%" border="0" align="center">
    <tr>
    	<td height="1" style="background-color: silver"></td>
    </tr>
  </table>
  
  <table id="userRightCtrl_group" width="100%" border="0" align="center">
    <tr> 
      <td align="right">所属组：</td>
      <td width="80%" align="left"><s:checkboxlist name="groups" value="%{groups}" list="allGroups" listKey="groupid" listValue="groupname"/><label style="color:red">*</label></td>
      <td width="11%"></td>
    </tr>
  </table>
  <table width="96%" border="0" align="center">
    <tr>
    	<td height="1" style="background-color: silver"></td>
    </tr>
  </table>
  
</s:form>
</div>
<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
					<input type="button" id="ysSaveButton" value=" 保 存 " onclick="doSave()"/>
					<input type="button" value=" 关 闭 " onclick="parent.closeEntityWindow()"/>
					<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
						<span id="SystemErrorMessage" style="top: 20px">
							<s:actionerror cssStyle="color:red"/>
							<s:actionmessage cssStyle="color:blue"/>
							<s:fielderror/>
						</span>
					</s:if>
				</td>
			</tr>
		</table>
	</div> 
</div>

  </body>
</html>
