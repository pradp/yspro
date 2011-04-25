<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
  	<title>添加参数信息</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript">
		detailPageStyle();
	////$(document).ready(function(){
		
	///	}
	///);
	validate_required_fields = [
			{fieldId:"csfl", message:"参数名称不能为空！", mustMatch: true}, 
			{fieldId:"cslx", message:"参数类型不能为空！", mustMatch: true},
			{fieldId:"csmc", message:"参数不能为空！", mustMatch: true},
			{fieldId:"cs", message:"参数值不能为空！", mustMatch: true}
		];
	function dosave(){
		if(isValidateForm()){
			submitForm();
		}
	}
	</script>
  </head>
  
  <body style="text-align:center;">
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

<div class="framestyle" style="width:100%;">
  <s:form name="theform" method="post" theme="simple" action="%{actionName}-save.c" >
 <fieldset> 
　 <legend>参数信息</legend>
  <table width="100%" border="0" align="center">

    <tr> 
      <td align="right" width="10%" nowrap="nowrap">参数名称：</td>
      <td width="40%"><s:textfield name="tsysPropertity.csfl" id="csfl" maxlength="50" size="31"/> <label style="color:red">*</label></td>
       <td align="right" width="10%" nowrap="nowrap">参数类型：</td>
      <td width="40%"><s:textfield name="tsysPropertity.cslx" id="cslx" maxlength="30" size="31"/> <label style="color:red">*</label></td>
     </tr>    
    <tr>      
      <td align="right" width="10%" nowrap="nowrap">参数：</td>
      <td width="40%"><s:textfield name="tsysPropertity.csmc" id="csmc" maxlength="50" size="31"/> <label style="color:red">*</label></td>
      <td align="right" width="10%" nowrap="nowrap">参数值：</td>
      <td width="40%"><s:textfield name="tsysPropertity.cs" id="cs" maxlength="300" size="31"/> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">参数说明：</td>
      <td width="40%"><s:textfield name="tsysPropertity.cssm" id="cssm" maxlength="30" size="31"/> <label style="color:red"></label></td>
   </tr>  
  </table>
  </fieldset>
  
  <table width="20%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
  <tr align="center" valign="middle"> 
    <td height="30" colspan="7">
    	<ul class="btn_gn">
    			<li><a href="#" title="保存" onClick="dosave()"><span>保存</span></a></li>
	    		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	    	</ul>
	    	</td>
  </tr>
  </table>
</s:form>
</div>
  </body>
</html>
