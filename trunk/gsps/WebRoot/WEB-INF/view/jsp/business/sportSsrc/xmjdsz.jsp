<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>批量修改赛程信息</title>
    
   	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
	detailPageStyle();
	var objid = parent.tem_valueObjid;
	var objname = parent.tem_nameObjid;
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
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
			ajaxService.getSelectDxmmc(obj,cb);
			ajaxService.getSelectZb(obj,cd);
			ajaxService.getSelectXbz(obj,cf);
	}

	function ce(result){
		var changeSelectId = "dxmmc";
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		jQuery("#dxmmcContainer").html('<select name="tsportSsrc.dxmmc" id="dxmmc" onchange="getzy1()" ><option value="" >--请选择--</option></select>');
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
		jQuery("#xxmmcContainer").html('<select name="tsportSsrc.xxmmc" id="xxmmc"><option value="" >--请选择--</option></select>');
		DWRUtil.addOptions( changeSelectId, result );
		var obj = document.getElementById("xxmmc_later");
		if(obj.value != '' && i==0){
			DWRUtil.setValue(changeSelectId,obj.value);
		}
		$ = jQuery;
	}
	function cd(result){
		var changeSelectId = "zb";
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		jQuery("#zbContainer").html('<select name="tsportSsrc.zb" id="zb"><option value="">--请选择--</option></select>');
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
		jQuery("#xbzContainer").html('<select name="tsportSsrc.xbz" id="xbz"><option value="">--请选择--</option></select>');
		DWRUtil.addOptions( changeSelectId, result );
		var obj = document.getElementById("xbz_later");
		if(obj.value != '' && i==0){
			DWRUtil.setValue(changeSelectId,obj.value);
		}
		$ = jQuery;
	}

	function sfsx(){
		var a = document.getElementById("dxmmc").value;
		var b = document.getElementById("xxmmc").value;
		var c = document.getElementById("zb").value;
		var d = document.getElementById("xbz").value;
		var e = document.getElementById("scbm_Query").value;
		var f = document.getElementById("startTime").value;
		var g = document.getElementById("endTime").value;
		var h = document.getElementById("bpfz").value;
		var i=0;
        if(a!=null&&a!=''){
            i++;
		}if(b!=null&&b!=''){
            i++;
		}if(c!=null&&c!=''){
            i++;
		}if(d!=null&&d!=''){
            i++;
		}if(e!=null&&e!=''){
            i++;
		}if(f!=null&&f!=''){
            i++;
		}if(g!=null&&g!=''){
            i++;
		}if(h!=null&&h!=''){
            i++;
		}if(i==0){
        alert("筛选赛程不能都为空!");
          return false;
		}
		return true;
	}

	function sfsz(){
		var a = document.getElementById("bssj").value;
		var b = document.getElementById("scbm").value; 
		var c = document.getElementById("bscd").value;
		var d = document.getElementById("cjdw").value;
		var e = document.getElementById("djjd").value;
		var i=0;
        if(a!=null&&a!=''){
            i++;
		}if(b!=null&&b!=''){
            i++;
		}if(c!=null&&c!=''){
            i++;
		}if(d!=null&&d!=''){
            i++;
		}if(e!=null&&e!=''){
            i++;
		}if(i==0){
        alert("设置赛程不能都为空!");
          return false;
		}
		return true;
		}
	
	function dosave(){
		if(sfsx()&&sfsz()){
	    if (actionName == null || actionName == "") {
	        actionName = getActionName();
	    }
	    if(document.getElementById("bssj").value!=""){
		    document.getElementById("bssj").value = document.getElementById("bssj").value+":00";
	    }
	    document.forms[0].action = actionName + "-submitXmjdsz.c";
	    $(".btn_gn a").each(function(i){
	        if ($(this).attr("title").indexOf("保存") != -1) {
	            $(this).html("<span>处理中...</span>");
	            $(this).unbind();
	        }
	    });
	    document.forms[0].submit();
	    return true;
		}
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
  
  <s:hidden name="tsportSsrc.wid" />
  <s:hidden id="menues" name="menues" />
  <s:hidden name="sfxz" id="sfxz" />

<fieldset>
<legend>筛选赛程</legend>
    <input type="hidden" value="<s:property value="tsportSsrc.xxmmc" />" id="xxmmc_later" />
	<input type="hidden" value="<s:property value="tsportSsrc.zb" />" id="zb_later" />
	<input type="hidden" value="<s:property value="tsportSsrc.xbz" />" id="xbz_later" />
	<input type="hidden" value="<s:property value="tsportSsrc.dxmmc" />" id="dxmmc_later" />
    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunlefttt">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
								 	<td align="right" nowrap="nowrap" class="">&nbsp;项目等级：</td>
									<td align="left" nowrap="nowrap">
										 <s:select name="tsportSsrc.xmdj" id ="xmdj" list="getXmdjList()" listKey="id" listValue="caption" onchange="getzy2()" headerKey="" headerValue="--请选择--"/>
									</td> 
									<td align="right" nowrap="nowrap" class="">&nbsp;项目：</td>
									<td align="left" nowrap="nowrap" id="dxmmcContainer" >
										 <s:select name="tsportSsrc.dxmmc" id ="dxmmc" list="getAllDxmmc()" listKey="caption" onchange="getzy1()" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;级（赛）别：</td>
									<td align="left" nowrap="nowrap" id="xxmmcContainer">
										 <s:select name="tsportSsrc.xxmmc" id ="xxmmc" list="#{}" listKey="caption" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
								</tr>
								<tr>
									<td align="right" nowrap="nowrap" class="">&nbsp;组别：</td>
									<td align="left" nowrap="nowrap" id="zbContainer">
										 <s:select name="tsportSsrc.zb" id ="zb" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;性别组：</td>
									<td align="left" nowrap="nowrap" id="xbzContainer">
										 <s:select name="tsportSsrc.xbz" id ="xbz" list="#{}" listKey="caption" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">赛次：</td>
								     <td align="left" nowrap="nowrap">
								       	<s:select name="tsportSsrc.scbmQuery" id ="scbm_Query" list="getSysCode('SSRC_SCBM')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
								     </td>
								</tr>
								<tr>
									<td align="right" nowrap="nowrap" class="">编排分组：</td>
								     <td align="left" nowrap="nowrap">
								       	<s:select name="tsportSsrc.bpfz" id ="bpfz" list="getSysCode('SSRC_BPFZ')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
								     </td>
									<td align="right" nowrap="nowrap">起始时间：</td>
										<td align="left" id="span_rq">
								 			<span id="span_2" ><s:textfield id="rq_2" name="startTime" size="13" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})" /></span>
								 		</td>
										<td align="right" nowrap="nowrap">结束时间：</td>
										<td align="left" id="span_rq2">
								 			<span id="span_4" ><s:textfield id="rq_4" name="endTime" size="13" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})" /></span>
								 		</td>
								</tr>
							</table>
						</td>
						<td width="15" height="75" class="chaxunrighttt">
							&nbsp;
						</td>
					</tr>
				</table></td></tr></table>
  </fieldset>
<br/><br/>
<fieldset>
  <legend>设置赛程</legend>
  <table width="100%" border="0" align="center">
     <tr>
	     <td align="right" nowrap="nowrap" width="10%">比赛时间：</td>
			<td align="left" width="20%" nowrap="nowrap">
			  <input id="bssj" name="tsportSsrc.bssj" size="13" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})" value="<s:date name="tsportSsrc.bssj" format="yyyy-MM-dd HH:mm"/>"/>
		 </td>
		<td align="right" nowrap="nowrap" width="10%">赛次编码：</td>
	      <td align="left" width="20%" nowrap="nowrap">
	       <s:select name="tsportSsrc.scbm" id ="scbm" list="getSysCode('SSRC_SCBM')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/> 
	    </td>
	    <td align="right" width="10%" nowrap="nowrap">比赛场地：</td>
	      <td align="left" width="20%" nowrap="nowrap">
	       <s:textfield id="bscd" name="tsportSsrc.bscd" maxlength="150" size="30"/>
		</td>
    </tr>
    <tr>
	    <td align="right" nowrap="nowrap" width="10%">成绩单位：</td>
	      <td align="left" width="20%" nowrap="nowrap">
	      <s:select name="tsportSsrc.cjdw" id ="cjdw" list="getSysCode('SSRC_CJDW')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/> 				   
	      </td>
	    <td align="right" width="10%" nowrap="nowrap">第几阶段：</td>
	      <td align="left" width="20%" nowrap="nowrap">
	       <s:select name="tsportSsrc.djjd" id ="djjd" list="#{'1':'第一阶段','2':'第二阶段','3':'第三阶段'}"  headerKey="" headerValue="--请选择--"/> 
		</td>
    </tr>
  </table>
  </fieldset>
  
  <table width="70%" border="0" align="right">
    <tr> 
      <td >&nbsp;</td>
    </tr>
	<tr valign="middle"> 
	    <td height="30" align="center">
	      <ul class="btn_gn" style="float:left">
    			<li><a href="#" title="批量保存" onClick="dosave()"><span>批量保存</span></a></li>
	    		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	    	</ul>
	    </td>
	</tr>
  </table>
  </s:form>
  </div>
  </body>
</html>

