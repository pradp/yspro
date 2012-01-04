/**
 * 设计测试问卷
 * 
 * @author Linyang datetime 2011-12-27
 */

/**
 * 初始化方法
 */
$(function() {
	if($("#cleanTm").length>0){
		$("#hidden_subject").val($("#cleanTm").next("div").html());
		$("#hidden_xx").val(getHtml(($("#cleanTm").next("div").find("ul li:eq(0)"))[0]));
		$("#hidden_xxbj").val(getHtml(($("#cleanTm").next("div").find("table tr").has("td"))[0]));
		$("#cleanTm").next("div").hide();
		if($(".csTm:visible").length>0){
			changeTmIndex($(".csTm:visible")[0]);
		}
	}
})

/**
 * 获取对象本身的html代码
 * @param {Object} obj
 * @return {TypeName} 
 */
function getHtml(obj){
	$(obj).wrap("<div id='pare_div'></div>");
	var html_ = $("#pare_div").html();
	$(obj).unwrap();
	return html_;
}

/**
 * 获取题目div
 * @param {Object} obj
 * @return {TypeName} 
 */
function getTmDiv(obj){
	return $(obj).closest(".csTm");
}

/**
 * 新增题组
 */
function addTz() {
	var addTz = $(".addTz");
	var tzs = addTz.nextAll("div[class*='csTz']").length;
	addTz.parent().append(
			"<div class='csTz' id='tz_" + (tzs + 1) + "'>" + (tzs + 1)
					+ "</div>");
}

/**
 * 
 * 改变题目序号
 * @param {Object} obj 
 * @memberOf {TypeName} 
 */
function changeTmIndex(obj){
	var o = $(obj);
	if(!o.is(".csTm")){
		o = getTmDiv(obj);
	}
	o.parent().find(".csTm:visible").each(function(){
		var index_ = $(this).prevAll(".csTm:visible").length;
		$(this).find(".tmbh").html((index_+1)+"、");
		$(this).find(".hiddenContext input").each(function(){
			if($(this).attr("name")=='px'){
				$(this).val(index_);
			}
			if($(this).attr("name").indexOf(".")==-1)
				$(this).attr("name","listTcstm["+index_+"]."+$(this).attr("name"));
		})
	});
}

/**
 * 新增题目
 * @param {Object} obj
 * @param {Object} type
 */
function addTm(obj, type) {
	if (type == 0) {
		$(".whtm,.edit").hide();
		var addTz = $(".addTz");
		var tms = addTz.parent().find(".csTm:visible").length;
		addTz.parent().append($("#hidden_subject").val());
		changeTmIndex((addTz.parent().find(".csTm:last"))[0]);
		//addTz.parent().find(".csTm").last().find(".tmbh").html((tms+1)+"、");
	} else {
		var tms = getTmDiv(obj).prevAll(".cmTm").length;
		getTmDiv(obj).after(getTmDiv(obj).clone());
		
		changeTmIndex(obj);
		
		getTmDiv(obj).find(".whtm,.edit").hide();
	}
}

/**
 * 修改题目
 * @param {Object} obj 序号
 */
function edit(obj){
	$(".whtm:hidden").each(function(){
		$(this).prevAll(".edit").hide();
	})
	$(obj).find(".edit").show();
	if($(obj).find(".whtm:visible").length==0){
		$(obj).find(".edit_bj").each(function(){
			if($(this).html()=='完成'){
				$(this).html("编辑");
			}
		})
		//$(obj).css("border-color","#66aaff");
	}
}

/**
 * 隐藏编辑按钮
 * @param {Object} obj
 */
function closeEdit(obj){
	if($(obj).find(".whtm:visible").length==0){
		//$(obj).css("border-color","#ffffff");
	}
}

/**
 * 进入编辑模式
 * @param {Object} obj
 */
function editType(obj){
	getTmDiv(obj).siblings().find(".whtm,.edit").hide();
	getTmDiv(obj).find(".whtm").toggle();
	getTmDiv(obj).find(".edit_bj").each(function(){
		if($(this).html()=='编辑'){
			$(this).html("完成");
		}else{
			$(this).html("编辑");
		}
	})
}

/**
 * 删除本题 
 * @param {Object} obj
 */
function deleteTm(obj){
	getTmDiv(obj).hide();
	changeTmIndex(obj);
	getTmDiv(obj).remove();
}

/**
 * 移动本题
 * @param {Object} obj
 * @param {Object} type 1为上移 -1为下移 2为置顶 -2为置底
 */
function moveTm(obj,type){
	var index_ = getTmDiv(obj).prevAll(".csTm:visible").length;
	var all_ = getTmDiv(obj).parent().find(".csTm:visible").length-1;
	if(index_!=0){
		if(type==1){
			getTmDiv(obj).prev(".csTm:visible").before(getHtml(getTmDiv(obj)));
			getTmDiv(obj).hide();
			changeTmIndex(obj);
			getTmDiv(obj).remove();
		}else if(type==2){
			getTmDiv(obj).parent().find(".csTm:visible").first().before(getHtml(getTmDiv(obj)));
			getTmDiv(obj).hide();
			changeTmIndex(obj);
			getTmDiv(obj).remove();
		}
	}
	if(index_!=all_){
		if(type==3){
			getTmDiv(obj).next(".csTm:visible").after(getHtml(getTmDiv(obj)));
			getTmDiv(obj).hide();
			changeTmIndex(obj);
			getTmDiv(obj).remove();
		}else if(type==4){
			getTmDiv(obj).parent().find(".csTm:visible").last().after(getHtml(getTmDiv(obj)));
			getTmDiv(obj).hide();
			changeTmIndex(obj);
			getTmDiv(obj).remove();
		}
	}
}

/**
 * 维护标题
 * @param {Object} obj
 */
function changeTitle(obj){
	var val_ = $(obj).val();
	var html_label = getHtml(getTmDiv(obj).find(".tmbt label")[0]);
	getTmDiv(obj).find(".tmbt").html(val_+html_label);
}

/**
 * 批量增加选项
 * @param {Object} obj
 */
function addOption(obj){
	var val_ = $(obj).html();
	getTmDiv(obj).find("div[class*='tmxx'] ul").append("<li><input type='radio'>"+val_+"</li>");
}

/**
 * 修改状态 是否必填
 * @param {Object} obj
 */
function changeState(obj){
	if(obj.checked){
		getTmDiv(obj).find(".tmbt label").html("&nbsp;*");
	}else{
		getTmDiv(obj).find(".tmbt label").html("");
	}
}

/**
 * 修改提示
 * @param {Object} obj
 */
function changeTs(obj){
	var val_ = $(obj).val();
	if(val_!=''){
		if(getTmDiv(obj).find(".tsxx").length==0){
			getTmDiv(obj).find(".edit").before("<div style='color:blue' class='tsxx' align='left'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提示："+val_+"</div>");
		}else{
			getTmDiv(obj).find(".tsxx").html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提示："+val_);
		}
	}else{
		getTmDiv(obj).find(".tsxx").remove();
	}
}

//选项信息 start
/**
 * 增加选项
 * @param {Object} obj
 */
function addXx(obj){
	$(obj).closest("tr").after($("#hidden_xxbj").val());
	var index_ = $(obj).closest("tr").prevAll("tr").has("td").length;
	getTmDiv(obj).find("ul li:eq("+index_+")").after($("#hidden_xx").val());
	$(obj).closest("tr").next("tr").find("td:eq(0) input").each(function(){
		this.setAttribute('value','请修改选项！');
		$(this).val('请修改选项！');
		$(this).focus();
	});
}

/**
 * 删除选项
 * @param {Object} obj
 * @return {TypeName} 
 */
function deleteXx(obj){
	var index_ = $(obj).closest("tr").prevAll("tr").has("td").length;
	var all_ = getTmDiv(obj).find("table tr").has("td").length;
	if(all_>2){
		getTmDiv(obj).find("ul li:eq("+index_+")").remove();
		$(obj).closest("tr").remove();
	}else{
		alert("请保留两个以上的选项！");
		return false;
	}
}

/**
 * 移动选项
 * @param {Object} obj
 * @param {Object} type
 */
function moveXx(obj,type){
	var index_ = $(obj).closest("tr").prevAll("tr").has("td").length;
	var all_ = getTmDiv(obj).find("table tr").has("td").length-1;
	var obj_li = getTmDiv(obj).find("ul li:eq("+index_+")");
	if(index_!=0){
		if(type==1){
			$(obj).closest("tr").prev("tr").before(getHtml($(obj).closest("tr")));
			$(obj).closest("tr").remove();
			obj_li.prev("li").before(getHtml(obj_li));
			obj_li.remove();
		}else if(type==2){
			$(obj).closest("tr").parent().find("tr").has("td").first().before(getHtml($(obj).closest("tr")));
			$(obj).closest("tr").remove();
			obj_li.parent().find("li:eq(0)").before(getHtml(obj_li));
			obj_li.remove();
		}
	}
	if(index_!=all_){
		if(type==3){
			$(obj).closest("tr").next("tr").after(getHtml($(obj).closest("tr")));
			$(obj).closest("tr").remove();
			obj_li.next("li").after(getHtml(obj_li));
			obj_li.remove();
		}else if(type==4){
			$(obj).closest("tr").parent().find("tr").has("td").last().after(getHtml($(obj).closest("tr")));
			$(obj).closest("tr").remove();
			obj_li.parent().find("li").last().after(getHtml(obj_li));
			obj_li.remove();
		}
	}
}

/**
 * 修改选项信息
 * @param {Object} obj
 */
function changeXx(obj){
	var val_ = $(obj).val();
	if(val_.replace(/(^\s*)|(\s*$)/g, "") == ''){
		alert("选项不能为空！");
		$(obj).focus();
	}
	var index_ = $(obj).closest("tr").prevAll().length;
	var success = true;
	$(obj).closest("table").find("tr:not(:eq("+index_+"))").has("td").each(function(){
		var obj_ = $(this).find("td:eq(0) input");
		if(obj_!=$(obj) && val_==obj_.val()){
			alert('选项不能重复');
			getTmDiv(obj).find("ul li:eq("+(index_-1)+")").each(function(){
				var clone_ = $(this).clone();
				clone_.find("input").remove();
				clone_.find("label").remove();
				$(obj).val(clone_.html().replace(/(^\s*)|(\s*$)/g, ""));
			});
			success = false;
			return false;
		}
	})
	if(success){
		getTmDiv(obj).find("ul li:eq("+(index_-1)+")").each(function(){
			var html_input = getHtml($(this).find("input")[0]);
			var html_xxsm = getHtml($(this).find(".xxsm")[0]);
			var html_xxdf = getHtml($(this).find(".xxdf")[0]);
			$(this).html(html_input + val_ + html_xxsm + html_xxdf);
		});
		obj.setAttribute('value',val_);
	}else{
		$(obj).focus();
	}
}

/**
 * 修改选项说明信息
 * @param {Object} obj
 */
function changeXxTitle(obj){
	var val_ = $(obj).val();
	var index_ = $(obj).closest("tr").prevAll().length;
	getTmDiv(obj).find("ul li:eq("+(index_-1)+") .xxsm").html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（"+val_+"）");
}

/**
 * 修改选项得分信息
 * @param {Object} obj
 */
function changeScore(obj){
	var val_ = $(obj).val();
	var index_ = $(obj).closest("tr").prevAll().length;
	getTmDiv(obj).find("ul li:eq("+(index_-1)+") .xxdf").html("&nbsp;&nbsp;&nbsp;得分："+val_+"' ");
	getTmDiv(obj).find("ul li:eq("+(index_-1)+") input").val(val_);
}

/**
 * 默认选中选项
 * @param {Object} obj
 */
function chooseThisAnswer(obj){
	var index_ = $(obj).closest("tr").prevAll().length;
	var xx_ = getTmDiv(obj).find("ul li:eq("+(index_-1)+") input");
	if(obj.checked){
		$(".cta_mr").each(function(){
			if(this!=obj && this.checked){
				this.checked = false;
			}
		})
		xx_.attr("checked","true");
		xx_.addClass("mrxz");
	}else{
		xx_.attr("checked","false");
		xx_.removeClass("mrxz");
	}
}

/**
 * 修改选项跳题
 */
function toOther(obj){
	
}

//选项信息 end


function doMySave(){
	$(".csTm:visible").each(function(){
		$(this).find(".hiddenContext input[name$='bjxx']").val(getHtml(this));
		$(this).find(".hiddenContext input[name$='xsxx']").val(function(){
			var value_ = "<div class='csTm' onmouseover='edit(this)' onmouseout='closeEdit(this)'>"; 
			getTmDiv(this).find(".tmh").each(function(){
				value_ += getHtml(this);
			})
			return value_+"</div>";
		});
	})
	if($(".csTm:visible").length==0){
		alert("请设置题目！");
		return false;
	}
	super_doSave();
}