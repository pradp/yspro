<%@ page contentType="text/html;charset=UTF-8" pageEncoding="gb2312"%>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<script>
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
<c:if test="${paginationContext.pageCount>1}">
	<div class="pagination-info clearFix"><span
		title='共<c:out value="${paginationContext.recordCount}"/>条记录 分<c:out value="${paginationContext.pageCount}"/>页显示'>
	共<c:out value="${paginationContext.pageCount}" />页 <c:out
		value="${paginationContext.recordCount}" />条记录 </span> <c:if
		test="${!empty param.paginationAction}">
        \111111111111
      	<c:if
			test="${paginationContext.showStartIndex>paginationContext.showIndexCount}">
			<c:url var="url" value="${param.paginationAction}">
				<c:param name="pageIndex"
					value="${paginationContext.showStartIndex-1}" />
			</c:url>
			<a href='<c:out value="${url}"/>'>&lt;</a>
		</c:if>
		<c:forEach var="x" begin="${paginationContext.showStartIndex}"
			end="${paginationContext.showEndIndex}" step="1" varStatus="status">
			<c:url var="url" value="${param.paginationAction}">
				<c:param name="pageIndex" value="${x}" />
			</c:url>
			<c:choose>
				<c:when test="${paginationContext.pageIndex==x}">
					<div title="当前页"><c:out value="${x}" /></div>
				</c:when>
				<c:otherwise>
					<a href='<c:out value="${url}"/>'
						title='点击跳转到第<c:out value="${x}"/>页'><c:out value="${x}" /></a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if
			test="${paginationContext.pageCount>paginationContext.showEndIndex}">
			<c:url var="url" value="${param.paginationAction}">
				<c:param name="pageIndex"
					value="${paginationContext.showEndIndex+1}" />
			</c:url>
			<a href='<c:out value="${url}"/>'>&gt;</a>
		</c:if>
	</c:if>  

		<c:if
			test="${paginationContext.showStartIndex>paginationContext.showIndexCount}">
			<a href="#"
				onclick="return gotoPage('searchingForm','<c:out value="${paginationContext.showStartIndex-1}"/>')">&lt;</a>
		</c:if>
		<c:forEach var="x" begin="${paginationContext.showStartIndex}"
			end="${paginationContext.showEndIndex}">
			<c:choose>
				<c:when test="${paginationContext.pageIndex==x}">
					<div title="当前页"><c:out value="${x}" /></div>
				</c:when>
				<c:otherwise>
					<a href="#"
						onclick="return gotoPage('searchingForm','<c:out value="${x}"/>')"
						title='点击跳转到第<c:out value="${x}"/>页'><c:out value="${x}" /></a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if
			test="${paginationContext.pageCount>paginationContext.showEndIndex}">
			<a href="#"
				onclick="return gotoPage('searchingForm','<c:out value="${paginationContext.showEndIndex+1}"/>')">&gt;</a>
		</c:if>
	 </div>
</c:if>