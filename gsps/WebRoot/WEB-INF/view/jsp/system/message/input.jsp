<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<title>消息发送</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/p2pMessage.js"></script>
	
	<script type="text/javascript">
	detailPageStyle();
	var tem_valueObjid,tem_nameObjid;
	function selectDepart(valueObjid,nameObjid){
		tem_valueObjid = valueObjid;
		tem_nameObjid = nameObjid;
		var url = "<s:property value="basePath"/>/system/depart-selectDepart.c";
		openWindow(url,700,300);
	}
	function submitForm(str){
        var depart = '<s:property value="depart.departtype" />';
		if(document.getElementById("xxjsr").value==""){
			alert("请选择消息接收者！");
			return false;
		}
		var xxbt = document.getElementById("xxbt").value;
		if(xxbt==""){
			alert("请输入标题！");
			return false;
		}
		if(getLength(xxbt)>50){
			alert("标题字数超出最大值！");
			return false;
		}
		var xxnr = document.getElementById("xxnr").value;
		if(xxnr==""){
			alert("请输入内容！");
			return false;
		}
		if(getLength(document.getElementById("xxnr").value)>1200){
			alert("内容字数超出最大值！");
			return false;
		}
		if(document.getElementById("messageType")){
			if(document.getElementById("messageType").checked)
			$("#xxly").val("100");
			//alert(document.getElementById("messageType").value);
		}
		document.getElementById("fszt").value = str;
		return super_submitForm();
	}
	function doReset(){
	     document.getElementById("attachment").focus();
	     document.execCommand("selectall");   
         document.execCommand("Delete"); 
	}
	function PreviewFile(myFile){
	    var filepath=myFile.value;
	    document.getElementById("fjm").value=filepath.substring(filepath.lastIndexOf('.')+1,filepath.length);
	}
	function init(){
		document.getElementById('xxbt').value = "";
		document.getElementById('xxnr').value = "";
	}
	window.onload = init;
	</script>
	
  	<base target="_self">
  </head>
  
  <body style="text-align:center;">

<div  class="framestyle" style="width:100%;">
  <s:form name="theform" method="post" theme="simple" enctype="multipart/form-data">
  <s:hidden id="xxjsr" name="tsysMessage.xxjsr" />
  <s:hidden id="xxly" name="tsysMessage.xxly" />
  <s:hidden id="fszt" name="tsysMessage.fszt" value="0"/>
  <s:hidden id="fjm" name="tsysMessage.fjm"/>

  <table width="100%" border="0" align="center">
    <tr class="fzline"> 
      <td align="right" width="10%" nowrap="nowrap">接收者：</td>
      <td width="40%">
	      <s:textfield name="tsysMessage.xxjsrName" id="xxjsrName" size="50" readonly="true"/> 
		      	<input type="button" value="部门" onclick="selectDepart('xxjsr','xxjsrName')"/>
	      <label style="color:red">*</label>
      </td>
    </tr>
    <tr class="fzline"> 
      <td align="right" width="10%" nowrap="nowrap">标题：</td>
      <td width="40%"><s:textfield id="xxbt" name="tsysMessage.xxbt" maxlength="50" size="50"/> <label style="color:red">*</label></td>
    </tr>
    <tr class="fzline">
     <td align="right" width="10%" nowrap="nowrap">内容：</td>
      <td width="40%"><s:textarea id="xxnr" name="tsysMessage.xxnr" cols="50" rows="10"></s:textarea> <label style="color:red">*</label></td>
    </tr>
    </table>
  
  <table width="35%" border="0" align="center">
  <br/>
    <tr> 
    	<td height="30" colspan="2" >
    		<ul class="btn_gn">
    			<li><a href="#" title="发送" onClick="submitForm('1')"><span>发送</span></a></li>
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
