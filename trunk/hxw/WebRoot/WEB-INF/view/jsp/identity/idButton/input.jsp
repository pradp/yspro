<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
  		<title>按钮信息</title>
	
	<script type="text/javascript">
	detailPageStyle();
	var buttoniconUri = [['新增','icon_add'],['修改','icon_update'],['删除','icon_delete'],
					     ['审核','icon_ok'],['退回','icon_back'],['导出','icon_remove']];
	validate_required_fields = [
			{fieldId:"buttonname", message:"按钮名称不能为空！", mustMatch: true}, 
			{fieldId:"buttonevent", message:"按钮事件不能为空！", mustMatch: true}, 
			{fieldId:"ordernum", message:"排序值不能为空！", mustMatch: true}
		];
	function doSave(){
		if(isValidateForm()){
			super_doSave();
		}
	}
	function changeButtonicon(){
		var obj =  document.getElementById('buttonevent');
		var index = obj.selectedIndex;
		var objv = obj.options[index].text;
		for(var i=0;i<buttoniconUri.length;i++){
			if(objv == buttoniconUri[i][0]){
				document.getElementById('buttonicon').value = buttoniconUri[i][1];
			}
		}
	}
	</script>
  </head>
  
  <body style="text-align:center;">

  <s:form name="theform" method="post" theme="simple">
  <s:hidden name="tsysButton.buttonid"/>
  <s:hidden name="tsysButton.menuid"/>
<div id="scrollContent" style="overflow: auto">
	<div class="box1" panelWidth="800">
	<fieldset> 
		<legend>按钮信息</legend> 
		<table class="tableStyle" transMode="true" footer="normal">
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">按钮名称：</td>
      <td width="40%" align="left"><s:textfield name="tsysButton.buttonname" id="buttonname" cssClass="validate[required,length[1,20]]"/> <label style="color:red">*</label></td>
       <td align="right" width="10%" nowrap="nowrap">按钮事件：</td>
      <td width="40%" align="left"><s:select name="tsysButton.buttonevent" id="buttonevent" list="getSysCode('ansj')" listKey="id" listValue="caption" onchange="changeButtonicon()"/> <label style="color:red">*</label></td>
     </tr>    
    <tr>      
      <td align="right" nowrap="nowrap">按钮图标：</td>
      <td align="left"><s:textfield name="tsysButton.buttonicon" id="buttonicon" maxlength="50" size="31" cssClass="validate[length[0,50]]"/> </td>
      <td align="right" nowrap="nowrap">企业管理员可见：</td>
      <td align="left"><s:radio cssClass="validate[required] radio" name="tsysButton.share2enterprise" list="#{1:'启用', 0:'禁用'}" listKey="key" listValue="value"/>
       <label style="color:red">*</label></td>
    </tr>
    <tr>      
      <td align="right" nowrap="nowrap">排序值：</td>
      <td align="left">
      <s:textfield id="ordernum" title="说明：同一层次中数值大的往前排" name="tsysButton.ordernum" maxlength="6" onkeypress="NumberText(event)" cssClass="validate[required,length[1,6]]"/> <label style="color:red">*</label>
      </td>
      <td align="right" nowrap="nowrap">状态：</td>
      <td align="left"><s:radio cssClass="validate[required] radio" name="tsysButton.state" list="#{1:'启用', 0:'禁用'}" listKey="key" listValue="value"/> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">描述：</td>
      <td colspan="3" align="left">
      	<span class="float_left">
			<s:textarea name="tsysButton.memo" id="memo" cssStyle="width:400px;" cssClass="validate[length[0,50]]"></s:textarea>
		</span>
		<span class="img_light" style="height:80px;" title="限制在50字以内"></span> </td>
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
</div>

</s:form>
  </body>
</html>
