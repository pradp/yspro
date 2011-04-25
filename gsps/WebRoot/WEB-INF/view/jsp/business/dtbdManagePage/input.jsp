<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>新建数据库表</title>
    
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
	//验证
	validate_required_fields = [				
			{fieldId:"ctableChineseName", message:"表中文名不能为空！", mustMatch: true}				
		];
	validate_length_range_fields = [
			{fieldId:"ctableChineseName", minLen:1, maxLen:50, message:"表中文名称长度在1-50个字节之间！", ignoreIfEmpty: true}		
		];
	var isUpdate=false;
	function submitForm(){
		//alert("提交");
		/*if(isValidateForm()){
			if(selectScope()){	
				super_submitForm();
			}else{
				alert("请选择服务范围！");
			}			
		}*/
		var isSumbit=true;
		
		if(document.getElementById('sx').checked){
			var ele=document.getElementsByName('lcsx');
			for(var i=0;i<ele.length;i++){
				if(ele[i].value=='7'||ele[i].value=='1'){
					if(!ele[i].checked){
						isSumbit=false;
						break;
					}
				}
			}
		}else{
			var ele=document.getElementsByName('lcgx');
			for(var i=0;i<ele.length;i++){
				if(ele[i].value=='6'||ele[i].value=='1'){
					if(!ele[i].checked){
						isSumbit=false;
						break;
					}
				}
			}
		}
		//alert(isUpdate);
		if(isSumbit||isUpdate){super_submitForm();}else{alert("请不要去除默认选中！");}
		
	}
	//添加一行
	var newnum=0;
	function getPersonMaxNum(){
	    var num = 0;
	    var ryInput = $("input[@name*=listField]").each(function(i){
	        if (this.name.indexOf(".wid") != -1) {
	            var thisIndexStr = this.name;
	            var end = thisIndexStr.substring("listField[".length);
	            var thisIndex = end.substring(0, end.indexOf("].wid"));
	            if (thisIndex > num) 
	                num = thisIndex;
	        }
	    });
	    return num;
	}	
	function createColumn(){
	    var id = (new Date()).getTime() + "";
	    var maxNum = getPersonMaxNum();
	    newnum = (parseInt(maxNum) + 1)>newnum?parseInt(maxNum) + 1:newnum;
	    var newTag = "listField[" + newnum + "]";
	    //alert(newTag);	   
	    jQuery.noConflict();
	    var cellFuncs = [function(data){
	        return ++newnum;
	    },function(data){
	        return "<input name='" + newTag + ".fieldChineseName' type='text' size='13' maxlength='70'/><input type='hidden' name='" + newTag + ".wid'/>";
	    },function(data){
	        return "<select name='"+newTag+".fieldType'><option value=\"0\">字符型</option><option value=\"1\">数字型</option><option value=\"2\">字典表</option></select>";
	    },function(data){
	        return "<input name='" + newTag + ".fieldLength' type='text' size='3' maxlength='70'/>";
	    },function(data){
	        return "<input name='" + newTag + ".fieldDefine' type='text' size='4' maxlength='70'/>";
	    },function(data){
	        return "<input name='" + newTag + ".isMustIn' type='checkbox'/>";
	    },function(data){
	        return "<input name='" + newTag + ".remarks' type='text' size='10' maxlength='70'/>";
	    },function(data){
	        return "<a href='javascript:void();' onclick='removeThisRow(this);'>删除列</a>";
	    }
	    
	];		
	    DWRUtil.addRows("listData", [id], cellFuncs, {
	        escapeHtml: false
	    });	   
	    $ = jQuery;
	    
   	 ///rebundstyle();
	}
	var delIDS=new Array();
	//删除一行
	function removeThisRow(obj,id){
		//alert("delete");		
		delIDS.push(id);
		var tr=obj.parentNode.parentNode;
		var tbody=obj.parentNode.parentNode.parentNode;		
	   	tbody.removeChild(tr);
	   	document.getElementById('delids').value=delIDS;
	   	//alert(document.getElementById('delids').value);
	}
	//流程的控制显示
	function disposeCheckBox(name,dispose){//屏蔽		
		//alert(document.getElementsByName(name).length);
		var ele=document.getElementsByName(name);
		for(var i=0;i<ele.length;i++){
			//alert(ele[i].value);
			ele[i].disabled=true;
		}
		var ele=document.getElementsByName(dispose);
		for(var i=0;i<ele.length;i++){
			//alert(ele[i].value);
			ele[i].disabled=false;
			if(ele[i].value!='8'&&ele[i].value!='9')
				ele[i].checked=true;
		}
	}
	//初始页面
	function init(){
		var type="<s:property value="%{#request.lcsx}"/>";
		
		if(""!=type){//修改			
			isUpdate=true;
			//alert(isUpdate);
			document.getElementById('sx').disabled=true;
			document.getElementById('gx').disabled=true;
			disposeCheckBox('lcsx','');
			disposeCheckBox('lcgx','');
			if(type.indexOf("7")>-1){//高中流程
				var ele=document.getElementsByName('lcsx');
				for(var i=0;i<ele.length;i++){
					//alert("高中:"+ele[i].value);
					if(type.indexOf(ele[i].value)>-1)
						ele[i].checked=true;
				}
			}else{//院系流程
				var ele=document.getElementsByName('lcgx');
				for(var i=0;i<ele.length;i++){
					//alert("院系:"+ele[i].value);
					if(type.indexOf(ele[i].value)>-1)
						ele[i].checked=true;
				}
			}
		}else{//新增
			if(document.getElementById('sx').checked){
				disposeCheckBox('lcgx','lcsx');
			}else{
				if(document.getElementById('sx').checked)
					disposeCheckBox('lcsx','lcgx');
				else{
					document.getElementById('sx').checked=true;
					init();
				}			
			}
		}
	
		
	}
	</script>
  </head>
  
<body onload="init();"> 
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
    <input type="hidden" name="delids" id="delids"/>
    
<!--table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="26%"><tr><td height="30px" width="440px">
<ul class="btn_gn"><li><a href="#" title="创建" onClick="submitForm();" id="sendMsgButton"><span>创建</span> </a></li>
<li><a href="#" title="取消" onclick="parent.closeInputWindow();"><span>取消</span></a></li></ul>	
</td></tr></table-->
    
    
    <table style="margin-top: 15px">
		<tr>
			<!-- td style="padding-left: 17px">表名：</td-->
			<td><s:hidden name="tableInfo.tableName"/></td>
			<td style="padding-left: 10px" align="right">中文名：<s:hidden name="tableInfo.wid"/></td>
			<td><s:textfield id="ctableChineseName" name="tableInfo.chineseName" size="40" maxlength="50"/></td>
			<td style="padding-left: 10px" align="right">备注：</td>
			<td><s:textfield id="tableRemarks" name="tableInfo.remarks" size="30" maxlength="200"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td style="padding-left: 10px" align="right">新增：</td>
			<td><s:select name="tableInfo.xzlx" list="getSysCode('dtbd_xzlx')" listKey="id" listValue="caption"/></td>
			<td style="padding-left: 10px" align="right">汇总：</td>
			<td><s:select name="tableInfo.hzlx" list="getSysCode('dtbd_hzlx')" listKey="id" listValue="caption"/></td>
		</tr>
	</table>
	
<!-- 审核流程 start -->
<fieldset style="width:40%">
<legend>审核流程</legend>
<table>	

	<tr><td><input type="radio" id="sx" name="dx" onclick="disposeCheckBox('lcgx','lcsx');"/></td><td><s:checkboxlist name="lcsx" list="#{\"8\":\"高中\",\"7\":\"市县\",\"1\":\"省中心\"}"/></td></tr>
	<tr><td><input type="radio" id="gx" name="dx" onclick="disposeCheckBox('lcsx','lcgx');"/></td><td><s:checkboxlist name="lcgx" list="#{\"9\":\"院系\",\"6\":\"高校\",\"1\":\"省中心\"}"/></td></tr>
	


	
</table>	
</fieldset>
<!-- end -->	
	
	
    
<!-- 表头外圈样式 start -->
<!-- table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB"><tr><td class="infomainbg">
<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td width="10">&nbsp;</td>
<td>&nbsp;</td></tr><tr><td width="10">&nbsp;</td><td-->
<fieldset> 
　 <legend>新增表结构</legend>
<!-- 表头外圈样式 end -->
       
    	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="95%"  class="middle" style="margin: 12px">
    		<thead id="listHead">
    		<tr>    			
    			<th>序号</th>
    			<!-- th>列名</th-->
    			<th>中文名</th>
    			<th>类型</th>
    			<th>长度</th>
    			<th>默认值</th>
    			<th>允许空</th>
    			<th>备注</th>
    			<th>操作</th>
    		</tr>
    		</thead>
    		<tbody id="listData">
    	<s:iterator value="listField" status="stat">    
    	<s:set name="bean" value="listField[#stat.index]" />		
    		<tr>
    			<td><s:property value="#stat.index+1"/><s:hidden name="listField[%{#stat.index}].wid"/></td>
    			
    			<s:hidden name="listField[%{#stat.index}].createTableID"/>
    			<s:hidden name="listField[%{#stat.index}].fieldName"/>
    			<s:hidden name="listField[%{#stat.index}].isFieldEnter"/>
    			<s:hidden name="listField[%{#stat.index}].isMustIn"/>
    			<s:hidden name="listField[%{#stat.index}].fieldEnterOrder"/>
    			<s:hidden name="listField[%{#stat.index}].fieldDisplayName"/>
    			<s:hidden name="listField[%{#stat.index}].isFieldDisplay"/>
    			<s:hidden name="listField[%{#stat.index}].fieldWidth"/>
    			<s:hidden name="listField[%{#stat.index}].fieldOrder"/>
    			<s:hidden name="listField[%{#stat.index}].isFieldQuery"/>
    			<s:hidden name="listField[%{#stat.index}].isStatistics"/>
    			<s:hidden name="listField[%{#stat.index}].depttype"/>
    			<s:hidden name="listField[%{#stat.index}].view_data"/>    			
    			<s:hidden name="listField[%{#stat.index}].isSum"/>
    			<s:hidden name="listField[%{#stat.index}].isAvg"/>
    			<s:hidden name="listField[%{#stat.index}].fzzd"/>
    			<s:hidden name="listField[%{#stat.index}].fieldsum"/>
    			<s:hidden name="listField[%{#stat.index}].fieldavg"/>
    			<s:hidden name="listField[%{#stat.index}].fieldtj"/>
    			
    			<!-- td><s:textfield name="listField[%{#stat.index}].fieldName" size="10"/></td-->    			
    			<td><s:textfield name="listField[%{#stat.index}].fieldChineseName" size="13"/></td>
    			<td><s:select name="listField[%{#stat.index}].fieldType" list="#{'0':'字符型','1':'数字型','2':'单选框','3':'多选框','4':'日期','5':'时间'}"/></td>
    			<td><s:textfield name="listField[%{#stat.index}].fieldLength" size="3" onkeypress="NumberText(event,false,false);" onblur="isNonnegativeInteger('bxkcs')"/></td>
    			<td><s:textfield name="listField[%{#stat.index}].fieldDefine" size="4"/></td>
    			<td><s:checkbox name="listField[%{#stat.index}].isNull"/></td>
    			<td><s:textfield name="listField[%{#stat.index}].remarks" size="10"/></td>
    			
    			<td><a href="javascript:void();" onclick="removeThisRow(this,'<s:property value="#bean.wid"/>');">删除列</a></td>
    			 
    		</tr>
    	</s:iterator> 
    		<s:if test="%{#request.err!=null&&#request.err!=''}">
    		<td colspan="8" style="text-align: left">&nbsp;&nbsp;<s:property value="%{#request.err}"/></td>
    		</s:if>  	 
    	   		
    		</tbody>
    	</table>     
    	
 <!-- 表 底外圈样式 start --> 
</fieldset>   	
<!-- /td></tr></table></td><td width="10" class="infomainright"></td></tr><tr><td height="20" class="infobottomleft"></td><td width="10" class="infobottomright"></td></tr></table-->
<!-- 表 底外圈样式 end -->       
	   
<!-- add column button -->
<!-- table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="26%"><tr><td height="30px" width="440px">
<ul class="btn_gn"><li><a href="#" title="新建列" onClick="createColumn();" id="addColumnButton"><span>新建列</span></a></li>
</ul>	
</td></tr></table-->

<table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle">	   
	    <td height="30" colspan="7">
	    	    
<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="26%"><tr><td height="30px" width="440px">
	<ul class="btn_gn">	
	<li><a href="#" title="增加字段" onClick="createColumn();" id="addColumnButton"><span>增加字段</span></a></li>									
	<li><a href="#" title="保存" onClick="submitForm();" id="sendMsgButton"><span>保存</span></a></li>
	<li><a href="#" title="关闭" onClick="parent.closeInputWindow();" id="sendMsgButton"><span>关闭</span></a></li>																															
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