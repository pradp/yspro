<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
    <title>维护用户</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
	<script type="text/javascript">
	detailPageStyle();
	$(document).ready(function(){
		
		//var url = "<s:property value="basePath"/>/suggest?aim=mydepart&departid=<s:property value="departID"/>";
		
		//getSuggest("departname","departid",url);
	});
	function submitForm(){
		validate_required_fields = [
			{fieldId:"userLoginId", message:"登录帐号不能为空！", mustMatch: true}, 
			{fieldId:"userPwd", message:"登录密码不能为空！", mustMatch: true}, 
			{fieldId:"userName", message:"用户名称不能为空！", mustMatch: true}, 
			{fieldId:"departid", message:"所属部门不能为空！", mustMatch: true}
		];
		validate_length_range_fields = [
			{fieldId:"userLoginId", minLen:1, maxLen:30, message:"用户登录账号长度在1-30个字节之间！", ignoreIfEmpty: true}, 
			{fieldId:"userPwd", minLen:1, maxLen:30, message:"登录密码长度在1-30个字节之间！", ignoreIfEmpty: true}, 
			{fieldId:"userName", minLen:1, maxLen:90, message:"用户显示名称长度在1-90个字节之间(30汉字以内)！", ignoreIfEmpty: true}
		];
		if(isValidateForm()){
			var userLoginId = document.getElementById("userLoginId").value;
			if( isContainChinese(userLoginId) ){
				alert("用户登录账号不接受中文！");
				document.getElementById("userLoginId").focus();
				return false;
			}else{
				super_submitForm();
			}
		}
	}
	</script>
	
  </head>
  
  <body style="text-align:center;" topmargin="0" leftmargin="0">

<div class="framestyle" style="">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tsysUser.userid" />
  <s:hidden id="menues" name="menues" />

  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr class="fzline"> 
      <td width="3%" height="30">&nbsp;</td>
      <td align="left" width="46%" nowrap="nowrap">登录用户名：
      <s:if test="tsysUser==null || #pleaseChange==true">
      <s:property value='%{UserLoginId.split("-")[0]}'/>-<s:textfield id="userLoginId" name="tsysUser.userLoginId" maxlength="30" size="13"/> <label style="color:red">*</label>
      </s:if>
      <s:else>
      <s:textfield value="%{tsysUser.userLoginId}" disabled="true" maxlength="50" size="23"/> 
      <s:hidden id="userLoginId" name="tsysUser.userLoginId" />
      </s:else>
      </td>
      <td align="left" width="46%" nowrap="nowrap">登录密码：<INPUT type="password" value="<s:property value="tsysUser.userPwd"/>" id="userPwd" name="tsysUser.userPwd" maxlength="30" size="15"/> <label style="color:red">*</label></td>
	<td align="left"></td>
    </tr>
    <tr class="fzline"> 
      <td height="30">&nbsp;</td>
      <td align="left" nowrap="nowrap">显示用户名称：<s:textfield id="userName" name="tsysUser.userName" maxlength="50" size="22"/> <label style="color:red">*</label></td>
      <td align="left" nowrap="nowrap">所属部门：
      <s:if test="tsysUser==null || #pleaseChange==true">
      <s:select list="getMyDeparts()" headerKey="" headerValue="------------请选择-----------" listKey="id" listValue="caption" id="departid" name="tsysUser.depart.departid"></s:select>
      </s:if>
      <s:else>
      <s:select list="getMyDeparts()" listKey="id" listValue="caption" value="%{tsysUser.depart.departid}" disabled="true"></s:select>
      <s:hidden id="departid" name="tsysUser.depart.departid" />
      </s:else>
       <label style="color:red">*</label></td>
	<td>&nbsp;</td>
    </tr>
    <tr> 
      <td height="30">&nbsp;</td>
      <td align="left" nowrap="nowrap">
      账号状态：
      <s:select id="userState" name="tsysUser.state" value="%{tsysUser==null?'2':tsysUser.state}" list="#{'2':'可用','0':'禁用'}" listKey="key" listValue="value" /> 
      <label style="color:red">*</label></td>
      <td align="left" nowrap="nowrap"></td>
	<td>&nbsp;</td>
    </tr>
  </table>
 
  <table width="30%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle"> 
	  <td colspan="20">&nbsp;</td>
	    <td height="30" >
	    
	    	<ul class="btn_gn">
    			<li><a href="#" title="保存" onClick="submitForm()"><span>保存</span></a></li>
	    		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	    	</ul>
	    </td>
	  </tr>
  </table>
  
</s:form>

</div>

<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

  </body>
</html>
