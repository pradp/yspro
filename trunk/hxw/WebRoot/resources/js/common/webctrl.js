/**
 * 表格、表单形式的页面使用的脚本库
 * 用于快速创建CRUD操作
 * yangjianliang
 */
var actionName = getActionName();
var keyColumnName = "wid";
var dialogType_debug = false;//打开窗口的模式为debug模式
var uri_suffix = "action";//访问action扩展名

var turnPageTickOff = true; // 离开页面后是否清空勾选
var isEmptyTickOff = true; // 翻页后是否保留原勾选记录
var menuid = "";
var index_labels = "";
var view_rules = "";

jQuery(document).ready(function() {

	doPagination(); //列表页面分页用
	
		$("form").attr("autocomplete","off"); //输入框双击不显示历史记录
		
		jQuery("a").css("color", "blue"); //超链接的字段显示为蓝色字体

		if ($("#userRoleMenuButton button")[0]) {
			$("#userRoleMenuButton").css( {
				"padding-top" : "10px"
			});
		}
		$("#userRoleMenuButton").siblings("div").css( {
			"padding-top" : "10px"
		});
		$("#userRoleMenuButton").siblings("form").find("div").first().css( {
			"padding-top" : "10px"
		});	
		changeSelectPosition();	//解决IE中浮动层滑动问题
		//是否支持翻页勾选
		if(document.getElementById("pagelist")){//原来有分页条的页面，说明需要分页
			if(turnPageTickOff){
				if($("input[type='checkbox']")[0]){ //页面存在checkbox时
					menuid = window.parent.document.getElementById('frmleft').contentWindow.document.getElementById("curr_menuid").value;
					if(document.getElementsByName("selectAll").length==0){ //没有全选checkbox时添加
						$("input[type='checkbox']:eq(0)").parent().parent().prev("tr").find("th:eq(0)")
							.html('<input type="checkbox" name="selectAll" value="true" id="selectAll" onclick="doSelectAll()"/>');
					}
					floatAddFloat();
				}
			}
		}
	});
    /**
     * 校验是否存在
     * @param {Object} entityName 实体名
     * @param {Object} column 字段名
     * @param {Object} columnName 字段中文名
     */
    function checkDuplicate(entityName,column,columnName){
    	var value_ = $("#"+column).val();
    	var wid_ = $("#wid").val();
		var url = "../jsonVisitor/ajaxSys-checkDuplicate.action?"+(new Date()).getTime();
		$.getJSON(url, {entityName: entityName, column: column, value: value_, wid: wid_}, function(data){
		    var exists = data.datamap.exists;
			if(exists == 'true'){
				$("#"+column).val('');
				alert(columnName+"已存在，请重新输入！");
			}
		});
    }
    
	/**
	 * 解决IE中浮动层滑动问题
	 * @memberOf {TypeName} 
	 */
	function changeSelectPosition(){
		if($.browser.msie){
			$("select").prev("div").each(function(){
				var obj = $(this);
				if(obj.find("div[class*='aa']").length == 0){
					$(this).css("position","static");
					$(this).find("div[class*='selectbox-wrapper']").wrap("<div style='position: absolute' class='aa'></div>");
					$(this).find("input").mousedown(function(){
						var offset = obj.offset();
						obj.find("div[class='aa']").css("left",(offset.left));
						obj.find("div[class='aa']").css("top",(offset.top));
					})
				}
			})
		}
	}
/**
 * 火狐浏览器获取用户自定义按钮 调整样式
 * @memberOf {TypeName} 
 */
function changeInitStyle() {
	if($.browser.mozilla){ //火狐不支持非input控件的click(){
		$("div button").css("margin", "auto 6px auto auto");
	}
}

//浮动面板功能 start
/**
 * 添加浮动面板
 * @param {Object} cookiename
 * @memberOf {TypeName} 
 */
function floatAddFloat(){
	var floatPanel_html = '<div id="floatPanel" style="overflow-y: auto;height: 300px"><table></table></div>';
	if($("#scrollContent")[0]){
		$("#scrollContent").append(floatPanel_html);
		$("#floatPanel").floatPanel({
			width:300,
			animatefirst:false,
			direction:"mr",
			topDistance: 60
		})
	}
	$("input[type='checkbox']").click(function(){
		floatClickCheckbox(this);
	});
	floatShowFloat();
	floatDoClickCheckbox();
}
/**
 * 初始化页面时自动选中浮动面板中有的记录(即已选中过的记录)
 * @memberOf {TypeName} 
 */
function floatDoClickCheckbox(){
	var clickCheckbox = getCookieValue(menuid);
	var clickCheckboxs = clickCheckbox.split(",");
	if(clickCheckbox!=null && clickCheckbox!=''){
		for(var i=0;i<clickCheckboxs.length;i++){
			$("input[type='checkbox']").each(function(){
				if(this.value == clickCheckboxs[i].split(":")[0]){
					this.checked = true;
				}
			});
		}
	}
	floatSelectAllCheckbox();
}
/**
 * 判断全选checkbox是否选中
 * @memberOf {TypeName} 
 */
function floatSelectAllCheckbox(){
	var nodes = document.getElementsByName("selectNode");
	var k = nodes.length;
	for (var i = 0; i < nodes.length; i++) {
		var node = nodes[i];
		if(!node.checked){
			k--;
		}
	}
	var parentChecked = document.getElementsByName("selectAll")[0];
	if(parentChecked){
		if(k == nodes.length && k!=0){ //选中
			parentChecked.indeterminate = false;
			parentChecked.checked = true;
		}else if(k==0){ //取消选中
			parentChecked.indeterminate = false;
			parentChecked.checked = false;
		}else{ //半选
			parentChecked.indeterminate = true;
		}
	}
}
/**
 * 清空已选记录
 */
function floatDeleteAllCookie(){
	document.cookie = menuid + "=;";
	floatShowFloat();
	$("input[type='checkbox'][id!='sfmrdk']").attr("checked","");
	$("input[type='checkbox'][id='selectAll']").each(function(){
		this.indeterminate = false;
		this.checked = false;
	});
}
/**
 * 选中或取消选中checkbox 可以重写
 * @param {Object} obj
 */
function floatGetIndexAndRules(checkboxObj){
	var index_name = -1;
	$(checkboxObj).parent().nextAll().each(function(i){
		if($(this).has('a')[0] && index_name==-1){
			index_name = i+2+"_a";
			if($(this).find("a").html().indexOf("</")!=-1){ //查看是否有子标签
				var hh_index = $(this).find("a").html().lastIndexOf("</")+2;
				var he_index = $(this).find("a").html().lastIndexOf(">");
				index_name += "_"+$(this).find("a").html().substring(hh_index,he_index);
			}
		}
	})
	var index_zt = -1;
	$(checkboxObj).parent().parent().siblings().find("th").each(function(i){
		if($(this).html().indexOf("状态")!=-1 && index_zt==-1){
			index_zt = i+1;
		}	
	})
	if(index_name!=-1 && index_zt!=-1){
		index_labels = [index_name,index_zt+''];
		view_rules = '{1}（{2}）';
	}else if(index_name==-1 && index_zt!=-1){
		index_labels = [index_zt+''];
		view_rules = '{1}';
	}else if(index_name!=-1 && index_zt==-1){
		index_labels = [index_name];
		view_rules = '{1}';
	}
}
/**
 * 选中或取消选中checkbox 
 * @param {Object} checkboxObj 
 * @return {TypeName} 
 */
function floatClickCheckbox(checkboxObj){
	if(checkboxObj.value!=null && checkboxObj.value!='' && checkboxObj.value!='true'){
		if(index_labels==""){
			floatGetIndexAndRules(checkboxObj);
		}
		var indexs = index_labels;
		var rules = view_rules;
		var name = $(checkboxObj).parent().siblings().find("a").html();
		for(var i=0;i<indexs.length;i++){
			var value_index = indexs[i];
			var html_i = ""; 
			if(value_index.indexOf("_")!=-1){
				var html_label = value_index.split("_");
				var index = parseInt(html_label[0])-1;
				for(var j=html_label.length-1;j>0;j--){
					var html_index = $(checkboxObj).parent().parent().find("td:eq("+index+") "+html_label[j]);
					if(html_index.length!=0 && html_i==""){
						html_i = $(html_index[0]).html().replace("&nbsp;","").replace(/(^\s*)|(\s*$)/g, "");
					}
				}
			}else{
				var index = parseInt(value_index)-1;
				if($(checkboxObj).parent().parent().find("td:eq("+index+")").length>0){
					html_i = $(checkboxObj).parent().parent().find("td:eq("+index+")").html().replace("&nbsp;","").replace(/(^\s*)|(\s*$)/g, "");
				}else{
					alert('列超过上限');
					return false;
				}
			}
			rules = rules.replace("{"+(i+1)+"}",html_i);
		}
		var pageNo = $('#pager_currentPageno').val();
		if(checkboxObj.checked){
			floatChangeClickFloatChecked(checkboxObj.value,pageNo,rules);
		}else{
			floatChangeClickFloatNotchecked(checkboxObj.value);
		}
	}
}
/**
 * 选中所有checkbox
 */
function doSelectAll(obj){
	var parentChecked = false;
	if(obj!=null && obj!='undefind'){
		parentChecked = obj;
	}else{
		parentChecked = document.getElementsByName("selectAll")[0].checked;
	}
	var nodes = document.getElementsByName("selectNode");
	for (var i = 0; i < nodes.length; i++) {
		var node = nodes[i];
		if(node.checked != parentChecked){
			node.checked = parentChecked;
			if(turnPageTickOff)
				floatClickCheckbox(node);
		}else{
			if(obj!=null && obj!='undefind'){
				if(turnPageTickOff)
					floatClickCheckbox(node);
			}
		}
	}
}
/**
 * 浮动面板显示信息
 */
function floatShowFloat(){
	var html = '<tr><td colspan="2"><button onclick="floatDeleteAllCookie()" '
			+ 'style="width: 90px;height: 22px;background: url(\'../clientui/skins/sky/form/btn_bg.jpg\') repeat scroll 0 0 transparent;'
			+'margin: auto 6px auto auto; padding-left: 5px;border: 1px solid #83B1F2;line-height: 20px;color: #3F3F3F;text-align: left;font-size:12px">'
			+ '<span sytle="word-wrap: normal;font-size: 12px;line-height: 20px;">清除已选</span></button></td>'
			+ '<td><input type="checkbox" id="sfmrdk" onclick="floatChangeMb(this)"/><label for="sfmrdk">面板是否默认打开</label></td></tr>'
			+ '<tr><td colspan="3"><b>已选记录</b>：</tr>';
	var floatPanel_innerhtml_title = '<tr><td width="40px" align="center" nowrap="nowrap">页码</td>'
							       + '<td align="center" width="40px" nowrap="nowrap">序号</td><td align="left" nowrap="nowrap">记录名</td></tr>';
	var clickCheckbox = getCookieValue(menuid);
	var count_row = 0;
	var clickCheckboxs = clickCheckbox.split(",");
	if(clickCheckbox!=null && clickCheckbox!=''){
		html += floatPanel_innerhtml_title;
		for(var i=0;i<clickCheckboxs.length;i++){
			var value = clickCheckboxs[i].split(":")[2];
			var view = isOverBytes(value,22);
			html += "<tr><td align='center'>［" + clickCheckboxs[i].split(":")[1] + "］</td><td align='center'>" + (i+1) + "．</td>" 
				 + "<td align='left' nowrap='nowrap' title='"+value+"'>"
				 + "<a onclick=\"javascript:floatReturnPage('" + clickCheckboxs[i].split(":")[1] + "')\"><font color='blue'>"+ view +"</font></a></td>"
				 + "<td><label onclick='floatDelThisRow(\""+clickCheckboxs[i].split(":")[0]+"\")'><image src='../clientui/icons/delete.gif' height='12px'/></label>"
				 + "</td></tr>";
			count_row++;
		}
	}
	$("#floatPanel div[id='floatPanel'] table").html(html);
	$("#floatPanel div[id='floatPanel'] table button span").css(
		{ backgroundImage: "url('../clientui/icons/delete.gif')",
		backgroundPosition: "0 40%",
		backgroundRepeat: "no-repeat",
		padding: "0 5px 0 18px",
		lineHeight: "",
		textAlign: "center",
		display: "block",
		styleFloat: "left",
		cursor: "pointer"})
	var floatDefault = getCookieValue("floatDefault");
	if(floatDefault == null || floatDefault =='' || floatDefault == 'true'){
		if(count_row != 0){
			$("#floatPanel button[class*='searchBtnRight']").each(function(){
				if($(this).html()=='打开面板'){
					this.click();
				}
			})
		}
		$("#sfmrdk").attr("checked","checked");
	}else{
		$("#sfmrdk").attr("checked","");
	}
}
/**
 * 浮动面板是否默认打开
 * @param {Object} checkboxObj
 */
function floatChangeMb(checkboxObj){
	if(checkboxObj.checked){
		document.cookie = "floatDefault=true";
	}else{
		document.cookie = "floatDefault=false";
	}
}
/**
 * 根据最大长度截取字符串
 * @param {Object} s 字符串
 * @param {Object} maxbytes 最大长度
 * @return {TypeName} 截取后的字符串
 */
function isOverBytes(s, maxbytes)
{
    var i = 0;
    var bytes = 0;
    var uFF61 = parseInt("FF61", 16);
    var uFF9F = parseInt("FF9F", 16);
    var uFFE8 = parseInt("FFE8", 16);
    var uFFEE = parseInt("FFEE", 16);
    
    var final_str = '';
    if(s != null && s != 'undefind' && s != ''){
	    while (i < s.length)
	     {
	        var c = parseInt(s.charCodeAt(i));
	        if (c < 256) {
	             bytes = bytes + 1;
	         }
	        else {
	            if ((uFF61 <= c) && (c <= uFF9F)) {
	                 bytes = bytes + 1;
	             } else if ((uFFE8 <= c) && (c <= uFFEE)) {
	                                bytes = bytes + 1;
	                        }
	                       else {
	                 bytes = bytes + 2;
	             }
	         }
	        final_str += s.substr(i,1);
	        if (bytes > maxbytes) {
	        	if(c < 256){
	        		final_str += " ";
	        	}
	            return final_str+"...";
	         }
	         i = i + 1;
	     }
	}
    return final_str;
}
/**
  * 删除该行 
  * @param {Object} checkboxvalue
  * @memberOf {TypeName} 
  */
function floatDelThisRow(checkboxvalue){
	$("input[type='checkbox']").each(function(){
		if(this.value==checkboxvalue){
			this.checked = false;
		}
	})
	floatChangeClickFloatNotchecked(checkboxvalue);
}
/**
 * 点击该项时自动跳转的所属页
 * @param {Object} pagerNo 页码
 */
function floatReturnPage(pagerNo){
	$("input[type='hidden'][name='pager.currentPageno']").val(pagerNo);
	trunPage();
}
/**
 * 选中checkbox时
 * @param {Object} checkboxvalue
 * @param {Object} pagerNo
 * @param {Object} value
 */
function floatChangeClickFloatChecked(checkboxvalue,pagerNo,value){
	var clickCheckbox = getCookieValue(menuid);
	var this_cookievalue = escape(checkboxvalue + ":" + pagerNo + ":" + value);
	if(clickCheckbox == null || clickCheckbox == ''){
		document.cookie = menuid + "=" + this_cookievalue;
	}else{
		var clickCheckboxs = clickCheckbox.split(",");
		var cookievalue = "";
		for(var i=0;i<clickCheckboxs.length;i++){
			var pagerNo_ = clickCheckboxs[i].split(":")[1];
			if(parseInt(pagerNo_)<parseInt(pagerNo)){
				cookievalue += escape(unescape(clickCheckboxs[i])) + ",";
			}else if(parseInt(pagerNo_)==parseInt(pagerNo)){
				var nodes = document.getElementsByName("selectNode");
				var nodes_curr = 0;
				var nodes_ = 0;
				for (var j = 0; j < nodes.length; j++) {
					var node = nodes[j];
					if(node.checked && node.value == clickCheckboxs[i].split(":")[0]){
						nodes_ = j;
					}else if(node.value == checkboxvalue){
						nodes_curr = j;
					}
				}
				if(nodes_ < nodes_curr){
					cookievalue += escape(unescape(clickCheckboxs[i])) + ",";
				}
			}
		}
		cookievalue += this_cookievalue + ",";
		for(var i=0;i<clickCheckboxs.length;i++){
			if((","+cookievalue).indexOf(","+escape(unescape(clickCheckboxs[i]))+",")==-1){
				cookievalue += escape(unescape(clickCheckboxs[i])) + ",";
			}
		}
		document.cookie = menuid + "=" + cookievalue.substr(0,cookievalue.length-1);
	}
	floatSelectAllCheckbox();
	floatShowFloat();
}
/**
 * 取消选中checkbox
 * @param {Object} checkboxvalue
 * @param {Object} value
 */
function floatChangeClickFloatNotchecked(checkboxvalue){
	var clickCheckbox = getCookieValue(menuid);
	var finalvalue = "";
	var clickCheckboxs = clickCheckbox.split(",");
	for(var i=0;i<clickCheckboxs.length;i++){
		if(clickCheckboxs[i].split(":")[0] != checkboxvalue){
			finalvalue += "," + escape(unescape(clickCheckboxs[i]));
		}
	}
	if(finalvalue!=""){
		finalvalue = finalvalue.substr(1);
	}
	document.cookie = menuid + "=" + finalvalue;
	floatSelectAllCheckbox();
	floatShowFloat();
} 
/**
 * 点击操作按钮时判断勾选情况
 * @param {Object} type 1为只能选一条,0为能多选
 * @param {Object} czms 操作内容
 * @return {TypeName} false为勾选数量有误 其他返回勾选控件值
 */
function floatchickButton(type, czms){
	var slength = 0;
	var clickCheckbox = "";
	if(turnPageTickOff){
		clickCheckbox = getCookieValue(menuid);
		if(clickCheckbox.indexOf(":")==-1){
			slength = 0;
		}else{
			slength = clickCheckbox.split(",").length;
		}
	}else{
		var a = document.getElementsByName("selectNode");
		for ( var i = 0; i < a.length; i++) {
			if (a[i].checked) {
				slength += 1;
			}
		}
	}
		
	if(type == 1){ //只能选1条
		if (slength == 1) {
			if(turnPageTickOff){
				return clickCheckbox.split(":")[0];
			}else{
				return CropCheckBoxValueAsString("selectNode");
			}
		} else {
			alert("请勾选一条记录!");
			return false;
		}
	}else{ //能选多条
		if (slength > 0) {
			var ids = "";
			if(turnPageTickOff){
				var clickCheckboxs = clickCheckbox.split(",");
				for(var i=0;i<clickCheckboxs.length;i++){
					if(i!=0){
						ids += ",";
					}
					ids += clickCheckboxs[i].split(":")[0];
				}
			}else{
				ids = CropCheckBoxValueAsString("selectNode");
			}
			return ids;
		} else {
			alert("请勾选要"+czms+"的记录!");
			return false;
		}
	}
}
//浮动面板功能 end

/**
 * 打开输入/查看页面时格式化页面样式
 */
function detailPageStyle() {
	jQuery.noConflict();
	jQuery(document)
			.ready(function() {
				
				jQuery("select").change(function() {
					document.body.focus();
				});
				//弹出窗口文本框获取焦点
				if(jQuery("input[type='text'][class*='textinput']:visible:eq(0)")[0])
					jQuery("input[type='text'][class*='textinput']:visible:eq(0)")[0].focus();
				
				//load css,put here fix ie6 bug
					//jQuery('<link rel="stylesheet" type="text/css" href="../component/ymprompt/skin/dmm-green/ymPrompt.css">').appendTo("head");
					if (parent.document.getElementById("ym_bc_div")) {
						//打开窗口，先设置标题，清除上次窗口的提示
						parent.document.getElementById("ym-header-text").innerHTML = "<span style='color:#000000'>"
								+ document.title + "</span>";
						parent.document.getElementById("ym_bc_div").innerHTML = "";
					}
					//如果页面有提示信息，就放到下面消息栏来提示，ym_bc_div是左下角的div
					if (document.getElementById("SystemErrorMessage")) {
						//条件成立，说明是提交页面后，重新进入该页面
						//jQuery("#SystemErrorMessage").hide();
						var mesg = jQuery("#SystemErrorMessage span").html();
						var mesg_html;
						if (mesg.indexOf("成功") != -1) {
							mesg_html = "<span id='operateResultMsg' style='color:blue'>";
						} else {
							mesg_html = "<span id='operateResultMsg' style='color:red'>";
						}
						mesg_html += "<img src=\"../resources/images/attention.gif\" width=\"18\" height=\"18\" />";
						mesg_html += "&nbsp;" + mesg + "！</span>";
						jQuery("#SystemErrorMessage").html(mesg_html);//两处都放置提示，这里给用户看到，下面为标记是否刷新父窗口
						if (parent.document.getElementById("ym_bc_div")) {
							parent.document.getElementById("ym_bc_div").innerHTML = mesg_html;
						}
					}
					//查看状态保存按钮隐藏 输入框只读等
					doReadOnly();
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
function openEntity(id, readOnlyPage, urlParameterStr, actionMethod) {
	var uri;
	var _actionMethod = "input";
	if (actionMethod && actionMethod.length > 0) {
		_actionMethod = actionMethod;
	}
	uri = actionName + "-" + _actionMethod + "." + uri_suffix + "?reqtime="
			+ new Date().getTime();
	if (id && id.length > 0) {
		uri += "&wid=" + id;
	}
	if (urlParameterStr && urlParameterStr.length > 0) {
		uri += "&" + urlParameterStr;
	}

	var windowWidth = document.body.clientWidth - 200;
	var windowHeight = document.body.clientHeight - 60;
	if(windowWidth<650)
		windowWidth += 160;
	//	var windowHeight = 420;

	if (readOnlyPage || readOnlyPage == "true") {
		uri += "&readOnlyPage=" + readOnlyPage;
		openWindow(uri, windowWidth, windowHeight);
	} else if (dialogType_debug) {
		openDebugWindow(uri);
	} else {
		openWindow(uri, windowWidth, windowHeight);
	}
}

/**
 * 编辑选中的纪录
 */
function doModify() {
	var id = floatchickButton(1);
	if(id != false){
		openEntity(id, false);
	}
}

/**
 * 删除选中的纪录。
 * AJAX 请求传统页面方式实现
 */
function doRemove() {
	var ids = floatchickButton(0,"删除");
	if(ids != false){
		var conf = window.confirm("您确定要删除已选中的这些数据吗？");
		if (conf == true) {
			var url_bak = document.forms[0].action;
			var url = actionName + "-remove." + uri_suffix;
			$.post(url, {
				wid : ids,
				reqtime : (new Date()).getTime()
			}, function(data) {
				document.forms[0].action = url_bak;//还原URL，防止点查询按钮却执行删除！
					if (data.indexOf("删除成功") != -1) {
						$("input[name=selectNode]").each(function(i) {
							if (ids.indexOf(this.value) != -1) {
								$(this).parent().parent().remove();
							}
						});
						
						if(turnPageTickOff){
							document.cookie = menuid + "=;";
							floatShowFloat();
						}
						//alert("删除成功!");
					document.forms[0].action = window.location.href;
					document.forms[0].submit();
				} else {
					//alert(data);
					alert($(data).find("span").text());
				}
			});
		}
	} 
}

/**
 * 批量更新状态
 * @param shzt 审核状态值
 * @param shms 审核类型描述，会加入提示用户的语句
 * @param shyj 审核人填写的审核意见
 */
function myChangeState(shzt, shms, shyj) {
	var ids = floatchickButton(0,shms);
	if(ids != false){
		var conf = window.confirm("您确定要" + shms + "已选中的这些数据吗？");
		if (conf == true) {
			var url_bak = document.forms[0].action;
			var url = actionName + "-changeState." + uri_suffix + "?reqtime="
					+ (new Date()).getTime();
			$.get(url, {
				wid : ids,
				shzt : shzt,
				shyj : shyj
			}, function(data) {
				document.forms[0].action = url_bak;//还原URL，防止点查询按钮却执行删除！
					if (data == "操作成功") {
						if(turnPageTickOff){
							document.cookie = menuid + "=;";
							floatShowFloat();
						}
						alert(data + "！");
						document.forms[0].submit();
					}else if(data.indexOf("用户登录")!=-1) {
						window.location.href = "../identity/index.action";
						return;
					}else{
						alert(data + "！");
					}
				});
		}
	}
}

/**
 * 导出选中的记录,没有选中的默认全部导出
 * 重写此方法可以自定义导出界面
 */
function doExport() {
	alert('doExport');
	return false;
}
/**
 * 审核通过选中的记录
 * 重写此方法可以自定义审核功能
 */
function doUniChangeState(state, obj) {	
	super_doUniChangeState(state, obj);
}
/**
 * 审核通过选中的记录
 */
function super_doUniChangeState(state, obj) {
	var shzt = $(obj).find("span").html();	
	var ids = floatchickButton(0,shzt);
	if(ids != false){
		if (window.confirm("您确定要" + shzt + "已选中的这些数据吗？")) {
			var url_bak = window.location.href;
			var parms = null;
			if (document.getElementById("changestate_parms")) {
				parms = document.getElementById("changestate_parms").value;
			} else {
				alert("页面缺少必要信息(操作对象或主键名或菜单编号)!");
				return false;
			}
			var url = "../jsonVisitor/ajaxSys-doUniChangeState.action?"
					+ (new Date()).getTime();
			$.getJSON(url, {
				wid : ids,
				state : state,
				parms : parms
			}, function(data) {
				document.forms[0].action = url_bak;//还原URL，防止点查询按钮却执行删除！
					if(turnPageTickOff){
						document.cookie = menuid + "=;";
						floatShowFloat();
					}
					document.forms[0].submit();
				});
		}
	}
}
/**
 * 重置查询条件
 */
function doreset() {
	$("div table input").each(
			function(i) {
				if ($(this).attr("type") == 'text'
						|| $(this).attr("type") == 'password') {
					$(this).val('');
				}
			})
	$("div table select").val('');
}
/**
 * 客户端提交表单时的表单处理函数
 * 重写此方法可以自定义验证功能
 */
function doSave(useAutoValidate) {
	return super_doSave(useAutoValidate);
}

/**
 * 默认的提交表单时的表单处理函数
 * @param {Object} useAutoValidate 是否要自动验证必填。默认true
 * @param {Object} actionMethod
 * @return {TypeName} 
 */
function super_doSave(useAutoValidate, actionMethod){
	if (isValidateForm() && super_doSave_validateForm(useAutoValidate)) {
	    if (actionName == null || actionName == "undefind") {
	        actionName = getActionName();
	    }
	    if (actionMethod == null || actionMethod == "undefind") {
	    	actionMethod = "save";
	    }
	    document.forms[0].action = actionName + "-"+actionMethod+"."+uri_suffix;
	    $("#ysSaveButton").attr("disabled","true");
	    $("#ysSaveButton").unbind();
	    document.forms[0].submit();
	    return true;
	}
}
/**
 * 校验必填字段是否为空
 * 页面字段后面标记了红色星号（必填标记），自动查找出并验证是否为空。
 * 允许客户端不调用此功能，因为对于比较复杂的页面，此自动验证无法完成。如加星号，但是隐藏的等。
 * @param {Object} useAutoValidate 是否需要执行自动校验，默认执行
 * @memberOf {TypeName} 
 * @return {TypeName} 
 */
function super_doSave_validateForm(useAutoValidate){
	if(useAutoValidate == null || useAutoValidate == "undefind"){
		useAutoValidate = true;
	}
	if(useAutoValidate){
		var success = true;
		var column_name = ''; //字段中文名
		$("label").each(function(i){
			if(this.innerHTML == '*'){ //有必填标识
				var parent_html = $(this).parent().html();
				if(!isContainChinese(parent_html.split("<")[0])){ //字段名和文本框等不在同一个td中
					if($(this).parent().is("td")){//一般情况，TD里写文字
						column_name = $(this).parent().prev().html().replace("：","").replace(":","");
					}else if($(this).parent().parent().is("td")){//有时候label会被span嵌套，需要向上多找一层
						column_name = $(this).parent().parent().prev().html().replace("：","").replace(":","");
					}
				}else{ //字段名和文本框等在同一个td中
					column_name = parent_html.split("<")[0].replace("：","").replace(":","");
				}
				if($(this).parent().find("select").index()==-1 && $(this).parent().find("textarea").index()==-1){ 
					if( $(this).parent().css("display")!='none'
							&& $(this).parent().find("input").val().replace(/(^\s*)|(\s*$)/g, "")==''){ //文本框
						success = false;
						return success;
					}else{
						if($(this).parent().find("input").attr("type")=='radio' || $(this).parent().find("input").attr("type")=='checkbox'){ //单选和多选
							success = false;
							$(this).parent().find("input[type='radio']").each(function(i){ //单选
								if(this.checked)
									success = true;
							})
							$(this).parent().find("input[type='checkbox']").each(function(i){ //多选
								if(this.checked)
									success = true;
							})
							return success;
						}
					}
				}else if($(this).parent().find("select").index()!=-1){ //下拉
					if($(this).parent().find("select").val().replace(/(^\s*)|(\s*$)/g, "")==''){
						success = false;
						return success;
					}
				}else if($(this).parent().find("textarea").index()!=-1){ //文本域
					if($(this).parent().find("textarea").val().replace(/(^\s*)|(\s*$)/g, "")==''){
						success = false;
						return success;
					}
				}
			}
		})
		if(!success)
			alert(column_name+"不能为空！");
		return success;
	}
	return true;
}
/**
 * 提交列表页面上的查询
 * 提交前重置页码值。避免翻页后，修改查询条件，界面没有数据显示出来
 * @param {Object} resetUrl 是否重置url为list.c。
 */
function super_doSearch( resetUrl ){
	//点击查询按钮自动清空缓存
	if(turnPageTickOff){ 
		document.cookie = menuid + "=;";
	}
	var isSafeWords = isQueryWordsSafe();
	if(isSafeWords==false){
		return false;
	}

    if (actionName == null || actionName == "") {
        actionName = getActionName();
    }
    if(document.getElementById('yspager_currentPageno')){
    	document.getElementById('yspager_currentPageno').value=1;
    }
    if (resetUrl) {
    	document.forms[0].action = actionName + "-list." + uri_suffix + "?reqtime="+(new Date()).getTime();
	}
    //去除查询文本框中输入的空白
    $("input[type='text']").each(function(i){
    	this.value = this.value.replace(/(^\s*)|(\s*$)/g, "");
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
//    top.Dialog.open({URL:"../system/"+uri, Title:"无遮罩窗口", Modal:false});
//    alert(width + "==" + height);
    
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

function getActionName(){
	var url = window.location.href;
	var actionName = url.substring( url.lastIndexOf("/")+1, url.lastIndexOf("-") );
	return actionName;
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
				var num_entries = parseInt(TotalNum);
				var currentPageNo = parseInt(jQuery("#pager_currentPageno").val())-1;
				if( currentPageNo<1 ){
					currentPageNo = 0;//控件第一页从0开始
				}
				var eachPageRows = parseInt(jQuery("#eachPageRows").val());
				//分页事件
				jQuery("#jpagination").css("padding","5px 0 5px 0").pagination(num_entries, {
				    prev_text: "上一页",
				    next_text: "下一页",
				    num_edge_entries: 2,//最前、最后各显示几页
				    num_display_entries: 8,//显示多少页出来
				    current_page: currentPageNo,
				    items_per_page: eachPageRows,
				    //回调
				    callback: pageselectCallback
				});
				//下面插入“合89条记录”
				var TotalNumStr = " <span style='color:gray;font-size:12px'>合"+num_entries+"条记录</span>";
				jQuery("#jpagination .pagination").append(TotalNumStr);
			}
		}

	    function pageselectCallback(page_index, jq) {
	    	//调用原框架里的分页
	    	jQuery("#yspager_currentPageno").val(page_index+1);//加1是为了两个分页工具的索引 起始值一个是0，一个是1
	    	//jQuery("#pager_rollPageButton").click();
	    	//jQuery("form[name=ysform]").append("<input name='pager.currentPageno' value='"+(page+1)+"' type='hidden'/>");
	    	trunPage();
	    }
}
/**
 * 修改单选下拉框选项时恢复原有样式
 * @param {Object} data json返回值
 * @param {Object} id 单选下拉框标签id属性
 * @param {Object} name 动态生成的下拉没有ID的，可以传入name
 * @param {Object} value 要选中项的值
 * @param {Object} width 宽度
 * @param {Object} defaultOrNot 是否默认格式
 */
function changeSelectOption(data, id, name, value,width,defaultOrNot){
	if(data!=null && data!="[]" && data!=''){
		var jsonarray = eval("("+data+")");
		if(id!=''){
			$("#"+id+" option").remove();
			for(var i=0;i<jsonarray.length;i++){
				var obj = jsonarray[i];
				$("#"+id).append("<option value='"+obj.id+"'>"+obj.caption+"</option>");
			}
			if(width!=null && width!='undefind'){
				$("#"+id).attr("autoWidth","true");
				$("#"+id).width(width);
			}
			$("#"+id).parent().html($("#"+id));
			if(value!=null && value!=''){
				$("#"+id).val(value);
			}
			if(defaultOrNot==null || defaultOrNot=='undefind' || !defaultOrNot)
				$("#"+id).selectbox();
		}else{
			$("select[name='"+name+"'] option").remove();
			for(var i=0;i<jsonarray.length;i++){
				var obj = jsonarray[i];
				$("select[name='"+name+"']").append("<option value='"+obj.id+"'>"+obj.caption+"</option>");
			}
			$("select[name='"+name+"']").parent().html($("select[name='"+name+"']"));
			if(value!=null && value!=''){
				$("select[name='"+name+"']").val(value);
			}
			if(defaultOrNot==null || defaultOrNot=='undefind' || !defaultOrNot)
				$("select[name='"+name+"']").selectbox();
		}
		changeSelectPosition();
		//页面只读时单选下拉框也只读
		var url = location.href;
		var readOnly = false;
		if(url.indexOf("readOnlyPage")!=-1){
			var readOnlyPage_value_index = url.indexOf("readOnlyPage")+"readOnlyPage=".length;
			readOnly = url.substr(readOnlyPage_value_index,4)=='true';
		}else{
			readOnly = $("#readOnlyPage").val() == 'true';
		}
		if(readOnly){
			$("table[id!='notReadOnly'] select").parent().find("input[type='button']").attr("disabled","disabled"); 
			$("table[id!='notReadOnly'] select").parent().find("input[type='text']").attr("disabled","disabled");
		}
	}
}
/**
 * 级联修改复选框时
 * @param {Object} data json字符串
 * @param {Object} id 上级标签id
 * @param {Object} name checkbox的name属性
 * @param {Object} value checkbox的值
 * @param {Object} null_Value 没有数据时的提示信息
 * @param {Object} state 默认状态
 */
function changeCheckboxList(data,id,name,value,null_Value,state){
	if(data!=null && data!="[]" && data!=''){
		var jsonarray = eval("("+data+")");
		$("#"+id).html('');
		var html = '';
		for(var i=0;i<jsonarray.length;i++){
			var obj = jsonarray[i];
			html += '<input type="checkbox" name="'+name+'" value="'+obj.id+'" id="'+obj.id+'"';
			if(state == 'true'){
				html += ' checked';
			}
			html += '/>';
			html += '<input type="hidden" name="__checkbox_'+name+'" value="'+obj.id+'" />'
					+'<label for="'+obj.id+'">'+obj.caption+'</label>';
			if(i!=jsonarray.length-1){
				html += '</br>';
			}
		}
		$("#"+id).html(html);
	}else{
		if(null_Value.indexOf('选择')!=-1){
			$("#"+id).html(null_Value);
		}else{
			$("#"+id).html('<font color="red">'+null_Value+'</font>');
		}
	}
}
/**
 * 只读模式控制页面元素只读
 * @memberOf {TypeName} 
 */
function doReadOnly(){
	var url = location.href;
	var readOnly = false;
	if(url.indexOf("readOnlyPage")!=-1){
		var readOnlyPage_value_index = url.indexOf("readOnlyPage")+"readOnlyPage=".length;
		readOnly = url.substr(readOnlyPage_value_index,4)=='true';
	}else{
		if(jQuery("#readOnlyPage")[0]){
			readOnly = jQuery("#readOnlyPage").val() == 'true';
		}
	}
	if(readOnly){
		jQuery("table[id!='notReadOnly'] textarea").attr("readonly","readonly"); //文本域只读
		//下拉菜单只读
		jQuery("table[id!='notReadOnly'] select").parent().find("input[type='button']").attr("disabled","disabled"); 
		jQuery("table[id!='notReadOnly'] select").parent().find("input[type='text']").attr("disabled","disabled");
		jQuery("div table[id!='notReadOnly'] input").each(function(i){
			if(jQuery(this).attr("type")=='button'){
				//alert(this.value.replace(new RegExp(" ","gm"),"").replace(new RegExp("　","gm"),"").replace(/(^\s*)|(\s*$)/g, ""));
				if(this.value.indexOf('保')!=-1 || this.value.indexOf('新')!=-1){ //隐藏保存(保存并新增等)按钮
					jQuery(this).hide();
				}else if(this.value.indexOf('关')==-1 && this.value.indexOf('消')==-1){ //除了关闭和取消按钮外的其他按钮置灰
					jQuery(this).attr("disabled","disabled");
				}
			}
			if(jQuery(this).attr("type")=='text') //文本框只读
				jQuery(this).attr("readonly","readonly");
			if(jQuery(this).attr("type")=='checkbox') //复选框只读
				jQuery(this).attr("disabled","disabled");
			if(jQuery(this).attr("type")=='radio') //单选只读
				jQuery(this).attr("disabled","disabled");
		});
	}
}