// JavaScript Document
function showPageTool(){
var allheight=document.body.scrollHeight;
var seeheight=document.body.clientHeight;
var showTopPageTool = document.getElementById("showTopPageTool");
//document.write(allheight);
//document.write("<br>");
//document.write(seeheight);
//document.write("<br>");
//document.write(allheight-seeheight);
	if(seeheight>=590){
		if((allheight-seeheight)>60){
			showTopPageTool.style.display="block";
		}
	}
	else{
		if((allheight-seeheight)>110){
			showTopPageTool.style.display="block";
		}
	}
}
showPageTool();