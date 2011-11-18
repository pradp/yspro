/**
 * 网上答疑模块
 * @returns {Boolean}
 */
function doSubmitC() {
	/*用户姓名不能为空*/
	var wen = document.getElementById("wen").value;
	if (wen == "") {
		alert("姓名不能为空！");
		return false;
	}
	if (getLength(wen)>20) {
		alert("姓名字数过长！");
		return false;
	}
	var dian = document.getElementById("dian").value;
	if (getLength(dian)>200) {
		alert("联系方式字数过长！");
		return false;
	}
	/*畜种，专家类型*/
	var xz = document.getElementById("xz").value;
	if (xz == "") {
		alert("请选择专家类型！ ");
		return false;
	}
	var zhi = document.getElementById("zhi").value;
	if (zhi == "") {
		alert("请选择专家！ ");
		return false;
	}
	/*标题不能为空*/
	var ti = document.getElementById("ti").value;
	if (ti == "") {
		alert("标题不能为空 ");
		return false;
	}
	if (getLength(ti)>50) {
		alert("标题字数过长！");
		return false;
	}
	/*提问内容不能为空*/
	var question = document.getElementById("question").value;
	if (question == "") {
		alert("提问内容不能为空");
		return false;
	}
	var url = "answer/wsdyInsert.jhtm";
	$.post(url, {
		ti : encodeURIComponent(ti),
		wen : encodeURIComponent(wen),
		zhi : zhi,
		xz : xz,
		dian : encodeURIComponent(dian),
		question : encodeURIComponent(question)
	}, function(data) {
		if (data.indexOf('ok') != -1) {
			alert('提交成功！');
			$("#ti").val('');
			$("#wen").val('');
			$("#zhi").val('');
			$("#dian").val('');
			$("#question").val('');
		} else {
			alert("提交失败！");
		}
	});
}
