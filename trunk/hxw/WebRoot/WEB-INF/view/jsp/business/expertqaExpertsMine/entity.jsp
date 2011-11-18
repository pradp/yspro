<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
		<link rel="stylesheet" type="text/css" href="../clientui/js/form/CLEditor/jquery.cleditor.css" />
		<script type="text/javascript" src="../clientui/js/form/CLEditor/jquery.cleditor.js"></script>
    	<title>专家信息</title>

	<script type="text/javascript">
	detailPageStyle();
	var canSubmit=false;

	validate_required_fields = [ 	
			{fieldId:"name", message:"专家姓名不能为空！", mustMatch: true},		
			{fieldId:"sortId", message:"专家类型为空！", mustMatch: true},
			{fieldId:"email", message:"电子邮箱不能为空！", mustMatch: true}
		];
    validate_length_range_fields = [	          
	        {fieldId:"yzbm", minLen:6, maxLen:6, message:"邮编不正确！", ignoreIfEmpty: true}
	     ];
	                	
    validate_type_fields=[
            {fieldId:"name",message:"专家姓名请输入中文！",typeRule:{requiredType:"chinese"}},
            {fieldId:"email",message:"请输入有效的邮件地址！",typeRule:{requiredType:"email"}},
            {fieldId:"telnum",message:"请输入有效的手机号码！",typeRule:{requiredType:"mobile"}},
            {fieldId:"mobilenum",message:"请输入有效的电话号码,如:025-86983857！",typeRule:{requiredType:"phone"}},
            {fieldId:"fax",message:"请输入有效的传真号码！",typeRule:{requiredType:"phone"}},
            {fieldId:"yzbm",message:"请输入有效的邮政编码号码！",typeRule:{requiredType:"number"}}
        ];
	
	function doSave(){	
		super_doSave(false);
	}	
	function dosavenew(){
		document.getElementById("sfxz").value = "1";
		doSave(false);
	}
	function dosaveclose(){
		doSave(false);
		parent.closeEntityWindow();
	}

	</script>
	
	
  </head>
  
  <body style="text-align:center;">

<div class="box1" >
  <s:form name="theform" method="post" theme="simple" >
    <s:hidden name="texpertqaExperts.wid" />
    <s:hidden name="texpertqaExperts.username" />
    <s:hidden name="sfxz" id="sfxz" />
  <fieldset> 
　 <legend>专家基本信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" nowrap="nowrap">登录账户：</td>
      <td align="left"><s:property value="texpertqaExperts.username"/> </td>
      <td align="right"></td>	
      <td align="left"></td>
	</tr>
    <tr> 
      <td align="right" nowrap="nowrap">专家姓名：</td>
      <td align="left"><s:textfield id="name" name="texpertqaExperts.name" maxlength="10" size="20" cssClass="validate[required,custom[chinese],length[0,10]]"/> <label style="color:red">*</label></td>
      <td align="right">专家类型：</td>	
      <td align="left"><s:select id="sortId" name="texpertqaExperts.sortId" list="getSysCode('sort_id')"  headerKey="" headerValue="--请选择--" listKey="id" listValue="caption" /> <label style="color:red">*</label></td>
	</tr>
    <tr> 
      <td align="right" nowrap="nowrap">职务：</td>
      <td align="left"><s:textfield id="position" name="texpertqaExperts.position" maxlength="15" size="20" cssClass="validate[length[0,15]]"/>&nbsp;&nbsp;</td>
      <td align="right">工作单位：</td>
	  <td align="left"><s:textfield id="zdmc" name="texpertqaExperts.unit" maxlength="50" size="40" cssClass="validate[length[0,50]]"/></td>   
	</tr>
    <tr> 
      <td align="right" nowrap="nowrap" >电子邮件：</td>
      <td align="left"><s:textfield id="email" name="texpertqaExperts.email"  maxlength="50" size="20" cssClass=" validate[required,custom[email]]" /> <label style="color:red">*</label><span id="spanEmail" ></span></td>
      <td align="right" >移动电话：</td>
      <td align="left"><s:textfield id="telnum" name="texpertqaExperts.telnum" maxlength="20" size="20" cssClass="validate[custom[mobilephone],length[0,20]]"/> </td>
	</tr>
    <tr> 
      <td align="right" nowrap="nowrap">固定电话：</td>
      <td align="left"><s:textfield id="mobilenum" name="texpertqaExperts.mobilenum" maxlength="20" size="20" cssClass="validate[length[0,20],custom[telephone]]" /> </td>
	  <td align="right">传 真：</td>
	  <td align="left"><s:textfield id="fax" name="texpertqaExperts.fax" maxlength="20" size="20" cssClass="validate[length[0,20],custom[telephone]]"/></td>
   
   </tr>
   <tr>       
	  <td align="right" nowrap="nowrap">通讯地址：</td>
	  <td align="left"><s:textfield id="lxdz" name="texpertqaExperts.lxdz" maxlength="50" size="40" cssClass="validate[length[0,50]]"/></td>
	  <td align="right">邮 编：</td>
	  <td align="left"><s:textfield id="yzbm" name="texpertqaExperts.yzbm" maxlength="6" size="20" cssClass="validate[custom[onlyNumber],length[6,6]]"/></td>
   </tr>
   <tr>
   		<td colspan="4">
   			<table width="100%">
		   		<tr>
			   		<td align="right" nowrap="nowrap" width="100">简介：</td>
					<td align="left"><textarea mode="full" editorWidth="600" editorHeight="150" class="rich" name="texpertqaExperts.memo" id="memo"><s:property value="texpertqaExperts.memo"/></textarea></td>
					<td colspan="2"></td>
		   		</tr>
   			</table>
   		</td>
		
  </tr>
  </table>
 </fieldset>
</s:form>
</div>
<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
					<input type="button" id="ysSaveButton" value=" 保 存 " onclick="doSave()"/>					
					<input type="button" value=" 返 回 " onclick="history.back()"/>
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
  </body>
</html>
