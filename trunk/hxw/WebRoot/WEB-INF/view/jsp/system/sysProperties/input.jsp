<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  	<title>添加参数信息</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
	<script type="text/javascript" src="../clientui/js/jquery-1.4.js"></script>
	<script type="text/javascript" src="../clientui/js/framework-source.js"></script>
		<link href="../clientui/css/framework/reset.css" rel="stylesheet" type="text/css"/>
		<link href="../clientui/css/framework/basic.css" rel="stylesheet" type="text/css"/>
		<link href="../clientui/css/framework/position.css" rel="stylesheet" type="text/css"/>
		<link href="../clientui/css/framework/form.css" rel="stylesheet" type="text/css"/>
		<link href="../clientui/css/framework/icon.css" rel="stylesheet" type="text/css"/>
		<link href="../clientui/css/framework/code.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin"/>
<!--框架必需end-->
<!--表单验证脚本start-->
<script src="../clientui/js/form/validationEngine-cn.js" type="text/javascript"></script>
<script src="../clientui/js/form/validationEngine.js" type="text/javascript"></script>
<!--表单验证脚本end-->

	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>

	<script type="text/javascript">
	detailPageStyle();
	
	validate_required_fields = [
			{fieldId:"csfl", message:"参数名称不能为空！", mustMatch: true}, 
			{fieldId:"cslx", message:"参数类型不能为空！", mustMatch: true},
			{fieldId:"csmc", message:"参数不能为空！", mustMatch: true},
			{fieldId:"cs", message:"参数值不能为空！", mustMatch: true}
		];
	function doSave(){
		if(isValidateForm()){
			super_doSave();
		}
	}
	</script>
  </head>
  
  <body style="text-align:center;">

  <s:form name="theform" method="post" theme="simple">
  <s:hidden name="tsysPropertity.wid"/>

	<div class="box1" panelWidth="100%">
	<fieldset> 
		<legend>参数信息</legend> 
		<table class="tableStyle" transMode="true" footer="normal">
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">参数名称：</td>
      <td width="40%" align="left"><s:textfield name="tsysPropertity.csfl" id="csfl" cssClass="validate[required,custom[chinese],length[1,50]]"/> <label style="color:red">*</label></td>
       <td align="right" width="10%" nowrap="nowrap">参数类型：</td>
      <td width="40%" align="left"><s:textfield name="tsysPropertity.cslx" id="cslx" maxlength="30" size="31" cssClass="validate[required,custom[noSpecialCaracters],length[1,30]]"/> <label style="color:red">*</label></td>
     </tr>    
    <tr>      
      <td align="right" nowrap="nowrap">参数：</td>
      <td align="left"><s:textfield name="tsysPropertity.csmc" id="csmc" maxlength="50" size="31"/> <label style="color:red">*</label></td>
      <td align="right" nowrap="nowrap">参数值：</td>
      <td align="left"><s:textfield name="tsysPropertity.cs" id="cs" maxlength="300" size="31"/> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">参数说明：</td>
      <td colspan="3" align="left"><s:textfield name="tsysPropertity.cssm" id="cssm" maxlength="20" cssStyle="width:220px"/> <label style="color:red"></label></td>
   </tr>  
		</table>
	</fieldset> 
	
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

</s:form>
  </body>
</html>
