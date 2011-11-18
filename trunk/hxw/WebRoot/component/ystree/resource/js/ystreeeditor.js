/**
 * 显示操作树节点的工具条
 * @param {Object} obj 当前行的DIV对象
 */
var service;
function showBar(obj){
	if( document.getElementById("bar_"+obj.id) ){
		document.getElementById("bar_"+obj.id).style.visibility="visible";
		//document.getElementById("editbar_"+obj.id).innerHTML="编辑";
	}else{
		/*
		var addbar = document.createElement("span");
		addbar.id="addbar_"+obj.id;
		
		var editbar = document.createElement("span");//未使用该功能,目前用他当空格
		editbar.id="editbar_"+obj.id;
		
		var deletebar = document.createElement("span");
		deletebar.id="deletebar_"+obj.id;
		
		var bar = document.createElement("span");
		bar.id="bar_"+obj.id;
		bar.appendChild(addbar);
		bar.appendChild(editbar);
		bar.appendChild(deletebar);
		obj.appendChild(bar);
		
		addbar.innerHTML="添加子菜单";
		addbar.title="添加子节点";
		addbar.style.paddingLeft="10%";
		//addbar.style.paddingRight="2%";
		addbar.style.cursor="pointer";
		addbar.onclick=addEvent;
		
		editbar.innerHTML="编辑该菜单";
		editbar.title="编辑该菜单";
		editbar.style.paddingLeft="1%";
		editbar.style.paddingRight="1%";
		editbar.style.cursor="pointer";
		editbar.onclick=editEvent;
		
		deletebar.innerHTML="删除该菜单";
		deletebar.title="删除该菜单";
		//deletebar.style.paddingLeft="2%";
		//deletebar.style.paddingRight="5%";
		deletebar.style.cursor="pointer";
		deletebar.onclick=deleteEvent;
		*/
	}
}
/**
 * 隐藏操作树节点的工具条
 * @param {Object} obj 当前行的DIV对象
 */
function hiddenBar(obj){
	if( document.getElementById("bar_"+obj.id) ){
		document.getElementById("bar_"+obj.id).style.visibility="hidden";
	}
}

/**
 * 当点击工具条上的添加时发生的操作
 * @param {Object} evt 事件
 */
function addEvent(evt){
	openWindow("");
	
	var newname = getSortnameByPrompt();
	if(newname==null){
		return false;
	}
	var e_out;
	evt ? e_out = evt.target : e_out = window.event.srcElement;
	if (e_out.tagName == "SPAN") {
		var id = e_out.getAttribute("id");
		var parent_qid = id.substring((id.lastIndexOf("_")+1),id.length);
		//alert(parent_qid);
	   	insertEntity(newname, parent_qid);
    	}
	function getSortnameByPrompt(){
	    var newsortname = window.prompt("请输入要添加的名称：","");
	    if( newsortname==null ){//用户取消
		return null;
	    }else if( jQuery.trim(newsortname) =="" ){//用户没有输入名称
	    	alert("没有输入名称");
		return getSortnameByPrompt();
	    }else{
	    	return newsortname;
	    }
	}
}

/**
 * 当点击工具条上的编辑时发生的操作
 * @param {Object} evt 事件
 */
function editEvent(evt){
	var newname = getSortnameByPrompt();
	if(newname==null){
		return false;
	}
	var e_out;
	evt ? e_out = evt.target : e_out = window.event.srcElement;
	if (e_out.tagName == "SPAN") {
		var id = e_out.getAttribute("id");
		var parent_qid = id.substring((id.lastIndexOf("_")+1),id.length);
		//alert(parent_qid);
	   	insertEntity(newname, parent_qid);
    	}
	function getSortnameByPrompt(){
	    var newsortname = window.prompt("请输入要添加的名称：","");
	    if( newsortname==null ){//用户取消
		return null;
	    }else if( jQuery.trim(newsortname) =="" ){//用户没有输入名称
	    	alert("没有输入名称");
		return getSortnameByPrompt();
	    }else{
	    	return newsortname;
	    }
	}
}
/**
 * @deprecated
 * @param {Object} evt
 * 
 */
function editEvent2(evt){
    var e_out;
	// "target" for Mozilla, Netscape, Firefox et al. ; "srcElement" for IE
    evt ? e_out = evt.target : e_out = window.event.srcElement;
    //alert(e_out.tagName);
    if (e_out.tagName == "SPAN") {
        var id = e_out.getAttribute("id");
	   document.getElementById(id).innerHTML="保存";
    }
	
}
function deleteEvent(evt){
    var e_out;
    evt ? e_out = evt.target : e_out = window.event.srcElement;
    if (e_out.tagName == "SPAN") {
        var id = e_out.getAttribute("id");
	   var node_qid = id.substring((id.lastIndexOf("_")+1),id.length);
	   var value = document.getElementById("label_"+node_qid).innerHTML;
	   var f = window.confirm("确定要删除\""+value+"\"及其下所有分类吗？");
	   if(f){
	   	if(node_qid=="000"){
			alert("无法删除根节点！");
			return ;
		}
		deleteEntity(node_qid);//service用来确定操作对象
	   }
    }
}
function cb(){
    	window.location.reload();
}
function insertEntity(newname, parent_qid){
	//iWebNewsSort.save(ws,cb);
	var nodeEntity ;
	if(service){
		if( typeof(service) == typeof(iWebNewsSort) ){
			nodeEntity = {sortname:newname,parentQueryid:parent_qid};
		}else if( typeof(service) == typeof(iAreatreeService) ){
			nodeEntity = {areaname:newname,parentQueryid:parent_qid};
		}else{
			return;
		}
		eval( service.save(nodeEntity,cb) );
	}
}
function deleteEntity(node_qid){
	eval( service.remove(node_qid,cb) );
}
function openWindow(uri){
	var params = "dialogWidth=780px;dialogHeight=600px";
	window.showModalDialog(uri,parent,params);
	//document.forms[0].submit();
	window.location.reload();
}