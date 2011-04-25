<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title><s:text name="error.name"/></title>

	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="css/text">
		div{
			line-height:30px;
			padding-bottom:20px;
			margin:20px;
		}
	</style>
  </head>
  
  <body>
<div style="color:green;">您刚才的操作发生了异常：</div>
<div id="error" style="background-color:#FFFFCC;height:100px;">
	<div style="color:red;"><s:actionerror/></div>
	<div style="color:red;"><s:fielderror/></div>
	<div style="color:#000000;"><s:actionmessage/></div>
	<div style="color:red;padding-left:20px; padding-top:30px"><s:property value="exception"/></div>
	<br/>
     <div style="display:none;text-align:left; padding-left:80px; padding-right:80px;">
        <s:property value="exceptionStack"/>
     </div>
</div>
<div style="color:green;">如果不能确定错误原因，请尽快与管理人员联系，报告此问题。⡣</div>
<div><br/></div>
<div><input type="button" value=" 返回 " onclick="history.back()"/> </div>
  </body>
</html>
