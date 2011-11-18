
jQuery(document).ready(function() {
	
	selectedMenu();
	
	$(".order a").each(function() {
		var html = $(this).html();
		if (html.length > 16) {
			html = html.substr(0, 16);
			var ht = html + "...";
			$(this).html(ht);
		} else {
			$(this).html(html);
		}
	});

	doPagination(); // 列表页面分页用

});

//默认指定导航
function selectedMenu(){ 
	var nameLabel = new Array("index.jsp","xlzx","xlcs","zhzx","xlxw","hdxz","xlwk","bbs"); 
    var locationUrl = location.href;//获得浏览器地址栏URL串 
    for(var i=0; i<nameLabel.length; i++){
    	var label_ = nameLabel[i];
    	if(locationUrl.indexOf(label_)!=-1){
    		$("#"+label_).css("background-color","#f5f5f5");
    		$("#"+label_).css("color","#FD9305");
    	}
    }
}

/**
 * 分页。
 * 使用jquery pagination插件，控制框架里的通用分页进行翻页
 */
function doPagination(toolRows){
		if(document.getElementById("pagelist")){//原来有分页条的页面，说明需要分页
			if(document.getElementById("jpagination")){

			}else{//jpagination不存在的时候才执行添加新分页样式
				jQuery("#pagelist").hide().after("<div id='jpagination'></div>");
				//TotalNum 总数
				var TotalNum = jQuery("#pageTotalRows").val();
				if(toolRows!=null){
					TotalNum = toolRows;
				}
				var num_entries = parseInt(TotalNum);
				var currentPageNo = parseInt(jQuery("#pager_currentPageno").val())-1;
				if( currentPageNo<1 ){
					currentPageNo = 0;//控件第一页从0开始
				}
				var eachPageRows = parseInt(jQuery("#eachPageRows").val());
				//分页事件
				jQuery("#jpagination").css("padding","5px 0 5px 0").pagination(num_entries, {
				    //回调
				    callback: pageselectCallback,
				    prev_text: "上一页",
				    next_text: "下一页",
				    num_edge_entries: 2,//最前、最后各显示几页
				    num_display_entries: 8,//显示多少页出来
				    current_page: currentPageNo,
				    items_per_page: eachPageRows
				});
				//下面插入“合89条记录”
				var TotalNumStr = " <span style='color:gray;font-size:12px'>合"+num_entries+"条记录</span>";
				jQuery("#jpagination .pagination").append(TotalNumStr);
			}
		}

	    function pageselectCallback(page_index, jq) {
	    	//调用原框架里的分页
	    	jQuery("#yspager_currentPageno").val(page_index+1);//加1是为了两个分页工具的索引 起始值一个是0，一个是1
	    	//jQuery("#pager_rollPageButton").click();
	    	//jQuery("form[name=ysform]").append("<input name='pager.currentPageno' value='"+(page+1)+"' type='hidden'/>");
	    	trunPage();
            return false;
	    }
}
/**
 * 按比例缩放图片
 * @param maxwidth 最大宽度
 */
function ResizeImages(imgid, maxwidth) {
	if(document.getElementById(imgid)){
		var myimg = document.getElementById(imgid);
		if (myimg.width > maxwidth) {
			myimg.height = myimg.height * (maxwidth / myimg.width);
			myimg.width = maxwidth;
		}
	}
}

/**
 * 支持Google Suggest功能的客户端方法
 * @param {Object} objid 输入框控件的ID
 * @param {Object} hideObjid 点击一个suggest后，存放该对象值的控件ID。如果空，则不传编码。
 * @param {Object} url 提供即时查询的URL，此URL返回的是json
 * @param (boolean) ys_notMustMatch 是否不强制从下拉中选择。默认必须从下拉选择
 */
function getSuggest(objid, hideObjid, url, ys_notMustMatch){	
	var ys_isMustMatch = true;
	if( ys_notMustMatch && ys_notMustMatch==true){
		ys_isMustMatch = false;
	}
	$("#"+objid).autocomplete(url, {
			minChars:1,
			max:20,
			multiple:false,
			mustMatch:ys_isMustMatch,
			matchContains:false,
			autoFill:false,//这个参数开启会有BUG
			scroll: true,
			scrollHeight:300,
			parse:function(data) {
				return $.map(eval(data), function(row) {
					return {
						data: row,
						value: row.value,
						result: row.name
					}
				});
			},
			formatItem: function(item, currentRowNum, maxRowNum) {
				//return currentRowNum + "/" + maxRowNum + ": " + item.name ;
				return item.name ;
			},
			formatResult: function(item) {
				//alert(item.name);
				return item.name;
			}
		})
	.result(function(e, item) {
		if(hideObjid && hideObjid!=""){
			$("#"+hideObjid).val( item.value );
		}
	});
	$("#"+objid).blur(function(){
		var NameStr = $("#"+objid).val();
		NameStr = $.trim(NameStr);
		if(NameStr=="" && hideObjid){
			$("#"+hideObjid).val("");//如果没有对应记录，同时清除对应的编号数据
		}
	});
}

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
