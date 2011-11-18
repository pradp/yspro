<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

		<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
		<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
		<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>

	
   <script type="text/javascript">
function doreset(){
		document.getElementById('departid').value="";
		document.getElementById('departname').value="";
		document.getElementById('userloginid').value="";
		document.getElementById('departtype').value="";
	}
	listPageStyle();	

function  changePwd(){
			var slength = 0;
			var a = document.getElementsByName("selectNode");
			for (var i = 0; i < a.length; i++) {
			    if (a[i].checked) {
			        slength += 1;
			    }
			}
			if(slength==1){
				var ids = CropCheckBoxValueAsString("selectNode");
			    ajaxService.init_pwd(ids,ajaxBackString);
      		}else{
				alert("请勾选一条记录!");
			}
		function ajaxBackString(result){
			if(result){
				alert("初始化成功！");
				document.forms[0].submit();
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

<table  width="100%" border="0" align="center" cellpadding="0"	cellspacing="0" class="maginB">
<tr><td>	<table width="100%" border="0" align="left" cellpadding="0"
					cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleft">
							<table id="searchForm" border="0" align="center" cellspacing="3"
								cellpadding="0" width="100%">
								<tr align="center">
									<td align="right" nowrap="nowrap">
										&nbsp;&nbsp;&nbsp;部门编号：
									</td>
									<td align="left">
										<s:textfield name="departid" id="departid" maxlength="50"
											size="25" />
									</td>
									<td align="right" nowrap="nowrap">
										部门名称：
									</td>
									<td align="left">
										<s:textfield name="departname" id="departname" maxlength="50"
											size="25" />
									</td>
									<td align="right" nowrap="nowrap">
										登录帐号：
									</td>
									<td align="left">
										<s:textfield name="userloginid" id="userloginid" maxlength="50"
											size="25" />
									</td>
									<td align="right" nowrap="nowrap">
										部门类别：
									</td>
									<td align="left">
										<s:select name="departtype" id="departtype"
												list="getSysCode('bmlb')" headerKey=""
												headerValue="---请选择---"  listKey="id" listValue="caption"/>
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
						<td width="15" height="49" class="chaxunright">
							&nbsp;
						</td>
					</tr>
				</table></td></tr>
<tr><td>	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0"
					width="100%">

					<tr>
						<td height="30px" colspan="10">
							<ul class="btn_gn">
									<li>
										<a href="#" title="密码初始化" onClick="changePwd()" name="changePwd"><span>密码初始化</span></a>
									</li>
							</ul>
						</td>
					</tr>

				</table></td></tr>
<tr><td>		<table width="100%" border="0" align="center" cellpadding="0"
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
													<th height="20px" width="5%">
														<s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
													<th width="10%">
														部门编号
													</th>
													<th width="15%">
														部门名称
													</th>
													<th width="10%">
														部门类别
													</th>
													<th width="10%">
														登录帐号
													</th>
													<th width="15%">
														用户名
													</th>
													<th width="10%">
														用户编码
													</th>
												</tr>
											</thead>
											<tbody id="listData">
												<s:iterator value="resultData" status="stuts">
													<tr>
														<td>
															<s:checkbox id="%{resultData[#stuts.index][0]}"
																name="selectNode"
																fieldValue="%{resultData[#stuts.index][0]}" />
														</td>
														<td>
															&nbsp;<s:property value="resultData[#stuts.index][1]" />
														</td>
														<td>
															&nbsp;<s:property value="resultData[#stuts.index][2]" />
														</td>
														<td>
															&nbsp;<s:property value="resultData[#stuts.index][3]" />
														</td>
														<td>
															&nbsp;<s:property value="resultData[#stuts.index][4]" />
														</td>
														<td>
															&nbsp;<s:property value="resultData[#stuts.index][5]" />
														</td>
														<td>
															&nbsp;<s:property value="resultData[#stuts.index][6]" />
														</td>
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
				</table></td></tr>
				<tr><td><table border="0" cellspacing="0" cellpadding="0" width="100%">

					<tr>
						<td colspan="10" align="right">
							<s:property value="pager.postToolBar" escape="false" />
						</td>
					</tr>
				</table></td></tr>

				</table>
				
			</s:form>
		</div>
	</body>
</html>

