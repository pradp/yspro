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
									<td nowrap="nowrap" class="">
										栏目：<s:select name="txxfbPl.lmmc" list="getCmsSort()" listKey="id" listValue="caption" headerKey="" headerValue="---请选择---" autoWidth="true"/>
									</td>
									<td align="center" nowrap="nowrap" class="">
										&nbsp;新闻标题：<s:textfield name="txxfbPl.wzbt" id="bt" maxlength="50" size="20" />
									</td>
									<td align="center" nowrap="nowrap" class="">
										&nbsp;评论时间：
										<s:textfield name="txxfbPl.plsjStart" cssClass="date" cssStyle="width:140px;" dateFmt="yyyy-MM-dd HH:mm:ss" /> -
										<s:textfield name="txxfbPl.plsjEnd" cssClass="date" cssStyle="width:140px;" dateFmt="yyyy-MM-dd HH:mm:ss" />
									</td>
									<td align="center" nowrap="nowrap" class="">
										&nbsp;评论状态：<s:select name="txxfbPl.state" list="getSysCode('xxfb_plzt')" listKey="id" listValue="caption" headerKey="" headerValue="---请选择---" autoWidth="true"/>
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
			<button onclick="doModify()"><span class="icon_edit">修改</span></button>
			<button onclick="doRemove()"><span class="icon_delete">删除</span></button>
			<button onclick="myChangeState('0', '屏蔽')"><span class="icon_no">屏蔽</span></button>
			<button onclick="myChangeState('1', '公布')"><span class="icon_ok">公布</span></button>
		</div>
		
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="false" useCheckBox="false">
				<tr>
					<th height="20px" width="3%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
					<th width="30%">
						评论内容
					</th>
					<th width="8%">
						栏目
					</th>
					<th width="20%">
						新闻标题
					</th>
					<th width="10%">
						评论时间
					</th>
					<th width="8%">
						评论人
					</th>
					<th width="10%">
						评论IP
					</th>
					<th width="8%">
						评论状态
					</th>
				</tr>
				<s:iterator value="resultData">
					<tr>
						<td>
							<s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}" />
						</td>
						<td>
							<span class="text_slice" style="width:260px;" title="<s:property value="plnr" />"><s:property value="plnr" /></span>
						</td>
						<td>
							<s:property value="lmmc" />
						</td>
						<td>
							<a href="../html/<s:property value="wzwid"/>.jhtm" target="_blank">
							<span class="text_slice" style="width:220px;" title="<s:property value="wzbt" />"><s:property value="wzbt" /></span>
							</a>
						</td>
						<td>
							<s:date name="plsj" format="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td>
							<s:if test="plr!=null && plr!=''">
							<a href="javascript:openEntity('<s:property value="plr"/>','','','../id/idUser')">
							<s:property value="plrName" />
							</a>
							</s:if>
							<s:else>
							匿名
							</s:else>
						</td>
						<td>
							<s:property value="plrip" />
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
