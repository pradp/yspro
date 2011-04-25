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

		<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
		<link rel="stylesheet"
			href="<s:property value="basePath"/>/resources/css/webface.css"
			type="text/css">
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/p2pMessage.js"></script>

	
   <script type="text/javascript">
	listPageStyle();
	function doreset(){
		document.getElementById('czdx').value = "";
		document.getElementById('czr').value = "";
		document.getElementById('czlx').value = "";
		document.getElementById('qssj').value = "";
		document.getElementById('zzsj').value = "";
	}
	
	function removeAll(){
		document.getElementById("inp").style.display="";
		if(document.getElementById('mydate').value==''){
			document.getElementById('mydate').focus();
		}else{
			removet();
		}
	}
	function removet(){
	var mydate = document.getElementById('mydate').value;
	var conf = window.confirm("您确定要删除"+mydate+"前的记录吗？");
	if(conf==true){
			var url_bak = document.forms[0].action;
			var url = "sysBizLog" + "-remove.c";
			jQuery.post(url,
			       { czsj: mydate, reqtime: (new Date()).getTime() },
			       function(data){
						document.forms[0].action = url_bak;//还原URL，防止点查询按钮却执行删除！
						document.forms[0].submit();
			       }
			);
	}else{
		document.getElementById('mydate').value = '';
		document.getElementById("inp").style.display="none";
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
<tr><td>	<table width="650px" border="0" align="left" cellpadding="0"
					cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleftt">
							<table id="searchForm" border="0" align="center" cellspacing="3"
								cellpadding="0" width="100%">
								<tr align="center">
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
									<td align="right" nowrap="nowrap" width="8%">操作对象：</td>
									<td align="left"><s:select name="tsysBizLog.czdx" id="czdx" list="getSysCode('czdx')" listKey="id" listValue="caption" headerKey="" headerValue="-----------------请选择-----------------" /></td>
									<td align="right" nowrap="nowrap">
										操作人账号：
									</td>
									<td align="left">
										<s:textfield name="tsysBizLog.czr" id="czr" maxlength="50"
											size="14" />
									</td>
									<td><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="super_doSearch()"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
										</li>
										</ul>
										</td>
								</tr>
								<tr>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
									<td align="right" nowrap="nowrap">
										操作时间：
									</td>
									<td align="left"><s:textfield name="qssj" id="qssj" maxlength="20" size="13"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"/>
									-- <s:textfield name="zzsj" id="zzsj" maxlength="20" size="13"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"/>
									</td>
									<td align="right" nowrap="nowrap">
										操作类型：
									</td>
									<td align="left">
										<s:select name="tsysBizLog.czlx" id="czlx" list="#{'1':'增加','2':'修改','3':'删除','4':'取消','5':'恢复','6':'审核','7':'发布'}" headerKey="" headerValue="----请选择----" />
									</td>
									<td><ul class="btn_gn">
										<li>
											<a href="#" title="重置" onClick="doreset();"
												id="searchButton2" name="btn4"><span> 重置 </span>
											</a>
										</li>
									</ul></td>
								</tr>
							</table>
						</td>
						<td width="15" height="70" class="chaxunrightt">
							&nbsp;
						</td>
					</tr>
				</table></td></tr>
				
				<tr>
						<td>
							<table id="buttonTable" border="0" cellspacing="3"
								cellpadding="0" width="100%">
								<tr>
									<td height="30px" width="280px">
										<ul class="btn_gn">
											<li><a href="#" title="删除" onClick="submitRemove()" name="removeRows"><span>删除</span></a></li>
											<li><a href="#" title="删除指定日期之前的全部记录" onClick="removeAll()" name="removeAll()"><span>删除指定日期之前的全部记录</span></a></li>
										</ul>
									</td>
									<td id="inp" style="display:none" align="left">
										指定日期：<s:textfield id="mydate" name="mydate" maxlength="20" size="20" onchange="removet()" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>
									</td>
								</tr>

							</table>
						</td>
					</tr>
					
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
													<th width="20%">
														操作对象
													</th>
													<th width="10%">
														操作人
													</th>
													<th width="15%">
														操作类型
													</th>
													<th width="15%">
														操作时间
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
															<s:if test="resultData[#stuts.index][1]!=null">
															 <s:property value="resultData[#stuts.index][1]" />
															</s:if>
															<s:else>
															 <s:property value="resultData[#stuts.index][5]" />(该操作对象未在字典表中定义)
															</s:else>
														</td>
														<td>
															&nbsp;<s:property value="resultData[#stuts.index][2]" />
														</td>
														<td>
															<s:if test="resultData[#stuts.index][3]=='1'.toString()">增加</s:if>
															<s:elseif test="resultData[#stuts.index][3]=='2'.toString()">修改</s:elseif>
															<s:elseif test="resultData[#stuts.index][3]=='3'.toString()">删除</s:elseif>
															<s:elseif test="resultData[#stuts.index][3]=='4'.toString()">取消</s:elseif>
															<s:elseif test="resultData[#stuts.index][3]=='5'.toString()">恢复</s:elseif>
															<s:elseif test="resultData[#stuts.index][3]=='6'.toString()">审核</s:elseif>
															<s:elseif test="resultData[#stuts.index][3]=='7'.toString()">发布</s:elseif>
														</td>
														<td>
															&nbsp;<s:property value="resultData[#stuts.index][4]" />
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

