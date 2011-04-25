<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
  	<title>新增参赛者</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.bgiframe.min.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.ajaxQueue.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/thickbox-compressed.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.css">
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/lib/thickbox.css">
	<script type="text/javascript">
	
	detailPageStyle();
	$(document).ready(function(){
		var url = "<s:property value="basePath"/>/suggest?aim=getYdyXxXxm&scbmd="+'<s:property value="%{#scbm}" />'+"&scbmx="+'<s:property value="%{#scbm}" />';
		getSuggest("xm","bm",url,true);
	});
	function changeGl(){
		var gl = document.getElementById("gl").value;
		var ds = document.getElementById("ds").value;
		if(gl == '3'){
			var url = "<s:property value="basePath"/>/suggest?aim=getYdyXxQb&ds="+ds;
			getSuggest("xm","bm",url,true);
		}else if(gl == '2'){
			var url = "<s:property value="basePath"/>/suggest?aim=getYdyXxDxm&ds="+ds+"&scbmd="+'<s:property value="%{#scbm}" />';
			getSuggest("xm","bm",url,true);
		}else if(gl == '1'){
			var url = "<s:property value="basePath"/>/suggest?aim=getYdyXxXxm&ds="+ds+"&scbmd="+'<s:property value="%{#scbm}" />'+"&scbmx="+'<s:property value="%{#scbm}" />';
			getSuggest("xm","bm",url,true);
		}
	}
	var type = '<s:property value="%{#parameters.type[0]}" />';
	var scbm = '<s:property value="%{#parameters.scbm[0]}" />';
	var departid = '<s:property value="%{#parameters.departid[0]}" />';
	var isjtdj = '<s:property value="isjtdj" />';
	var xmbm = '<s:property value="xmbm" />';
	var url = actionName+"-save."+uri_suffix+"?reqtime="+new Date().getTime();//提交保存的url
	var url_back = actionName+'-xzcsz.'+uri_suffix+'?type='+type+"&scbm="+scbm+"&departid="+departid+"&isjtdj="+isjtdj+"&xmbm="+xmbm;//刷新页面的URL
function dosaveclose(){
	
	if(getValidates()){
		if(document.getElementById("bm") || document.getElementById("ydy")){
		var bm = document.getElementById("bm").value;
		var ydy = document.getElementById("ydy").value;
		var scbmValidate = document.getElementById("scbmValidate").value;
		var departid = document.getElementById("departid").value;
		var xmbm = document.getElementById("xmbm").value;
		var temp = '';
		if(bm!=null && bm!=''){
			temp = bm;
		}else if(ydy!=null && ydy!=''){
			temp = ydy;
		}
		ajaxService.validatePerson(scbmValidate,temp,departid, xmbm, function (data){
			if(data=='no'){
				alert('该数据已存在！');
				return false;
			}else if(data=='passBut'){
				if(window.confirm("您添加的运动员非本代表团或代表队的运动员，确认添加？")){
					var url = actionName+"-save."+uri_suffix+"?reqtime="+new Date().getTime();
					var postData = $("#theform").serializeArray();
					$.post(url, postData, function(data){
					       	if(data.indexOf('<span class="actionMessage">操作成功</span>')!=-1){
						       	parent.window.location.reload();
						    }else{
							    alert($(data).find("#SystemErrorMessage span").text());
						    }
					});
				}
			}else if(data=='ydybf'){
				alert('此运动员信息与二次报名确认数据不符！');
				return false;

		}else if(data=='wbcxm'){
				alert('该运动员未报名！');
				return false;
		}else if(data=='ok'){
				var url = actionName+"-save."+uri_suffix+"?reqtime="+new Date().getTime();
				var postData = $("#theform").serializeArray();
				$.post(url, postData, function(data){
				       	if(data.indexOf('<span class="actionMessage">操作成功</span>')!=-1){
					       	parent.window.location.reload();
					    }else{
						    alert($(data).find("#SystemErrorMessage span").text());
					    }
				});
			}
			});
		}else{
			var postData = $("#theform").serializeArray();
			
			$.post(url, postData, function(data){
			       	if(data.indexOf('<span class="actionMessage">操作成功</span>')!=-1){
				       	parent.window.location.reload();
				    }else{
					    alert($(data).find("#SystemErrorMessage span").text());
				    }
			});

		}
	}
}

function dosavenew(){
	if(getValidates()){
		if(document.getElementById("bm") || document.getElementById("ydy")){
			var bm = document.getElementById("bm").value;
			var ydy = document.getElementById("ydy").value;
			var scbmValidate = document.getElementById("scbmValidate").value;
			var departid = document.getElementById("departid").value;
			var xmbm = document.getElementById("xmbm").value;
			var temp = '';
			if(bm!=null && bm!=''){
				temp = bm;
			}else if(ydy!=null && ydy!=''){
				temp = ydy;
			}
			ajaxService.validatePerson(scbmValidate,temp,departid,xmbm, function (data){
				if(data=='no'){
					alert('该数据已存在！');
					return false;
				}else if(data=='passBut'){
					if(window.confirm("您添加的运动员非本代表团或代表队的运动员，确认添加？")){
						var postData = $("#theform").serializeArray();
						
						$.post(url, postData, function(data){
						       	if(data.indexOf('<span class="actionMessage">操作成功</span>')!=-1){
									window.location.href = url_back;
							    }else{
								    alert($(data).find("#SystemErrorMessage span").text());
							    }
						});
					}
				}else if(data=='ydybf'){
						alert('此运动员信息与二次报名确认数据不符！');
						return false;

				}else if(data=='wbcxm'){
						alert('该运动员未报此项目！');
						return false;
				}else if(data=='ok'){
							var postData = $("#theform").serializeArray();
					
							$.post(url, postData, function(data){
					       	if(data.indexOf('<span class="actionMessage">操作成功</span>')!=-1){
								window.location.href = url_back;
						    }else{
							    alert($(data).find("#SystemErrorMessage span").text());
						    }
					});
						//super_submitForm();
				}
			});
		}else{
			var postData = $("#theform").serializeArray();
			
			$.post(url, postData, function(data){
			       	if(data.indexOf('<span class="actionMessage">操作成功</span>')!=-1){
						window.location.href = url_back;
				    }else{
					    alert($(data).find("#SystemErrorMessage span").text());
				    }
			});
		}
	}
}

function getValidates(){
	var type = document.getElementById("handType").value;
	if(type=='1'){
		var dbt = document.getElementById("dbt").value;
		if(dbt == ''){
			alert(" 请选择'代表团' ！");
			return false;
		}
	}else{
		var i = 0;
		var j = 0;
		var bm = document.getElementById("bm").value;
		var ydy = document.getElementById("ydy").value;
		var dbt = document.getElementById("dbt").value;
		var dbd = document.getElementById("dbd").value;
		var xm = document.getElementById("xm").value;
		if(xm == ''){
			bm = '';
		}
		if(bm != ''){
			i = 1;
		}
		if(ydy != ''){
			j = j+1;
		}
		if(dbt != ''){
			j = j+1;
		}
		if(dbd != ''){
			j = j+1;
		}
		if(i==1){
			if(j>0){
				alert("您选择'根据姓名拼音首字母检索运动员' 请不要在 '根据代表地查找' 做出选择！ ")
				return false;	
			}else{
				return true;
			}	
		}else{
			if(dbt == ''){
				alert("当前默认选择'根据代表地查找运动员' 请选择'代表团' ！");
				return false;
			}
			if(ydy == ''){
				alert("当前默认选择'根据代表地查找运动员' 请选择'运动员' ！");
				return false;
			}
		}
	}
	return true;
}


//获得代表队
function getDbd(){
	var val = document.getElementById('dbt').value;
	ajaxService.getDbd(val,function (data){
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		DWRUtil.removeAllOptions('dbd');
		DWRUtil.addOptions( 'dbd', data,'id','caption');
		$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
	});
	if(document.getElementById('ydy')){
		ajaxService.getYdy(val,function (data){
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('ydy');
			DWRUtil.addOptions( 'ydy', data,'id','caption');
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
		});
	}
}
//获得运动员
function getYdy(){
	var val = document.getElementById('dbd').value;
	if(val == '' && document.getElementById('dbt').value != null){
		val = document.getElementById('dbt').value;
	}
		ajaxService.getYdy(val,function (data){
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('ydy');
			DWRUtil.addOptions( 'ydy', data,'id','caption');
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
		});
}

	</script>
  </head>
  
  <body style="text-align:center;">
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

<div class="framestyle" style="width:100%">
<s:form id="theform" name="theform" method="post" theme="simple">
     <s:hidden name="scbm" id="scbmValidate"  value="%{#scbm}" />
     <s:hidden name="departid" id="departid" value="%{#departid}" />
     <s:hidden name="isjtdj" value="%{#isjtdj}" />
     <s:hidden name="xmbm" value="%{#xmbm}" id="xmbm"/>
     <input type="hidden" id="handType" value="<s:property value='type' />" />
       <s:if test="#type!=1">
       		   <fieldset> 
　				 <legend>根据姓名拼音首字母检索</legend>
  				<table width="100%" border="0" align="center">
  				   <tr> 
     				 <td nowrap="nowrap">运动员：
	     				 <s:select name="gl" id="gl" list="#{'1':'级（赛）别参赛者','2':'项目参赛者','3':'全部运动员'}" onchange="changeGl()"/>
	     				 <s:select name="ds" id="ds" list="getDbtmc()" listKey="id" listValue="caption"  headerKey="" headerValue="-请选择-"  onchange="changeGl()"/>
	     				 <s:textfield name="xm" id="xm" size="60"/><s:hidden name="bm" id="bm"/>
     				 </td>
    			   </tr>
   				</table>
 			 </fieldset>
       </s:if>

  
 <fieldset> 
　 <legend>根据代表地查找</legend>
  <table width="100%" border="0" align="center">
     <s:if test="#type==1">
     <tr> 
      <td align="right"  nowrap="nowrap">代表团：<s:hidden name="saveModel" value="jtxm"></s:hidden></td>
      <td ><s:select name="dbt" id="dbt" list="getDbtmc()" listKey="id" listValue="caption"  headerKey="" headerValue="-请选择-"  onchange="getDbd()" /> </td>
      <td align="right"  nowrap="nowrap">代表队：</td>
      <td ><s:select name="dbd" id="dbd" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="-请选择-" /></td>
       </tr>
     </s:if>
     <s:else>
     <tr> 
      <td align="right"  nowrap="nowrap">代表团：<s:if test="#isjtdj==1" ><s:hidden name="saveModel" value="jtxm" ></s:hidden></s:if><s:else><s:hidden name="saveModel" value="fjtxm"></s:hidden></s:else></td>
      <td ><s:select name="dbt" id="dbt" list="getDbtmc()" listKey="id" listValue="caption" headerKey="" headerValue="-请选择-"  onchange="getDbd()"/> </td>
      <td align="right" nowrap="nowrap">代表队：</td>
      <td><s:select name="dbd" id="dbd" list="#{}" listKey="id" listValue="caption"  headerKey="" headerValue="-请选择-"  onchange="getYdy()" /></td>
   	  <td align="right">运动员：</td>
      <td><s:select name="ydy" id="ydy" list="#{}"  listKey="id" listValue="caption" headerKey="" headerValue="-请选择-" /> </td>
    </tr>
	 </s:else>
   </table>
  </fieldset>
   
  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
  <tr align="center" valign="middle">
  <td width="220">&nbsp;</td> 
    <td height="30" colspan="1" >
    	<ul class="btn_gn">
    		<li><a href="#" title="保存并新增" onClick="dosavenew()"><span>保存并新增</span></a></li>
    		<li><a href="#" title="保存并关闭" onClick="dosaveclose()"><span>保存并关闭</span></a></li>
	    	<li><a href="#" title="关闭" onclick="parent.window.location.reload()"><span>关闭</span></a></li>
	    </ul>
    </td>
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
  </body>
</html>
