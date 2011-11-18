<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
	<title>选择部门</title>
	<%@include file="../../common/include_list_head.jsp" %>
	<link href="../../css/import_basic.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript">
	$(document).ready(function(){
		//添加自定义按钮
		var userRoleMenuButton = '<s:property value="userRoleMenuButton"  escape="false"/>';
		if(userRoleMenuButton != null && userRoleMenuButton != ''){
			//document.getElementById("userRoleMenuButton").innerHTML = userRoleMenuButton;
		}
				
		//firfox里样式调整
		changeInitStyle();
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
	      if(objid!=null){
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
	}
	function departInfo(departid){
		openWindow('<s:property value="basePath"/>/system/depart-input.action?wid='+departid+'&readOnlyPage=true',
				document.body.clientWidth - 200,document.body.clientHeight - 60);
	}

	</script>
  	
  </head>
	<body > 
		<div id="scrollContent">
			<div style="padding-top:10px;padding-bottom:10px" class="box_tool_mid padding_right5">
			<div class="center">
				<div class="left">
					<div class="right">
						<div class="padding_top8 padding_left10">
							<table>
			    <s:form theme="simple" name="ysform">
				    <s:hidden name="pager.formname" value="ysform"/>
				    <s:hidden name="pager.currentPageno" id="yspager_currentPageno"/>
					<s:hidden name="tsysDepart.departtype"/>
					<s:hidden name="ids" id="ids" value="%{#parameters.ids[0]}" />
					<s:hidden name="userId" id="userId" value="%{#parameters.userId[0]}" />	
					<s:hidden name="addressList" value="%{#parameters.addressList[0]}" id="addressList"/>
					<s:hidden name="depid" value="%{#parameters.depid[0]}" id="depid"/>
    				<s:hidden name="changestate_parms" id="changestate_parms" value="entityName:t_sys_depart;idName:departid"/>
					<tr> 
						<td>部门名称： </td>
						<td><s:textfield name="tsysDepart.departname" id="departname" maxlength="50" size="10" /></td> 						
						<td>部门编号： </td>
						<td><s:textfield name="tsysDepart.departid" id="departid" maxlength="50" size="5" /></td> 
						<td>上级部门名称：</td>
						<td><s:textfield name="tsysDepart.updepartid" id="updepartid" maxlength="50" size="10" /></td> 
						<td>
							<button id="searchButton1" onclick="super_doSearch()"><span class="icon_find">查询</span></button>
							<button id="searchButton2" onclick="doreset();"><span class="icon_recycle"> 重置 </span></button>
						</td>
					</tr>
				</s:form>
				</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 
				  <s:if test="#parameters==null||#parameters.addressList==null||#parameters.addressList[0]!=1">
					<div style="padding-bottom:10px" id="userRoleMenuButton">
							<button onclick="postDeparts()"><span class="icon_ok">确定</span></button>
							<button onClick="parent.closeInputWindow()"><span class="icon_no">取消</span></button>
							<button id="adddeparts"  style="display:none" onClick="addDeparts()"><span class="icon_add">追加</span></button>
							<button onClick="postNoDeparts()"><span class="icon_recycle">清除已选</span></button>
					</div>
				  </s:if>
				 -->
	    	
			<div>
				<table class="tableStyle" useMultColor="false" useCheckBox="false">
						<tr>
							<th width="10%"><s:checkbox name="selectAll" onclick="doSelectAll()"/></td>
							<th width="20%">部门编号</td>
							<th width="40%">部门名称</td>
							<th width="30%">上级部门名称</td>
						</tr>
					</thead>
						<s:iterator value="resultData">
						    <tr>
								<td><s:checkbox id="%{departid}" name="selectNode" fieldValue="%{departid}"/></td>
								<td><s:property value="departid"/></td>
						 		<td id="dname_${departid}">
						 		<a href="javascript:departInfo('<s:property value="departid"/>')"><s:property value="departname" /></a>
						 		</td>
								<td><s:property value="updepartid" /></td>				
							</tr>
						</s:iterator>
				</table>
			</div>
			
		<div style="height: 45px;">
			<div id="pagelist" style="display: none">
	  			<s:property value="pager.postToolBar" escape="false"/>
	  		</div>
	
			<div class="clear"></div>
			</div>
		</div>
	</body>
</html>

