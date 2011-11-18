<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="java.net.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<%@include file="../../common/include_list_head.jsp" %>
		<title>在线人列表</title>	
		<script type="text/javascript">
	function openPage(uri){
		openWindow(uri,400,250);
	}
	
	function departInfo(departid){
		openWindow('<s:property value="basePath"/>/system/depart-input.action?wid='+departid+'&readOnlyPage=true');
	}
	</script>
	</head>

<body>
	<div id="scrollContent">
    
	<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
		<div id="SystemErrorMessage" >
			<s:actionerror/>
			<s:actionmessage/>
			<s:fielderror/>
		</div>
	</s:if>
		<div id="listC">
			<table border="0" cellspacing="5" cellpadding="0">
				<tr>
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
		  </div>
		<div style="padding-top:10px;padding-bottom:10px" class="box_tool_mid padding_right5" height="85px">
		  <div class="center">
			<div class="left">
			  <div class="right">
				<div class="padding_top8 padding_left10">
					<table>
					 <s:form theme="simple" name="ysform">
					    <s:hidden name="pager.formname" value="ysform"/>
					    <s:hidden name="pager.currentPageno" id="yspager_currentPageno"/>
					  <tr>
						<td align="right"  nowrap="nowrap">用户名称：</td>
						<td align="left"><s:textfield name="loginUserVO.username" id="username" maxlength="20" size="20"/></td>
						<td align="right"  nowrap="nowrap">登录账号：</td>
						<td align="left"><s:textfield name="loginUserVO.userloginid" id="userloginid" maxlength="20" size="20"/></td>
						<td align="right"  nowrap="nowrap">所属部门：</td>
						<td align="left"><s:textfield name="loginUserVO.depart.departname" id="departname" maxlength="20" size="20"/></td>
						<td align="right">&nbsp;&nbsp;&nbsp;</td>
						<td>
							<button onclick="super_doSearch()"><span class="icon_find">查询</span>
							<button onclick="doreset();"><span class="icon_recycle"> 重置 </span></button>
						</td>
					  </tr>
					 </s:form>
					</table>
				  </div>
				</div>
			  </div>
			</div>
		</div>	
		<!--  
		<div style="padding-bottom:10px">
			<button onclick="sendMessage('097')"><span class="icon_delete">消息发送</span></button>
		</div>
		-->
		<div>
			<table class="tableStyle" headFixMode="true" useMultColor="true" useCheckBox="true">
				<tr>
					<th width="3%"><s:checkbox name="selectAll" onclick="doSelectAll()"/></th>
					<th width="20%">用户名称</th>
					<th width="18%">登录账号</th>
					<th width="20%">所属部门</th>
					<th width="20%">登录IP</th>
					<th width="25%">登录时间</th>
				</tr>
			  <s:iterator value="resultData">
				<tr>
					<td class=""><s:checkbox id="depart_%{depart.departid}" name="selectNode" fieldValue="%{depart.departid}" />
					</td>
					<td>
						<s:hidden id="depart_%{depart.departid}" name="%{depart.departid}"></s:hidden>
						<a href="javascript:departInfo('<s:property value="%{depart.departid}"/>')">
							<font color="blue"><s:property value="username" /> </font> </a>
					</td>
					<td><s:property value="userloginid"/></td>
					<td><s:property value="depart.departname"/></td>
					<td><s:property value="clientIP"/></td>
					<td><s:date name="loginTime" format="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
			  </s:iterator>
	         <tr align="left">
				<td colspan="6">
					<b>本次查询结果为:</b>
					匹配数据，共有
					<s:property value="resultData.size" />
					用户，列表如上：(单击用户名,可查看其详细信息)
				</td>
	        </tr>
			</table>
		</div>

		<div style="height: 45px;">
			<div id="pagelist" style="display: none">
	  			<s:property value="pager.postToolBar" escape="false"/>
	  		</div>
	
			<div class="clear"></div>
		</div>
		</div>
	</body>
</html>