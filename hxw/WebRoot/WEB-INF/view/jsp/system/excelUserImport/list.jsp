<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title>list</title>
    <%@include file="../../common/include_list_head.jsp" %>
    <style type="text/css">
	body{font-size:12px;}
	</style>
	<script type="text/javascript">
	function isTrue(){
		return <s:property value="isImport"/>;
	}
	function loading(){
		parent.isSubmitBtn(<s:property value="isImport"/>);
	}
	</script>
  </head>
  
<body topmargin="0" leftmargin="0" onLoad="loading();"> 
    <div id="scrollContent">
		<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
		</s:if>
    <div id="listC" style="text-align:center;">
       <s:form theme="simple" name="ysform">
          <s:hidden name="pager.formname" value="ysform"/>
          <s:hidden name="pager.currentPageno" id="yspager_currentPageno"/>	
          <s:hidden name="importTempID" value="%{importTempID}"/>
          <s:hidden name="filePath" value="%{filePath}"/>
          <s:hidden name="sheetName" value="%{sheetName}"/>
      </s:form>
    <div align="left" >
		<table class="tableStyle" headFixMode="true" useMultColor="false" useCheckBox="false">
    		<tr>
    			<s:iterator id="header" value="headerValue" status="stat">
    				<th height="20px" style="font-size:12px">&nbsp;<s:property value="header"/></th>
    			</s:iterator>   			
    		</tr>
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
    			<tr>    				    			
    				<th height="20px">&nbsp;</th>    				    				
    			</tr>
    			<tr>
    				<td>&nbsp;</td>
    			</tr>
    		</s:else>
    	</table>
    </div>	
		<div style="height: 45px;">
			<div id="pagelist" style="display: none">
	  			<s:property value="pager.postToolBar" escape="false"/>
	  		</div>
	
			<div class="clear"></div>
		</div>
	  </div>
    </div>
  </body>
</html>
