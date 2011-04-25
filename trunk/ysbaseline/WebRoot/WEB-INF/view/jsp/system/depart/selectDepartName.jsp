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
	function openPage(uri){
		openWindow(uri,850,450);
	} 
	function addDeparts(){
		var objidValue="",objnameValue="";
		var deptype = document.getElementById("deptype").value;
		if(deptype == 1 || deptype == 0){
			var a = document.getElementsByName("selectNodeSzx");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					if(objnameValue.indexOf(objnameValue)!=-1){
						objnameValue += document.getElementById("dname_"+a[i].value).innerText;
						if(i<a.length-1){
							objnameValue += ",";
						}
					}
				}
			}
		}
		if(deptype == 6 || deptype == 0){
			var a = document.getElementsByName("selectNodeSsbk");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					if(objnameValue.indexOf(objnameValue)!=-1){
						objnameValue += document.getElementById("dname_"+a[i].value).innerText;
						if(i<a.length-1){
							objnameValue += ",";
						}
					}
				}
			}
			var a = document.getElementsByName("selectNodeGzgz");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					if(objnameValue.indexOf(objnameValue)!=-1){
						objnameValue += document.getElementById("dname_"+a[i].value).innerText;
						if(i<a.length-1){
							objnameValue += ",";
						}
					}
				}
			}
			var a = document.getElementsByName("selectNodeSzssgx");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					if(objnameValue.indexOf(objnameValue)!=-1){
						objnameValue += document.getElementById("dname_"+a[i].value).innerText;
						if(i<a.length-1){
							objnameValue += ",";
						}
					}
				}
			}
			var a = document.getElementsByName("selectNodeCrgx");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					if(objnameValue.indexOf(objnameValue)!=-1){
						objnameValue += document.getElementById("dname_"+a[i].value).innerText;
						if(i<a.length-1){
							objnameValue += ",";
						}
					}
				}
			}
		}
		if(deptype == 7 || deptype == 0 || deptype == 20 ){
			var a = document.getElementsByName("selectNodeSz");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					if(objnameValue.indexOf(objnameValue)!=-1){
						objnameValue += document.getElementById("dname_"+a[i].value).innerText;
						if(i<a.length-1){
							objnameValue += ",";
						}
					}
				}
			}
			var a = document.getElementsByName("selectNodeX");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					if(objnameValue.indexOf(objnameValue)!=-1){
						objnameValue += document.getElementById("dname_"+a[i].value).innerText;
						if(i<a.length-1){
							objnameValue += ",";
						}
					}
				}
			}
		}
		if(objnameValue.length>0){
			parent.document.getElementById(objid).value="";
			parent.document.getElementById(objname).value="";
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
		var deptype = document.getElementById("deptype").value;
		var objidValue="",objnameValue="";
		if(deptype == 1 || deptype == 0){
			var a = document.getElementsByName("selectNodeSzx");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					objnameValue += document.getElementById("dname_"+a[i].value).innerText.replace(/(^\s*)|(\s*$)/g, "")+ ",";
				}
			}
		}
		if(deptype == 6 || deptype == 0){
			var a = document.getElementsByName("selectNodeSsbk");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					objnameValue += document.getElementById("dname_"+a[i].value).innerText.replace(/(^\s*)|(\s*$)/g, "")+ ",";
				}
			}
			
			var a = document.getElementsByName("selectNodeGzgz");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					objnameValue += document.getElementById("dname_"+a[i].value).innerText.replace(/(^\s*)|(\s*$)/g, "")+ ",";
				}
			}
			
			var a = document.getElementsByName("selectNodeSzssgx");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					objnameValue += document.getElementById("dname_"+a[i].value).innerText.replace(/(^\s*)|(\s*$)/g, "")+ ",";
				}
			}
			var a = document.getElementsByName("selectNodeCrgx");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					objnameValue += document.getElementById("dname_"+a[i].value).innerText.replace(/(^\s*)|(\s*$)/g, "")+ ",";
				}
			}
		}
		if(deptype == 7 || deptype == 0 || deptype == 20 ){
			var a = document.getElementsByName("selectNodeSz");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					objnameValue += document.getElementById("dname_"+a[i].value).innerText.replace(/(^\s*)|(\s*$)/g, "")+ ",";
				}
			}
			var a = document.getElementsByName("selectNodeX");
			for (var i = 0; i < a.length; i++) {
				if (a[i].checked) {
					objidValue += a[i].value + ",";
					objnameValue += document.getElementById("dname_"+a[i].value).innerText.replace(/(^\s*)|(\s*$)/g, "")+ ",";
				}
			}
		}
		
		if(document.getElementById("type").value=="dtbd"){
			if(document.getElementById("selectAll")){
				if(document.getElementsByName("selectAll")[0].checked){
					objidValue="";
					objnameValue="";
				}
			}else{
				if(document.getElementsByName("selectAllSsbk")[0].checked){
					objidValue="";
					objnameValue="";
				}
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
	function postNoDeparts(){
		var deptype = document.getElementById("deptype").value;
		parent.document.getElementById(objid).value="";
		parent.document.getElementById(objname).value="";
		document.getElementById("selectAll").checked = false;
		doSelectAll();
	}
	function initData(){
        var objid = parent.tem_valueObjid;
        var objname = parent.tem_nameObjid;
		var objidValue=parent.document.getElementById(objid).value;
		var objnameValue=parent.document.getElementById(objname).value;
		var v = objidValue.split(",");
		var deptype = document.getElementById("deptype").value;
		if(deptype == 1 || deptype == 0){
			var a = document.getElementsByName("selectNodeSzx");
			for (var i = 0; i < v.length; i++) {
				for(var j = 0; j < a.length; j++){
					if (a[j].value==v[i]) {
						a[j].checked=true;
					}
				}
				
			}
		}
		if(deptype == 6 || deptype == 0){
			var a = document.getElementsByName("selectNodeSsbk");
			for (var i = 0; i < v.length; i++) {
				for(var j = 0; j < a.length; j++){
					if (a[j].value==v[i]) {
						a[j].checked=true;
					}
				}
				
			}
			var a = document.getElementsByName("selectNodeGzgz");
			for (var i = 0; i < v.length; i++) {
				for(var j = 0; j < a.length; j++){
					if (a[j].value==v[i]) {
						a[j].checked=true;
					}
				}
				
			}
			var a = document.getElementsByName("selectNodeSzssgx");
			for (var i = 0; i < v.length; i++) {
				for(var j = 0; j < a.length; j++){
					if (a[j].value==v[i]) {
						a[j].checked=true;
					}
				}
				
			}
			var a = document.getElementsByName("selectNodeCrgx");
			for (var i = 0; i < v.length; i++) {
				for(var j = 0; j < a.length; j++){
					if (a[j].value==v[i]) {
						a[j].checked=true;
					}
				}
				
			}
		}
		if(deptype == 7 || deptype == 0 || deptype == 20 ){
			var a = document.getElementsByName("selectNodeSz");
			for (var i = 0; i < v.length; i++) {
				for(var j = 0; j < a.length; j++){
					if (a[j].value==v[i]) {
						a[j].checked=true;
					}
				}
				
			}
			var a = document.getElementsByName("selectNodeX");
			for (var i = 0; i < v.length; i++) {
				for(var j = 0; j < a.length; j++){
					if (a[j].value==v[i]) {
						a[j].checked=true;
					}
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

	/**
	 * 全选
	 */
	function doSelectAll(){
		var deptype = document.getElementById("deptype").value;
		var parentChecked = document.getElementsByName("selectAll")[0].checked;
		if(deptype == 1 || deptype == 0){
			//省中心
			document.getElementsByName("selectAllSzx")[0].checked = parentChecked;
			doSelect('selectAllSzx','selectNodeSzx');
		}
		if(deptype == 6 || deptype == 0){
			//省属本科
			document.getElementsByName("selectAllSsbk")[0].checked = parentChecked;
			doSelect('selectAllSsbk','selectNodeSsbk');
			//高职高专
			document.getElementsByName("selectAllGzgz")[0].checked = parentChecked;
			doSelect('selectAllGzgz','selectNodeGzgz');
			//市州所属高校
			document.getElementsByName("selectAllSzssgx")[0].checked = parentChecked;
			doSelect('selectAllSzssgx','selectNodeSzssgx');
			//成人高校
			document.getElementsByName("selectAllCrgx")[0].checked = parentChecked;
			doSelect('selectAllCrgx','selectNodeCrgx');
		}
		if(deptype == 7 || deptype == 0 || deptype == 20 ){
			//市
			document.getElementsByName("selectAllSz")[0].checked = parentChecked;
			doSelect('selectAllSz','selectNodeSz');
			//区县
			document.getElementsByName("selectAllX")[0].checked = parentChecked;
			doSelect('selectAllX','selectNodeX');
		}
	}
	function doSelect(obj,sel){
	    var parentChecked = document.getElementsByName(obj)[0].checked;
	    var nodes = document.getElementsByName(sel);
	    for (var i = 0; i < nodes.length; i++) {
	        var node = nodes[i];
	        node.checked = parentChecked;
	    }
	}
	</script>
  	<base target="_self">
  </head>
	<body > 
		<div id="listC" style="width:98%;margin:10px auto">
			<s:form theme="simple" name="theform">
				<s:hidden name="pager.formname" value="theform" />
				<s:hidden name="tsysDepart.departtype" id="departtype"/>
				<s:hidden name="ids" id="ids" value="%{#parameters.ids[0]}" />
				<s:hidden name="userId" id="userId" value="%{#parameters.userId[0]}" />	
				<s:hidden name="addressList" value="%{#parameters.addressList[0]}" id="addressList"/>
				<s:hidden name="depid" value="%{#parameters.depid[0]}" id="depid"/>
				<s:hidden name="sfzj" value="%{#parameters.sfzj[0]}" />
				<s:hidden name="deptype" value="%{#parameters.deptype[0]}" />
				<s:hidden name="type" id="type" value="%{#parameters.type[0]}" />
				    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
	 <!-- <tr>
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
	  </tr> --> 
    </table>
    
        <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%" class="maginB">
			<tr align="center">
				
			</tr>
	</table>
	<!-- addressList为通讯录专用,其他模块为空 -->
		<s:if test="#parameters==null||#parameters.addressList==null||#parameters.addressList[0]!=1">
		<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%" align="center">
			<tr>
			    <td height="30px">
				   <ul class="btn_gn">
					<li><a href="#" title=" 确定" onClick="postDeparts()"><span> 确定</span></a></li>
					<li ><a href="#" title="取消" onClick="parent.closeInputWindow()"><span>取消</span></a></li>		 
					<!--<li id="adddeparts"  style="display:none"><s:if test="#parameters.sfzj[0]== 1"></s:if><s:else><a href="#" title="追加" onClick="addDeparts()"><span>追加</span></a></s:else></li>
					<li><a href="#" title="清除已选" onClick="postNoDeparts()"><span>清除已选</span></a></li> -->
				   </ul>
			     </td>    
			 </tr>
		</table>
		</s:if>
	  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB" >
	  <tr>
	    <td>
		<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="10">&nbsp;</td>
	      </tr>
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>
				<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" align="center"  class="middle">
					<!-- 省中心 -->
					<s:if test="#parameters.deptype[0] == 1 || #parameters.deptype[0] == 0 ">
						<thead id="listHead">
							 <tr>
								<td colspan="10" align="left"><s:checkbox name="selectAll" id="selectAll" onclick="doSelectAll()"/><b>全选</b></td>
							</tr>
						</thead>
						<tbody id="listData">
							 
							<tr><td align="left"><s:checkbox name="selectAllSzx" id="selectNode" onclick="doSelect('selectAllSzx','selectNodeSzx')"/><b>省中心</b></td></tr> 
							<s:iterator value="listSzx" status="stat">
							<s:if test="%{#stat.index%3==0}"><tr></tr></s:if>
								<td id="dname_${departnamePy}" align="left"><s:checkbox id="%{departnamePy}" name="selectNodeSzx" fieldValue="%{departnamePy}"/>
						 			<s:property value="departname" />
						 		</td>
							</s:iterator>
						</tbody>
					</s:if>
					<!-- 高校 -->
					<s:if test="#parameters.deptype[0] == 6 || (#parameters.deptype[0] == 0 && depart.departtype!=7) ">
						<s:if test="#parameters.deptype[0] == 6 && ISHUNAN">
						<thead id="listHead">
							<tr>
								<td colspan="10" align="left"><s:checkbox name="selectAll" id="selectAll" onclick="doSelectAll()"/><b>全选</b></td>
							</tr>
						</thead>
						</s:if>
						<tbody id="listData">
							<s:if test="ISHUNAN">
								<tr><td align="left"><s:checkbox name="selectAllSsbk" id="selectNode" onclick="doSelect('selectAllSsbk','selectNodeSsbk')"/><b>省属本科</b></td></tr></s:if>
							<s:else>
								<tr><td align="left"><s:checkbox name="selectAllSsbk" id="selectNode" onclick="doSelect('selectAllSsbk','selectNodeSsbk')"/><b>全选</b></td></tr>
							</s:else>
							<s:iterator value="listSsbk" status="stat">
							<s:if test="%{#stat.index%3==0}"><tr></tr></s:if>
								<td id="dname_${departid}" align="left"><s:checkbox id="%{departid}" name="selectNodeSsbk" fieldValue="%{departid}"/>
						 			<s:property value="departname" />
						 		</td> 
					 		</s:iterator>
					 		<s:if test="ISHUNAN">
					 		<tr><td align="left"><s:checkbox name="selectAllGzgz" id="selectNode" onclick="doSelect('selectAllGzgz','selectNodeGzgz')"/><b>省属高职高专</b></td></tr>
							<s:iterator value="listSsgzgz" status="stat">
							<s:if test="%{#stat.index%3==0}"><tr></tr></s:if>
								<td id="dname_${departid}" align="left"><s:checkbox id="%{departid}" name="selectNodeGzgz" fieldValue="%{departid}"/>
						 			<s:property value="departname" />
						 		</td> 
					 		</s:iterator>
					 		<tr><td align="left"><s:checkbox name="selectAllSzssgx" id="selectNode" onclick="doSelect('selectAllSzssgx','selectNodeSzssgx')"/><b>市州所属高校</b></td></tr>
							<s:iterator value="listSzssgx" status="stat">
							<s:if test="%{#stat.index%3==0}"><tr></tr></s:if>
								<td id="dname_${departid}" align="left"><s:checkbox id="%{departid}" name="selectNodeSzssgx" fieldValue="%{departid}"/>
						 			<s:property value="departname" />
						 		</td> 
					 		</s:iterator>
					 		<tr><td align="left"><s:checkbox name="selectAllCrgx" id="selectNode" onclick="doSelect('selectAllCrgx','selectNodeCrgx')"/><b>成人高校</b></td></tr>
							<s:iterator value="listCrgx" status="stat">
							<s:if test="%{#stat.index%3==0}"><tr></tr></s:if>
								<td id="dname_${departid}" align="left"><s:checkbox id="%{departid}" name="selectNodeCrgx" fieldValue="%{departid}"/>
						 			<s:property value="departname" />
						 		</td> 
					 		</s:iterator>
					 		</s:if>
						</tbody>
					</s:if>
					<!-- 市县 -->
					<s:if test="#parameters.deptype[0] == 7 || #parameters.deptype[0] == 20 ||(#parameters.deptype[0] == 0 && depart.departtype!=6) ">
						<s:if test="#parameters.deptype[0] == 7 || #parameters.deptype[0] == 20">
						<thead id="listHead">
							<tr>
								<td colspan="10" align="left"><s:checkbox name="selectAll" id="selectAll" onclick="doSelectAll()"/><b>全选</b></td>
							</tr>
						</thead>
						</s:if>
						<tbody id="listData">
							<tr><td align="left"><s:checkbox name="selectAllSz" id="selectNode" onclick="doSelect('selectAllSz','selectNodeSz')"/><b>市州</b></td></tr>
							<s:iterator value="listSz" status="stat">
								<s:if test="%{#stat.index%3==0}"><tr></tr></s:if>
								<td id="dname_${departid}" align="left"><s:checkbox id="%{departid}" name="selectNodeSz" fieldValue="%{departid}"/>
						 			<s:property value="departname" />
						 		</td>
					 		</s:iterator>
					 		<s:if test="#qxxs == 'qxxs'.toString()">
						 		<tr><td align="left"><s:checkbox name="selectAllX" id="selectNode" onclick="doSelect('selectAllX','selectNodeX')"/><b>区县</b></td></tr>
								<s:iterator value="listX" status="stat">
									<s:if test="%{#stat.index%3==0}"><tr></tr></s:if>
									<td id="dname_${departid}" align="left"><s:checkbox id="%{departid}" name="selectNodeX" fieldValue="%{departid}"/>
							 			<s:property value="departname" />
							 		</td>
						 		</s:iterator>
					 		</s:if>
						</tbody>
					</s:if>
				</table> 
				 </td>
	        </tr>
	    </table>
		</td>
	  </tr>
	</table>
				<!-- 
				<table border="0" cellspacing="0" cellpadding="0" width="100%">
					<tr>
					     <td colspan="10" align="right"><s:property value="pager.postToolBar" escape="false" /></td>
					</tr>
				</table> -->
			</s:form>
		</div>
	</body>
</html>

