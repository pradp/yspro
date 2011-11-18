<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
    	<title>维护字典</title>

	<script type="text/javascript">
	detailPageStyle();

	validate_required_fields = [ 
			{fieldId:"zdbm", message:"标准代码不能为空！", mustMatch: true}, 
			{fieldId:"zdmc", message:"标准名称不能为空！", mustMatch: true}
		];
	function doSave(){
			if(isValidateForm()){
				super_doSave();
			}
		}	
	function dosavenew(){
		document.getElementById("sfxz").value = "1";
		doSave();
	}
	function dosaveclose(){
		doSave();
		parent.closeEntityWindow();
	}
	</script>
	
	
  </head>
  
  <body style="text-align:center;">

<div class="box1" >
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tsysCode.wid" />
  <s:hidden name="sfxz" id="sfxz" />

 <fieldset> 
　 <legend>字典信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" nowrap="nowrap">字典值：</td>
      <td align="left"><s:textfield id="zdbm" name="tsysCode.zdbm" maxlength="50" size="20"/> <label style="color:red">*</label></td>
	  <td align="right">字典名称：</td>
	  <td align="left"><s:textfield id="zdmc" name="tsysCode.zdmc" maxlength="50" size="20"/> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">字典类别：</td>
      <td align="left"><s:select id="zdlb" name="tsysCode.zdlb" list="SysCodeSort" listKey="id" listValue="caption"/> </td>
	  <td align="right">状态：</td>
	  <td align="left"><s:select name="tsysCode.sfsy" list="#{'1':'启用','0':'禁用'}"/> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">注释：</td>
      <td align="left" colspan="3"><s:textfield id="zs" name="tsysCode.zs" maxlength="40" size="20" cssStyle="width:300px"/>&nbsp;&nbsp;</td>
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
					<input type="button" id="" value=" 保存并新增 " onclick="dosavenew()"/>
					<input type="button" id="" value=" 保存并关闭 " onclick="dosaveclose()"/>
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
