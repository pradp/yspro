<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
  		<title>维护菜单</title>
	
	<script type="text/javascript">
	detailPageStyle();
	$(document).ready(function(){
			
			<s:if test="refresh">
			window.parent.window.frames["menuFrame"].location.reload();
			</s:if>
		}
	);
	function doSave(){
		
		if( !checkInput("menuname","菜单名称不能为空！") ){
			return false;
		}
		if( !checkInput("ordernum","排序值不能为空！") ){
			return false;
		}
		return super_doSave();
	}
	function submitRemoveMenu(){
		var conf = window.confirm("删除此菜单会同时删除其下所有子菜单！\n\n您确定要删除吗？");
		if(conf==true){
			var ids = document.getElementById("menuid").value;
			if(ids.length>0){
				var url = actionName + "-remove.action";
				$.post(url,
				       { menuid: ids, reqtime: (new Date()).getTime() },
				       function(data){
					 	//alert("Data Loaded: " + data);
						if(data.indexOf("删除成功")!=-1){
							alert("删除成功！");
						}else{
							alert(data);
						}
						window.parent.window.frames["menuFrame"].location.reload();
						//window.parent.window.frames["menuFrame"].location.href = "idMenu-list.action?"+(new Date()).getTime();
						$("input[name^=tsysMenu]").each(function(){
							$(this).val("");
						});
				       }
				);
			}else{
				alert("无要删除的项!");
			}
		}
	}
	function input(){
		var uri = actionName+"-input.action?tsysMenu.upmenuid=<s:property value="tsysMenu.menuid"/>";
		window.location.href = uri;
	}
	function goButtonList(){
		var uri = "idButton-list.action?tsysButton.menuid=<s:property value="tsysMenu.menuid"/>";
		window.location.href = uri;
	}
	</script>
  </head>
  
  <body style="text-align:center;">
  <s:form name="ysform" method="post" theme="simple">
  <s:hidden id="menuid" name="tsysMenu.menuid" />
  <s:hidden name="tsysMenu.upmenuid" />
  <s:hidden name="tsysMenu.depth" />

	<div class="box1" panelWidth="99%">
 <fieldset> 
　 <legend>菜单信息</legend>
  <table class="tableStyle" transMode="true" footer="normal">
    <tr> 
      <td align="right" width="16%" nowrap="nowrap">名称：</td>
      <td align="left"><s:textfield id="menuname" name="tsysMenu.menuname" maxlength="25" size="30" cssStyle="width: 350px"/> <label style="color:red">*</label></td>
    </tr>

    <tr> 
      <td align="right">URI链接：</td>
      <td align="left"><s:textfield id="menupath" name="tsysMenu.menupath" maxlength="200" size="80" cssStyle="width: 350px"/> </td>
    </tr>

    <tr> 
      <td align="right">排序值：</td>
      <td align="left"><s:textfield id="ordernum" name="tsysMenu.ordernum" maxlength="6" size="6" onkeypress="NumberText(event)" cssStyle="width: 350px"/> <label style="color:red">*</label>
      <font color="#999999">说明：同一层次中数值大的往前排</font></td>
    </tr>

    <tr> 
      <td align="right">状态：</td>
      <td align="left"><s:radio id="menustate" name="tsysMenu.state" list="#{1:'启用', 0:'禁用'}" listKey="key" listValue="value"/> <label style="color:red">*</label></td>
    </tr>
  </table>
  </fieldset>
 
		<div class="padding_top10">
			<table class="tableStyle" transMode="true">
				<tr>
					<td colspan="4">
						<input type="button" id="ysSaveButton" value=" 保 存 " onclick="doSave()"/>
						<s:if test="tsysMenu.menuid!=null">
							<input type="button" id="ysDeleteButton" value=" 删 除 " onclick="submitRemoveMenu()"/>
							<input type="button" id="ysInsertButton" value=" 新增子菜单 " onclick="input()"/>
						</s:if>
						<s:else>
							<input type="button" value=" 返 回 " onclick="window.history.go(-1)"/>
						</s:else>
						<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
							<span id="SystemErrorMessage"">
								<s:actionerror/>
								<s:actionmessage/>
								<s:fielderror/>
							</span>
						</s:if>
					</td>
				</tr>
			</table>
		</div> 
	</div>
</s:form>

  </body>
</html>
