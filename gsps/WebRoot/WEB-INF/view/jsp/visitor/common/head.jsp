<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@page import="com.imchooser.framework.util.DBUtil"%>
<%@page import="com.imchooser.util.StringUtil"%>
<%@page import="com.imchooser.util.*"%>
<%@page import="com.imchooser.framework.*"%>
<%@page import="com.imchooser.util.DateUtil"%>
<%@ page import="com.imchooser.framework.identity.entity.LoginUserVO"%>
<%@ page import="com.imchooser.framework.identity.entity.TSysDepart"%>
<%@ page import="com.imchooser.framework.identity.IdConstants"%>
	<%
		String cssS = request.getParameter("cssS");
    	if(StringUtil.isBlank(cssS))
    		cssS="1";
    	if(request.getParameter("sx")!=null && "1".equals(request.getParameter("sx")))
    		cssS="3";
    	String d = DateUtil.currentDateString();

    	//查询目前实际产生的奖牌数
		LoginUserVO tsysUser = (LoginUserVO) session.getAttribute(IdConstants.SESSION_USER);
		String jps = null;
		String yps = null;
		String tps = null;
		String jps1 = null;
		String yps1 = null;
		String tps1 = null;
		String departname = null;
		if(tsysUser!=null){
			TSysDepart tdepart = tsysUser.getDepart();
			String departid = tdepart.getDepartid();
			departname = tdepart.getDepartname();
			String sql1 = " select sum(tt.jps),sum(tt.yps),sum(tt.tps) from (";
			String sql2	= " select sum(nvl(t.jps,0)) as jps,sum(nvl(t.yps,0)) as yps,sum(nvl(t.tps,0)) as tps from t_sport_cj_ydy t left join t_sport_ssrc a on t.scbm=a.wid where t.sfjtxm='0' and t.shzt=1 and t.sfjs=1 and a.fbzt='3' ";
			String sql3 = " union ";
			String sql4 = " select sum(nvl(y.jps,0)) as jps,sum(nvl(y.yps,0)) as yps,sum(nvl(y.tps,0)) as tps from t_sport_cj_jt y left join t_sport_ssrc a on y.scbm=a.wid where y.sfjs=1 and y.shzt=1 and a.fbzt='3' ";
			String sql5 = " ) tt ";//目前共产生奖牌数
			Object[] k = DBUtil.queryRowColumns(sql1+sql2+sql3+sql4+sql5);
			if(k!=null){
				jps = k[0].toString();
				yps = k[1].toString();
				tps = k[2].toString();
			}
			if(departid!=null && !"320".equals(departid)){
				String sql6 = " select sum(tt.jps),sum(tt.yps),sum(tt.tps) from (";
				String sql7	= " select sum(nvl(t.jps,0)) as jps,sum(nvl(t.yps,0)) as yps,sum(nvl(t.tps,0)) as tps from t_sport_cj_ydy t left join t_sport_ssrc a on t.scbm=a.wid where t.sfjtxm='0' and t.shzt=1 and t.sfjs=1 and a.fbzt='3' and t.departid=? ";
				String sql8 = " union ";
				String sql9 = " select sum(nvl(y.jps,0)) as jps,sum(nvl(y.yps,0)) as yps,sum(nvl(y.tps,0)) as tps from t_sport_cj_jt y left join t_sport_ssrc a on y.scbm=a.wid where y.sfjs=1 and y.shzt=1 and a.fbzt='3' and y.departid=? ";
				String sql10 = " ) tt ";//代表团的奖牌数
				Object[] l = DBUtil.queryRowColumns(sql6+sql7+sql8+sql9+sql10, departid, departid);
				if(l!=null){
					jps1 = l[0].toString();
					yps1 = l[1].toString();
					tps1 = l[2].toString();
				}
			}
		}
		
    	
	%>
<style type="text/css">
		#header h1.home {
			margin: 0;
			padding: 0;
			height: 101px;
			<s:if test="getDepartID() != null && getDepartID().length()==6 " >
			background: url(../resources/images/pages/logo_dbtcj.jpg) no-repeat left top;
			</s:if>
			<s:else>
			background: url(../resources/images/pages/logo.jpg) no-repeat left top;
			</s:else>
			
		}
		#header {
			<s:if test="getDepartID() != null && getDepartID().length()==6 " >
			background: url(../resources/images/pages/bg_headerdl.jpg)
				no-repeat left top;
			</s:if>
			<s:else>
			background: url(../resources/images/pages/bg_header.jpg) no-repeat left top;
			</s:else>
		}
		#nav p.subnav {
			float: right;
			margin: 4px 0 0;
			padding: 8px 0 0;
			width: 300px;
			<s:if test="getDepartID() != null && getDepartID().length()==6 " >
			background: url(../resources/images/pages/subnav_dl.png)
				no-repeat right;
			</s:if>
			<s:else>
			background: url(../resources/images/pages/subnav.png)
				no-repeat right;
			</s:else>
			text-align: center;
			color: #fffeff;
			height: 20px;
		}
		body {
			<s:if test="getDepartID() != null && getDepartID().length()==6 " >
			background: url(../resources/images/pages/indexbg_dl.jpg)
				repeat-x left top;
			font-size: 12px;
			</s:if>
			<s:else>
			background: url(../resources/images/pages/indexbg.jpg)
				repeat-x left top;
			font-size: 12px;
			</s:else>
		}
</style>
<div class="container_16">
	<div id="header" class="grid_16"><!-- 头部开始 -->
	<h1 class="home"><span>江苏省第十七届运动会综合成绩榜</span></h1>
  <div id="nav"><!-- 导航开始 -->
    <ul class="mainnav">
    
	 
		<s:if test="getUserLoginId() != null && getUserLoginId() != '' " >
		 	<li><a href="./sportCjTdHz-list.c?cssS=1" title="首 页" <%if("1".equals(cssS)){ %> class="active" <%} %>>首 页</a></li>
			<li><a href="./sportCjcxDbt-list.c?jp=3&cssS=2" title="代表团成绩查询" <%if("2".equals(cssS)){ %> class="active" <%} %>>代表团成绩查询</a></li> 		
			<li><a href="./sportCjcxRcZk-list.c?cssS=4" title="赛程查询" <%if("4".equals(cssS)){ %> class="active" <%} %>>赛程查询</a></li>
			<li><a href="sportDxmmc-list.c?cssS=5" title="项目查询" <%if("5".equals(cssS)){ %> class="active" <%} %>>项目查询</a></li>
	   		<li><a href="sportCjcxPjl-list.c?cssS=6" title="破纪录查询" <%if("6".equals(cssS)){ %> class="active" <%} %>>破纪录查询</a></li>
			<li><a href="sportCjcxZhcjb-list.c?cssS=9" title="其他奖项" <%if("9".equals(cssS)){ %> class="active" <%} %>>其他奖项</a></li>
			<li ><a href="sportCjcxNbbd-list.c?cssS=7" title="代表团全部成绩榜" <%if("7".equals(cssS)){ %> class="active" <%} %>>代表团全部成绩榜 </a></li>
			<li><a href="sportCjcxXscjb-list.c?cssS=3" title="区县成绩榜"  <%if("3".equals(cssS)){ %> class="active" <%} %>>区县成绩榜</a></li>
			<li><a href="../identity/index.c?cssS=8" title="成绩管理"  <%if("8".equals(cssS)){ %> class="active" <%} %>>成绩管理</a></li>
		</s:if>
		<s:else>
			<li><a href="sportCjTdHz-list.html" title="首 页" <%if("1".equals(cssS)){ %> class="active" <%} %>>首 页</a></li>
			<li><a href="sportCjcxDbt-nj.html" title="代表团成绩查询" <%if("2".equals(cssS)){ %> class="active" <%} %>>代表团成绩查询</a></li> 		
			<li><a href="sportCjcxRcZk-list.html" title="赛程查询" <%if("4".equals(cssS)){ %> class="active" <%} %>>赛程查询</a></li>
			<li><a href="sportDxmmc-list.html" title="项目查询" <%if("5".equals(cssS)){ %> class="active" <%} %>>项目查询</a></li>
	   		<li><a href="sportCjcxPjl-list.html" title="破纪录查询" <%if("6".equals(cssS)){ %> class="active" <%} %>>破纪录查询</a></li>
			<li><a href="sportCjcxZhcjb-list.html" title="其他奖项" <%if("9".equals(cssS)){ %> class="active" <%} %>>其他奖项</a></li>
			<li><a href="sportCjcxXscjb-list.html" title="区县成绩榜"  <%if("3".equals(cssS)){ %> class="active" <%} %>>区县成绩榜</a></li>
		</s:else>
	</ul>
		
		
  </div><!-- 导航结束 -->
</div>
<div id="info" class="grid_16 alpha omega" align="left">
  	<p><s:if test="getUserLoginId() != null && getUserLoginId() != '' " ><s:property value="getUser().getUserName()" /><s:if test="getDepartID() != null && getDepartID() != 320 ">代表团，</s:if></s:if>您好！今天是：<s:property value='getThisDay()' />，今天共有<span><s:property value='getCountThisDay()' /></span>项比赛。
  	<s:if test="getDepartID() != null && getDepartID() == 320 " > 	
  		目前共产生<span><%=jps%></span>金、<span><%=yps%></span>银、<span><%=tps%></span>铜。
	  	<span style="padding-left: 150px; color: white">
	  	【<a href="../identity/logout.c" style="color: white">退出</a>】
	  	</span>
  	</s:if>
  	<s:if test="getDepartID() != null && getDepartID() != 320 " > 	
  		目前共产生<span><%=jps%></span>金、<span><%=yps%></span>银、<span><%=tps%></span>铜，<%=departname %>代表团已取得<span><%=jps1%></span>金、<span><%=yps1%></span>银、<span><%=tps1%></span>铜。
  		<span style="padding-left: 0px; color: white">【<a href="../identity/logout.c" style="color: white">退出</a>】</span>
  	</s:if></p>
</div>
</div>
<!-- 头部结束 -->
