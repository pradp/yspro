<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/include_list_head.jsp" %>
	
		<!--截取文字start-->
		<script type="text/javascript" src="../clientui/js/text/text-overflow.js"></script>
		<!--截取文字end-->
		
		<script type="text/javascript">

		</script>
	</head>

	<body>
    <div id="scrollContent">
    
		<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
		</s:if>

		<div class="box_tool_mid padding_right5">
			<div class="center">
				<div class="left">
					<div class="right">
						<div class="padding_top8 padding_left10">
							<table>
						    <s:form theme="simple" name="ysform">
						    <s:hidden name="pager.formname" value="ysform"/>
						    <s:hidden name="pager.currentPageno" id="yspager_currentPageno"/>
								<tr >
									<td align="center" nowrap="nowrap" class="">
										&nbsp;标题：<s:textfield name="thdNr.bt" id="bt" maxlength="50" size="20" />
									</td>
									<td align="center" nowrap="nowrap" class="">
										&nbsp;最后修改日期：
										<input name="thdNr.zhxgrqStart" value="<s:date name="thdNr.zhxgrqStart" format="yyyy-MM-dd HH:mm:ss"/>" class="date" style="width:140px;" dateFmt="yyyy-MM-dd HH:mm:ss" /> -
										<input name="thdNr.zhxgrqEnd" value="<s:date name="thdNr.zhxgrqEnd" format="yyyy-MM-dd HH:mm:ss"/>" class="date" style="width:140px;" dateFmt="yyyy-MM-dd HH:mm:ss" />
									</td>
									<td align="center" nowrap="nowrap" class="">
										&nbsp;状态：<s:select name="thdNr.state" list="getSysCode('hd_state')" listKey="id" listValue="caption" headerKey="" headerValue="---请选择---" autoWidth="true"/>
									</td>
									<td>&nbsp;&nbsp;<button onclick="super_doSearch()"><span class="icon_find">查询</span></button></td>
								</tr>
	</s:form>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="userRoleMenuButton" >
			<button onclick="openEntity()"><span class="icon_add">新增</span></button>
			<button onclick="doModify()"><span class="icon_edit">修改</span></button>
			<button onclick="doRemove()"><span class="icon_delete">删除</span></button>
			<button onclick="myChangeState('2', '通过')"><span class="icon_ok">批量审核</span></button>
			<button onclick="myChangeState('-1', '退回')"><span class="icon_ok">批量退回</span></button>
			<button onclick="myChangeState('-2', '结束')"><span class="icon_no">设为已结束</span></button>
		</div>
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="false" useCheckBox="false">
				<tr>
					<th height="20px" width="3%"></th>
					<th width="25%">
						标题
					</th>
					<th width="10%">
						最后编辑时间
					</th>
					<th width="15%">
						活动时间
					</th>
					<th width="5%">
						价格
					</th>
					<th width="8%">
						报名人数
					</th>
					<th width="5%">
						点击数
					</th>
					<th width="8%">
						创建人
					</th>
					<th width="10%">
						审核时间
					</th>
					<th width="8%">
						状态
					</th>
				</tr>
				<s:iterator value="resultData">
					<tr>
						<td>
							<s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}" />
						</td>
						<td>
							<span class="text_slice" style="width:260px;" title="<s:property value="bt" />">
								<a href="javascript:openEntity('<s:property value="wid"/>')"><s:property value="bt" /></a>
							</span>
						</td>
						<td>
							<s:date name="zhxgrq" format="yyyy-MM-dd HH:mm"/>
						</td>
						<td>
							<span class="text_slice" style="width:150px;" title="<s:property value="hdsj" />">
								<s:property value="hdsj" />
							</span>
						</td>
						<td>
							<s:property value="jg" />
						</td>
						<td>
							<s:property value="bmrs" /> / <s:property value="zdrs" />
						</td>
						<td>
							<s:property value="djs" />
						</td>
						<td>
							<s:property value="cjrName" />
						</td>
						<td>
							<s:date name="shrq" format="yyyy-MM-dd HH:mm"/>
						</td>
						<td>
							<s:property value="state" />
						</td>
					</tr>
				</s:iterator>
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
