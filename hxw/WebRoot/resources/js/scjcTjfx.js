function onchangeNd() {
	var rwnf = $("#rwnf").val();
	if (rwnf != '') {
		var url = basePath + "jsonVisitor/ajaxBiz-loadRw.action?"
				+ (new Date()).getTime();
		$.getJSON(url, {
			rwnf : rwnf
		}, function(data) {
			var rwmc = data.datamap.rwmc;
			changeSelectOption(rwmc, 'rwmc');
		});
	}
}

function onchangeXz() {
	var rwnf = $("#rwnf").val();
	var xz = $("#xz").val();
	if ($("#rwnf")[0] && (rwnf == null || rwnf == '')) {
		alert('年份不能为空！');
		return false;
	}else{
		if(rwnf == null){
			rwnf = '';
		}
	}
	var url = basePath + "jsonVisitor/ajaxBiz-loadRw.action?"
			+ (new Date()).getTime();
	$.getJSON(url, {
		rwnf : rwnf,
		xz : xz
	}, function(data) {
		var rwmc = data.datamap.rwmc;
		changeSelectOption(rwmc, 'rwmc');
	});
	
	if($("#bszq").attr("disabled") == ""){//任务变更时自动关闭周期范围等
		closeNextLabel('bszq');
		$("#tr_zqlx").hide();
		$("#tr_zqfw").hide();
		
		closeNextLabel('tjlx');
        changeCheckboxList('[]','jcx','tscjcDuty.jcx','','请先选择任务！','true');
        $("#chooseCityButton").attr("disabled","true");
        if(tjlx == null || tjlx == ''){
        	$("#chooseCityButton span").html('选择');
        }else{
        	if(tjlx == 1)
        		$("#chooseCityButton span").html('公司');
        	else if(tjlx ==2)
        		$("#chooseCityButton span").html('场');
        	else
        		$("#chooseCityButton span").html('区县');
        }
        $("input[name='tscjcDuty.jcx']").attr("disabled","true");
        $("#upname").val('');
        $("#departs").val('');
        
        if(type == '2'){
			closeNextLabel('jcx');
        }
	}
}

function onchangeRw(){
	var rwmc = $("#rwmc").val();
	if(rwmc!=''){
		var url = basePath + "jsonVisitor/ajaxBiz-loadRwJcx.action?"+(new Date()).getTime();
		$.getJSON(url, {rwmc: rwmc}, function(data){
			var bszq = data.datamap.bszq;
        	changeSelectOption(bszq,'bszq');
        	var jcx = data.datamap.jcx;
        	if(type == '2'){
        		changeSelectOption(jcx,'jcx');
				openNextLabel('rwmc','jcx')
        	}else{
        		changeCheckboxList(jcx,'jcx','tscjcDuty.jcx','','该任务无监测项！','true');
        	}
        			
        	$('#jcxms').val(jcx);
        	if($("#rwnf").length==0){
	        	var nf = data.datamap.rwnf;
	        	if(eval("("+nf+")").length ==1){
	        		$("#jcxl").val('0');
					if(type != null && type !=''){
						$("#jcnf_tr").hide();
					}
	        	}else{
	        		$("#jcxl").val('1');
	        	}
	        	$("#nfxx").val(nf);
	        	if(type!=null && type!=''){
					$("#jcnf_tr").show();
				    changeCheckboxList(nf,'jcnf','rwnf');
				    $("input[type='checkbox'][name='rwnf']").attr("checked","checked");
	        		if(eval("("+nf+")").length ==1){
				    	$("input[type='checkbox'][name='rwnf']").attr("disabled","true");
	        		}
				}
        	}else{
	        	var nf = data.datamap.rwnf;
	        	$("#nfxx").val(nf);
	        	$("#jcxl").val('0');
				if(type != null && type !=''){
					$("#jcnf_tr").hide();
				}
        	}
		});
	}
	if((tjlx!=null && tjlx!='') || tj == '2'){
		openNextLabel('rwmc','chooseCityButton');
		$("#upname").val('');
		$("#departs").val('');
	}else{
		$("#upname").val('');
		$("#departs").val('');
		$("#jcdw").hide();
	}
	if($("#zqlx").attr("disabled") == ""){//任务变更时自动关闭周期范围等
		$("#tr_zqlx").hide();
		$("#tr_zqfw").hide();
		closeNextLabel('tjlx');
		changeCheckboxList('[]','jcx','tscjcDuty.jcx','','请先选择任务！');
		if(tj=='2'){
			$("#chooseCityButton span").html('场');
		}else{
			$("#chooseCityButton").attr("disabled","true");
			$("#chooseCityButton span").html('选择');
		}
		$("input[name='tscjcDuty.jcx']").attr("disabled","true");
	}
}

function onchangeBszq() {
	var bszq = $("#bszq").val();
	var xxzq = "[{id:'',caption:'--请选择--'},";
	var len = 0;
	if (bszq == '1') {
		len = 12;
		$("#tr_zqfw").find("td:eq(0)").html('月份：');
	} else if (bszq == '2') {
		len = 4;
		$("#tr_zqfw").find("td:eq(0)").html('季度：');
	} else if (bszq == '3') {
		len = 2;
		$("#tr_zqfw").find("td:eq(0)").html('半年：');
	} else if (bszq == '4') {
		len = 1;
	}
	for ( var i = 0; i < len; i++) {
		if(bszq != '3'){
			xxzq += "{id:'" + (i + 1) + "',caption:'" + (i + 1) + "'}";
		}else{
			if(i==0){
				xxzq += "{id:'" + (i + 1) + "',caption:'上半年'}";
			}else{
				xxzq += "{id:'" + (i + 1) + "',caption:'下半年'}";
			}
		}
		if (i != len - 1) {
			xxzq += ",";
		}
	}
	xxzq += "]";
	showZqlx(xxzq);
	closeNextLabel('zqlx');
	openNextLabel('bszq','zqlx');
}
function showZqlx(xxzq){
	var bszq = $("#bszq").val();
	if(bszq!='' && bszq!='4'){
		$("#tr_zqlx").show();
		$("#tr_zqfw").show();
		$("span[id^='xxzq']").hide();
		var nfxx = $("#nfxx").val();
		$("#xxzq3").show();
		if(nd!=''){
			changeSelectOption(nfxx, 'rwnf0','',nd,60);
		}else{
			changeSelectOption(nfxx, 'rwnf0','','',60);
		}
		changeSelectOption(xxzq, 'xxzq0','','',60);
		$("#xxzq4").show();
		if(nd!=''){
			changeSelectOption(nfxx, 'rwnf1','',nd,60);
			changeSelectOption(nfxx, 'rwnf2','',nd,60);
		}else{
			changeSelectOption(nfxx, 'rwnf1','','',60);
			changeSelectOption(nfxx, 'rwnf2','','',60);
		}
		changeSelectOption(xxzq, 'xxzq_ks1','','',60);
		changeSelectOption(xxzq, 'xxzq_js2','','',60);
		$("#xxzq4").hide();
	}else{
		$("#tr_zqlx").hide();
		$("#tr_zqfw").hide();
	}
}
function onchangeZqlx() {
	var zqlx = $("#zqlx").val();
	var jcxl = $("#jcxl").val(); //继承系列的任务,1为是 0为否
	if (zqlx == '' || zqlx == '1') {
		$("#xxzq3").show();
		$("#xxzq4").hide();
		openNextLabel('zqlx','rwnf0');
		openNextLabel('zqlx','xxzq0');
	} else if (zqlx == '2') {
		$("#xxzq3").hide();
		$("#xxzq4").show();
		openNextLabel('zqlx','rwnf1');
		openNextLabel('zqlx','rwnf2');
		openNextLabel('zqlx','xxzq_ks1');
		openNextLabel('zqlx','xxzq_js2');
	}
}
function dataCheck(){
	if(isValidateForm()){
		var bszq = $("#bszq").val();
		$("#bszq option").each(function(){
			if($(this).val() == bszq){
				$("#tbsj").val($(this).html());
			}
		})
		var zqlx = $("#zqlx").val();
		var jcxl = $("#jcxl").val();
		if($("#tr_zqlx")[0] && $("#tr_zqlx").css("display") != "none"){
			if(zqlx == null || zqlx == ''){
				alert('周期类型不能为空！');
				return false;
			}
			if(zqlx=='1'){
				var rwnf = $("#rwnf0").val();
				var xxzq = $("#xxzq0").val();
				if(rwnf==null || rwnf==''){
					alert("年份不能为空！");
					return false;
				}
				if(xxzq==null || xxzq==''){
					alert($("#xxzq").parent().parent().prev("td").html().replace("：","") +"不能为空！");
					return false;
				}
				$("#xxzq_id").val(xxzq);
				$("#rwnf_").val(rwnf);
			}else if(zqlx=='2'){
				var rwnf1 = $("#rwnf1").val();
				var rwnf2 = $("#rwnf2").val();
				var xxzq1 = $("#xxzq_ks1").val();
				var xxzq2 = $("#xxzq_js2").val();
				var zq = $("#xxzq").parent().parent().prev("td").html().replace("：","");
				if(rwnf1=='' || rwnf2=='' || xxzq1 =='' || xxzq2==''){
					alert(zq +"范围必须完整！");
					return false;
				}
				var nf1_ = parseInt($("#rwnf1 option[value='"+rwnf1+"']").html());
				var nf2_ = parseInt($("#rwnf2 option[value='"+rwnf2+"']").html());
				if(nf1_>nf2_|| (nf1_==nf2_ && parseInt(xxzq1)>parseInt(xxzq2))){
					alert('起始'+zq+'不能大于结束'+zq+'！');
					return false;
				}
				$("#xxzq_id").val(xxzq1+"-"+xxzq2);
				if(rwnf1 == rwnf2){
					$("#rwnf_").val(rwnf1);
				}else{
					$("#rwnf_").val(rwnf1+"-"+rwnf2);
				}
			}
		}
		if(type!=null && type!='' && $("#jcxl").val()=='1'){
			var rwnf_ = CropCheckBoxValueAsString("rwnf");
			if(rwnf_.length == 0){
				alert('年份不能为空！');
				return false;
			}else{
				$("#rwnf_").val(rwnf_);
			}
		}
		var departs = $("#departs").val();
		if(tjlx == null || tjlx == ''){
			tjlx = $("#tjlx").val();
		}
		var tjyj_depart = '监测单位';
		if(tjlx == '3'){
			tjyj_depart = '区县';
		}else if(tjlx == '2'){
			tjyj_depart = '场';
		}else if(tjlx == '1'){
			tjyj_depart = '公司';
		}
		if(departs == '110' || departs.indexOf('110,')==0){
			alert('不能只选择总站！');
			$("#departs").val('');
			$("#upname").val('');
			return false;
		}
		if(departs==null || departs==''){
			alert(tjyj_depart+'不能为空！');
			return false;
		}
				
		var jcx = '';
		if(document.getElementsByName("tscjcDuty.jcx").length==0){
			alert('该任务无监测项！');
			return false;
		}else{ 
			if(type == '2'){
				jcx = $("#jcx").val();
			}else{
				jcx = CropCheckBoxValueAsString("tscjcDuty.jcx");
			}
			if(jcx==''){
				alert('监测项不能为空！');
				return false;
			}
			var data = $("#jcxms").val();
			var jcxm = '';
			var jsonarray = eval("("+data+")");
			for(var i=0;i<jsonarray.length;i++){
				var obj = jsonarray[i];
				if((jcx+",").indexOf(obj.id)!=-1){
					jcxm += obj.id + "_" + obj.caption + ",";
				}
			}
			$("#jcxm").val(jcxm.substr(0,jcxm.length-1));
		}
		if($("#tjlx").val()==null || $("#tjlx").val()==''){
			$("#tjlx").val('2');
		}
		document.forms[0].submit();
	}
}
function selectArea(valueObjid, nameObjid) {
	tem_valueObjid = valueObjid;
	tem_nameObjid = nameObjid;
	var tj = tjlx;
	if (tj == null || tj == '') {
		tj = $("#tjlx").val();
	}
	var duty = $("#rwmc").val();
	var jcxl = $("#jcxl").val();
	var url = '';
	if (tjlx == null || tjlx == '' || type == '2') {
		if (tj == '3') {
			url = "../system/area-areaTree.action?showCheckBox=true&dutyid="
					+ duty + "&jcxl=" + jcxl;
		} else if (tj == '1') {
			url = '../system/depart-departTree.action?showCheckBox=true&state=1&type=0&onlyCompany=1&dutyid='
					+ duty + "&jcxl=" + jcxl;
		} else {
			url = '../system/depart-departTree.action?showCheckBox=true&state=1&type=0&dutyid='
					+ duty + "&jcxl=" + jcxl;
		}
	} else {
		if (tj == '3') {
			url = "../system/area-areaTree.action?dutyid=" + duty + "&jcxl="
					+ jcxl;
		} else if (tj == '1') {
			url = '../system/depart-departTree.action?state=1&onlyCompany=1&type=0&dutyid='
					+ duty + "&jcxl=" + jcxl;
		} else {
			url = '../system/depart-departTree.action?state=1&type=0&dutyid='
					+ duty + "&jcxl=" + jcxl;
		}
	}
	openTreeDialog(url);
}
function changeButtonValue(id) {
	var tjlx_ = $("#tjlx").val();
	if (tjlx_ == 3) {
		$("#" + id + " span").html("选择区县");
	} else if (tjlx_ == 1) {
		$("#" + id + " span").html("选择公司");
	} else if (tjlx_ == 2) {
		$("#" + id + " span").html("选择场");
	} else {
		$("#" + id + " span").html("选择");
		$("#" + id).attr("disabled", "true");
	}
	//清空监测区域
	$("#upname").val('');
	$("#departs").val('');
	$("#jcdw").hide();
}
function onchangeDepart() {
	if ((tjlx == '' || tjlx == null) && tj != '2') {
		if ($("#departs").val() != null && $("#departs").val() != '')
			setTimeout("onchangeDepartname()", 100);
	}
}
function onchangeDepartname() {
	$("#jcdw").show();
	var tjlx = $("#tjlx").val();
	if (tjlx == 3) {
		$("#jcdw td:eq(0)").html("监测区县：");
	} else if (tjlx == 1) {
		$("#jcdw td:eq(0)").html("监测公司：");
	} else if (tjlx == 2) {
		$("#jcdw td:eq(0)").html("监测场：");
	}
	var str = $("#upname").val();
	str = str.replace(/(,)/g, "\n");
	$("#upname").val(str);
}
/**
 * 开启级联标签
 * @param {Object} thisObjId
 * @param {Object} labelId 标签id
 */
function openNextLabel(thisObjId,labelId){
	var value = $("#"+thisObjId).val();
	if(value != null && value != ''){
		$("#"+labelId).attr("disabled","");
		$("#"+labelId).prev().find("input[class*='inputDisabled']").removeAttr("disabled");
		$("#"+labelId).prev().find("input[class*='inputDisabled']").removeClass("inputDisabled");
		$("#"+labelId).prev().find("input[class*='selBtn_disabled']").removeAttr("disabled");
		$("#"+labelId).prev().find("input[class*='selBtn_disabled']").removeClass("selBtn_disabled");
	}
}
/**
 * 关闭标签
 * @param {Object} labelId 标签id
 */
function closeNextLabel(labelId){
	$("#"+labelId).val('');
	$("#"+labelId).attr("disabled","disabled");
	$("#"+labelId).prev().find("input[type='text']").attr("disabled","disabled");
	$("#"+labelId).prev().find("input[type='text']").addClass("inputDisabled");
	$("#"+labelId).prev().find("input[type='button']").attr("disabled","disabled");
	$("#"+labelId).prev().find("input[type='button']").addClass("selBtn_disabled");
	$("#"+labelId).prev().find("input[type='text']").val("--请选择--");
}