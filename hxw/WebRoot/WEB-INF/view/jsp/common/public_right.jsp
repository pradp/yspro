<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:useBean id="indexPageQuery" scope="application" class="com.yszoe.biz.IndexPageQuery" />
<jsp:useBean id="StringUtil" scope="application" class="com.yszoe.util.StringUtil" />
<link rel="stylesheet" rev="stylesheet" href="../../resources/jquery/plugins/tab/kandytabs.css" />
<script type="text/javascript" src="../../resources/jquery/plugins/tab/kandytabs.pack.js"></script>
<script type="text/javascript">
  $(function(){
    $("#ktabs").KandyTabs();
    $(".order a").each(function(){
			  var html = $(this).html();
			  if(html.length > 13){
				html = html.substr(0,13);
				var ht = html+"...";
				$(this).html(ht);
			  }else{
			    $(this).html(html);
			  }
	});
})
</script>
 <%--right_begin--%>
<div class="w250 fr">
    <div class="rb_right_top">
      <h2>推荐课程</h2>
    </div>
  <div class="rb_right_div">
     <!--推荐课程Begin-->
       <div class="w98">
         <ul class="order">
          <c:forEach var="Tjentity" items="${indexPageQuery.tjlist}" varStatus="status">
	        <li><a href="../html/${Tjentity.lmwid }-${Tjentity.wid}.jhtm" target="_blank" title="${Tjentity.bt}">${Tjentity.bt}</a></li> 
	      </c:forEach>
         </ul>
      </div>
    <!--End-->
    <div id="ktabs">
    <!--热门活动_Begin-->
      <h2>热门活动</h2>
      <div>
        <ul class="order">
          <c:forEach var="Rmentity" items="${indexPageQuery.rmlist}" varStatus="status">
	         <li><a href="../html/${Rmentity.lmwid }-${Rmentity.wid }.jhtm" target="_blank" title="${Rmentity.bt}">${Rmentity.bt}</a></li>
	      </c:forEach>
        </ul>
      </div>
    <!--_End-->
    <!--最新文库_Begin-->
       <h2>最新文库</h2>
       <div>
        <ul class="order">
          <c:forEach var="Tjentity" items="${indexPageQuery.tjlist}" varStatus="status">
	        <li><a href="../html/${Tjentity.lmwid }-${Tjentity.wid}.jhtm" target="_blank" title="${Tjentity.bt}">${Tjentity.bt}</a></li> 
	      </c:forEach>
        </ul>
       </div>
    <!--_End-->
    </div>
   
  </div>
</div>
 <%--right_end--%>