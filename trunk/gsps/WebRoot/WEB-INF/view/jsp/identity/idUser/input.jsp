<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
    <title>维护用户</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.bgiframe.min.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.ajaxQueue.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/thickbox-compressed.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.js"></script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.css">
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/lib/thickbox.css">
	
	<script type="text/javascript">
	detailPageStyle();
	$(document).ready(function(){
		
		var url = "<s:property value="basePath"/>/suggest?aim=depart";
		
		getSuggest("departname","departid",url,true);
		
		changeRightCtrl();
	});
	
	var menues_init = '<s:property value="menues"/>';

	function submitForm(){
		
		if( !checkInput("userLoginId","登录帐号不能为空！") ){
			return false;
		}
		if( isContainChinese($("#userLoginId").val()) ){
			alert("用户登录账号不接受中文！");
			document.getElementById("userLoginId").focus();
			return false;
		}
		if( getLength($("#userLoginId").val())>50 ){
			alert("用户登录账号长度不能超过50！");
			document.getElementById("userLoginId").focus();
			return false;
		}
		if(!checkInput("userPwd","登录密码不能为空！")){
			return false;
		}
		if( !checkInput("userName","用户名称不能为空！") ){
			return false;
		}
		if( !checkInput("departid","所属部门不能为空！") || !checkInput("departname","所属部门不能为空！") ){
			return false;
		}
		var userState = $("#userState").val();
		if(userState=="1"||userState=="2"){
			var slength = 0;
			var a = document.getElementsByName("groups");
			for (var i = 0; i < a.length; i++) {
			    if (a[i].checked) {
			        slength += 1;
			    }
			}
			if(slength==0){
				alert("请选择所属组！");
				return false;
			}
		}
		var menues = window.frames["menuFrame"].document.getElementById("nodeid").value;
		if(menues!=="" && menues !== menues_init){
			document.getElementById("menues").value = menues; 
		}
		return super_submitForm();
		
	}

	function changeRightCtrl(){
		var userState = $("#userState").val();
		if(userState=="1"){
			$("#userRightCtrl_group").show();
			$("#userRightCtrl_menu").show();
		}else if(userState=="2"){
			$("#userRightCtrl_group").show();
			$("#userRightCtrl_menu").hide();
		}else if(userState=="3"){
			$("#userRightCtrl_group").hide();
			$("#userRightCtrl_menu").show();
		}else{
			//$("#userRightCtrl_group").hide();
			//$("#userRightCtrl_menu").hide();
		}
	}
	</script>
  </head>
  
  <body style="text-align:center;">

<div class="framestyle" style="width:100%;">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tsysUser.userid" />
  <s:hidden id="departid" name="tsysUser.depart.departid" />
  <s:hidden id="menues" name="menues" />

  <table width="100%" border="0" align="center">
    <tr> 
      <td width="3%">&nbsp;</td>
      <td align="center" width="23%" nowrap="nowrap">登录帐号：<s:textfield id="userLoginId" name="tsysUser.userLoginId" maxlength="50" size="15"/> <label style="color:red">*</label></td>
      <td align="center" width="30%" nowrap="nowrap">登录密码：<INPUT type="password" value="<s:property value="tsysUser.userPwd"/>" id="userPwd" name="tsysUser.userPwd" maxlength="30" size="15"/> <label style="color:red">*</label></td>
	<td align="center">状态：
	<s:select id="userState" name="tsysUser.state" value="%{tsysUser==null?'2':tsysUser.state}" list="#{'1':'启用，且两者都有','2':'启用，仅继承用户组的菜单','3':'启用，仅使用单独指定的菜单','0':'暂不允许该用户登录'}" listKey="key" listValue="value" onchange="changeRightCtrl()"/>
	</td>
      <td width="3%">&nbsp;</td>
    </tr>
  </table>
  <table width="96%" border="0" align="center">
    <tr>
    	<td height="1" style="background-color: silver"></td>
    </tr>
  </table>
  
  <table width="100%" border="0" align="center">
    <tr> 
      <td >&nbsp;</td>
      <td align="center" nowrap="nowrap">用户名称：<s:textfield id="userName" name="tsysUser.userName" maxlength="50" size="30"/> <label style="color:red">*</label></td>
      <td align="center" nowrap="nowrap">用户所在部门：<s:textfield id="departname" name="tsysUser.depart.departname" maxlength="25" size="30" /><label style="color:red">*</label></td>
      <td align="center" nowrap="nowrap">身份类型：<s:select id="usertype" name="tsysUser.usertype"  list="#{'':'无特殊身份','1':'成绩发布者','2':'成绩审核者','3':'成绩登记者','4':'青管中心'}" listKey="key" listValue="value"/><label style="color:red">*</label></td>
	<td>&nbsp;</td>
    </tr>
  </table>

  <table width="96%" border="0" align="center">
    <tr>
    	<td height="1" style="background-color: silver"></td>
    </tr>
  </table>
  
  <table id="userRightCtrl_group" width="100%" border="0" align="center">
    <tr> 
      <td align="right">所属组：</td>
      <td width="80%" align="left"><s:checkboxlist name="groups" value="%{groups}" list="allGroups" listKey="groupid" listValue="groupName"/></td>
      <td width="11%"></td>
    </tr>
  </table>
  <table width="96%" border="0" align="center">
    <tr>
    	<td height="1" style="background-color: silver"></td>
    </tr>
  </table>
  
  <table id="userRightCtrl_menu" width="100%" border="0" align="center">
    <tr>
    	<td>&nbsp;指定菜单：</td>
    </tr>
    <tr> 
      <td align="center" width="100%" nowrap="nowrap">
      	<iframe id="menuFrame" name="menuFrame" frameborder="0" width="100%" height="350" src="idMenu-list.c?showCheckBox=true"></iframe>
      </td>
    </tr>
  </table>
 
  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
    <tr valign="middle">
    	<td height="30" colspan="7">
    		<ul class="btn_gn" style="padding-left:40%;">
    			<li><a href="#" title="保存" onClick="submitForm()"><span>保存</span></a></li>
	    		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	    	</ul>
	</td>
    </tr>
  </table>

</s:form>
</div>

<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

  </body>
</html>
