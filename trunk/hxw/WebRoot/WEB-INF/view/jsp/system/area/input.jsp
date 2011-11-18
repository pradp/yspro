<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page import="com.yszoe.identity.IdConstants"%>
<%@ page import="com.yszoe.identity.entity.LoginUserVO"%>
<%@ page import="com.yszoe.identity.entity.TSysDepart"%>
<%
LoginUserVO tsysUser = (LoginUserVO) session.getAttribute(IdConstants.SESSION_USER);
TSysDepart tdepart = tsysUser.getDepart();
String logindepartid=tdepart.getDepartid();
String departword = "区域";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
	<%@include file="../../common/Include_input_head.jsp" %>
  	<base target="_self">
  	<title>区域信息</title>

	<script type="text/javascript">
	detailPageStyle();
	var isEditSelf = null;
	$(document).ready(function(){
		if(document.getElementById('isEditSelf')){
			isEditSelf = document.getElementById('isEditSelf').value;
		}
		<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			window.parent.document.getElementById('menuFrame').src='<s:property value="basePath"/>/system/area-areaTree.action?isEditSelf='+isEditSelf;
		</s:if>			
	});

   validate_required_fields = [
			{fieldId:"areaname", message:"区域名称不能为空！", mustMatch: true}
		];
	function addSub(){
		window.location.href='<s:property value="basePath"/>/system/area-input.action?tsysArea.upareaid=<s:property value="tsysArea.areaid"/>';
	}
	function saveArea(){
		if(isValidateForm()){
			return super_doSave();
		}
	}
	function deleteArea(){
		if(document.getElementById('isEditSelf')){
			isEditSelf = document.getElementById('isEditSelf').value;
		}
		if(confirm('是否删除该区域？删除的同时将会连同子区域一起删除！')){
			$.post('<s:property value="basePath"/>/system/area-remove.action?wid=<s:property value="tsysArea.areaid"/>',null,function(data){
				if(data.indexOf('删除成功')>0){
					alert('删除成功！');
					window.parent.document.getElementById('menuContentFrame').src='';
					window.parent.document.getElementById('menuFrame').src='<s:property value="basePath"/>/system/area-areaTree.action?isEditSelf='+isEditSelf;
				}else{
					alert(data.substring(data.indexOf('[')+1,data.indexOf(']')));
				}
			});
		}
	}
	</script>
	
  </head>
  
  <body style="text-align:center;">

<div class="framestyle" style="width:100%;">
  <s:form name="theform" method="post" theme="simple">
  <s:hidden name="tsysArea.upareaid" id="upareaid" />
  <s:hidden name="tsysArea.arealevel" id="arealevel" />
  <s:hidden name="tsysArea.upareaname" />
  <s:hidden id="isEditSelf" name="isEditSelf" value="%{#parameters.isEditSelf[0]}"/>
  
	<div class="box1" panelWidth="99%">
 <fieldset> 
　 <legend>
	<s:if test="tsysArea.areaid !=null">修改区域信息</s:if>
    <s:else>添加区域信息</s:else></legend>
  <table class="tableStyle" transMode="true" footer="normal">
    <tr>
      <td align="right" width="10%" nowrap="nowrap"><%=departword %>编号：</td>
      <td width="40%" align="left">
      	<s:if test="#parameters.isEditSelf[0]!=null"><s:property value="tsysArea.areaid"/>
  				<s:hidden name="tsysArea.areaid" id="areaid" /></s:if>
      	<s:else>
      		<s:textfield name="tsysArea.areaid" id="areaid" maxlength="50" size="10"/>
      	</s:else>
      </td>
     <td align="right"><%=departword %>名称：</td>
      <td align="left"><s:textfield name="tsysArea.areaname" id="areaname" maxlength="20" size="26"/> <label style="color:red">*</label></td>
    </tr>
    <tr>
      <td align="right">上级<%=departword %>编号：</td>
     <td align="left"><s:property value="tsysArea.upareaid==null?'--':tsysArea.upareaid" /> </td>
     <td align="right">上级<%=departword %>名称：</td>
      <td align="left"><s:property value="tsysArea.upareaname==null?'--':tsysArea.upareaname"/> </td>
    </tr>
    <tr>
      <td align="right">国标码：</td>
     <td align="left"><s:textfield name="tsysArea.gbm" id="gbm" maxlength="20" size="26"/></td>
      <td align="right">状态：</td>
      <td align="left"><s:select name="tsysArea.state" list="#{'1':'可用','0':'禁用'}" listKey="key" listValue="value"></s:select> </td>
    </tr>
    <tr>
      <td align="right">排序值：</td>
      <td align="left" colspan="3">
     	<s:textfield name="tsysArea.ordernum" id="ordernum" maxlength="6" size="26" 
     		onkeypress="NumberText(event,false,false);" cssStyle="ime-mode:disabled"/> <label style="color:red">*</label>
      	<font color="#999999">说明：同一层次中数值大的往前排</font>
      </td>
    </tr>
  </table>
  </fieldset>
 
	<div class="padding_top10">
	  	<table  class="tableStyle" transMode="true">
	          <tr> 
	            <td height="50" colspan="4" align="left"> 
					<input type="button" id="savaAreaButton" value=" 保  存 " onclick="saveArea()" style="margin-right: 10px"/>
	            	<s:if test="#parameters.isEditSelf[0]!=null">
	    				<input type="button" id="addSubButton" value=" 新增下级 " onclick="addSub()"/>
	    			</s:if>
					<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
						<span id="SystemErrorMessage" style="top: 20px">
							<s:actionerror/>
							<s:actionmessage/>
							<s:fielderror/>
						</span>
					</s:if>
	          	</td>
	          </tr>
		</table>
	</div>
  </div>
</s:form>
</div>
  </body>
</html>
