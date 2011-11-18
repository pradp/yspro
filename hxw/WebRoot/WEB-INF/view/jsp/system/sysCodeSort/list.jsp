<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/include_list_head.jsp" %>
	
		<script type="text/javascript">

	function openPage(uri){
		openWindow(uri,800,450);
	}
	function doReturn(uri){
		location.href= uri;
	}
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
										&nbsp;字典类别：
										<s:select id="zdlb" onchange="super_doSearch()"
											name="tsysCodesort.zdlb" list="SysCodeSort" listKey="id" 
											listValue="caption" headerKey=""
												headerValue="-------请选择-------" autoWidth="true"/>
									</td>
								</tr>
	</s:form>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="userRoleMenuButton">
			<button onclick="openEntity()"><span class="icon_add">新增</span></button>
			<button onclick="doModify()"><span class="icon_edit">修改</span></button>
			<button onclick="doRemove()"><span class="icon_delete">删除</span></button>
			<button onclick="doReturn('../system/sysCode-list.action')"><span class="icon_back">返回</span></button>
		</div>
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="false" useCheckBox="false">
				<tr>
					<th height="20px" width="5%"></th>
					<th width="15%">
						字典类别编码
					</th>
					<th width="20%">
						字典类别名称
					</th>
					<th width="20%">
						操作
					</th>
				</tr>
				<s:iterator value="resultData">
					<tr>
						<td>
							<s:checkbox id="%{zdlb}" name="selectNode" fieldValue="%{zdlb}" />
						</td>
						<td>
							<a href="javascript:openEntity('<s:property value="zdlb"/>')"><s:property
									value="zdlb" />
							</a>
						</td>
						<td>
							<s:property value="lbmc" />
						</td>
						<td>
							[<a href="javascript:openEntity('<s:property value="zdlb"/>',false)">编辑</a>]
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
