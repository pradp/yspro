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
	function isTrue(){
		return <s:property value="isImport"/>;
	}
	function loading(){
		parent.isSubmitBtn(<s:property value="isImport"/>);
	}
	</script>
  </head>
  
<body topmargin="0" leftmargin="0" onload="loading();"> 

		<s:if
			test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
		</s:if>


    <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform">
    <s:hidden name="pager.formname" value="theform"/>    	
    <s:hidden name="importTempID" value="%{importTempID}"/>
    <s:hidden name="filePath" value="%{filePath}"/>
    <s:hidden name="sheetName" value="%{sheetName}"/>
    
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
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
    			<s:iterator id="header" value="headerValue" status="stat">
    				<th height="20px">&nbsp;<s:property value="header"/></th>
    			</s:iterator>   			
    		</tr>
    		</thead>
    		<tbody id="listData">
    		<s:if test="%{#content.size()>0}">    		
    		<s:iterator id="sub" value="content">
    			<tr>
    			<s:iterator id="text" value="sub">
    				<td>&nbsp;<s:property value="text"/></td>
    			</s:iterator>
    			</tr>
    		</s:iterator>
    		</s:if>  
    		<s:elseif test="%{#headerValue.size()>0}">
    		<tr>
    			<s:iterator id="header" value="headerValue" status="stat">
    				<td height="20px">&nbsp;</td>
    			</s:iterator>
    		</tr>
    		</s:elseif>    		
    		<s:else>
    		<thead id="listHead">
    			<tr>    				    			
    				<th height="20px">&nbsp;</th>    				    				
    			</tr>
    		</thead>
    		<tbody id="listData">
    			<tr>
    				<td>&nbsp;</td>
    			</tr>
    		</tbody>
    		</s:else>
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
    	
    	
		<table border="0" cellspacing="0" cellpadding="0" width="90%">
    		<tr>
    			<td colspan="10" align="right">
    			<s:property value="pager.postToolBar" escape="false"/>
    			</td>
    		</tr>
    	</table>
    	</s:form>
    </div>
  </body>
</html>
