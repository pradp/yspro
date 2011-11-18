<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>list</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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

		<script type="text/javascript">
	listPageStyle();
	var mywid = '<s:property value="loginUser.userid"/>';
	function safeSubmitRemove(){
		var a = document.getElementsByName("selectNode");
	      for (var i = 0; i < a.length; i++) {
	          if (a[i].checked && a[i].value==mywid) {
	              alert("不能删除自己！");
	              return false;
	          }
	      }
		submitRemove();
	}
	</script>
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


				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleft">
							<table id="searchForm" border="0" align="center" cellspacing="3"
								cellpadding="0" width="100%">
								<tr align="center">
									<td align="center" nowrap="nowrap" class="">
										&nbsp;状态：
										<s:select id="state" name="tsysUser.state"
											list="#{'-1':'全部','1':'可用','0':'禁用'}" listKey="key"
											listValue="value" onchange="document.forms[0].submit()" />
									</td>
									<td align="center" nowrap="nowrap" class="">
										&nbsp;登录用户名：
										<s:textfield name="tsysUser.userLoginId" id="userLoginId"
											maxlength="50" size="10" />
									</td>
									<td align="center" nowrap="nowrap" class="">
										&nbsp;显示用户名称：
										<s:textfield name="tsysUser.userName" id="userName"
											maxlength="30" size="15" />
									</td>
									<td align="center" nowrap="nowrap" class="">
										&nbsp;所属部门：
										<s:textfield name="tsysUser.depart.departname" id="departname"
											maxlength="30" size="20" />
									</td>
									<td align="center" nowrap="nowrap">

										<ul class="btn_gn">
											<li>
												<a href="#" title="查询" onClick="super_doSearch()"
													id="searchButton" name="btn3"><span> 查询 </span>
												</a>
											</li>
										</ul>

									</td>
								</tr>
							</table>
						</td>
						<td width="15" height="49" class="chaxunright">
							&nbsp;
						</td>
					</tr>
				</table>

				<table id="searchForm" border="0" align="center" cellspacing="3"
					cellpadding="0" width="100%" class="maginB">
					<tr align="center">

					</tr>
				</table>
				<table id="buttonTable" border="0" cellspacing="3" cellpadding="0"
					width="100%">
					<tr>
						<td height="30px" colspan="10">

							<ul class="btn_gn">
								<li>
									<a href="#" title="新增用户" onClick="input()"><span>新增用户</span>
									</a>
								</li>
								<li>
									<a href="#" title="修改用户" onClick="modifySelected()"><span>修改用户</span>
									</a>
								</li>
								<li>
									<a href="#" title="删除用户" onClick="safeSubmitRemove()"><span>删除用户</span>
									</a>
								</li>

							</ul>

						</td>
					</tr>
				</table>

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
													<th height="20px" width="5%">
														<s:checkbox name="selectAll" onclick="doSelectAll()" />
													</th>
													<th width="12%">
														登录用户名
													</th>
													<th width="25%">
														显示用户名称
													</th>
													<th width="25%">
														用户所在部门
													</th>
													<th width="8%">
														状态
													</th>
													<th>
														操作
													</th>
												</tr>
											</thead>
											<tbody id="listData">
												<s:iterator value="resultData">
													<tr>
														<td>
															<s:checkbox id="%{userid}" name="selectNode"
																fieldValue="%{userid}" />
														</td>
														<td>
															<a
																href="javascript:input('<s:property value="userid"/>',false)"><FONT color="blue"><s:property
																	value="userLoginId" /></FONT>
															</a>
														</td>
														<td>
															&nbsp;
															<s:property value="userName" />
														</td>
														<td>
															&nbsp;
															<s:property value="depart.departname" />
														</td>
														<td>
															&nbsp;
															<s:if test="state=='0'.toString()">禁用</s:if>
															<s:else>可用</s:else>
														</td>
														<td >
															
															<a
																href="javascript:input('<s:property value="userid"/>',false)"><FONT
																color="blue">编辑</FONT>
															</a>
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
				</table>
				<table border="0" cellspacing="0" cellpadding="0" width="100%">
					<tr>
						<td colspan="10" align="right">
							<s:property value="pager.postToolBar" escape="false" />
						</td>
					</tr>
				</table>
			</s:form>
		</div>
	</body>
</html>
