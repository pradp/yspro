<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>模板项增加</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/zxdk.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
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
			super_submitForm();
		parent.closeInputWindow();
		parent.location.reload();
						
	}
	
	</script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/resources/css/webface.css">
  	<base target="_self">
  </head>
  
<body style="text-align:center;">
<!-- header start -->
<s:if test="actionErrors.size()> 0 || actionMessages.size()>0 || fieldErrors.size()>0">
<div id="SystemErrorMessage">
<s:actionerror />
<s:actionmessage />
<s:fielderror />
</div>
</s:if>
<!-- header end -->

<div class="framestyle" style="width:90%;padding: 0pt 10pt 10pt 10pt;">
<s:form name="theform" method="post" theme="simple" >
<s:hidden name="wid" value="%{#request.wid}"/>
<s:hidden name="servicestate" value="%{#request.servicestate}"/>
 <fieldset> 
　 <legend>新增模板项</legend>
  <table width="100%" border="0" align="center">
  	<tr>
  		<td style="text-align: right">模板项名称：</td>
  		<td colspan="3"><s:textfield id="tempName" name="tempName" maxlength="150" size="50"/><label style="color:red">*</label></td>
  	</tr>
  	<tr>
  		<td style="width:10%;text-align: right">模板项映射表：</td><td style="width:15%"><s:select id="tableName" name="tableName" list="DBTables" value="%{#request.tableName}"/><label style="color:red">*</label></td>  		
  	</tr>
  </table>
 </fieldset>

  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle">	   
	    <td height="30" colspan="7">
	    	    
<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="26%"><tr><td height="30px" width="440px">
	<ul class="btn_gn">										
		<li>
			<a href="#" title="确定" onClick="submitForm();" id="sendMsgButton"><span>确定</span> </a>
		</li>
		<li>
			<a href="#" title="关闭" onClick="parent.closeInputWindow();" id="sendMsgButton"><span>关闭</span> </a>
		</li>																															
	</ul>
</td></tr></table>

			</td>
	  </tr>
  </table>
</s:form>
</div>
</body>
</html>
