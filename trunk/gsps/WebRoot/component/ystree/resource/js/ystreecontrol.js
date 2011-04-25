//import other javascript - jquery framework
//$import("resource/js/ysframework.js");
$import("resource/css/treeview.css");
/******** 全局常量参数 *********/
var on_off_usedForEditTree = true;//是否编辑模式
var on_off_actionWhenClickText = true;//是否在点击文字时发生回应
var ystreecheckboxname = "ystreeCheckBoxName";
var valueContainerId = "nodeid";//存放checkbox值的input控件的ID,配合你页面中定义的input控件的id

$(document).ready(function(){
	if(on_off_actionWhenClickText==false){
		//此时是checkbox模式
		initMenuChecked();
	}
});

/**
 * 从第二层开始收起来
 * @param {Object} idNodeLength 层次长度。如000，000001......层次长度为3
 */
function displaySecondNode(idNodeLength){
	if(idNodeLength==null || idNodeLength<1){
		idNodeLength = 3;
	}
	$(document).ready(function(){
		$("div img").each(function(i){
			if(this.id){
				var cid = this.id;
				var menuid = cid.substring(cid.indexOf("_")+1);
				if(menuid.length/idNodeLength==2){//从第二层开始收起来
					this.click();
				}
			}
		});
	});
}
/**
 * 客户端可以重写覆盖此方法
 * @param {Object} obj 被点击的节点对象
 */
function clickingText(obj){
//当点击树节点文字时的动作。
	if(on_off_actionWhenClickText == true){
		$("label").each(function(i){
			this.style.color="";
		});
		obj.style.color="red";
		var queryid = obj.id.replace("label_","");
		window.parent.document.getElementById("menuContentFrame").src=getActionName()+"-input.c?wid="+queryid;
	}
}

function resetValue(obj){
	resetValueForContainer(obj, valueContainerId);
}

//当点击checkbox后，为表单元素重新付值 obj :checkbox , valueContainerId : 存放checkbox值的input控件的ID
function resetValueForContainer(obj, valueContainerId){
	selectAllSon(obj);
	var c = document.getElementsByName(ystreecheckboxname);
	var tmp = "";
	for(var i=0;i<c.length;i++){
		if(c[i].checked){
			tmp += c[i].value + ",";
		}
	}
	tmp = tmp.substring(0,tmp.length-1);
	if(document.getElementById( valueContainerId ))
		document.getElementById( valueContainerId ).value=tmp;
	else if( document.getElementsByName( valueContainerId )){
		document.getElementsByName( valueContainerId )[0].value = tmp;
	}
}

//初始化需要选中的菜单。权限菜单需求
function initMenuChecked(){
	var c = document.getElementsByName(ystreecheckboxname);
	var menues = window.parent.document.getElementById("menues").value;
	for(var i=0;i<c.length;i++){
		var menuid = c[i].id;
		if(menuid=="000"){
			c[i].checked = true;
		}else{
			if(checkContain(menuid ,menues)){
				c[i].checked = true;
			}else{
				c[i].checked = false;
			}
		}
	}
}

function checkContain(menuid ,menues){
	var mm = menues.split(",");
	for(var i=0;i<mm.length;i++){
		if(mm[i]==menuid){
			return true;
		}
	}
	return false;
}

function displayNode(obj){
//改变节点 展开/关闭 的状态
	
	var pex = new Array();
	pex[0]="expanded";//展开的
	pex[1]="collapsed";//关闭的
	var displaySwitch ;
	var path = obj.src;
	var img = path.substring( path.lastIndexOf("/")+1);
	if(img.indexOf( pex[0] )!=-1){//已展开的
		img = img.replace(pex[0],pex[1]);
		displaySwitch = "none";
	}else{//已关闭的
		img = img.replace(pex[1],pex[0]);
		displaySwitch = "block";
	}
	obj.src = path.substring(0, path.lastIndexOf("/")+1) + img;
	//显示/隐藏 子孙节点
	var imgid = obj.id;
	var parentdivid = imgid.replace("ystreeNodeImg_","ystreeDivPane_");
	document.getElementById( parentdivid ).style.display = displaySwitch ;
}

function colorChange(obj){
	if(on_off_usedForEditTree==true){
		showBar(obj);
	}
	obj.style.color="#ff0000";
}

function colorBack(obj){
	if(on_off_usedForEditTree==true){
		hiddenBar(obj);
	}
	obj.style.color="#000000";
}

/**
 * 控制是否要选中和被点节点相关的一些节点，比如子节点，父节点
 * @param {Object} obj
 */
function selectAllSon(obj){
	var checkedid = obj.id;
	var c = document.getElementsByName(ystreecheckboxname);
	for(var i=c.length-1;i>=0;i--){
		if(c[i].id == checkedid){
		//说明该节点和被点节点是同级
		
		}else if(c[i].id.indexOf(checkedid)==0){
		//说明该节点是被点节点的子孙节点
			c[i].checked = obj.checked;
		}else if(checkedid.indexOf( c[i].id )==0){
		//说明该节点是被点节点的祖先节点
		//alert(c[i].id);
		//以下注释掉。因为权限菜单需求中，父节点可以被单独选中
			/*
			if(isMySonAllSelected( c[i].id )){
				c[i].checked = true;
			}else{
				c[i].checked = false;
			}
			*/
			if(obj.checked){
				c[i].checked = true;
			}
		}
	}
	
}

function isMySonAllSelected(currID){
	var f = true;
	var c = document.getElementsByName(ystreecheckboxname);
	for(var i=0;i<c.length;i++){
		if( c[i].id!=currID && c[i].id.indexOf(currID)==0 ){
			if(c[i].checked == false){
				f = false;
				break;
			}
		}
	}
	return f;
}

//引入文件
function $import(file){
    var ext = file.substring(file.lastIndexOf(".") + 1).toLowerCase();
    if (ext == "js") {
        var fileElem = document.createElement('script');
        fileElem.setAttribute('src', file);
        fileElem.setAttribute('type', 'text/javascript');
        document.getElementsByTagName('head')[0].appendChild(fileElem);
    }
    else 
        if (ext == "css") {
	        var fileElem = document.createElement('link');
	        fileElem.setAttribute('href', file);
	        fileElem.setAttribute('rel', 'stylesheet');
	        fileElem.setAttribute('type', 'text/css');
	        document.getElementsByTagName('head')[0].appendChild(fileElem);
        }
}

// import with a random query parameter to avoid caching
function $importNoCache(src){
    var ms = new Date().getTime().toString();
    var seed = "?" + ms;
    $import(src + seed);
}

// future expand
function moveTreeDiv(){
	setInterval(mv,50);
}
function mv(){
	var sw = document.body.clientWidth;
	var ystreeDiv_000 = document.getElementById("ystreeDiv_000");
	Hoffset   =   ystreeDiv_000.style.height;
	Woffset   =   ystreeDiv_000.style.width;
	if(ystreeDiv_000.style.left < sw/2){
	  //alert(ystreeDiv_000.style.left);
		ystreeDiv_000.style.left += 10;  
		ystreeDiv_000.style.top += 10;
	}
}
