<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
    	<title>维护字典类别</title>

	<script type="text/javascript">
	detailPageStyle();

	validate_required_fields = [ 
			{fieldId:"zdlb", message:"字典类别编码不能为空！", mustMatch: true}, 
			{fieldId:"lbmc", message:"标准类别名称不能为空！", mustMatch: true}
		];
	function doSave(){
		if(isValidateForm()){
			super_doSave();
		}
	}
	</script>
	
	
  </head>
  
  <body style="text-align:center;">

<div class="box1">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="wid" value="%{#parameters.wid[0]}"/>

 <fieldset> 
　 <legend>字典类别信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td width="3%">&nbsp;</td>
      <td align="center" width="30%" nowrap="nowrap">字典类别编码：
      <s:textfield name="tsysCodesort.zdlb"  id="zdlb" maxlength="50" size="20"/> <label style="color:red">*</label></td>
	<td align="center">标准类别名称：
	<s:textfield name="tsysCodesort.lbmc" id="lbmc" maxlength="50" size="20"/> <label style="color:red">*</label></td>
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
