<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ page import="javax.portlet.*"%>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ht.article.search.model.Article"%>
<%@page import="org.apache.commons.lang.StringUtils"%><portlet:defineObjects />
<style>
.search-form {
	padding: 20px;
}

.search-form input {
	padding: 1px;
}

.search-content {
	width: 70%;
	padding: 20px;
}

.search-result {
	margin: 20px 0;
}

.search-top {
	background: #eee;
	padding: 4px;
}

.result-title a {
	font-size: 16px;
	text-decoration: underline;
}

.result-info {
	color: #aaa;
	padding: 0 10px;
	white-space: nowrap;
}

.result-content {
	line-height: 150%;
}

.result-site {
	color: #080;
}
</style>
 
<div class="search-form">
<%String term= request.getParameter("term")==null?"":request.getParameter("term");

%>
<form id="searchingForm" method="post"
	action='<portlet:renderURL>
						<portlet:param name="action" value="searchArticle"/>
						 
					</portlet:renderURL>">'>
<table>
	<tr>
		<td style="vertical-align: middle;">&nbsp;&nbsp;关键字&nbsp;&nbsp;</td>
		<td><input name="term" type="text"
			value="<%=term%>" size="30" />&nbsp;&nbsp;</td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="搜 索" /></td>

	</tr>

</table>
</form>
</div>
<div class="search-top">检索结果</div>

<div class="search-content">
<%
if( request.getAttribute("searchResultList")!=null){
 
List searchResultList = (List) request.getAttribute("searchResultList");


	for (Iterator iterator = searchResultList.iterator(); iterator.hasNext();) {
		Article art = (Article) iterator.next();%>
		<div class="search-result">
			<div class="result-title">
				<a href='<%=art.getArtUrl() %>' target="_blank"> <%=art.getArtTitle() %></a>
			</div>
		</div>
		
	<% }%>
<%
	term=StringUtils.isEmpty(term)?"":term;
	if(searchResultList.size()<1) {%>抱歉，没有找到与“<span style="color: red;"><%=term%></span>”相关的内容<%} 
}else{
	System.out.println("  null");
}
%>
</div>
<c:import url="/WEB-INF/jsp/pagination.jsp">
	<c:param name="formId" value="searchingForm" />
</c:import>