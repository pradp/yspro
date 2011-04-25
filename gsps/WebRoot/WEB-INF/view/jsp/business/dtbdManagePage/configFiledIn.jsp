<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>填报页面设置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
	
	
	<script type="text/javascript">
	detailPageStyle();
	function submitForm(){
		document.getElementById('save').value='1';
		super_submitForm("configFiledIn");
	}
	function showList(){
		super_submitForm("configFiledIn");
	}
	//添加一行
	var newnum=0;
	function getPersonMaxNum(){
	    var num = 0;
	    var ryInput = $("input[@name*=test]").each(function(i){
	        if (this.name.indexOf(".wid") != -1) {
	            var thisIndexStr = this.name;
	            var end = thisIndexStr.substring("test[".length);
	            var thisIndex = end.substring(0, end.indexOf("].wid"));
	            if (thisIndex > num) 
	                num = thisIndex;
	        }
	    });
	    return num;
	}	
	function createColumn(){
		//alert("11"+document.getElementById('selectList').innerHTML);
	    var id = (new Date()).getTime() + "";
	    var maxNum = getPersonMaxNum();
	    newnum = (parseInt(maxNum) + 1)>newnum?parseInt(maxNum) + 1:newnum;
	    var newTag = "test[" + newnum + "]";
	    //alert(newTag);	   
	    jQuery.noConflict();
	    var cellFuncs = [function(data){
	        return "变量：";
	    },function(data){
	        return "<input name='" + newTag + ".name' type='text' size='10' maxlength='70'/>&nbsp;&nbsp;=&nbsp;&nbsp;<select>"+document.getElementById('selectList').innerHTML+"</select>&nbsp;&nbsp;<a href='javascript:void();' onclick='removeThisRow(this);'>删除变量</a>";
	    }
	    
	];		
	    DWRUtil.addRows("selectROW", [id], cellFuncs, {
	        escapeHtml: false
	    });	   
	    $ = jQuery;
	    
   	 ///rebundstyle();
	}
	//删除一行
	function removeThisRow(obj){
		//alert("delete");			
		var tr=obj.parentNode.parentNode;
		var tbody=obj.parentNode.parentNode.parentNode;		
	   	tbody.removeChild(tr);	   
	   	//alert(document.getElementById('delids').value);
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
    <s:hidden name="wid" value="%{#request.wid}"/>  
    <s:hidden id="save" name="save" value=""/> 
       
<!-- 设置权限显示介面start -->
<!--s:select name="DeptType" list="%{#request.DeptType}" onchange="showList();" value="%{#request.cindex}"/-->
<s:hidden name="DeptType" value="%{#request.cindex}"/>
<!-- end -->       
       
<!-- 表头外圈样式 start -->
<!--table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB"><tr><td class="infomainbg">
<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td width="10">&nbsp;</td>
<td>&nbsp;</td></tr><tr><td width="10">&nbsp;</td><td-->

<fieldset> 
　 <legend>报表配置</legend>
<!-- 表头外圈样式 end -->
       
    	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="95%"  class="middle">
    		<thead id="listHead">
    		<tr>    			
    			<th style="width:13%">列名</th>
    			<th style="width:20%">自定义显示名</th>
    			<th style="width:10%">编辑索引</th>
    			
    			<th style="width:10%">浏览宽度(%)</th>
    			<th style="width:10%">浏览索引</th>
    			<s:if test="%{(#request.cindex=='9'.toString()||#request.cindex=='8'.toString())||(#request.DeptType.size()<=2&&(#request.cindex=='6'.toString()||#request.cindex=='7'.toString()))}">
    			<th style="width:5%">编辑</th>
    			<th style="width:5%">必填</th>
    			</s:if>
    			<th style="width:5%">显示</th>
    			<th style="width:5%">查询</th>
    			<th style="width:5%">统计</th>
    			<!--th style="width:5%">分组</th-->
    			<th style="width:5%">求和</th>
    			<th style="width:5%">平均</th>
    		</tr>
    		</thead>
    		<tbody id="listData">
    	<s:iterator value="listField" status="stat"> 
    	<s:set name="bean" value="listField[#stat.index]" />   		
    		<tr>
    			<td><s:property value="#bean.fieldChineseName"/><s:hidden name="listField[%{#stat.index}].fieldChineseName"/><s:hidden name="listField[%{#stat.index}].wid"/><s:hidden name="listField[%{#stat.index}].fieldName"/>
    			<s:hidden name="listField[%{#stat.index}].fieldsum"/><s:hidden name="listField[%{#stat.index}].fieldavg"/><s:hidden name="listField[%{#stat.index}].fieldtj"/>
    			
    			<s:hidden name="listField[%{#stat.index}].createTableID"/>
    			<s:hidden name="listField[%{#stat.index}].fieldForm"/>
    			<s:hidden name="listField[%{#stat.index}].isNull"/>
    			<s:hidden name="listField[%{#stat.index}].fieldLength"/>
    			<s:hidden name="listField[%{#stat.index}].fieldDefine"/>
    			<s:hidden name="listField[%{#stat.index}].remarks"/>
    			<s:hidden name="listField[%{#stat.index}].view_data"/>
    			<s:hidden name="listField[%{#stat.index}].depttype"/>
    			<s:hidden name="listField[%{#stat.index}].fieldType"/>
    			
    			</td>
    			<td><s:textfield name="listField[%{#stat.index}].fieldDisplayName" size="26"/></td>
    			<td><s:textfield name="listField[%{#stat.index}].fieldEnterOrder" size="4" onkeypress="NumberText(event,false,false);"/></td>
    			    			    			
    			<td><s:textfield name="listField[%{#stat.index}].fieldWidth" size="10" onkeypress="NumberText(event,false,false);"/></td>
    			<td><s:textfield name="listField[%{#stat.index}].fieldOrder" size="4" onkeypress="NumberText(event,false,false);"/></td>
    			
    			<s:if test="%{(#request.cindex=='9'.toString()||#request.cindex=='8'.toString())||(#request.DeptType.size()<=2&&(#request.cindex=='6'.toString()||#request.cindex=='7'.toString()))}">
    				<s:if test="%{#bean.fieldName.indexOf(\"FIELD\")==-1}">
    					<td><s:checkbox name="listField[%{#stat.index}].isFieldEnter" disabled="true"/></td>
    					<td><s:checkbox name="listField[%{#stat.index}].isMustIn" disabled="true"/></td>
    				</s:if>
    				<s:else>
    					<td><s:checkbox name="listField[%{#stat.index}].isFieldEnter"/></td>
    					<td><s:checkbox name="listField[%{#stat.index}].isMustIn"/></td>
    				</s:else>    				
    			</s:if>
    			    			
    			<td><s:checkbox name="listField[%{#stat.index}].isFieldDisplay"/></td>
    			<td><s:checkbox name="listField[%{#stat.index}].isFieldQuery"/></td>
    			<td>&nbsp;<s:if test="%{#bean.fieldType=='1'.toString()}"><s:checkbox name="listField[%{#stat.index}].isStatistics"/></s:if><s:else><s:checkbox name="listField[%{#stat.index}].isStatistics" disabled="true"/></s:else></td>
    			    			
    			<!--td>&nbsp;<s:checkbox name="listField[%{#stat.index}].fzzd"/></td-->
    			<td>&nbsp;<s:if test="%{#bean.fieldType=='1'.toString()}"><s:checkbox name="listField[%{#stat.index}].isSum"/></s:if><s:else><s:checkbox name="listField[%{#stat.index}].isSum" disabled="true"/></s:else></td>
    			<td>&nbsp;<s:if test="%{#bean.fieldType=='1'.toString()}"><s:checkbox name="listField[%{#stat.index}].isAvg"/></s:if><s:else><s:checkbox name="listField[%{#stat.index}].isAvg" disabled="true"/></s:else></td>    		
    		    			
    		</tr>
    	</s:iterator>
    	    		 		   	 
    	   	<tr><td colspan="12" style="text-align: left"><span style="color:#999999">"编辑"表示是否允许在填报页面让用户填报,"显示"表示是否在列表页面列出,"查询"表示是否在列表页面上提供根据此字段查询的功能,"统计"表示是否要统计此字段的值'</span></td></tr>
    	   	  	 
    		</tbody>
    	</table>     
    	
 <!-- 表 底外圈样式 start -->   	
<!--/td></tr></table></td><td width="10" class="infomainright">&nbsp;</td></tr><tr><td height="20" class="infobottomleft"></td><td width="10" class="infobottomright"></td></tr></table-->
</fieldset>
<!-- 表 底外圈样式 end -->       
<table>
	<tr>
		<td align="left">设置填报年度默认值：<s:textfield name="TBND" size="6" onkeypress="NumberText(event,false,false);" value="%{#request.TBND}"/></td>
		<s:if test="tableInfo.hzlx == 1">
			<td align="left">填报月份：<s:textfield name="TBYF" size="6" onkeypress="NumberText(event,false,false);" value="%{#request.TBYF}"/></td>
		</s:if>
	</tr>
    <tr><td align="left" colspan="2"><s:checkbox name="isCount"/>审核部门浏览页面统计上报部门记录总数</td></tr>	   
</table>
<!-- 报表设置 start -->
<fieldset> 
　 <legend>报表配置</legend>
<table>
<tbody id="selectROW">
    	<tr><td>报表样式文件：</td><td><input type="file"/></td></tr>
    	<tr>
    	<td>变量：</td>
    	<td><input type="hidden" name="test[0].wid"/><s:textfield name="test[0].name" size="10"/>&nbsp;&nbsp;=&nbsp;&nbsp;<s:select id="selectList" name="test[0].val" list="%{#request.selectList}"/>
    	&nbsp;&nbsp;<a href='javascript:void();' onclick='createColumn();'>添加变量</a></td>
    	</tr>
</tbody>
</table>
</fieldset>
<!-- end -->
	   
	   
	   
<!-- add column button -->
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
<!-- add column button -->   
   	
    	</s:form>
    </div>
  </body>
</html>