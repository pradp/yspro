<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>选择部门</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	
	<script type="text/javascript">
	listPageStyle();
	$(document).ready(function(){
		initData();
	});
	var objid = parent.tem_valueObjid;
	var objname = parent.tem_nameObjid;
	function postDeparts1(){ //明细发放时用的方法
		var objidValue="",objnameValue="";
		var a = document.getElementsByName("selectNode");
		for (var i = 0; i < a.length; i++) {
			if (a[i].checked) {
				objidValue += a[i].value + ",";
				objnameValue += document.getElementById("dname_"+a[i].value).innerText + "，";
			}
		}
		if(objidValue.length>0)
			objidValue = objidValue.substring(0, objidValue.length - 1);
		if(objnameValue.length>0)
			objnameValue = objnameValue.substring(0, objnameValue.length - 1);
			
		var temp=objidValue;
		var k=0;
		for(var j=0;j< temp.length;j++){
		   if(typeof(temp.split(",")[j])!="undefined"){
		   		k+=1;
		   }
		}	
		if(k==0){
			alert("没有选择要转给的高校！");
		}else if(k>1){
			alert("一条发放明细只应该转给一个高校！");
		}else{
			 var wid=document.getElementById("ids").value;
			 var userId=document.getElementById("userId").value;
			 openPage('../business/zxFfmx-approve.c?wid='+wid+'&objidValue='+objidValue+'&objnameValue='+objnameValue+'&userId='+userId);
			 
		}
	}
	
	
	function postDeparts2(){//发送消息时用的方法
		var objidValue="",objnameValue="";
		var a = document.getElementsByName("selectNode");
		for (var i = 0; i < a.length; i++) {
			if (a[i].checked) {
				objidValue += a[i].value + ",";
				objnameValue += document.getElementById("dname_"+a[i].value).innerText.replace(/(^\s*)|(\s*$)/g, "")+ "，";
			}
		}
		if(objidValue.length>0)
			objidValue = objidValue.substring(0, objidValue.length - 1);
		if(objnameValue.length>0)
			objnameValue = objnameValue.substring(0, objnameValue.length - 1);
		parent.document.getElementById(objid).value=objidValue;
		parent.document.getElementById(objname).value=objnameValue;
		//setParentWindowValue(objid,objidValue);
		//setParentWindowValue(objname,objnameValue);
		parent.closeInputWindow();
	}
	function postDeparts3(){//合并院系时用的方法
		var objidValue="",objnameValue="";
		var a = document.getElementsByName("selectNode");
		var slength = 0;
		for (var i = 0; i < a.length; i++) {
		    if (a[i].checked) {
		        slength += 1;
		    }
		}
		if(slength==1){
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value;
					objnameValue += document.getElementById("dname_"+a[i].value).innerText;
				}
			}
			parent.document.getElementById(objid).value=objidValue;
			parent.document.getElementById(objname).value=objnameValue;
			parent.closeInputWindow();
			parent.mergeDepart();
		}else{
			alert("请勾选一条记录!");
		}
	}
	
	function openPage(uri){
		openWindow(uri,850,450);
	} 
	function addDeparts(){
		var objidValue="",objnameValue="";
		var a = document.getElementsByName("selectNode");
		for (var i = 0; i < a.length; i++) {
			if (a[i].checked) {
				objidValue += a[i].value + ",";
				if(objnameValue.indexOf(document.getElementById("dname_"+a[i].value).innerText)==-1){
					objnameValue += document.getElementById("dname_"+a[i].value).innerText;
					if(i<a.length-1){
						objnameValue += "，";
					}
				}
			}
		}
		if(objnameValue.length>0){
			objidValue = objidValue.substring(0, objidValue.length - 1);
			objnameValue = objnameValue.substring(0, objnameValue.length - 1);
			var old_objidValue = parent.document.getElementById(objid).value;
			var old_objnameValue = parent.document.getElementById(objname).value;
			if(old_objidValue.length>0){
				objidValue = old_objidValue + "," + objidValue;
				objnameValue = old_objnameValue + "，" + objnameValue;
			}
			parent.document.getElementById(objid).value=objidValue;
			parent.document.getElementById(objname).value=objnameValue;
		}
		parent.closeInputWindow();
	}
	function postDeparts(){
	
		 if(document.getElementById("userId").value!=null && document.getElementById("userId").value!=''){
		 	postDeparts1();//明细发放时用的方法
		 }else if(document.getElementById("depid").value!=null && document.getElementById("depid").value!=''){
			 postDeparts3();//合并院系时用的方法
		 }else{
			postDeparts2();//发送消息时用的方法
		 }
	}
	function postNoDeparts(){
		parent.document.getElementById(objid).value="";
		parent.document.getElementById(objname).value="";
		var a = document.getElementsByName("selectNode");
		for (var i = 0; i < a.length; i++) {
			a[i].checked = false;
		}
	}
	function initData(){
	 	if(document.getElementById("userId").value!=null && document.getElementById("userId").value!=''){
		 document.getElementById("adddeparts").style.display="none";//明细发放时不显示 追加按钮
		 }else{
		 	document.getElementById("adddeparts").style.display="";//发送消息时 显示 追加按钮
		 }
	      var objid = parent.tem_valueObjid;
	      var objname = parent.tem_nameObjid;
		var objidValue=parent.document.getElementById(objid).value;
		var objnameValue=parent.document.getElementById(objname).value;
		var v = objidValue.split(",");
		var a = document.getElementsByName("selectNode");
		for (var i = 0; i < v.length; i++) {
			for(var j = 0; j < a.length; j++){
				if (a[j].value==v[i]) {
					a[j].checked=true;
				}
			}
			
		}
	}
	function doreset()
	{	
		document.getElementById("departname").value="";	
		document.getElementById("departid").value="";	
		document.getElementById("updepartid").value="";	
		document.getElementById("linkman").value="";	
	}
	function departInfo(departid){
		openWindow('<s:property value="basePath"/>/system/depart-departdetail.c?tsysDepart.departid='+departid+'&readOnlyPage=true',500,200);
	}
	</script>
  	<base target="_self">
  </head>
	<body > 
		<div id="listC" style="width:98%;margin:10px auto">
			<s:form theme="simple" name="theform">
				<s:hidden name="pager.formname" value="theform" />
				<s:hidden name="tsysDepart.departtype"/>
				<s:hidden name="ids" id="ids" value="%{#parameters.ids[0]}" />
				<s:hidden name="userId" id="userId" value="%{#parameters.userId[0]}" />	
				<s:hidden name="addressList" value="%{#parameters.addressList[0]}" id="addressList"/>
				<s:hidden name="depid" value="%{#parameters.depid[0]}" id="depid"/>
				    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
	  <tr>
	    <td class="chaxunleft">
				<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
					<tr> 
						<td align="right" nowrap="nowrap">&nbsp;部门名称： </td>
						<td  align="left" nowrap="nowrap"><s:textfield name="tsysDepart.departname" id="departname" maxlength="50" size="10" /></td> 						
						<td align="right" nowrap="nowrap">&nbsp;部门编号： </td>
						<td  align="left" nowrap="nowrap"><s:textfield name="tsysDepart.departid" id="departid" maxlength="50" size="5" /></td> 
						<td align="right" nowrap="nowrap">&nbsp;上级部门名称：</td>
						<td  align="left" nowrap="nowrap"><s:textfield name="tsysDepart.updepartid" id="updepartid" maxlength="50" size="10" /></td> 
						<td align="right" nowrap="nowrap">&nbsp;联系人： </td>
						<td  align="left" nowrap="nowrap"><s:textfield name="departDetail.linkman" id="linkman" maxlength="50" size="10" /></td> 						
						<td align="center" rowspan="2" nowrap="nowrap">
						     <ul class="btn_gn">
			    <li><a href="#" title="查询"  id="searchButton" name="btn3" onclick="document.getElementById('pager_currentPageno').value='1';document.forms[0].submit();"><span> 查询 </span></a></li>
				<li><a href="#" title="重置" onClick="doreset();" id="searchButton1" name="btn4"><span> 重置 </span> </a></li>
			  </ul>
						</td>
					</tr>
				</table>
				</td>
				    <td width="15" height="49" class="chaxunright">&nbsp;</td>
	  </tr>
    </table>
    
        <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%" class="maginB">
			<tr align="center">
				
			</tr>
	</table>
	<!-- addressList为通讯录专用,其他模块为空-->
		<s:if test="#parameters==null||#parameters.addressList==null||#parameters.addressList[0]!=1">
		<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%" align="center">
			<tr>
			    <td height="30px">
				   <ul class="btn_gn">
					<li><a href="#" title=" 确定" onClick="postDeparts()"><span> 确定</span></a></li>
					<li ><a href="#" title="取消" onClick="parent.closeInputWindow()"><span>取消</span></a></li>		 
					<li id="adddeparts"  style="display:none"><a href="#" title="追加" onClick="addDeparts()"><span>追加</span></a></li>
					<li><a href="#" title="清除已选" onClick="postNoDeparts()"><span>清除已选</span></a></li>
				   </ul>
			     </td>    
			 </tr>
		</table>
		</s:if>
	    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB" >
	  <tr>
	    <td class="infomainbg">
		
		<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>
				<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" align="center"  class="middle">
					<thead id="listHead">
						<tr>
							<td width="10%"><s:checkbox name="selectAll" onclick="doSelectAll()"/></td>
							<td width="40%">部门名称</td>
							<td width="35%">上级部门名称</td>
						</tr>
					</thead>
					<tbody id="listData">
						<s:iterator value="resultData">
						    <tr>
								<td><s:checkbox id="%{departid}" name="selectNode" fieldValue="%{departid}"/></td>
						 		<td id="dname_${departid}">
						 		<a href="javascript:departInfo('<s:property value="departid"/>')"><s:property value="departname" /></a>
						 		</td>
								<td><s:property value="departnamePy" /></td>				
							</tr>
						</s:iterator>
					</tbody>
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
				
				<table border="0" cellspacing="0" cellpadding="0" width="100%">
					<tr>
					     <td colspan="10" align="right"><s:property value="pager.postToolBar" escape="false" /></td>
					</tr>
				</table>
			</s:form>
		</div>
	</body>
</html>

