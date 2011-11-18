jQuery(document).ready(function() {

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
				var currentPageNo = parseInt(jQuery("#pager_currentPageno").val())-1;
				if( currentPageNo<1 ){
					currentPageNo = 0;//控件第一页从0开始
				}
				var eachPageRows = parseInt(jQuery("#eachPageRows").val());
				//分页事件
				jQuery("#jpagination").css("padding","5px 0 5px 0").pagination(TotalNum, {
				    prev_text: "上一页",
				    next_text: "下一页",
				    num_edge_entries: 2,//最前、最后各显示几页
				    num_display_entries: 8,//显示多少页出来
				    current_page: currentPageNo,
				    items_per_page: eachPageRows,
				    //回调
				    callback: pageselectCallback
				});
				//下面插入“合89条记录”
				var TotalNumStr = " <span style='color:gray;font-size:12px'>合"+TotalNum+"条记录</span>";
				jQuery("#jpagination .pagination").append(TotalNumStr);
			}
		}

	    function pageselectCallback(page) {
	    	//调用原框架里的分页
	    	jQuery("#yspager_currentPageno").val(page+1);//加1是为了两个分页工具的索引 起始值一个是0，一个是1
	    	//jQuery("#pager_rollPageButton").click();
	    	//jQuery("form[name=ysform]").append("<input name='pager.currentPageno' value='"+(page+1)+"' type='hidden'/>");
	    	trunPage();
	    }
}
