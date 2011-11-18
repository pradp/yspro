/**
 * Spring mvc 前台表格、表单形式的页面使用的脚本库
 * yangjianliang
 * 2011-09-08
 */

var keyColumnName = "wid";
var uri_suffix = ".jhtm";//访问action扩展名

jQuery(document).ready(function() {

	doPagination(); //列表页面分页用
//		$("form").attr("autocomplete","off"); //输入框双击不显示历史记录
});

/**
 * 全选
 */
function doSelectAll(){
    var parentChecked = document.getElementsByName("selectAll")[0].checked;
    var nodes = document.getElementsByName("selectNode");
    for (var i = 0; i < nodes.length; i++) {
        var node = nodes[i];
        node.checked = parentChecked;
    }
}
/**
 * 遍历所有的checkbox，获得所选取的对象的value
 * 选中的checkbox的class为selectNode
 */
function CropCheckBoxValueAsString(checkboxName){
    var tmp = "";
    var a = document.getElementsByName(checkboxName);
    for (var i = 0; i < a.length; i++) {
        if (a[i].checked) {
            tmp += a[i].value + ",";
        }
    }
    tmp = tmp.substring(0, tmp.length - 1);
    return tmp;
}

/**
 * http://www.123.com/appName/../modelName/methodName.jhtm 返回 methodName
 * @returns 规则约定的部分，方法名
 */
function getMethodName(){
	var url = window.location.href;
	var actionName = url.substring( url.lastIndexOf("/")+1, url.lastIndexOf(uri_suffix) );
	return actionName;
}

/**
 * 在列表页面打开输入页面的函数
 * @param {Object} wid :wid 主键值
 * @param {Object} urlParameterStr 附加参数对
 * @param {Object} actionMethod 方法名称，如果需要修改默认调用input方法，这里传入方法名
 */
function openEntity(wid, urlParameterStr, actionMethod) {
	
	var _actionMethod = "input";
	if (actionMethod && actionMethod.length > 0) {
		_actionMethod = actionMethod;
	}
	var uri = _actionMethod + uri_suffix + "?reqtime=" + new Date().getTime();
	if (wid && wid.length > 0) {
		uri += "&wid=" + wid;
	}
	if (urlParameterStr && urlParameterStr.length > 0) {
		uri += "&" + urlParameterStr;
	}

	var windowWidth = document.body.clientWidth - 200;
	var windowHeight = document.body.clientHeight - 60;
	if(windowWidth<600)
		windowWidth += 160;
	//	var windowHeight = 420;
	openWindow(uri, windowWidth, windowHeight);
}

/**
 * 编辑选中的纪录
 */
function doModify() {
	var slength = 0;
	var a = document.getElementsByName("selectNode");
	for ( var i = 0; i < a.length; i++) {
		if (a[i].checked) {
			slength += 1;
		}
	}
	if (slength == 1) {
		var id = CropCheckBoxValueAsString("selectNode");
		openEntity(id);
	} else {
		alert("请勾选一条记录!");
	}
}

/**
 * 删除选中的纪录。
 * AJAX 请求传统页面方式实现
 */
function doRemove() {
	var ids = CropCheckBoxValueAsString("selectNode");
	if (ids.length > 0) {
		var conf = window.confirm("您确定要删除已选中的这些数据吗？");
		if (conf == true) {
			var url = "remove" + uri_suffix;
			$.post(url, {
				wid : ids,
				reqtime : (new Date()).getTime()
			}, function(data) {
				var bean = eval('(' +data + ')');
					if (bean.msg == "ok") {
						$("input[name=selectNode]").each(function(i) {
							if (ids.indexOf(this.value) != -1) {
								$(this).parent().parent().remove();
							}
						});
						alert("删除成功!");
					document.forms[0].submit();
				} else {
					//alert(data);
					alert(bean.msg);
				}
			});
		}
	} else {
		alert("请选择要删除的项!");
	}
}

/**
 * 批量更新状态
 * @param shzt 审核状态值
 * @param shms 审核类型描述，会加入提示用户的语句
 * @param shyj 审核人填写的审核意见
 */
function myChangeState(shzt, shms, shyj) {
	var ids = CropCheckBoxValueAsString("selectNode");
	if (ids.length > 0) {
		var conf = window.confirm("您确定要" + shms + "已选中的这些数据吗？");
		if (conf == true) {
			var url = "changeState" + uri_suffix + "?reqtime=" + (new Date()).getTime();
			$.post(url, {
				wid : ids,
				shzt : shzt,
				shyj : shyj
			}, function(data) {
					if (data == "操作成功") {
						alert(data + "！");
						document.forms[0].submit();
					}
				});
		}
	}else {
		alert("请勾选要操作的项!");
	}
}

/**
 * 客户端提交表单时的表单处理函数
 * 重写此方法可以自定义验证功能
 */
function doSave(useAutoValidate) {

	if (isValidateForm()) {
		return super_doSave();
	}
}

/**
 * 默认的提交表单时的表单处理函数
 * @param {Object} useAutoValidate 是否要自动验证必填。默认true
 * @param {Object} actionMethod
 * @return {TypeName} 
 */
function super_doSave(actionMethod){

    if (actionMethod == null || actionMethod == "") {
    	actionMethod = "save";
    }
    document.forms[0].action = actionMethod + uri_suffix;
    $("#ysSaveButton").attr("disabled","true");
    $("#ysSaveButton").unbind();
    document.forms[0].submit();
    return true;
}

/**
 * 提交列表页面上的查询
 * 提交前重置页码值。避免翻页后，修改查询条件，界面没有数据显示出来
 * @param {Object} resetUrl 是否重置url为list.jhtm。
 */
function super_doSearch( resetUrl ){

	var isSafeWords = isQueryWordsSafe();
	if(isSafeWords==false){
		return false;
	}
    if(document.getElementById('yspager_currentPageno')){
    	document.getElementById('yspager_currentPageno').value=1;
    }
    if (resetUrl) {
    	document.forms[0].action = "list" + uri_suffix + "?reqtime="+(new Date()).getTime();
	}
    //去除查询文本框中输入的空白，中文编码
    jQuery("input:text").each(function(i){
    	this.value = this.value.replace(/(^\s*)|(\s*$)/g, "");
    	this.value = encodeURIComponent( this.value );
    })
	document.forms[0].action = window.location.href;
    document.forms[0].submit();
}

/**
 * 检查查询表单里输入的查询条件中是否合法
 * 
 * @return 如果含有非法字符，返回false；全部合法，返回true
 */
function isQueryWordsSafe() {
	var isSafe = true;
	$("input[type=text]").each(function(i){
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
	    showMask: false,
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
 * 关闭弹出窗口
 * 子窗口关闭自己：parent.closeEntityWindow()
 */
function closeEntityWindow(){
	if(document.getElementById("ym_bc_div") && jQuery.trim(jQuery("#ym_bc_div").text())!=""){
		//提交过iframe中页面，刷新主页面
		if(document.forms[0]){
			document.forms[0].action = window.location.href;
			document.forms[0].submit();
		}else{
			window.location.reload();
		}
	}else{
		ymPrompt.close();
	}
}

/**
 * 分页。
 * 使用jquery pagination插件，控制框架里的通用分页进行翻页
 */
function doPagination(toolRows){
		if(document.getElementById("pagelist")){//原来有分页条的页面，说明需要分页
			if(document.getElementById("jpagination")){

			}else{//jpagination不存在的时候才执行添加新分页样式
				jQuery("#pagelist").hide().after("<div id='jpagination'></div>");
				//TotalNum 总数
				var TotalNum = jQuery("#pageTotalRows").val();
				if(toolRows!=null){
					TotalNum = toolRows;
				}
				var currentPageNo = parseInt(jQuery("#pager_currentPageno").val())-1;
				if( currentPageNo<1 ){
					currentPageNo = 0;//控件第一页从0开始
				}
				//分页事件
				jQuery("#jpagination").css("padding","5px 0 5px 0").pagination(TotalNum, {
				    prev_text: "上一页",
				    next_text: "下一页",
				    num_edge_entries: 2,//最前、最后各显示几页
				    num_display_entries: 8,//显示多少页出来
				    current_page: currentPageNo,
				    //回调
				    callback: pageselectCallback
				});
				//下面插入“合89条记录”
				var TotalNumStr = " <span style='color:gray;font-size:12px'>合"+TotalNum+"条记录</span>";
				jQuery("#jpagination .pagination").append(TotalNumStr);
			}
		}

	    function pageselectCallback(page) {
	    	//调用原框架里的分页
	    	jQuery("#yspager_currentPageno").val(page+1);//加1是为了两个分页工具的索引 起始值一个是0，一个是1
	    	//jQuery("#pager_rollPageButton").click();
	    	//jQuery("form[name=ysform]").append("<input name='pager.currentPageno' value='"+(page+1)+"' type='hidden'/>");
	    	trunPage();
	    }
}