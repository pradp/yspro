<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/include_list_head.jsp" %>
		<script type="text/javascript" src="../clientui/js/table/treeTable.js"></script>
	
		<script type="text/javascript">
		function reBuildTreeOrderBy(){
			$("table tr").each(function(i){
				var pid = $(this).attr("class");
				pid = pid.replaceAll("child-of-node-","");
				if(pid!=""){
					var id = $(this).attr("id");
					id = id.replaceAll("node-","");
					var prevTrId = $(this).prev().attr("id");//上一行tr的id
					prevTrId = prevTrId.replaceAll("node-","");
					if(prevTrId!=pid){
						//上一行不是本行的父辈目录，需要移动本行到父目录行后面
						$("#node-"+pid).after( $(this) );
						//$(this).remove();
					}
				}
			});
		}
		jQuery(document).ready(function() {
			//reBuildTreeOrderBy();
		});
		
		/**
		 * 删除选中的纪录。由于本页面选择框格式特殊，所以此处单独写函数
		 * AJAX 请求传统页面方式实现
		 */
		function doRemove() {
			var ids = CropCheckBoxValueAsString("selectNode");
			if(ids != false){
				var conf = window.confirm("您确定要删除已选中的栏目吗？");
				if (conf == true) {
					var url_bak = document.forms[0].action;
					var url = actionName + "-remove." + uri_suffix;
					$.post(url, {
						wid : ids,
						reqtime : (new Date()).getTime()
					}, function(data) {
						document.forms[0].action = url_bak;//还原URL，防止点查询按钮却执行删除！
							if (data.indexOf("删除成功") != -1) {
								$("input[name=selectNode]").each(function(i) {
									if (ids.indexOf(this.value) != -1) {
										$(this).parent().parent().remove();
									}
								});
								
								//alert("删除成功!");
							document.forms[0].action = window.location.href;
							document.forms[0].submit();
						} else {
							//alert(data);
							alert($(data).find("span").text());
						}
					});
				}
			} 
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
		<s:form theme="simple" name="ysform">
			<s:hidden name="pager.formname" value="ysform"/>
			<s:hidden name="pager.currentPageno" id="yspager_currentPageno"/>
		</s:form>
		<div id="userRoleMenuButton" >
			<button onclick="openEntity()"><span class="icon_add">新增</span></button>
			<button onclick="doRemove()"><span class="icon_delete">删除</span></button>
		</div>
		<div>
			<table class="treeTable" headFixMode="true" expandable="false"
				useMultColor="true" useCheckBox="true">
				<tr>
					<th width="25%">
						栏目名称（文章数）
					</th>
					<th width="8%">
						前台排序值
					</th>
					<th width="10%">
						开放RSS支持
					</th>
					<th width="10%">
						允许网友供稿
					</th>
					<th width="10%">
						默认评论权限
					</th>
					<th width="12%">
						状态
					</th>
				</tr>
				<s:iterator value="resultData">
					<tr id="node-${wid }" class="child-of-node-${parentwid }">
						<td>
							<s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}" />
							<span class="folder">
							<a href="javascript:openEntity('<s:property value="wid"/>')"><s:property
									value="lmmc" /></a>
							</span>
							（<s:property value="children"/>篇）
						</td>
						<td>
							<s:property value="ordernum"/>
						</td>
						<td>
							<s:property value="zcrss"/>
						</td>
						<td>
							<s:property value="yxwygg"/>
						</td>
						<td>
							<s:property value="sfpl"/>
						</td>
						<td>
							<s:property value="state"/>
						</td>
					</tr>
				</s:iterator>
			</table>
		</div>

	</div>
	</body>
</html>
