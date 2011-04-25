<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
    <title>维护字典</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
	<script type="text/javascript">
	detailPageStyle();

	validate_required_fields = [ 
			{fieldId:"zdlb", message:"字典类别编码不能为空！", mustMatch: true}, 
			{fieldId:"lbmc", message:"标准类别名称不能为空！", mustMatch: true}
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

<div class="framestyle" style="width:98%;padding: 0pt 10pt 10pt 10pt;">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="wid" value="%{#parameters.wid[0]}"/>

 <fieldset> 
　 <legend>字典类别信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td width="3%">&nbsp;</td>
      <td align="center" width="30%" nowrap="nowrap">字典类别编码：
      <s:textfield name="tsysCodeSort.zdlb"  id="zdlb" maxlength="50" size="20"/> <label style="color:red">*</label></td>
	<td align="center">标准类别名称：
	<s:textfield name="tsysCodeSort.lbmc" id="lbmc" maxlength="50" size="20"/> <label style="color:red">*</label>
  </table>
 </fieldset>

  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle"> 
	  <td colspan="30">&nbsp;</td>
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
