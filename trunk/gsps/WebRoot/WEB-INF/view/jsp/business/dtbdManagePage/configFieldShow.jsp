<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>配置导入规则</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/idcard.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.bgiframe.min.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.ajaxQueue.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/thickbox-compressed.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.css">
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/lib/thickbox.css">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
	<script type="text/javascript">
	listPageStyle();
	detailPageStyle();	
	function submitForm(){		
		super_submitForm("configFieldShow");
	}	
	</script>
  </head>
  
<body> 
<!-- header start -->
<s:if test="actionErrors.size()> 0 || actionMessages.size()>0 || fieldErrors.size()>0">
<div id="SystemErrorMessage">
<s:actionerror />
<s:actionmessage />
<s:fielderror />
</div>
</s:if>
<!-- header end -->
    <div id="listC" style="text-align:left;">
    <s:form theme="simple" name="theform" id="theform">
    <s:hidden name="tempID" value="%{tempID}"/>
    <s:hidden name="pager.formname" value="theform"/>  
        
<!-- 表头外圈样式 start -->
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB"><tr><td class="infomainbg">
<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td width="10">&nbsp;</td>
<td>&nbsp;</td></tr><tr><td width="10">&nbsp;</td><td>
<!-- 表头外圈样式 end -->
       
    	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="95%"  class="middle">
    		<thead id="listHead">
    		<tr>     			
    			<th>显示名称</th>
    			<th>宽度(px)</th>
    			<th>索引</th>
    		</tr>
    		</thead>
    		<tbody id="listData">
    	<s:iterator value="listField" status="stat">    		
    	<s:set name="bean" value="listField[#stat.index]" />
    		<tr>
    			<td><s:property value="#bean.fieldDisplayName"/><s:hidden name="listField[%{#stat.index}].wid"/><s:hidden name="listField[%{#stat.index}].fieldDisplayName"/></td>
    			<td><s:textfield name="listField[%{#stat.index}].fieldWidth" size="10"/></td>
    			<td><s:textfield name="listField[%{#stat.index}].fieldOrder" size="13"/></td>    			
    		</tr>
    	</s:iterator>   	 
    	   		
    		</tbody>
    	</table>     
    	
 <!-- 表 底外圈样式 start -->   	
</td></tr></table></td><td width="10" class="infomainright">&nbsp;</td></tr><tr><td height="20" class="infobottomleft"></td><td width="10" class="infobottomright"></td></tr></table>
<!-- 表 底外圈样式 end -->       
	   
<!-- button -->
 <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle">	   
	    <td height="30" colspan="7">
	    	    
<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="26%"><tr><td height="30px" width="440px">
	<ul class="btn_gn">										
		<li>
			<a href="#" title="确定" onClick="submitForm();" id="sendMsgButton"><span>确定</span> </a>
		</li>
		<li>
			<a href="#" title="关闭" onClick="parent.closeInputWindow();" id="sendMsgButton"><span>关闭</span> </a>
		</li>																															
	</ul>
</td></tr></table>

			</td>
	  </tr>
  </table>
<!-- button -->   
   	
    	</s:form>
    </div>
  </body>
</html>