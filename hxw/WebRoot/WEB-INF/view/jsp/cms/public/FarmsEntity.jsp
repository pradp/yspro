<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>${entityBean.departname }</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=7" />
		<link type="text/css" rel="stylesheet" href="../faceui/css/winport-merge.css" />
		<link id="screenOStyleCSS" rel="stylesheet" rev="stylesheet" 
		      href="../faceui/css/499115_cnzhenguo_1311142088948.css" type="text/css" media="screen">
		<script type="text/javascript" src="../resources/jquery/jquery-1.6.2.min.js"></script>
		<script type="text/javascript" src="../faceui/js/wsdyIndex.js"></script>
		<script language="javascript">
		$(function(){
			ResizeImages("manPic", 650);//自动缩放图片
		})
		</script>
	</head>
  
	<body>
    <jsp:include page="common/head.jsp" />
		<div id="main">
			<div class="page2 position">
				您现在正在浏览：
				<a href="../index.jsp">首页</a> »
				<a href="../farms/index.jhtm" target="_blank">种畜禽场</a>
				» 正文
			</div>
			<!--cjbd_begin-->
<div class="page2 box">
  <div class="w700 fl">
     <div class="rb_mid box">
	<div class="inBg">
		<div>
			<div id="top_nav" class=" moveChild">
<div id="company_name" class="moveChild topbaner ">
	<div class="clr"></div>
	

	<div class="pointer vas_nobg" id="boardNormal">
	
		<div id="companyname"> 
			<ul>
				<li class="china">
					<span id="chinaname" class="chinaname">${entityBean.departname }</span>
					<span id="enname" class="enname"></span>
				</li>
			</ul>
		</div>
		<div class="clr"></div>
	</div>
	<div class="pointer" id="boardCartoon" style="display:none;">
     </div>
   </div>
</div>
<div id="content2" class="bodyRight simsun  filterDom ">
<div id="companyinfos" class="bodyCont" style="float:left;width: 702px">
    <div class="clr"></div>
    <div class="bodyContTitle"><span class="fl b titleLinkColor titleName">公司介绍</span></div>
		   <div class="companyinfo mainTextColor" style="word-break:break-all;zoom:1;">
			    <img id="manPic" class="fl margin5" style="" onerror="this.src='../faceui/images/6447397_2.jpg'" src="../${tdepart.zxqct }" name="bannerADrotator" alt="公司图片" border="0" height="221" width="300">
			    &nbsp;  
        		企业简介：<br><br>&nbsp;&nbsp;&nbsp;${entityBean.description } </div>
        <div style="clear:both"></div>
						
        <div class="bodyContTitle"><span class="fl b titleLinkColor titleName">详细信息</span></div>
    	                     	                    	<div class="bodyContContent rel" style="text-align:center;">
    		<table align="center" bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="1" width="700px">
                <tbody><tr>
                    <td class="S lh15" style="padding-top: 3px; padding-right: 3px; padding-bottom: 3px;" bgcolor="#F0f0f0">
    					<div align="right"><strong>联系人： </strong></div>
    				</td>
    				<td class="S lh15" style="padding: 3px 5px;" align="left" bgcolor="#FFFFFF"> 
                    ${entityBean.linkname }
                    </td> 				
    			                                                                 
                                                                        
                                                   <td class="S lh15" style="padding-top: 3px; padding-right: 3px; padding-bottom: 3px;" bgcolor="#F0f0f0">
                        <div align="right"><strong>联系电话：</strong></div>
                    </td>
                    <td class="S lh15" style="padding: 3px 5px;" align="left" bgcolor="#FFFFFF">
                        ${entityBean.linktel }                     
                    </td>
                    </tr>
                    <tr>
                        <td class="S lh15" style="padding-top: 3px; padding-right: 3px; padding-bottom: 3px;" bgcolor="#F0f0f0">
                            <div align="right"><strong>联系地址：</strong></div>
                        </td>
                        <td class="S lh15" style="padding: 3px 5px;" align="left" bgcolor="#FFFFFF">
                          ${entityBean.linkaddress }
                        </td>
                          <td class="S lh15" style="padding-top: 3px; padding-right: 3px; padding-bottom: 3px;" bgcolor="#F0f0f0">
                        <div align="right"><strong>联系邮编：</strong></div>
                    </td>
                    <td class="S lh15" style="padding: 3px 5px;" align="left" bgcolor="#FFFFFF">
                     ${entityBean.linkpostcode }
                     </td>
                    </tr>
                     <tr>
                      <td class="S lh15" style="padding-top: 3px; padding-right: 3px; padding-bottom: 3px;" bgcolor="#F0f0f0">
                        <div align="right"><strong>联系邮箱：</strong></div>
                      </td>
                      <td class="S lh15" style="padding: 3px 5px;" align="left" bgcolor="#FFFFFF">
                        ${entityBean.linkemail }    
                      </td>
                      <td class="S lh15" style="padding-top: 3px; padding-right: 3px; padding-bottom: 3px;" bgcolor="#F0f0f0">
                        <div align="right"><strong>联系传真：</strong></div>
                      </td>
                      <td class="S lh15" style="padding: 3px 5px;" align="left" bgcolor="#FFFFFF">
                          ${entityBean.linkfax }
                      </td>
                      </tr>
                      <tr>
                        <td class="S lh15" style="padding-top: 3px; padding-right: 3px; padding-bottom: 3px;" bgcolor="#F0f0f0">
                        <div align="right"><strong>法人代表：</strong></div>
                      </td>
                      <td class="S lh15" style="padding: 3px 5px;" align="left" bgcolor="#FFFFFF">
                          ${tdepart.frdb }
                      </td>
                       <td class="S lh15" style="padding-top: 3px; padding-right: 3px; padding-bottom: 3px;" bgcolor="#F0f0f0">
                        <div align="right"><strong>登记时间：</strong></div>
                      </td>
                      <td class="S lh15" style="padding: 3px 5px;" align="left" bgcolor="#FFFFFF">
                        <fmt:formatDate value="${tdepart.djsj }" pattern="yyyy.MM.dd"/>
                      </td>
                     </tr>
                       <tr>
                        <td class="S lh15" style="padding-top: 3px; padding-right: 3px; padding-bottom: 3px;" bgcolor="#F0f0f0">
                        <div align="right"><strong>单位性质： </strong></div>
                      </td>
                      <td class="S lh15" style="padding: 3px 5px;" align="left" bgcolor="#FFFFFF">
                          ${dwxzBean.zdmc }
                      </td>
                        <td class="S lh15" style="padding-top: 3px; padding-right: 3px; padding-bottom: 3px;" bgcolor="#F0f0f0">
                        <div align="right"><strong>养殖畜种：</strong></div>
                        </td>
                      <td class="S lh15" style="padding: 3px 5px;" align="left" bgcolor="#FFFFFF">
                          ${xzBean.zdmc }
                      </td>
                      </tr>
                  	</tbody>
                  </table>
                </div>
             </div>
   <div class="left_low"></div>	
			</div>
			</div>
<!-- server is ok -->
	</div>
</div>
   <div class="left_low"></div>	
</div>
<!--cjbd_end-->
	<%@include file="common/right.jsp"%>

	<div id="dhcd" align="center" style="clear:both;" >	
    <jsp:include page="common/foot.jsp" />
	</div>
</div>		
	</body>
</html>
