<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
	<div id="footer" class="grid_16" align="left"><!-- footer begin -->
      <p>
	  
	  <s:if test="getUserLoginId() != null && getUserLoginId() != '' " >
		 	<a href="../visitor/sportCjTdHz-list.c?cssS=1" >首 页</a> | 
		    <a href="../visitor/sportCjcxDbt-list.c?jp=3&cssS=2">代表团成绩榜</a> | 
	        <a href="../visitor/sportCjcxRcZk-list.c?cssS=4">赛程查询</a> | 
		    <a href="../visitor/sportDxmmc-list.c?cssS=5">项目查询</a> | 
		    <a href="../visitor/sportCjcxPjl-list.c?cssS=6">破纪录查询</a> |
	        <a href="../visitor/sportCjcxZhcjb-list.c?cssS=9">其他奖项</a> |
		    <a href="../visitor/sportCjcxNbbd-list.c" title="代表团全部成绩榜">代表团全部成绩榜 </a>|
			<a href="../visitor/sportCjcxXscjb-list.c?cssS=3" title="区县成绩榜" >区县成绩榜</a> 
		</s:if>
		<s:else>
		   <a href="sportCjTdHz-list.html" >首 页</a> | 
	       <a href="sportCjcxDbt-nj.html">代表团成绩榜</a> | 
	       <a href="sportCjcxRcZk-list.html">赛程查询</a> | 
	       <a href="sportDxmmc-list.html">项目查询</a> | 
	       <a href="sportCjcxPjl-list.html">破纪录查询</a> |
	       <a href="sportCjcxZhcjb-list.html">其他奖项</a>
	  
		</s:else>
	  
	  </p>
      <p>Copyright © 2010 17thjsgames.org.cn. All rights reserved. technical support <a href="http://www.jundoo.com.cn" style="text-decoration :underline" target="_blank" >jundoo.com.cn</a> </p>
	</div>
