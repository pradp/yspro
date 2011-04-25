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
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
	listPageStyle();
	$(document).ready(function(){
		jQuery("#listTable").unbind("click");
	});
	var objid = parent.tem_valueObjid;
	var objname = parent.tem_nameObjid;
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
	}
	function doreset()
	{	
		document.getElementById("dxmmc_id").value="";
		document.getElementById("xxmmc_id").value="";	
		document.getElementById("st_id").value="";	
		document.getElementById("et_id").value="";
	}
	
	var i =0;
	function getzy1(){
		i=1;
		document.getElementById("xxmmc_later").value="";	
		document.getElementById("zb_later").value="";	
		document.getElementById("xbz_later").value="";	
		getzy();
	}
	
	function getzy(){
		var dxmmc=document.getElementById("dxmmc").value;
		if(dxmmc!=""){
	   		changeSelectHtml(dxmmc);
	   	}
	}

	function changeSelectHtml(obj){
			ajaxService.getSelectXxmmc(obj,cb);
			ajaxService.getSelectZb(obj,cd);
			ajaxService.getSelectXbz(obj,cf);
	}

	function getSelectXxmmclFirst(obj){
		//清除 项目 隐藏域的值
		document.getElementById("dxmmcHidden_id").value='';
		document.getElementById("xxmmcHidden_id").value='';
		document.getElementById("help_id").value='0';
		getSelectXxmmc(obj);
	}
	function getSelectXxmmc(obj){
			var help_val = document.getElementById("help_id");
			ajaxService.getSelectXxmmc(obj.value,function (data){
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('xxmmc_id');
			DWRUtil.addOptions( 'xxmmc_id', data,'id','caption');
			var obj1 = document.getElementById("xxmmcHidden_id");
			if(help_val.value==null || help_val.value==''){
				DWRUtil.setValue('xxmmc_id',obj1.value);
			}
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
			});
	}
	</script>
  </head>
<body onload="getSelectXxmmc(document.getElementById('dxmmc_id'))"> 
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
    <s:hidden name="sportBsxm.val" />
    <s:hidden name="sportBsxm.dpType" />
    <input type="hidden" id="dxmmcHidden_id" value="<s:property value='sportBsxm.dxmmc' />" />
    <input type="hidden" id="xxmmcHidden_id" value="<s:property value='sportBsxm.xxmmc' />" />
    <input type="hidden" id="help_id" value="" />
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
    <tr><td id="fsearch"> 
    <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
	  <tr>
	    <td class="chaxunleft">
	    
         <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="98%">
			    <tr>
					<td align="right" nowrap="nowrap" class=""  colspan="1" width="5%">
						项目：
					</td>
					<td align="left" colspan="1" width="10%">
							<s:select name="sportBsxm.dxmmc" id="dxmmc_id"  list="getAllDxmmc()" onchange="getSelectXxmmclFirst(this)" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
					</td>
					<td align="right" nowrap="nowrap" class="" colspan="1" width="5%">
						级（赛）别：
					</td>
					<td align="left" colspan="3" width="12%">
							<s:select name="sportBsxm.xxmmc" id="xxmmc_id"  list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="-------请选择-------" />
					</td>
					<td align="right" nowrap="nowrap" class="" colspan="1">
						起始时间：
					</td>
					<td align="left" colspan="1">
						<s:textfield name="sportBsxm.startTime" id="st_id" size="13"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"  />
					</td>
					<td align="right" nowrap="nowrap" class="" colspan="1">
						结束时间：
					</td>
					<td align="left" colspan="1">
						<s:textfield name="sportBsxm.endTime" id="et_id"  size="13"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"  />
					</td>
					<td align="left" nowrap="nowrap"><ul class="btn_gn">
						<li>
							<a href="#" title="查询" onClick="super_doSearch()"
								id="searchButton" name="btn3"><span> 查询 </span>
							</a></li>
					</ul></td>
					<td align="left" nowrap="nowrap"><ul class="btn_gn">
						<li>
							<a href="#" title="重置" onClick="doreset()"
								id="searchButton2" name="btn4"><span> 重置 </span>
							</a>
						</li>
					</ul></td>
				</tr>
		</table>
			
		</td>
	    <td width="15" height="70" class="chaxunright">&nbsp;</td>
	  </tr>
    </table></td></tr>
    <tr>
    <td>
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
    			<th width="15%">时间</th>
    			<th width="30%">项目</th>
    			<th width="5%">&nbsp;</th>
    			<th width="10%">金</th>
    			<th width="10%">银</th>
    			<th width="10%">铜</th>
    			<th width="10%">得分</th>
    			</tr>
    		</thead>
    		<tbody id="listData">
    		<s:iterator value="resultData" status="status">
    		   <s:set name="ydyxxb" value="resultData[#status.index][8].split('_')"/>
    		   <s:set name="zsb" value="resultData[#status.index][9].split('_')"/>
		    		<tr>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][1]" /></td>
     			  	 <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][0]" /></td>
                         <td style="vertical-align:middle">
                         	<table cellpadding="0" cellspacing="0" width="100%" class="middle">
                         		<tr><td>赛程</td></tr>
                         		<tr><td>实际</td></tr>
                         	</table>
                         </td>
                         <td style="vertical-align:middle" colspan="4">
                         	<table cellpadding="0" cellspacing="0" width="100%"  class="middle" >
                         		<tr>
                         			<td width="25%"><s:property value="resultData[#status.index][2]" /></td>
                         			<td width="25%"><s:property value="resultData[#status.index][3]" /></td>
                         			<td width="25%"><s:property value="resultData[#status.index][4]" /></td>
                         			<td width="25%" style="border-right: 1px #D7D8D9 solid;"><s:property value="resultData[#status.index][5]" /></td>
                         		</tr>
                         		<tr>
                         			<td width="25%"><s:property value="resultData[#status.index][6]" /></td>
                         			<td width="25%"><s:property value="resultData[#status.index][7]" /></td>
                         			<td width="25%"><s:property value="resultData[#status.index][8]" /></td>
                         			<td width="25%" style="border-right: 1px #D7D8D9 solid;"><s:property value="resultData[#status.index][9]" /></td>
                         		</tr>
                         		
                         	</table>
                         </td>
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
    	</td></tr></table>
    	</s:form>
    </div>
  </body>
</html>

