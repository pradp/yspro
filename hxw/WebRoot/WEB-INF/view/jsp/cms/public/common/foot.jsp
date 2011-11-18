<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<img src="../faceui/images/index_90.jpg" border="0" height="6" width="960"/>
<!--footer_begin-->
<div class="footer page2">
版权所有     北京市畜牧兽医总站   
<%
Calendar calendar=Calendar.getInstance();//不能用new方法。
     int year=calendar.get(Calendar.YEAR); 
     if( year != 2011){
%> 
©2011-<%=year %><br />
<%
     }else{
%>
©2011<br />
<%	 
     }
%>
电话：010-84929056&nbsp;&nbsp;&nbsp;84929053　  地址：北京市朝阳区安外北宛路甲15号       
邮编100107<br>
技术支持：<a target="_blank" href="http://www.njfstech.com">南京丰顿科技有限公司</a>      
电话：025-86983857
</div>
<!--footer_end-->

