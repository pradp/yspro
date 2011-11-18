<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>导入模板配置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<script type="text/javascript"
			src="<s:property value="basePath"/>/dwr/engine.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
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
	function L(ID){
		return document.getElementById(ID);
	}
	function tableFields(obj){
		var objImportID=obj+'_importField';
		var objExportID=obj+'_exportField';		
		var tableName=L(obj+'_tables').value;	
		showCodeSort(obj);	
		L(objImportID).innerHTML="<option value=\"0\"> - 选择字段 - </option>";
		L(objExportID).innerHTML="<option value=\"0\">- 选择字段 -</option>";		
		ajaxService.getFields(tableName,function(data){
			for(var i in data){
				var opti = document.createElement("option");
				var opte = document.createElement("option");
				opti.text=data[i];
				opti.value=data[i];
				opte.text=data[i];
				opte.value=data[i];
				//$('importField').appendChild(opt);//火狐				
				L(objImportID).add(opti);
				L(objExportID).add(opte);
			}				
		});		
	}
	function showCodeSort(objID){
		var myObj=L(objID+'_tables');
		var codeSort=L(objID+'_replaceField');		
		if(myObj.value=='T_SYS_CODE'){			
			codeSort.removeAttribute('disabled');
		}else{
			codeSort.value="";
			codeSort.setAttribute('disabled','disabled');
		}
	}
	//激活数字字典选项函数
	function intactSelect(objID){		
		var change=L(objID+'_change');		
		var tables=L(objID+'_tables');
		var imp=L(objID+'_importField');
		var exp=L(objID+'_exportField');
		var codeSort=L(objID+'_replaceField');
		if(change.checked){		
			tables.removeAttribute('disabled');
			imp.removeAttribute('disabled');
			exp.removeAttribute('disabled');
		}else{
			tables.setAttribute('disabled','disabled');			
			tables.value="0";
			imp.setAttribute('disabled','disabled');			
			exp.setAttribute('disabled','disabled');
			imp.innerHTML="";
			exp.innerHTML="";
			
			var opti = document.createElement("option");
			var opte = document.createElement("option");
			opti.text="- 选择字段 -";
			opti.value=0;
			opte.text="- 选择字段 -";
			opte.value=0;					
			imp.add(opti);
			exp.add(opte);
			
			codeSort.value="";
			codeSort.setAttribute('disabled','disabled');
		}	
	}
	function submitForm(){
		alert("提交");
		L('theform').submit();
	}
	</script>
  </head>
  
<body> 
  <div id="scrollContent">
    
		<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
		</s:if>
   <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform" action="excelImportAdminSetup-saveValidateFields">
    
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
    
    <s:hidden name="pager.formname" value="theform"/>    
    	<table id="listTable" border="1" cellspacing="0" cellpadding="0" width="100%">
    		<tbody id="listData">
    		
    	<s:iterator value="resultData">    		
    		<tr>
    			<td><s:checkbox id="%{filedName}" name="selectNode" fieldValue="%{filedName}"/></td>
    			<td><s:property value="filedName"/><s:hidden name="%{filedName}_filedName" value="filedName"/></td>
    			<td>
    				<s:textfield name="%{filedName}_fileAlias" value="%{filedAlias}" size="20"/>
    				<s:hidden name="%{filedName}_filedLength" value="filedLength"/>
    				<s:hidden name="%{filedName}_filedType" value="filedType"/>
    				<s:hidden name="%{filedName}_Scale" value="Scale"/>
    				<s:hidden name="%{filedName}_isNull" value="isNull"/>
    			</td>
    			<td>
    				<table>
    					<tr>
    						<td style="width:2%"><s:checkbox id="%{filedName}_change" name="isChange" fieldValue="%{filedName}" onclick="intactSelect('%{filedName}');"/></td>
	    					<td style="width:24%"><s:select name="%{filedName}_tables" id="%{filedName}_tables" list="DBTables" headerKey="0" headerValue="-- 请选择替换表  --" onchange="tableFields('%{filedName}');" value="%{replaceSelectTable}" disabled="true" cssStyle="width:150px"/></td>
	    					<td style="width:26%"><s:select name="%{filedName}_replaceField" id="%{filedName}_replaceField" list="getSysCodeSort()" headerKey="" headerValue="-- 转换类别 --" listKey="id" listValue="caption" disabled="true" cssStyle="width:150px" value="%{replaceField}"/></td>
	    					<td style="width:24%">导入值:	    					
	    					<s:select name="%{filedName}_importField" id="%{filedName}_importField" list="getTableFields(replaceSelectTable)" headerKey="" headerValue="- 选择字段 -" listKey="id" listValue="caption" value="importField" disabled="true" cssStyle="width:100px"></s:select>
	    					</td>
	    					<td style="width:24%">替换值:	    					
	    					<s:select name="%{filedName}_exportField" id="%{filedName}_exportField" list="getTableFields(replaceSelectTable)" headerKey="" headerValue="- 选择字段 -" listKey="id" listValue="caption" value="exportField" disabled="true" cssStyle="width:100px"></s:select> 
	    					</td>	    									    				
	    				</tr>
    				</table>
    			</td>
    			<td><s:checkbox id="%{filedName}_isOnly" name="%{filedName}_isOnly" fieldValue="%{isOnly}"/></td>
    			<td><s:textfield id="%{filedName}_serialNumber" name="%{filedName}_serialNumber" value="%{serialNumber}" size="1"/></td>
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
    	
    	<table border="0" cellspacing="0" cellpadding="0" width="90%">
    		<tr>
    			<td colspan="10" align="right">
    			<s:property value="pager.postToolBar" escape="false"/>
    			</td>
    		</tr>
    	</table>
    	</s:form>
     </div>
     <div style="height: 45px;">
			<div id="pagelist" style="display: none">
	  			<s:property value="pager.postToolBar" escape="false"/>
	  		</div>
	
			<div class="clear"></div>
		</div>
	</div>
  </body>
</html>
