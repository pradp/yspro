<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
	listPageStyle();
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
   <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform">
    <s:hidden name="pager.formname" value="theform"/>
    <input type="hidden" value="<s:property value="tsportCjYdy.xxmmc" />" id="xxmmc_later" />
	<input type="hidden" value="<s:property value="tsportCjYdy.zb" />" id="zb_later" />
	<input type="hidden" value="<s:property value="tsportCjYdy.xbz" />" id="xbz_later" />
  		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
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
	    			<th width="40%">项目</th>
	    			<th width="10%">时间</th>
	    			<th width="10%"></th>
	    			<th width="10%">金牌</th>
	    			<th width="10%">银牌</th>
	    			<th width="10%">铜牌</th>
	    			<th width="10%">得分</th>
    			</tr>
    		</thead>
    		<tbody id="listData">
    		<s:iterator value="resultData" status="status">
		    		<tr>
     			  		 <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][0]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][1]" /></td>
                         <td style="vertical-align:middle">
                         	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
                         		<tr><td>赛程</td></tr>
                         		<tr><td>实际</td></tr>
                         	</table>
                         </td>
                         <td style="vertical-align:middle">
                         	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
                         		<tr><td><s:property value="resultData[#status.index][2]" /></td></tr>
                         		<tr><td><s:property value="resultData[#status.index][6]" /></td></tr>
                         	</table>
                         </td>
                         <td style="vertical-align:middle">
                         	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
                         		<tr><td><s:property value="resultData[#status.index][3]" /></td></tr>
                         		<tr><td><s:property value="resultData[#status.index][7]" /></td></tr>
                         	</table>
                         </td>
                         <td style="vertical-align:middle">
                         	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
                         		<tr><td><s:property value="resultData[#status.index][4]" /></td></tr>
                         		<tr><td><s:property value="resultData[#status.index][8]" /></td></tr>
                         	</table>
                         </td>
                         <td style="vertical-align:middle">
                         	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
                         		<tr><td><s:property value="resultData[#status.index][5]" /></td></tr>
                         		<tr><td><s:property value="resultData[#status.index][9]" /></td></tr>
                         	</table>
                         </td>
                         
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
	
    	<table border="0" cellspacing="0" cellpadding="0" width="100%">
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

