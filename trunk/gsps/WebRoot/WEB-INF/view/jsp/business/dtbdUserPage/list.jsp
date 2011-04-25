<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script type="text/javascript"
			src="<s:property value="basePath"/>/dwr/engine.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/dwr/util.js"></script>
		<link rel="stylesheet"
			href="<s:property value="basePath"/>/resources/css/webface.css"
			type="text/css">
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
   <script type="text/javascript">
   listPageStyle();

   //公共的辅助参数
	function doreset(){
		document.forms[0].reset();
	}
	//最底层数据的提交
	function handin(){
		var conf = window.confirm("您确定将数据批量提交?");
		if(conf==true){
			var shzt_name = document.getElementsByName("shzt_name");
			//两层数据标识
	    	var twoCeng = document.getElementById("twoCeng");
			var tt = []; 
			var tt2 = []; 
			if(twoCeng.value=='1'){
				for(var i=0; i<shzt_name.length; i++){
					var shzt_nameVal =trim(shzt_name[i].value); 
					if(shzt_nameVal == "草稿" || shzt_nameVal == "省中心退回"){
					}else{
						alert("其中包含 '"+shzt_nameVal+"' 的数据，不允许提交！");
						return false;
					}
				}
			}else{
				for(var i=0; i<shzt_name.length; i++){
					var shzt_nameVal =trim(shzt_name[i].value); 
					if(shzt_nameVal == "草稿" || shzt_nameVal == "市县审核退回" || shzt_nameVal == "高校审核退回"){
					}else{
						alert("其中包含 '"+shzt_nameVal+"' 的数据，不允许提交！");
						return false;
					}
				}
			}
			
		var action_hz = document.getElementById("action_hz");
		var filed_hz = document.getElementById("filed_hz");
		var departid = document.getElementById("thisdepartid");
		var mytitle = document.getElementById("mytitle");
		var tableName = document.getElementById("tableName");
		var checkbox_selectNode = document.getElementById("checkbox_selectNode");
    	var cd = document.getElementsByTagName("input");
    	var tjshgz = document.getElementsByTagName("tjshgz");

		
		
			var type = document.getElementById("userType");
			ajaxService.dtbdSH(tableName.value,type.value,departid.value,filed_hz.value,action_hz.value,tjshgz.value,function (data){
					alert(data);
					document.forms[0].submit();
					return false;
				}
					);
	}}
	//退回
	function toback(){
		var conf = window.confirm("您确定将你选择的信息退回?");
		if(conf==true){
		var mytitle = document.getElementById("mytitle");
		var userType = document.getElementById("userType");
		var tableName = document.getElementById("tableName");
		var checkbox_selectNode = document.getElementById("checkbox_selectNode");
    	var cd = document.getElementsByTagName("input");
    	var tjshgz = document.getElementById("tjshgz");
    	var tt = []; 
		for(var i=0; i<cd.length; i++){
			if(cd[i].type=="checkbox" && mytitle != cd[i] && cd[i].checked){
				tt[tt.length] = cd[i].value;
			}
		}
		if(tt.length >0 && tableName.value != null && tableName.value != ''){
			
			var action_hz = document.getElementById("action_hz");
			var filed_hz = document.getElementById("filed_hz");
			for(var i=0;i<tt.length;i++){
				var shzt_val = trim(document.getElementById("shzt_"+tt[i]).value);
				if(userType.value!='1'){
					if(shzt_val=='待高校审核' || shzt_val=='待市县审核'||shzt_val=='市县审核通过'||shzt_val=='高校审核通过'||shzt_val=='省中心退回'){
					}else{
						alert("其中包含 '"+shzt_val+"' 的数据，不允许退回！");
						return false;
					}
				}else if(shzt_val=='审核通过' || shzt_val=='高校待省中心审核'||shzt_val=='市县待省中心审核'){
				}else{
						alert("其中包含 '"+shzt_val+"' 的数据，不允许退回！");
						return false;
				}
			}
			var type = document.getElementById("userType");
				ajaxService.dtbdTH(tableName.value,tt,type.value,filed_hz.value,action_hz.value,tjshgz.value,function (data){
					alert(data);
					document.forms[0].submit();
					return false;
					}
					);
		}else{
			alert("请勾选要操作的记录!");
		}
		}
	}
	//第二层数据   通过操作
	function shtg(){
		var conf = window.confirm("您确定将你选择的信息审核通过?");
		if(conf==true){
		var mytitle = document.getElementById("mytitle");
		var tableName = document.getElementById("tableName");
		var checkbox_selectNode = document.getElementById("checkbox_selectNode");
    	var cd = document.getElementsByTagName("input");
    	var action_hz = document.getElementById("action_hz");
		var filed_hz = document.getElementById("filed_hz");
		var tjshgz = document.getElementById("tjshgz");
    	var tt = []; 
		for(var i=0; i<cd.length; i++){
			if(cd[i].type=="checkbox" && mytitle != cd[i] && cd[i].checked){
				tt[tt.length] = cd[i].value;
			}
		}
		if(tt.length >0 && tableName.value != null && tableName.value != ''){
			var type = document.getElementById("userType");
			for(var i=0;i<tt.length;i++){
				var shzt_nameVal = document.getElementById("shzt_"+tt[i]).value;
				if(shzt_nameVal == "市县审核通过" || shzt_nameVal == "高校审核通过"||shzt_nameVal == "市县待省中心审核"||shzt_nameVal == "高校待省中心审核"||shzt_nameVal=='草稿'||shzt_nameVal=='审核通过'){
					alert("其中包含 '"+shzt_nameVal+"' 的数据，不允许通过审核！");
					return false;
				}
			}
				ajaxService.dtbd_Shtg(tableName.value,tt,type.value,filed_hz.value,action_hz.value,tjshgz.value,function (data){
					alert(data);
					document.forms[0].submit();
					return false;
				}
					);
			
		}else{
			alert("请勾选要操作的记录!");
		}
		}
	}
	//省中心 审核通
	function shtg2(){
		var conf = window.confirm("您确定将你选择的信息审核通过?");
		if(conf==true){
		var mytitle = document.getElementById("mytitle");
		var tableName = document.getElementById("tableName");
		var checkbox_selectNode = document.getElementById("checkbox_selectNode");
    	var cd = document.getElementsByTagName("input");
    	var action_hz = document.getElementById("action_hz");
		var filed_hz = document.getElementById("filed_hz");
		var tjshgz = document.getElementById("tjshgz");
    	var tt = []; 
		for(var i=0; i<cd.length; i++){
			if(cd[i].type=="checkbox" && mytitle != cd[i] && cd[i].checked){
				tt[tt.length] = cd[i].value;
			}
		}
		if(tt.length >0 && tableName.value != null && tableName.value != ''){
			var type = document.getElementById("userType");
			for(var i=0;i<tt.length;i++){
				var shzt_nameVal = document.getElementById("shzt_"+tt[i]).value;
				if(shzt_nameVal == "审核通过"||shzt_nameVal=='草稿'){
					alert("其中包含 '"+shzt_nameVal+"' 的数据，不允许通过审核！");
					return false;
				}
			}
				ajaxService.dtbd_Shtg(tableName.value,tt,type.value,filed_hz.value,action_hz.value,tjshgz.value,ajaxBackString);
		}else{
			alert("请勾选要操作的记录!");
		}
		}
	}

	function ajaxBackString(result){
		alert(result);
		document.forms[0].submit();
	}
	//第二层数据提交 操作
	function handin2(){
		var conf = window.confirm("您确定将数据批量提交?");
		if(conf==true){
		var shzt_name = document.getElementsByName("shzt_name");
		var tt = []; 
		var tt2 = []; 
		var twoCeng = document.getElementById("twoCeng");
		if(twoCeng.value=='1'){
			for(var i=0; i<shzt_name.length; i++){
				var shzt_nameVal =trim(shzt_name[i].value); 
				if(shzt_nameVal == "草稿" || shzt_nameVal == "省中心退回"){
					
				}else{
					alert("其中包含 '"+shzt_nameVal+"' 的数据，不允许提交审核！");
					return false;
				}
			}
		}else{
				for(var i=0; i<shzt_name.length; i++){
					var shzt_nameVal =trim(shzt_name[i].value); 
					if(shzt_nameVal == "市县审核通过" || shzt_nameVal == "高校审核通过"){
					
					}else{
						alert("其中包含 '"+shzt_nameVal+"' 的数据，不允许提交审核！");
						return false;
					}
				}

		}
		
		var departid = document.getElementById("thisdepartid");
		var mytitle = document.getElementById("mytitle");
		var tableName = document.getElementById("tableName");
		var checkbox_selectNode = document.getElementById("checkbox_selectNode");
    	var cd = document.getElementsByTagName("input");
    	var action_hz = document.getElementById("action_hz");
		var filed_hz = document.getElementById("filed_hz");
			var type = document.getElementById("userType");
			var tjshgz = document.getElementById("tjshgz");
			ajaxService.dtbdSH2(tableName.value,type.value,departid.value,filed_hz.value,action_hz.value,tjshgz.value,function (data){
					alert(data);
					document.forms[0].submit();
					return false;
				}
					);
		
		}
	}
	function trim(str){  //删除左右两端的空格    
		 return str.replace(/(^\s*)|(\s*$)/g, "");    
		} 

	function update(){
		var mytitle = document.getElementById("mytitle");
		var userType = document.getElementById("userType");
		var tableName = document.getElementById("tableName");
		var checkbox_selectNode = document.getElementById("checkbox_selectNode");
    	var cd = document.getElementsByTagName("input");
    	var tt = []; 
		for(var i=0; i<cd.length; i++){
			if(cd[i].type=="checkbox" && mytitle != cd[i] && cd[i].checked){
				tt[tt.length] = cd[i].value;
			}
		}
		if(tt.length==1){
				input(tt[0],'','tableName='+tableName.value,'');
		}else{
			alert('请勾选一条记录！');
		}

		
	}


	//汇总表初始化
	function hzInit(){
		var init_type =  document.getElementById("init_type").value;
		var bbnd =  document.getElementById("bbnd").value;
		var bbyf =  document.getElementById("bbyf").value;
		var tableName =  document.getElementById("tableName").value;
		ajaxService.init_dtbd(bbnd,bbyf,init_type,tableName,function (data){
			alert(data);
			document.forms[0].submit();
			return false;
		}
			);
		
	}
	
	function openPage(uri){
		openWindow(uri,1000,450);
	}

	function getforward(wid){
		var tableName =  document.getElementById("tableName").value;
		openPage("../business/dtbdUserPage-input.c?wid="+wid+"&tableName="+tableName);
	}
	function xinzen(){
		var tableName =  document.getElementById("tableName").value;
		var bbnd =  document.getElementById("bbnd").value;
		var bbyf =  document.getElementById("bbyf").value;
		input('','','tableName='+tableName+'&bbnd='+bbnd+'&bbyf='+bbyf,'');
	}
	function submitRemove(){
		var conf = window.confirm("您确定要删除已选中的这些数据吗？");
		if(conf==true){
			var tableName =  document.getElementById("tableName").value;
			var ids = CropCheckBoxValueAsString("selectNode");
			if(ids.length>0){
				var url_bak = document.forms[0].action;
				var url = actionName + "-remove.c?tableName="+tableName;
				$.post(url,
				       { wid: ids, reqtime: (new Date()).getTime() },
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
	</script>
		<base target="_self">
	</head>

	<body>
	
	
	
		<s:if
			test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
		</s:if>
	<div id="listC" style="text-align:center;">
			<s:form theme="simple" name="theform">
				<s:hidden name="pager.formname" value="theform" />
				<s:hidden name="tablewid" value="%{tablewid==null?#parameters.tablewid[0]:tablewid}" />
				<s:hidden name="userid" id="userid"/>
				<input type="hidden" id="userType" value="<s:property value='userType' />" />
				<input type="hidden" id="tableName" name="tableName" value="<s:property value="tableName" />" />
				<input type="hidden" name="departid"  value="<s:property value="departid" />" />
				<input type="hidden" id="thisdepartid"  value="<s:property value="getDepartID()" />" />
				<input type="hidden" name="tablewid"  value="<s:property value="tablewid" />" />
				<input type="hidden" id="init_type" value="<s:property value="init_type" />" />
				<input type="hidden" id="bbnd" value="<s:property value="bbnd" />" />
				<input type="hidden" id="bbyf" value="<s:property value="bbyf" />" />
				<input type="hidden" id="filed_hz" value="<s:property value="filed_hz" />" />
				<input type="hidden" id="action_hz" value="<s:property value="action_hz" />" />
				<input type="hidden" id="tjshgz" value="<s:property value="tjshgz" />" />
				<input type="hidden" id="twoCeng" value="<s:property value="twoCeng" />" />
				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="maginB">
					<tr>
						<td>
							<table width="100%" border="0" align="center" cellpadding="0"
								cellspacing="0" class="maginB">
								<tr>
									<td>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" align="left" cellpadding="0"
								cellspacing="0" class="maginB">
								<tr>
									<td class="chaxunleftt">

										<table id="searchForm" border="0" align="center" cellspacing="3"
								cellpadding="0" width="100%">
								<tr align="left" >
									<td>
										&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;度：&nbsp;&nbsp;<s:select name="s_nd" id="nd" list="getNd(#tableName,getDepart().getDeparttype(),#romait)" 
											listKey="id" listValue="caption" />
											<s:if test="bbyf != null && bbyf != ''">
												&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;份：&nbsp;&nbsp;<s:select name="s_yf" id="yf" list="getSysCode('bbyf')" 
													listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
											</s:if>
										<s:if test="#searchType!=1">
												&nbsp;&nbsp;&nbsp;&nbsp;填报部门：<input type="text" name="DWBM"  value="<s:property value='DWBM' />" id="dtbdFieldInfo_DWBM" />
												&nbsp;&nbsp;&nbsp;&nbsp;提交时间：<input type="text" name="TJSJ"  value="<s:property value='TJSJ' />" id="dtbdFieldInfo_DWBM" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"  /><BR />
												&nbsp;&nbsp;&nbsp;&nbsp;审核时间：<input type="text" name="SHSJ"  value="<s:property value='SHSJ' />" id="dtbdFieldInfo_DWBM" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"  />
												
										</s:if><s:else>
										<s:iterator value="getList_DTBDFieldInfo_Select()" status="stuts">
											<s:if test="#stuts.index%2==0 &&#stuts.index!=0 ">
												<s:if test="fieldName!='shzt'" >
													&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="fieldDisplayName"/>：
												  <s:if test="fieldType==2">
												  	<select id="dtbdFieldInfo_<s:property value='fieldName' />" name="<s:property value='fieldName' />" style="width:100px">
									    				<option value="">--请选择--</option>
									    				<s:iterator value="%{getSysCode(fieldDefine)}"  status="stuts" id="p">
									  						<s:if test="#map.get(fieldName) == id">
									    						<option value="<s:property value='id' />" selected="selected"><s:property value='caption' /></option>
									  						</s:if>
									  						<s:else>
									    						<option value="<s:property value='id' />"><s:property value='caption' /></option>
									    					</s:else>
									  					</s:iterator>
									  				</select><br />
												  </s:if>
												  <s:else>
													<input type="text" name="<s:property value='fieldName'/>" value="<s:property value='#map.get(fieldName)'/>" id="dtbdFieldInfo_<s:property value="fieldName"/>" /><br />
												  </s:else>
												</s:if>
												
											</s:if>
											<s:else>
												<s:if test="fieldName!='shzt'" >
													&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="fieldDisplayName"/>：
													<input type="text" name="<s:property value='fieldName'/>"  value="<s:property value='#map.get(fieldName)'/>" id="dtbdFieldInfo_<s:property value="fieldName"/>" />
												</s:if>
											</s:else>
											
										</s:iterator>
										</s:else>
										
									<s:if test="#shzt_display==1">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<s:if test="#twoCeng==1">
												<s:if test="getDepart().getDeparttype()==7">
												 审核状态：<s:select name="shzt" id="shzt_select" value="#map.get('shzt')" list="#{'':'--请选择--','none':'未开始','7':'市县待省中心审核','9':'审核通过','-9':'省中心退回','1':'草稿'}"/>
												</s:if>
												<s:elseif test="getDepart().getDeparttype()==6">
												审核状态：<s:select name="shzt" id="shzt_select" value="#map.get('shzt')" list="#{'':'--请选择--','none':'未开始','8':'高校待省中心审核','9':'审核通过','-9':'省中心退回','1':'草稿'}"/>
												</s:elseif>
												<s:else>
													<s:if test="#romait2==7">
														 审核状态：<s:select name="shzt" id="shzt_select" value="#map.get('shzt')" list="#{'':'--请选择--','none':'未开始','7':'市县待省中心审核','9':'审核通过','-9':'省中心退回'}"/>
													</s:if>
													<s:elseif test="#romait2==6">
														审核状态： <s:select name="shzt" id="shzt_select" value="#map.get('shzt')" list="#{'':'--请选择--','none':'未开始','8':'高校待省中心审核','9':'审核通过','-9':'省中心退回'}"/>
													</s:elseif>
												
												</s:else>
											
											</s:if>
											<s:else>
												<s:if test="getDepart().getDeparttype()==8">
												 审核状态：<s:select name="shzt" id="shzt_select" value="#map.get('shzt')" list="#{'':'--请选择--','none':'未开始','3':'待高校审核','5':'高校审核通过','-5':'高校审核退回','8':'高校待省中心审核','9':'审核通过','-9':'省中心退回','1':'草稿'}"/>
													</s:if>
												<s:elseif test="getDepart().getDeparttype()==9">
												 审核状态：<s:select name="shzt" id="shzt_select" value="#map.get('shzt')" list="#{'':'--请选择--','none':'未开始','3':'待高校审核','5':'高校审核通过','-5':'高校审核退回','8':'高校待省中心审核','9':'审核通过','-9':'省中心退回','1':'草稿'}"/>
													</s:elseif>
												<s:else>
													<s:if test="#romait2==7">
														 审核状态：<s:select name="shzt" id="shzt_select" value="#map.get('shzt')" list="#{'':'--请选择--','none':'未开始','3':'待高校审核','5':'高校审核通过','-5':'高校审核退回','8':'高校待省中心审核','9':'审核通过','-9':'省中心退回'}"/>
													
													</s:if>
													<s:elseif test="#romait2==6">
														 审核状态：<s:select name="shzt" id="shzt_select" value="#map.get('shzt')" list="#{'':'--请选择--','none':'未开始','3':'待高校审核','5':'高校审核通过','-5':'高校审核退回','8':'高校待省中心审核','9':'审核通过','-9':'省中心退回'}"/>
													
													</s:elseif>
												
												</s:else>
													
											</s:else>
											
											<br />
											</s:if>
									
									</td>
									<td><ul class="btn_gn">
									<li>
											<a href="#" title="查询" onClick="super_doSearch()"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
										</li>
										<li>
											<a href="#" title="重置" onClick="doreset();"
												id="searchButton2" name="btn4"><span> 重置 </span>
											</a>
										</li>
									</ul></td>
								</tr>
							</table>

									</td>
									<td width="15" height="75" class="chaxunrightt">
										&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr height="25" align="left">  <td colspan="10"><s:if test="#cxhz!=null">&nbsp;&nbsp;&nbsp;<b>本次查询数据为:</b><s:property value="cxhz" /></s:if></td></tr>
					<tr>
						<td>
							<table id="buttonTable" border="0" cellspacing="3"
								cellpadding="0" width="100%">
								<tr>
									<td height="30px" colspan="10">
									<s:if test="#departid==null || #departid=='' " >
							<ul class="btn_gn">
								<s:if test="getDepart().getDeparttype()==#romait.toString()">
								<s:if test="#creat_display==1" >
									<li><a href="#" title="新增" onClick="xinzen()" name="auditRows"><span>新增</span></a></li>
								</s:if><s:else>
									<li class="btn_gn_disable"><a href="#" title="新增" onClick="alert('管理员未初始化年度数据，不能填报！')" name="auditRows"><span>新增</span></a></li>
								</s:else>
								
								<li><a href="#" title="修改" onClick="update()" name="modifyt"><span>修改</span> </a></li>
								<li><a href="#" title="删除" onClick="submitRemove()" name="exportData"><span>删除</span> </a></li>
								<s:if test="#twoCeng==1">
									<li><a href="#" title="提交审核" onClick="handin2()" name="exportData"><span>提交审核</span> </a></li>
								</s:if><s:else>
									<li><a href="#" title="提交审核" onClick="handin()" name="exportData"><span>提交审核</span> </a></li>
								</s:else>
								
								</s:if><s:elseif test="getDepart().getDeparttype()==1&&#romait!=null">
									<li><a href="#" title="年度初始化" onClick="hzInit()" name="exportData"><span>年度初始化</span> </a></li>
									<li><a href="#" title="审核通过" onClick="shtg2()" name="exportData"><span>审核通过</span> </a></li>
									<li><a href="#" title="退回" onClick="toback()" name="exportData"><span>审核退回</span> </a></li>
									<li><a href="#" title="打印汇总报表"  name="exportData"><span>打印汇总统计报表</span> </a></li>
								</s:elseif><s:elseif test="#romait.toString()!=getDepart().getDeparttype().toString() && getDepart().getDeparttype()!=8 && getDepart().getDeparttype()!=9">
									<li><a href="#" title="审核通过" onClick="shtg()" name="exportData"><span>审核通过</span> </a></li>
									<li><a href="#" title="退回" onClick="toback()" name="exportData"><span>审核退回</span> </a></li>
									<li><a href="#" title="提交审核" onClick="handin2()" name="exportData"><span>提交审核</span> </a></li>
									<li><a href="#" title="打印汇总报表"  name="exportData"><span>打印汇总报表</span> </a></li>
								</s:elseif>
								
							</ul>
							</s:if>
						</td>

								</tr>

							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" align="center" cellpadding="0"
								cellspacing="0" class="maginB">
								<tr>
									<td class="infomainbg">


										<table class="middle" width="100%" border="0" cellspacing="0"
											cellpadding="0">
											<tr>
												<td width="10">
													&nbsp;
												</td>
												<td>
													&nbsp;
												</td>
											</tr>
											<tr>
												<td width="10">
													&nbsp;
												</td>
												<td>

													<table id="listTable" border="0" cellspacing="0"
											cellpadding="0" width="100%" class="middle">

											<thead id="listHead">
												<tr>
													<%int j=0;
														int i=0;
													%>
													<s:if test="getList_DTBDFieldInfo_TableHead()!=null && getList_DTBDFieldInfo_TableHead().size()>0" >
													<th width="4%">
															<s:checkbox name="selectAll" id="mytitle" onclick="doSelectAll()" /></th>
													<s:iterator value="getList_DTBDFieldInfo_TableHead()" status="stuts">	
														<th width="<s:property value="fieldWidth"/>%" style="text-align: center"><s:property value="fieldDisplayName"/></th>
															<%i++; %>
														<s:if test="fieldDisplayName=='审核状态'">
															<% j=i; %>
														</s:if>
													</s:iterator>
													</s:if>
													<th align="center">操作</th>
												</tr>
											</thead>
											<tbody id="listData">
												
												<s:iterator value="resultData" status="stuts">
												<%int k=0; %>
													<tr>
															<s:iterator value="data_size" status="sy">
															
																
																<s:if test="#sy.index==0">
																	<td>
																		&nbsp;<s:checkbox id="%{resultData[#stuts.index][0]}" name="selectNode" fieldValue="%{resultData[#stuts.index][0]}" />
																		
																	</td>
																</s:if>
																<s:else>
																	<td>
																   		<%if(k==j){
																		%>
																		<s:if test="resultData[#stuts.index][#sy.index]==null || resultData[#stuts.index][#sy.index]==''.toString()">
																			未开始
																		</s:if>
																		<s:else>
																			&nbsp;<s:property value="resultData[#stuts.index][#sy.index]"/>
																		</s:else>
																			<input type="hidden" name="shzt_name" id="shzt_<s:property value='resultData[#stuts.index][0]' />" value="<s:property value='resultData[#stuts.index][#sy.index]' />" />
																		<%	
																		}else{
																			%>
																			<s:if test="#sy.index==1">
																				<s:if test="resultData[#stuts.index][#sy.index]==null || resultData[#stuts.index][#sy.index]==''.toString()">
																			&nbsp;
																		</s:if>
																		<s:elseif test="getDepart().getDeparttype()!=1 || getDepart().getDeparttype()!=6||getDepart().getDeparttype()!=7">
																			<s:property value="resultData[#stuts.index][#sy.index]"/>
																		</s:elseif>
																			</s:if><s:else>
																			<s:if test="resultData[#stuts.index][#sy.index]==null || resultData[#stuts.index][#sy.index]==''.toString()">
																			&nbsp;
																		</s:if>
																		<s:else>
																			&nbsp;<s:property value="resultData[#stuts.index][#sy.index]"/>
																		</s:else>
																			</s:else>
																			
																			<%
																		}
																		%>
																   </td>
																</s:else>
																<%k++; %>
															</s:iterator>
															<s:if test="#view_model=='ss'.toString()">
																<td>
																<span style="cursor:pointer;color:blue"  onclick="openPage('../business/dtbdUserPage-list.c?departid=<s:property value='resultData[#stuts.index][0]' />&tableName=<s:property value='tableName' />')">查看明细</span>
															</td>
															</s:if>
															<s:else>
																<td>
																	<span style="cursor:pointer;color:blue"  onclick="getforward('<s:property value='resultData[#stuts.index][0]' />')">查看明细</span>
																</td>
															
															</s:else>
															
													</tr>
													
												</s:iterator>
											</tbody>
										</table>
												</td>
											</tr>
										</table>




									</td>
									<td width="10" class="infomainright">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td height="20" class="infobottomleft"></td>
									<td width="10" class="infobottomright"></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table border="0" cellspacing="0" cellpadding="0" width="100%">
								<tr>
									<td colspan="10" align="right">
										<s:property value="pager.postToolBar" escape="false" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>










			</s:form>
		</div>
	</body>
	
	
</html>

