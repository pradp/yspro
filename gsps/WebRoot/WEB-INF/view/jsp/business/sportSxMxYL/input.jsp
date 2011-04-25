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
	function dosave(){
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
				super_submitForm();
				
			}
		}else{
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
	function shtg(){
		//0草稿、1审批通过、-1取消审批
		var conf = window.confirm("您确定将你选择的信息审批通过?");
		if(conf==true){
			var a = document.getElementsByName("selectNode");
			var scbm = document.getElementById("scbm").value;
			var isjtxm = document.getElementById("isjtxm").value;
			//两层数据标识
			var tt = []; 
			for(var i=0; i<a.length; i++){
					if(a[i].checked){
					var shzt_nameVal =document.getElementById("shzt_id"+i).value; 
					if(shzt_nameVal == "0" || shzt_nameVal == "-1"){
						tt[tt.length]= a[i].value; 
					}else{
						alert("其中包含审批通过 的数据，不允许提交审批！");
						return false;
					}
				}
			}
		if(tt.length==0){
			alert('请勾选一条数据！');
			return false;
		}else{
			ajaxService.ydydfTg(tt,scbm,isjtxm,function (data){
				alert(data);
				var scbm = document.getElementById("scbm").value;
				var sc = document.getElementById("sc").value;
				var type = document.getElementById("type_id").value;
				 window.location.href="../business/sportCjYdy-input.c?scbm="+scbm+"&sc="+sc+"&type="+type+"&wid=";
				return false;
			});

		}
	}
	}

	//退回
	function shth(){
		//0草稿、1审批通过、-1取消审批
		var conf = window.confirm("您确定将你选择的信息取消审批?");
		if(conf==true){
			var a = document.getElementsByName("selectNode");
			var scbm = document.getElementById("scbm").value;
			var isjtxm = document.getElementById("isjtxm").value;
			//两层数据标识
			var tt = []; 
			for(var i=0; i<a.length; i++){
				if(a[i].checked){
				var shzt_nameVal =document.getElementById("shzt_id"+i).value; 
				if(shzt_nameVal == "1"){
					tt[tt.length]= a[i].value; 
				}else{
					alert("其中包含未审批通过 的数据，不允许取消审批！");
					return false;
				}
			}
		}
		if(tt.length==0){
			alert('请勾选一条数据！');
			return false;
		}else{
			ajaxService.ydydfTh(tt,scbm,isjtxm,function (data){
				alert(data);
				var scbm = document.getElementById("scbm").value;
				var sc = document.getElementById("sc").value;
				var type = document.getElementById("type_id").value;
				 window.location.href="../business/sportCjYdy-input.c?scbm="+scbm+"&sc="+sc+"&type="+type+"&wid=";
				return false;
			});
		}
	}
	}
	
	//改变破纪录输入框的状态
	function changeYjlcl(id,obj){
		var yjlcl = document.getElementById(id);
		if(obj.value != '0'){
			yjlcl.disabled=false
		}else{
			yjlcl.disabled=true;
		}
			
	}
	function xz(type){
		openWindow('../business/sportCjYdy-xzcsz.c?type='+type+"&scbm="+document.getElementById('scbm').value, 800, 300);
	}
	function xz2(type){
		openWindow('../business/sportCjYdy-xzcsz.c?type='+type+"&scbm="+document.getElementById('scbm').value+"&departid="+document.getElementById("departid").value, 800, 300);
	}

	//发布
	function fb(){
		var xmbm = document.getElementById('xmbm').value;
		var scbm = document.getElementById('scbm').value;
		ajaxService.fbcj(xmbm,scbm,function (data){
			alert(data);
			return false;
		});
	}

	/**
	 * 删除选中的纪录。
	 * AJAX 请求传统页面方式实现
	 */
	function del(){
		var conf = window.confirm("您确定要删除已选中的这些数据吗？");
		if(conf==true){
			var ids = CropCheckBoxValueAsString("selectNode");
			var isjtxm = $("#isjtxm").val();
			//alert(isjtxm);
			if(ids.length>0){
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
			}else{
				alert("请选择要删除的项!");
			}
		}
	}
	
	function fhdjtdcj(){
		//alert(document.getElementById("sc").value);
		uri = "../business/sportCjYdy-input.c?scbm="+document.getElementById("scbm").value+"&sc="+document.getElementById("sc").value+"&type="+document.getElementById("type_id").value+"&wid=";
		location.href=uri;
	}
	</script>
  </head>
  
<body topmargin="0" leftmargin="0"> 


    <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform">
    <s:hidden name="type" id="type_id" value="%{#type}" />
    <br />
    　 <div style="font-size: 12px; font-weight: bold">代表团赛次成绩预览</div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB"  align="left">
	  <tr>
	    <td class="infomainbg">	
	    <s:hidden name="isjtxm" id="isjtxm" value="%{#isjtxm}"> </s:hidden>
	    <s:hidden name="jtscbm" id="jtscbm" value="%{#jtscbm}"> </s:hidden>
	    <s:hidden id="xmbm" value="%{#xmbm}"> </s:hidden>
	    <s:hidden id="departid" name="departid" value="%{#departid}"> </s:hidden>
		<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>
    	
      <table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
    		<thead id="listHead">	
    		<tr>
					 
			  		 <th>代表团</th>
			  		 <th>金牌数</th>
			  		 <th>银牌数</th>
			  		 <th>铜牌数</th>
			  		 <th>得分</th>
			   		 <th>审核状态</th>
			  		 <th>备注</th>
			  		 <th>得分类型</th>
			  		 <th>得分来源</th>
			  		 
			 	</tr>
    		</thead>
    		<tbody id="listData">
    		<s:iterator value="objsTd" status="i">
    		<tr>
    		<s:set name="bean" value="objsTd[#i.index]" />
			  		 <td>&nbsp;<s:property value="#bean[2]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[4]+#bean[7]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[5]+#bean[8]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[6]+#bean[9]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[11]+#bean[10]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[12]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[13]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[14]" /></td>
			  		 <td style="border-right: 1px #D7D8D9 solid;">&nbsp;<s:property value="#bean[15]" /></td>
			  </tr>
    		</s:iterator>
    		</tbody>
    	</table>
    	    	</td>
	        </tr>
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>
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
    
    <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform">
    <s:hidden name="type" id="type_id" value="%{#type}" />
    <br />
    <div style="font-size: 12px; font-weight: bold">市县赛次成绩预览</div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB"  align="left">
	  <tr>
	    <td class="infomainbg">	
	    <s:hidden name="isjtxm" id="isjtxm" value="%{#isjtxm}"> </s:hidden>
	    <s:hidden name="jtscbm" id="jtscbm" value="%{#jtscbm}"> </s:hidden>
	    <s:hidden id="xmbm" value="%{#xmbm}"> </s:hidden>
	    <s:hidden id="departid" name="departid" value="%{#departid}"> </s:hidden>
		<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>
    	
       <table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
    		<thead id="listHead">	
    		<tr>
			  		 <th>单位</th>
			  		 <th>金牌数</th>
			  		 <th>银牌数</th>
			  		 <th>铜牌数</th>
			  		 <th>得分</th>
			   		 <th>审核状态</th>
			  		 <th>备注</th>
			  		 <th>得分类型</th>
			  		 <th>得分来源</th>
			  		 
			 	</tr>
    		</thead>
    		<tbody id="listData">
    		<s:iterator value="objsSx" status="i">
    		<tr>
    		<s:set name="bean" value="objsSx[#i.index]" />
			  		 <td>&nbsp;<s:property value="#bean[3]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[4]+#bean[7]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[5]+#bean[8]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[6]+#bean[9]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[11]+#bean[10]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[12]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[13]" /></td>
			  		 <td>&nbsp;<s:property value="#bean[14]" /></td>
			  		 <td style="border-right: 1px #D7D8D9 solid;">&nbsp;<s:property value="#bean[15]" /></td>
			  </tr>
    		</s:iterator>
    		</tbody>
    	</table>
    	    	</td>
	        </tr>
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>
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
    
  </body>
</html>
