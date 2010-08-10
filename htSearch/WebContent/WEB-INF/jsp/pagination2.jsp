<%@ page contentType="text/html;charset=UTF-8" pageEncoding="gb2312"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>

<%@page import="com.ht.pagination.PaginationContext"%><script>
function gotoPage(f, p) {
	var frm = document.getElementById(f);
	var input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'pageIndex';
	input.value = p;
	frm.appendChild(input);
	frm.submit();
	return false;
}
function gotoPage(f, p) {
	var frm = document.getElementById(f);
	var input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'pageIndex';
	input.value = p;
	frm.appendChild(input);
	frm.submit();
	return false;
}


</script>
 
<style>
.pagination-info {
	padding: 5px;
	line-height: 130%;
}

.pagination-info span {
	display: block;
	float: left;
	padding: 2px 6px;
}

.pagination-info a,.pagination-info div,.pagination-info span {
	display: block;
	float: left;
	border: 1px solid #DFE2E7;
	padding: 2px 6px;
	margin: 0 2px;
}

.pagination-info div {
	font-weight: bold;
	color: #000;
	background: #eee;
}

.pagination-info a:hover {
	background: #eee;
	color: #00c;
}
</style>
<%
PaginationContext paginationContext=(PaginationContext)request.getAttribute("paginationContext");
int pageCount=paginationContext.getPageCount();
int recordCount=paginationContext.getRecordCount();
 
int showStartIndex =paginationContext.getShowStartIndex();
int showEndIndex =paginationContext.getShowEndIndex();
int showIndexCount=paginationContext.getShowIndexCount();
int  pageIndex=paginationContext.getPageIndex();
%> 
<%if(pageCount>1) {
	
	
%>

<div class="pagination-info clearFix">
	<span	title='��<%=recordCount %>����¼ ��<%=pageCount %>ҳ��ʾ'>��<%=pageCount %>ҳ <%=recordCount %>����¼ </span> 
	 
	<%if(showStartIndex>showIndexCount){ %>
		<a href="#"	onclick="return gotoPage('searchingForm','<%=showStartIndex-1 %>')">&lt;</a>
	<%} %>
	
	<%for(int i=showStartIndex;i<showEndIndex;i++){ 
		if(pageIndex==i){%>
			<div title="��ǰҳ"><%=i %></div>
		<%}else{ %>
		
			<a href="#"	onclick="return gotoPage('searchingForm','<%=i %>')" title='�����ת����<%=i %>ҳ'><%=i %></a>
		<%} %>
	
	<%} %>
	<%if(pageCount>showEndIndex){ %>
		<a href="#"	onclick="return gotoPage('searchingForm','<%=showEndIndex+1 %>')">&lt;</a>
	<%} %>
	
<%} %>
</div> 