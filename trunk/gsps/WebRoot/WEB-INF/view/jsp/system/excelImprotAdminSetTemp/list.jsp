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
		<link rel="stylesheet"
			href="<s:property value="basePath"/>/resources/css/webface.css"
			type="text/css">
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	
	<script type="text/javascript">
	listPageStyle();	
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

<div id="listC" style="text-align:center;">
<s:form theme="simple" name="theform">
<s:hidden name="pager.formname" value="theform"/>
    
<!-- 按钮 -->
<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%"><tr><td height="30px" colspan="10">
				  <ul class="btn_gn">
				    <li><a href="#" title="新增模板项" onClick="input();"><span>新增模板项</span></a></li>
				    <li><a href="#" title="修改模板项" onClick="modifySelected();"><span>修改模板项</span></a></li>
				    <li><a href="#" title="删除模板项" onClick="submitRemove();"><span>删除模板项</span></a></li>				     
				  </ul>
</td></tr></table>
<!-- 按钮结束 -->
<!-- 表头外圈样式 start -->
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB"><tr><td class="infomainbg">
<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td width="10">&nbsp;</td>
<td>&nbsp;</td></tr><tr><td width="10">&nbsp;</td><td>
<!-- 表头外圈样式 end -->

    	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%"  class="middle">
    		<thead id="listHead">
    		<tr>
    			<th height="20px" width="5%"><s:checkbox name="selectAll" onclick="doSelectAll();"/></th>
    			<th>模板标示号</th>
    			<th>模板名称</th>
    			<th>对应表名</th>  
    			<th>操作</th>  			   			
    		</tr>
    		</thead>
    		<tbody id="listData">
    		<s:iterator value="resultData" status="stat">
    		<tr>
    			<td ><s:checkbox id="%{resultData[#stat.index][0]}" name="selectNode" fieldValue="%{resultData[#stat.index][0]}"/></td>
    			<td>
    				&nbsp;<s:property value="%{resultData[#stat.index][0]}"/>
    			</td>
    			<td>
    				&nbsp;<s:property value="resultData[#stat.index][1]"/>
    			</td>    			
    			<td>
    				&nbsp;<s:property value="resultData[#stat.index][2]"/>
    			</td>   
    			<td>
    				&nbsp;<a href="javascript:openWindow('./excelImportAdminSetup-input.c?tempID=<s:property value="%{resultData[#stat.index][0]}"/>',1024,500)">编辑模板</a>
    			</td>			
    		</tr>
    	</s:iterator>
    		</tbody>
    	</table>   	

<!-- 表 底外圈样式 start -->   	
</td></tr></table></td><td width="10" class="infomainright">&nbsp;</td></tr><tr><td height="20" class="infobottomleft"></td><td width="10" class="infobottomright"></td></tr></table>
<!-- 表 底外圈样式 end --> 
<!-- 分页标签 start -->   	
<table border="0" cellspacing="0" cellpadding="0" width="90%"><tr><td colspan="10" align="right"><s:property value="pager.postToolBar" escape="false"/></td>
</tr></table>
<!-- 分页标签 end -->
    	</s:form>
    </div>
  </body>
</html>
