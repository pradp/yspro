var clientCache = "";
/**
 * 取服务器端消息
 */
function getP2pMessage(){
	$.get(
		"resources/p2p/keepConnect.jsp",
		function(data){
			if(clientCache==data){
				//alert(clientCache);
			}else{
				clientCache = data;
				$("#p2pMessage").html(data).css("color","red").css("display","none");
				if($.trim( $("#p2pMessage").text() )!==""){
					alert( $.trim( $("#p2pMessage").text() ) );
				}
			}
		}
	);
}
$(document).ready(function(){
	getP2pMessage();
	var time = 1000 * 60 * 3;//3分钟
	window.setInterval(getP2pMessage,time);
});
