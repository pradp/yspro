// JavaScript Document
$(function(){
	$("#search_input").click(function(){
		$("#topselect").hide();		
	});
		   
	$("#set_li").mouseover(function(){
		$("#option").show();		
	});
	$("#set_li").mouseout(function(){
		$("#option").hide();
	});
});

	
/*顶部搜索下拉框*/
function showSelect(){
	if($("#topselect").css("display")=="none"){
    	$("#topselect").show();
    }else{
    	$("#topselect").hide();    
    }
	
	var value = $("#search_input").val();
	$("#select li").each(function(){
	   	$(this).remove();				 
	});
	if(value == "搜咨询师") {
		$("#select").append("<li onclick='choosed(\"搜文章\")'>搜文章</li>")
		.append("<li onclick='choosed(\"搜帖子\")'>搜帖子</li>")
		.append("<li onclick='choosed(\"搜测试\")'>搜测试</li>");
	} else if(value == "搜测试"){
		$("#select").append("<li onclick='choosed(\"搜文章\")'>搜文章</li>")
		.append("<li onclick='choosed(\"搜帖子\")'>搜帖子</li>")
		.append("<li onclick='choosed(\"搜咨询师\")'>搜咨询师</li>");
	} else if(value == "搜文章"){
		$("#select").append("<li onclick='choosed(\"搜测试\")'>搜测试</li>")
		.append("<li onclick='choosed(\"搜帖子\")'>搜帖子</li>")
		.append("<li onclick='choosed(\"搜咨询师\")'>搜咨询师</li>");
	} else if(value == "搜帖子"){
		$("#select").append("<li onclick='choosed(\"搜测试\")'>搜测试</li>")
		.append("<li onclick='choosed(\"搜文章\")'>搜文章</li>")
		.append("<li onclick='choosed(\"搜咨询师\")'>搜咨询师</li>");
	}	
}
 
function choosed(obj){
	$("#search_input").val(obj);
	$("#topselect").hide();
} 
 
function changeTab(tag,tabNum,className){ 
	for(i=1; i <tabNum; i++){
		  if (i==tag){ 
			  $("#tag"+i).addClass(className);
		  } else {
			  $("#tag"+i).removeClass();
		  }
	 }
}
 function tabCharts(obj,div_id){
	      var ul_a = $(obj).parent('ul').find('a');
		  
	      $(ul_a).each(function(){
		     $(this).removeClass('choose_a');
		  });
		  $(obj).children('a').addClass('choose_a');
		  
		  $(".hot_div_content_ul").each(function(){
			  $(this).css('display','none');
		  });
		  $("#"+div_id).css('display','block');
	   }
	   
function changeUlColor(div,tag) {
    var line = $("."+div+tag);
	for ( var i = 1; i < line.length + 1; i++) {
		line[i - 1].className = (i % 2 > 0) ? "deep_color" : "whiteColor";
	}
	return;
}

/*搜索站内信问题*/
function showSelectQu(){
  if($("#topselectQu").css("display")=="none"){
  	$("#topselectQu").show();
  }else{
  	$("#topselectQu").hide();
  }
	var value = $("#search_input_qu").val();
	 $("#selectQu li").each(function(){
			   	$(this).remove();				 
			});
	 
			if(value == "按咨询问题"){
				$("#selectQu").append("<li onclick='choosedQuestion(\"按来访者\")'>按来访者</li><li onclick='choosedQuestion(\"按回复情况\")'>按回复情况</li><li onclick='choosedQuestion(\"按咨询评价\")'>按咨询评价</li>");
				}
			if(value == "按来访者"){
				$("#selectQu").append("<li onclick='choosedQuestion(\"按咨询问题\")'>按咨询问题</li><li onclick='choosedQuestion(\"按回复情况\")'>按回复情况</li><li onclick='choosedQuestion(\"按咨询评价\")'>按咨询评价</li>");
				}
			if(value == "按回复情况"){
				$("#selectQu").append("<li onclick='choosedQuestion(\"按咨询问题\")'>按咨询问题</li><li onclick='choosedQuestion(\"按来访者\")'>按来访者</li><li onclick='choosedQuestion(\"按咨询评价\")'>按咨询评价</li>");
				}
			if(value == "按咨询评价"){
				$("#selectQu").append("<li onclick='choosedQuestion(\"按咨询问题\")'>按咨询问题</li><li onclick='choosedQuestion(\"按回复情况\")'>按回复情况</li><li onclick='choosedQuestion(\"按来访者\")'>按来访者</li>");
				}
	$("#searchQuestionType").attr("value",value);
}

function choosedQuestion(obj){
	  $("#search_input_qu").val(obj);
	  $("#topselectQu").hide();
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
function closeBlock(){
	$.unblockUI();
}