<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>模块功能与开放规则设置</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript">
	detailPageStyle();
	$(document).ready(function(){
		window.frames["menuFrame"].document.getElementById("nodeid").value = document.getElementById("menues").value;
		//alert(window.frames["menuFrame"].document.getElementById("nodeid").value);
		setDate();
		setHeight();
	});
	function setHeight(){
		var he=document.body.clientHeight - 40;
		document.getElementById("menuFrame").style.height=he;
	}
	
	function setDate(){
		var cycleType=document.getElementById("cycleType").value;
		if(cycleType==1){
		  document.getElementById("tr1").style.display="";
		  document.getElementById("tr2").style.display="none";
		  document.getElementById("tr3").style.display="none";
		}else if(cycleType==2){
		  document.getElementById("tr1").style.display="none";
		  document.getElementById("tr2").style.display="";
		  document.getElementById("tr3").style.display="none";
		}else if(cycleType==3){
		  document.getElementById("tr1").style.display="none";
		  document.getElementById("tr2").style.display="none";
		  document.getElementById("tr3").style.display="";
		}else if(cycleType==""){
		  document.getElementById("tr1").style.display="none";
		  document.getElementById("tr2").style.display="none";
		  document.getElementById("tr3").style.display="none";
		}
		
	}
	
	function checkDateT(){
		//var date = new Date();
		///var month =Integer.parseInt(date.getMonth());//获取当前月份
		if(document.getElementById("ksHao").value.length==""){
			alert("请输入开始号！");
			return false;
		}
		if(document.getElementById("jsHao").value.length==""){
			alert("请输入结束号！");
			return false;
		}
		var ksHao=parseInt(document.getElementById("ksHao").value);//开始号			
		var jsHao=parseInt(document.getElementById("jsHao").value);//结束号		
		if(ksHao<=0||ksHao>31){
			alert("几号开始时间设置必须大于0！");
			return false;
		}	
		if(jsHao>31||jsHao<=0||jsHao==ksHao){
			alert("几号结束时间设置必须大于结束时间，且小于31！");
			return false;
		}
		return true;
	}
	function checkDateS(){
		if(document.getElementById("ksMonth").value.length==""){
			alert("请输入开始月！");
			return false;
		}
		if(document.getElementById("jsMonth").value.length==""){
			alert("请输入结束月！");
			return false;
		}
		if(document.getElementById("ksDay").value.length==""){
			alert("请输入开始日！");
			return false;
		}
		if(document.getElementById("jsDay").value.length==""){
			alert("请输入结束日！");
			return false;
		}
		var ksMonth=parseInt(document.getElementById("ksMonth").value);//开始月12
		var jsMonth=parseInt(document.getElementById("jsMonth").value);//结束月
		var ksDay=parseInt(document.getElementById("ksDay").value);//开始日
		var jsDay=parseInt(document.getElementById("jsDay").value);//结束日
		if(ksMonth>12||ksMonth<=0){
			alert("开始月设置必须大于0，小于12月！");
			return false;
		}
		if(jsMonth<ksMonth||jsMonth<=0||jsMonth>12){
			alert("结束月设置必须大于0，小于12月，且大于开始月！");
			return false;
		}
		if(ksDay>31||ksDay<=0){
			alert("开始日设置错误！");
			return false;
		}
		if(ksMonth==jsMonth){
			if(jsDay<=ksDay||jsDay<=0||jsDay>31){
				alert("结束日设置必须大于0，大于开始日！");
				return false;
			}
		}
		if(jsDay<=0||jsDay>31){
				alert("结束日必须大于0，小于31！");
				return false;
			}
		return true;
		
	}
	function checkDateF(){
		if(document.getElementById("kshour").value.length==""){
			alert("请输入开始时！");
			return false;
		}
		if(document.getElementById("jshour").value.length==""){
			alert("请输入结束时！");
			return false;
		}
			if(document.getElementById("ksminute").value.length==""){
			alert("请输入开始分！");
			return false;
		}
		if(document.getElementById("jsminute").value.length==""){
			alert("请输入结束分！");
			return false;
		}
		var kshour=parseInt(document.getElementById("kshour").value);//开始时24
		var jshour=parseInt(document.getElementById("jshour").value);//结束时
		var ksminute=parseInt(document.getElementById("ksminute").value);//开始分60
		var jsminute=parseInt(document.getElementById("jsminute").value);//结束分
		if(kshour>=24||kshour<=0){
			alert("开始时设置必须大于0，小于24小时！");
			return false;
		}
		if(jshour>=24||jshour<=0||jshour<kshour){
			alert("结束时设置必须大于0，小于24小时,且大于开始时的设置！");
			return false;
		}
		if(ksminute>60||ksminute<0){
			alert("开始分设置必须大于0，小于60分！");
			return false;
		}
		
		if(kshour==jshour){
			if(jsminute<=ksminute||jsminute<0){
			alert("结束分设置必须大于0，且大于开始分！");
			return false;
			}
		}if(jsminute<0){
			alert("结束分设置必须大于0！");
			return false;
		}
		return true;
		
	}
		validate_required_fields = [
			{fieldId:"BUTTON_ENUM_ID", message:"权限设置不能为空！", mustMatch: true},
			{fieldId:"cycleType", message:"开放时间不能为空！", mustMatch: true}		
		];
	
	function  dosave(){
		var menues_init = '<s:property value="menues"/>';
		var menues = window.frames["menuFrame"].document.getElementById("nodeid").value;
		//alert(menues);
		if(menues==""||menues.length<5){
			alert("权限设置菜单不能为空！");
			return false;
		}
		
		var BUTTON_ENUM_ID=document.getElementById("BUTTON_ENUM_ID").value;
		////var state=document.getElementById("state").value;
		if(BUTTON_ENUM_ID==""){
			alert("权限设置不能为空");
			return false;
		}
		if(menues!=="" && menues !== menues_init){
			document.getElementById("menues").value = menues; 
		}
		var cycleType=document.getElementById("cycleType").value;
	
		if(cycleType==1){
			if(isValidateForm()&&checkDateF()){
			super_submitForm();
			}
		}else if(cycleType==2){
		
	 		if(isValidateForm()&&checkDateT()){
			 super_submitForm();
			 }
	 
		}else if(cycleType==3){
	        if(isValidateForm()&&checkDateS()){       
			 super_submitForm();			
			 }
	 
		}
		else if(cycleType==""){
			if(isValidateForm()){
				 super_submitForm();
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
<div class="framestyle" style="width:98%;padding: 0pt 10pt 10pt 10pt;">
<s:form theme="simple" name="theform">
<s:hidden id="menues" name="menues" />
<s:hidden id="wid" name="tsysButtonRule.wid" />
    <table width="100%" cellpadding="0" cellspacing="0" border="0" >
    	<tr>
    		<td width="29%"> 
<fieldset>
	<legend>模块功能选择</legend>
	<iframe id="menuFrame" name="menuFrame" frameborder="0" width="100%" src="../id/idMenu-list.c?showCheckBox=true"></iframe>
</fieldset>		
    		</td>
    		<td width="1%" bgcolor="#CCCCCC"></td>
    		<td width="70%" align="right" valign="top">
<fieldset>
	<legend>开放规则设置</legend>
	<table width="98%" height="350" border="0"  align="center" cellpadding="0" cellspacing="0" >
	    <tr>
		     <td align="right" width="20%">权限设置：</td>
		     <td colspan="3" align="left" valign="middle">
		     <s:checkboxlist  id="BUTTON_ENUM_ID" list="getButtonList()" name="BUTTON_ENUM_ID" listKey="id" listValue="caption"></s:checkboxlist>
             </td>    
          </tr>
          <tr>
           <td align="right" width="20%">开放时间：</td>
           <td colspan="3" align="left">
           <s:select id="cycleType" name="tsysButtonRule.cycleType"  onchange="setDate()" list="getSysCode('cycletype')" headerKey="" headerValue="-------请选择-----" listKey="id" listValue="caption"/> <label style="color:red">*</label>
           </td>
         </tr>
         <tr id="tr1" style="display:none">
          <td align="right" >开始时间：</td>
          <td align="left"><s:textfield id="kshour" name="kshour" maxlength="5" size="2" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/>时
          <s:textfield id="ksminute" name="ksminute" maxlength="5" size="2" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/> 分</td> 
          <td align="right">结束时间：</td>     
          <td align="left"><s:textfield id="jshour" name="jshour" maxlength="5" size="2" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/>时
          <s:textfield id="jsminute" name="jsminute" maxlength="5" size="2" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/> 分</td> 
        </tr>
          <tr id="tr2" style="display:none">
          <td align="right">几号开始：</td>
          <td align="left">
          <s:textfield id="ksHao" name="ksHao" maxlength="5" size="2" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/>日</td>
         <td align="right">几号结束：</td> 
          <td align="left">    
         <s:textfield id="jsHao" name="jsHao" maxlength="5" size="2" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/>日</td> 
        </tr>
        <tr id="tr3" style="display:none">
          <td align="right">开始月日：</td>
         <td align="left"><s:textfield id="ksMonth" name="ksMonth" maxlength="5" size="2" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/>月
          <s:textfield id="ksDay" name="ksDay" maxlength="5" size="2" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/> 日</td> 
        <td align="right">结束月日：</td> 
         <td align="left"><s:textfield id="jsMonth" name="jsMonth" maxlength="5" size="2" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/>月
          <s:textfield id="jsDay" name="jsDay" maxlength="5" size="2" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/> 日 </td> 
       </tr>
          <tr>
	          <td align="right" width="20%">该规则是否启用： </td> 
	          <td colspan="3" align="left">
	          <s:radio name="tsysButtonRule.state" id="state" list="#{'1':'启用','0':'禁用'}" > </s:radio></td>
          </tr>
       
	 <tr> 
            <td>&nbsp;</td>
            <td height="50" colspan="3" align="left"> 
            	<ul class="btn_gn">
    			<li><a href="#" title="提交" onClick="dosave();" ><span>保存</span></a></li>
	    		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	    	</ul>
          </td>
       </tr>
	</table>
</fieldset>

		</td>
       </tr>
</table>
		
  </s:form>
</div>
  </body>
</html>




