<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.bgiframe.min.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.ajaxQueue.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/thickbox-compressed.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
	listPageStyle();
	var objid = parent.tem_valueObjid;
	var objname = parent.tem_nameObjid;
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
	}
	function doreset()
	{	
		document.getElementById("dxmmc").value="";
		document.getElementById("xxmmc").value="";
		document.getElementById("zb").value="";
		document.getElementById("xbz").value="";	
		document.getElementById("xm").value="";	
		document.getElementById("xb").value="";	
		if(document.getElementById("dbd")){
			document.getElementById("dbd").value="";
		}

		document.getElementById("state").value="";
		document.getElementById("shzt").value="";	
	}

	/**
	 * 更新运动员状态为 无效运动员。
	 * AJAX 请求传统页面方式实现
	 */
	function submitUpdate(){
		var conf = window.confirm("您勾选的当前运动的报名数据将被删除，确认吗？");
		if(conf==true){
			var ids = CropCheckBoxValueAsString("selectNode");//可以多选
			if(ids.length>0){
				ajaxService.updateydy(ids,ajaxBackString);
			}else{
				alert("请勾选一条记录!");
			}
		}
	}

	/**
	 * 审核通过
	 */
	function shtg(){
		var conf = window.confirm("您确定要审核通过吗？");
		if(conf==true){
		var slength = 0;
		var a = document.getElementsByName("selectNode");
		for (var i = 0; i < a.length; i++) {
			if (a[i].checked) {
				slength += 1;
			}
		}
		if(slength>=1){
			var id = CropCheckBoxValueAsString("selectNode");
			var list = id.split(',');
			var newid = "";
			for(i=0;i<list.length;i++){
				list2 = list[i].split('_');
				if(i==0){
					newid = newid + list2[0];
				}else{
					newid = newid +','+list2[0];
				}
				
			}
			ajaxService.shtgCommit(newid,function(data){
				alert(data);
				document.forms[0].submit();                        //页面刷新
				return false;
			});
		}else{
			alert("请勾选至少一条记录!");
		}
	  }
	}
	
	/**
	 * 审核退回
	 */
	function shth(){
		var conf = window.confirm("您确定要审核退回吗？");
		if(conf==true){
		var slength = 0;
		var a = document.getElementsByName("selectNode");
		for (var i = 0; i < a.length; i++) {
			if (a[i].checked) {
				slength += 1;
			}
		}
		if(slength>=1){
			var id = CropCheckBoxValueAsString("selectNode");
			var list = id.split(',');
			var newid = "";
			for(i=0;i<list.length;i++){
				list2 = list[i].split('_');
				if(i==0){
					newid = newid + list2[0];
				}else{
					newid = newid +','+list2[0];
				}
				
			}
			ajaxService.shthCommit(newid,function(data){
				alert(data);
				document.forms[0].submit();
				return false;
			});
		}else{
			alert("请勾选至少一条记录!");
		}
	 }
	}
	
	/**
	 * 报送数据
	 */
	function bssj(){
		var conf = window.confirm("<s:property value="getDepartName()"/>代表团，您确定将您的报名数据提交吗？数据报送后将无法修改，点击“确认”提交，点击“取消”返回修改。");
		if(conf==true){
		var departid=document.getElementById("departid").value;
		ajaxService.bssjCommit(departid,function(data){
			alert(data);
			super_doSearch(true);
			return false;
		});
	 }
	}

	/**
	 *弹出确认参赛项目页面
	 */
	/*function qrbsxm(){
			var slength = 0;
			var a = document.getElementsByName("selectNode");
			for (var i = 0; i < a.length; i++) {
			    if (a[i].checked) {
			        slength += 1;
			    }
			}
			if(slength==1){
				var id = CropCheckBoxValueAsString("selectNode");
			var shzt=$("#"+id+"_shzt").val();
				input(id,"","&shzt="+shzt,"qrbsxm");
			}else{
				alert("请勾选一条记录!");
			}
		}*/
	/**
	 *弹出查看成绩分布页面
	 */
	function ckcjfb(){
			var slength = 0;
			var a = document.getElementsByName("selectNode");
			for (var i = 0; i < a.length; i++) {
			    if (a[i].checked) {
			        slength += 1;
			    }
			}
			if(slength==1){
				var id = CropCheckBoxValueAsString("selectNode");
				input(id,"","","ckcjfb");
			}else{
				alert("请勾选一条记录!");
			}
		}
	/**
	 *弹出查看成绩分布页面
	 */
	function inputcjfb(wid){
		var uri ="sportYdyxx-ckcjfb.c?wid="+wid;
		openWindow(uri,850,450);
	}
	//打印
	function toprint(){
		var slength = 0;
		var a = document.getElementsByName("selectNode");
		for (var i = 0; i < a.length; i++) {
		    if (a[i].checked) {
		        slength += 1;
		    }
		}
		if(slength==1){
			var id = CropCheckBoxValueAsString("selectNode");
			var uri ="sportYdyxx-ckcjfb.c?wid="+id+"&isprint=1";
			openWindow(uri,850,450);
		}else{
			alert("请勾选一条记录!");
		}
	}
	
	function changeState(obj){
		var id = CropCheckBoxValueAsString("selectNode");
		var ids = id.split(',');
		var tg = 0;
		var th = 0;
		var xz = 0;
		var xg = 0;
		var sc = 0;
		if(obj!=null){
			if(document.getElementById(obj.id+"_shzt")){
				var valshzt = document.getElementById(obj.id+"_shzt").value;
				if(valshzt!='1' && valshzt!='2' ){
					if(obj.checked){
						$("#"+obj.id+"_hasxxm").attr("disabled",false);
					}else{
						$("#"+obj.id+"_hasxxm").attr("disabled",true);
					}
				}
			}
		}
		for(i=0;i<ids.length;i++){
			var val = $("#"+ids[i]+"_shzt").val();
		 	if(val=="0"){
				tg++;
				th++;
			}
			if(val=="1"){
				xz++;
				xg++;
				sc++;
			}
			if(val=="2"){
				xz++;
				xg++;
				sc++;
				tg++;
			}
			if(val=="-1"){
				th++;
			}
		}
	var departid = $("#departid").val();
	var isEdit = $("#isEdit").val();
	//系统管理员
		if(departid.length==3 && isEdit!='1'){
			if(tg > 0){
				$("#shtg").attr("class","btn_gn_disable");
				$("#shtg > a").unbind('click').removeAttr('onclick').click(function() { alert('当前信息的状态限制,不允许执行此操作！'); }); 
			}else{
				$("#shtg").attr("class","");
				$("#shtg > a").unbind('click').removeAttr('onclick').click(function() { shtg(); });
			}
			if(th > 0){
				$("#shth").attr("class","btn_gn_disable");
				$("#shth > a").unbind('click').removeAttr('onclick').click(function() { alert('当前信息的状态限制,不允许执行此操作！'); }); 
			}else{
				$("#shth").attr("class","");
				$("#shth > a").unbind('click').removeAttr('onclick').click(function() { shth(); });
			}
		}
	}

	/*function modifySelected(){
		var slength = 0;
		var a = document.getElementsByName("selectNode");
		for (var i = 0; i < a.length; i++) {
		    if (a[i].checked) {
		        slength += 1;
		    }
		}
		if(slength==1){
			var id = CropCheckBoxValueAsString("selectNode");
			input(id,false,'&xm='+$('#'+id+'_xm')+'&dxmmc='+$('#'+id+'_dxmmc').val());
		}else{
			alert("请勾选一条记录!");
		}
	}*/

	 function changeDisabled(obj,ydywid,awid){
		var isEdit = $("#isEdit").val();
		 if($("#departid").val()!='320' || isEdit=='1'){
			 if(obj.checked){
				 document.getElementById("hidden_"+obj.id).removeAttribute("disabled");
				 if(document.getElementById("fenzu_"+obj.id)){
					 document.getElementById("fenzu_"+obj.id).removeAttribute("disabled");
				 }
				 $('#'+ydywid+"_"+awid).attr("checked",true);
				 $("#"+ydywid+"_"+awid+"_hasxxm").attr("disabled",false);
			 }else{
				 document.getElementById("hidden_"+obj.id).setAttribute("disabled","disabled");
				 if(document.getElementById("fenzu_"+obj.id)){
					 document.getElementById("fenzu_"+obj.id).setAttribute("disabled","disabled");
				 }
				 var i=0;
				 $(':checkbox[id^='+ydywid+'_'+awid+'_xxmmc]').each(function(){
						if($(this).attr("checked")==true){
							i++;
				 	}});
					if(i==0){
						$('#'+ydywid+"_"+awid).attr("checked",false);
						//alert(dxmmc);
						$("#"+ydywid+"_"+awid+"_hasxxm").attr("disabled",true);
					}
			 }
		}
		
	}
		function tosave(obj){
//			var url = actionName+"-saveList."+uri_suffix+"?reqtime="+new Date().getTime();
//			var fm = document.forms[0];
//			fm.action = url;
//			alert('保存成功！');
//			fm.submit();
			obj.disabled=true;
			$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
			var actionName = getActionName();;
			var actionMethod = "save";
			var url = actionName+"-saveList2."+uri_suffix+"?reqtime="+new Date().getTime();
			var fm = document.forms[0];
			fm.action = url;
			alert('保存成功！');
			fm.submit();
		}

	    //导出（本次查询结果）
		function toExps(){
		  var conf = window.confirm("您确定要导出已报名的数据吗？");
		  if(conf == true){
			var departid = '';
			var dxmmc = '';
			var xxmmc = '';
			var xm = '';
			var xb = '';
			var state = '';
			var shzt= '';
			var xbz= '';
			var zb= '';
			var reqTitle= '';
			var reportServer = '';
			if(document.getElementById("dbd2")){
				 departid = $("#dbd2").val();
			}
			if(document.getElementById("xxmmc2")){
				xxmmc = $("#xxmmc2").val();
			}
			if(document.getElementById("dxmmc2")){
				dxmmc = $("#dxmmc2").val();
			}
			if(document.getElementById("xm2")){
				 xm = $("#xm2").val();
			}
			if(document.getElementById("xb2")){
				 xb = $("#xb2").val();
			}
			if(document.getElementById("state2")){
				state = $("#state2").val();
			}
			if(document.getElementById("shzt2")){
				shzt = $("#shzt2").val();
			}
			if(document.getElementById("xbz2")){
				xbz = $("#xbz2").val();
			}
			if(document.getElementById("zb2")){
				zb = $("#zb2").val();
			}
			if(document.getElementById("reqTitle2")){
				reqTitle = $("#reqTitle2").val();
			}
			if(document.getElementById("reportServer")){
				reportServer = $("#reportServer").val();
			}
			var  url = reportServer+"?raq=/report_ecbm.raq&title='"+reqTitle+"'&filter= ";
			if(departid!=''){
				url = url+" and  b.yddbm like '"+departid+"%25' ";
			}
			if(dxmmc!=''){
				url = url+" and a.dxmmc='"+dxmmc+"' ";
			}
			if(xxmmc!=''){
				url = url+ " and c.xxmmc='"+xxmmc+"' ";
			}
			if(zb!=''){
				url = url+" and c.zb='"+zb+"' ";
			}
			if(xbz!=''){
				url = url+" and c.xbz='"+xbz+"' ";
			}
			if(xm!=''){
				url = url+" and b.xm like '%25"+xm+"%25' ";
			}
			if(xb!=''){
				url = url+" and b.xb='"+xb+"' ";
			}
			if('0'==state){
				url = url+" and (b.state != '1' or b.state is null) ";
			}else if(state!=''){
				url = url+ " and b.state = '"+state+"' ";
			}
			if(shzt!=''){
				url = url+" and b.shzt='"+shzt+"' ";
			}
			omvc = window.open(url, 'newwindow', 'height=600, width=800, top=50, left=100, toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
			omvc.focus();
		}}

		   //导出
		function toExps2(){
		  var conf = window.confirm("您确定要导出已报名的数据吗？");
		  if(conf == true){
			var departid = '';
			var reqTitle= '';
			var reportServer = '';
			if(document.getElementById("dbd2")){
				 departid = $("#dbd2").val();
			}
			if(document.getElementById("reqTitle1")){
				reqTitle = $("#reqTitle1").val();
			}
			if(document.getElementById("reportServer")){
				reportServer = $("#reportServer").val();
			}
			var  url = reportServer+"?raq=/report_ecbm.raq&title='"+reqTitle+"'&filter= ";
			if(departid!=''){
				url = url+" and  b.yddbm like'"+departid+"%25' ";
			}
				url = url+ " and b.state='1' and (b.shzt='1' or b.shzt='2') ";
			//alert(url);
			omvc = window.open(url, 'newwindow', 'height=600, width=800, top=50, left=200, toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
			omvc.focus();
		}}
//大项目 小项目 组别 性别组 关联
		var i =0;
		function getzy1(){
			i=1;
			document.getElementById("zb_later").value="";	
			document.getElementById("xbz_later").value="";
			document.getElementById("xxmmc_later").value="";		
			getzy();
		}
		function getzy(){
			var dxmmc=document.getElementById("dxmmc").value;
			if(dxmmc!=""){
		   		changeSelectHtml(dxmmc);
		   	}
		}
		function changeSelectHtml(obj){
				ajaxService.getBsxmZb(obj,cd);
				ajaxService.getSelectxxmmc(obj,cb);
		}
		function cd(result){
			var changeSelectId = "zb";
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('zb');
			DWRUtil.addOptions( changeSelectId, result,'id','caption');
			var obj = document.getElementById("zb_later");
			if(obj.value != '' && i==0){
				DWRUtil.setValue(changeSelectId,obj.value);
				}
			$ = jQuery;
		}
		
		function cb(result){
			var changeSelectId = "xxmmc";
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			jQuery("#xxmmcContainer").html('<select name="tsportYdybmxmCc.xxmmc" id="xxmmc"><option value="">--请选择--</option></select>');
			DWRUtil.addOptions( changeSelectId, result );
			var obj = document.getElementById("xxmmc_later");
			if(obj.value != '' && i==0){
				DWRUtil.setValue(changeSelectId,obj.value);
			}
			$ = jQuery;
		}
		function tochangeChecked(id,dxmmc){
			//alert(id+"_"+dxmmc);
			var i=0;
			var j=0;
			//alert(id);
			$(':checkbox[id^='+id+'_]').each(function(){
				//i++;
				$(this).attr("disabled","true");
			})
			$(':checkbox[id^=hidden_'+dxmmc+'_'+id+'_]').each(function(){
				$(this).attr("disabled","true");
			})
			$('select[id$=_'+dxmmc+']').each(function(){
			//	i++;
				$(this).attr("disabled","true");
			})
			//alert(i);
		}
		/**
		 * 全选
		 */
		function doSelectAll(){
		    var parentChecked = document.getElementsByName("selectAll")[0].checked;
		    var nodes = document.getElementsByName("selectNode");
		    for (var i = 0; i < nodes.length; i++) {
		        var node = nodes[i];
		        if(node.disabled==false){
		        	 node.checked = parentChecked;
			     }
		    }
		    return true;
		}
		function changeStateAll(){
			if(doSelectAll()){
				changeState();
			}
		}

		function changeCheckbox(ydywid,st,awid){
			if(st!='0'){
				$("#"+ydywid+"_"+awid).attr("checked",true);
				$("#"+ydywid+"_"+awid+"_hasxxm").attr("disabled",false);
			}
			$("#"+ydywid+"_"+awid).attr("disabled","true");
		}
		function changeCheckboxYES(ydywid,st,awid){
				$("#"+ydywid+"_"+awid).attr("checked","true");
				$("#"+ydywid+"_"+awid+"_hasxxm").attr("disabled",false);
		}

		function tochangeListCheckbox(ydywid,awid){
			$(':checkbox[id^='+ydywid+'_'+awid+'_xxmmc]').each(function(){
				$(this).attr("disabled",true);
			});
		}
	</script>
  </head>
<body  onload="getzy()" > 
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
    <s:hidden id="departid" value="%{getDepartID()}"></s:hidden>
  	<s:hidden  value="%{#parameters.cd[0]}" id="cd" />
  	<s:hidden  value="%{@java.net.URLEncoder@encode(tsportYdybmxmCc.dbd,'utf-8')}" id="dbd2" />
  	<s:hidden  value="%{#reqTitle1}" id="reqTitle1" />
  	<s:hidden  value="%{#reqTitle2}" id="reqTitle2" />
  	<s:hidden  value="%{@java.net.URLEncoder@encode(tsportYdybmxmCc.dxmmc,'utf-8')}" id="dxmmc2" />
  	<s:hidden  value="%{@java.net.URLEncoder@encode(tsportYdybmxmCc.xm,'utf-8')}" id="xm2" />
  	<s:hidden  value="%{tsportYdybmxmCc.xb}" id="xb2" />
  	<s:hidden  value="%{tsportYdybmxmCc.state}" id="state2" />
  	<s:hidden  value="%{tsportYdybmxmCc.shzt}" id="shzt2" />
  	<s:hidden  value="%{@java.net.URLEncoder@encode(tsportYdybmxmCc.xxmmc,'utf-8')}" id="xxmmc2" />
  	<s:hidden  value="%{tsportYdybmxmCc.zb}" id="zb2" />
  	<s:hidden  value="%{tsportYdybmxmCc.xbz}" id="xbz2" />
  	<s:hidden  value="%{#reportServer}" id="reportServer" />
  	<s:hidden  name="tsportYdybmxmCc.isEdit" id="isEdit" />
    <input type="hidden" value="<s:property value="tsportYdybmxmCc.xxmmc" />" id="xxmmc_later" />
    <input type="hidden" value="<s:property value="tsportYdybmxmCc.dxmmc" />" id="dxmmc_later" />
    <input type="hidden" value="<s:property value="tsportYdybmxmCc.zb" />" id="zb_later" />
	<!--是否可保存（用于管理员 对上报的数据做修改） -->
	<input type="hidden" value="<s:property value="tsportYdybmxmCc.isEdit" />" id="isEdit" />
    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleftt">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
								<s:if test="getDepartID().length()==3">
									<td align="right" nowrap="nowrap" class="">&nbsp;代表团：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportYdybmxmCc.dbd" id="dbd" list="getDbd()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>

								</s:if>
									<%--<td align="right" nowrap="nowrap" class="">&nbsp;项目：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportYdybmxmCc.dxmmc" id="dxmmc" list="getAllDxmmc()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--" />
									</td>--%>
									
									<td align="right" nowrap="nowrap" class="" width="10%">&nbsp;项目：</td>
									<td align="left" nowrap="nowrap" id="dxmmcContainer" width="10%">
										<s:select name="tsportYdybmxmCc.dxmmc" id ="dxmmc" list="getAllDxmmc()" listKey="caption" onchange="getzy1()" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;组别：</td>
									<td align="left" nowrap="nowrap" id="zbContainer">
										 <s:select name="tsportYdybmxmCc.zb" id ="zb" list="#{}" listKey="caption" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;性别：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportYdybmxmCc.xb" id="xb" list="getSysCode('XB')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="" width="10%">&nbsp;级（赛）别：</td>
									<td align="left" nowrap="nowrap" id="xxmmcContainer" width="20%">
										 <s:select name="tsportYdybmxmCc.xxmmc" id ="xxmmc" list="#{}" listKey="caption" listValue="caption" headerKey="" headerValue="-------请选择-------"/>
									</td>
								</tr>
								<tr>
									<td align="right" nowrap="nowrap" class="">&nbsp;姓名：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield name="tsportYdybmxmCc.xm" id="xm" maxlength="20" size="10"/>
									</td>
								
									<td align="right" nowrap="nowrap" class="">&nbsp;报名状态：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportYdybmxmCc.state" id ="state" list="getSysCode('STATE')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;审核状态：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportYdybmxmCc.shzt" id ="shzt" list="getSysCode('YDY_SHZT')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="center" rowspan="2" nowrap="nowrap"><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="super_doSearch(true)" style="float:  right;"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
										</li>
										</ul>
									</td>
									<td align="center" rowspan="2" nowrap="nowrap"><ul class="btn_gn">
										<li>
											<a href="#" title="重置" onClick="doreset()" style="float:  left;"
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
	  <tr height="25" align="left">
	        <td colspan="10">&nbsp;&nbsp;&nbsp;<b>统计：</b>本次查询共<s:property value="#countYdy" />人，其中已报名<s:property value="#countYbYdy"/>人，<s:property value="#countXm"/>项目
	        </td>
	  </tr>
    		<tr>
    			<td height="30px" colspan="10">
    			<ul class="btn_gn">
			    <s:if test="%{getDepartID().length()==3 && (tsportYdybmxmCc==null || tsportYdybmxmCc.isEdit==null || tsportYdybmxmCc.isEdit=='') }">
				    <s:if test="#shzt==2||#zt==3">
				    <li class="btn_gn_disable" id="shtg"><a href="#" title="审核通过 " onClick="alert('当前信息的状态限制,不允许执行此操作!');" name="create1"><span>审核通过 </span></a></li>
				    </s:if>
				    <s:else>
				    <li id="shtg"><a href="#" title="审核通过" onClick="shtg()" name="shtg0"><span>审核通过 </span></a></li>
				    </s:else>
				    <s:if test="#shzt==-1||#zt==3">
				    <li class="btn_gn_disable" id="shth"><a href="#" title="审核退回 " onClick="alert('当前信息的状态限制,不允许执行此操作!');" name="create1"><span>审核退回 </span></a></li>
				    </s:if>
				    <s:else>
				    <li id="shth"><a href="#" title="审核退回"  onClick="shth()" name="shth0"><span>审核退回 </span></a></li>
				    </s:else>
			    </s:if>
			    <s:elseif test="%{getDepartID().length()==6}">
			    
				    <s:if test="#shzt==1">
				   		<li class="btn_gn_disable" ><a href="#" title="保存" onClick="alert('当前信息的状态限制,不允许执行此操作!')"><span>保存</span></a></li>
				    	<li class="btn_gn_disable" id="sjbs"><a href="#" title="数据报送 " onClick="alert('当前信息的状态限制,不允许执行此操作!');" name="create1"><span>数据报送 </span></a></li>
				    </s:if>
				    <s:else>
					    <li><a href="#" title="保存" onClick="tosave(this)"><span>保存</span></a></li>
					    <li id="sjbs"><a href="#" title="数据报送 " onClick="bssj()" name="bssj0"><span>数据报送</span></a></li>
				    </s:else>
			    </s:elseif>
			    <s:elseif test="tsportYdybmxmCc.isEdit==1">
			    	 <li><a href="#" title="保存" onClick="tosave(this)"><span>保存</span></a></li>
			    </s:elseif>
			    <li><a href="#" onclick="toExps()" title="导出/打印（本次查询数据）" ><span>导出/打印（本次查询数据）</span></a></li>
			    <li><a href="#" onclick="toExps2()" title="导出/打印（全部已确认数据）" ><span>导出/打印（全部已确认数据）</span></a></li>

			    <li><div id="mes" style="font-size:12px; width: 200px; "></div></li>
			   </ul>
    	     </td>
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
  				<s:if test="%{getDepartID().length()==3 && (tsportYdybmxmCc==null || tsportYdybmxmCc.isEdit==null || tsportYdybmxmCc.isEdit=='')}" >
  					<th height="20px" width="3%"><s:checkbox name="selectAll" onclick="changeStateAll()"  /></th>
  				</s:if>
  				<s:else>
  					<th height="20px" width="3%">&nbsp;</th>
  				</s:else>
    		
 		        <th width="8%">姓名</th>
 		        <th width="6%">性别</th>
 		        <th width="10%">大项目</th>
 		        <th width="10%">代表团</th>
    			<th width="10%">注册证号</th>
    			<th width="12%">身份证号</th>
    			<th width="8%">组别</th>
    			<th width="8%">状态</th>
    			<th width="8%">审核状态</th>
    			<%--<th width="10%">操作</th>
    			--%>
    		</tr>
    		</thead>
    		<tbody id="listData">
 			<s:iterator value="resultData" status="st">
    		<tr>
     			<td><s:checkbox id="%{ydywid}_%{awid}" name="selectNode" fieldValue="%{ydywid}_%{awid}" onclick="changeState(this)"/></td>
      			<td nowrap="nowrap" colspan="9">
						<table width="100%" border="0"  cellpadding="0" cellspacing="0" >
							<tr>
								<td align="center" width="8%"><a href="javascript:inputcjfb('<s:property value="ydywid"/>')">
									<FONT color="blue"><s:property value="xm" /></FONT></a>
									<!-- 
									<s:hidden id="%{resultData[#st.index][4]}_xm" value="%{resultData[#st.index][1]}" ></s:hidden>
									 -->
									<s:hidden name="ydywid" value="%{ydywid}_%{awid}" ></s:hidden>&nbsp;</td>
								<td align="center" width="6%"><s:property value="xb" /></td>
				      			<td align="center" width="10%">
				      				<s:property value="dxmmc" />
				      				<s:hidden name="%{ydywid}_%{awid}_dxmmc" id="%{ydywid}_dxmmc" value="%{dxmmc}" ></s:hidden>
				      				<% int fenzu = 0; %>
				      				<s:if test="dxmmc=='乒乓球' || dxmmc=='羽毛球' ">
				      					<% fenzu=1; %>
				      				</s:if>
				      			</td> 
				      			<td align="center" width="10%"><s:property value="dbd" /></td>    		   			       			    		    
				    			<td align="center" width="10%"><s:property value="zch" /></td>
				    			<td align="center" width="12%"><s:property value="sfzh" /></td>
				    			<td align="center" width="8%"><s:property value="zb_cn" />&nbsp;
				    					<s:hidden name="%{ydywid}_%{awid}_zb" id="%{ydywid}_%{awid}_zb" value="%{zb}" ></s:hidden>
				    			</td>
				    			<td align="center" width="8%">
				    				<% int bmzt = 0; %>
					    				<s:if test="selectedinfo!=null && selectedinfo!='' " >
					    					<s:set name="bmtest" value="selectedinfo.split(',')"/>
					    					<s:iterator value="#bmtest" status="ss">
												<s:set name="bmss" value="%{#bmtest[#ss.index].split('_')}"/>
													<s:if test="#bmss[0]!=null && #bmss[0]!=''" >
														<s:if test="%{#bmss[0]==bsxmwid1 || #bmss[0]==bsxmwid2 || #bmss[0]==bsxmwid3 || #bmss[0]==bsxmwid4 || #bmss[0]==bsxmwid5 || #bmss[0]==bsxmwid6 || #bmss[0]==bsxmwid7 || #bmss[0]==bsxmwid8 ||#bmss[0]==bsxmwid9 || #bmss[0]==bsxmwid10 || #bmss[0]==bsxmwid11 || #bmss[0]==bsxmwid12 ||#bmss[0]==bsxmwid13}" >
															<% bmzt=1; %>
														</s:if>
													</s:if>
											</s:iterator>
					    				</s:if>
					    				<% if(bmzt>0){
					    					%>已报名<%
					    				}else{
					    					%>
					    					  未报名
					    					<%
					    				} %>
				    				</td>
				    			<td align="center" width="8%"><s:property value="shzt" />&nbsp;
				    			<s:hidden id="%{ydywid}_%{awid}_shzt" name="%{ydywid}_%{awid}_shzt" value="%{shzt2}" ></s:hidden>
				    			</td>
							
    			<%--<td nowrap="nowrap"> <s:property value="resultData[#st.index][7]" />&nbsp;
						<a href="javascript:input('<s:property value="ydywid"/>',false,'&xm=<s:property value="xm" />&dxmmc=<s:property value="dxmmc" />')">
						<FONT color="blue">登记报名</FONT></a>&nbsp;
				</td>--%>
							</tr>
							<tr>
							<td colspan="9">
							<% 
								int bz = 0;
								int state = 0;
								int kk=0;
							%>
							<s:if test="selectedinfo!=null && selectedinfo!='' " >
							<input type="hidden"  name="<s:property value="%{ydywid}" />_<s:property value="%{awid}"/>_hasxxm" value="1" id="<s:property value="%{ydywid}" />_<s:property value="%{awid}"/>_hasxxm" value="1"  />
								<s:set name="sfbjydhcj" value="selectedinfo.split(',')"/>
										<strong>&nbsp;&nbsp;&nbsp;&nbsp;报名项目：</strong>
										<%
											int st_10 =0;
											int st_12 =0;
											int st_14 =0;
											int st_16 =0;
											int st_18 =0;
											int st_20 =0;
											int st_22 =0;
											int st_24 =0;
											int st_26 =0;
											int st_33 =0;
											int st_35 =0;
											int st_37 =0;
											int st_39 =0;
											int sfxs1  =0;
											int sfxs2  =0;
											int sfxs3  =0;
											int sfxs4  =0;
											int sfxs5  =0;
											int sfxs6  =0;
											int sfxs7  =0;
											int sfxs8  =0;
											int sfxs9  =0;
											int sfxs10  =0;
											int sfxs11  =0;
											int sfxs12  =0;
											int sfxs13  =0;
										%>
										<s:if test="%{xxmmc1.indexOf('双打')!=-1}">
												<% sfxs1=1; %>
										</s:if>
										<s:if test="%{xxmmc2.indexOf('双打')!=-1}">
												<% sfxs2=1; %>
										</s:if>
										<s:if test="%{xxmmc3.indexOf('双打')!=-1}">
												<% sfxs3=1; %>
										</s:if>
										<s:if test="%{xxmmc4.indexOf('双打')!=-1}">
												<% sfxs4=1; %>
										</s:if>
										<s:if test="%{xxmmc5.indexOf('双打')!=-1}">
												<% sfxs5=1; %>
										</s:if>
										<s:if test="%{xxmmc6.indexOf('双打')!=-1}">
												<% sfxs6=1; %>
										</s:if>
										<s:if test="%{xxmmc7.indexOf('双打')!=-1}">
												<% sfxs7=1; %>
										</s:if>
										<s:if test="%{xxmmc8.indexOf('双打')!=-1}">
												<% sfxs8=1; %>
										</s:if>
										<s:if test="%{xxmmc9.indexOf('双打')!=-1}">
												<% sfxs9=1; %>
										</s:if>
										<s:if test="%{xxmmc10.indexOf('双打')!=-1}">
												<% sfxs10=1; %>
										</s:if>
										<s:if test="%{xxmmc11.indexOf('双打')!=-1}">
												<% sfxs11=1; %>
										</s:if>
										<s:if test="%{xxmmc12.indexOf('双打')!=-1}">
												<% sfxs12=1; %>
										</s:if>
										<s:if test="%{xxmmc13.indexOf('双打')!=-1}">
												<% sfxs13=1; %>
										</s:if>
										<s:iterator value="#sfbjydhcj" status="ss">
										<s:set name="xxm_fenzu" value="%{#sfbjydhcj[#ss.index].split('_')}"/>
											<s:if test="%{#xxm_fenzu[0]==bsxmwid1}" >
												<% st_10=1;%>
												<s:set name="xmmFenzu1" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											
											<s:if test="%{#xxm_fenzu[0]==bsxmwid2}" >
												<% st_12=1; %>
												<s:set name="xmmFenzu2" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											
											<s:if test="%{#xxm_fenzu[0]==bsxmwid3}" >
												<% st_14=1; %>
												<s:set name="xmmFenzu3" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											
											<s:if test="%{#xxm_fenzu[0]==bsxmwid4}" >
												<% st_16=1; %>
												<s:set name="xmmFenzu4" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											
											<s:if test="%{#xxm_fenzu[0]==bsxmwid5}" >
												<% st_18=1; %>
												<s:set name="xmmFenzu5" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											
											<s:if test="%{#xxm_fenzu[0]==bsxmwid6}" >
												<% st_20=1; %>
												<s:set name="xmmFenzu6" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											
											<s:if test="%{#xxm_fenzu[0]==bsxmwid7}" >
												<% st_22=1; %>
												<s:set name="xmmFenzu7" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											
											<s:if test="%{#xxm_fenzu[0]==bsxmwid8}" >
												<% st_24=1; %>
												<s:set name="xmmFenzu8" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											
											<s:if test="%{#xxm_fenzu[0]==bsxmwid9}" >
												<% st_26=1; %>
												<s:set name="xmmFenzu9" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											<s:if test="%{#xxm_fenzu[0]==bsxmwid10}" >
												<% st_33=1; %>
												<s:set name="xmmFenzu10" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											<s:if test="%{#xxm_fenzu[0]==bsxmwid11}" >
												<% st_35=1; %>
												<s:set name="xmmFenzu11" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											<s:if test="%{#xxm_fenzu[0]==bsxmwid12}" >
												<% st_37=1; %>
												<s:set name="xmmFenzu12" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
											<s:if test="%{#xxm_fenzu[0]==bsxmwid13}" >
												<% st_39=1; %>
												<s:set name="xmmFenzu13" value="%{#xxm_fenzu[1]==null ? '':#xxm_fenzu[1]}" />
											</s:if>
										</s:iterator>
									<s:if test="%{xxmmc1!=null && xxmmc1!=''}">
										<% 
											state ++;
										if(st_10==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc1" id="%{ydywid}_%{awid}_xxmmc1" value="1"  onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc1" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc1" value="<s:property value='bsxmwid1' />" />
											<% if(fenzu==1&&sfxs1==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid3}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc1" value="%{#xmmFenzu1}" headerKey="" headerValue="请选择"></s:select>
												<%}%>
											<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc1" id="%{ydywid}_%{awid}_xxmmc1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc1" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc1"  disabled="disabled" value="<s:property value='bsxmwid1' />" />
											<% if(fenzu==1&&sfxs1==1){%>
														组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid3}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc1" value="%{#xmmFenzu1}"headerKey="" headerValue="请选择"></s:select>
												<%}%>
											<%}%>
									</s:if><s:else>&nbsp;</s:else>
					      			<s:if test="%{xxmmc2!=null && xxmmc2!=''}">
					      				<%
					      				state ++;
					      				if(st_12==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc2" id="%{ydywid}_%{awid}_xxmmc2" value="1"  onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc2" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc2"   value="<s:property value='bsxmwid2' />" />
											<% if(fenzu==1&&sfxs2==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid2}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc2" value="%{#xmmFenzu2}"headerKey="" headerValue="请选择"></s:select>
												<%}%>
											<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc2" id="%{ydywid}_%{awid}_xxmmc2" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc2" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc2"  disabled="disabled" value="<s:property value='bsxmwid2' />" />
											<% if(fenzu==1&&sfxs2==1){%>
														组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid2}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc2" value="%{#xmmFenzu2}"headerKey="" headerValue="请选择"></s:select>
												<%}%>
										<%}%>
										</s:if><s:else>&nbsp;</s:else>
									<s:if test="%{xxmmc3!=null && xxmmc3!=''}">
										<%
										state ++;
										if(st_14==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc3" id="%{ydywid}_%{awid}_xxmmc3" value="1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc3" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc3" value="<s:property value='bsxmwid3' />" />
											<% if(fenzu==1&&sfxs3==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid3}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc3" value="%{#xmmFenzu3}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%}else{%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc3" id="%{ydywid}_%{awid}_xxmmc3" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc3" />
										<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc3"  disabled="disabled" value="<s:property value='bsxmwid3' />" />
										<% if(fenzu==1&&sfxs3==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid3}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc3" value="%{#xmmFenzu3}"headerKey="" headerValue="请选择"></s:select>
										<%}%>
										<%}%>
									</s:if><s:else>&nbsp;</s:else>
									<s:if test="%{xxmmc4!=null && xxmmc4!=''}">
										
										<% 
										state ++;
										if(st_16==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc4" id="%{ydywid}_%{awid}_xxmmc4" value="1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc4" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc4"  value="<s:property value='bsxmwid4' />" />
											<% if(fenzu==1&&sfxs4==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid4}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc4" value="%{#xmmFenzu4}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
											<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc4" id="%{ydywid}_%{awid}_xxmmc4" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc4" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc4"  disabled="disabled" value="<s:property value='bsxmwid4' />" />
											<% if(fenzu==1&&sfxs4==1){%>
														组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid4}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc4" value="%{#xmmFenzu4}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}%>
									</s:if><s:else>&nbsp;</s:else>
									<s:if test="%{xxmmc5!=null && xxmmc5!=''}">
										<% 
										state ++;
										if(st_18==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc5" id="%{ydywid}_%{awid}_xxmmc5" value="1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc5" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc5"  value="<s:property value='bsxmwid5' />" />
											<% if(fenzu==1&&sfxs5==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid5}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc5" value="%{#xmmFenzu5}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc5" id="%{ydywid}_%{awid}_xxmmc5" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc5" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc5"  disabled="disabled" value="<s:property value='bsxmwid5' />" />
											<% if(fenzu==1&&sfxs5==1){%>
														组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid5}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc5" value="%{#xmmFenzu5}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}%>
									</s:if><s:else>&nbsp;</s:else>
									<s:if test="%{xxmmc6!=null && xxmmc6!=''}">
										<%
										state ++;
										if(st_20==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc6" id="%{ydywid}_%{awid}_xxmmc6" value="1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc6" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc6"   value="<s:property value='bsxmwid6' />" />
											<% if(fenzu==1&&sfxs6==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid6}" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc6" value="%{#xmmFenzu6}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc6" id="%{ydywid}_%{awid}_xxmmc6" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc6" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc6"  disabled="disabled" value="<s:property value='bsxmwid6' />" />
											<% if(fenzu==1&&sfxs6==1){%>
														组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid6}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc6" value="%{#xmmFenzu6}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}%>
									</s:if><s:else>&nbsp;</s:else>
									<s:if test="%{xxmmc7!=null && xxmmc7!=''}">
										<%
										state ++;
										if(st_22==1){
										%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc7" id="%{ydywid}_%{awid}_xxmmc7" value="1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc7" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc7"   value="<s:property value='bsxmwid7' />" />
											<% if(fenzu==1&&sfxs7==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid7}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc7" value="%{#xmmFenzu7}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc7" id="%{ydywid}_%{awid}_xxmmc7" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc7" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc7"  disabled="disabled" value="<s:property value='bsxmwid7' />" />
											<% if(fenzu==1&&sfxs7==1){%>
														组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid7}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc7" value="%{#xmmFenzu7}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}%>
									</s:if><s:else>&nbsp;</s:else>
									<s:if test="%{xxmmc8!=null && xxmmc8!=''}">
										<%
										state ++;
										if(st_24==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc8" id="%{ydywid}_%{awid}_xxmmc8" value="1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc8" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc8"   value="<s:property value='bsxmwid8' />" />
											<% if(fenzu==1&&sfxs8==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid8}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc8" value="%{#xmmFenzu8}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc8" id="%{ydywid}_%{awid}_xxmmc8" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc8" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc8"  disabled="disabled" value="<s:property value='bsxmwid8' />" />
											<% if(fenzu==1&&sfxs8==1){%>
														组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid8}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc8" value="%{#xmmFenzu8}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}%>
									</s:if><s:else>&nbsp;</s:else>
									<s:if test="%{xxmmc9!=null && xxmmc9!=''}">
										<% 
										state ++;
										if(st_26==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc9" id="%{ydywid}_%{awid}_xxmmc9" value="1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc9" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc9"  value="<s:property value='bsxmwid9' />" />
											<% if(fenzu==1&&sfxs9==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid9}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc9" value="%{#xmmFenzu9}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc9" id="%{ydywid}_%{awid}_xxmmc9" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc9" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc9"  disabled="disabled" value="<s:property value='bsxmwid9' />" />
											<% if(fenzu==1&&sfxs9==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid9}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc9" value="%{#xmmFenzu9}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}%>
									</s:if><s:else>&nbsp;</s:else>
									<s:if test="%{xxmmc10!=null && xxmmc10!=''}">
										<% 
										state ++;
										if(st_33==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc10" id="%{ydywid}_%{awid}_xxmmc10" value="1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc10" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc10"  value="<s:property value='bsxmwid10' />" />
											<% if(fenzu==1&&sfxs10==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid10}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc10" value="%{#xmmFenzu10}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc10" id="%{ydywid}_%{awid}_xxmmc10" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc10" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc10"  disabled="disabled" value="<s:property value='bsxmwid10' />" />
											<% if(fenzu==1&&sfxs10==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid10}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc10" value="%{#xmmFenzu10}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}%>
									</s:if><s:else>&nbsp;</s:else>
									<s:if test="%{xxmmc11!=null && xxmmc11!=''}">
										<% 
										state ++;
										if(st_35==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc11" id="%{ydywid}_%{awid}_xxmmc11" value="1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc11" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc11"  value="<s:property value='bsxmwid11' />" />
											<% if(fenzu==1&&sfxs11==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid11}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc11" value="%{#xmmFenzu11}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc11" id="%{ydywid}_%{awid}_xxmmc11" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc11" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc11"  disabled="disabled" value="<s:property value='bsxmwid11' />" />
											<% if(fenzu==1&&sfxs11==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid11}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc11" value="%{#xmmFenzu11}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}%>
									</s:if><s:else>&nbsp;</s:else>
									<s:if test="%{xxmmc12!=null && xxmmc12!=''}">
										<%
										state ++;
										if(st_37==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc12" id="%{ydywid}_%{awid}_xxmmc12" value="1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc12" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc12"  value="<s:property value='bsxmwid12' />" />
											<% if(fenzu==1&&sfxs12==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid12}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc12" value="%{#xmmFenzu12}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc12" id="%{ydywid}_%{awid}_xxmmc12" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc12" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc12"  disabled="disabled"  value="<s:property value='bsxmwid12' />" />
											<% if(fenzu==1&&sfxs12==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid12}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc12" value="%{#xmmFenzu12}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}%>
									</s:if><s:else>&nbsp;</s:else>
									<s:if test="%{xxmmc13!=null && xxmmc13!=''}">
										<%
										state ++;
										if(st_39==1){
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc13" id="%{ydywid}_%{awid}_xxmmc13" value="1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc13" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc13"  value="<s:property value='bsxmwid13' />" />
											<% if(fenzu==1&&sfxs13==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid13}"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc13" value="%{#xmmFenzu13}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}else{
											%>
											<s:checkbox name="%{ydywid}_%{awid}_xxmmc13" id="%{ydywid}_%{awid}_xxmmc13" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc13" />
											<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc13"  disabled="disabled" value="<s:property value='bsxmwid13' />" />
											<% if(fenzu==1&&sfxs13==1){%>
													组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid13}"  disabled="true"  list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc13" value="%{#xmmFenzu13}"headerKey="" headerValue="请选择"></s:select>
											<%}%>
										<%
										}%>
									</s:if><s:else>&nbsp;</s:else>
							
								<s:if test="%{shzt2==1|| shzt2==2}">
									<s:if test="%{getDepartID().length()>3 || tsportYdybmxmCc.isEdit==1}" >
											<script>changeCheckbox('<s:property value="%{ydywid}" />','','<s:property value="%{awid}" />')</script>
								</s:if>
							</s:if>
							</s:if>
							<s:else>
									<!-- 由于后台判断是否设为未报名 -->
									<input type="hidden"  name="<s:property value="%{ydywid}" />_<s:property value="%{awid}"/>_hasxxm" value="1" id="<s:property value="%{ydywid}" />_<s:property value="%{awid}"/>_hasxxm" value="1" disabled="true" />
									<strong>&nbsp;&nbsp;&nbsp;&nbsp;报名项目：</strong>
									<%
											int sfxs1  =0;
											int sfxs2  =0;
											int sfxs3  =0;
											int sfxs4  =0;
											int sfxs5  =0;
											int sfxs6  =0;
											int sfxs7  =0;
											int sfxs8  =0;
											int sfxs9  =0;
											int sfxs10  =0;
											int sfxs11  =0;
											int sfxs12  =0;
											int sfxs13  =0;
										%>
										<s:if test="%{dxmmc.indexOf('双打')!=-1}">
												<% sfxs1=1; %>
										</s:if>
										<s:if test="%{xxmmc2.toString().indexOf('双打')!=-1}">
												<% sfxs2=1; %>
										</s:if>
										<s:if test="%{xxmmc3.toString().indexOf('双打')!=-1}">
												<% sfxs3=1; %>
										</s:if>
										<s:if test="%{xxmmc4.toString().indexOf('双打')!=-1}">
												<% sfxs4=1; %>
										</s:if>
										<s:if test="%{xxmmc5.toString().indexOf('双打')!=-1}">
												<% sfxs5=1; %>
										</s:if>
										<s:if test="%{xxmmc6.toString().indexOf('双打')!=-1}">
												<% sfxs6=1; %>
										</s:if>
										<s:if test="%{xxmmc7.toString().indexOf('双打')!=-1}">
												<% sfxs7=1; %>
										</s:if>
										<s:if test="%{xxmmc8.toString().indexOf('双打')!=-1}">
												<% sfxs8=1; %>
										</s:if>
										<s:if test="%{xxmmc9.toString().indexOf('双打')!=-1}">
												<% sfxs9=1; %>
										</s:if>
										<s:if test="%{xxmmc10.toString().indexOf('双打')!=-1}">
												<% sfxs10=1; %>
										</s:if>
										<s:if test="%{xxmmc11.toString().indexOf('双打')!=-1}">
												<% sfxs11=1; %>
										</s:if>
										<s:if test="%{xxmmc12.toString().indexOf('双打')!=-1}">
												<% sfxs12=1; %>
										</s:if>
										<s:if test="%{xxmmc13.toString().indexOf('双打')!=-1}">
												<% sfxs13=1; %>
										</s:if>
								<s:if test="%{xxmmc1!=null && xxmmc1!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc1" id="%{ydywid}_%{awid}_xxmmc1" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc1" />
								<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc1" disabled="disabled" value="<s:property value='bsxmwid1' />" />
								<%
								state ++;
								if(fenzu==1&&sfxs1==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid1}"  disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc1" headerKey="" headerValue="请选择"></s:select>
								<%}%>
								</s:if><s:else>&nbsp;</s:else>
				      			<s:if test="%{xxmmc2!=null && xxmmc2!=''}">
				      				<s:checkbox name="%{ydywid}_%{awid}_xxmmc2" id="%{ydywid}_%{awid}_xxmmc2" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc2" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc2" disabled="disabled"   value="<s:property value='bsxmwid2' />" />
									<% 
									state ++;
									if(fenzu==1&&sfxs2==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid2}" disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc2" headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								<s:if test="%{xxmmc3!=null && xxmmc3!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc3" id="%{ydywid}_%{awid}_xxmmc3" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc3" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc3"  disabled="disabled" value="<s:property value='bsxmwid3' />" />
									<%
									state ++;
									if(fenzu==1&&sfxs3==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid3}"   disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc3"headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								<s:if test="%{xxmmc4!=null && xxmmc4!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc4" id="%{ydywid}_%{awid}_xxmmc4" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc4" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc4"  disabled="disabled" value="<s:property value='bsxmwid4' />" />
									<%
									state ++;
									if(fenzu==1&&sfxs4==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid4}"  disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc4" headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								<s:if test="%{xxmmc5!=null && xxmmc5!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc5" id="%{ydywid}_%{awid}_xxmmc5" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc5" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc5"  disabled="disabled" value="<s:property value='bsxmwid5' />" />
									<%
									state ++;
									if(fenzu==1&&sfxs5==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid5}"  disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc5" headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								<s:if test="%{xxmmc6!=null && xxmmc6!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc6" id="%{ydywid}_%{awid}_xxmmc6" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc6" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc6"  disabled="disabled" value="<s:property value='bsxmwid6' />" />
									<%
									state ++;
									if(fenzu==1&&sfxs6==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid6}"  disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc6" headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								<s:if test="%{xxmmc7!=null && xxmmc7!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc7" id="%{ydywid}_%{awid}_xxmmc7" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc7" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc7"  disabled="disabled" value="<s:property value='bsxmwid7' />" />
									<%
									state ++;
									if(fenzu==1&&sfxs7==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid7}"  disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc7" headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								<s:if test="%{xxmmc8!=null && xxmmc8!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc8" id="%{ydywid}_%{awid}_xxmmc8" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc8" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc8"  disabled="disabled" value="<s:property value='bsxmwid8' />" />
									<%
									state ++;
									if(fenzu==1&&sfxs8==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid8}" disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc8" headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								<s:if test="%{xxmmc9!=null && xxmmc9!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc9" id="%{ydywid}_%{awid}_xxmmc9" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc9" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc9"  disabled="disabled" value="<s:property value='bsxmwid9' />" />
									<%
									state ++;
									if(fenzu==1&&sfxs9==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid9}" disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc9" headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								<s:if test="%{xxmmc10!=null && xxmmc10!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc10" id="%{ydywid}_%{awid}_xxmmc10" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc10" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc10"  disabled="disabled" value="<s:property value='bsxmwid10' />" />
									<%
									state ++;
									if(fenzu==1&&sfxs10==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid10}" disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc10" headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								<s:if test="%{xxmmc11!=null && xxmmc11!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc11" id="%{ydywid}_%{awid}_xxmmc11" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc11" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc11"  disabled="disabled" value="<s:property value='bsxmwid11' />" />
									<%
									state ++;
									if(fenzu==1&&sfxs11==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid11}" disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc11" headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								<s:if test="%{xxmmc12!=null && xxmmc12!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc12" id="%{ydywid}_%{awid}_xxmmc12" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc12" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc12"  disabled="disabled" value="<s:property value='bsxmwid12' />" />
									<%
									state ++;
									if(fenzu==1&&sfxs12==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid12}" disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc12" headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								<s:if test="%{xxmmc13!=null && xxmmc13!=''}">
									<s:checkbox name="%{ydywid}_%{awid}_xxmmc13" id="%{ydywid}_%{awid}_xxmmc13" onclick="changeDisabled(this,'%{ydywid}','%{awid}')"></s:checkbox><s:property value="xxmmc13" />
									<input type="hidden" name="<s:property value='ydywid' />_<s:property value="%{awid}" />" id="hidden_<s:property value='ydywid' />_<s:property value="%{awid}" />_xxmmc13"  disabled="disabled" value="<s:property value='bsxmwid13' />" />
									<% 
									state ++;
									if(fenzu==1&&sfxs13==1){%>
										组合：<s:select name="%{ydywid}_%{awid}_fenzu_%{bsxmwid13}" disabled="true" list="getSysCode('FZCODE')" listKey="id" listValue="caption" id="fenzu_%{ydywid}_%{awid}_xxmmc13" headerKey="" headerValue="请选择"></s:select>
									<%}%>
								</s:if><s:else>&nbsp;</s:else>
								
							</s:else>
							<s:if test="bsxmwid10==1||bsxmwid10==2">
								<script>tochangeChecked('<s:property value="ydywid"/>','<s:property value="awid"/>')</script>
							</s:if>
							<% 
							
							if(state>0){
									kk=1;
									%>
									<s:if test="%{getDepartID().length()>3 || tsportYdybmxmCc.isEdit==1}" >
									<s:if test="%{(tsportYdybmxmCc==null || tsportYdybmxmCc.isEdit==null || tsportYdybmxmCc.isEdit=='') && (shzt2==1 || shzt2==2)}">
										<% if(bmzt>0){%>
											<script>changeCheckbox('<s:property value="%{ydywid}" />','','<s:property value="%{awid}" />')</script>
										<%}else{%>
											<script>changeCheckbox('<s:property value="%{ydywid}" />','0','<s:property value="%{awid}" />')</script>		
										<%}%>
									</s:if>
									<s:else>
										<% if(bmzt>0){%>
											<script>changeCheckbox('<s:property value="%{ydywid}" />','','<s:property value="%{awid}" />')</script>
										<%}else{%>
											<script>changeCheckbox('<s:property value="%{ydywid}" />','0','<s:property value="%{awid}" />')</script>		
										<%}%>
									</s:else>
									</s:if>
									<%
							} %>
							<%
								if(kk==0){
									%>
									<s:if test="%{getDepartID().length()>3 || tsportYdybmxmCc.isEdit==1}" >
										<s:if test="%{(tsportYdybmxmCc==null || tsportYdybmxmCc.isEdit==null || tsportYdybmxmCc.isEdit=='') && (shzt2==1 || shzt2==2)}">
												<% if(bmzt>0){%>
													<script>changeCheckbox('<s:property value="%{ydywid}" />','','<s:property value="%{awid}" />')</script>
												<%}else{%>
													<script>changeCheckbox('<s:property value="%{ydywid}" />','0','<s:property value="%{awid}" />')</script>		
												<%}%>
										</s:if>
										<s:else>
											<% if(bmzt>0){%>
												<script>changeCheckboxYES('<s:property value="%{ydywid}" />','','<s:property value="%{awid}" />')</script>
												<%}%>
										</s:else>
									</s:if>
									<%
								}
							
							%>
								<s:if test="(tsportYdybmxmCc==null || tsportYdybmxmCc.isEdit==null || tsportYdybmxmCc.isEdit=='')">
									<s:if test="%{shzt2==1 || shzt2==2}">
										<script>
											tochangeListCheckbox('<s:property value="%{ydywid}" />','<s:property value="%{awid}" />');
										</script>	
									</s:if>
								</s:if>
							</td>
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
    	</s:form>
    </div>
	<iframe width="0" height="0" id="sss" name="sss"></iframe>
  </body>
</html>

