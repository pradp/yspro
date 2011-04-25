<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="_self">
		<title>单位信息</title>

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
 	<script type="text/javascript">
	$(document).ready(function(){
			detailPageStyle();
		}
	);
	</script>

	</head>

	<body style="text-align:center;">
		<div class="framestyle" style="width:98%;padding: 0pt 10pt 10pt 10pt;">
			<s:form name="theform" method="post" theme="simple"
				action="/system/depart-save.c">
				<s:hidden name="tsysDepart.departid" />
				<table width="100%" border="0" align="center">
					<tr>
						<th height="40px" width="100%">
							<h3>
								单位信息
							</h3>
						</th>
					</tr>
				</table>
				<s:property value="%{#parameters.dwlx[0]}" />




													<fieldset>
														<legend>
															基本信息
														</legend>
														<table width="100%" border="0" align="center">
															<tr>
																<td align="right" width="10%" nowrap="nowrap">
																	部门编号：
																</td>
																<td width="40%">
																	<s:property value="tsysDepart.departid" />
																</td>
																<td align="right" width="10%" nowrap="nowrap">
																	部门名称：
																</td>
																<td width="40%">
																	<s:property value="tsysDepart.departname" />
																</td>
															</tr>
															<tr>
																<td align="right" width="10%" nowrap="nowrap">
																	上级部门编号：
																</td>
																<td width="40%">
																	<s:property value="updepartid" />
																</td>
																<td align="right" width="10%" nowrap="nowrap">
																	上级部门名称：
																</td>
																<td width="40%">
																	<s:property value="updepartname" />
																</td>
															</tr>
														</table>
													</fieldset>
													<fieldset>
														<legend>
															附属信息
														</legend>
														<table width="100%" border="0" align="center">
															<tr>
																<td align="right" width="10%" nowrap="nowrap">
																	部门联系人：
																</td>
																<td width="40%">
																	<s:property value="departDetail.linkman" />
																</td>
																<td align="right" width="10%" nowrap="nowrap">
																	部门联系电话：
																</td>
																<td width="40%">
																	<s:property value="departDetail.linktel" />
																</td>
															</tr>
															<tr>
																<td align="right" width="10%" nowrap="nowrap">
																	邮编：
																</td>
																<td width="40%">
																	<s:property value="departDetail.postcode" />
																</td>
																<td align="right" width="10%" nowrap="nowrap">
																	通讯地址：
																</td>
																<td width="40%">
																	<s:property value="departDetail.address" />
																</td>
															</tr>
															<tr>
																<td align="right" width="10%" nowrap="nowrap">
																	传真：
																</td>
																<td width="40%">
																	<s:property value="departDetail.fax" />
																</td>
																<td align="right" width="10%" nowrap="nowrap">
																	电子邮箱：
																</td>
																<td width="40%">
																	<s:property value="departDetail.email" />
																</td>
															</tr>
														</table>
													</fieldset>
													<table width="20%" border="0" align="center">
														<tr>
															<td colspan="7">
																&nbsp;
															</td>
														</tr>
														<tr align="center" valign="middle">
												
															<td  colspan="7">
																<ul class="btn_gn">
																	<li>
																		<a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span>
																		</a>
																	</li>
																</ul>
															</td>
														</tr>
													</table>
									

			</s:form>
		</div>
	</body>
</html>
