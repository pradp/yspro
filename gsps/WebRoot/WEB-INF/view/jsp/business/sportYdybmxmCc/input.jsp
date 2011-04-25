<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <title><s:property value="xm"/> 二次报名项目</title>
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
		document.getElementById("dxmmc").value="";	
		document.getElementById("xxmmc").value="";	
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
	function submitBsxm() {
		var id = CropCheckBoxValueAsString("selectNode") + '';
		if (id.length > 0) {
			var leg = id.split(',');
			var conf = window.confirm("本次二次报名项目共" + leg.length + "条。");
			if (conf == true) {
				var slength = 0;
				var a = document.getElementsByName("selectNode");
				var ydybm = document.getElementById("ydyid").value + '';
				var xmmc = document.getElementById("dxmmc").value + '';
				for ( var i = 0; i < a.length; i++) {
					if (a[i].checked) {
						slength += 1;
					}
				}
				if (slength >= 1) {
					ajaxService.submitXmbm(id, ydybm, xmmc, function(data) {
						//alert(data);
						$("#detile").val("1");
						document.forms[0].submit();
						return false;
					});
				}
			}
		} else {
			alert("请勾选至少一条记录!");
			return false;
		}
	}

	var i = 0;
	function getzy1() {
		i = 1;
		document.getElementById("xxmmc_later").value = "";
		getzy();
	}

	function getzy() {
		var dxmmc = document.getElementById("dxmmc").value;
		if (dxmmc != "") {
			changeSelectHtml(dxmmc);
		}
	}

	function changeSelectHtml(obj) {
		ajaxService.getSelectXxmmc(obj, cb);
	}

	function cb(result) {
		var changeSelectId = "xxmmc";
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		DWRUtil.removeAllOptions('xxmmc');
		DWRUtil.addOptions(changeSelectId, result, 'id', 'caption');
		var obj = document.getElementById("xxmmc_later");
		if (obj.value != '' && i == 0) {
			DWRUtil.setValue(changeSelectId, obj.value);
		}
		$ = jQuery;
	}

	//打印页面信息
	function printForm(){
		var id =  document.getElementById("ydyid").value;
		var xm =  document.getElementById("xm").value;
		var url = actionName+"-printRcbm.c?wid="+id+"&xm="+xm;
		openWindow(url,800,350);
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
    <s:hidden name="xm" id="xm"/>
    <s:hidden name="dxmmc" id="dxmmc"/>
  	<s:hidden name="cd" value="%{#parameters.cd[0]}" id="cd" />
    <s:hidden name="pager.formname" value="theform"/>
    <fieldset>
    <legend>可选择参赛项目 </legend>
    <input type="hidden" value="<s:property value="tsportBsxm.xxmmc" />" id="xxmmc_later" />
	<input type="hidden" value="<s:property value="tsportBsxm.dxmmc" />" id="dxmmc_later" />
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleftt">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
									<td align="right" nowrap="nowrap" class="" colspan="1" width="10%">&nbsp;项目：</td>
									<td align="left" nowrap="nowrap" id="dxmmcContainer" colspan="1"  width="15%">
										 <s:select name="tsportBsxm.dxmmc" id ="dxmmc" list="getYdyDxmmc()" listKey="id" onchange="getzy1()" listValue="caption" headerKey="" />
										<s:hidden name="detile" id="detile" />
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1" width="10%">&nbsp;级（赛）别：</td>
									<td align="left" nowrap="nowrap" id="xxmmcContainer" colspan="1" width="40%">
										 <s:select name="tsportBsxm.xxmmc" id ="xxmmc" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="-------请选择-------"/>
									</td>
									<%--<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;组别：</td>
									<td align="left" nowrap="nowrap" id="zbContainer" colspan="1">
										 <s:select name="tsportBsxm.zb" id ="zb" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;性别组：</td>
									<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
										 <s:select name="tsportBsxm.xbz" id ="xbz" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									--%><td colspan="1"></td>
									<td align="right"  nowrap="nowrap" colspan="1"><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="super_doSearch()"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
										</li>
										<li>
											<a href="#" title="重置" onClick="doreset()"
												id="searchButton2" name="btn4"><span> 重置 </span>
											</a>
										</li>
									</ul></td>
								</tr>
							</table>
						</td>
						<td width="15" height="75" class="chaxunrightt">
							&nbsp;
						</td>
					</tr>
				</table></td></tr></table>

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
					<li ><a href="#" title="关闭" onClick="parent.document.forms[0].submit();"><span>关闭</span></a></li>
					<li ><a href="#" title="打印" onClick="printForm()"><span>打印</span></a></li>		 
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
	      			<td id="xbz_<s:property value='wid'/>">
	      			<s:if test="xbz != null && xbz !=''">
	      			<s:property value="xbz"/></s:if>
	      			<s:else>--</s:else>
	      			</td> 
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

