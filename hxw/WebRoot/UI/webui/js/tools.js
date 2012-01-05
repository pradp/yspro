/*
 *Name:样式控制JS;
 *Author:lchen;
 *Version:2010-04-01
 */

function displaySubMenu(span) {
	var subMenu = span.getElementsByTagName("ul")[0];
	subMenu.style.display = "block";
}
function hideSubMenu(span) {
	var subMenu = span.getElementsByTagName("ul")[0];
	subMenu.style.display = "none";
}

function goToUrl(url){
	window.location = url;
}
//图片大小自适应
function ImgAuto(i){
	 var MaxW=120;
	 var MaxH=120;
	 var o=new Image();o.src=i.src;var w=o.width;var h=o.height;var t;if (w>MaxW){t=MaxW;}else{t=w;}
	 if ((h*t/w)>MaxH){i.height=MaxH;i.width=MaxH/h*w;}else{i.width=t;i.height=t/w*h;}
	 }
//首页上的TAB JS
function changeTabForMain(tag,tabNum){ 
	for(i=1; i <tabNum; i++)
	 {
	  if (i==tag)
	  { 
	   document.getElementById("info"+i).className="see";
	   document.getElementById("tag"+i).className="tabsClick";
	  }
	  else{
	   document.getElementById("info"+i).className="hide";
	   document.getElementById("tag"+i).className="tabsa";
	  } 
	 }
	}
//个人基本信息使用JS
function changeTab(num, url) {
	if (url != '') {
		window.location = url;
	}
	for ( var i = 1; i < 13; i++) {
		$("#li" + i).removeClass();
	}
	$("#li" + num).addClass("goalTab");
}

// UL LI隔行变色
function ghhs() {

	var line = $("#personMessage li");
	for ( var i = 1; i < line.length + 1; i++) {
		line[i - 1].className = (i % 2 > 0) ? "blueColor" : "whiteColor";
	}
	return;
}

//个人详情中UL LI隔行变色
function changeLiColor(tag) {

	var line = $("#list_div "+tag);
	for ( var i = 1; i < line.length + 1; i++) {
		line[i - 1].className = (i % 2 > 0) ? "deep_color" : "whiteColor";
	}
	return;
}
/*-------------------------------------------------------
 封装新建类弹出模态窗口
 --------------------------------------------------------*/
function showDialog(title, width, height, url) {
	window.top.ymPrompt.win( {
		message : url,
		width : width,
		height : height,
		title : title,
		iframe : true
	});
}

/*-------------------------------------------------------
 封装新手指南弹出模态窗口
 --------------------------------------------------------*/
function showNewDialog(url, width, height, x, y) {
	window.top.ymPrompt.win( {
		message : url,
		width : width,
		height : height,
		iframe : true,
		titleBar : false,
		winPos : [ x, y ],
		maskAlpha : 0
	});
}

/*---------------------------------------------------------------
 checkbox全选
 ---------------------------------------------------------------*/
function selectAllRes(id, name) {

	$("input[name='" + name + "']").each(function() {
		var ckif = $("#" + id).get(0).checked;

		this.checked = ckif;
	})
}

function selectAll(id, name) {
	$("#" + id).attr("checked", "checked");
	selectAllRes(id, name);
}





String.prototype.replaceAll = function(s1, s2) {
	return this.replace(new RegExp(s1, "gm"), s2);
};
String.prototype.len = function() {
	var str = this;
	return str.replace(/[^\x00-\xff]/g, "**").length
};

function lessBody(param, end, maxlen) {
	param = param.replaceAll("</?(IMG|img)[^<>]*/?>", "");
	var result = "";
	var n = 0;
	var temp;
	var isCode = false; // 是不是HTML代码
	var isHTML = false; // 是不是HTML特殊字符,如&nbsp;
	for ( var i = 0; i < param.length; i++) {
		temp = param.charAt(i);
		if (temp == '<') {
			isCode = true;
		} else if (temp == '&') {
			isHTML = true;
		} else if (temp == '>' && isCode) {
			n = n - 1;
			isCode = false;
		} else if (temp == ';' && isHTML) {
			isHTML = false;
		}

		if (!isCode && !isHTML) {
			n = n + 1;
			// UNICODE码字符占两个字节
			if ((temp + "").len() > 1) {
				n = n + 1;
			}
		}

		result += temp;
		if (n >= maxlen) {
			break;
		}
	}
	result += end;
	// 取出截取字符串中的HTML标记
	var temp_result = result.replaceAll("(>)[^<>]*(<?)", "$1$2");
	if (param.length - temp_result.length < maxlen)
		return param;
	// 去掉不需要结素标记的HTML标记
	temp_result = temp_result
			.replaceAll(
					"</?(AREA|BASE|BASEFONT|BODY|BR|COL|COLGROUP|DD|DT|FRAME|HEAD|HR|HTML|IMG|INPUT|ISINDEX|LI|LINK|META|OPTION|P|PARAM|TBODY|TD|TFOOT|TH|THEAD|TR|area|base|basefont|body|br|col|colgroup|dd|dt|frame|head|hr|html|img|input|isindex|li|link|meta|option|p|param|tbody|td|tfoot|th|thead|tr)[^<>]*/?>",
					"");
	// 去掉成对的HTML标记
	temp_result = temp_result
			.replaceAll("<([a-zA-Z]+)[^<>]*>(.*?)</\\1>", "$2");
	// 用正则表达式取出标记
	var reg = new RegExp("<([a-zA-Z]+)[^<>]*>", "gm");
	var arr;
	if (reg.test(temp_result)) {
		arr = (temp_result.match(reg));
	}
	if (arr != null && arr.length > 0) {
		for ( var j = 0; j < arr.length; j++) {
			if (arr[j].indexOf(" ") > 0)
				result = result + "</"
						+ arr[j].substring(1, arr[j].indexOf(" ")) + ">";
			else
				result = result + "</" + arr[j].substring(1, arr[j].length - 1)
						+ ">";
		}
	}
	return result;
}


var curSelect = null;
var signSelect = null;
function changeProvince(provinceValue, url, sign, toSelect) {	
	if (!provinceValue) {
		var child = document.getElementById(toSelect);
		while (child.childNodes.length > 0) {
			child.removeChild(child.childNodes[0]);
		}

		if (sign == 1) {
			var corpOption = null;
			corpOption = document.createElement("option");
			corpOption.setAttribute("value", "");
			corpOption.appendChild(document.createTextNode(""));
			child.appendChild(corpOption);
		} else if (sign == -1) {
			var corpOption = null;
			corpOption = document.createElement("option");
			corpOption.setAttribute("value", "");
			corpOption.appendChild(document.createTextNode("不限"));
			child.appendChild(corpOption);
		}		
		
	} else {
		signSelect = sign;
		curSelect = toSelect;
		var reqUrl = url + "?province=" + provinceValue + "&time=" + Math.random();
		$.ajax( {
			type : 'GET',
			url : reqUrl,
			dataType: "json",
			async: false,
			cache: false,
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				document.write(XMLHttpRequest.responseText);
			},
			success : function(data) {
				ajaxXMLCity(data);
			}
		});
	}
}

jQuery.extend({ 
   /** * @see 将json字符串转换为对象 * @param json字符串 * @return 返回object,array,string等对象 */ 
   evalJSON: function(strJson) { 
     return eval("(" + strJson + ")"); 
   } 
}); 


function ajaxXMLCity(data) {
	var child = document.getElementById(curSelect);

	while (child.childNodes.length > 0) {
		child.removeChild(child.childNodes[0]);
	}
	
	if (signSelect == 1) {
		var option = null;
		option = document.createElement("option");
		option.setAttribute("value", "");
		option.appendChild(document.createTextNode(""));
		child.appendChild(option);
	} else if (signSelect == -1) {
		var option = null;
		option = document.createElement("option");
		option.setAttribute("value", "");
		option.appendChild(document.createTextNode("不限"));
		child.appendChild(option);
	}
	
	if(data["flag"] != "success"){
		document.write(data);
	}else{
		var optionsString = "";
		var citysMap = $.evalJSON(data["citysMap"]);
		 
	    $.each(citysMap,function(value,name) {   
	      	optionsString += "<option value=\""+value+"\">"+name+"</option>"; 
	    });	
	    
		$("#"+curSelect).append(optionsString);
	}
}