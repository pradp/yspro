<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page import="com.yszoe.identity.IdConstants"%>
<%@ page import="com.yszoe.identity.entity.LoginUserVO"%>
<%@ page import="com.yszoe.identity.entity.TSysDepart"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<%@include file="../../common/Include_input_head.jsp" %>
  	<title>组织机构信息</title>
	
	<script type="text/javascript">
	detailPageStyle();
	validate_type_fields = [
	            			{fieldId:"linkemail", message:"邮箱格式不正确！", typeRule:{requiredType:"email"}}
	            		];
	var isEditSelf = null;
	$(document).ready(function(){
		var departtype = $("#departtype").val();
		if(departtype=='' || departtype=='1' || departtype == '2'){
			$("#departtype option").each(function(){
				if($(this).html()=='区县' || $(this).html()=='管理员'){
					$(this).remove();
				}
				if(departtype == '1'){
					if($(this).html()=='种畜禽场'){
						$(this).remove();
					}
				}
			})
			$("#departtype").prev("div").find("ul li").each(function(){
				if($(this).html()=='区县' || $(this).html()=='管理员'){
					$(this).remove();
				}
				if(departtype == '1'){
					if($(this).html()=='种畜禽场'){
						$(this).remove();
					}
				}
			})
		}
		if(document.getElementById('isEditSelf')){
			isEditSelf = document.getElementById('isEditSelf').value;
		}
		<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			if(window.parent.document.getElementById('menuFrame')){
				var type = '<s:property value="#type"/>';
				window.parent.document.getElementById('menuFrame').src='<s:property value="basePath"/>/system/depart-departTree.action?isEditSelf='+isEditSelf+'&type='+type;
			}
		</s:if>			
	});

	function addSub(){
		window.location.href='<s:property value="basePath"/>/system/depart-input.action?tsysDepart.updepartid=<s:property value="tsysDepart.departid"/>&type=<s:property value="%{#parameters.type[0]}"/>';
	}
	var tem_valueObjid,tem_nameObjid;
	function selectArea(valueObjid,nameObjid){
		tem_valueObjid = valueObjid;
		tem_nameObjid = nameObjid;
		var url = "<s:property value="basePath"/>/system/area-areaTree.action";
		openTreeDialog(url);
	}
	</script>
  </head>
  
  <body>

  <s:form name="theform" method="post" theme="simple">
  <s:hidden name="tsysDepart.departid" id="departid"/>
  <s:hidden name="tsysDepart.updepartid" id="updepartid"/>
  <s:hidden name="tsysDepart.updepartname" id="updepartname"/>
  <s:hidden name="tsysDepart.city" id="city"/>
  <s:hidden name="tsysDepart.depth" id="depth"/>
  <s:hidden name="type" value="%{#parameters.type[0]}"/>
  
	<div class="box1" style="width:100%;height:500px;overflow-y:auto;overflow-x: hidden">

 <fieldset> 
　 <legend>基本信息</legend>
  <table class="tableStyle" transMode="true" footer="normal">
    <tr>      
      <td align="right" width="10%" nowrap="nowrap">部门编号：</td>
      <td width="40%" align="left">
      	<s:if test="tsysDepart.departid == null"><s:property value="tsysDepart.updepartid"/>***(自动生成)</s:if>
      	<s:else><s:property value="tsysDepart.departid"/></s:else>
      </td>
     <td align="right" width="10%" nowrap="nowrap">部门名称：</td>
     <td width="40%" align="left"><s:textfield name="tsysDepart.departname" id="departname" maxlength="20" size="26"/><label style="color:red">*</label></td>
    </tr>
    <tr>      
      <td align="right" width="10%" nowrap="nowrap">上级部门编号：</td>
      <td width="40%" align="left"><s:property value="tsysDepart.updepartid" /> </td>
     <td align="right" width="10%" nowrap="nowrap">上级部门名称：</td>
      <td width="40%" align="left"><s:property value="tsysDepart.updepartname"/> </td>
    </tr>    
	<tr>
	   <td align="right" width="10%" nowrap="nowrap">部门类型：</td>
	   <td width="40%" align="left">
	      <s:select name="tsysDepart.departtype" id="departtype" list="getSysCode('departtype')" listKey="id" listValue="caption" headerKey="" headerValue="----请选择----"/><label style="color:red">*</label>
	   </td>
	   <td align="right" width="10%" nowrap="nowrap">状态：</td>
	   <td width="40%" align="left"><s:select name="tsysDepart.state" list="#{'1':'可用','0':'禁用'}" listKey="key" listValue="value"></s:select> </td>
	</tr>
    <s:if test="tsysDepart.departtype==0 || tsysDepart.departtype==3"></s:if>
    <s:else>
	    <tr>
	      <td align="right" width="10%" nowrap="nowrap">所属区县</td>
	      <td width="40%" align="left"><s:textfield name="tsysDepart.cityname" id="cityname" maxlength="20" size="20" readonly="true" />
				<input type="button" value="..." onclick="selectArea('city','cityname')" /><label style="color:red">*</label></td>
	      <td align="right" width="10%" nowrap="nowrap">&nbsp;</td>
	      <td width="40%" align="left">&nbsp;</td>
	    </tr>
    </s:else>
	<tr> 
	  <td align="right" nowrap="nowrap">部门描述：</td>
	  <td colspan="3" align="left">
		 <span class="float_left"><s:textarea name="tsysDepart.description" id="description" cssStyle="width:400px;" cssClass="validate[length[0,300]]"/></span>
		 <span class="img_light" style="height:80px;" title="限制在300字以内"></span> 
	  </td>
	</tr> 
  </table>
  </fieldset>
 <fieldset> 
　 <legend>附属信息</legend>
  <table class="tableStyle" transMode="true" footer="normal">   
    <tr>      
      <td align="right" width="10%" nowrap="nowrap">联系人：</td>
      <td width="40%" align="left"><s:textfield name="tsysDepart.linkname" id="linkname" maxlength="20" size="31"/> </td>
     <td align="right" width="10%" nowrap="nowrap">联系电话：</td>
      <td width="40%" align="left"><s:textfield name="tsysDepart.linktel" id="linktel" maxlength="12" size="31" onkeypress="NumberText(event,false,false);" cssStyle="ime-mode:disabled"/> </td>
    </tr>    
    <tr>      
      <td align="right" width="10%" nowrap="nowrap">联系地址：</td>
      <td width="40%" align="left"><s:textfield name="tsysDepart.linkaddress" id="linkaddress" maxlength="40" size="31"/> </td>
     <td align="right" width="10%" nowrap="nowrap">联系邮编：</td>
      <td width="40%" align="left"><s:textfield name="tsysDepart.linkpostcode" id="linkpostcode" maxlength="6" size="31" onkeypress="NumberText(event,false,false);" cssStyle="ime-mode:disabled"/> </td>
    </tr>    
    <tr>      
      <td align="right" width="10%" nowrap="nowrap">联系邮箱：</td>
      <td width="40%" align="left"><s:textfield name="tsysDepart.linkemail" id="linkemail" maxlength="50" size="31"/> </td>
     <td align="right" width="10%" nowrap="nowrap">联系传真：</td>
      <td width="40%" align="left"><s:textfield name="tsysDepart.linkfax" id="linkfax" maxlength="50" size="31"/> </td>
    </tr>
    
  </table>
  </fieldset>  

	<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
		  			<s:if test="#parameters.type[0] == 1">
		  			</s:if>
		  			<s:else>
		  				<s:if test="tsysDepart.departtype==null || tsysDepart.departtype!=0">
							<input type="button" id="ysSaveButton" value=" 保  存 " onclick="doSave(true)"/>
						</s:if>
						<s:if test="tsysDepart.departtype!=2 && tsysDepart.departid!=null && tsysDepart.departid!=''.toString()">
							<!-- <input type="button" id="ysaddButton" value=" 新增下级 " onclick="addSub()"/> -->
						</s:if>
						<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
							<span id="SystemErrorMessage">
								<s:actionerror/>
								<s:actionmessage/>
								<s:fielderror/>
							</span>
						</s:if>
					</s:else>
				</td>
			</tr>
		</table>
	</div> 
  		
  </div>
</s:form>
  </body>
</html>
