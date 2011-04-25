function XMLHttpObject(method,url,Syne){
	var	XMLHttp=null;
	var	o=this;
	this.method=method;
	this.url=url;
	this.Syne=Syne;
	this.text="";
	this.xmldoc=null;
	this.params=null;

	this.sendData = function()
	{
		if (window.XMLHttpRequest) {
			XMLHttp	= new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			XMLHttp	= new ActiveXObject("Microsoft.XMLHTTP");
		}
		with(XMLHttp){
			open(this.method.toUpperCase(), this.url, this.Syne);
			if(this.method.toUpperCase()=="POST") {
			    setRequestHeader("Method", "POST "+this.url+" HTTP/1.1");
  				setRequestHeader("Content-Type","application/x-www-form-urlencoded");//指定为表单方式
			    //setRequestHeader("Accept-Language", "zh-cn");
			    //setRequestHeader("Content-Length",this.params.length);
			    //setRequestHeader("Cache-Control", "no-cache");
				//setRequestHeader("Pragma","no-cache");
			} else {
				setRequestHeader("Content-Type","text/xml;charset=utf-8");
			}
			onreadystatechange = o.onCallBack;
			send(this.params);
		}
	}

	this.onCallBack=function()
	{
		if (XMLHttp.readyState == 4) {
			//alert(XMLHttp.readyState);
			if (XMLHttp.status == 200) {
				o.text = XMLHttp.responseText;
				//o.xmldoc=XMLHttp.responseXML;
				o.CallBackOK();
			} else if(XMLHttp.status == 204) {
				o.CallBackFailed();
			} else if(XMLHttp.status == 203) {
				o.CallBackTimeout();
			} else {
				o.CallBackFailed();
			}
		}
	}

	this.CallBackFailed=function(){};
	this.CallBackTimeout=function(){};
	
}

/**
将指定表单中数据项格式化为串接型
方便xmlhttp post
*/
function convertFormDataToPostContent(form_name){

	var content_to_submit ="";
	var form_element;
	var last_element_name ="";

	for (i = 0; i < form_name.elements.length; i++){
		form_element = form_name.elements[i];
		switch (form_element.type){
			//Text fields, hidden form elements
			case 'text':
			case 'hidden':
			case 'password':
			case 'textarea':
			case 'select-one':
			//content_to_submit += form_element.name + '=' + escape(form_element.value) + '&';
			content_to_submit += form_element.name + '=' + encodeCN(form_element.value) + '&';
			break;
			// Radio buttons
			case 'radio':
			if (form_element.checked){
				content_to_submit += form_element.name + '=' + encodeCN(form_element.value) + '&';
			}
			break;
			// Checkboxes
			case 'checkbox':
			if (form_element.checked){
			// Continuing multiple, same-name checkboxes
				if (form_element.name == last_element_name){
				// Strip of end ampersand if there is one
					if (content_to_submit.lastIndexOf('&') == content_to_submit.length - 1){
						content_to_submit = content_to_submit.substr(0,content_to_submit.length - 1);
					}
					// Append value as comma-delimited string
					content_to_submit += ',' + encodeCN(form_element.value);
				}
				else{
					content_to_submit += form_element.name + '=' + encodeCN(form_element.value);
				}
				content_to_submit += '&';
				last_element_name = form_element.name;
			}
			break;
		}
	}
	// Remove trailing separator
	content_to_submit = content_to_submit.substr(0, content_to_submit.length - 1);
	return content_to_submit;
}

function encodeCN(res){
//解决中文编码问题
/*   encodeURIComponent函数是将传入的参数转换成utf-8编码以后再做URL编码，可以在
 * 服务器端自动完成URL解码。注意URL解码后的是utf-8编码的串，需要自行完成到
 *      所需编码的转换
 *   escape函数是将传入的参数转换成unicode编码以后再做URL编码，在服务器端一般不
 *      能全部完成URL解码。参数中的汉字将以%uhhhh的形式出现，处理上稍嫌麻烦
 */
	return encodeURIComponent(res);
	//return escape(res);
}