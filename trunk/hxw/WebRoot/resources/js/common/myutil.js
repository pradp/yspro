/*********************************** common utils ***********************************/
//window.onerror = killErrors;

function killErrors(){
    return true;
}

function isIEBrowser(){
    var browser = navigator.appName;
    if (browser == "Netscape") {
        return false;
    }
    else {
        return true;
    }
}

/**
 * 截取URL参数
 * @param {Object} fieldName 参数名称
 */
function getUrlParamValue(fieldName){
	var urlString = document.location.search;
      if(urlString != null)
      {
           var typeQu = fieldName+"=";
           var urlEnd = urlString.indexOf(typeQu);
           if(urlEnd != -1)
           {
                var paramsUrl = urlString.substring(urlEnd+typeQu.length);
                var isEnd =  paramsUrl.indexOf('&');
                if(isEnd != -1)
                {
                     return paramsUrl.substring(0, isEnd);
                }
                else
                {
                    return paramsUrl;
                }
           }
           else 
           {
                return null;
           }
     }
     else
     {
        return null;
     }
}

String.prototype.replaceAll = function(search, replace){
    var regex = new RegExp(search, "g");
    return this.replace(regex, replace);
}

/************************************* about date *************************************/
function initMyDate(objStart, objEnd){
    var now = new Date();
    var dd = now.getDate() < 10 ? "0" + now.getDate() : now.getDate();
    var mt = (now.getMonth() + 1) < 10 ? "0" + (now.getMonth() + 1) : (now.getMonth() + 1);
    var yy = y2k(now.getYear());
    var now2 = Dateadd(now, -30);
    var dd2 = now2.getDate() < 10 ? "0" + now2.getDate() : now2.getDate();
    var mt2 = (now2.getMonth() + 1) < 10 ? "0" + (now2.getMonth() + 1) : (now2.getMonth() + 1);
    var yy2 = y2k(now2.getYear());
    if (objStart != null) {
        objStart.value = yy2 + "-" + (mt2) + "-" + dd2;
    }
    if (objEnd != null) {
        objEnd.value = yy + "-" + (mt) + "-" + dd;
    }
}

//fix firefox
function y2k(number){
    var num = parseInt(number, 10);
    return (num < 1000) ? (num + 1900) : num;
}

function Dateadd(nowDate, addDays){
    return new Date(nowDate.getTime() + addDays * 24 * 60 * 60 * 1000);
}

/************************************* about string ***************************************/
/**
 * 得到字符串的长度，汉字占3个字节。对应数据库的编码（UTF-8）
 * @param {Object} str 字符串
 */
function getLength(str){
    var i, sum;
    sum = 0;
    for (i = 0; i < str.length; i++) {
        if ((str.charCodeAt(i) >= 0) && (str.charCodeAt(i) <= 255)) 
            sum = sum + 1;
        else 
            sum = sum + 3;//UTF8编码，中文算三个字节
    }
    return sum;
}

/**
 * 把英文逗号隔开的字符串过滤，去掉前后逗号以及中间空的项
 * @param {Object} srcvalue
 */
function filterit(srcvalue){
    var tvalue = "";
    var tmp = new Array();
    tmp = srcvalue.split(",");
    for (i = 0; i < tmp.length; i++) {
        if (tmp[i] != "") {
            if (i == tmp.length - 1) {
                tvalue += tmp[i];
            }
            else {
                tvalue += tmp[i] + ",";
            }
        }
    }
    if (tvalue.lastIndexOf(",") == tvalue.length - 1) {
        tvalue = tvalue.substring(0, tvalue.length - 1);
    }
    return tvalue;
}

/**
 * 把被选中的checkbox的值以字符串返回，用英文逗号隔开
 * @param {Object} checkboxName
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

function CropCheckBoxValueByObj(checkboxObjects){
    var tmp = "";
    for (var i = 0; i < checkboxObjects.length; i++) {
        if (checkboxObjects[i].checked) {
            tmp += checkboxObjects[i].value + ",";
        }
    }
    tmp = tmp.substring(0, tmp.length - 1);
    return tmp;
}

/**
 * 字符串中是否包含中文
 * @param {Object} str
 */
function isContainChinese(str){
    var reg = /[\u4e00-\u9fa5]/g;
    if (reg.test(str)) {
        //alert("含有汉字");
	  return true;
    }
    else {
       // alert("不含有汉字");
	 return false;
    }
}

/**
 * 检查字符串是否包含特殊字符
 */
function isContainSpecialChar(str){
	if(str && str!=""){
	    var myReg = /^[^@\/\'\\\"#$%&\^\*]+$/;
	    if(myReg.test(str)){
	    	return false; 
	    }else{
	        return true; 
	    }
	}else{
        return false; 
    }
}

/****************************** about number ********************************/
/**
 * 检查是否纯数字组合
 * 一般用在表单提交时检查
 * @param {Object} NUM 要被检查的字符串
 * @param {Object} allowDot 允许点号，默认不允许
 * @param {Object} allowNegative 允许负号，默认不允许
 */
function CheckNum(NUM, allowDot, allowNegative){
    var i, j, strTemp;
    strTemp = "0123456789";
    if (allowDot) {
        strTemp += ".";
    }
    if (allowNegative) {
        strTemp += "-";
    }
    if (NUM == null || NUM.length == 0) {
        return false;
    }
    if (NUM.indexOf("-") > 0) {
        //有负号，且位置不在开头
        return false;
    }
    var sss = 0, vvv = 0;
    for (i = 0; i < NUM.length; i++) {
        ch = NUM.charAt(i);
        if ("." == ch) 
            sss += 1;
        if ("-" == ch) 
            vvv += 1;
    }
    if (sss > 1 || vvv > 1) {
        //小数点或者负号出现一次以上
        return false;
        
    }
    for (i = 0; i < NUM.length; i++) {
        j = strTemp.indexOf(NUM.charAt(i));
        if (j == -1) {
            return false;
        }
    }
    return true;
}

/**
 * 让输入时只能输入数字 46是小点 45是-号
 * 用在输入时控制输入字符
 * @param {Object} evt 键盘输入事件
 * @param {Object} allowNegative 是否允许输入负号（-），默认不允许
 * @param {Object} allowPoint 是否允许输入小数点（.），默认不允许
 */
function NumberText(evt, allowNegative, allowPoint){
    var mykeyCode;
    if (isIEBrowser()) {
        mykeyCode = window.event.keyCode;
    } else {
        mykeyCode = evt.which;
    }
    if (mykeyCode < 48 || mykeyCode > 57) {
        //非数字部分
        if (allowNegative && mykeyCode == 45) {
            //允许负号
        } else if (allowPoint && mykeyCode == 46) {
            //允许小数点
        } else if ( mykeyCode == 8 ) {
            //删除键，放过
        } else 
            if (isIEBrowser()) {
                window.event.returnValue = "";
            } else {
                evt.preventDefault();
            }
    }
}

/**
 * 过滤掉所有非法字符，重设输入框的值为安全数据
 * @param {Object} obj
 */
function resetNumValue(obj){
    obj.value = filterNumberInput(obj.value);
}

function filterNumberInput(textValue){
    textValue = textValue.replace(/[\u4e00-\u9fa5]/g, "");//汉字
    textValue = textValue.replace(/[a-zA-Z_\s]/g, "");//字母和空格
    //textValue = textValue.replace(/[^uFF00-uFFFF]/g,"");//全角
    textValue = textValue.replace(/([~`!@#%&_=|,:;<>*+?^'"${}()|[\]\/\\])/g, "");//除小数点和负号的其他特殊符号
    return textValue;
}

/***** about window *******/
function SetFullScreen(){
    setTimeout("top.moveTo(0,0)", 500);
    setTimeout("top.resizeTo(screen.availWidth,screen.availHeight)", 1000);
}

function isAllowOpenWindow(){
    var allow = false;
    var params = "top=0,left=0,width=0,height=0,toolbar=no,resizable=no,scrollbars=auto,location=no,status=no,menubar=no";
    var nwindow = window.open("", "", params);
    if (nwindow == null) {
        alert("您的游览器禁止了弹出新窗口！\n\n请修改为允许本站点弹出新窗口！");
    }
    else {
        allow = true;
        nwindow.close();
    }
    return allow;
}

function openTreeDialog(url){
    var params = "dialogWidth=310px;dialogHeight=520px";
    return openDialog(url, params);
}

function openDialog2(url, params){
    var nwindow;
    
    if (params == null || params == "") {
        params = "top=60,left=150,width=610,height=560,toolbar=no,resizable=no,scrollbars=auto,location=no,status=no,menubar=no";
    }
    nwindow = window.open(url, "", params);
    
    return nwindow;
}

function openDialog(url, params, matchbrowser){
    var nwindow;
    
    if (matchbrowser != null && matchbrowser == false) {
        if (params == null || params == "") {
            params = "top=60,left=150,width=610,height=560,toolbar=no,resizable=no,scrollbars=auto,location=no,status=no,menubar=no";
        }
        nwindow = openDialog2(url, params);
    }
    else {
        //不用isIEBrowser()了，现在firefox也支持showModalDialog了！
        if (params == null || params == "") {
            params = "dialogWidth=610px;dialogHeight=620px";
        }
        try {
            nwindow = window.showModalDialog(url, window, params);
        } 
        catch (e) {
            var ms = "warning:can not create new window.\n try change the type parameter to 'window'.\n\n";
            ms += "error message:" + e.Message + "\n" + e.description;
            alert(ms);
            nwindow = openDialog2(url, params);
            //nwindow = window.showModalDialog(url,window,params);
        }
    }
    return nwindow;
}

function getParentWindow(){
    if (window.opener) {
        return window.opener;
    }
    else 
        if (window.dialogArguments) {
            return window.dialogArguments;
        }
        else {
            return window.parent;
        }
}

function getParentWindowDocument(){
    return getParentWindow().document;
}

function setParentWindowValue(objid, value){
    var pd = getParentWindowDocument();
    pd.getElementById(objid).value = value;
}

function getParentWindowValue(objid){
    var pd = getParentWindowDocument();
    var pv = "";
    if (pd.getElementById(objid)) {
        pv = pd.getElementById(objid).value;
    }
    return pv;
}

function closeThisWindow(){
    window.opener = null;
    window.open('', '_self', '');
    window.self.close();
    //window.top.window.close();
    //window.opener = window;
}

function getIFrameDocument(IFrameID){
    var rv = null;
    
    // if contentDocument exists, W3C compliant (Mozilla)
    if (document.getElementById(IFrameID).contentDocument) {
        rv = document.getElementById(IFrameID).contentDocument;
    }
    else {
        // IE
        rv = window.frames[IFrameID];
    }
    return rv;
}

function compareDate(first, second, sign){
    fArray = first.split(sign);
    sArray = second.split(sign);
    var fDate = new Date(fArray[0], fArray[1], fArray[2]);
    var sDate = new Date(sArray[0], sArray[1], sArray[2]);
    
    var t = Math.abs(fDate.getTime() - sDate.getTime());
    var days = t / (1000 * 60 * 60 * 24);
    return days;
}

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

function checkForm(){
    var arr_ele = document.forms[0].elements;
    for (var i = 0; i < arr_ele.length; i++) {
        if (arr_ele[i].type != "checkbox" && arr_ele[i].type != "hidden") {//select-one text checkbox
            if (arr_ele[i].value == "") {
                var yesPost = window.confirm("系统检测到有一些数据项您没有填写完整！\n\n点击“确定”执行提交，点击“取消”返回！");
                if (yesPost == false) {
                    try {
                        arr_ele[i].focus();
                    } 
                    catch (err) {
                    }
                    return false;
                }
                else {
                    break;
                }
            }
        }
    }
    return true;
}

/**
 * 检查表单元素的值是否有值
 * @return 有值返回true； 空返回false
 */
function checkInput(objid, alertString){
    if (alertString && alertString !== "") {
        if (document.getElementById(objid) && document.getElementById(objid).value == "") {
            alert(alertString);
            if (document.getElementById(objid).tagName == 'INPUT' && document.getElementById(objid).type !== 'hidden') {
                document.getElementById(objid).focus();
            }
            return false;
        }
        else {
            return true;
        }
    }
    else {
        if (document.getElementById(objid) && document.getElementById(objid).value == "") {
            return false;
        }
        else {
            return true;
        }
    }
}

/**
 * 检查传入的参数是HTML对象，还是String值
 * @param {Object} obj
 * @return if htmlObject return true,elseif String value return false.
 */
function testObject(obj){
    if (obj != null && typeof(obj) == 'object' && typeof(obj.tagName) != 'undefined' && typeof(obj.constructor) != 'function') {
        return true;
    }
    else 
        if (obj != null && typeof(obj) == 'string') {
            return false;
        }
}

/**
 * 状态为multiple="multiple"的 select控件
 * 全部选中里面的值
 */
function selectedAllSelect(obj){
    for (i = 0; i < obj.options.length; i++) {
        obj.options[i].selected = true;
    }
}

/**
 * Enter键焦点转到下个控件
 * @param {Object} index
 */
function compnent_onkeydown(index, e){
    var _keyCode = 0;
    if (document.all) {
        _keyCode = window.event.keyCode;
    }
    else {
        _keyCode = e.which;
    }
    if (_keyCode == 13) {
        ++index;
        while ((document.getElementById(compnent_list[index]).disabled == true) && (index < compnent_list.length)) {
            ++index;
        }
        if (index < compnent_list.length) 
            document.getElementById(compnent_list[index]).focus();
    }
}

/***************************** cookie 相关处理函数 ***************************************/
function getCookieValue(ys_cookie_name){
	var cookieString = new String(document.cookie);
	var cookieHeader = ys_cookie_name+"=";
	var beginPosition = cookieString.indexOf(cookieHeader);
	//alert(cookieString);
	if (beginPosition != -1) //cookie已经设置值
	{
		beginPosition += ys_cookie_name.length + 1;
		var endPosition = cookieString.indexOf(";", beginPosition);
		if (endPosition == -1){
			endPosition = cookieString.length;
		}
		var value = unescape(cookieString.substring(beginPosition, endPosition));
		
		return value;
	}
	else//cookie没有设置值　
	{
		return "";
	}
}

/***************************** about form validate ***************************************/
var validate_required_fields = [];//json
var validate_length_range_fields = [];//json
var validate_type_fields = [];//json
//alert(getJsonLength(validate_required_fields));

function getJsonLength(jsonObj){
	var sum = 0;
	for(var obj in jsonObj){
		sum += 1;
	}
	return sum;
}
/**
 * 验证表单。有不符合的就返回false。全部通过返回true。
 */
function isValidateForm(){
	try{
		//验证表单字段
		validate_form();
		return true;
	}catch(msg){
		alert(msg);
		return false;
	}
}
/**
 * 验证表单，有不符合的就抛异常传递消息。
 */
function validate_form(){
	
	validate_required();
	
	validate_length_range();
	
	validate_type();
	//validate_mustAllChinese();
}
function validate_required(){
	for(var i=0; i<validate_required_fields.length; i++){
		var o = validate_required_fields[i];
		//alert( o.mustMatch );
		if( o.mustMatch ){
			validate_field_required( o.fieldId, o.message, o.mustMatch );
		}else{
			validate_field_required( o.fieldId, o.message );
		}
	}
}

/**
 * 根据ID，验证此控件是否有值。
 * @param {Object} fieldId 待验证控件的ID
 * @param {Object} message 如果为空，提示信息。
 * @param (boolean) mustMatch 如果不存在此控件，是否抛出错误提示。默认为false，表示不存在就不验证它。
 * @return 此控件有值，什么都不返回。没有值，或者不存在此控件，抛出异常。
 */
function validate_field_required(fieldId, message, mustMatch){
	if(document.getElementById(fieldId)){
		var val = document.getElementById(fieldId).value;
		val = val.replaceAll(" ","");
		if(val==""){
			try{
				document.getElementById(fieldId).focus();
			}catch(err){}
			if(message){
				throw message;
			}else{
				throw "不能为空！点击确定后会返回此必填项。";
			}
		}
	}else{
		if(mustMatch){
			throw "不存在ID为["+fieldId+"]的待验证控件！";
		}
	}
}

function validate_length_range(){
	for(var i=0; i<validate_length_range_fields.length; i++){
		var o = validate_length_range_fields[i];
		if( o.mustMatch ){
			validate_field_length_range( o.fieldId, o.minLen, o.maxLen, o.message, o.ignoreIfEmpty, o.mustMatch );
		}else{
			validate_field_length_range( o.fieldId, o.minLen, o.maxLen, o.message, o.ignoreIfEmpty );
		}
	}
}
/**
 * 验证字段值的长度。注意长度按字节算。一个汉字算3个字节，即使用的是UTF-8编码。
 * @param {Object} fieldId 待验证控件的ID
 * @param {Object} minLen 最小长度。默认0长度
 * @param {Object} maxLen 最大长度。默认无限制。输入null或者0 也表示不限制
 * @param {Object} message 如果不在规定长度范围内时的提示信息。
 * @param (boolean) mustMatch 如果不存在此控件，是否抛出错误提示。默认为false，表示不存在就不验证它。
 * @param (boolean) ignoreIfEmpty 如果此控件中没有值，则忽略此条验证项。默认为false。
 */
function validate_field_length_range(fieldId, minLen, maxLen, message, ignoreIfEmpty, mustMatch){
	var temp_minLen = 0;
	if(minLen){
		temp_minLen = parseInt( minLen );
	}
	if(document.getElementById(fieldId)){
		var val = document.getElementById(fieldId).value;
		if( ignoreIfEmpty ){
			if( val.replaceAll(" ","")=="" ){
				return;
			}
		}
		var valLength = getLength(val);//UTF8长度
		if( valLength < temp_minLen ){
			try{
				document.getElementById(fieldId).focus();
			}catch(err){}
			if(message){
				throw message;
			}else{
				throw "长度太小！点击确定后会返回此项重新输入。";
			}
		}
		if(maxLen){
			if( parseInt( maxLen )!=0 && valLength > parseInt( maxLen ) ){
				try{
					document.getElementById(fieldId).focus();
				}catch(err){}
				if(message){
					throw message;
				}else{
					throw "长度太大！点击确定后会返回此项重新输入。";
				}
			}
		}
	}else{
		if(mustMatch){
			throw "不存在ID为["+fieldId+"]的待验证控件！";
		}
	}
}

function validate_type(){
	for(var i=0; i<validate_type_fields.length; i++){
		var o = validate_type_fields[i];
		validate_field_type( o.fieldId, o.message, o.typeRule );
	}
}
/**
 * 验证字段格式是否正确
 * @param {Object} fieldId 
 * @param {Object} message 
 * @param {Object} typeRule 规则对象。requiredType:"number" "phone" "mobile"
 * 当为number时：typeRule:{requiredType:"number", allowDot:true, allowNegative:false}
 */
function validate_field_type(fieldId, message, typeRule){
	if(document.getElementById(fieldId)){
		if(typeRule && typeRule.requiredType){
			var val = document.getElementById(fieldId).value;
			val = val.replaceAll(" ","");
			if(val!="" && typeRule.requiredType=="number"){
				var f = CheckNum(val, typeRule.allowDot, typeRule.allowNegative);
				if( !f ){
					try{
						document.getElementById(fieldId).focus();
					}catch(err){}
					if(message){
						throw message;
					}else{
						throw "格式不正确！点击确定后会返回此项重新输入。";
					}
				}
			}else if(val!="" && typeRule.requiredType=="phone"){
				var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
				if( !tel.test(val) ){
					try{
						document.getElementById(fieldId).focus();
					}catch(err){}
					if(message){
						throw message;
					}else{
						throw "格式不正确！点击确定后会返回此项重新输入。";
					}
				}
			}else if(val!="" && typeRule.requiredType=="mobile"){
				var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))\d{8})$/;
				if( (val.length!=0 && val.length!=11 && val.length!=12) || !mobile.test(val) ){
					try{
						document.getElementById(fieldId).focus();
					}catch(err){}
					if(message){
						throw message;
					}else{
						throw "格式不正确！点击确定后会返回此项重新输入。";
					}
				}
			}else if(val!="" && typeRule.requiredType=="chinese"){
				var mobile = /^[\u4e00-\u9fa5]+$/;				
				if(!mobile.test(val)){
					try{
						document.getElementById(fieldId).focus();
					}catch(err){}
					if(message){
						throw message;
					}else{
						throw "格式不正确！点击确定后会返回此项重新输入。";
					}
				}
			}else if(val!="" && typeRule.requiredType=="email"){
				var email = /^[a-zA-Z0-9_\.\-]+\@([a-zA-Z0-9\-]+\.)+[a-zA-Z0-9]{2,4}$/;
				if(!email.test(val)){
					try{
						document.getElementById(fieldId).focus();
					}catch(err){}
					if(message){
						throw message;
					}else{
						throw "格式不正确！点击确定后会返回此项重新输入。";
					}
				}
			}
		}
	}
}

/***************************** add by yangjianliang at 20090519 30分钟没有操作的用户自动退出 ***************************************/
/**
 * 这里负责更新cookie里时间，在headMesage.jsp里定时查看是否20分钟了，cookie没有更新，就执行退出
 */
var ys_cookie_name = "ys_cookie_name";
var ys_cookie_life = 20*1000*60;//分钟
writeTime2Cookie();
/**
 * 检查cookie多久没有更新（用户多久没有操作），超过指定时间表示超时了，返回 true
 * @param {Object} intervalMinute 认为超时的间隔时间，单位分钟
 */
function isCookieOverTime(){
	var lastTime = getCookieValue(ys_cookie_name);
	if(lastTime==""){//cookie没有设置过期时间，取不到说明是初次加载页面
		//alert("cookie过期");
		writeTime2Cookie();
		//return true;
	}else{
		var nowTime = (new Date()).getTime();
		var interval = ys_cookie_life;//默认
		if((nowTime*1 - lastTime*1)>=interval){//超过设定的时间了
			//alert("cookie超时，设定"+interval+"，时间已过");
			return true;
		}
	}
	return false;
}
function writeTime2Cookie(){
	var ysnow = new Date();
	var then = new Date();
	then.setTime(ysnow.getTime() + ys_cookie_life );//分钟后失效
	//document.cookie = ys_cookie_name+"="+ysnow.getTime()+";expires="+ then.toGMTString();
	document.cookie = ys_cookie_name+"="+ysnow.getTime()+";path="+"/"+"";
	//var tt = new Date();
	//tt.setTime(getCookieValue(ys_cookie_name));
	//alert("更新日期为："+tt.toLocaleString());
}

