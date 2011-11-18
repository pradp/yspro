<%@page import="com.yszoe.util.DateUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@ page import="com.yszoe.cms.entity.TXxfbLm"%>
<%@ page import="com.yszoe.cms.entity.TXxfbWz"%>
<%@ page import="com.yszoe.biz.entity.TExpertqaAppealadd"%>
<%@ page import="com.yszoe.biz.entity.TExpertqaExperts"%>
<%@ page import="com.yszoe.sys.entity.TSysCode"%>
<%@ page import="com.yszoe.util.StringUtil"%>
<%@ page import="com.yszoe.cms.util.CachedQuery"%>
<%@ page import="com.yszoe.framework.util.DBUtil"%>
<%@page import="com.yszoe.sys.util.SysConfigUtil"%>
<jsp:useBean id="showBean" scope="application" class="com.yszoe.biz.IndexPageQuery" />
<%
//用于循环查询各栏目得出最新10条	
String[] lmWids = {"000001","000002001","000002003","000002002","000002004"};
	
	String tzgg = lmWids[0];//通知公告 
	String zxdt = lmWids[1];//中心动态 
	String gfbz = lmWids[2];//规范标准 
	String hydt = lmWids[3];//行业动态 
	String zcfg = lmWids[4];//政策法规 
	String zlxz = "000005";//资料下载
	String pzjs = "000007";//品种介绍 
	String fyjs = "000008";//繁育技术

	//String DhiLogoutUrl = SysConfigUtil.getString("DhiLogoutUrl");
	
	Calendar calendar = Calendar.getInstance();//不能用new方法。
	int year = calendar.get(Calendar.YEAR);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><fmt:message key="application_name" /> </title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=7" />
		<link type="text/css" rel="stylesheet" href="faceui/css/layout.css" />
		<script type="text/javascript" src="resources/jquery/jquery-1.6.2.min.js"></script>
		<script type="text/javascript" src="faceui/js/common.js"></script>
		<script type="text/javascript" src="faceui/js/tab.js"></script>
		<script type="text/javascript" src="faceui/js/wsdyIndex.js"></script>
		<script type="text/javascript" src="faceui/js/indexSy.js"></script>
		<style type="text/css">
		body{
			background-color: #FFFFFF
		}
		#headmenu li
		{
			list-style: none;
			float: left;
		}
		#headmenu li a
		{	display: block;
			margin: 8px 1px 0 4px;
			padding: 4px 8px;
			width: 65px;
			color: #FFF;
			font-weight:bold;
			text-align: center;
			text-decoration: none
		}
		#headmenu li a:hover
		{
			background: #F5F5F5;
			color: #FD9305
		}
		#headmenu div
		{	position: absolute;
			visibility: hidden;
			margin: 0;
			padding: 0;
		}
		#headmenu div a{	
			width: 65px;
			position: relative;
			display: block;
			margin: 0 1px 0 4px;
			padding: 7px 8px 3px 8px;
			white-space: nowrap;
			text-align: center;
			text-decoration: none;
			background: #f5f5f5;
			color: #FD9305;
		}
		#headmenu div a:hover{	
			background: #F8AD13;
			color: #FFF
		}
		</style>
	</head>

	<body>
	<%--header_begin--%>
	<div id="header" class="box">
	  <div id="logo" class="page box">
	    <div class=""><img src="faceui/images/index_03.gif" border="0" width="960" /></div>
	  </div>
	<fmt:bundle basename="sysconfig" >
	    <div id="menu" class="page box relative" align="center">
	      <ul id="headmenu">
		   <li class="menu_first"><a href="index.jsp" id="index"><span>首 页</span></a></li>
		   <li><a href="channel/tzgg.jhtm" id="tzgg"><span>通知公告</span></a></li>
		   <li><a href="farms/index.jhtm" id="farms"><span>种畜禽场</span></a></li>
		   <li><a href="#" id="zzyz" onmouseover="mopen('m1')" onmouseout="mclosetime()"><span>种猪育种</span></a>
		       <div id="m1" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
		           <a href="http://www.bcage.org.cn/docc/zcxx.jsp" target="_blank">综合查询</a>
		           <a href="http://www.bcage.org.cn/docc/cdxxquery.jsp?sendLocation=/docc/cdxxquery.jsp" target="_blank">网络育种</a>
		       </div>
		   </li>
		   <li><a href="logindhi.jsp" id="dhi"><span style="font-family:新宋体;">奶牛DHI</span></a></li>
		   <li><a href="identity/index.action" id="scjc"><span style="font-family:新宋体;">生产监测</span></a></li>
		   <li><a href="channel/zhzx.jhtm" class="hide" id="zxdt1" onmouseover="mopen('m2')" onmouseout="mclosetime()"><span>综合资讯</span></a>
		      <div id="m2" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
		           <a href="channel/zxdt.jhtm">中心动态</a>
		           <a href="channel/hydt.jhtm">行业动态</a>
		           <a href="channel/gfbz.jhtm">规范标准</a>
		           <a href="channel/zcfg.jhtm">政策法规</a>
		       </div>
		   </li>
		   <li><a href="channel/pzjs.jhtm" id="pzjs" class="hide"><span>品种介绍</span></a></li>
	       <li><a href="channel/fyjs.jhtm" id="fyjs" class="hide"><span>繁育技术</span></a></li>
		   <li><a href="answer/index.jhtm" id="answer" class="hide"><span>网上答疑</span></a></li>
	       <li><a href="channel/zlxz.jhtm" id="zlxz" class="hide"><span>资料下载</span></a></li>
		 </ul>   
	    </div>
    </fmt:bundle>
  </div> 
<%--header_end--%>

<%--body_begin--%>
	<div id="main">
			<div class="page box">
				<div class="w700 fl box">
					<div class="rb_top"></div>
					<div class="rb_mid box">
						<div class="w300 fl">
							<div class="jdt">
								<script src="faceui/js/AC_RunActiveContent.js"
									type="text/javascript">
</script>
								<script language="JavaScript" type="text/javascript">
	var data = "<%=showBean.getXxfbWzDdxw()%>";
	
	var pics = ''; //图片路径 
	var links = ''; //图片链接 
	var texts = ''; //文本说明 
	if(data!=null && data!="[]" && data!=''){
		var jsonarray = eval("("+data+")");
		for(var i=0;i<jsonarray.length;i++){
			var obj = jsonarray[i];
			pics += obj.src;
			links += "."+obj.url;
			texts += obj.title;
			if(i!=jsonarray.length-1){
				pics += '|';
				links += '|';
				texts += '|';
			}
		}
	}
var focus_width = 284; //图片宽度 
var focus_height = 201; //图片高度 
var text_height = 21; //文本高度 
var swf_height = focus_height + text_height; //图片高度和文本高度相加之和最好是偶数,否则数字会出现模糊失真 
AC_FL_RunContent(
		'codebase',
		'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0',
		'width', focus_width, 'height', swf_height, 'src', 'swf/playswf',
		'quality', 'high', 'pluginspage',
		'http://www.macromedia.com/go/getflashplayer', 'wmode', 'opaque',
		'menu', 'false', 'movie', 'faceui/flash/playswf', 'allowScriptAccess',
		'sameDomain', 'FlashVars', 'pics=' + pics + '&links=' + links
				+ '&texts=' + texts + '&borderwidth=' + focus_width
				+ '&borderheight=' + focus_height + '&textheight='
				+ text_height, 'bgcolor', '#eeeeee'); //最后的#eeeeee为文本背景颜色，可自行修改 

</script>
							</div>
							<div class="shrd">
								<h2>
									<a href="farms/index.jhtm" " target="_blank">种畜禽场展示</a>
								</h2>
								    <div id="scrollBox2" style="height: 145px;overflow:hidden;line-height:24px;">
								        <ul class="order">
									    </ul>
								</div>			
							</div>
						</div>
						<div class="w400 fr">
							<ul class="topnews">
									<%
									//首页推荐两条新闻
										List recommends = showBean.getTop2RecommendArticles();
										if (null != recommends && recommends.size()> 0) {
											for(int i=0;i<recommends.size();i++){
												TXxfbWz recommend = (TXxfbWz) recommends.get(i);
												String bt = recommend.getBt();
									%>
								<li class="toptext <%if(i>0){ %>line<%} %>">
												<%
												if ("2".equals(recommend.getWzlx())) {
												%>
									<a href=<%=recommend.getBturl()%> title="<%=bt%>" target="_blank"><h3><%=StringUtil.getShortTitle(bt, 22)%></h3>
									</a>
									<p><%=recommend.getZy() %></p>
												<%
												} else {
												%>
									<a href="html/<%=recommend.getLmwid() %>-<%=recommend.getWid()%>.jhtm" title="<%=bt%>"
										target="_blank"><h3><%=StringUtil.getShortTitle(bt, 22)%></h3>
									</a>
									<p><%=recommend.getZy() %></p>
									<%
												}
											}
										}
									%>
								</li>
							</ul>
							<ul class="topnews">
								<%
								//各栏目取最新3条新闻。不包括：头条推荐2条、品种介绍栏目、资料下载栏目、育种技术栏目
								for(int i=0;i<lmWids.length;i++){
									//List newArticles = showBean.getTop10NewArticles();
									List newArticles = showBean.getTopArticlesByChannel(lmWids[i], 2);
									if (null != newArticles) {
										for (int m = 0; m < newArticles.size(); m++) {
												TXxfbWz newArticle = (TXxfbWz) newArticles.get(m);
								%>
								<li>
									<span><a href="channel/<%=newArticle.getLmwid()%>.jhtm" target="_blank">[<%=newArticle.getFbt()%>]</a></span>
												<%
												if ("2".equals(newArticle.getWzlx())) {//超链接
												%>
									<a href="<%=newArticle.getBturl()%>" target="_blank" title="<%=newArticle.getBt()%>"><%=StringUtil.getShortTitle(newArticle.getBt(), 16)%></a>
												<%
												}else{
												%>
									<a href="html/<%=newArticle.getLmwid()%>-<%=newArticle.getWid()%>.jhtm" target="_blank" title="<%=newArticle.getBt() %>"><%=StringUtil.getShortTitle(newArticle.getBt(), 16)%></a>
												<%
												}
												
												if ("3".equals(newArticle.getWzlx())) {//导读，有图 
												%>
												<img src="faceui/images/img.gif" alt="图片导读文章"/>
												<%
												}
												
												if (2==newArticle.getOrdernum()) {//永久置顶 
												%>
												<img src="clientui/images/layout/pin-dn-on.gif" border="0" alt="永久置顶" />
												<%
												}else if (1==newArticle.getOrdernum()) {//置顶 
												%>
												<img src="clientui/images/layout/pin-dn-off.gif" border="0" alt="置顶" />
												<%
												} 
												
												if ("1".equals(newArticle.getSftj())) {//判断文章是否推荐  
												%>
												<img src="faceui/images/finger.gif" alt="推荐"/>
												<%
												}
												%>
											<em><%= DateUtil.formatDate(newArticle.getZhxgrq(), "yyyy.MM.dd")%></em>
								</li>
								<%
										}
									}
								}
								%>

							</ul>
						</div>
					</div>
					<div class="rb_low"></div>
				</div>
				<!-- begin end -->
				<!--mright_begin-->
				<div class="w250 fr">
					<!-- 登录 -->
					<div class="rb_right_top">
						<h2>
							<a href="#">登录</a>
						</h2>
					</div>
					<div class="rb_right_div">
				  <iframe frameborder="0" scrolling="no" width="100%" height="120px" src="indexLogin.jsp" ></iframe>
					</div>
				  
					<div class="rb_right_low"></div>
					<!-- 资料下载 -->
					<div class="rb_right_top mt5">
						<h2>
							<a href="channel/zlxz.jhtm" target="_blank">资料下载</a>
						</h2>
					</div>
					<div class="rb_right_div">
						<ul class="order">
								<%
								//资料下载信息
								List zlxzs = showBean.getTop10ArticlesByChannel(zlxz);
									if (null != zlxzs) {
										for (int m = 0; m < zlxzs.size(); m++) {
												TXxfbWz newArticle = (TXxfbWz) zlxzs.get(m);
								%>
								<li>
												<%
												if ("2".equals(newArticle.getWzlx())) {//超链接
												%>
									<a href="<%=newArticle.getBturl()%>" target="_blank" title="<%=newArticle.getBt()%>"><%=StringUtil.getShortTitle(newArticle.getBt(), 16)%></a>
												<%
												}else{
												%>
									<a href="html/<%=newArticle.getLmwid()%>-<%=newArticle.getWid()%>.jhtm" target="_blank" title="<%=newArticle.getBt() %>"><%=StringUtil.getShortTitle(newArticle.getBt(), 16)%></a>
												<%
												}
												
												if ("3".equals(newArticle.getWzlx())) {//导读，有图 
												%>
												<img src="faceui/images/img.gif" alt="图片导读文章"/>
												<%
												}
												
												if (2==newArticle.getOrdernum()) {//永久置顶 
												%>
												<img src="clientui/images/layout/pin-dn-on.gif" border="0" alt="永久置顶" />
												<%
												}else if (1==newArticle.getOrdernum()) {//置顶 
												%>
												<img src="clientui/images/layout/pin-dn-off.gif" border="0" alt="置顶" />
												<%
												} 
												
												if ("1".equals(newArticle.getSftj())) {//判断文章是否推荐  
												%>
												<img src="faceui/images/finger.gif" alt="推荐"/>
												<%
												}
												%>
								</li>
								<%
										}
									}
								%>

						</ul>
					</div>
					<div class="rb_right_low"></div>
					<!-- 资料下载 end  -->
				</div>
				<!--mright_end-->
			</div>

				<%-- 品种介绍 bigin --%>
				<div id="scrollBox">
				    <h2>
					   <a href="channel/pzjs.jhtm" target="_blank">品种介绍</a>
					</h2>
					<ul class="jctw" id="scrolls">
						<%
							List pzjss = showBean.getTop10ArticlesByChannel(pzjs);
							if (null != pzjss) {
								for (int t = 0; (t < pzjss.size()) && (t < 6); t++) {
									TXxfbWz pzjs_1 = (TXxfbWz) pzjss.get(t);
									if (t == 0) {
						%>
						<%
							}
						%>
						<li>
							<a href="html/<%=pzjs_1.getLmwid()%>-<%=pzjs_1.getWid()%>.jhtm" target="_blank"><img
									src=<%=pzjs_1.getSyydt()%> alt=<%=pzjs_1.getBt()%>><span><%=StringUtil.getShortTitle(pzjs_1.getBt(), 10)%></span>
							</a>
						</li>
						<%
							}
							}
						%>
					</ul>
				</div>
				<%--品种介绍 end --%>

				<!--第三横栏区域_begin-->
				<div class="page2 box">
					<div class="w700 fl">
						<div class="left_top">
							<h2 class="w340 fl">
								<a href="channel/fyjs.jhtm" target="_blank">繁育技术专栏</a>
							</h2>
							<h2 class="w340 fr">
								<a href="answer/index.jhtm" target="_blank">专家答疑</a>
							</h2>
						</div>
						<div class="box"></div>
						<div class="left_div box">
							<div class="line-right pr10 mt5 fl">
								<ul class=" w340">
									<%
										//繁育技术
										List fyjss = showBean.getTopArticlesByChannel(fyjs, 12);
										if (null != fyjss && fyjss.size() > 0) {
											for (int m = 0; m < fyjss.size(); m++) {
												TXxfbWz fyjs_1 = (TXxfbWz) fyjss.get(m);
												if ("2".equals(fyjs_1.getWzlx())) {
									%>
									<li style="line-height: 26px; padding-left:20px">
										・ <a href="<%=fyjs_1.getBturl()%>" target="_blank"><%=StringUtil.getShortTitle(fyjs_1.getBt(), 18)%></a>
									</li>
									<%
												} else {
									%>
									<li style="line-height: 26px; padding-left:20px">
										・ <a href="html/<%=fyjs_1.getLmwid()%>-<%=fyjs_1.getWid()%>.jhtm" target="_blank"><%=StringUtil.getShortTitle(fyjs_1.getBt(), 18)%></a>
									</li>
									<%
												}
											}
										}
									%>
								</ul>
							</div>
							
							<div class="mt5 fl">
								<ul class="list">
									<dl class="rmpl">
										<%
											List dygbs = showBean.getAnswerList();
											if (null != dygbs && dygbs.size() != 0) {
												for (int m = 0; m < dygbs.size(); m++) {
													TExpertqaAppealadd dygb_1 = (TExpertqaAppealadd) dygbs.get(m);
										%>
										<dt>
											<span><%=StringUtil.getShortTitle(dygb_1.getAppealid(), 5)%></span>：<a><%=StringUtil.getShortTitle(dygb_1.getAttach(), 15)%></a>
										</dt>
										<dd>
											<span><%=StringUtil.getShortTitle(dygb_1.getExpertid(), 5)%></span>：
											<a title="<%=dygb_1.getAnswer()%>"><%=StringUtil.getShortTitle(dygb_1.getAnswer(), 40)%></a>
										</dd>
										<dd class="line"></dd>
										<%
											}
											}
										%>
									</dl>
								</ul>
							</div>
						</div>
						<div class="left_low"></div>
					</div>

					<div class="w250 fr">
						<div class="pink_right_top">
							<h2>
								<a href="#">网上答疑</a>
							</h2>
						</div>
						<div class="pink_right_div" style="min-height: 190px;">
							<div class="w98">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tableCSS">
								  <form action="" name="wsdy" method="post">
									<tr>
										<td valign="top">
											<table width="95%" border="0" align="center" cellpadding="0"
												cellspacing="0">
												<tr>
													<td width="31%" height="30" align="right">
														姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：
													</td>
													<td width="69%" height="30" align="left">
														<input type="text" name="wen" id="wen" />
													</td>
												</tr>
												<tr>
													<td height="30" align="right">
														联系方式：
													</td>
													<td height="30" align="left">
														<input type="text" name="dian" id="dian" />
													</td>
												</tr>
												<tr id="selectZJ">
													<td height="30" align="right">
														专&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家：
													</td>
													<td height="30" align="left"><input type="hidden" id="hid" name="hid"/>
														<select name="xz" id="xz" onchange="selectZJ()" style="width:35%">  
															<option value="">
																&nbsp;
															</option>
															<%
															  List xzs = showBean.tableXzQuery();
															  if(null != xzs && !xzs.isEmpty())
									                          for( int p = 0;p < xzs.size();p++){
									                        	  TSysCode xz_1 = (TSysCode)xzs.get(p);
								                           %>
								                           <option value="<%= xz_1.getZdbm() %>"><%= xz_1.getZdmc() %>&nbsp;</option>
								                           <%
								                             }
														   %>
														</select>
														<script type="text/javascript">
														      function selectZJ(){
														         $('#zhi').show();
                                                                  var xz = $('#xz').val();
                                                                  var fff = $("#hid").val();
                                                                  if(fff == null || fff == ''){
                                                                  	$("#hid").val($('#zhi').html());
                                                                  }else{
                                                                  	$("#zhi").html($('#hid').val());
                                                                  }
                                                                 $("#zhi option").each(function(){
                	                                              var id = this.id;
                	                                              if(id!='' && id.indexOf(xz+"_") != 0){
                		                                          	$(this).remove();
                	                                              }
                                                                })
                                                                }
                                                        </script>
														<select name="zhi" id="zhi" style="width:35%">
															<option value="">
																&nbsp;
															</option>
															<% 
							                                  List zxzjs = showBean.getExpertsList();
							                                  if(null != zxzjs && !zxzjs.isEmpty())
								                              for( int z = 0;z < zxzjs.size();z++){
								      	                      TExpertqaExperts zxzj_1 = (TExpertqaExperts)zxzjs.get(z);
							                                %>
							                                <option value="<%= zxzj_1.getUserid() %>" id="<%=zxzj_1.getSortId()+"_"+zxzj_1.getWid() %>"><%= zxzj_1.getName() %>&nbsp;</option>
							                                <%
							                                 }
							                                %>
														</select>
													</td>
												</tr>
												<tr>
													<td height="35" align="right">
														问&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题：
													</td>
													<td height="30" align="left">
														<input type="text" name="ti" id="ti" />
													</td>
												</tr>
												<tr>
													<td height="30" align="right" valign="top">
														描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述：
													</td>
													<td height="30" align="left">
														<textarea name="question" id="question" cols="17" rows="3"></textarea>
													</td>
												</tr>
												<tr>
													<td height="40" colspan="2" align="center">
														<button class="button" type="button" onclick="doSubmitC()"><span>提交问题</span></button>
														&nbsp;&nbsp;&nbsp;
														<button class="button" type="button" onclick="window.location='answer/index.jhtm'"><span>查看解答</span></button>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div class="pink_right_low"></div>
						<div id="yqlj" style="padding: 10px 2px 0 2px; color: #666">
								<form name="form" id="form">
									<select name="jumpMenu" id="jumpMenu" style="width:230px" 
										onchange=window.open(this.options[this.selectedIndex].value)>
										<option>
											－－－－－－友情链接－－－－－－
										</option>
										<option value="http://www.bjxsh.com" target="_blank">北京市畜牧兽医总站</option>
                                        <option value="http://www.caav.org.cn" target="_blank">中国畜牧兽医学会</option>
                                        <option value=http://www.njfstech.com target="_blank">南京丰顿信息咨询有限公司</option>
                                        <option value="http://www.bcage.org.cn" target="_blank">北京种猪遗传评估中心</option>
                                        <option value="http://www.agri.org.cn" target="_blank">中国农业信息网</option>
                                        <option value="http://www.chinaahvm.com" target="_blank">中国畜牧兽医行业网</option>
                                        <option value="http://www.chinabreed.com"  target="_blank">中国养殖网</option>
                                        <option value="http://www.chinaswine.org.cn"  target="_blank">中国种猪信息网</option>
                                        <option value="http://www.caaa.cn"  target="_blank">中国畜牧业信息网新版2.0</option>
                                        <option value="http://www.cav.net.cn" target="_blank">中国畜牧兽医信息网</option>
                                        <option value="http://www.moa.gov.cn/" target="_blank">农业部</option>
                                        <option value="http://www.cav.net.cn/" target="_blank">全国畜牧总站</option>
                                        <option value="http://www.dac.com.cn/" target="_blank">中国奶业协会</option>
                                        <option value="http://www.bjny.gov.cn/" target="_blank">北京市农业局</option>
									</select>
								</form>
							</div>
					</div>
				</div>
				<!--ysyl_end-->
				<!--footer_begin-->
				<div class="footer page2">
					<img src="faceui/images/index_90.jpg" width="960" height="6" />
					<%
						if (year != 2011) {
					%>
					版权所有 北京市畜牧兽医总站 ©2011-<%=year%><br />
					<%
						} else {
					%>
					版权所有 北京市畜牧兽医总站 ©2011
					<br />
					<%
						}
					%>
					电话：010-84929056&nbsp;&nbsp;&nbsp;84929053 地址：北京市朝阳区安外北宛路甲15号
					邮编100107
					<br>
					技术支持：
					<a target="_blank" href="http://www.njfstech.com">南京丰顿科技有限公司</a>
					 电话：025-86983857
				</div>
				<!--footer_end-->
	</body>
</html>