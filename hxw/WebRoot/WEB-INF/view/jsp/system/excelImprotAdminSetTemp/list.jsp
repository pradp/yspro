<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>配置导入规则</title>
		
	<%@include file="../../common/include_list_head.jsp" %>
	
	<script type="text/javascript">
		$(function(){
			//配置浮动面板显示记录 
			index_labels = ['3_a','4'];
			view_rules = '{1}（{2}）';
		})
		function openPage(url){
			var windowWidth = document.body.clientWidth - 200;
			if(windowWidth<600){
				windowWidth += 160;
			}
			var windowHeight = document.body.clientHeight - 60;
			openWindow(url,windowWidth,windowHeight);
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
    
		<div id="userRoleMenuButton">
			<button onclick="openEntity()"><span class="icon_add">新增</span></button>
		    <button onclick="doModify()"><span class="icon_edit" title="">修改</span></button>
		    <button onclick="doRemove()"><span class="icon_delete" title="">删除</span></button>
		</div>

		<div>
		  <table class="tableStyle" headFixMode="true" useMultColor="false" useCheckBox="false">
    		<tr>
    			<th height="20px" width="5%"><s:checkbox name="selectAll" onclick="doSelectAll();"/></th>
    			<th width="20%">模板标示号</th>
    			<th width="35%">模板名称</th>
    			<th width="20%">对应表名</th>  
    			<th width="20%">操作</th>  			   			
    		</tr>
    		<s:iterator value="resultData" status="stat">
	    		<tr>
	    			<td ><s:checkbox id="%{resultData[#stat.index][0]}" name="selectNode" fieldValue="%{resultData[#stat.index][0]}"/></td>
	    			<td>
	    				<s:property value="%{resultData[#stat.index][0]}"/>
	    			</td>
	    			<td>
	    				<a href="javascript:openEntity('<s:property value="%{resultData[#stat.index][0]}"/>')">
	    					<s:property value="resultData[#stat.index][1]"/>&nbsp;
	    				</a>&nbsp;
	    			</td>    			
	    			<td>
	    				<s:property value="resultData[#stat.index][2]"/>&nbsp;
	    			</td>   
	    			<td>
	    				<a href="javascript:openPage('./excelImportAdminSetup-input.action?tempID=<s:property value="%{resultData[#stat.index][0]}"/>',1024,500)">编辑模板</a>
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
