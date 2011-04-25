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


		<script type="text/javascript"
			src="<s:property value="basePath"/>/dwr/engine.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>

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
	function openPage(uri){
		openWindow(uri,800,450);
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
										&nbsp;字典类别:
										<s:select id="zdlb" onchange="document.forms[0].submit()"
											name="tsysCodeSort.zdlb" list="SysCodeSort" listKey="id" 
											listValue="caption" headerKey=""
												headerValue="------------------请选择------------------" />
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
				<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
				 <tr>
					<td height="30px" colspan="10">
					    <ul class="btn_gn">
							<li><a href="#" title="新增类别" onClick="input();" name="create0"><span>新增参数</span></a></li>
							<li><a href="#" title="删除类别" onClick="submitRemove()" name="removeRows"><span>删除</span></a></li>
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
													<th height="20px" width="5%"></th>
													<th width="15%">字典类别编码</th>
													<th width="20%">字典类别名称</th>
													<th width="20%">操作</th>
												</tr>
											</thead>
											<tbody id="listData">
    											<s:iterator value="resultData">
													<tr>
														<td>&nbsp;<s:checkbox id="%{zdlb}" name="selectNode" fieldValue="%{zdlb}"/></td>
														<td>&nbsp;<a href="javascript:input('<s:property value="zdlb"/>',true)"><s:property value="zdlb"/></a></td>
														<td>&nbsp;<s:property value="lbmc"/></td>
														<td>[<a href="javascript:input('<s:property value="zdlb"/>',false)" >编辑</a>]</td>
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
