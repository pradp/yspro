<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

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
   <script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>	
		<script type="text/javascript">

	$(document).ready(function(){
		listPageStyle();
	});
   	function uploadFile(){
		var params = "dialogWidth=420px;dialogHeight=140px";
		window.showModalDialog("excelImport-uploadFile.c",parent,params);
		document.forms[0].submit();
	}
	function importData(){
		var conf = window.confirm("您确定要正式导入这些数据吗？");
		if(conf==true){
			var url_bak = window.location.href;
			var url = "excelImport-importData.c";
			$.post(url, { reqtime: (new Date()).getTime() },
				function(data){
					//window.location.href = url_bak;//还原URL，防止点查询按钮却执行删除！
					document.forms[0].action=url_bak;//还原URL，防止点查询按钮却执行删除！
					if(data.indexOf('导入成功')!=-1){
						alert('导入成功！');
						document.forms[0].submit();
					}else{
						alert('导入失败！');
						$("#importMessage").html(data);
					}
				}
			);
		}
	}
	
	function doSearch_student(){
		document.getElementById('sfzh').value=(document.getElementById('sfzh').value).toUpperCase();
		super_doSearch();
	}
	
	function submitRemove(){
		var conf = window.confirm("您确定要清除这些临时数据吗？");
		if(conf==true){
			var ids = '<s:property value="loginUser.userid"/>';
			if(ids.length>0){
				var url_bak = window.location.href;
				var url = actionName + "-remove."+uri_suffix;
				$.post(url,
				       { wid: ids, reqtime: (new Date()).getTime() },
				       function(data){
						window.location.href = url_bak;//还原URL，防止点查询按钮却执行删除！
						document.forms[0].submit();
				       }
				);
			}else{
				alert("请选择要删除的项!");
			}
		}
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
						<td>
							<table width="65%" border="0" align="left" cellpadding="0"
								cellspacing="0" class="maginB">
								<tr>
									<td class="chaxunleft">
										<table id="searchForm" border="0" align="center"
											cellspacing="3" cellpadding="0" width="100%">
											<tr align="center">
												<td align="right" nowrap="nowrap" class="">
													学生姓名：
												</td>
												<td align="left">
													<s:textfield name="tsxDksqbImport.xsxm" id="xsxm"
														maxlength="8" size="8" />
												</td>
												<td align="right" nowrap="nowrap" class="">
													学生身份证号：
												</td>
												<td align="left">
													<s:textfield name="tsxDksqbImport.sfzh" id="sfzh"
														maxlength="18" size="23" />
												</td>
												<td align="right" nowrap="nowrap" class="">
													数据状态：
												</td>
												<td align="left">
													<s:select name="tsxDksqbImport.yzzt"
														list="#{'':'全部','1':'通过','0':'不通过'}" />
												</td>
												<td align="left" nowrap="nowrap">


													<ul class="btn_gn">
														<li>
															<a href="#" title="查询学生" onClick="doSearch_student()"
																id="searchButton" name="btn3"><span>查询学生</span>
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
						</td>
					</tr>
					<tr>
						<td>
							<table id="buttonTable" border="0" cellspacing="3"
								cellpadding="0" width="100%">
								<tr>
									<td height="30px" colspan="10">
										<ul class="btn_gn">
											<s:if test="resultData==null || resultData.isEmpty()">
												<li>
													<a href="#" title="上传Excel文件" onClick="uploadFile();"
														name="create0"><span>上传Excel文件</span> </a>
												</li>
											</s:if>
											<s:else>
												<li>
													<a href="#" title="导入正式库" onClick="importData()"
														name="modifyStudent"><span>导入正式库</span> </a>
												</li>
												<li>
													<a href="#" title="清除数据" onClick="submitRemove()"
														name="removeRows"><span>清除数据</span> </a>
												</li>
											</s:else>
										</ul>
									</td>
								</tr>
								<tr>
									<td>
										<span id="importMessage"></span>
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

													<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
													<thead id="listHead">
													<tr>
													<th width="8%">
																	姓名
																</th>
																<s:if test="depart.departtype==8||depart.departtype==7">
																	<th width="15%">
																		所在区县
																	</th>
																	<th width="15%">
																		所在中学
																	</th>
																</s:if>
																<s:elseif
																	test="depart.departtype==9||depart.departtype==6">
																	<th width="15%">
																		所在高校
																	</th>
																	<th width="15%">
																		所在班级
																	</th>
																</s:elseif>
																<th width="10%">
																	身份证号
																</th>
																<th width="5%">
																	困难类型
																</th>
																<th width="5%">
																	申请金额
																</th>
																<th width="10%">
																	状态
																</th>
															</tr>
														</thead>
														<tbody id="listData">
															<s:iterator value="resultData">

																<tr>
																	<td>
																		<a
																			href="javascript:input('<s:property value="wid"/>')"><s:property
																				value="xsxm" /> </a>
																	</td>
																	<s:if test="depart.departtype==8||depart.departtype==7">
																		<td>
																			&nbsp;
																			<s:property value="hjszqx" />
																		</td>
																		<td>
																			&nbsp;
																			<s:property value="byxx" />
																		</td>
																	</s:if>
																	<s:elseif
																		test="depart.departtype==9||depart.departtype==6">
																		<td>
																			&nbsp;
																			<s:property value="gxbm" />
																		</td>
																		<td>
																			&nbsp;
																			<s:property value="bj" />
																		</td>
																	</s:elseif>
																	<td>
																		&nbsp;
																		<s:property value="sfzh" />
																	</td>
																	<td>
																		&nbsp;
																		<s:property value="knlx" />
																	</td>
																	<td>
																		&nbsp;
																		<s:property value="sqje" />
																	</td>
																	<td>
																		<s:if test="yzzt==null">
									未验证
									</s:if>
																		<s:elseif test="yzzt==0">
									不通过
									</s:elseif>
																		<s:elseif test="yzzt==1">
									通过
									</s:elseif>
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

