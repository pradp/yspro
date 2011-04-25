<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  
    <title>list</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
	listPageStyle();
	function openPage(uri){
		openWindow(uri,840,450);
	}
	function setHeight(heights,widths){
		var data_heigth = parseInt(heights)+130;
		var data_width = parseInt(widths)+130;
		if(data_heigth<350){
			data_heigth=350;
		}
		
		document.getElementById("ydycjdj").style.height=data_heigth;
		document.getElementById("ydycjdj").style.width=data_width;
	}
	function toInit(wid,sc,cjdw,trId){
		var dsp = document.getElementById("bsxm_id");
		if(dsp.value==null || dsp.value==''){
			var objs = document.getElementById("dxmmcHidden_id");
			if(objs.value !=null && objs.value != ''){
				document.getElementById("help_id").value='0';
				getSelectXxmmc(objs);
			}
		}
		
		var iframe = document.getElementById("ydycjdj");
		var index_wid = document.getElementById("index_wid");
		var index_sc = document.getElementById("index_sc");
		var type = document.getElementById("type_id");
		var indwx_cjdw = document.getElementById("index_dw");
		var sccj =  document.getElementById("sccj");
		var bsxm = document.getElementById("bsxm_id")
		//传入的是赛程的wid  wid 为空值时，说明是 页面加载默认显示 第一个分组的 人员
		if(wid==null || sc==null || wid=='' || sc==''){
			iframe.src="../business/sportCjYdy-input.c?scbm="+index_wid.value+"&sc="+index_sc.value+"&cjdw="+indwx_cjdw.value+"&type="+type.value+"&wid=&sccj="+sccj.value+"&bsxm="+encodeURIComponent(bsxm.value);
		}else{
			var listData_size = document.getElementById("listData_size").value;
			
			if(listData_size != ''){
				var lenght = parseInt(listData_size);
				for(i=0;i<lenght;i++){
					document.getElementById("tr_"+i).style.backgroundColor="#F1F3F4";
				}
				document.getElementById(trId).style.backgroundColor="#BCD4EC";
				document.getElementById("scbm_default").value = wid;
				iframe.src="../business/sportCjYdy-input.c?scbm="+wid+"&sc="+sc+"&cjdw="+cjdw+"&type="+type.value+"&wid=&sccj="+sccj.value+"&bsxm="+encodeURIComponent(bsxm.value);
				}
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
	function getSelectXxmmclFirst(obj){
		//清除 项目 隐藏域的值
		document.getElementById("dxmmcHidden_id").value='';
		document.getElementById("xxmmcHidden_id").value='';
		document.getElementById("zbHidden_id").value='';
		document.getElementById("xbzHidden_id").value='';
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
		if(help_val.value!=null && help_val.value!=''){
			DWRUtil.setValue('xxmmc_id',obj1.value);
		}
		$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
	});
	ajaxService.getBsxmZb(obj.value,function (data){
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		DWRUtil.removeAllOptions('zb_id');
		DWRUtil.addOptions( 'zb_id', data,'id','caption');
		var obj2 = document.getElementById("zbHidden_id");
		if(help_val.value!=null && help_val.value!=''){
			DWRUtil.setValue('zb_id',obj2.value);
		}
		$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
		});
		ajaxService.getBsxmXbz(obj.value,function (data){
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		DWRUtil.removeAllOptions('xbz_id');
		DWRUtil.addOptions( 'xbz_id', data,'id','caption');
		var obj3 = document.getElementById("xbzHidden_id");
		if(help_val.value!=null && help_val.value!=''){
			DWRUtil.setValue('xbz_id',obj3.value);
		}
		$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
		});
	}
	
	
	function doreset(){	
	    document.getElementById("xxmmc_id").value="";
		document.getElementById("sc_id").value="";	
		document.getElementById("zb_id").value="";	
	    document.getElementById("csz_id").value="";
		document.getElementById("xbz_id").value="";	
	    document.getElementById("st_id").value="";	
	    document.getElementById("et_id").value="";
	    document.getElementById("shzt_id").value="";
	}	
	function doreset2(){	
	    document.getElementById("dxmmc_id").value="";
	    document.getElementById("xxmmc_id").value="";
		document.getElementById("sc_id").value="";	
		document.getElementById("zb_id").value="";	
	    document.getElementById("csz_id").value="";
		document.getElementById("xbz_id").value="";	
	    document.getElementById("st_id").value="";	
	    document.getElementById("et_id").value="";
	    document.getElementById("shzt_id").value="";
	}	

	function super_doSearch( resetUrl ){//resetUrl 是否重置url为list.c
	    if (actionName == null || actionName == "") {
	        actionName = getActionName();
	    }
	    if(document.getElementById('pager_currentPageno')){
	    	document.getElementById('pager_currentPageno').value=1;
	    }
	    if (resetUrl) {//cx 用来标记是 点击查询按钮触发的提交
	    	document.forms[0].action = actionName + "-list." + uri_suffix + "?reqtime="+(new Date()).getTime()+"&cx=1";
		}
	    document.forms[0].submit();
//	   	document.forms[0].action = actionName + "-list." + uri_suffix + "?reqtime="+(new Date()).getTime()+"&cx=1";
//	    document.forms[0].submit();
	}


	
	function auditGameProcessFbcj(fbzt,obj){
		var conf;
		if(fbzt=='3'){
			conf = window.confirm("您确定将你选择的记录发布？");
		}else if(fbzt=='-3'){
			conf = window.confirm("您确定将你选择的记录撤销发布？");
		}else if(fbzt=='-2'){
			var ids = CropCheckBoxValueAsString("selectNode");
			conf = window.confirm("您确定将你选择的记录退回到审核流程？");
			if(conf){
				if(ids.length>0){
				var id = ids.split(',');
				for(var k=0; k<id.length;k++){
					var val = document.getElementById("fbzt_"+id[k]).value;
					if(val=='-3'||val=='2'){
					}else{
						alert("只有是\“撤销发布\”和\“成绩待发布\”的数据  才允许 退回到审核流程！");
						return false;
					}
				}
				var uri ="sportCjYdy-shyj.c?wid="+ids+"&shzt=-2";
				openWindow(uri,700,400);
			}else{
				alert('请勾选一条记录！');
				return false;
				}
			}
			return false;
		} 
	if(conf==true){
		var ids = CropCheckBoxValueAsString("selectNode");
		if(ids.length>0){
			var id = ids.split(',');
			if(fbzt=='3'){
				for(var k=0; k<id.length;k++){
					var val = document.getElementById("fbzt_"+id[k]).value;
					if(val=='2' || val=='-3'){
					}else{
						alert("只有是\“撤销发布\”和\“成绩待发布\”的数据  才允许 发布！");
						return false;
					}
				}
				obj.disabled=true;
				$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
				ajaxService.auditGameProcess('3',ids,'','','',sc,function (data){
					alert(data);
					document.forms[0].submit();
					return false;
				});
			}else if(fbzt=='-3'){
				if(id.length==1){
				var xmbm = document.getElementById("xmbm_"+id[0]).value;
				var sc = document.getElementById("sc_"+id[0]).value;
				obj.disabled=true;
				$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
					ajaxService.auditGameProcess('-3',ids,xmbm,'','',sc,function (data){
						alert(data);
						document.forms[0].submit();
						return false;
					});
				}else{
						alert("请勾选一个赛程进行撤销操作！");
						return false;
				}
			}else if(fbzt=='-2'){
				for(var k=0; k<id.length;k++){
					var val = document.getElementById("fbzt_"+id[k]).value;
					if(val=='-3'||val=='2'){
					}else{
						alert("只有是\“撤销发布\”和\“成绩待发布\”的数据  才允许 退回到审核流程！");
						return false;
					}
				}
				obj.disabled=true;
				$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
				ajaxService.auditGameProcess('-2',ids,'','','','',function (data){
					alert(data);
					document.forms[0].submit();
					return false;
				});
			}
			
		}else{
			alert('请勾选一条记录');
			return false;
		}
		}
	}
	/**
	* 导入后进入正在登记成绩的页面
	*/
	function reOpenZzdj(){
		//var url = window.location.href;
		var _bsxm = getUrlParamValue("bsxm");
		if(_bsxm==null || _bsxm==""){
			_bsxm = "";
		}
		url = "../business/sportCjYdy-list.c?bsxm="+_bsxm+"&sportBsxm.shzt=0.5&type=dj";
		window.location = url + "";
	}
	//赛程成绩预览
	function auditGameProcessSccjyl (){
		var ids = CropCheckBoxValueAsString("selectNode");
		if(ids.length>0){
		var id = ids.split(',');
		if(id.length==1){
		var fbzt = document.getElementById("fbzt_"+id[0]).value;
		var xmbm = document.getElementById("xmbm_"+id[0]).value;
		var sc = document.getElementById("sc_"+id[0]).value;
			ajaxService.auditGameProcess('preview',id[0],xmbm,'','',sc,function (data){
				var uri	= "../business/sportSxMxYL-input.c?scbm="+id[0]+"&wid=&fbzt="+fbzt;
				openPage(uri);
			});
		}else{
			alert('请勾选一条记录');
			return false;
		}
	 }else{
			alert('请勾选一条记录');
			return false;
		}
	}

//刷新缓存
	function sxhc(){
		$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
		$.get("../business/sportCjYdy-sxhc.c",function (data){
			alert(data);
			$("#mes").html("");
			return false;
		});
	}

	function changeYlsc(){
		var ids = CropCheckBoxValueAsString("selectNode");
		if(ids.length>0){
			var m = 0;
			var n = 0;
			var k = 0;
			var j = 0;
			var id = ids.split(',');
			if(id.length>0){
				for(i=0;i<id.length;i++){
				var val = document.getElementById("sc_"+id[i]).value;
				var fbzt = document.getElementById("fbzt_"+id[i]).value;
				//预览赛次
				if(val!='2' || (fbzt!='-3' && fbzt!='-2' && fbzt!='2')){
					m++;
				}
				//发布按钮
				if(fbzt=='2'){
					n++;
				}
				//撤销发布
				if(fbzt=='3'){
					k++;
				}
				//退回到审核流程
				if(fbzt=='-3'||fbzt=='2'){
					j++;
				}
			  }
			}
			if(id.length>1){
				m++;
			}
			if(m>0){
				document.getElementById("yl").disabled=true;
				//document.getElementById("yl").disabled='false';
			}else{
				document.getElementById("yl").disabled=false;
			}
			if(id.length>0 && id.length==n){
				document.getElementById("fb").disabled=false;
			}else{
				document.getElementById("fb").disabled=true;
			}
			
			if(k==1){
				document.getElementById("cxfb").disabled=false;
			}else{
				document.getElementById("cxfb").disabled=true;
			}
			if(id.length>0 && id.length==j){
				document.getElementById("thdshlc").disabled=false;
			}else{
				document.getElementById("thdshlc").disabled=true;
			}
			
		}else{
			document.getElementById("yl").disabled=true;
			document.getElementById("fb").disabled=true;
			document.getElementById("cxfb").disabled=true;
			document.getElementById("thdshlc").disabled=true;
		}
	}
	function genPublicHtmlNow(){
		alert("点击确认，开始生成静态页面......");
		$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
		ajaxService.genPublicHtmlNow(function (){
			$("#mes").html("");
			alert("生成静态页面完毕！");
		});
	}
	function genPublicHtmlAsync(){
		ajaxService.genPublicHtmlAsync(function (){
			alert("已经开启生成静态页面线程，请稍后刷新外部页面查看！");
		});
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
    <s:hidden name="pager.formname" value="theform"/>
    <s:hidden name="bsxm" id="bsxm_id" value="%{#bsxm}"></s:hidden>
    <s:hidden name="listData_size" id="listData_size" value="%{resultData.size()}" />
    <s:hidden name="type" id="type_id" value="%{#type}" />
    <input type="hidden" id="dxmmcHidden_id" value="<s:property value='sportBsxm.dxmmc' />" />
    <input type="hidden" id="xxmmcHidden_id" value="<s:property value='sportBsxm.xxmmc' />" />
    <input type="hidden" id="zbHidden_id" value="<s:property value='sportBsxm.zb' />" />
    <input type="hidden" id="xbzHidden_id" value="<s:property value='sportBsxm.xbz' />" />
    
    <input type="hidden" name="sccj" id="sccj" value="<s:property value='sccj' />" />
    <input type="hidden" name="gqxm" id="gqxm" value="<s:property value='gqxm' />" />
    <input type="hidden" name="scbm_default" id="scbm_default" value="<s:property value='scbm_default' />" />
    <!-- 辅助 级联  赋值 -->
    <input type="hidden" id="help_id" value="" />
    		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunlefts">
						<s:if test="#bsxm==null || #bsxm=='' ">
						<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="95%">
								<tr align="center" colspan="7">
									<td align="right" nowrap="nowrap" class=""  colspan="1" width="10%">
										项目：
									</td>
									<td align="left" colspan="1" width="15%">
											<s:select name="sportBsxm.dxmmc" id="dxmmc_id"  list="getAllDxmmc()" onchange="getSelectXxmmclFirst(this)" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1" width="10%">
											性别组：
									</td>
									<td align="left" colspan="1" width="10%">
										<s:select name="sportBsxm.xbz" id="xbz_id" list="getBsxmXbz()" listKey="id" listValue="caption"  headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1" width="10%">
										级（赛）别：
									</td>
									<td align="left" colspan="3" width="45%">
											<s:select name="sportBsxm.xxmmc" id="xxmmc_id"  list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="-------请选择-------" />
									</td>
									
								</tr>
								<tr>	
									<td align="right" nowrap="nowrap" class="" colspan="1">
										组别：
									</td>
									<td align="left" colspan="1">
										<s:select name="sportBsxm.zb" id="zb_id"  list="getBsxmZb()" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1">
										赛次：
									</td>
									<td align="left" colspan="1">
										<s:select name="sportBsxm.sc" id="sc_id"  list="getBsxmSc()" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1">
										参赛者：
									</td>
									<td align="left" colspan="1">
										<s:textfield name="sportBsxm.csz" size="13"  id="csz_id"/>
									</td>
								
									
									<td colspan="1"><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="super_doSearch()"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
										</li>
									</ul></td>
							    </tr>
								<tr>
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
										<td align="right" nowrap="nowrap" class="" colspan="1">
										审核状态：</td>
										<td align="left" colspan="1">
											<s:select name="sportBsxm.shzt" id="shzt_id" list="getFbztList()" listKey="id" listValue="caption"  headerKey="" headerValue="--请选择--"  />
										</td>
									<td><ul class="btn_gn" colspan="1">
										<li>
											<a href="#" title="重置" onClick="doreset2()"
												id="searchButton2" name="btn4"><span> 重置 </span>
											</a>
										</li>
									</ul></td>
								</tr>
							</table>
						</s:if>
						<s:else>
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="95%">
								<tr align="center">
									
									<td align="right" nowrap="nowrap" class="">
										性别组：
									</td>
									<td align="left">
										<s:select name="sportBsxm.xbz" id="xbz_id" list="getBsxmXbz()" listKey="id" listValue="caption"  headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="">
										组别：
									</td>
									<td align="left">
										<s:select name="sportBsxm.zb" id="zb_id"  list="getBsxmZb()" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="">比赛项目：</td>
									<td align="left">
										<s:select name="sportBsxm.xxmmc" id="xxmmc_id"  list="getBsxmByName()" listKey="id" listValue="caption" headerKey="" headerValue="-------请选择-------" />

									</td>
								</tr>
								<tr>
									<td align="right" nowrap="nowrap" class="">
										赛次：
									</td>
									<td align="left">
										<s:select name="sportBsxm.sc" id="sc_id"  list="getBsxmSc()" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="">
										参赛者：
									</td>
									<td align="left">
										<s:textfield name="sportBsxm.csz" size="13"  id="csz_id"/>
									</td>
									<td align="right" nowrap="nowrap" class="">
										审核状态：
									</td>
									<td align="left">
										<s:select name="sportBsxm.shzt" id="shzt_id" list="getFbztList()" listKey="id" listValue="caption"  headerKey="" headerValue="--请选择--"  />
									</td>
									</tr>
									<tr>
								<td align="right" nowrap="nowrap" class="">
										起始时间：
									</td>
									<td align="left">
										<s:textfield name="sportBsxm.startTime" id="st_id" size="13"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"  />
									</td>
									<td align="right" nowrap="nowrap" class="">
										结束时间：
									</td>
									<td align="left">
										<s:textfield name="sportBsxm.endTime" id="et_id"  size="13"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"  />
									</td>
									<td colspan="3" ><div style="padding-left: 118px;"><ul class="btn_gn" >
										<li>
										<a href="#" title="查询" onClick="super_doSearch()"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
											<a href="#" title="重置" onClick="doreset()"
												id="searchButton2" name="btn4"><span> 重置 </span>
											</a>
										</li>
									</ul></div></td>
								</tr>
							</table>
						</s:else>
							
						</td>
						<td width="15" height="90" class="chaxunrights"></td>
					</tr>
				</table>
	<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%" class="maginB">
			<tr align="center">
				
			</tr>
	</table>

    	<table  border="0" cellspacing="3" cellpadding="0" width="100%">
          <tr>
		   	<s:if test="#sccj=='fb'">
    				<td><ul class="btn_gn">
    				 	<s:if test="#fbzt=='3'.toString()||#fbzt=='-3'.toString()||#fbzt=='-2'.toString()||#fbzt=='2'.toString() ||#fbzt=='-3+2'.toString()||#fbzt==''" >
		    				<li><a href="#" title="发布" onclick="auditGameProcessFbcj('3',this)" id="fb" <s:if test="#fbzt=='3'.toString() ||#fbzt=='-2'.toString() " >disabled="true"</s:if>><span>确认发布</span></a></li>
		    				<li><a href="#" title="撤销发布" onclick="auditGameProcessFbcj('-3',this)" id="cxfb" <s:if test="#fbzt!='3'.toString() && #fbzt!=''" >disabled="true"</s:if>><span>撤销发布</span></a></li>
		    				<li><a href="#" title="退回到审核流程" onclick="auditGameProcessFbcj('-2',this)" id="thdshlc" <s:if test="#fbzt=='3'.toString() ||#fbzt=='-2'.toString()" >disabled="true"</s:if>><span>退回到审核流程</span></a></li>
		    				<li><a href="#" title="预览赛次成绩" onclick="auditGameProcessSccjyl()" id="yl" <s:if test="resultData.size()==0 || #fbzt==3 ">disabled="true"</s:if> ><span>预览赛次成绩</span></a></li>
		    				
    					</s:if>
    					<s:else>
    						<li><a href="#" title="发布" onclick="auditGameProcessFbcj('3')" id="fb" disabled="true"> <span>确认发布</span></a></li>
		    				<li><a href="#" title="撤销发布" onclick="auditGameProcessFbcj('-3')" id="cxfb" disabled="true"><span>撤销发布</span></a></li>
		    				<li><a href="#" title="退回到审核流程" onclick="fbSocre('-2')" id="thdshlc" disabled="true"><span>退回到审核流程</span></a></li>
		    				<li><a href="#" title="预览赛次成绩" onclick="auditGameProcessSccjyl()" id="yl" <s:if test="resultData.size()==0 || #fbzt==3">disabled="true"</s:if> ><span>预览赛次成绩</span></a></li>
    					</s:else>
    					<li><a href="#" title="刷新内存中业务数据" onclick="sxhc()"><span>刷新内存中业务数据</span></a></li>
    					<li><a href="#" title="" onclick="genPublicHtmlNow()"><span>立即生成静态页面</span></a></li>
    					<li><a href="#" title="" onclick="genPublicHtmlAsync()"><span>异步生成静态页面</span></a></li>
							<li><div id="mes" style="font-size:12px; float: right; padding-right: 40px; "></div></li>
    				</ul></td>
    			</s:if>
    			
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
			
    	<table id="listTable" border="0" style="float: left" cellspacing="0" cellpadding="0" width="99%" class="middle">
    		<thead id="listHead">   	
			<tr>
			<!-- sccj  判断是否是 ‘ 赛次成绩 发布’  ‘赛次成绩汇总’    -->
				<s:if test="#sccj=='fb' || #sccj=='hz' " ><th width="2%"><s:checkbox name="selectAll"  onclick="changeYlsc(doSelectAll())" /></th></s:if>
			   <th width="26%" nowrap="nowrap">比赛项目</th>
			   <th width="6%" nowrap="nowrap">赛次</th>
			   <th width="8%" nowrap="nowrap">组别</th>
			    <th width="8%" nowrap="nowrap">性别组</th>
			    <th width="6%" nowrap="nowrap">编排分组</th>
			   <th width="13%" nowrap="nowrap">比赛时间</th>
			   <th width="5%" nowrap="nowrap">是否集体项目</th>
			   <th width="18%" nowrap="nowrap">对战队(人)</th>
			   <th width="12%" nowrap="nowrap">赛程状态</th>
			   <th width="12%" nowrap="nowrap">审核意见</th>
			  </tr>
    		</thead>
    		<tbody id="listData">
    	
    	<s:iterator value="resultData" status="status">
    	<s:if test="#scbm_default==wid && #cx !=1" >
    		<tr id="tr_<s:property value="#status.index" />" style="cursor: pointer; background-color: #BCD4EC; " title="比赛场地：<s:property value="bscd" />">
    	</s:if>
    	<s:else>
    		<s:if test="#status.index==0 &&(#scbm_default==null || #scbm_default=='' || #cx==1)" >
    				<tr id="tr_<s:property value="#status.index" />" style="cursor: pointer; background-color: #BCD4EC; "  title="比赛场地：<s:property value="bscd" />">
    		</s:if>
    		<s:else>
    			<tr id="tr_<s:property value="#status.index" />" style="cursor: pointer;"  title="比赛场地：<s:property value="bscd" />" >
    		</s:else>
    	</s:else>
  			<s:if test="#scbm_default==wid && #cx !=1">
  				<input type="hidden" name="index_wid" id="index_wid" value="<s:property value="wid" />" />
  				<input type="hidden" name="index_sc" id="index_sc" value="<s:property value="sc" />" />
  				<input type="hidden" name="index_dw" id="index_dw" value="<s:property value="cjdw" />" />
  			</s:if>
  			<s:elseif test="#status.index==0 &&(#scbm_default==null || #scbm_default=='' || #cx==1)">
  				<input type="hidden" name="index_wid" id="index_wid" value="<s:property value="wid" />" />
  				<input type="hidden" name="index_sc" id="index_sc" value="<s:property value="sc" />" />
  				<input type="hidden" name="index_dw" id="index_dw" value="<s:property value="cjdw" />" />
  			</s:elseif>
  			<s:if test="#sccj=='fb' || #sccj=='hz' " ><td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}" onclick="changeYlsc()"/></td></s:if>
  			<td  onclick="toInit('<s:property value="wid" />','<s:property value="sc" />','<s:property value="cjdw" />','tr_<s:property value="#status.index" />')">&nbsp;
  			<s:if test="#bsxm==null || #bsxm=='' ">
  			【<s:property value="dxmmc"/>】
  			</s:if>
  			<s:property value="xxmmc"/></td>
  			<td  onclick="toInit('<s:property value="wid" />','<s:property value="sc" />','<s:property value="cjdw" />','tr_<s:property value="#status.index" />')">&nbsp;<s:property value="scCn" /></td>
  			<td  onclick="toInit('<s:property value="wid" />','<s:property value="sc" />','<s:property value="cjdw" />','tr_<s:property value="#status.index" />')">&nbsp;<s:property value="zbcn"/></td>
  			<td  onclick="toInit('<s:property value="wid" />','<s:property value="sc" />','<s:property value="cjdw" />','tr_<s:property value="#status.index" />')">&nbsp;<s:if test="xbz==1">男子</s:if><s:elseif test="xbz==2" >女子</s:elseif><s:elseif test="xbz==3">男女混合</s:elseif></td>
  			<td  onclick="toInit('<s:property value="wid" />','<s:property value="sc" />','<s:property value="cjdw" />','tr_<s:property value="#status.index" />')">&nbsp;<s:property value="bpfz"/></td>
  			<td  onclick="toInit('<s:property value="wid" />','<s:property value="sc" />','<s:property value="cjdw" />','tr_<s:property value="#status.index" />')">&nbsp;<s:property value="startTime"/></td>
  			<td  onclick="toInit('<s:property value="wid" />','<s:property value="sc" />','<s:property value="cjdw" />','tr_<s:property value="#status.index" />')">&nbsp;<s:property value="sfjtxm"/></td>
  			<td  onclick="toInit('<s:property value="wid" />','<s:property value="sc" />','<s:property value="cjdw" />','tr_<s:property value="#status.index" />')">&nbsp;<s:property value="dzr" /></td>
  			<s:hidden id="sc_%{wid}" value="%{sc}" />
  			<s:hidden id="fbzt_%{wid}" value="%{fbzt}" />
  			<s:hidden id="xmbm_%{wid}" value="%{xmbm}" />
  			<td style="border-right:1px #D7D8D9 solid"  onclick="toInit('<s:property value="wid" />','<s:property value="sc" />','<s:property value="cjdw" />','tr_<s:property value="#status.index" />')">&nbsp;<s:if test="fbzt==0.5">在登记成绩</s:if>
  			<s:elseif test="fbzt==3">已发布</s:elseif><s:elseif test="fbzt==-3">撤消发布</s:elseif>
  			<s:elseif test="fbzt==2">成绩待发布</s:elseif><s:elseif test="fbzt==-2">退回审核中</s:elseif>
  			<s:elseif test="fbzt==-1">成绩修订中</s:elseif><s:elseif test="fbzt==1">成绩审核中</s:elseif><s:elseif test="fbzt==0">未开始</s:elseif></td>
  			<s:if test="fbzt==-2 || fbzt==-1">  
  			<td><a href="javaScript:openPage('sportCjYdy-shyj.c?wid=<s:property value="wid" />&model=look')">
					<font color="blue">查看</font></a></td></s:if>
			<s:else><td>&nbsp;查看</td>
			</s:else>
  		</tr>
    	</s:iterator>
  	    	<s:if test="resultData.isEmpty()">
  	    		<tr>
  	    			<td>&nbsp;&nbsp;</td>
  	    			<td>&nbsp;&nbsp;</td>
  	    			<td>&nbsp;&nbsp;</td>
  	    			<td>&nbsp;&nbsp;</td>
  	    			<td>&nbsp;&nbsp;</td>
  	    			<td>&nbsp;&nbsp;</td>
  	    			<td>&nbsp;&nbsp;</td>
  	    			<td>&nbsp;&nbsp;</td>
  	    			<td>&nbsp;&nbsp;</td>
  	    			<td>&nbsp;&nbsp;</td>
  	    		</tr>
  	    	</s:if>
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
    <table border="0" cellspacing="0" cellpadding="0" width="100%" align="left">
  		   <tr><td>
    		<iframe  name="ydycjdj" id="ydycjdj" height="100%" marginwidth="0"  width="100%" marginwidth="0" marginheight="0"  frameborder="0" ></iframe>
    		</td></tr>
    </table>
    </s:form>
        </div>
  
  </body>
</html>
