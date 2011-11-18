<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<%@include file="../../common/include_list_head.jsp" %>
		<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
   <script type="text/javascript">
	$(function(){
		index_labels = ['4','2'];
		view_rules = '{1}：（{2}）';
	})
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
			var url = "sysBizLog" + "-remove.action";
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
						<td align="center">操作对象：</td><td>
							<s:select name="tsysBizLog.czdx" id="czdx" list="getSysCode('czdx')" listKey="id" listValue="caption" headerKey="" headerValue="-----请选择-----" /></td>
						<td align="center">&nbsp;&nbsp;&nbsp;操作人账号：</td>
						<td><s:textfield name="tsysBizLog.czr" id="czr" maxlength="50" size="10" /></td>
						<td align="center">&nbsp;&nbsp;&nbsp;操作时间：</td>
						<td><s:textfield name="qssj" id="qssj" maxlength="20" size="10"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"/>
							-- <s:textfield name="zzsj" id="zzsj" maxlength="20" size="10"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"/>
						</td>
						<td align="center">&nbsp;&nbsp;&nbsp;操作类型：</td>
						<td><s:select name="tsysBizLog.czlx" id="czlx" list="#{'1':'增加','2':'修改','3':'删除'}" headerKey="" headerValue="-----请选择-----" /></td>
						<td align="right">&nbsp;&nbsp;&nbsp;</td>
						<td>
							<button type="button" onclick="super_doSearch()"><span class="icon_find">查询</span>
						</td>
					  </tr>
					 </s:form>
					</table>
				  </div>
				</div>
			  </div>
			</div>
		</div>
				
		<div style="padding-bottom:10px">
			<button onclick="doRemove()"><span class="icon_delete">删除</span></button>
			<button onclick="removeAll()"><span class="icon_recycle">删除指定日期之前的全部记录</span></button>
			<span id="inp" style="display:none" align="left">
				指定日期：<s:textfield id="mydate" name="mydate" maxlength="20" size="20" onchange="removet()" 
				onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>
			</span>
		</div>
					
		<div>
			<table class="tableStyle" headFixMode="true" useMultColor="false" useCheckBox="false">
				<tr>
					<th height="20px" width="5%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
					<th width="20%">操作对象</th>
					<th width="10%">操作人</th>
					<th width="15%">操作类型</th>
					<th width="15%">操作时间</th>
					<th width="15%">操作IP</th>
				</tr>
			  <s:iterator value="resultData" status="stuts">
				<tr>
					<td><s:checkbox id="%{resultData[#stuts.index][0]}" name="selectNode" fieldValue="%{resultData[#stuts.index][0]}" /></td>
					<td>
						<s:if test="resultData[#stuts.index][1]!=null"><s:property value="resultData[#stuts.index][1]" /></s:if>
						<s:else><s:property value="resultData[#stuts.index][5]" />(该操作对象未在字典表中定义)</s:else>
					</td>
					<td>&nbsp;<s:property value="resultData[#stuts.index][2]" /></td>
					<td>
						<s:if test="resultData[#stuts.index][3]=='1'.toString()">增加</s:if>
						<s:elseif test="resultData[#stuts.index][3]=='2'.toString()">修改</s:elseif>
						<s:elseif test="resultData[#stuts.index][3]=='3'.toString()">删除</s:elseif>
					</td>
					<td>&nbsp;<s:property value="resultData[#stuts.index][4]" /></td>
					<td>&nbsp;<s:property value="resultData[#stuts.index][6]" /></td>
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

