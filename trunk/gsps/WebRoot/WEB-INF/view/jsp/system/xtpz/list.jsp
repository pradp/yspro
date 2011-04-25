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
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript">
	listPageStyle();
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
	}
	function ajaxBackString(result){
		var flag=result.split(":")[0];
		if(flag=='true')
		{	
			alert('刷新成功！');
		}else {
			alert('失败信息：'+result.split(":")[1]);
		}
		}
	</script>
  </head>
<body > 
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

    <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%" class="maginB">
			<tr align="center">
				
			</tr>
	</table>
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
    		<tr>
    			<td height="30px" colspan="10">
    			<ul class="btn_gn">
			    <li><a href="#" title="新增参数" onClick="input();" name="create0"><span>新增参数</span></a></li>
			    <li><a href="#" title="修改参数" onClick="modifySelected()"  name="modifyStudent"><span>修改参数</span></a></li>
			    <li><a href="#" title="删除" onClick="submitRemove()" name="removeRows"><span>删除</span></a></li>
			    <li><a href="#" title="刷新内存数据" onClick="doRefreshSysProp()" name="doRefreshSysProp"><span>刷新内存数据</span></a></li>
			</ul>
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
    			<th height="20px" width="5%"></th>
 		        <th width="20%">参数名称</th>
    			<th width="20%">参数</th>
    			<th width="20%">参数值</th>
    			<th width="10%">参数类型</th>    			
    			<th width="10%">参数说明</th> 
    		</tr>
    		</thead>
    		<tbody id="listData">
 	<s:iterator value="resultData">
    		<tr>
     			<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
    			<td>
    				&nbsp;<a href="javascript:input('<s:property value="wid"/>',true)"><FONT color="blue"><s:property value="csfl"/></FONT></a>
    			</td>
      			<td>&nbsp;<s:property value="csmc"/></td>       
      			<td>&nbsp;<s:property value="cs"/></td>       		   			       			    		    
    			 <td>&nbsp;<s:property value="cslx"/></td>     		
    			 <td>&nbsp;<s:property value="cssm"/></td>       				   			  						      			
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

