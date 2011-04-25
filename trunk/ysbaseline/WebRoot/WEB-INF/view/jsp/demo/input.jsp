<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>维护角色</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/zxdk.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function(){
		detailPageStyle();
	});
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
	function submitForm(){
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
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/resources/css/webface.css">
  	<base target="_self">
  </head>
  
  <body style="text-align:center;">
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

<div class="framestyle" style="width:98%;padding: 0pt 10pt 10pt 10pt;">
  <s:form name="theform" method="post" theme="simple" >
  
  <s:hidden name="tsysRole.wid" />
  <s:hidden id="menues" name="menues" />

 <fieldset> 
　 <legend>字典信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td width="18%"></td>
      <td width="30%"></td>
      <td width="4%"></td>
      <td width="18%"></td>
      <td width="30%"></td>
    </tr>
    <tr> 
      <td align="right">字典名称：</td>
      <td colspan="4" nowrap="nowrap">
      <s:textfield id="zdmc" name="tsysCode.zdmc" maxlength="150" size="40"/> <label style="color:red">*</label>
	</td>
    </tr>
    <tr> 
      <td colspan="5" height="10"></td>
    </tr>
    <tr> 
      <td align="right">字典值：</td>
      <td width="30%" colspan="4">
      	<s:textfield id="zdbm" name="tsysCode.zdbm" maxlength="100" size="40"/> <label style="color:red">*</label>
      </td>
    </tr>
    <tr> 
      <td colspan="5" height="10"></td>
    </tr>
    <tr style="display:none"> 
      <td >&nbsp;</td>
      <td align="center" nowrap="nowrap">上级编号：
      <s:textfield id="sjdm" name="tsysCode.sjdm" maxlength="20" size="30"/>&nbsp;&nbsp;
      </td>
	<td align="center">字典层次：
      <s:textfield id="zdcc" name="tsysCode.zdcc" maxlength="2" size="30"/>&nbsp;&nbsp;&nbsp;
	</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">类别：</td>
	<td>
      <s:select id="zdlb" name="tsysCode.zdlb" list="SysCodeSort" listKey="key" listValue="value"/> 
      <label style="color:red">*</label>
      </td>
      <td >&nbsp;</td>
	<td align="right">扩展类别：</td>
	<td>
	 <s:select id="kzzdlb" name="tsysCode.kzzdlb" list="SysCodeSort" headerKey="" headerValue="---请选择---" listKey="key" listValue="value"/> 
	</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="5" height="10"></td>
    </tr>
    <tr> 
      <td align="right">状态：</td>
      <td colspan="4" nowrap="nowrap">
	<s:select name="tsysCode.sfsy" list="#{'1':'启用','0':'禁用'}" listKey="key" listValue="value"/> 
	<label style="color:red">*</label>
	</td>
    </tr>
  </table>
 </fieldset>

  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle"> 
	    <td height="30" colspan="7">
	    <input type="button" value=" 保存 " onclick="submitForm()"/>
	    &nbsp;&nbsp;&nbsp;
	    &nbsp;&nbsp;&nbsp;
	    <input type="button" value=" 关闭 " onclick="window.close()"/></td>
	  </tr>
  </table>
</s:form>
</div>
  </body>
</html>
