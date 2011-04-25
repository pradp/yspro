//加载CSS样式
document.writeln('<link href="/resources/css/waitshow.css" rel="stylesheet" type="text/css">');

//生成显示文字及样式
function getWaitBody(){
	var s="<div id=\"Layer1\" style=\"position:absolute; width:335px; height:39px; z-index:1; border: 1px none #000000;\">"; 
	s+="<center><marquee style=\"border:  1px solid ButtonShadow;\" direction=\"right\" scrollamount=\"8\" scrolldelay=\"100\">";
	s+="<span class=\"progressBarHandle-0\"></span>";
	s+="<span class=\"progressBarHandle-1\"></span>";
	s+="<span class=\"progressBarHandle-2\"></span>";
	s+="<span class=\"progressBarHandle-3\"></span>";
	s+="<span class=\"progressBarHandle-4\"></span>";
	s+="<span class=\"progressBarHandle-5\"></span>";
	s+="<span class=\"progressBarHandle-6\"></span>";
	s+="<span class=\"progressBarHandle-7\"></span>";
	s+="<span class=\"progressBarHandle-8\"></span>";
	s+="<span class=\"progressBarHandle-9\"></span>";
	s+="</marquee></center><br>";
	s+="<center><label id=\"id2\">正在查询，请稍等 ......</label></center>";
	s+="</div>";
 	return s;
}

//显示等待界面
function createWait() {
    var newElem = document.createElement("div");
    newElem.id = "showWait";
    newElem.innerHTML = getWaitBody();
    newElem.style.position = "absolute";
    //newElem.style.width = "240px";
    //newElem.style.height = "40px";
    newElem.style.align = "center";
    //newElem.style.left = (document.body.clientWidth / 2 -150) + "px";
    newElem.style.left = (document.body.clientWidth / 2 ) + "px";
    //newElem.style.top = (document.body.scrollTop + document.body.clientHeight / 2 - newElem.clientHeight / 2 )+ 150 + "px";
    newElem.style.top = (document.body.scrollTop + document.body.clientHeight / 2  )+ 200 + "px";
    
    newElem.style.background = "";
    window.self.document.body.appendChild(newElem);
    
    autoThisHeight();//调整iframe高度
}

//删除等待界面
function removeShowWait() {
    document.body.removeChild(document.getElementById("showWait"));
}

//在子窗口里执行删除父窗口的等待界面
function removeWaitInChildPage(){
    var parentDoc=window.parent.document;
    if(parentDoc.getElementById("showWait")!=null)
    	parentDoc.body.removeChild(parentDoc.getElementById("showWait"));
}
function autoThisHeight(){
	try{
		if(parent.bodyright!=null){
			parent.bodyright.style.height=document.body.scrollHeight;
		}
	}catch(err){
	}
}