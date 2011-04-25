<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="java.net.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		
		<title>在线人列表</title>	
	
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
		<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/p2pMessage.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
		<script type="text/javascript">
	function openPage(uri){
		openWindow(uri,400,250);
	}
	
	function doreset(){
		document.getElementById('userName').value="";
		document.getElementById('userLoginId').value="";
		document.getElementById('departname').value="";
	}
	
	function departInfo(departid){
		openWindow('<s:property value="basePath"/>/system/depart-departdetail.c?tsysDepart.departid='+departid+'&readOnlyPage=true');
	}

	
	
	listPageStyle();
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
		
		<table width="100%" border="0" align="center" cellpadding="0"
						cellspacing="0" class="maginB">
						<tr>
							<td>

								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td height="33" valign="top" class="tishileft">
											<table border="0" cellspacing="5" cellpadding="0">
												<tr>
													<td width="20" align="left">
														<img src="../resources/images/vista/point05.png" width="7"
															height="7" />
													</td>
													<td width="700" align="left">
														<b>总在线人数查询:</b><%
					try {
						   Enumeration interfaces = NetworkInterface.getNetworkInterfaces();
						   while (interfaces.hasMoreElements()) {
						    NetworkInterface interfaceN = (NetworkInterface)interfaces.nextElement();
						    Enumeration ienum = interfaceN.getInetAddresses();
						    while (ienum.hasMoreElements()) {
						     InetAddress ia = (InetAddress)ienum.nextElement();
						     if(ia instanceof Inet4Address){
						      if(ia.getHostAddress().toString().startsWith("127")) {
						       continue;
						      }
						      else {
						       out.println(ia.getHostAddress()+"、");
						       break;
						      }
						      
						     } 
						     //if(ia instanceof Inet6Address){
						     // System.out.println(ia.getHostAddress()+"---ipv6");
						     //}
						    }
						   }
						  }
						  catch (Exception e) {
							  out.println(e.getMessage());
						  }
					%>上，
					共有
					<s:property value="#users.size"/>
					用户在线，列表如下：(单击用户名,可查看其详细信息)
													</td>
												</tr>
											</table>
										</td>
										<td width="15" height="33" class="tishiright">
											&nbsp;
										</td>
									</tr>
								</table>

							</td>
						</tr>
					</table>
		
		<table  width="100%" border="0" align="center" cellpadding="0"	cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleft">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
									<td align="right"  nowrap="nowrap">
										用户名称：
									</td>
									<td align="left">
										<s:textfield name="loginUserVO.userName" id="userName" maxlength="20" size="20"></s:textfield>
									</td>
									<td align="right"  nowrap="nowrap">
										登录账号：
									</td>
									<td align="left">
										<s:textfield name="loginUserVO.userLoginId" id="userLoginId" maxlength="20" size="20"></s:textfield>
									</td>
									<td align="right"  nowrap="nowrap">
										所属部门：
									</td>
									<td align="left">
										<s:textfield name="loginUserVO.depart.departname" id="departname" maxlength="20" size="20"></s:textfield>
									</td>
									<td><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="super_doSearch()"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
										</li>
										<li>
											<a href="#" title="重置" onClick="doreset()"
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
		</table>
		
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
			<tr>
									<td class="infomainbg">

										<table class="middle" width="100%" border="0" cellspacing="0"
											cellpadding="0">
											<tr>
												<td width="10">
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
					<th  width="3%"><s:checkbox name="selectAll" onclick="doSelectAll()"/></th>
					<th width="20%">
						用户名称
					</th>
					<th  width="18%">
						登录账号
					</th>
					<th  width="20%">
						所属部门
					</th>
					<th  width="20%">
						登录IP
					</th>
					<th  width="25%">
						登录时间
					</th>
				</tr>
			</thead>
			<tbody id="listData">
				<s:iterator value="resultData">
				<tr>
					<td class=""><s:checkbox id="depart_%{depart.departid}" name="selectNode" fieldValue="%{depart.departid}" />
					</td>
					<td>
						<s:hidden id="depart_%{depart.departid}" name="%{depart.departid}"></s:hidden>
						<a href="javascript:departInfo('<s:property value="%{depart.departid}"/>')">
							<font color="blue"><s:property value="userName" /> </font> </a>
					</td>
					<td>
						<s:property value="userLoginId"/>
					</td>
					<td>
						<s:property value="depart.departname"/>
					</td>
					<td>
						<s:property value="clientIP"/>
					</td>
					<td>
						<s:date name="loginTime" format="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
				</s:iterator>
			</tbody>
	         <tr align="left">
				<td colspan="6">
					<b>本次查询结果为:</b>
					匹配数据，共有
					<s:property value="resultData.size" />
					用户，列表如上：(单击用户名,可查看其详细信息)
				</td>
	        </tr>
	    </table>	
	    </table>
				
	    <td width="10" class="infomainright">&nbsp;</td>
	  <tr>
	    <td height="20" class="infobottomleft"></td>
	    <td width="10" class="infobottomright"></td>
	  </tr>
	</table>	
   
   </table>
   </s:form>
   </div>
   </body>
</html>
