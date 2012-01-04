<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
		<link rel="stylesheet" type="text/css" href="../resources/css/testProject.css"/>
		<script type="text/javascript" src="../resources/js/testProject.js"/>
	
    	<title>测试项目信息</title>

	<script type="text/javascript">
	detailPageStyle();
	</script>
	
	
  </head>
  
  <body style="text-align:center;">

<div class="box1" panelWidth="100%">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tcsXm.wid" id="wid"/>
  <s:hidden name="tcsXm.fz" id="fz"/>
  <s:hidden name="tcsXm.xxxx" id="xxxx"/>
  <s:hidden name="sfxz" id="sfxz" />

 <fieldset> 
　 <legend>项目信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" nowrap="nowrap" width="15%">项目名：</td>
      <td align="left" width="25%"><s:textfield id="name" name="tcsXm.name" maxlength="25"/> <label style="color:red">*</label></td>
	  <td align="right" width="15%">类型：</td>
	  <td align="left" width="45%"><s:select id="lx" name="tcsXm.lx" list="getType()" listKey="id" listValue="caption"/> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">价格：</td>
      <td align="left"><s:textfield id="jg" name="tcsXm.jg" maxlength="6" onkeypress="NumberText(event,false,false);" cssStyle="ime-mode:disabled"/></td>
	  <td align="right">测试时间：</td>
	  <td align="left"><s:textfield id="cssj" name="tcsXm.cssj" maxlength="6" onkeypress="NumberText(event,false,false);" cssStyle="ime-mode:disabled"/></td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">简介：</td>
      <td align="left" colspan="3">
		 <span class="float_left"><s:textarea name="tcsLx.jj" id="jj" cssStyle="width:400px;" cssClass="validate[length[0,300]]"/></span>
		 <span class="img_light" style="height:80px;" title="限制在300字以内"></span> 
	  </td>
    </tr>
  </table>
 </fieldset>
 
 <fieldset> 
　 <legend>题目信息</legend>
  <div width="100%" border="0" align="center" id="tmxx">
	  <div style="float：left" align="left" class="addTz" id="cleanTm"> 
	    <s:hidden name="hidden_context" id="hidden_subject"/>
	    <s:hidden name="hidden_context" id="hidden_xx"/>
	    <s:hidden name="hidden_context" id="hidden_xxbj"/>
		<button type="button" onclick="addTz()"><span class="icon_add">新增题组</span></button>
		<button type="button" onclick="addTm(this,0)"><span class="icon_add">新增题目</span></button>
	  </div>
	  <div><%@include file="./subject.jsp" %></div>
	  <s:iterator value="listTcstm" status="stat">
	  	<s:property value="bjxx" escape="false"/>
	  </s:iterator>
  </div>
 </fieldset>
</s:form>
<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
					<input type="button" id="ysSaveButton" value=" 保 存 " onclick="doMySave()"/>
					<input type="button" value=" 关 闭 " onclick="parent.closeEntityWindow()"/>
					<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
						<span id="SystemErrorMessage" style="margin-left: 5px;white-space:nowrap;">
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
  </body>
</html>
