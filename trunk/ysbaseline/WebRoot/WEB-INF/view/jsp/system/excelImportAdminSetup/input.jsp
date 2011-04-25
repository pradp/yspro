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
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
	<script type="text/javascript">
	listPageStyle();
	detailPageStyle();
	function L(ID){
		return document.getElementById(ID);
	}
	function tableFields(obj){
		var objImportID=obj+'_importField';
		var objExportID=obj+'_exportField';		
		var tableName=L(obj+'_tables').value;	
		showCodeSort(obj);	
		//L(objImportID).innerHTML="<option value=\"0\"> - 选择字段 - </option>";
		//L(objExportID).innerHTML="<option value=\"0\">- 选择字段 -</option>";
		//alert(L(objImportID).options.length);	
		while(L(objImportID).options.length>0){
			L(objImportID).options.remove(0);
		}		
		//alert(L(objExportID).options.length);	
		while(L(objExportID).options.length>0){
			L(objExportID).options.remove(0);
		}		
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
		//document.getElementById('import').value=parent.document.getElementById('import').value;
		//alert(document.getElementById('import').value);
		//document.getElementById('className').value=parent.document.getElementById('className').value;
		//alert(document.getElementById('className').value);
		super_submitForm();
	}
	function isCheckBox(obj){		
		if(obj.checked){
			obj.value=1;
			alert(obj.value);
		}else{
			obj.value=2;
		}
	}
	function editRow(testid,checkid,selectid){
		if(!document.getElementById(testid).disabled){
			document.getElementById(testid).disabled=true;
			document.getElementById(checkid).disabled=true;
			document.getElementById(checkid).checked=false;
			intactSelect(selectid);
		}else{
			document.getElementById(testid).disabled=false;
			document.getElementById(checkid).disabled=false;			
		}		
	}
	function loading(){
		parent.setAddInfo('<s:property value="%{#request.importrow}"/>','<s:property value="%{#request.classname}"/>');
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
    
    <table>
		<tr>
			<td style="padding-left: 17px">导入Excel从第几行开始：</td>
			<td><s:textfield id="import" name="import" value="%{#request.importrow}" size="5" maxlength="10" onkeypress="NumberText(event,false,false);"/></td>
			<td style="padding-left: 10px">设置处理服务类：</td>
			<td><s:textfield id="className" name="className" value="%{#request.classname}" size="60" maxlength="200"/></td>
		</tr>
	</table>
    
<!-- 表头外圈样式 start -->
<!--table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB"><tr><td class="infomainbg">
<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td width="10">&nbsp;</td>
<td>&nbsp;</td></tr><tr><td width="10">&nbsp;</td><td-->
 <fieldset> 
　 <legend>导入字段设置</legend>
<!-- 表头外圈样式 end -->
       
    	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="96%"  class="middle" align="center">
    		<thead id="listHead">
    		<tr>    			
    			<th style="width:6%;height:3px;text-align: right">导入</th>
    			<th style="width:6%;text-align: left">&nbsp;&nbsp;&nbsp;&nbsp;字段</th>
    			<th style="width:12%">标题名称</th>
    			<th style="width:74%">数字字典转换</th>
    			<th style="width:7%">必填</th>
    			<!--th>必转</th-->
    			<th style="width:7%">列序</th>
    		</tr>
    		</thead>
    		<tbody id="listData">    		
    	<s:iterator value="listInfo" status="stat">    		
    		<tr>
    			<td><s:checkbox id="%{filedName}" name="listInfo[%{#stat.index}].isImportField" value="%{filedAlias!=null&&filedAlias!=\"\"?true:false}" onclick="editRow('listInfo[%{#stat.index}].filedAlias','%{filedName}_change','%{filedName}');"/></td>
    			<td><s:property value="filedName"/></td>
    			<td>
    				<s:hidden name="listInfo[%{#stat.index}].filedName" value="%{filedName}"/>
    				<s:textfield disabled="%{(filedAlias!=null&&filedAlias!=\"\")?false:true}" id="listInfo[%{#stat.index}].filedAlias" name="listInfo[%{#stat.index}].filedAlias" value="%{filedAlias}" size="6"/>
    				<s:hidden name="listInfo[%{#stat.index}].filedLength" value="%{filedLength}"/>
    				<s:hidden name="listInfo[%{#stat.index}].filedType" value="%{filedType}"/>
    				<s:hidden name="listInfo[%{#stat.index}].Scale" value="%{Scale}"/>
    				
    			</td>
    			<td>
    				<table>
    					<tr>
    						<td style="width:2%"><s:checkbox id="%{filedName}_change" disabled="%{(filedAlias!=null&&filedAlias!=\"\")?false:true}" name="isChange" value="%{replaceSelectTable!=null?true:false}" onclick="intactSelect('%{filedName}');"/></td>
	    					<td style="width:24%"><s:select name="listInfo[%{#stat.index}].replaceSelectTable" id="%{filedName}_tables" list="DBTables" headerKey="0" headerValue="-- 请选择替换表  --" onchange="tableFields('%{filedName}');" value="%{replaceSelectTable}" disabled="%{replaceSelectTable!=null?false:true}" cssStyle="width:150px"/></td>
	    					<td style="width:26%"><s:select name="listInfo[%{#stat.index}].replaceField" id="%{filedName}_replaceField" list="getSysCodeSort()" headerKey="" headerValue="-- 转换类别 --" listKey="id" listValue="caption" cssStyle="width:150px" value="%{replaceField}" disabled="%{replaceField!=null?false:true}"/></td>
	    					<td style="width:24%">导入值:	    					
	    					<s:select name="listInfo[%{#stat.index}].importField" id="%{filedName}_importField" list="getTableFields(replaceSelectTable)" headerKey="" headerValue="- 选择字段 -" listKey="id" listValue="caption" value="importField" disabled="%{importField!=null?false:true}" cssStyle="width:100px"></s:select>
	    					</td>
	    					<td style="width:24%">替换值:	    					
	    					<s:select name="listInfo[%{#stat.index}].exportField" id="%{filedName}_exportField" list="getTableFields(replaceSelectTable)" headerKey="" headerValue="- 选择字段 -" listKey="id" listValue="caption" value="exportField" disabled="%{exportField!=null?false:true}" cssStyle="width:100px"></s:select> 
	    					</td>	    									    				
	    				</tr>
    				</table>
    			</td>
    			<td><s:checkbox id="%{filedName}_isNull" name="listInfo[%{#stat.index}].isNull" disabled="false" value="%{!isNull}"/></td>
    			<!-- td><s:checkbox id="%{filedName}_isOnly" name="listInfo[%{#stat.index}].isOnly" disabled="false" value="%{isOnly}"/></td-->
    			<td><s:textfield id="%{filedName}_serialNumber" name="listInfo[%{#stat.index}].serialNumber" value="%{serialNumber}" size="1"/></td>
    		</tr>
    	</s:iterator>
    	    	    	
    		</tbody>
    	</table>     
    	
 <!-- 表 底外圈样式 start -->   
  </fieldset>	
<!--/td></tr></table></td><td width="10" class="infomainright">&nbsp;</td></tr><tr><td height="20" class="infobottomleft"></td><td width="10" class="infobottomright"></td></tr></table-->
<!-- 表 底外圈样式 end -->    	
	   
<table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle">	   
	    <td height="30" colspan="7">
   	
<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="26%"><tr><td height="30px" width="440px">
<ul class="btn_gn"><li><a href="#" title="保存" onClick="submitForm();" id="sendMsgButton"><span>保存</span> </a></li>
<li><a href="#" title="取消" onclick="parent.closeInputWindow();"><span>关闭</span></a></li></ul>	
</td></tr></table>

			</td>
	  </tr>
  </table>
   	
    	</s:form>
    </div>
  </body>
</html>