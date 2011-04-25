<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>菜单维护</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
	<script type="text/javascript">
	detailPageStyle();
	$(document).ready(function(){
			
			<s:if test="refresh">
			window.parent.window.frames["menuFrame"].location.reload();
			</s:if>
		}
	);
	function submitForm(){
		
		if( !checkInput("menuName","菜单名称不能为空！") ){
			return false;
		}
		if( !checkInput("ordernum","排序值不能为空！") ){
			return false;
		}
		return super_submitForm();
	}
	function submitRemoveMenu(){
		var conf = window.confirm("删除此菜单会同时删除其下所有子菜单！\n\n您确定要删除吗？");
		if(conf==true){
			var ids = document.getElementById("menuid").value;
			if(ids.length>0){
				var url = actionName + "-remove.c";
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
						$("input[@name^=tsysMenu]").each(function(){
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
		var uri = actionName+"-input.c?tsysMenu.upMenuId=<s:property value="tsysMenu.menuid"/>";
		window.location.href = uri;
	}
	</script>
  </head>
  
  <body style="text-align:center;">
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

<div class="framestyle" style="width:98%;">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden id="menuid" name="tsysMenu.menuid" />
  <s:hidden name="tsysMenu.upMenuId" />
  <s:hidden name="tsysMenu.depth" />
 
  <table width="100%" border="0" align="center">
    <tr>
    	<th height="40px" width="100%"><h3><s:if test="tsysMenu.menuid!=null">维护</s:if><s:else>新增</s:else>菜单</h3></th>
    </tr>
  </table>
  
  
    
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="200" height="34" class="wintitle_left"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="11%">&nbsp;</td>
            <td width="89%">&nbsp;</td>
          </tr>
        </table></td>
        <td height="34" class="wintitle_right"><table width="72" border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="winmain_left"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="7" rowspan="2">&nbsp;</td>
            <td>
 <fieldset> 
　 <legend>菜单信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">名称：</td>
      <td width="90%"><s:textfield id="menuName" name="tsysMenu.menuName" maxlength="25" size="30"/> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right"></td>
      <td></td>
    </tr>
    <tr> 
      <td align="right">URI链接：</td>
      <td><s:textfield id="menuPath" name="tsysMenu.menuPath" maxlength="200" size="80" /> </td>
    </tr>
    <tr> 
      <td align="right"></td>
      <td></td>
    </tr>
    <tr> 
      <td align="right">排序值：</td>
      <td><s:textfield id="ordernum" name="tsysMenu.ordernum" maxlength="6" size="6" onkeypress="NumberText(event)"/> <label style="color:red">*</label>
      <font color="#999999">说明：同一层次中数值大的往前排</font></td>
    </tr>
    <tr> 
      <td align="right"></td>
      <td></td>
    </tr>
    <tr> 
      <td align="right">状态：</td>
      <td><s:radio id="menustate" name="tsysMenu.state" list="#{1:'启用', 0:'禁用'}" listKey="key" listValue="value"/> <label style="color:red">*</label></td>
    </tr>
  </table>
  </fieldset>
 
  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle"> 
	  <td colspan="25">&nbsp;</td>
	    <td height="30" colspan="7">
	    		<ul class="btn_gn">
			    <li><a href="#" title="保存此菜单" onclick="submitForm()"><span>保存此菜单</span></a></li>
<s:if test="tsysMenu.menuid!=null">
			    <li><a href="#" title="删除此菜单" onclick="submitRemoveMenu()"><span>删除此菜单</span></a></li>
			    <li><a href="#" title="新增子菜单" onclick="input()"><span>新增子菜单</span></a></li>
</s:if>
<s:else>
			    <li><a href="#" title="返回" onclick="window.history.go(-1)"><span>返回</span></a></li>
</s:else>
			</ul>
	    </td>
	  </tr>
  </table>
  
  
  
</td>
          </tr>
          <tr>
            <td height="30">



            </td>
          </tr>
        </table></td>
        <td width="7" class="winmain_right">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
  
</s:form>
</div>
  </body>
</html>
