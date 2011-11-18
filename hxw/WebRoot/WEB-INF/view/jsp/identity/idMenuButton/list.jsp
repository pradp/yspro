<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/include_list_head.jsp" %>
		
		<script type="text/javascript">
		$(document).ready(function(){
			//菜单按层次向后两个空格 
			$("td[id^='td_']").each(function(i){
				var id_len_3 = $(this).attr("id").length /3 - 4;
				var str = "";
				if(id_len_3>0){
					for(var i=0;i<id_len_3;i++){
						str += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
				}
				$(this).html(str + $(this).html());
			});
			//初始化选中 已选中的菜单
			var menues = window.parent.document.getElementById("menues").value;
			var menue = menues.split(",");
			for(var i=0;i<menue.length;i++){
				$("#menu_"+menue[i]).attr("checked","checked");
			}
			//初始化选中 已选中的菜单按钮
			var menuebuttons = window.parent.document.getElementById("menuebuttons").value;
			var menuebutton = menuebuttons.split(",");
			for(var i=0;i<menuebutton.length;i++){
				$("#mb_"+menuebutton[i]).attr("checked","checked");
			}
			//暂时不开放配置按钮功能
			$("input[type='checkbox'][id^='mb_']").attr("disabled","disabled");
			
			//查看状态保存按钮隐藏 输入框只读等
			doReadOnly();
			
		});
		//更新菜单按钮信息
		function tochangeMenuButton(obj){
			if(obj.checked){ //菜单按钮选中时
				var strs = obj.value.split("_")[0];
				var len_3 = strs.length / 3;
				for(var i=2;i<=len_3;i++){
					var str = strs.substr(0,i*3);
					if(!$("#menu_"+str).attr("checked")){ //菜单按钮选中但所属菜单及其上级菜单未选中时
						$("#menu_"+str).attr("checked", "checked"); //选中菜单下的按钮后默认选中该菜单及其上级菜单
						//更新菜单信息
						var menues = window.parent.document.getElementById("menues").value;
						if(menues == null || menues == ''){
							window.parent.document.getElementById("menues").value = $("#menu_"+str).val();
						}else{
							window.parent.document.getElementById("menues").value += ","+$("#menu_"+str).val();
						}
					}
				}
				//更新菜单按钮信息
				var menuebuttons = window.parent.document.getElementById("menuebuttons").value;
				if(menuebuttons == null || menuebuttons == ''){
					window.parent.document.getElementById("menuebuttons").value = obj.value;
				}else{
					window.parent.document.getElementById("menuebuttons").value += ","+obj.value;
				}
			}else{ //菜单按钮取消选中时
				//更新菜单按钮信息
				var menuebuttons = window.parent.document.getElementById("menuebuttons").value;
				var menuebutton = menuebuttons.split(",");
				var curr_menuebuttons = "";
				for(var i=0;i<menuebutton.length;i++){
					if(menuebutton[i]!=obj.value){
						curr_menuebuttons += menuebutton[i] + ",";
					}
				}
				if(curr_menuebuttons.lastIndexOf(",")== curr_menuebuttons.length-1){
					curr_menuebuttons = curr_menuebuttons.substr(0,curr_menuebuttons.length-1);
				}
				window.parent.document.getElementById("menuebuttons").value = curr_menuebuttons;
			}
		}
		//更新菜单信息
		function tochangeMenu(obj){
			if(obj.checked){ //菜单被选中时
				//菜单选中时其上级菜单默认选中
				var len_3 = obj.value.length / 3;
				for(var i=2;i<len_3;i++){
					var str = obj.value.substr(0,i*3);
					if(!$("#menu_"+str).attr("checked")){ //上级菜单未选中时
						$("#menu_"+str).attr("checked","checked");
						var menues = window.parent.document.getElementById("menues").value;
						if(menues == null || menues == ''){
							window.parent.document.getElementById("menues").value = $("#menu_"+str).val();
						}else{
							window.parent.document.getElementById("menues").value += ","+$("#menu_"+str).val();
						}
					}
				}
				//菜单选中时其下级菜单默认选中
				$("input[id^='menu_"+obj.value+"']").each(function(i){
					if(!this.checked){ //上级菜单未选中时
						$(this).attr("checked","checked");
						var menues = window.parent.document.getElementById("menues").value;
						if(menues == null || menues == ''){
							window.parent.document.getElementById("menues").value = $(this).val();
						}else{
							window.parent.document.getElementById("menues").value += ","+$(this).val();
						}
					}
				});
				//处理本级菜单
				var menues = window.parent.document.getElementById("menues").value;
				if(menues == null || menues == ''){
					window.parent.document.getElementById("menues").value = obj.value;
				}else{
					window.parent.document.getElementById("menues").value += ","+obj.value;
				}
			}else{ //菜单取消选中时
				$("input[id^='mb_"+obj.value+"']").each(function(i){ //菜单取消选中时,该菜单及其下级菜单的按钮全部取消选中
					if(this.checked){ //按钮已选中
						$(this).attr("checked", ""); //取消按钮选中
						//更新菜单按钮信息
						var menuebuttons = window.parent.document.getElementById("menuebuttons").value;
						var menuebutton = menuebuttons.split(",");
						var curr_menuebuttons = "";
						for(var i=0;i<menuebutton.length;i++){
							if(menuebutton[i]!=$(this).val()){
								curr_menuebuttons += menuebutton[i] + ",";
							}
						}
						if(curr_menuebuttons.lastIndexOf(",")== curr_menuebuttons.length-1){
							curr_menuebuttons = curr_menuebuttons.substr(0,curr_menuebuttons.length-1);
						}
						window.parent.document.getElementById("menuebuttons").value = curr_menuebuttons;
					}
				});
				//下级菜单取消选中
				$("input[id^='menu_"+obj.value+"']").attr("checked","");
				//更新菜单信息
				var menues = window.parent.document.getElementById("menues").value;
				var menue = menues.split(",");
				var curr_menues = "";
				for(var i=0;i<menue.length;i++){
					if(menue[i].indexOf(obj.value)!=0){
						curr_menues += menue[i] + ",";
					}
				}
				if(curr_menues.lastIndexOf(",")== curr_menues.length-1){
					curr_menues = curr_menues.substr(0,curr_menues.length-1);
				}
				window.parent.document.getElementById("menues").value = curr_menues;
			}
		}
		function changeAll(obj){
			if(!obj.checked){
				$("input[name^='selectNode']").each(function(i){ //二级菜单取消选中时,下级菜单全部取消选中
					if(this.checked){ //该菜单的按钮已选中
						$(this).attr("checked", ""); //选中菜单下的按钮后默认选中该菜单
					}
				});
				//更新菜单信息
				var menues = window.parent.document.getElementById("menues").value;
				var menue = menues.split(",");
				var curr_menues = "";
				for(var i=0;i<menue.length;i++){
					if(menue[i].indexOf(obj.value)!=0){
						curr_menues += menue[i] + ",";
					}
				}
				if(curr_menues.lastIndexOf(",")== curr_menues.length-1){
					curr_menues = curr_menues.substr(0,curr_menues.length-1);
				}
				window.parent.document.getElementById("menues").value = curr_menues;
				//更新菜单按钮信息
				var menuebuttons = window.parent.document.getElementById("menuebuttons").value;
				var menuebutton = menuebuttons.split(",");
				var curr_menuebuttons = "";
				for(var i=0;i<menuebutton.length;i++){
					if(menuebutton[i].indexOf(obj.value)!=0){
						curr_menuebuttons += menuebutton[i] + ",";
					}
				}
				if(curr_menuebuttons.lastIndexOf(",")== curr_menuebuttons.length-1){
					curr_menuebuttons = curr_menuebuttons.substr(0,curr_menuebuttons.length-1);
				}
				window.parent.document.getElementById("menuebuttons").value = curr_menuebuttons;
			}else{ //选中二级菜单时,默认其下级菜单全部选中
				var menues = window.parent.document.getElementById("menues").value;
				if(menues == null || menues == ''){
					window.parent.document.getElementById("menues").value = obj.value;
				}else{
					window.parent.document.getElementById("menues").value += ","+obj.value;
				}
				$("input[name='selectNodeMenu']").each(function(i){ //二级菜单取消选中时,下级菜单全部取消选中
					$(this).attr("checked", "checked"); //选中菜单下的按钮后默认选中该菜单
					menues = window.parent.document.getElementById("menues").value;
					if(menues == null || menues == ''){
						window.parent.document.getElementById("menues").value = this.value;
					}else{
						window.parent.document.getElementById("menues").value += ","+this.value;
					}
				});
			}
		}
		
		</script>
	</head>
  
<body > 
    <div id="scrollContent">
    
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" >
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

			<table class="tableStyle" headFixMode="true">
				<tr>
				    <td align="left" colspan="100">
				    	<s:checkbox id="menu_%{upmenuid}" name="selectNode" fieldValue="%{upmenuid}" onclick="changeAll(this)"/>
				     	<label for="menu_<s:property value="upmenuid"/>"><s:property value="menuname"/></label>
				     	<s:hidden name="upmenuid"/><s:hidden name="roleid"/>
				    </td>
				</tr>
				<tr>
	    			<th align="left">功能点</th>
 					<s:iterator value="listButton">
			    		<th align="left"><s:property value="caption"/></th>
	    			</s:iterator>
				</tr>
	 					<s:iterator value="listMenu" id="lm">
						<tr>
							<td width="180" id="td_<s:property value='id'/>">
						    	<s:checkbox id="menu_%{id}" name="selectNodeMenu" fieldValue="%{id}" onclick="tochangeMenu(this)"/>
						    	<label for="menu_<s:property value="%{id}"/>"><s:property value="caption"/></label>
							</td>
	 						<s:iterator value="listButton" id="lb">
	 							<td>
			 						<s:checkbox id="mb_%{#lm.id}_%{id}" name="selectNodeMenuButton" fieldValue="%{#lm.id}_%{id}" onclick="tochangeMenuButton(this)"/>
					  			</td>
					    	</s:iterator>
					    </tr>
				  </s:iterator>
			</table>
	</div>
  </body>
</html>
