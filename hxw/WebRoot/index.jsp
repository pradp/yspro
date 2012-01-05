<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@page import="com.yszoe.framework.util.DBUtil"%>
<%@page import="com.yszoe.cms.entity.TXxfbLm"%>
<%@page import="com.yszoe.cms.util.CachedQuery"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<title><fmt:message key="application_name" /> - 做中国最专业的心理门户网站 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@include file="WEB-INF/view/jsp/common/public_head_meta.jsp" %>	
  </head>
  
  <body>

	<%@include file="WEB-INF/view/jsp/common/public_head.jsp" %>	

   <br/><br/>
    <div align="center">
	    <br/>
	    这是首页     
	    <br/>
	    ......     
	    <br/><br/><br/> 
	    <!-- 登录 -->
		<div class="rb_right_top">
						<h2>
							<a href="#">登录</a>
						</h2>
		</div>
					<div class="rb_right_div">
				  <iframe frameborder="0" scrolling="no" width="100%" height="150px" src="indexLogin.jsp" ></iframe>
					</div>
		
    </div>
	<%@include file="WEB-INF/view/jsp/common/public_foot.jsp" %>	
  </body>
</html>
