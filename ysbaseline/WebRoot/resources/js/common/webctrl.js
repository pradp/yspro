/**
 * 助学贷款 项目脚本库
 * yangjianliang
 */
var actionName = getActionName();
var DWRServiceName = getDWRServiceName();
var entityBeanType = "";
var keyColumnName = "wid";
var dialogType_debug = false;//打开窗口的模式为debug模式
var uri_suffix = "c";//访问action扩展名

$.getScript("../component/ymprompt/ymPrompt_source.js");

/**
 * 给予模糊查询
 * 
 */
function chaxun(){
	var username = document.theform.username.value;
	document.theform.sqlContext.value="select t.* from (t_sys_user) t where t.username like '%" + username + "%'";
}

/**
 * 打开列表页面时格式化页面样式
 */
function listPageStyle(){
	MM_preloadImages('../resources/images/vista/btn_goact.png',
	'../resources/images/vista/refresh_act.png',
	'../resources/images/vista/windowtop.png',
	'../resources/images/loading.gif',
	'../component/ymprompt/skin/infoms/images/ico.gif',
	'../component/ymprompt/skin/infoms/images/win_l.gif',
	'../component/ymprompt/skin/infoms/images/win_r.gif',
	'../component/ymprompt/skin/infoms/images/title_bg_left.gif',
	'../component/ymprompt/skin/infoms/images/title_bg_center.jpg',
	'../component/ymprompt/skin/infoms/images/title_bg_right.gif',
	'../component/ymprompt/skin/infoms/images/win_b.gif',
	'../component/ymprompt/skin/infoms/images/win_rb.gif',
	'../component/ymprompt/skin/infoms/images/win_lb.gif');
	jQuery.noConflict();
	jQuery(document).ready(function(){
		//load css,put here fix ie6 bug
		jQuery('<link rel="stylesheet" type="text/css" href="../component/ymprompt/skin/infoms/ymPrompt.css">').appendTo("head");

		jQuery("#listData tr").mouseover(function(){
					jQuery(this).addClass("over");
				})
				.mouseout(function(){
					jQuery(this).removeClass("over");
				})
		jQuery("#listData tr:even").addClass("alt");
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

/**
 * 打开输入/查看页面时格式化页面样式
 */
function detailPageStyle(){
	jQuery.noConflict();
	jQuery(document).ready(function(){
		jQuery("select").change( function() { 
			document.body.focus();
		 }); 
		//load css,put here fix ie6 bug
		jQuery('<link rel="stylesheet" type="text/css" href="../component/ymprompt/skin/infoms/ymPrompt.css">').appendTo("head");
		//把以前页面提示信息放到下面消息栏来提示，ym_bc_div是左下角的div
		if(document.getElementById("SystemErrorMessage") && parent.document.getElementById("ym_bc_div")){
			//条件成立，说明是提交页面后，重新进入该页面
			jQuery("#SystemErrorMessage").hide();
			var mesg = jQuery("#SystemErrorMessage span").html();
			var mesg_html;
			if(mesg.indexOf("成功")!=-1){
				mesg_html = "<span id='operateResultMsg' style='color:black'>";
			}else{
				mesg_html = "<span id='operateResultMsg' style='color:red'>";
			}
			mesg_html += "<img src=\"../resources/images/vista/btn_info.png\" width=\"14\" height=\"14\" />";
			mesg_html += "&nbsp;&nbsp;" + mesg + "！</span>";
			//parent.document.getElementById("SystemMessageSpan").innerHTML = mesg_html;
			parent.document.getElementById("ym_bc_div").innerHTML = mesg_html;
			
			//ym-header-text左上角的div 的Id  在左上角显示title
			parent.document.getElementById("ym-header-text").innerHTML ="<span style='color:#000000'>"+document.title+"</span>";
			//下面自动AJAX更新父页面数据
			/*
			alert(jQuery("form").serialize());
			var parentUrl = parent.document.forms[0].action;
			var data = $(parent.document.forms[0]).formSerialize();
			$.post(parentUrl, data, function(){
				
			});
			*/
		}else if(parent.document.getElementById("ym_bc_div")){
			parent.document.getElementById("ym-header-text").innerHTML ="<span style='color:#000000'>"+document.title+"</span>";
			parent.document.getElementById("ym_bc_div").innerHTML = "";
		}
		var url = window.location.href;
		if(url.indexOf("readOnlyPage=true")!=-1){//只读页面，只有关闭按钮
			$("table:last").hide();
			var closeButtonHtml = "<div style='width:100%;'><div style='width:30%;align:right;'><ul class=\"btn_gn\">";
			closeButtonHtml += "<li><a href=\"#\" title=\"关闭\" onclick=\"parent.closeInputWindow()\"><span>关闭</span></a></li>";
			closeButtonHtml += "</ul></div></div>";
			$("body").append(closeButtonHtml);
		}
	});
	$ = jQuery;
}


/**
 * 在列表页面打开输入页面的函数
 * @param {Object} id :wid 主键值
 * @param {Object} readOnlyPage :boolean value 是否只读页面。默认false
 * @param {Object} urlParameterStr 附加参数对
 * @param {Object} actionMethod action的方法名称
 */
function input(id,readOnlyPage,urlParameterStr,actionMethod){
	var uri ;
	var _actionMethod = "input";
	if(actionMethod && actionMethod.length>0){
		_actionMethod = actionMethod;
	}
	uri = actionName+"-"+_actionMethod+"."+uri_suffix+"?reqtime="+new Date().getTime();
	if(id && id.length>0){
		uri += "&wid="+id;
	}
	if(urlParameterStr && urlParameterStr.length>0){
		uri += "&" + urlParameterStr;
	}
	
	var windowWidth = document.body.clientWidth - 100;
	var windowHeight = document.body.clientHeight - 30;
	
	if(readOnlyPage || readOnlyPage=="true"){
		uri += "&readOnlyPage="+readOnlyPage;
		openWindow(uri, windowWidth, windowHeight);
	}else if( dialogType_debug ){
		openDebugWindow(uri);
	}else{
		openWindow(uri, windowWidth, windowHeight);
	}
}

/**
 * 编辑选中的纪录
 */
function modifySelected(){
	var slength = 0;
	var a = document.getElementsByName("selectNode");
	for (var i = 0; i < a.length; i++) {
	    if (a[i].checked) {
	        slength += 1;
	    }
	}
	if(slength==1){
		var id = CropCheckBoxValueAsString("selectNode");
		input(id,false);
	}else{
		alert("请勾选一条记录!");
	}
}

/**
 * 浏览用户
 */
function skanUser(){
	var slength = 0;
	var a = document.getElementsByName("selectNode");
	for (var i = 0; i < a.length; i++) {
	    if (a[i].checked) {
	        slength += 1;
	    }
	}
	if(slength==1){
		var id = CropCheckBoxValueAsString("selectNode");
		input(id,false);
	}else{
		alert("请勾选一条记录!");
	}
}

/**
 * 删除选中的用户
 */
function deleteUser(){
	var slength = 0;
	var a = document.getElementsByName("selectNode");

	for (var i = 0; i < a.length; i++) {
	    if (a[i].checked) {
	    	slength += 1;
	    	var id = a[i].value;
	    	doDeleteUser(id);
	    }
	}
	if(slength==0){
	alert("请勾选一条记录!");
	}
}


/**
 * 重置选中的纪录的密码
 */
function resetPassqord(){
	var slength = 0;
	var a = document.getElementsByName("selectNode");

	for (var i = 0; i < a.length; i++) {
	    if (a[i].checked) {
	    	slength += 1;
	    	var id = a[i].value;
	    	doResetPassword(id);
	    }
	}
	if(slength==0){
	alert("请勾选一条记录!");
	}
}

/**
 * 删除选中的纪录。
 * AJAX 请求传统页面方式实现
 */
function submitRemove(){
	var conf = window.confirm("您确定要删除已选中的这些数据吗？");
	if(conf==true){
		var ids = CropCheckBoxValueAsString("selectNode");
		if(ids.length>0){
			var url_bak = document.forms[0].action;
			var url = actionName + "-remove."+uri_suffix;
			$.post(url,
			       { wid: ids, reqtime: (new Date()).getTime() },
			       function(data){
					document.forms[0].action = url_bak;//还原URL，防止点查询按钮却执行删除！
					if(data.indexOf("删除成功")!=-1){
						$("input[@name=selectNode]").each(function(i){
							if(ids.indexOf(this.value)!=-1){
								$(this).parent().parent().remove();
							}
						});
						//alert("删除成功!");
					}else{
						//alert(data);
						alert($(data).find("span").text());
					}
					//document.forms[0].submit();
			       }
			);
		}else{
			alert("请选择要删除的项!");
		}
	}
}

/**
 * 客户端提交表单时的表单处理函数
 * 重写此方法可以自定义验证功能
 */
function submitForm(){
	return super_submitForm();
}

/**
 * 默认的提交表单时的表单处理函数
 */
function super_submitForm(actionMethod){
    if (actionName == null || actionName == "") {
        actionName = getActionName();
    }
    if (actionMethod == null || actionMethod == "") {
    	actionMethod = "save";
    }
    document.forms[0].action = actionName + "-"+actionMethod+".c";
    $(".btn_gn a").each(function(i){
        if ($(this).attr("title").indexOf("保存") != -1) {
            $(this).html("<span>处理中...</span>");
            $(this).unbind();
        }
    });
    document.forms[0].submit();
    return true;
}

/**
 * 提交列表页面上的查询
 * 提交前重置页码值。避免翻页后，修改查询条件，界面没有数据显示出来
 * @param {Object} resetUrl 是否重置url为list.c。
 */
function super_doSearch( resetUrl ){

	var isSafeWords = isQueryWordsSafe();
	if(isSafeWords==false){
		return false;
	}
    if (actionName == null || actionName == "") {
        actionName = getActionName();
    }
    if(document.getElementById('pager_currentPageno')){
    	document.getElementById('pager_currentPageno').value=1;
    }
    if (resetUrl) {
    	document.forms[0].action = actionName + "-list." + uri_suffix + "?reqtime="+(new Date()).getTime();
	}
    document.forms[0].submit();
}

/**
 * 检查查询表单里输入的查询条件中是否合法
 * 
 * @return 如果含有非法字符，返回false；全部合法，返回true
 */
function isQueryWordsSafe() {
	var isSafe = true;
	$("input[@type=text]").each(function(i){
		var str = this.value;
		if(str!=""){
			if(str.indexOf("'")!=-1){
				isSafe = false;
	            alert("包含非法字符！");
	            return false;
	        }
		}
	});
	return isSafe;
}

/**
 * AJAX回调，返回的是boolean的情况
 */
function ajaxBackBoolean(result){
	if(result==false){
		alert("操作失败！");
	}else{
		//window.location.reload();
		document.forms[0].submit();
	}
}

/**
 * AJAX回调，返回的是String的情况
 */
function ajaxBackString(result){
	if(result!==""){
		alert(result);
		//window.location.reload();
		document.forms[0].submit();
	}
}

/**
 * 由于系统早期开发的时候都是使用的alert，所以这里重写这个函数
 * 使用ymPrompt组件替代
 * @param {Object} msg
 * @param {Object} width
 * @param {Object} height
 */
var alertDiv = function(msg, width, height){
    if (!width) {
        width = 300;
    }
    if (!height) {
        height = 160;
    }
    var block = true;
    var alerthandler = function(clicked){
        if (clicked == "ok") {
            block = false;
		ymPrompt.close();
        }
    }
    msg = "<br/><br/>" + msg + "";
    ymPrompt.alert({
        message: msg,
        width: width,
        height: height,
        handler: alerthandler,
        maskAlphaColor: '#fff',
        maskAlpha: '0.5',
        slideShowHide: false,
        title: '系统信息'
    });
}

var confirmDiv = function(msg){
    var confirmhandler = function(clicked){
        if (clicked == "ok") {
            ymPrompt.close();
        }
    }
    msg = "<p/>" + msg + "";
    ymPrompt.confirmInfo({message:msg,handler:confirmhandler});
    return resp;
}

/**
 * 打开一个新窗口，使用div遮罩层实现，内部使用iframe打开目标网页
 * @param {Object} uri 要打开的目标网页地址
 * @param {Object} width 窗口的宽度
 * @param {Object} height 窗口的高度
 */
function openWindow(uri, width, height){	
    if (!width) {
        width = 840;
    }
    if (!height) {
        height = 450;
    }
    var winhandler = function(clicked){
        if (clicked == "ok") {
		ymPrompt.close();
        }
    }
    ymPrompt.win({
        width: width,
        height: height,
        title: '<img id="loadingImage" src="../resources/images/loading.gif" border="0">',
        maskAlphaColor: '#fff',
        maskAlpha: '0.5',
        handler: winhandler,
        maxBtn: true,
        minBtn: true,
	    showMask: true,
        dragOut: true,
        iframe: {
            id: 'inputFrame',
            name: 'inputFrame',
            src: uri
        }
    });
    $("#inputFrame").load(function(){
    	//为窗口里的iframe添加load事件
	$("#loadingImage").hide();
    });
}

/**
 * 打开一个新窗口，使用div遮罩层实现，内部使用iframe打开目标网页
 * @param {Object} message
 * @param {Object} width 窗口的宽度
 * @param {Object} height 窗口的高度
 */
function showInfo(message, title, width, height){
    if (!width) {
        width = 400;
    }
    if (!height) {
        height = 240;
    }
    if(!title){
    	title = '';
    }
    var winhandler = function(clicked){
        if (clicked == "ok") {
		ymPrompt.close();
        }
    }
    ymPrompt.win({
        message: message,
	  width: width,
        height: height,
        title: title,
        maskAlphaColor: '#fff',
        maskAlpha: '0.5',
        handler: winhandler,
        maxBtn: true,
        minBtn: true,
	  showMask: true,
        dragOut: false
    });
	//fix ie6 bug start
	var nb = "<div style='padding-top: 10px;background-color:#fff'>" + $(".ym-body").html() + "</div>";
	$(".ym-body").html(nb);
	//fix ie6 bug end
}

function openDebugWindow(uri){
	params = "top=60,left=150,width=710,height=460,toolbar=yes,resizable=yes,scrollbars=auto,location=yes,status=yes,menubar=no";
	window.open(uri, "", params);
}
function openWindowOnly(uri, width, height){
	openWindow(uri, width, height);
	//document.forms[0].submit();
	//window.location.reload();
}
/**
 * 打开模式窗口
 * @param uri
 * @param in_params 窗口大小、位置等参数
 * @return
 */
function openModalWindow(uri, in_params){
	var params = "dialogWidth=780px;dialogHeight=600px";
	if(in_params){
		params = in_params;
	}
	window.showModalDialog(uri,parent,params);
}
/**
 * 关闭弹出窗口
 * 子窗口关闭自己：parent.closeInputWindow()
 */
function closeInputWindow(){
      if(document.getElementById("ym_bc_div") && document.getElementById("ym_bc_div").innerText!=""){
		//提交过iframe中页面，刷新主页面
		if(document.forms[0]){
			document.forms[0].submit();
		}else{
			window.location.reload();
		}
			
	}else{
		ymPrompt.close();
	}
}

function getDWRServiceName(){
	var DWRServiceName ;
	var scs = document.getElementsByTagName("script");
	for(var i=0;i<scs.length;i++){
		var sc = scs[i].src;
		if(sc.indexOf("/dwr/interface/")!=-1){
			DWRServiceName = sc.substring( sc.lastIndexOf("/")+1, sc.lastIndexOf(".") );
			break;
		}
	}
	return DWRServiceName;
}

function getActionName(){
	var url = window.location.href;
	var actionName = url.substring( url.lastIndexOf("/")+1, url.lastIndexOf("-") );
	return actionName;
}

var preRow="";
var preRowNum = "";
/**
 * 点击表格,选中一行突出显示
 * @param {Object} theRow
 * @param {Object} theRowNum
 * @param {Object} theAction
 * @param {Object} colorValue
 */
function setPointer(theRow, theRowNum, theAction,colorValue )
{
  	var theDefaultColor = '#f0f0f2';
	var thePointerColor = colorValue;
	var theMarkColor = colorValue;

	var theCells = null;
	if ((thePointerColor == '' && theMarkColor == '') || typeof(theRow.style) == 'undefined')
	{
		return false;
	}
	if (typeof(document.getElementsByTagName) != 'undefined')
	{
		theCells = theRow.getElementsByTagName('td');
	}
	else if (typeof(theRow.cells) != 'undefined')
	{
		theCells = theRow.cells;
	}else {
		return false;
	}
	var rowCellsCnt  = theCells.length;
	var domDetect    = null;
	var currentColor = null;
	var newColor     = null;
	if (typeof(window.opera) == 'undefined' && typeof(theCells[0].getAttribute) != 'undefined')
	{
		currentColor = theCells[0].getAttribute('bgcolor');
		domDetect    = true;
	}
 	else
	{
		currentColor = theCells[0].style.backgroundColor;
		domDetect    = false;
	} 	
	if (colorValue)
	{
		var c = null;
		if (domDetect)
		{
			for (c = 0; c < rowCellsCnt; c++)
			{
				theCells[c].setAttribute('bgcolor', colorValue, 0);
			} 
		}
		else
		{
			for (c = 0; c < rowCellsCnt; c++)
			{
				theCells[c].style.backgroundColor = colorValue;
			}
		}
	}
	if(preRowNum!="") {
      if(theRowNum!=preRowNum) {
      	setPointer(preRow,preRowNum, 'click','#f0f0f2');
      }   
   }       
   preRow=theRow;
  	preRowNum=theRowNum;  
	return true;
}

/**
 * date:2003-9-20 9:49
 * 处理鼠标over的事件
 */
function changeButtonStyle(obj,flag) {
	if(flag==true){
		obj.style.backgroundImage='url(../resources/images/button_a.gif)';
	}else{
		obj.style.backgroundImage='url(../resources/images/button_v.gif)';
  	}
}

/**
 * 支持Google Suggest功能的客户端方法
 * @param {Object} objid 输入框控件的ID
 * @param {Object} hideObjid 点击一个suggest后，存放该对象值的控件ID。如果空，则不传编码。
 * @param {Object} url 提供即时查询的URL，此URL返回的是json
 * @param (boolean) ys_notMustMatch 是否不强制从下拉中选择。默认必须从下拉选择
 */
function getSuggest(objid, hideObjid, url, ys_notMustMatch){
	var ys_isMustMatch = true;
	if( ys_notMustMatch && ys_notMustMatch==true){
		ys_isMustMatch = false;
	}
	$("#"+objid).autocomplete(url, {
			minChars:1,
			max:20,
			multiple:false,
			mustMatch:ys_isMustMatch,
			matchContains:false,
			autoFill:false,//这个参数开启会有BUG
			scroll: true,
			scrollHeight:300,
			parse:function(data) {
				return $.map(eval(data), function(row) {
					return {
						data: row,
						value: row.value,
						result: row.name
					}
				});
			},
			formatItem: function(item, currentRowNum, maxRowNum) {
				//return currentRowNum + "/" + maxRowNum + ": " + item.name ;
				return item.name ;
			},
			formatResult: function(item) {
				//alert(item.name);
				return item.name;
			}
		})
	.result(function(e, item) {
		if(hideObjid && hideObjid!=""){
			$("#"+hideObjid).val( item.value );
		}
	});
	$("#"+objid).blur(function(){
		var NameStr = $("#"+objid).val();
		NameStr = NameStr.replaceAll(" ","");
		if(NameStr=="" && hideObjid){
			$("#"+hideObjid).val("");//如果没有对应记录，同时清除对应的编号数据
		}
	});
}

function MM_preloadImages() { //v3.0
    var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
