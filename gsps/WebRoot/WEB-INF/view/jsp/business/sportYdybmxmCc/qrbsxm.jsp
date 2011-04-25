<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <title>运动员确认参赛项目</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript">
	detailPageStyle();
	var objid = parent.tem_valueObjid;
	var objname = parent.tem_nameObjid;
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
	}
	function doreset()
	{	
		document.getElementById("xmdj").value="";
		document.getElementById("dxmmc").value="";	
		document.getElementById("xxmmc").value="";	
		document.getElementById("zb").value="";	
		document.getElementById("xbz").value="";
	}

	//删除选择项目
	function dels(id,ydybm){
		ajaxService.removeYdyxm(id,ydybm,function(data){
			alert(data);
			document.forms[0].submit();
			return false;
		});
	}
	//用于确认可选多项参赛项目
	function submitBsxm(){
		var slength = 0;
		var a = document.getElementsByName("selectNode");
		var ydybm = document.getElementById("ydyid").value+'';
		for (var i = 0; i < a.length; i++) {
			if (a[i].checked) {
				slength += 1;
			}
		}
		if(slength>=1){
			var id = CropCheckBoxValueAsString("selectNode")+'';
			ajaxService.submitXmbm(id,ydybm,function(data){
				  alert(data);
				  document.forms[0].submit();
				  return false;
			});
		}else{
			alert("请勾选至少一条记录!");
		}

	}
	var i =0;
	function getzy2(){
		i=1;
		document.getElementById("dxmmc_later").value="";
		getzyy();
	}
	
	function getzy1(){
		i=1;
		document.getElementById("xxmmc_later").value="";	
		document.getElementById("zb_later").value="";	
		document.getElementById("xbz_later").value="";	
		getzy();
	}
	
	function getzyy(){
		var xmdj=document.getElementById("xmdj").value;
		if(xmdj!=""){
	   		changeSelectHtml1(xmdj);
	   	}
	}
	
	function getzy(){
		var dxmmc=document.getElementById("dxmmc").value;
		if(dxmmc!=""){
	   		changeSelectHtml(dxmmc);
	   	}
	}


	function changeSelectHtml1(obj){
		ajaxService.getSelectXmdj(obj,ce);
		
	}
	
	function changeSelectHtml(obj){
			ajaxService.getSelectXxmmc(obj,cb);
			ajaxService.getSelectZb(obj,cd);
			ajaxService.getSelectXbz(obj,cf);
	}

	function ce(result){
		var changeSelectId = "dxmmc";
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		jQuery("#dxmmcContainer").html('<select name="tsportBsxm.dxmmc" id="dxmmc" onchange="getzy1()" ><option value="" >--请选择--</option></select>');
		DWRUtil.addOptions( changeSelectId, result );
		var obj = document.getElementById("dxmmc_later");
		if(obj.value != '' && i==0){
			DWRUtil.setValue(changeSelectId,obj.value);
		}
		$ = jQuery;
	}
	function cb(result){
		var changeSelectId = "xxmmc";
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		DWRUtil.removeAllOptions('xxmmc');
		DWRUtil.addOptions( changeSelectId, result,'id','caption');
		var obj = document.getElementById("xxmmc_later");
		if(obj.value != '' && i==0){
			DWRUtil.setValue(changeSelectId,obj.value);
		}
		$ = jQuery;
	}
	function cd(result){
		var changeSelectId = "zb";
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		jQuery("#zbContainer").html('<select name="tsportBsxm.zb" id="zb"><option value="">--请选择--</option></select>');
		DWRUtil.addOptions( changeSelectId, result );
		var obj = document.getElementById("zb_later");
		if(obj.value != '' && i==0){
			DWRUtil.setValue(changeSelectId,obj.value);
			}
		$ = jQuery;
	}
	function cf(result){
		var changeSelectId = "xbz";
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		jQuery("#xbzContainer").html('<select name="tsportBsxm.xbz" id="xbz"><option value="">--请选择--</option></select>');
		DWRUtil.addOptions( changeSelectId, result );
		var obj = document.getElementById("xbz_later");
		if(obj.value != '' && i==0){
			DWRUtil.setValue(changeSelectId,obj.value);
		}
		$ = jQuery;
	}
	
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
   <div class="framestyle" style="width:100%;padding: 0pt 10pt 10pt 10pt;">
    <s:form name="theform" method="post" theme="simple" >
    <s:hidden name="wid" id="ydyid" />
    <s:hidden name="tsportBsxm.wid" />
  	<s:hidden name="cd" value="%{#parameters.cd[0]}" id="cd" />
    <s:hidden name="pager.formname" value="theform"/>
    <fieldset>
    <legend>可选择参赛项目</legend>
    <input type="hidden" value="<s:property value="tsportBsxm.xxmmc" />" id="xxmmc_later" />
	<input type="hidden" value="<s:property value="tsportBsxm.zb" />" id="zb_later" />
	<input type="hidden" value="<s:property value="tsportBsxm.xbz" />" id="xbz_later" />
	<input type="hidden" value="<s:property value="tsportBsxm.dxmmc" />" id="dxmmc_later" />
    <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%" class="maginB">
			<tr align="center">
				
			</tr>
	</table>
	<s:if test="%{#shzt=='-1'||#shzt=='0' ||#shzt=='' ||#shzt==null}">
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
    		<tr>
			    <td height="30px">
				   <ul class="btn_gn">
					<li><a href="#" title=" 确定" onClick="submitBsxm()"><span> 确定</span></a></li>
					<li ><a href="#" title="关闭" onClick="	parent.window.location.reload();"><span>关闭</span></a></li>		 
				   </ul>
			     </td>
	     	</tr>    
    	</table>
   </s:if>
  
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
    			<th height="20px" width="5%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
 		        <th width="10%">项目</th>
 		        <th width="10%">性别组</th>
 		        <th width="10%">组别</th>
    			<th width="30%">级（赛）别</th>
    		</tr>
    		</thead>
    		<tbody id="listData"><% int i=0; %>
 			<s:iterator value="#lists"><%--lists 用于在页面上把后台的数据显示出来--%>
 			<%i=0; %>
 				<tr>
 					<s:iterator value="#lists1" status="sts">
    					<s:if test="%{#lists1[#sts.index][3].toString()==wid}">
    						<% i=1; %>
    					</s:if>
    				</s:iterator>
    				<%
    					if(i==1){
    						%>
    						<td ><input type="checkbox"  id="<s:property value='wid' />" name="selectNode" value="<s:property value='wid' />" checked="checked"  /></td>
    						<%
    					}else{
    						%>
    						<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
    						<%
    					}
    				%>
		      		<td id="dxmmc_<s:property value='wid'/>" ><s:property value="dxmmc" /></td> 
	      			<td id="xbz_<s:property value='wid'/>"><s:property value="xbz"/></td> 
	      			<td id="zb_<s:property value='wid'/>"><s:property value="zb"/></td>
	      			<td id="xxmmc_<s:property value='wid'/>"><s:property value="xxmmc"/></td>       		   			       			    		    
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
    	</fieldset>
    	<br/>
    	</s:form>
    </div>
  </body>
</html>

