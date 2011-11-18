<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
    	<title>维护消息管理</title>

	<script type="text/javascript">
	detailPageStyle();
	function doSave(){
		super_doSave();
	}	
	var tem_valueObjid,tem_nameObjid;
	function selectMenu(valueObjid,nameObjid){
		tem_valueObjid = valueObjid;
		tem_nameObjid = nameObjid;
		var url = "<s:property value="basePath"/>/id/idMenu-list.action";
		openTreeDialog(url);
	}
	</script>
	
	
  </head>
  
  <body style="text-align:center;">

<div class="box1" >
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tsysMessageCtrl.menuid" id="menuid"/>
  <s:hidden name="tsysMessageCtrl.wid" id="wid"/>

 <fieldset> 
　 <legend>消息信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" width="15%">名称：</td>
      <td align="left" width="35%"><s:textfield id="name" name="tsysMessageCtrl.name" maxlength="15"/> <label style="color:red">*</label></td>
	  <td align="right" width="15%">部门类型：</td>
	  <td align="left" width="35%">
	  		<s:select name="tsysMessageCtrl.departtype" id="departtype" list="getSysCode('departtype')"
				listKey="id" listValue="caption" headerKey="" headerValue="----请选择----"/> <label style="color:red">*</label>
	  </td>
    </tr>
    <tr> 
      <td align="right">关联菜单：</td>
      <td align="left"><s:textfield name="tsysMessageCtrl.menuname" id="menuname" maxlength="20" size="20" readonly="true" />
				<input type="button" value="..." onclick="selectMenu('menuid','menuname')" /> <label style="color:red">*</label></td>
	  <td align="right">状态：</td>
	  <td align="left"><s:radio name="tsysMessageCtrl.state" list="#{'1':'启用','0':'禁用'}"/> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right">排序值：</td>
      <td align="left"><s:textfield name="tsysMessageCtrl.ordernum" id="ordernum" maxlength="4"
      		 onkeypress="NumberText(event,false,false);" cssStyle="ime-mode:disabled"/> <label style="color:red">*</label></td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
    </tr>
	<tr> 
	  <td align="right" nowrap="nowrap">查询语句：</td>
	  <td colspan="3" align="left">
		 <span class="float_left"><s:textarea name="tsysMessageCtrl.sql" id="sql" cssStyle="width:400px;" cssClass="validate[length[0,150]]"/></span>
		 <span class="img_light" style="height:80px;" title="限制在150字符以内"></span>
		 <span style="width:100px">
		 	<b>示例：</b>select <font color="red">count(*)</font> from t_sys_depart where <font color="red">departid like ?</font>
		 	（固定传参：当前部门号+＂%＂）
		 </span> 
	  </td>
	</tr>
	<tr> 
	  <td align="right" nowrap="nowrap">注释：</td>
	  <td colspan="3" align="left">
		 <span class="float_left"><s:textarea name="tsysMessageCtrl.description" id="description" cssStyle="width:400px;" cssClass="validate[length[0,150]]"/></span>
		 <span class="img_light" style="height:80px;" title="限制在150字以内"></span> 
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
