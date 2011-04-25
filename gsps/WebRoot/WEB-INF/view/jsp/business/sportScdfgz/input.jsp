<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>list</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<style type="text/css">
	body{background: #f1f1f1 repeat-x left top;}
	</style>
	<script type="text/javascript">
	listPageStyle();
	function dosave(){
		if(isValidateForm()){
			submitForm();
			}
	}
	function document.onkeydown(){ 
		var e = window.event; 
		if(e.keyCode==13 && e.srcElement.type != 'button'){ 
		e.keyCode = 9; 
		return; 
		} 
	} 
	</script>
  </head>
  
<body topmargin="0" leftmargin="0" onload="loading();"> 


    <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform">
    <s:hidden name="ListSportScdfgz_size" id="ListSportScdfgz_size" value="%{ListSportScdfgz.size()}" />
    <s:hidden name="type" id="type_id" value="%{#type}" />
    
    	<%-- 4表示青管中心 --%>
    	<s:if test="getLoginUser().getUsertype()!=4" > 
    	<table width="100%" border="0" align="center">
		<tr align="center" valign="middle">
			<td height="30" colspan="7">
				<ul class="btn_gn">
		    			<li><a href="#" title="保存" onclick="dosave()"><span>保存</span></a></li>
		    		</ul>
			</td>
		</tr>
	</table>
	</s:if>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB"  align="left">
	  <tr>
	    <td class="infomainbg">	
	    
		<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>
    	
      <table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
    		
    		<thead id="listHead">	
    		<tr>
			   		 <th height="20px" width="3%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
			  		 <th>排名级别</th>
			  		 <th>排名得分</th>
			  		 <th>排名金牌数</th>
			  		 <th>排名银牌数</th>
			  		 <th>排名铜牌数</th>
			  		 <th>是否递减规则</th>
			 	</tr>
    		</thead>
    		<tbody id="listData">
    		<s:iterator value="listSportScdfgz" status="status">
    		<s:hidden name="listSportScdfgz[%{#status.index}].wid" id="wid" value="%{listSportScdfgz[#status.index].wid}" />
    		<s:hidden name="listSportScdfgz[%{#status.index}].pmjb" id="pmjb_id" value="%{listSportScdfgz[#status.index].pmjb}" />
    		<s:hidden name="listSportScdfgz[%{#status.index}].xmbm" id="xmbm_id" value="%{listSportScdfgz[#status.index].xmbm}" />
    		
    		<tr>
    			<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
    			<td>&nbsp;第<s:property value="listSportScdfgz[#status.index].pmjb"/>名</td>
				<td>&nbsp;<s:textfield name="listSportScdfgz[%{#status.index}].pmdf" id="pmdf_id" size="5" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,true);" value="%{listSportScdfgz[#status.index].pmdf}" /></td>
    			<td>&nbsp;<s:textfield name="listSportScdfgz[%{#status.index}].pmjps" id="pmjps_id" size="5" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,true);" value="%{listSportScdfgz[#status.index].pmjps}" /></td>
    			<td>&nbsp;<s:textfield name="listSportScdfgz[%{#status.index}].pmyps" id="pmyps_id" size="5" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,true)" value="%{listSportScdfgz[#status.index].pmyps}" /></td>
    			<td>&nbsp;<s:textfield name="listSportScdfgz[%{#status.index}].pmtps" id="pmtps_id" size="5" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,true);" value="%{listSportScdfgz[#status.index].pmtps}" /></td>
    			<td>&nbsp;<s:radio name="listSportScdfgz[%{#status.index}].sfdjgz"  list="#{'1':'是','0':'否'}" value="%{listSportScdfgz[#status.index].sfdjgz}" /></td>
    	  </tr>
    	</s:iterator>
    		</tbody> 		   
    	</table>
    	
    	    	</td>
	        </tr>
	    </table>		
		</td>
	    <td width="10" class="infomainright">&nbsp;</td>
	  </tr>
	  <tr>
	    <td height="20" class="infobottomleft"></td>
	    <td width="10" class="infobottomright"></td>
	  </tr>
	</table>
    	<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage" style=" float:  left">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
	</s:if>
    	
		
    	</s:form>
    	 
    </div>
   
  </body>
</html>
