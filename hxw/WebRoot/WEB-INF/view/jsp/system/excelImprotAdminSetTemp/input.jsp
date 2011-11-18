<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<%@include file="../../common/Include_input_head.jsp" %>
    <title>模板项增加</title>
    
	<script type="text/javascript">
	$(document).ready(function(){
		detailPageStyle();
	});
	validate_required_fields = [
			{fieldId:"tempName", message:"服务名称不能为空！", mustMatch: true}			
		];
	validate_length_range_fields = [
			{fieldId:"serviceName", minLen:1, maxLen:50, message:"服务名称长度在1-50个字节之间！", ignoreIfEmpty: true}		
		];
	function submitForm(){	
		if(isValidateForm())
			super_doSave(true);
	}
	
	</script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/resources/css/webface.css">
  	<base target="_self">
  </head>
  
<body style="text-align:center;">
  <div class="box1" >
	  <s:form name="theform" method="post" theme="simple" >
		<s:hidden name="wid" value="%{#request.wid}"/>
		<s:hidden name="servicestate" value="%{#request.servicestate}"/>
	 	<fieldset> 
		　 <legend>新增模板项</legend>
		  <table width="100%" border="0" align="center">
		  	<tr>
		  		<td style="text-align: right">模板项名称：</td>
		  		<td colspan="3">
		  			<s:textfield id="tempName" name="tempName" maxlength="150" size="50"/>
		  		 	 <label style="color:red">*</label>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td style="width:10%;text-align: right">模板项映射表：</td>
		  		<td style="width:15%">
		  			<s:select id="tableName" name="tableName" list="DBTables" value="%{#request.tableName}"
		  				 cssClass="default" autoWidth="true" cssStyle="100px"/>
		  		 	 <label style="color:red">*</label>
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
				<input type="button" id="ysSaveButton" value=" 保 存 " onclick="submitForm()"/>
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
</body>
</html>
