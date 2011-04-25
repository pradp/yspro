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
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript">
	listPageStyle();
	function toInit(wid,obj){
		
		var iframe = document.getElementById("scdfgzlist");
		var index_wid = document.getElementById("index_wid");
		//传入的是赛程的wid  wid 为空值时，说明是 页面加载默认显示 第一个分组的 人员
		if(wid==null || wid=='' ){
			iframe.src="../business/sportScdfgz-input.c?xmbm="+index_wid.value+"&wid=";
			document.getElementById("tr_0").style.backgroundColor="#BCD4EC";
			getzy();
		}else{
			var listData_size = document.getElementById("listData_size").value;
			
			if(listData_size != ''){
				var lenght = parseInt(listData_size);
				for(i=0;i<lenght;i++){
					document.getElementById("tr_"+i).style.backgroundColor="#F1F3F4";
				}
				obj.style.backgroundColor="#BCD4EC";
				iframe.src="../business/sportScdfgz-input.c?xmbm="+wid+"&wid=";
			}
		}
		
	}
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
	}
	function doreset()
	{	
		document.getElementById("dxmmc").value="";	
		document.getElementById("xxmmc").value="";	
		document.getElementById("zb").value="";	
		document.getElementById("xbz").value="";
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
		
	}
	function listPageStyle(){
		MM_preloadImages('<s:property value="basePath"/>/resources/images/vista/btn_goact.png',
		'<s:property value="basePath"/>/resources/images/vista/refresh_act.png',
		'<s:property value="basePath"/>/resources/images/vista/windowtop.png',
		'<s:property value="basePath"/>/resources/images/loading.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/ico.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/win_l.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/win_r.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/title_bg_left.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/title_bg_center.jpg',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/title_bg_right.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/win_b.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/win_rb.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/win_lb.gif');
		jQuery.noConflict();
		jQuery(document).ready(function(){
			//load css,put here fix ie6 bug
			jQuery('<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/ymprompt/skin/infoms/ymPrompt.css">').appendTo("head");

			jQuery("#listData tr").mouseover(function(){
						jQuery(this).addClass("over");
					})
					.mouseout(function(){
						jQuery(this).removeClass("over");
				})
			//jQuery("#listData tr:even").addClass("alt");
			jQuery("#listTable").click(function(event){
				sortColumn(event);
			});

			jQuery("#listHead th").each(function(i){
					jQuery(this).html( "<font class='sortfont'>"+jQuery(this).html()+"</font>" );
			});
			$("#listData tr td:last").addClass("rightborder");
		});
		$ = jQuery;
	}
	
	
	</script>
  </head>
<body onload="toInit()"> 
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" >
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>
   <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform">
  <s:hidden name="cd" value="%{#parameters.cd[0]}" id="cd" />
    <s:hidden name="pager.formname" value="theform"/>
     <s:hidden name="listData_size" id="listData_size" value="%{resultData.size()}" />
     <input type="hidden" value="<s:property value="tsportBsxm.dxmmc" />" id="dxmmc_later" />
    <input type="hidden" value="<s:property value="tsportBsxm.xxmmc" />" id="xxmmc_later" />
	<input type="hidden" value="<s:property value="tsportBsxm.zb" />" id="zb_later" />
	<input type="hidden" value="<s:property value="tsportBsxm.xbz" />" id="xbz_later" />
    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleftt">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="95%">
								<tr align="center">
									<td align="right" nowrap="nowrap" class="">&nbsp;项目等级：</td>
									<td align="left" nowrap="nowrap" >
										 <s:select name="tsportBsxm.xmdj" id ="xmdj" list="getXmdjList()" listKey="id"  listValue="caption" onchange="getzy2()" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;项目：</td>
									<td align="left" nowrap="nowrap" id="dxmmcContainer" >
										 <s:select name="tsportBsxm.dxmmc" id ="dxmmc" list="getAllDxmmc()" listKey="caption" onchange="getzy1()" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;级（赛）别：</td>
									<td align="left" nowrap="nowrap" id="xxmmcContainer">
										 <s:select name="tsportBsxm.xxmmc" id ="xxmmc" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
								</tr>
								<tr>
									<td align="right" nowrap="nowrap" class="">&nbsp;组别：</td>
									<td align="left" nowrap="nowrap" id="zbContainer">
										 <s:select name="tsportBsxm.zb" id ="zb" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;性别组：</td>
									<td align="left" nowrap="nowrap" id="xbzContainer">
										 <s:select name="tsportBsxm.xbz" id ="xbz" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td>&nbsp;</td>
									<td align="center" nowrap="nowrap"><ul class="btn_gn">
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
 		        <th width="10%">项目</th>
 		        <th width="10%">性别组</th>
 		        <th width="10%">组别</th>
    			<th width="30%">级（赛）别</th>
    			<th width="10%">项目等级</th>
    		</tr>
    		</thead>
    		<tbody id="listData">
 	<s:iterator value="resultData" status="status">
 				<s:if test="#status.index==0">
    				<input type="hidden" name="index_wid" id="index_wid" value="<s:property value="wid" />" />
    			</s:if>
    		<tr id="tr_<s:property value="#status.index" />" style="cursor: pointer; " onclick="toInit('<s:property value="wid" />',this)">
      			<td ><s:property value="dxmmc" /></td>      
      			<td ><s:property value="xbz"/></td> 
      			<td ><s:property value="zb"/></td>
      			<td ><s:property value="xxmmc"/></td>       		   			       			    		    
    			<td ><s:property value="xmdj"/></td> 
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
    	</s:form>
    </div>
     <iframe  id="scdfgzlist" height="350" marginwidth="0"  width="100%"  marginwidth="0" marginheight="0"  frameborder="0" ></iframe>
  </body>
</html>

