<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@page import="com.yszoe.framework.util.DBUtil"%>
<%@page import="com.yszoe.cms.entity.TXxfbLm"%>
<%@page import="com.yszoe.cms.util.CachedQuery"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<title><fmt:message key="application_name" /> - 会员中心 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@include file="../../common/usercenter_head_meta.jsp" %>	
  </head>
  
  <body>
  
	<%@include file="../../common/usercenter_head.jsp" %>
	
	<%@include file="../../common/usercenter_left.jsp" %>
	
   <br/><br/>
    <div style="float: left; width:69%">
	    <br/>
	    这是会员主页     
	    <br/>
	    ......     
	    <br/>
	    
    </div>
    
	<%@include file="../../common/public_foot.jsp" %>	
	
  </body>
</html>
