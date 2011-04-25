<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <title>打印运动员二次报名项目</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript">
	detailPageStyle();
	var objid = parent.tem_valueObjid;
	var objname = parent.tem_nameObjid;
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
	}

	function printForm(){
		var conf = document.getElementById("buttonTable").style.display="none"
		if(conf){
			window.print();
			}
		return false;
	}
</script>
  </head>
<body onload="getzy()"> 
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" >
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>
   <div class="framestyle" style="width:100%;padding: 0pt 10pt 10pt 10pt;">
    <s:form name="theform" method="post" theme="simple" >
    <s:hidden name="wid" id="ydyid" />
    <s:hidden name="tsportBsxm.wid" />
    <s:hidden name="xm" id="xm"/>
  	<s:hidden name="cd" value="%{#parameters.cd[0]}" id="cd" />
    <s:hidden name="pager.formname" value="theform"/>
    <fieldset>
    <legend><s:property value="xm"/> 二次报名项目 </legend>
	<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%" class="maginB">
			<tr align="center">
				
			</tr>
	</table>	
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
    		<tr>
			    <td>
				    <input type="button" value=" 确认打印 " onclick="printForm()" />
					&nbsp;&nbsp;&nbsp;
				    &nbsp;&nbsp;&nbsp;
					<input type="button" value=" 取消打印 " onclick="parent.closeInputWindow();"/>
				</td>
	     	</tr>    
    	</table>
  
  	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB" >
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
    			<th height="20px" width="5%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
 		        <th width="10%">项目</th>
 		        <th width="10%">性别组</th>
 		        <th width="10%">组别</th>
    			<th width="30%">级（赛）别</th>
    		</tr>
    		</thead>
    		<tbody id="listData"><% int i=0; %>
 			<s:iterator value="#lists"><%--lists 用于在页面上把后台的数据显示出来--%>
 			<%i=0; %>
 				<tr>
 					<s:iterator value="#lists1" status="sts">
    					<s:if test="%{#lists1[#sts.index][3].toString()==wid}">
    						<% i=1; %>
    					</s:if>
    				</s:iterator>
    				<%
    					if(i==1){
    						%>
    						<td ><input type="checkbox"  id="<s:property value='wid' />" name="selectNode" value="<s:property value='wid' />" checked="checked"  /></td>
    						<%
    					}else{
    						%>
    						<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
    						<%
    					}
    				%>
		      		<td id="dxmmc_<s:property value='wid'/>" ><s:property value="dxmmc" /></td> 
	      			<td id="xbz_<s:property value='wid'/>"><s:property value="xbz"/></td> 
	      			<td id="zb_<s:property value='wid'/>"><s:property value="zb"/></td>
	      			<td id="xxmmc_<s:property value='wid'/>"><s:property value="xxmmc"/></td>       		   			       			    		    
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
    	</fieldset>
    	<br/>
    	</s:form>
    </div>
  </body>
</html>

