<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
  	<title>新增参赛者 - <s:property value="xxmmc" /></title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.bgiframe.min.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.ajaxQueue.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/thickbox-compressed.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.js"></script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.css">
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/lib/thickbox.css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript">
	
	detailPageStyle();
	$(document).ready(function(){
		<%
			String str = request.getParameter("departid");
			if(StringUtils.isNotBlank(str)){
				%>
				var url = "<s:property value="basePath"/>/suggest?aim=getYdyXxDxm&scbmd="+'<s:property value="%{#scbm}" />'+"&scbmx="+'<s:property value="%{#scbm}" />&ds='+'<s:property value="%{#departid}" />';
				getSuggest("xm","bm",url,true);
				<%
			}else{
				%>
				var url = "<s:property value="basePath"/>/suggest?aim=getYdyXxDxm&scbmd="+'<s:property value="%{#scbm}" />'+"&scbmx="+'<s:property value="%{#scbm}" />';
				getSuggest("xm","bm",url,true);
				<%
			}
		%>
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
	}

	
function addOne(obj){
	var bm = $("#bm").val();
	if(bm==null || bm==''){
		alert('您检索后添加的运动员不存在！');
		return false;
	}else{
		obj.disabled=true;
		var scbmValidate = document.getElementById("scbmValidate").value;
		var departid = document.getElementById("departid").value;
		var xmbm = document.getElementById("xmbm").value;
		ajaxService.validatePerson(scbmValidate,bm,departid,xmbm, function (data){
			if(data=='no'){
				alert('该数据已存在！');
				obj.disabled=false;
				return false;
			}else if(data=='passBut'){
				if(window.confirm("您添加的运动员非本代表团或代表队的运动员，确认添加？")){
					$("#bms").val(bm);
					var url = actionName+"-save."+uri_suffix+"?reqtime="+new Date().getTime();
					var postData = $("#theform").serializeArray();
					$.post(url, postData, function(data){
					       	if(data.indexOf('<span class="actionMessage">操作成功</span>')!=-1){
						       	$("#xm").val('');
						       	$("#bm").val('');
						       	$("#bms").val('');
						       	addSuccessMessage();
								obj.disabled=false;
						    }else{
							    alert($(data).find("#SystemErrorMessage span").text());
							    obj.disabled=false;
						    }
					});
				}
			}else if(data=='ydybf'){
					alert('此运动员信息与二次报名确认数据不符！');
					obj.disabled=false;
					return false;

			}else if(data=='wbcxm'){
					alert('该运动员未报此项目！');
					obj.disabled=false;
					return false;
			}else if(data=='ok'){
				$("#bms").val(bm);
				var url = actionName+"-save."+uri_suffix+"?reqtime="+new Date().getTime();
				var postData = $("#theform").serializeArray();
				$.post(url, postData, function(data){
				       	if(data.indexOf('<span class="actionMessage">操作成功</span>')!=-1){
					       	$("#xm").val('');
					       	$("#bm").val('');
					       	$("#bms").val('');
					       	addSuccessMessage();
					       	obj.disabled=false;
					    }else{
						    alert($(data).find("#SystemErrorMessage span").text());
						    obj.disabled=false;
					    }
				});
			}
		});
	}
}
	
	function dosave(obj){
		var id = CropCheckBoxValueAsString("selectNode");
		if(id.length==0){
			alert("请勾选代表团！");
			return false;
		}
		$("#dbt").val(id);
		obj.disabled=true;
		var url = actionName+"-save."+uri_suffix+"?reqtime="+new Date().getTime();
		var postData = $("#theform").serializeArray();
		$.post(url, postData, function(data){
		       	if(data.indexOf('<span class="actionMessage">操作成功</span>')!=-1){
			       	addSuccessMessage();
			       	obj.disabled=false;
			    }else{
				    alert($(data).find("#SystemErrorMessage span").text());
					obj.disabled=false;
			    }
		});
	}

	//添加保存成功信息
function addSuccessMessage(){
	mesg_html = "<img src='<s:property value='basePath'/>/resources/images/vista/btn_info.png' width='14' height='14' />";
	mesg_html += "&nbsp;&nbsp;添加成功！</span>";
	parent.document.getElementById("ym_bc_div").innerHTML = mesg_html;
}
	
function dosavenew(){
	if(getValidates()){
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

function doSerch(){
	url_back = url_back+"&selectDbt="+$("#selectDbt").val()
	//alert(url_back);
	window.location.href = url_back;
}

/*
function getValidates(){
	
		var dbt = document.getElementById("dbt").value;
		if(dbt == ''){
			alert(" 请选择'代表团' ！");
			return false;
		}else{
			return true;
		}
}
*/
function savelist(obj){
	var id = CropCheckBoxValueAsString("selectNode");
	//var bm = $("#bm").val();
	var totalbm = '';
	var scbmValidate = document.getElementById("scbmValidate").value;
	var departid = document.getElementById("departid").value;
	var xmbm = document.getElementById("xmbm").value;
	if(id!=null && id != ''){
		totalbm = id;
		obj.disabled=true;
		ajaxService.validatePerson(scbmValidate,totalbm,departid,xmbm, function (data){
			if(data=='no'){
				alert('该数据已存在！');
				obj.disabled=false;
				return false;
			}else if(data=='passBut'){
				if(window.confirm("您添加的运动员非本代表团或代表队的运动员，确认添加？")){
					tjbc(totalbm);
				}
				obj.disabled=false;
			}else if(data=='ydybf'){
					alert('此运动员信息与二次报名确认数据不符！');
					obj.disabled=false;
					return false;

			}else if(data=='wbcxm'){
					alert('该运动员未报此项目！');
					obj.disabled=false;
					return false;
			}else if(data=='ok'){
				tjbc(totalbm);
				obj.disabled=false;
			}
		});
	}else{
	 alert('请选择运动员！');	
		return false;
	}
}
//提交保存
function tjbc( totalbm){
	$("#bms").val(totalbm);
	var url = actionName+"-save."+uri_suffix+"?reqtime="+new Date().getTime();
	var postData = $("#theform").serializeArray();
	$.post(url, postData, function(data){
	       	if(data.indexOf('<span class="actionMessage">操作成功</span>')!=-1){
		       	$("input:checked").removeAttr("checked"); 
		       	addSuccessMessage();
		    }else{
			    alert($(data).find("#SystemErrorMessage span").text());
		    }
	});
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
<div class="framestyle" style="width:100%">
<s:form id="theform" name="theform" method="post"  theme="simple">
     <s:hidden name="scbm" id="scbmValidate"  value="%{#scbm}" />
     <s:hidden name="departid" id="departid" value="%{#departid}" />
     <s:hidden name="isjtdj" id="isjtxm" value="%{#isjtdj}" />
     <s:hidden name="xmbm" value="%{#xmbm}" id="xmbm"/>
     <s:hidden name="bmlast" id="bms"/>
     <s:hidden name="jtwid" id="jtwid" value="%{#jtwid}" />
     <input type="hidden" id="handType" value="<s:property value='type' />" />
       <s:if test="#type!=1">
        <fieldset> 
　				 <legend>根据姓名拼音首字母检索</legend>
  				<table width="100%" border="0" align="center">
  				   <tr> 
     				 <td nowrap="nowrap">运动员：
	     				 <s:hidden name="gl" id="gl" value="2"/>
	     				 <input type="text" value="<s:property value="dxmmc" />" disabled="disabled" size="10" />
	     				<s:if test="%{#departid==null || #departid==''}">
	     				  <s:select name="ds" id="ds" list="getDbtmc()" listKey="id" listValue="caption"  headerKey="" headerValue="-请选择-"  onchange="changeGl()"/>
	     				</s:if>
	     				<s:else>
	     					 <s:select list="getDbtmc()" listKey="id" listValue="caption"  headerKey="" headerValue="-请选择-"  disabled="true" value="%{#departid}" />
	     					 <s:hidden name="ds" id="ds" value="%{#departid}" />
	     				</s:else>
	     				 <s:textfield name="xm" id="xm" size="60"/><s:hidden name="bm" id="bm"/>
     				 </td>
     				 <td align="left"><input type="button" onclick="addOne(this)" value="立即添加" /></td>
    			   </tr>
   				</table>
 		</fieldset>
       <s:if test="#isjtdj==1" ><s:hidden name="saveModel" value="jtxm" ></s:hidden></s:if><s:else><s:hidden name="saveModel" value="fjtxm"></s:hidden></s:else>
       		   <fieldset> 
　				 <legend>二次报名的运动员列表</legend>
			<s:if test="%{#departid==null || #departid==''}">
			<div align="left">
				&nbsp;级（赛）别：<input type="text" disabled="disabled" value="<s:property value="xxmmc" />" />
				<s:if test="%{#departid==null || #departid==''}">
					&nbsp;代表团：<s:select name="selectDbt" id="selectDbt" list="getDbtmc()" listKey="id" listValue="caption" headerKey="" headerValue="---请选择---" ></s:select>
				</s:if>
				&nbsp;<input type="button" onclick="doSerch()" value="查询" />
			</div>
			</s:if>
  		<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
    		<thead id="listHead">
  				   <tr> 
  				   	<th height="20px" width="5%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
  				   	<th>姓名</th>
  				   	<th>身份证号</th>
  				   	<th>所属运动队</th>
  				   	<th>注册号</th>
    			   </tr>
    		</thead>
    			   <tbody id="listData">
 			<s:iterator value="#ydylist" status="loop">
 				<tbody id="listData">
    			<tr>
    				<td ><s:checkbox id="%{#ydylist[#loop.index][0]}" name="selectNode" fieldValue="%{#ydylist[#loop.index][0]}_%{#ydylist[#loop.index][2]}_%{#ydylist[#loop.index][1]}_%{#ydylist[#loop.index][5]}"/></td>
      				<td><s:property value="%{#ydylist[#loop.index][2]}" /></td>
      				<td><s:property value="%{#ydylist[#loop.index][3]}" /></td>     		   			       			    		    
    				<td><s:property value="%{#ydylist[#loop.index][1]}" /></td>
    				<td><s:property value="%{#ydylist[#loop.index][4]}" /></td>
    			</tr>
    			</tbody>
   			</s:iterator>
    	</tbody>
   	 </table>
 	</fieldset>
       </s:if>
       <s:else>
       <s:hidden name="saveModel" value="jtxm"></s:hidden>
    <fieldset> 
　 		<legend>新增代表团</legend>
  	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
     <s:if test="#type==1">
     	<tr><td><s:checkbox name="selectAll" onclick="doSelectAll()" /></td><td align="left">&nbsp;全选</td><td>&nbsp;</td><td>&nbsp;</td></tr>
     	<s:hidden name="dbt" id="dbt" />
    	   <s:iterator value="getDbtmc4Ydydj()" status="st">
    	   	<s:if test="#st.index%2==0"><tr></s:if>
    	   	  	<td ><s:checkbox id="%{id}" name="selectNode" fieldValue="%{id}"/></td>
    	   	  	<td style="text-align: left;">&nbsp;<s:property value="caption" /></td>
    	   	  	 	<s:if test="#st.index%2!=0"></tr></s:if>
    	   </s:iterator>
    </s:if>
   </table>
  	</fieldset>
       
  </s:else>
   
  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
  <tr align="center" valign="middle">
  <td width="220">&nbsp;</td> 
    <td height="30" colspan="1" >
     <ul class="btn_gn">
    	<s:if test="#type==1">
    		<li><a href="#" title="保存" onClick="dosave(this)"><span>保存</span></a></li>
	    </s:if>
	    <s:else>
	    	<li><a href="#" title="保存" onClick="savelist(this)"><span>保存</span></a></li>
	    </s:else>
	    	<li><a href="#" title="关闭" onClick="parent.closeInputWindow()"><span>关闭</span></a></li>
	 </ul>
    </td>
  </tr>
  </table>
</s:form>
</div>
  </body>
</html>
