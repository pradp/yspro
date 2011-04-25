<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page import="com.imchooser.framework.identity.IdConstants"%>
<%@ page import="com.imchooser.framework.identity.entity.LoginUserVO"%>
<%@ page import="com.imchooser.framework.identity.entity.TSysDepart"%>
<%
LoginUserVO tsysUser = (LoginUserVO) session.getAttribute(IdConstants.SESSION_USER);
TSysDepart tdepart =tsysUser.getDepart();
String logindepartid=tdepart.getDepartid();  
String operationdepartid=((TSysDepart)request.getAttribute("tsysDepart")).getDepartid();
String departword="";
String flag="";
boolean isSchool=false;

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
  	<title>组织机构信息</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>

  
	<script type="text/javascript">
	detailPageStyle();
	$(document).ready(function(){
			<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			window.parent.document.getElementById('menuFrame').src='<s:property value="basePath"/>/system/depart-areaTree.c';
			</s:if>			
		}
	);

	function addSub(){
		window.location.href='<s:property value="basePath"/>/system/depart-input.c?tsysDepart.updepartid=<s:property value="tsysDepart.departid"/>';
	}
	function saveDepart(){
		var departname=document.getElementById('departname');
		if(departname && departname.value==''){
			alert('请输入部门名称');
			return false;
		}
		var linkman=document.getElementById('linkman');
		var linktel=document.getElementById('linktel');
		var postcode=document.getElementById('postcode');
		var address=document.getElementById('address');
		var fax=document.getElementById('fax');
		var email=document.getElementById('email');
		var bank1=document.getElementById('bank1');
		var account1=document.getElementById('account1');
		var bank2=document.getElementById('bank2');
		var account2=document.getElementById('account2');
		
		return super_submitForm();
	}
	function deleteDepart(){
		if(confirm('是否删除该单位？删除的同时将会连同子单位一起删除！')){
			$.post('<s:property value="basePath"/>/system/depart-remove.c?tsysDepart.departid=<s:property value="tsysDepart.departid"/>',null,function(data){
				if(data.indexOf('删除成功')>0){
					alert('删除成功！');
					window.parent.document.getElementById('menuContentFrame').src='';
					window.parent.document.getElementById('menuFrame').src='<s:property value="basePath"/>/system/depart-areaTree.c';
				}else{
					alert(data.substring(data.indexOf('[')+1,data.indexOf(']')));
				}
			});
		}
	}

	var tem_valueObjid,tem_nameObjid;
	function selectDepart(valueObjid,nameObjid){
		tem_valueObjid = valueObjid;
		tem_nameObjid = nameObjid;
		var url = '<s:property value="basePath"/>/system/depart-selectDepart.c?depid=<s:property value="departID"/>';
		openWindowOnly(url,700,300);
	}
	function mergeDepart(){
		var mydepid = '<s:property value="tsysDepart.departid"/>';
		var finaldepid = document.getElementById('depid').value;
		if(mydepid == finaldepid){
			alert('不能和自己院系合并!');
			return false;
		}
		ajaxService.mergeDepart('2009',mydepid,finaldepid, backString);
		function backString(result){
			alert(result);
			window.parent.document.getElementById('menuFrame').src='<s:property value="basePath"/>/system/depart-areaTree.c';
			window.location.href='<s:property value="basePath"/>/system/depart-input.c?tsysDepart.departid='+finaldepid;
		}
	}
		
	function checkDepartname(){
		var departname = null;
		var updepartid = null;
		var departid = '<s:property value="tsysDepart.departid"/>';
		if(departid==""){
		  departname=document.getElementById('departname').value;
		  updepartid=document.getElementById('updepartid').value;
		 }else if(document.getElementById('departname')&&document.getElementById('departname').value!=''&&document.getElementById('updepartid')&&departid!=null){
		 	return false;
		 }else{
		 	departname= '<s:property value="tsysDepart.departname"/>';
		 	updepartid= '<s:property value="tsysDepart.updepartid"/>';
		 }
		ajaxService.checkDepartData(departname,updepartid,callCheckData);
		function callCheckData(result){
			if(result==false){
				if(document.getElementById('departname')){
					alert('已登记该部门,请登记其他部门!');
					document.getElementById('departname').value="";
					document.getElementById('departname').focus();
					return false;
				}	
			}
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

<div class="framestyle" style="width:100%;">
  <s:form name="theform" method="post" theme="simple">
  <s:hidden name="tsysDepart.departid"/>
  <s:hidden name="updepartid" />
  <s:hidden name="updepartname" />
  <s:hidden name="tsysDepart.updepartid" />
  <s:hidden name="tsysDepart.cc" />
  <s:hidden name="tsysDepart.sfsn" value="1"/>
  <s:hidden id="depid" name="depid" />
  <s:hidden id="depidName" name="depidName" />
  
  
  
  <table width="100%" border="0" align="center">
    <tr>
    	<th height="40px" width="100%">
    	<h3>
    	<s:if test="tsysDepart.departid !=null">
    	修改<%=departword %>信息
    	</s:if>
    	<s:else>
    	添加<%=departword %>信息
    	</s:else>
    	</h3></th>
    </tr>
  </table>
  <s:property value="%{#parameters.dwlx[0]}" />

 <fieldset> 
　 <legend>基本信息</legend>
  <table width="100%" border="0" align="center">
  <%
  if(logindepartid.equals(operationdepartid)){
  %>
    <tr>      
      <td align="right" width="10%" nowrap="nowrap"><%=departword %>编号：</td>
      <td width="40%"><s:property value="tsysDepart.departid"/> </td>
     <td align="right" width="10%" nowrap="nowrap"><%=departword %>名称：</td>
      <td width="40%"><s:property value="tsysDepart.departname"/><s:hidden name="tsysDepart.departname" /></td>
    </tr>
    <tr>      
      <td align="right" width="10%" nowrap="nowrap">上级<%=departword %>编号：</td>
      <td width="40%"><s:property value="updepartid==null?'--':updepartid" /> </td>
     <td align="right" width="10%" nowrap="nowrap">上级<%=departword %>名称：</td>
      <td width="40%"><s:property value="updepartname==null?'--':updepartname"/> </td>
    </tr>    
   <%}else{ %>
    <tr>
      <td align="right" width="10%" nowrap="nowrap"><%=departword %>编号：</td>
      <td width="40%"><s:property value="tsysDepart.departid==null?'自动生成':tsysDepart.departid"/> </td>
     <td align="right" width="10%" nowrap="nowrap"><%=departword %>名称：</td>
      <td width="40%"><s:textfield name="tsysDepart.departname" id="departname" maxlength="20" size="26" onblur="checkDepartname()"/> <label style="color:red">*</label></td>
    </tr>
    <tr>
      <td align="right" width="10%" nowrap="nowrap">上级<%=departword %>编号：</td>
     <td width="40%"><s:property value="updepartid==null?'--':updepartid" /> </td>
     <td align="right" width="10%" nowrap="nowrap">上级<%=departword %>名称：</td>
      <td width="40%"><s:property value="updepartname==null?'--':updepartname"/> </td>
    </tr>
   <%} %>    
    <tr>
      <td align="right" width="10%" nowrap="nowrap">状态：</td>
      <td width="40%"><s:select name="tsysDepart.state" list="#{'1':'可用','0':'禁用'}" listKey="key" listValue="value"></s:select> </td>
      <td align="right" width="10%" nowrap="nowrap"></td>
      <td width="40%"></td>
    </tr>
  </table>
  </fieldset>
 <fieldset> 
　 <legend>附属信息</legend>
  <table width="100%" border="0" align="center">   
    <tr>      
      <td align="right" width="10%" nowrap="nowrap"><%=departword %>联系人：</td>
      <td width="40%"><s:textfield name="departDetail.linkman" id="linkman" maxlength="20" size="31"/> </td>
     <td align="right" width="10%" nowrap="nowrap"><%=departword %>联系电话：</td>
      <td width="40%"><s:textfield name="departDetail.linktel" id="linktel" maxlength="50" size="31"/> </td>
    </tr>    
    <tr>      
      <td align="right" width="10%" nowrap="nowrap">邮编：</td>
      <td width="40%"><s:textfield name="departDetail.postcode" id="postcode" maxlength="20" size="31"/> </td>
     <td align="right" width="10%" nowrap="nowrap">通讯地址：</td>
      <td width="40%"><s:textfield name="departDetail.address" id="address" maxlength="50" size="31"/> </td>
    </tr>    
    <tr>      
      <td align="right" width="10%" nowrap="nowrap">传真：</td>
      <td width="40%"><s:textfield name="departDetail.fax" id="fax" maxlength="20" size="31"/> </td>
     <td align="right" width="10%" nowrap="nowrap">电子邮箱：</td>
      <td width="40%"><s:textfield name="departDetail.email" id="email" maxlength="50" size="31"/> </td>
    </tr>
    
  </table>
  </fieldset>  
  <table width="30%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
  <tr align="center" valign="middle"> 

    <td height="30" colspan="7">
    	<ul class="btn_gn">
    			
    <s:if test="tsysDepart.cc==2 || tsysDepart.cc==3">
    <li><a href="#" title="新增下级" onClick="addSub()"><span>新增下级</span></a></li>
    
    </s:if>
     <li><a href="#" title="保存" onClick="saveDepart()"><span>保存</span></a></li>
    <%
  if(!logindepartid.equals(operationdepartid)){
  %>
   <li><a href="#" title="删除" onClick="deleteDepart()"><span>删除</span></a></li>
   <%}%>
   </ul>
    </td>
  </tr>
  </table>
  		
</s:form>
</div>
  </body>
</html>
