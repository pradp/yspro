<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet"
			href="<s:property value="basePath"/>/resources/css/zxdk.css"
			type="text/css">
		<script type="text/javascript"
			src="<s:property value="basePath"/>/dwr/engine.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
        <script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/sydHtslService.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/myutil.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/zxdk.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>

		<script type="text/javascript">
	listPageStyle();
	function doreset(){
  	
        document.getElementById("departname").value="";
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
    <s:hidden name="dwlx" />
    <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="80%">
	<tr align="center">
	<td align="right" nowrap="nowrap" class="">
							单位名称:
						</td>
						<td align="left">
							<s:textfield name="tsysDepart.departname" id="departname" maxlength="8"
								size="30" />
						</td>
                       <td align="center" nowrap="nowrap">
							&nbsp;
							<input type="button" id="searchButton" name="btn3" value=" 查询 "
								onClick="document.forms[0].submit();">
							<input type="button" id="searchButton2" name="btn4" value=" 重置 "
								onClick="doreset();">
						</td>						
	</tr>

		</table>	
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="90%">
    		<tr>
    			<td height="30px" colspan="10">
    	        <input name="create0" value="新增下级单位信息" type="button" onclick="input('',false,'dwlx=<s:property value="dwlx"/>');"/>&nbsp;
	    		<input name="modifyStudent" value="修改单位信息" type="button" onclick="modifySelected()"/>&nbsp;&nbsp;&nbsp;
    		    <input name="removeRows" value=" 删除 " type="button"  onclick="submitRemove()" />
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	     </td>
    	     
    		</tr>
  
    	</table>
    	<table id="listTable" border="1" cellspacing="0" cellpadding="0" width="90%">
    		<thead id="listHead">
  				<tr>
    			<td height="20px" width="5%"></td>
    	      <td width="12%" align="left"  ><div align="left">登录用户名1</div></td>
    			<td width="20%">单位名称</td>
    			<td width="10%">上级单位</td>  			
    			<td width="10%">联系人姓名</td> 
    			<td width="10%">联系人电话</td>     			
 		     	<td width="6%">层次</td>    	
 		     	<td width="10%">增加</td>     
	     	    <td width="10%">删除</td>    		     			     		 			
    		</tr>
    	 </thead>
    	<tbody id="listData">
 	<s:iterator value="resultData">
    		<tr>
      			<td ><s:checkbox id="%{departid}" name="selectNode" fieldValue="%{departid}"/></td>
    			 	     
    			<td  align="left" >
    			<s:if test="cc==1">
    			<div align="left">
     				<a href="javascript:input('<s:property value="departid"/>',false,'dwlx=<s:property value="dwlx"/>')"><s:property value="departid"/></a></div>
                     </s:if>
                <s:if test="cc==3">
    			<div align="left">
     				<a href="javascript:input('<s:property value="departid"/>',false,'dwlx=<s:property value="dwlx"/>')"><s:property value="departid"/></a></div>
                     </s:if>      
               <s:if test="cc==4">
    			<div align="left">
     				<label style=" font=20px">┝</label><a href="javascript:input('<s:property value="departid"/>',false,'dwlx=<s:property value="dwlx"/>')"><s:property value="departid"/></a></div>
                     </s:if>   
                <s:if test="cc==5">
    			<div align="left">
     			<label style=" font=20px">&nbsp;&nbsp;&nbsp;&nbsp;┝</label><a href="javascript:input('<s:property value="departid"/>',false,'dwlx=<s:property value="dwlx"/>')"><s:property value="departid"/></a></div>
                     </s:if>                                                          
    			</td>
    			<td> 
    			    <s:if test="cc==3">
    			      	<div align="left" ><label style=" font=10px">
    			 	&nbsp;</label><s:property value="departname"/></div>
                   </s:if> 
    			    <s:if test="cc==4">
    			      	<div align="left" ><label style=" font=20px">
    			 	&nbsp;┝</label><s:property value="departname"/></div>
                   </s:if> 
    	       	      <s:if test="cc==5">
    			      	<div align="left" ><label style=" font=20px">
    			 	 &nbsp;&nbsp;&nbsp;&nbsp;┝</label><s:property value="departname"/></div>
                    </s:if> 
    	          </td>
    			<td>&nbsp;<s:property value="updepartid"/></td>     
    			 <td>&nbsp;<s:property value="linkname"/></td>     		
    			 <td>&nbsp;<s:property value="departtype"/></td>          	
    			 <td>&nbsp;<s:property value="cc"/></td>   	
    			 <td  align="left" >
        			  <s:if test="cc==4||cc==3">
    			     <a href="javascript:input('',true,'dwlx=<s:property value="departid"/>#<s:property value="departtype"/>')">增加下级部门</a>
                     </s:if>		
                 </td>   	
    			 <td  align="left" >
        			 <a href="javascript:input('',true,'<s:property value="departid"/>')">删除</a>
                    
                 </td>                   		  						      			
    		</tr>
    	</s:iterator>
    		  </tbody>
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

