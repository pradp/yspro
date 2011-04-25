<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>list</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<style type="text/css">
	body{background: #f1f1f1 repeat-x left top;}
	</style>
	<script type="text/javascript">
	listPageStyle();
	function dosave(isjtxm,obj){
		var fbzt = document.getElementById('fbzt').value;
		if(fbzt=='-1' || fbzt=='0' || fbzt=='' || fbzt=='0.5'){
		var i = 0;
		var cd = document.getElementsByTagName("input");
		var size = document.getElementById("listSportYdydf_size").value;
		for(var i=0; i<cd.length; i++){
			if(cd[i].type=="radio"){
				if(cd[i].checked){
					i++;
				}
			}
		}
		if(size != '' && size != '0'){
			if(i<parseInt(size)){
				alert('请选择是否进入下一轮！');
			}else{
				if(isjtxm=='2'){
					var a = new Array();
					var c=0;
					$(":checkbox").each(function(i){
						if(this.id!='mainCheck'){
							var mc = "#"+$(this).val()+"_mc";
							var sfbj = "#"+$(this).val()+"_sfbj";
							if(document.getElementById($(this).val()+"_mc") && document.getElementById($(this).val()+"_sfbj")){
								if($(sfbj).val()=='1'){
									a[c]= $(mc).val();
									c++;
								}
							}
							
						}
					});
					a = s2m(a);
					for(var k=0;k<a.length;k++){
						var count =0;
						for(var m=0;m<a.length;m++){
							if(a[m]!='0' && parseInt(a[m])<parseInt(a[k])){
								count++;
							}
						}
						if((count==parseInt(a[k])-1) || a[k]=='0'){
						}else{
							var conf = window.confirm("名次顺序填写不完整，点击【确定】保存成绩，点击【取消】返回修改！");
							if(conf){
								obj.disabled=true;
								if(super_submitForm()){
										alert('保存成功！');
										parent.document.forms[0].submit();
								}
							}
							return false;
						}
					}
					if(a.length==0){
						var local = window.location+"";
						obj.disabled=true;
						var actionName = getActionName();;
						var actionMethod = "save";
						   // document.forms[0].action = actionName + "-"+actionMethod+".c?reqtime="+new Date().getTime();
						var url =actionName + "-"+actionMethod+".c?reqtime="+new Date().getTime();
						var postData = $("#theform").serializeArray();
						$.post(url, postData, function(data){
							alert('保存成功！');
							document.forms[0].action = local;
						       		document.forms[0].submit();
						});
					}else{
						obj.disabled=true;
						if(super_submitForm()){
								alert('保存成功！');
								parent.document.forms[0].submit();
						}
					}
				}else{
					obj.disabled=true;
					var local = window.location+"";
					obj.disabled=true;
					var actionName = getActionName();;
					var actionMethod = "save";
					   // document.forms[0].action = actionName + "-"+actionMethod+".c?reqtime="+new Date().getTime();
					var url =actionName + "-"+actionMethod+".c?reqtime="+new Date().getTime();
					var postData = $("#theform").serializeArray();
					$.post(url, postData, function(data){
						alert('保存成功！');
						document.forms[0].action = local;
					       		document.forms[0].submit();
					});
				}
				
			}
		}else{
			return false;
		}
		}else{
			alert('成绩已通过确认 或  处于待审核 状态 不可保存！');
			return false;
		}
		
	}

	//保存并更新人员
	function updateAndSavePeople(obj){
		var fbzt = document.getElementById('fbzt').value;
		if(fbzt=='-1' || fbzt=='0' || fbzt=='' || fbzt=='0.5'){
		var i = 0;
		var cd = document.getElementsByTagName("input");
		var size = document.getElementById("listSportYdydf_size").value;
		for(var i=0; i<cd.length; i++){
			if(cd[i].type=="radio"){
				if(cd[i].checked){
					i++;
				}
			}
		}
		if(size != '' && size != '0'){
			if(i<parseInt(size)){
				alert('请选择是否进入下一轮！');
			}else{
				obj.disabled=true;
				$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
				if(super_submitForm()){
						var departids = document.getElementsByName("departids");
						var scbm = document.getElementById("scbm").value;
						var xmbm = document.getElementById("xmbm").value;
						var array = new Array();
						for(i=0;i<departids.length;i++){
							array[array.length] = departids[i].value;
						}
						ajaxService.resetCjYdy(xmbm,array,scbm,function (data){
							if(data=='ok'){
								alert('更新、保存成功！');
								//parent.document.forms[0].submit();
							}else{
								alert('更新0人，因为当前赛程下未登记参赛人员！');
							}
							window.location.href=window.location;
						});
						
				 }
			}
		}else{
			return false;
		}
		}else{
			alert('成绩已通过确认 或  处于待审核 状态 不可保存！');
			return false;
		}
		
	}
	function document.onkeydown(){ 
		var e = window.event; 
		if(e.keyCode==13 && e.srcElement.type != 'button'){ 
		e.keyCode = 9; 
		return; 
		} 
	} 

	
	//通过
	function auditScoreShtg(obj){
		
		var conf = window.confirm("您确定将你选择的信息审批通过?");
		if(conf==true){
			var fbzt = document.getElementById("fbzt").value;
			if(fbzt=='1'|| fbzt=='-2' || fbzt=='-1'){
			var a = document.getElementsByName("selectNode");
			var scbm = document.getElementById("scbm").value;
			var isjtxm = document.getElementById("isjtxm").value;
			//两层数据标识
			var tt = []; 
			for(var i=0; i<a.length; i++){
					if(a[i].checked){
					var shzt_nameVal =document.getElementById("shzt_id"+i).value; 
					if(shzt_nameVal == "2"){
						tt[tt.length]= a[i].value; 
					}else{
						alert("必须为'待审核'的数据才能进行审核！");
						
						return false;
					}
				}
			}
		if(tt.length==0){
			alert('请勾选一条数据！');
			return false;
		}else{
			ajaxService.auditScore('1',tt,scbm,isjtxm,function (data){
				alert(data);
				var scbm = document.getElementById("scbm").value;
				var sc = document.getElementById("sc").value;
				var type = document.getElementById("type_id").value;
				 window.location.href="../business/sportCjYdy-input.c?scbm="+scbm+"&sc="+sc+"&type="+type+"&wid=";
				return false;
			});
			obj.disabled=true;
			$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
		}
		}else{
			alert("赛程状态 必须为\“成绩修订\” 或 \“退回审核\” 的数据才能通过！");
			return false;
		}
	  }
	}

	//退回（取消审批）
	function auditScoreShth(obj){
		var conf = window.confirm("您确定将你选择的记录退回到成绩修订中？");
		if(conf==true){
			var fbzt = document.getElementById("fbzt").value;
			if(fbzt=='1'|| fbzt=='-2' || fbzt=='-1'){
			var a = document.getElementsByName("selectNode");
			var scbm = document.getElementById("scbm").value;
			var isjtxm = document.getElementById("isjtxm").value;
			//两层数据标识
			var tt = []; 
			for(var i=0; i<a.length; i++){
				if(a[i].checked){
				var shzt_nameVal =document.getElementById("shzt_id"+i).value; 
				if(shzt_nameVal == "1" || shzt_nameVal == "2" ){
					tt[tt.length]= a[i].value; 
				}else{
					alert("必须为\“待审核\” 或 \“确认成绩\”  的数据才能退回！");
					return false;
				}
			}
		}
		if(tt.length==0){
			alert('请勾选一条数据！');
			return false;
		}else{
			var ids = CropCheckBoxValueAsString("selectNode");
			//var conf = window.confirm("您确定将你选择的记录退回到成绩修订中？");
			//if(conf){
				var scbm = document.getElementById("scbm").value;
				var isjtxm = document.getElementById("isjtxm").value;
				var uri ="sportCjYdy-shyj.c?wid="+ids+"&shzt=-1"+"&scbm="+scbm+"&isjtxm="+isjtxm;
				openWindow(uri,700,250);
				return false;
			//}
			//if(conf){
				obj.disabled=true;
				$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
				ajaxService.auditScore('-1',tt,scbm,isjtxm,function (data){
					alert(data);
					parent.document.forms[0].submit();
					return false;
				});
			//}
		}
	}else{
		alert("赛程状态 必须为\“成绩修订\” 或\ “退回审核\” 的数据才能退回！");
		return false;
	}}
	}
	//强制退回（退回会删除此赛程录入的人员数据）
	function shth_del(){
		var conf = window.confirm("您确定将你选择的记录强制退回？（强制退回会删除此赛程下所有录入人员数据！）");
		if(conf==true){
			var scbm = document.getElementById("scbm").value;
			if(scbm!=null && scbm!=''){
				ajaxService.shth_del(scbm,function (data){
					alert(data);
					parent.document.forms[0].submit();
					return false;
				});
			}else{
				alert('退回失败！');
				return false;
			}
			
		}
	}
	
	//改变破纪录输入框的状态
	function changeYjlcl(id,obj,hiddenId){
		var yjlcl = document.getElementById(id);
		if(obj.value != '0'){
			yjlcl.disabled=false
			
		}else{
			yjlcl.disabled=true;
		}
			
	}
	function xz(type){
		var fbzt = document.getElementById('fbzt').value;
		if(fbzt=='-1' || fbzt=='0' || fbzt=='' || fbzt=='0.5'){
		if(validateShzt()){
			openWindow('../business/sportCjYdy-xzcsz.c?type='+type+"&scbm="+document.getElementById('scbm').value+"&departid="+document.getElementById("departid").value+"&xmbm="+document.getElementById('xmbm').value, 800, 300);
		}else{
			alert('成绩已通过确认 或  处于待审核 状态 不可新增！');
			return false;
		}
		}else{
			alert('成绩已通过确认 或  处于待审核 状态 不可新增！');
			return false;
		}
		
	}
	function xz2(type){
		var fbzt = document.getElementById('fbzt').value;
		if(fbzt=='-1' || fbzt=='0' || fbzt=='' || fbzt=='0.5'){
		if(validateShzt()){
			openWindow('../business/sportCjYdy-xzcsz.c?type='+type+"&scbm="+document.getElementById('scbm').value+"&departid="+document.getElementById("departid").value+"&isjtdj="+document.getElementById("isjtdj").value+"&xmbm="+document.getElementById('xmbm').value+"&jtwid="+document.getElementById('jtwid').value, 800, 300);
		}else{
			alert('成绩已通过确认 或  处于待审核 状态 不可新增！');
			return false;
		}}else{
			alert('成绩已通过确认 或  处于待审核 状态 不可新增！');
			return false;
		}
		
	}

	function  validateShzt(){
		var objs =  document.getElementsByTagName("input")
		var j = 0;
		for(i=0;i<objs.length;i++){
			if(objs[i].type=='checkbox'){
				j++;
			}
		} 
		var m = 0;
		if(j-1>0){
			for(k=0;k<j-1;k++){
				if(document.getElementById("shzt_id"+k)){
					var val = document.getElementById("shzt_id"+k).value;
					if(val!=''){
						m = m+parseInt(val);
					}
				}else{
					m=-1;
				}
			}
		}else{
			m=-1;
			}
		if(m==j-1){
			return false;
		}else{
			return true;
		}
		
	}
	/**
	 * 删除选中的纪录。
	 * AJAX 请求传统页面方式实现
	 */
	function del(stat,obj){
		var conf = window.confirm("您确定要删除已选中的这些数据吗？");
		if(conf==true){
			var ids = CropCheckBoxValueAsString("selectNode");
			var isjtxm = $("#isjtxm").val();
			var scbm = document.getElementById('scbm').value;
			//alert(isjtxm);
			if(ids.length>0){
				if(stat!=null && stat!=''){
					if(getSHZT()){
					obj.disabled=true;	
					$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
				var url_bak = document.forms[0].action;
				var url = actionName + "-remove."+uri_suffix;
				$.post(url,
				       { wid: ids, types: isjtxm, scbm: scbm , reqtime: (new Date()).getTime() },
				       function(data){
						document.forms[0].action = url_bak;//还原URL，防止点查询按钮却执行删除！
						if(data.indexOf("删除成功")!=-1){
							$("input[@name=selectNode]").each(function(i){
								if(ids.indexOf(this.value)!=-1){
									$(this).parent().parent().remove();
								}
							});
							//alert("删除成功!");
						}else{
							//alert(data);
							alert($(data).find("span").text());
						}
						//document.forms[0].submit();
				       }
				);
				parent.document.forms[0].submit();
				}else{
					alert("只能删除\“草稿\” 和  \“成绩退回\” 的数据！");

				}
			}else{
				var url_bak = document.forms[0].action;
				var url = actionName + "-remove."+uri_suffix;
				$.post(url,
				       { wid: ids, types: isjtxm, reqtime: (new Date()).getTime() },
				       function(data){
						document.forms[0].action = url_bak;//还原URL，防止点查询按钮却执行删除！
						if(data.indexOf("删除成功")!=-1){
							$("input[@name=selectNode]").each(function(i){
								if(ids.indexOf(this.value)!=-1){
									$(this).parent().parent().remove();
								}
							});
							//alert("删除成功!");
						}else{
							//alert(data);
							alert($(data).find("span").text());
						}
						//document.forms[0].submit();
				       }
				);
			 }
			}else{
				alert("请选择要删除的数据!");
			}
		}
		}
	//判断审核状态
	function getSHZT(){
		var objs =  document.getElementsByTagName("input")
		var total = document.getElementById("sportCjYdy-input_selectAll");
		var j = 0;
		var a  = new Array();   
		for(i=0;i<objs.length;i++){
			if(objs[i].type == 'checkbox' && objs[i].checked && objs[i]!=total){
				a[a.length] = objs[i].value;
			}
		} 
		var m = 0;
		if(a.length>0){
			for(k=0;k<a.length;k++){
				if(document.getElementById("shzt"+a[k])){
					var val = document.getElementById("shzt"+a[k]).value;
					if(val!='0' && val!='-1' ){
						m = m+parseInt(val);
					}
				}
			}
		}
		if(m>0){
			return false;
		}else{
			return true;
		}
	}
	
	function fhdjtdcj(){
			//alert(document.getElementById("sc").value);
		uri = document.getElementById("url").value;
			//if(sta=='1'){
			//	uri = "../business/sportCjYdy-input.c?scbm="+document.getElementById("scbm").value+"&sc="+document.getElementById("sc").value+"&type="+document.getElementById("type_id").value+"&wid=&sccj=fb";
			//}else{
			//	uri = "../business/sportCjYdy-input.c?scbm="+document.getElementById("scbm").value+"&sc="+document.getElementById("sc").value+"&type="+document.getElementById("type_id").value+"&wid=";
			//}
		var i = uri.indexOf("business");
		uri = uri.substring(i,uri.length);
		uri = uri.replace(new RegExp("~","gm"),"&");
			location.href="../"+uri;
	}

	//提交到审核流程
	function auditGameProcessTjdxh(obj){
		var conf = window.confirm("您确定将数据提交审核吗？");
		if(conf==true){
			var fbzt = document.getElementById('fbzt').value;
			if(fbzt=='-1' || fbzt=='0.5'){
			var scbm = document.getElementById('scbm').value;
			var isjtxm = document.getElementById('isjtxm').value;
			var sc = document.getElementById('sc').value;
			var xmbm = document.getElementById('xmbm').value;
			ajaxService.auditGameProcess('1',scbm,'','',isjtxm,'',function (data){
				alert(data);
				parent.document.forms[0].submit();
			});
			obj.disabled=true;
			$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
		}else{
			alert("提交审核的成绩必须处于\“成绩修订中\” 或  \“草稿\”、\“登记状态\” ！");
			return false;
		}
			}
	}
	//审核状态验证（提交到审核流程用）
	function  validateShzt2(){
		var objs =  document.getElementsByTagName("input")
		var j = 0;
		for(i=0;i<objs.length;i++){
			if(objs[i].type=='checkbox'){
				j++;
			}
		} 
		var m = 0;
		if(j-1>0){
			for(k=0;k<j-1;k++){
				if(document.getElementById("shzt_id"+k)){
					var val = document.getElementById("shzt_id"+k).value;
					if(val!='0' && val!='-1' && val!='-2'){
						m = 1;
					}
				}
			}
		}else{
			alert('无数据操作！');
			return false;
		}
		if(m==1){
			alert(" 提交数据 必须 是  \“草稿\” 或  \“成绩退回\” 的 状态！");
			return false;
		}else{
			return true;
		}
		
	}
	
	//提交到发布流程
	function auditGameProcessTjfblc(obj){
		var fbzt = document.getElementById('fbzt').value;
		if(fbzt=='1' || fbzt=='-2'){
		if(validateShzt3()){
		var scbm = document.getElementById('scbm').value;
		var isjtxm = document.getElementById('isjtxm').value;
		var sc = document.getElementById('sc').value;
		var xmbm = document.getElementById('xmbm').value;
		ajaxService.auditGameProcess('2',scbm,xmbm,'',isjtxm,sc,function (data){
			alert(data);
			 parent.document.forms[0].submit();
		});
			obj.disabled=true;
			$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
		}
		}else{
			alert(" 提交发布 只针对\“成绩审核中\”、\“退回审核中\” 赛程数据操作！");
			return  false;
		}
	}
	//审核状态验证（提交到发布流程用）
	function  validateShzt3(){
		var objs =  document.getElementsByTagName("input")
		var j = 0;
		for(i=0;i<objs.length;i++){
			if(objs[i].type=='checkbox'){
				j++;
			}
		} 
		var m = 0;
		if(j-1>0){
			for(k=0;k<j-1;k++){
				if(document.getElementById("shzt_id"+k)){
					var val = document.getElementById("shzt_id"+k).value;
					if(val=='-1' || val=='2' || val=='0'){
						alert("提交数据中 存在 \“成绩退回\” 、\“待审核\”、\“草稿\” 的数据 不允许提交发布流程！");
					return false;
					}
				}
			}
		}else{
			alert('无数据操作！');
			return false;
		}
			return true;
	}

	//取消|| 恢复 成绩
	function auditScoreShthChangeCjZt (zt,obj){
		//取消
		if(zt=='qx'){
			var conf = window.confirm("您确定将你选择的取消成绩?");
			if(conf==true){
				
				var fbzt = document.getElementById("fbzt").value;
				if(fbzt=='1'|| fbzt=='-2' || fbzt=='-1'){
				var a = document.getElementsByName("selectNode");
				var scbm = document.getElementById("scbm").value;
				var isjtxm = document.getElementById("isjtxm").value;
				//两层数据标识
				var tt = []; 
				for(var i=0; i<a.length; i++){
					if(a[i].checked){
					var shzt_nameVal =document.getElementById("shzt_id"+i).value; 
					if(shzt_nameVal == "1" || shzt_nameVal == "2" || shzt_nameVal == "-1" ){
						tt[tt.length]= a[i].value; 
					}else{			
						alert(" 只能取消 '成绩退回'、'待审核'、'确认成绩' 的数据  ！");
						return false;
					}
				}
			}
			if(tt.length==0){
				alert('请勾选一条数据！');
				return false;
			}else{
				ajaxService.auditScore('-2',tt, scbm, isjtxm,function (data){
					alert(data);
					parent.document.forms[0].submit();
					return false;
				});
				obj.disabled=true;
				$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
			}
		}else{
			alert(" 赛程状态 必须为'成绩修订' 或 '退回审核' 的数据才能取消成绩！");
			return false;
		}}
		//恢复
	}else if(zt=='hf'){
		var conf = window.confirm("您确定将你选择的恢复成绩?");
		if(conf==true){
			
			var fbzt = document.getElementById("fbzt").value;
			if(fbzt=='1'|| fbzt=='-2'|| fbzt=='-1'){
			var a = document.getElementsByName("selectNode");
			var scbm = document.getElementById("scbm").value;
			var isjtxm = document.getElementById("isjtxm").value;
			//两层数据标识
			var tt = []; 
			for(var i=0; i<a.length; i++){
				if(a[i].checked){
				var shzt_nameVal =document.getElementById("shzt_id"+i).value; 
				if(shzt_nameVal == "-2" ){
					tt[tt.length]= a[i].value; 
				}else{
					alert("只能针对'取消成绩'的数据  进行成绩的 恢复！");
					return false;
				}
			}
		}
		if(tt.length==0){
			alert('请勾选一条数据！');
			return false;
		}else{
			ajaxService.auditScore('hfcj',tt, scbm, isjtxm,function (data){
				alert(data);
				var scbm = document.getElementById("scbm").value;
				var sc = document.getElementById("sc").value;
				var type = document.getElementById("type_id").value;
				 window.location.href="../business/sportCjYdy-input.c?scbm="+scbm+"&sc="+sc+"&type="+type+"&wid=";
				return false;
			});
			obj.disabled=true;
			$("#mes").html("<div style='border:1px #CCCCCC solid; padding: 5px 10px 5px 10px;'><img src='<s:property value="basePath"/>/resources/images/loading.gif' style='vertical-align:middle;' />&nbsp;&nbsp;&nbsp;&nbsp;请稍后，正在处理中......</div>");
		}
	}else{
		alert("赛程状态 必须为'成绩修订' 或 '退回审核' 的数据才能恢复成绩！");
		return false;
	}}
		
	}
 }
	 //赛程成绩预览
	function auditGameProcessSccjyl (){
		var fbzt = document.getElementById("fbzt").value;
		var scbm = document.getElementById("scbm").value;
		var sc = document.getElementById('sc').value;
			var xmbm = document.getElementById('xmbm').value;
			ajaxService.auditGameProcess('preview',scbm,xmbm,'','',sc,function (data){
				var uri	= "../business/sportSxMxYL-input.c?scbm="+scbm+"&wid=&fbzt="+fbzt;
				parent.openPage(uri);
			});
	}
	function openPage(uri){
		var importTempID = '<s:property value="#importTempID" />';
		parent.openPage(uri+importTempID,850,450);
	}

	function changeQXHF(){
		var fbzt = document.getElementById("fbzt").value;
		if(fbzt=='1' || fbzt=='-2'){
			var ids = CropCheckBoxValueAsString("selectNode");
		if(ids.length>0){
			var m = 0;
			var n = 0;
			var id = ids.split(',');
			for(j=0;j<id.length;j++){
				var val = document.getElementById("shzt"+id[j]).value;
				if(val=='-2'|| val=='0'){
					m++;
				}
				
				if(val=='-2'){
					n++;
				}
			}
			if(m>0){
				document.getElementById("qx").disabled=true;
			}else{
				document.getElementById("qx").disabled=false;
			}
			if(id.length>0 && n==id.length){
				document.getElementById("hf").disabled=false;
			}else{
				document.getElementById("hf").disabled=true;
			}
		}else{
			document.getElementById("qx").disabled=true;		
			document.getElementById("hf").disabled=true;		
		}
		}
	}
	//数组从小到大排序 small to max
	function s2m (temp) {
			for (var i = 0; i < temp.length; i++) {
				for (var j = i+1; j < temp.length; j++) {
					if (parseInt(temp[i]) > parseInt(temp[j])) {
						var x = temp[i];
						temp[i] = temp[j];
						temp[j] = x;
					}
				}
			}
			return temp;
	}
	//打印
	function print (temp) {
			var reportServer = '';
			var scbm = '';
			if(document.getElementById("reportServer")){
				reportServer = $("#reportServer").val();
			}
			if(document.getElementById("scbm")){
				scbm = $("#scbm").val();
			}
			var  url = reportServer+"?raq=/report_sports_cjgg.raq&scbm='"+scbm+"'";
			omvc = window.open(url, 'newwindow', 'height=600, width=800, top=50, left=200, toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
			omvc.focus();
	}

	
	</script>
  </head>
  
<body topmargin="0" leftmargin="0" onload="parent.setHeight(document.getElementById('listTable').clientHeight,document.getElementById('listTable').clientWidth)"> 


    <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform" id="theform">
    <s:hidden name="type" id="type_id" value="%{#type}" />
    <s:hidden name="model" id="model_id" value="%{#model}" />
    <s:hidden name="isjtdj" id="isjtdj" value="%{#isjtdj}" />
    <s:hidden name="sccj" id="sccj" value="%{#sccj}" />
    <s:hidden  value="%{#reportServer}" id="reportServer" />
    <s:if test="#sccj==null || #sccj==''" >
    <table id="buttonTable" border="0" cellspacing="3" cellpadding="0"  align="left">
    		<tr>
    			<td height="30px" colspan="10">
    			 <s:if test="#type=='sp'.toString() && #model!='look'" >
    			 	<s:if test="#jtscbm!=null && #jtscbm!=''">
					 	<ul class="btn_gn">
		    					<li><a href="#" title="返回登记团队成绩" onclick="fhdjtdcj()"><span>返回登记团队成绩</span></a></li>
		    					<li><a href="#" title="保存" onclick="dosave('1',this)"><span>保存</span></a></li>
		    					<li><a href="#" title="新增" onclick="xz2('0')"><span>新增</span></a></li>
		    					<li><a href="#" title="删除" onClick="del()" name="removeRows"><span>删除</span></a></li>
		    			 </ul>
					 </s:if>
					 <s:elseif test="#sccj!='fb'">
					 	<ul class="btn_gn">
					 	<s:if test="#fbzt==1||#fbzt==-2" >
					 	<li><a href="#" title="通过" <s:if test="#isdisabledTg=='true'">disabled="true"</s:if> onclick="auditScoreShtg(this)"><span>通过</span></a></li>
		    				<li><a href="#" title="退回" onclick="auditScoreShth(this)"><span>退回</span></a></li>
		    				<li><a href="#" title="取消成绩" onclick="auditScoreShthChangeCjZt('qx',this)" id="qx" ><span>取消成绩</span></a></li>
		    				<li><a href="#" title="恢复成绩" onclick="auditScoreShthChangeCjZt('hf',this)" id="hf"><span>恢复成绩</span></a></li>
		    				<li><a href="#" title="提交到发布流程" onclick="auditGameProcessTjfblc(this)" ><span>提交到发布流程</span></a></li>
		    				<li><a href="#" title="预览赛次成绩" onclick="auditGameProcessSccjyl()" <s:if test="#isdisabled=='true' || #sc!=2">disabled="true"</s:if> ><span>预览赛次成绩</span></a></li>
					 	</s:if>
					 	<s:else>
					 		<li><a href="#" title="退回" onclick="auditScoreShth()" disabled="true"><span>退回</span></a></li>
		    				<li><a href="#" title="取消成绩" onclick="auditScoreShthChangeCjZt('qx')" id="qx" disabled="true"><span>取消成绩</span></a></li>
		    				<li><a href="#" title="恢复成绩" onclick="auditScoreShthChangeCjZt('hf')" id="hf" disabled="true"><span>恢复成绩</span></a></li>
		    				<li><a href="#" title="提交到发布流程" onclick="auditGameProcessTjfblc(this)" <s:if test="#isdisabled=='true' || #sc!=2 || #fbzt==3 || #fbzt==-1">disabled="true"</s:if>><span>提交到发布流程</span></a></li>
		    				<li><a href="#" title="预览赛次成绩" onclick="auditGameProcessSccjyl()"<s:if test="#fbzt==0 || #fbzt==0.5  || #fbzt==-1  || #sc!=2">disabled="true"</s:if> ><span>预览赛次成绩</span></a></li>
					 	</s:else>
					 	<s:if test="%{(jts==null || jts.size()==0) && (listSportCjYdy==null || listSportCjYdy.size()==0)}">
					 		<li><a href="#" title="强制退回" onclick="shth_del()"><span>强制退回</span></a></li>
					 	</s:if>
					 	<s:if test="%{(jts!=null && jts.size()>0)||(listSportCjYdy!=null && listSportCjYdy.size()>0)}">
		    					<li><a href="#" title="打印"  onclick="print('1')"><span>打印</span></a></li>
		    			</s:if>
					 		
		    				<li><div id="mes" style="font-size:12px; float: right; "></div></li>
		    		</ul>
					 </s:elseif>
    				
		    	</s:if>
		    	<s:if test="#type=='dj'.toString() && #model!='look'" >
		    			<s:if test="#jtscbm!=null && #jtscbm!=''">
					 		<ul class="btn_gn">
		    					<li><a href="#" title="返回登记团队成绩" onclick="fhdjtdcj()"><span>返回登记团队成绩</span></a></li>
		    					<li><a href="#" title="保存" onclick="dosave('1',this)"><span>保存</span></a></li>
		    					<li><a href="#" title="新增" onclick="xz2('0')"><span>新增</span></a></li>
		    					<li><a href="#" title="删除" onClick="del()" name="removeRows"><span>删除</span></a></li>
		    				 </ul>
						</s:if>
						<s:else>
							<ul class="btn_gn">
							<s:if test="#fbzt==0||#fbzt==0.5||#fbzt==-1" >
		    					<li><a href="#" title="保存" onclick="dosave('2',this)"  <s:if test="(jts==null && listSportCjYdy==null)||( jts!=null && listSportCjYdy!=null && jts.size()==0&& listSportCjYdy.size()==0 ) || #isdisabledSave=='true'"> disabled="true" </s:if>   ><span>保存</span></a></li>
		    					
		    					<s:if test="#isjtxm!=1 && #isjtxm!=2">
		    						<li><a href="#" title="新增"  onclick="xz('0')"><span>新增</span></a></li>
		    					</s:if>
		    					<s:else>
		    						<li><a href="#" title="新增"  onclick="xz('1')"><span>新增</span></a></li>
		    						<li><a href="#" title="保存并更新团队人员" onclick="updateAndSavePeople(this)"  <s:if test="(jts==null && listSportCjYdy==null)||( jts!=null && listSportCjYdy!=null && jts.size()==0&& listSportCjYdy.size()==0 ) || #isdisabledSave=='true' ||(#isjtxm!=1 && #isjtxm!=2 )"> disabled="true" </s:if>   ><span>保存并更新团队人员</span></a></li>
		    					</s:else>
		    						<li><a href="#" title="删除" onClick="del('1',this)" name="removeRows"  <s:if test="(jts==null && listSportCjYdy==null)||( jts!=null && listSportCjYdy!=null && jts.size()==0&& listSportCjYdy.size()==0 ) || #isdisabledSave=='true'"> disabled="true" </s:if>><span>删除</span></a></li>
		    						<li><a href="#" title="提交到审核流程" onClick="auditGameProcessTjdxh(this)" name="removeRows"  <s:if test="(jts==null && listSportCjYdy==null)||( jts!=null && listSportCjYdy!=null && jts.size()==0&& listSportCjYdy.size()==0 ) || #isdisabledSave=='true'"> disabled="true" </s:if>><span>提交审核</span></a></li>
		    					<s:if test="#importTempID!=null && #importTempID!=''">
		    						<li><a href="#" title="导入数据" onClick="openPage('../system/excelUserImport-input.c?importTempID=')" <s:if test="#fbzt==3 || (jts!=null && listSportCjYdy!=null)&&(jts.size()>0&& listSportCjYdy.size()>0 )"> disabled="true" </s:if> name="removeRows"><span>导入数据</span></a></li>
		    					</s:if>	
		    				</s:if>
		    				<s:else>
		    					<li><a href="#" title="保存"  disabled="true"  ><span>保存</span></a></li>
		    						<li><a href="#" title="新增"   disabled="true" ><span>新增</span></a></li>
		    						<li><a href="#" title="保存并更新团队人员"  disabled="true" ><span>保存并更新团队人员</span></a></li>
		    						<li><a href="#" title="删除"  name="removeRows"   disabled="true"><span>删除</span></a></li>
		    						<li><a href="#" title="提交到审核流程" name="removeRows" disabled="true" ><span>提交审核</span></a></li>
		    					<s:if test="#importTempID!=null && #importTempID!=''">
		    						<li><a href="#" title="导入数据" onClick="openPage('../system/excelUserImport-input.c?importTempID=')" disabled="true"  name="removeRows"><span>导入数据</span></a></li>
		    					</s:if>	
		    				</s:else>
		    				<s:if test="%{(jts!=null && jts.size()>0)||(listSportCjYdy!=null && listSportCjYdy.size()>0)}">
		    					<li><a href="#" title="打印"  onclick="print('1')"><span>打印</span></a></li>
		    				</s:if>	
		    					<li><div id="mes" style="font-size:12px; float: right; "></div></li>
		    				</ul>
						</s:else>
				 </s:if>
				 <s:if test="%{#model=='look'.toString()}">
					<ul class="btn_gn">
				 		<li><a href="#" title="返回团队成绩列表" onclick="fhdjtdcj()"><span>返回团队成绩列表</span></a></li>
				 	</ul>
				 </s:if>
				 </td>
    		</tr>
    </table>
   
    <br />
    <br />
    <br />
    </s:if>
    <table border="0"  cellpadding="0" cellspacing="0" class="maginB" width="1155"  align="left">
	  <tr>
	    <td class="infomainbg">
	    <!-- 发布状态  用于取消审批 时 判断（必须取消发布） -->
	   <s:hidden name="jtwid" id="jtwid" value="%{#jtwid}" />
	    <s:hidden name="url" id="url" value="%{#url}"> </s:hidden>
	    <s:hidden name="fbzt" id="fbzt" value="%{#fbzt}"> </s:hidden>
	    <s:hidden name="isjtxm" id="isjtxm" value="%{#isjtxm}"> </s:hidden>
	    <s:hidden name="jtscbm" id="jtscbm" value="%{#jtscbm}"> </s:hidden>
	    <s:hidden name="xmbm" id="xmbm" value="%{#xmbm}"> </s:hidden>
	    <s:hidden id="departid" name="departid" value="%{#departid}"> </s:hidden>
		<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td>&nbsp;</td>
	        <td >
      	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
    		<s:if test="#isjtxm!=1 && #isjtxm!=2">
    			<!-- 导入  非集体项目 -->
    			<jsp:include page="fjtxm.jsp" flush="true"></jsp:include>
    		</s:if>
    		<s:else>
    		<!-- 导入  集体项目 -->
    			<jsp:include page="jtxm.jsp" flush="true"></jsp:include>
    		</s:else>
    	</table>
    	    	</td>
	        </tr>
	    </table>		
		</td>
	    <td width="10" class="infomainright">&nbsp;</td>
	  </tr>
	  <tr>
	    <td height="20" class="infobottomleft"></td>
	    <td width="10" class="infobottomright"></td>
	  </tr>
	</table>
    	<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage" style=" float:  left">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
	</s:if>
    	</s:form>
    	 
    </div>
    <script type="text/javascript">
    	var local = window.location+"";
		document.forms[0].action = local;
    </script>
  </body>
</html>
