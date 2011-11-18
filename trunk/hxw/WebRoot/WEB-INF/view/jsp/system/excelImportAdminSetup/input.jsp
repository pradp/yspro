<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
	<%@include file="../../common/Include_input_head.jsp" %>
    <title>配置导入规则</title>
	
	<script type="text/javascript">
	detailPageStyle();
	$(function(){
		//初始化全选按钮 
		$(".tableStyle tr:eq(0) th:eq(0)")
			.html('<input type="checkbox" name="selectAll" value="true" id="selectAll" onclick="doSelectAllOne(this)"/>');
		//初始化列序和是否必填 
		$("input[type='checkbox'][name$='.isImportField']").each(function(){
			if($(this).attr("checked")){
				$(this).parent().parent().find("input[readonly]").attr("readonly","");
				$(this).parent().parent().find("input[disabled][type='checkbox']").attr("disabled","");
			}else{
				$(this).parent().parent().find("input[readonly]").attr("readonly","readonly");
				$(this).parent().parent().find("input[disabled][type='checkbox']").attr("disabled","disabled");
			}
			$(this).click(function(){
				doselectAllState();
			})
		})
		$("select[id$='_replaceField']").each(function(){
			if($(this).parent().prev("td").prev("td").find("input[type='checkbox']").attr("checked")){
				if($(this).parent().prev("td").find("select").val() == 'T_SYS_CODE'){
					$(this).next("span").find("select").hide();
				}else{
					$(this).hide();
				}
			}else{
				$(this).hide();
			}
		})
		//初始化列序值 
		$("input[id$='_serialNumber']").val(function(){
			if($(this).val()=='0'){
				return '';
			}else{
				return $(this).val();
			}
		})
		doselectAllState();
    });
	//改变全选按钮的状态 
	function doselectAllState(){
		var number_checkbox = 0;
		var number_checked = 0;
		$("input[type='checkbox'][name$='.isImportField']").each(function(i){
			if(this.checked){
				number_checkbox++; 
				number_checked++;
			}else{
				number_checkbox++; 
			}
		})
		var selectAll = $("#selectAll")[0];
		if(number_checked==number_checkbox && number_checked!=0){
			selectAll.indeterminate = false;
			selectAll.checked = true;
		}else if(number_checked == 0){
			selectAll.indeterminate = false;
			selectAll.checked = false;
		}else{
			selectAll.indeterminate = true;
		}
	}
	//点击全选按钮时触发 
	function doSelectAllOne(obj){ 
		$(".tableStyle[id='execlImport_table'] tr:not(:eq(0))").each(function(i){
		  if($(this).find("td:eq(0) input[type='checkbox']").attr("checked")!=obj.checked){
    		$(this).find("td:eq(0) input[type='checkbox']").attr("checked",obj.checked);
    		var name_ = $(this).find("td:eq(0) input[type='checkbox']").attr("name");
    		var id_ = $(this).find("td:eq(0) input[type='checkbox']").attr("id");
    		editRow(name_.substr(0,name_.indexOf('.'))+'.filedAlias',id_+'_change',id_);
    	  }
		})
	}
	function L(ID){
		return document.getElementById(ID);
	}
	function tableFields(obj){
		var tableName=L(obj+'_tables').value;	
		showCodeSort(obj);
		if(tableName != 'T_SYS_CODE'){
			var url = "<s:property value="basePath"/>/jsonVisitor/ajaxSys-getFields.action?"+(new Date()).getTime();
			$.getJSON(url, {tableName: tableName}, function(data){
				var fields = data.datamap.fields;
				changeSelectOption(fields, obj+'_importField','','','100',true);
				changeSelectOption(fields, obj+'_exportField','','','100',true);
				$("#"+obj+"_importField").attr("disabled","");
				$("#"+obj+"_exportField").attr("disabled","");
			});
		}
	}
	function showCodeSort(objID){
		var myObj=L(objID+'_tables');
		var codeSort=L(objID+'_replaceField');		
		if(myObj.value=='T_SYS_CODE'){		
			$("#"+objID+"_replaceField").show();
			$("#"+objID+"_replaceField").attr("disabled","");
			$("#"+objID+"_importField").val("");
			$("#"+objID+"_importField").hide();
			$("#"+objID+"_exportField").attr("disabled","disabled");
		}else{
			$("#"+objID+"_replaceField").val("");
			$("#"+objID+"_replaceField").hide();
			$("#"+objID+"_importField").show();
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
			tables.value="";
			
			$("#"+objID+"_replaceField").hide();
			$("#"+objID+"_importField").show();
			var option_value= "[{id:'',caption:'---导入值---'}]";
			changeSelectOption(option_value, objID+'_importField','','','100',true);
			option_value= "[{id:'',caption:'---替换值---'}]";
			changeSelectOption(option_value, objID+'_exportField','','','100',true);
			$("#"+objID+'_importField').attr('disabled','disabled');
			$("#"+objID+'_exportField').attr('disabled','disabled');
			
			$("#"+objID+'_replaceField').val("");
			$("#"+objID+'_replaceField').hide();
		}	
	}
	function submitForm(){		
		if (super_doSave_validateForm(true)) {
			var success = true;
			$(".tableStyle tr:not(:eq(0))").each(function(i){
			  if($(this).find("td:eq(0) input[type='checkbox']").attr("checked")){
				if($(this).find("input[name$='.filedAlias']").val() == ''){
					alert("标题名称不能为空 ！");
					success = false;
					return false;
				}
				if($(this).find("input[type='checkbox'][id$='_change']").attr("checked")){
					if($(this).find("select[id$='_tables']").val()==''){
						alert("转换表不能为空！");
						success = false;
						return false;
					}else{
						if($(this).find("select[id$='_tables']").val()=='T_SYS_CODE'){
							if($(this).find("select[id$='_replaceField']").val()==''){
								alert("字典类别不能为空！");
								success = false;
								return false;
							}
						}else{
							var importField = $(this).find("select[id$='_importField']").val();
							var exportField = $(this).find("select[id$='_exportField']").val();
							if(importField==''){
								alert("导入值不能为空！");
								success = false;
								return false;
							}
							if(exportField==''){
								alert("替换值不能为空！");
								success = false;
								return false;
							}
							if(exportField==importField){
								alert("替换值不能与导入值相同！");
								success = false;
								return false;
							}
						}
					}
				}
				if($(this).find("input[id$='_serialNumber']").val() == ''){
					alert("排序值不能为空 ！ ");
					success = false;
					return false;
				}
	    	  }
			})
			if(success){
				super_doSave();
			}
		}
	}
	function checkordernum(obj){
		$("input[type='text'][id$='_serialNumber']").each(function(){
			if($(this).val() != '' && this!=obj && $(this).val() == obj.value){
				alert('列序不能重复！');
				obj.value = '';
				$(obj).focus();
				return false;
			}
		})
	}
	function editRow(testid,checkid,selectid){
		if(!document.getElementById(testid).disabled){
			$("input[id='"+testid+"']").val("");
			document.getElementById(testid).disabled=true;
			document.getElementById(checkid).disabled=true;
			document.getElementById(checkid).checked=false;
			intactSelect(selectid);
			$("#"+selectid+"_isNull").attr("checked","");
			$("#"+selectid+"_isNull").attr("disabled","disabled");
			$("#"+selectid+"_serialNumber").val("");
			$("#"+selectid+"_serialNumber").attr("readonly","readonly");
		}else{
			document.getElementById(testid).disabled=false;
			document.getElementById(checkid).disabled=false;
			$("#"+selectid+"_isNull").attr("disabled","");
			$("#"+selectid+"_serialNumber").attr("readonly","");
		}		
	}
	function loading(){
		parent.setAddInfo('<s:property value="%{#request.importrow}"/>','<s:property value="%{#request.classname}"/>');
	}
	</script>
  </head>
  
<body> 
<div class="box1" >
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tempID" value="%{tempID}"/>
	
    <table>
		<tr>
			<td style="padding-left: 17px">导入Excel从第几行开始：</td>
			<td>
			   <s:textfield id="import" name="import" value="%{#request.importrow}" size="5" maxlength="10" 
			    onkeypress="NumberText(event,false,false);" cssStyle="ime-mode:disabled" cssStyle="width:50px"/>
			    <label style="color:red">*</label>
			</td>
			<td style="padding-left: 10px">设置处理服务类：</td>
			<td>
				<s:textfield id="className" name="className" value="%{#request.classname}" size="60" maxlength="200"
					 cssStyle="width:300px"/>
				 <label style="color:red">*</label>
			</td>
		</tr>
	</table>
    
 <fieldset> 
　 <legend>导入字段设置</legend>

		<table class="tableStyle" id="execlImport_table">
     		<tr>    			
    			<th align="center" width="3%"></th>
    			<th align="center" width="8%">字段</th>
    			<th align="center" width="10%">标题名称</th>
    			<th align="center" width="15%" colspan="2">转换表</th>
				<th align="center" width="10%">导入值/字典类别</th>
				<th align="center" width="10%">替换值</th>
    			<th align="center" width="4%">必填</th>
    			<th align="center" width="5%">列序</th>
    		</tr>
    	<s:iterator value="listInfo" status="stat">    		
    		<tr>
    			<td align="center">
    				<s:checkbox id="%{filedName}" name="listInfo[%{#stat.index}].isImportField"
    			    	value="%{filedAlias!=null&&filedAlias!=\"\"?true:false}" 
    			    	onclick="editRow('listInfo[%{#stat.index}].filedAlias','%{filedName}_change','%{filedName}');"/>
    			</td>
    			<td align="left" style="font-size: 11px;"><s:property value="filedName"/></td>
    			<td align="center">
    				<s:hidden name="listInfo[%{#stat.index}].filedName" value="%{filedName}"/>
    				<s:textfield disabled="%{(filedAlias!=null&&filedAlias!=\"\")?false:true}" id="listInfo[%{#stat.index}].filedAlias" 
    				             name="listInfo[%{#stat.index}].filedAlias" value="%{filedAlias}" size="6" cssStyle="width:100px;"/>
    				<s:hidden name="listInfo[%{#stat.index}].filedLength" value="%{filedLength}"/>
    				<s:hidden name="listInfo[%{#stat.index}].filedType" value="%{filedType}"/>
    				<s:hidden name="listInfo[%{#stat.index}].Scale" value="%{Scale}"/>
    		   </td>
    			<td align="center">
    			    <s:checkbox id="%{filedName}_change" disabled="%{(filedAlias!=null&&filedAlias!=\"\")?false:true}" name="isChange" 
    			                value="%{replaceSelectTable!=null?true:false}" onclick="intactSelect('%{filedName}');"/>
    			</td>
    			<td align="center">
					<s:select name="listInfo[%{#stat.index}].replaceSelectTable" id="%{filedName}_tables" list="DBTables" headerKey=""
						         headerValue="---选择转换表---" onchange="tableFields('%{filedName}');" value="%{replaceSelectTable}"
						         disabled="%{replaceSelectTable!=null?false:true}" autoWidth="true" cssStyle="width:150px" cssClass="default"/>
	    		</td>
	    		<td align="center">
					<s:select name="listInfo[%{#stat.index}].replaceField" id="%{filedName}_replaceField" list="getSysCodeSort()" 
					             headerKey="" headerValue="---字典类别---" listKey="id" listValue="caption" value="%{replaceField}" 
					                disabled="%{replaceField!=null?false:true}" autoWidth="true" cssStyle="width:100px" cssClass="default"/>
	    			<span>
		    			<s:select name="listInfo[%{#stat.index}].importField" id="%{filedName}_importField"
		    			 list="getTableFields(replaceSelectTable)" headerKey="" headerValue="---导入值---"
		    			  listKey="id" listValue="caption" value="importField" disabled="%{importField!=null?false:true}"
		    			   autoWidth="true" cssStyle="width:100px" cssClass="default"/>
	    			</span>
	    		</td>
	    		<td align="center">
	    			<s:select name="listInfo[%{#stat.index}].exportField" id="%{filedName}_exportField"
	    			 list="getTableFields(replaceSelectTable)" headerKey="" headerValue="---替换值---" listKey="id"
	    			  listValue="caption" value="exportField" disabled="%{exportField!=null?false:true}"
	    			   autoWidth="true" cssStyle="width:100px" cssClass="default"/>
	    		</td>	    									    				
    			<td align="center">
    				<s:checkbox id="%{filedName}_isNull" name="listInfo[%{#stat.index}].isNull" disabled="true" value="%{!isNull}"/>
    			</td>
    			<td align="center">
    				<s:textfield id="%{filedName}_serialNumber" name="listInfo[%{#stat.index}].serialNumber" 
    				 onkeypress="NumberText(event,false,false);" cssStyle="ime-mode:disabled" maxlength="2"
    				 value="%{serialNumber}" style="width:30px;" readonly="true" onblur="checkordernum(this)"/>
    			</td>
    		</tr>
    	</s:iterator>
 </fieldset>	    	
</s:form>
</div>  	
	   
	<div class="padding_top10">
			<table class="tableStyle" transMode="true">
				<tr>
					<td colspan="4">
						<input type="button" id="ysSaveButton" value=" 保 存 " onclick="submitForm()"/>
						<input type="button" value=" 关 闭 " onclick="parent.closeEntityWindow()"/>
						<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
							<span id="SystemErrorMessage" style="top: 20px">
								<s:actionerror cssStyle="color:red"/>
								<s:actionmessage cssStyle="color:blue"/>
								<s:fielderror/>
							</span>
						</s:if>
					</td>
				</tr>
			</table>
	</div>
  </body>
</html>