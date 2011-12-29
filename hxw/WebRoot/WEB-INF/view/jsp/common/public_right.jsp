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
   <!-- 在线答疑_begin -->
    <h2><span>在线答疑</span></h2>
	<div class="w98">
	  <dl class="rmpl">
	       <c:forEach var="Dyentity" items="${indexPageQuery.answerList}" varStatus="status" begin='0' end='3'>
			<dt><span> ${status.index+1}、${StringUtil.getShortTitle( Dyentity.appealid, 5 )}</span>： <a>${StringUtil.getShortTitle( Dyentity.attach, 10) }</a></dt>
			<dd>${StringUtil.getShortTitle( Dyentity.expertid, 5 )}：${StringUtil.getShortTitle( Dyentity.answer, 30) }</dd>
			<dd class="line"></dd>
		   </c:forEach>
	  </dl>
	</div>
	</div>
</div>
 <%--right_end--%>