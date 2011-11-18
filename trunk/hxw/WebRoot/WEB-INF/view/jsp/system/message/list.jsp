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
	function submitRemove(id,re){
		var url = actionName + "-remove."+uri_suffix;
		var ids =id;
		if(re==""){
		var conf = window.confirm("您确定要删除已选中的这些数据吗？");
		if(conf==true){
			if(ids.length>0){
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
		}else{
				if(confirm("此删除将会影响接收人的信息，你确定要删除这些数据吗？")){
				    	jQuery.post(url,{wid:ids,xxzt:1},function(data){
				    		if(data.indexOf("删除成功")!=-1){
				    			$("input[@name=selectNode]").each(function(i){
									if(ids.indexOf(this.value)!=-1){
										jQuery(this).parent().parent().remove();
									}
								});
						    }
					       document.forms[0].submit();
					    });
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
	function openPageMsgbody(uri,wid){
		openWindow(uri,550,300);
		changeMsgState(wid);
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
									<td height="30px" width="640px">
										<ul class="btn_gn">
											<li>
												<a href="#" title="写消息" onClick="sendMessageToDepart()"
													id="sendMsgButton"><span>写消息</span> </a>
											</li>
										
											<li>
												<a href="#" title="收件箱"
													onclick="location.href='message-list.c?queryType=2'"><span>收件箱</span>
												</a>
											</li>
											<li>
												<a href="#" title="已发消息"
													onclick="location.href='message-list.c?queryType=1&fs=1'"><span>已发消息</span>
												</a>
											</li>
											<s:if test="#queryType==2">
												<li><a href="#" title="删除指定日期前的收件箱消息" onClick="removeAll('2')" name="removeAll()"><span>删除指定日期前的收件箱消息</span></a></li>
											</s:if>
											<s:elseif test="#queryType==1">
												<s:if test="#fs == '1'.toString()">
													<li><a href="#" title="删除指定日期前的发件箱消息" onClick="removeAll('1')" name="removeAll()"><span>删除指定日期前的发件箱消息</span></a></li>
												</s:if>
												<s:else>
													<li><a href="#" title="删除指定日期前的草稿箱消息" onClick="removeAll('1')" name="removeAll()"><span>删除指定日期前的草稿箱消息</span></a></li>
												</s:else>
											</s:elseif>
										</ul>
									</td>
										<td id="inp" style="display:none" align="left" width="160px">
										指定日期：
											<s:if test="#queryType==2">
												<s:textfield id="mydate" name="mydate" maxlength="20" size="10" onchange="removet('2')" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>
											</s:if>
											<s:elseif test="#queryType==1">
												<s:textfield id="mydate" name="mydate" maxlength="20" size="10" onchange="removet('1')" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>
											</s:elseif>
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
																<s:if test="#queryType==2">
																	<th width="20%">
																		发送者
																	</th>
																</s:if>
																<s:elseif test="#queryType==1">
																	<s:if test="#fs=='1'.toString() && user.depart.departtype!='1'.toString()">
																		<th width="15%">
																			接收者
																		</th>
																	</s:if>
																</s:elseif>
																<th width="20%">
																	消息标题
																</th>
																<s:if test="#fs=='1'.toString()||#queryType==2">
																	<th width="10%">
																		发送时间
																	</th>
																</s:if>
																<s:if test="(user.depart.departtype!='1'.toString()&& #fs!='1'.toString())||#queryType==2 "> 
																		<th width="6%">
																			状态
																		</th>
																</s:if>
																<s:elseif test="#fs=='1'.toString()&&user.depart.departtype=='1'.toString()&&#queryType==1">
																	<th width="6%">
																		已读人数
																	</th>
																	<th width="6%">
																		未读人数
																	</th>
																</s:elseif>
																<th width="15%">
																	操作
																</th>

															</tr>
														</thead>
														<tbody id="listData">
															<s:iterator value="resultData">
																<tr>
																	<td>
																		<s:property value="xxly" />
																	</td>
																	<s:if test="#queryType==2">
																		<td>
																			<a
																				href="javascript:departInfo('<s:property value="xxfsrDepartid"/>')""><font
																				color="blue"><s:property value="xxfsr" /> </font> </a>
																		</td>
																	</s:if>
																	<s:elseif test="#queryType==1">
																		<s:if test="#fs=='1'.toString()&&user.depart.departtype!='1'.toString()">
																		<td>
																			<s:property value="xxjsr" />
																		</td>
																		</s:if>
																	</s:elseif>
																	<td id="msg_title<s:property value="wid"/>">
																		<s:property value="xxbt" />
																	</td>
																<s:if test="#fs=='1'.toString()||#queryType==2">
																	<td>
																		<s:property value="xxfssjName.substring(0,19)" />
																		<!-- <s:date format="yyyy-MM-dd HH:mm" name="xxfssj" /> -->
																	</td>
																</s:if>
																<s:if test="(user.depart.departtype!='1'.toString()&& #fs!='1'.toString())||#queryType==2 "> 
																	<td id="xxzt<s:property value="wid"/>">
																			<s:property value="xxzt" />
																	</td>
																</s:if>
																<s:elseif test="#fs=='1'.toString()&&user.depart.departtype=='1'.toString()&&#queryType==1">
																	<td>
																		<s:if test="xxly=='群发学生消息'.toString()">--</s:if>
																		<s:elseif test="ydrs==0">0</s:elseif>
																		<s:else>
																		<a href="javascript:void(null)"
																		onclick="openPage('message-receiveArea.c?wid=${wid}&xxzt=1')"><FONT
																		color="blue"><s:property value="ydrs" />
																		</FONT> </a>
																		</s:else>
																	</td>
																	<td>
																		<s:if test="xxly=='群发学生消息'.toString()">--</s:if>
																		<s:elseif test="wdrs==0">0</s:elseif>
																		<s:else>
																			<a href="javascript:void(null)"
																			onclick="openPage('message-receiveArea.c?wid=${wid}&xxzt=0')"><FONT
																			color="blue"><s:property value="wdrs" />
																		</FONT> </a>
																		</s:else>
																	</td>
																</s:elseif>
																	<td>
																	  <s:if test="#fs=='0'.toString()&&#queryType==1">
																		<span> 	
																			<font color="blue">
																			      <a href="javascript:void(null)"
																							onclick="openPageModify('../system/message-modify.c?ids=<s:property value="realWid"/>')"><font
																							color="blue">查看</font>
																				  </a>
																			</font> 
																		</span>
																	  </s:if>
																	  <s:else>
																		<span> 
																			<s:if test="ISHUNAN">
																			<font color="blue">
																				<a
																				id="switchShow<s:property value="wid"/>"
																				href="javascript:void(null)"
																							onclick="openPageMsgbody('../system/message-msgbody.c?wid=<s:property value="realWid"/>','<s:property value="wid"/>')">查看</a>
																			</font> 
																			</s:if>	
																			<s:else>
																				<font color="blue">
																				<a
																				id="switchShow<s:property value="wid"/>"
																				href="javaScript:readMsg('<s:property value="wid"/>',<s:property value="#queryType==2?'true':'false'"/>)">查看</a>
																			</font> 
																			</s:else>
																		</span>
																	  </s:else>
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
																		<s:if test="#queryType==2">
																			<a
																				href="javaScript:reMsg('<s:property value="xxfsrDepartid"/>','<s:property value="wid"/>')"><font
																				color="blue">回复</font></a>

																		</s:if>
																		<s:if test="#fs==0">
																			<a
																				href="javaScript:sendMsg('<s:property value="realWid"/>')"><font
																				color="blue">发送</font></a>

																		</s:if>
																		<a
																			href="javaScript:submitRemove('<s:property value="wid"/>','')"><font
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

