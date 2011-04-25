function sendMessage(msgLy){
	var ids = CropCheckBoxValueAsString("selectNode");
	var uri ;
	if(ids.length>0){
		var wid = ids.split(",");
		var departid = "";
		for(var i=0;i<wid.length;i++){
			departid += document.getElementById("depart_"+wid[i]).value;
			if(i<wid.length-1){
				departid += ",";
			}
		}
		uri = "../system/message-input.c?tsysMessage.xxjsr="+departid+"&tsysMessage.xxly="+msgLy;
		openWindow(uri);
	}else{
		alert("请选择信息接收人或部门!");
	}
}

function sendMessageToDepart(){
	var uri = "../system/message-input.c?tsysMessage.xxly=097";//097用户交流
	openWindow(uri);
}

function readMsg(msgId, isChangeMsgState){
	var title = $('#msg_title'+msgId).html();
	if(title!=""){
		title = "<span style='font-size:11px;color:#000'>" + title + "</span>";
	}
	showInfo( $('#msg'+msgId).html(), title );
	if (isChangeMsgState) {
	  	changeMsgState(msgId);
	  }
}

function changeMsgState(msgId){

  	if($('#xxzt'+msgId).text().indexOf("未读")!=-1){
		ajaxService.changeMsgState(msgId, '1', changeBack);//前提是页面已引入DWR
		$('#xxzt'+msgId).text('已读');
	}
	function changeBack(){
		window.parent.frames["topFrame"].getMsgStat();
	}
}