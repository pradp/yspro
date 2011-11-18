<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>

    <title>输出对象集合的例子</title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<script type="text/javascript" src="../resources/jquery/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="../resources/js/common/webutil.js"></script>
	<script type="text/javascript" src="../component/ymprompt/ymPrompt_source.js"></script>
	<link rel="stylesheet" type="text/css" href="../component/ymprompt/skin/dmm-green/ymPrompt.css">
	
		<!--分页start-->
		<script type="text/javascript" src="../component/jquery.pagination/jquery.pagination.js"></script>
		<link rel="stylesheet" type="text/css" media="all" href="../component/jquery.pagination/pagination.css" />
		<!--分页end-->
	<script type="text/javascript">

	</script>
  </head>
  
<body>

    <div id="listC" style="text-align:center;">
    <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="70%">
		<tr align="center">
    	<form method="post" name="ysform">
		<input type="hidden" name="formname" value="ysform"/>
		<input type="hidden" name="currentPageno" id="yspager_currentPageno" value="${pager.currentPageno }"/>
				<td align="center" nowrap="nowrap" class="">&nbsp;标题:
					<input name="bt" maxlength="50" value="${bt }"/>
				</td>
		</form>
				<td align="center" nowrap="nowrap">&nbsp;
					<input type="button" id="searchButton" name="btn3" value="查询" onClick="super_doSearch();">                      
    			</td>
		</tr>
	</table>
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="90%">
    		<tr>
    			<td height="30px" colspan="10">
			<button onclick="openEntity()"><span class="icon_add">新增</span></button>
			<button onclick="doModify()"><span class="icon_edit">修改</span></button>
			<button onclick="doRemove()"><span class="icon_delete">删除</span></button>
    			</td>
    		</tr>
    	</table>
    	<table id="listTable" border="1" cellspacing="0" cellpadding="0" width="70%">
    		<thead id="listHead">
    		<tr>
    			<td height="20px" width="5%"></td>
    			<td width="12%">编号</td>
    			<td width="25%">标题</td>
    			<td >操作</td>
    		</tr>
    		</thead>
    		<tbody id="listData">
    	<c:forEach var="bean" items="${resultList}" varStatus="status">
    		<tr>
    			<td><input type="checkbox" name="selectNode" id="${bean.wid }" value="${bean.wid }"/> </td>
    			<td>
    				<a href="javascript:openEntity('${bean.wid }')">${bean.wid }</a>
    			</td>
    			<td>
    				${bean.bt }
    			</td>
    			<td align="left">
    			[<a href="javascript:openEntity('${bean.wid }')" >编辑</a>]
    			</td>
    		</tr>
		</c:forEach>
    		</tbody>
    	</table>
    	<table border="0" cellspacing="0" cellpadding="0" width="90%">
    		<tr>
    			<td colspan="10" align="right">
    				${pager.postToolBar }
    			</td>
    		</tr>
    	</table>
	<script language="javascript">
		function trunPage(){
			var reqPageNo = document.getElementById('pager_currentPageno').value;
			if( reqPageNo<1 || reqPageNo>${pager.totalPages } ){
					alert('当前的有效页码是小于或等于${pager.totalPages }的正整数，请重新输入！');
					return;
			}
			$("#yspager_currentPageno").val($("#pager_currentPageno").val());
			$("#yspager_eachPageRows").val($("#eachPageRows").val());//让spring可以接收，转为bean
			document.forms[0].submit();
		}
	</script>
    </div>
  </body>
</html>
