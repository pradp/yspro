<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="../../common/include_list_head.jsp" %>

<body>
<script type="text/javascript">
/**
 * 选中的纪录。
 * AJAX 请求传统页面方式实现
 */
function doupdate(){
	var entityName='t_expertqa_appeal';
	var id_name='wid';
	var itemname='accepter';	
	var conf = window.confirm("您确定要移交已选中的这些问题给管理员吗？");
	if(conf==true){
		var ids = CropCheckBoxValueAsString("selectNode");
		if(ids.length>0){
			var url_bak = document.forms[0].action;
			var url = actionName + "-update."+uri_suffix;
			$.post(url, 
					{wid: ids,entityName:entityName,id_name:id_name,itemname:itemname,reqtime: (new Date()).getTime()  },
					function(data){
						if(data.indexOf("提交成功")!=-1){		
							document.forms[0].action = url_bak;//还原URL，防止点查询按钮却执行删除！
							document.forms[0].submit();
						}
					}
				);
			document.forms[0].action = url_bak;//还原URL，防止点查询按钮却执行删除！
			document.forms[0].submit();
		}else{
			alert("请选择要移交给管理员的项!");
		}
	}
}
</script>
<div id="scrollContent">    
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" >
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>
 <s:form theme="simple" name="ysform">
    <s:hidden name="pager.formname" value="ysform"/>
    <s:hidden name="pager.currentPageno" id="yspager_currentPageno"/>
    <s:hidden name="entityName" id="entityName" value="t_scjc_code"/>
    <s:hidden name="id_name" id="id_name" value="wid"/>
    <s:hidden name="menuid" id="menuid"/>
<div class="box_tool_mid padding_right5">
	<div class="center">
		<div class="left">
			<div class="right">
				<div class="padding_top8 padding_left10">
					<table>
						<tr>
							<td align="center" nowrap="nowrap" class="">&nbsp;关键词：
								<s:textfield name="texpertqaAppeal.title" id="title" size="20"/>
							</td>
							<td onclick="super_doSearch();"><button><span class="icon_find" >查询</span></button></td>
						</tr>
					</table>
				</div>			
			</div>		
		</div>	
	</div>
</div>
</s:form>
		<div id="userRoleMenuButton">
			<button onclick="doModify();"><span class="icon_add">答复</span></button>
			<button onclick="doupdate();"><span class="icon_mark">转交管理员</span></button>
		</div>
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="true" useCheckBox="true">
				<tr>
					<th width="25"></th>
					<th width="300"><span onclick="">问题</span></th>
					<th><span onclick="">问题内容</span></th>
					<th width="100"><span onclick="">提问人</span></th>
					<th width="100"><span onclick="">提问类型</span></th>
					<th width="100"><span onclick="">提问日期</span></th>
					<th width="60"><span onclick="">状态</span></th>					
				</tr>
 				<s:iterator value="resultData">
					<tr>
						<td><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
						<td><a href="javascript:openEntity('<s:property value="wid"/>')"><s:property value="title"/></a></td>
						<td><span class="text_slice" style="width:100px;" title="<s:property value="content" escapeHtml="false"/>"><s:property value="content" escapeHtml="false" /></span></td>
						<td title="<s:property value='content'/>"><s:property value="writer"/></td>
						<td title="<s:property value='sortId'/>"><s:property value="sortId"/></td>
						<td title="<s:property value='dateofinput'/>"><s:date name="dateofinput"  format="yyyy-MM-dd" /></td>
						<td title="<s:property value='ispublish'/>"><s:if test="ispublish==1">公开</s:if><s:else>不公开</s:else></td>
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
