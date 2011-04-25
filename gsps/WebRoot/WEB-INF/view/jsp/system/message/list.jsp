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
		<link rel="stylesheet"
			href="<s:property value="basePath"/>/resources/css/webface.css"
			type="text/css">
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/p2pMessage.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
		<script type="text/javascript">
	listPageStyle();
	function reMsg(jsr, msgId){
		var uri = "message-input.c?action=reMsg&tsysMessage.xxly=097&tsysMessage.xxjsr="+jsr;//097用户交流
		openWindow(uri);
		changeMsgState(msgId);
	}
	function departInfo(departid){
		openWindow('<s:property value="basePath"/>/system/depart-departdetail.c?tsysDepart.departid='+departid+'&readOnlyPage=true');
	}
	function submitRemove(id){
		var conf = window.confirm("您确定要删除已选中的这些数据吗？");
		if(conf==true){
			var ids =id;
			if(ids.length>0){
				var url = actionName + "-remove."+uri_suffix;
				var queryType=document.getElementById('queryType').value;
				$.post(url,
				       { wid: ids, queryType: queryType, reqtime: (new Date()).getTime() },
				       function(data){
						if(data.indexOf("删除成功")!=-1){
							$("input[@name=selectNode]").each(function(i){
								if(ids.indexOf(this.value)!=-1){
									$(this).parent().parent().remove();
								}
							});
							//alert("删除成功!");
						}
						document.forms[0].submit();
				       }
				);
			}else{
				alert("请选择要删除的项!");
			}
		}
	}	
	function removeAll(str){
		document.getElementById("inp").style.display="";
		if(document.getElementById('mydate').value==''){
			document.getElementById('mydate').focus();
		}else{
			var s = str;
			removet(s);
		}
	}
	function removet(str){
	var mydate = document.getElementById('mydate').value;
	var fszt = document.getElementById('fszt').value;
	if(fszt==null){
		fszt = '-1';
	}
	var conf = window.confirm("您确定要删除"+mydate+"前的记录吗？");
	if(conf==true){
			var url_bak = document.forms[0].action;
			var url = actionName + "-remove."+uri_suffix;
			var queryType=str;
			jQuery.post(url,
			       { czsj: mydate, queryType: queryType, fszt: fszt, reqtime: (new Date()).getTime() },
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
	function openPage(uri){
		if(uri.indexOf('xxzt=0')!=-1){
			openWindow(uri,400,250);
		}else{
			openWindow(uri,550,250);
		}
	}
	function openPageModify(uri){
		openWindow(uri,850,300);
	}
	function sendMsg(ids){
		ajaxService.sendShortMessage(ids, ajaxBackString);
		function ajaxBackString(result){
			if(result){
				alert('发送成功');
			}
			document.forms[0].submit();
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
			<s:form theme="simple" name="theform">
				<s:hidden name="pager.formname" value="theform" />
				<s:hidden name="queryType" />
				<s:hidden name="fszt" value="%{#parameters.fs[0]}" id="fszt"/>
				<s:hidden name="fs" value="%{#parameters.fs[0]}" id="fs"/>

		<div id="listC" style="text-align:center;z-index: -100">
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="maginB">

					<tr>
						<td>
							<table width="45%" border="0" align="left" cellpadding="0"
								cellspacing="0" class="maginB">
								<tr>
									<td class="chaxunleft">
										<table id="searchForm" border="0" align="center"
											cellspacing="3" cellpadding="0" width="100%">
											<tr align="left">

												<td align="right" nowrap="nowrap">
													&nbsp;消息标题：
												</td>
												<td align="left">
													<s:textfield name="tsysMessage.xxbt" id="yxbm"
														maxlength="50" size="30" />
												</td>

												<td align="center" nowrap="nowrap">

													<ul class="btn_gn">
														<li>
															<a href="#" title="查询" onClick="super_doSearch()"
																id="searchButton" name="btn3"><span>查询</span> </a>
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
									<td height="30px" width="350px" align="left">
										<ul class="btn_gn">
											<li>
												<a href="#" title="写消息" onClick="sendMessageToDepart()"
													id="sendMsgButton"><span>写消息</span> </a>
											</li>
											<li>
												<a href="#" title="已发消息"
													onclick="location.href='message-list.c?queryType=1&fs=1'"><span>已发消息</span>
												</a>
											</li>
											<li><a href="#" title="删除指定日期前的消息" onClick="removeAll('1')" name="removeAll()"><span>删除指定日期前的消息</span></a></li>
										</ul>
									</td>
										<td id="inp" style="display:none" align="left" width="160px">
										指定日期：
												<s:textfield id="mydate" name="mydate" maxlength="20" size="10" onchange="removet('1')" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>
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
																<th width="10%">
																	消息类型
																</th>
																<th width="20%">
																	消息标题
																</th>
																	<th width="10%">
																		发送时间
																	</th>
																<th width="15%">
																	操作
																</th>

															</tr>
														</thead>
														<tbody id="listData">
															<s:iterator value="resultData">
																<tr>
																	<td>
																		通知公告
																	</td>
																	<td id="msg_title<s:property value="wid"/>">
																		<s:property value="xxbt" />
																	</td>
																	<td>
																		<s:date format="yyyy-MM-dd HH:mm" name="xxfssj" />
																	</td>
																	<td>
																		<span> 	
																			<font color="blue">
																				<a
																				id="switchShow<s:property value="wid"/>"
																				href="javaScript:readMsg('<s:property value="wid"/>',<s:property value="#queryType==2?'true':'false'"/>)">查看</a>
																			</font> 
																		</span>
																		<span id="msg<s:property value="wid"/>"
																			style="display:none;text-align:left;width:100%;height:60;word-wrap: break-word; word-break: break-all;">
																			&nbsp;&nbsp;
																			<s:if test="xxfsrDepartid.length()==3">
																				<s:property value="xxnr" escape="false" /></br></br>
																			</s:if>
																			<s:else>
																				<s:property value="xxnr" escape="true" /></br></br>
																			</s:else>
																		    <s:if test="fjm != null">
																		    	<b>附件：</b><a href="../system/message-download.c?aId=<s:property value='realWid'/>&pathStr=<s:property value='fjm'/>">
																		    	<FONT color="blue"><s:property value='fjm'/></FONT></a>
																		    </s:if>
																		</span>
																		<a
																			href="javaScript:submitRemove('<s:property value="wid"/>')"><font
																			color="blue">删除</font> </a>
																	</td>
																</tr>

															</s:iterator>
														</tbody>
														<tr>
															<td colspan="6"></td>
														</tr>
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
		</div>
			</s:form>
	</body>
</html>

