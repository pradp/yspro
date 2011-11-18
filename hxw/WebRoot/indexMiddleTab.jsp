<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.yszoe.biz.entity.TScjcCode"%>
<%@ page import="com.yszoe.biz.entity.TSysCodePzxx"%>
<%@ page import="com.yszoe.identity.entity.TSysDepart"%>
<jsp:useBean id="entityBean" scope="page" class="com.yszoe.biz.IndexPageQuery" />
<%@page import="com.yszoe.sys.util.SysConfigUtil"%>
<script type="text/javascript">
   function check(){
	   var xian = document.getElementById("textfield1").value;
	   var chang = document.getElementById("textfield2").value;
	   var xu = document.getElementById("textfield3").value;
	   var url = "farms/index.jhtm?xian="+encodeURI(xian)+"&chang="+encodeURI(chang)+"&xu="+encodeURI(xu);
	   window.location.href = url;
   }
</script>
	<%
	  String[] xzArray=new String[]{"01","02","04","05","06"};
	%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="faceui/js/tab.js"></script>
<link type="text/css" rel="stylesheet" href="faceui/css/indexMiddleTab.css" />
<div class="tabbing page2">
<div class="fwtd">
<table width="740" border="0" cellpadding="0" cellspacing="0">
  <tbody><tr>
    <td></td>
  </tr>
  
  <tr>
    <td class="bg03"><table width="98%" align="center" border="0" cellpadding="0" cellspacing="0">
      <tbody><tr>
        <td valign="top"> 
		   <div id="root" style="position: relative; top: 0px; left: 0px; width: 722px; height: 220px; overflow: hidden;"> 
               <!--种猪育种代码开始-->
              <div style="left: 0px; top: 0px; z-index: 3; display: block; overflow: hidden;" class="SlideTabItem" id="zwxx">
                 <table width="630" border="0" cellpadding="0" cellspacing="0">
                  <tbody><tr> 
                    <td class="zmhdBG" valign="top" width="49%"><table width="49%" align="center" border="0" cellpadding="0" cellspacing="0" height="220">
                        <tbody><tr> 
                         <!--顶端Tab-->
                          <td class="bg13" valign="top">
                         <table width="594" border="0" cellpadding="0" cellspacing="0">
                              <tbody><tr> 
                                <td class="bg13_2" height="35"><table width="594" border="0" cellpadding="0" cellspacing="0">
                                <tbody>
                                  <tr>
                                     <td>&nbsp;&nbsp;</td>
                                     <td><p class="image1" id="left1" onmouseover="change('top1')" align="center">种猪</p><p class="image2" id="left2" style="display:none;" align="center">种猪</p></td>
                                     <td><p class="image1" id="right1" onmouseover="change('top2')" align="center">奶牛</p><p class="image2" id="right2" style="display:none;" align="center">奶牛</p></td>
                                     <td><p class="image1" id="left3" onmouseover="change('top3')" align="center">蛋鸡</p><p class="image2" id="left4" style="display:none;" align="center">蛋鸡</p></td>
                                     <td><p class="image1" id="right3" onmouseover="change('top4')" align="center">肉鸡</p><p class="image2" id="right4" style="display:none;" align="center">肉鸡</p></td>
                                     <td><p class="image1" id="left5" onmouseover="change('top5')" align="center">种鸭</p><p class="image2" id="right5" style="display:none;" align="center">种鸭</p></td>
                                  </tr>
                                </tbody>
								</table></td>
                              </tr>
                            </tbody></table>
                            <!-- 种猪 begin -->
                            <%
                                 for(int i = 0 ;i < xzArray.length ;i++){
                            	  String str = "biao"+(i+1);//定义ID
                                 %>
                            <table width="616" border="0" cellpadding="8" cellspacing="0" id=<%=str %>>
                              <tbody><tr> 
                                <td>
                                
                                  <table width="86%" border="0" cellpadding="0" cellspacing="0" >
                                    <tbody><tr> 
                                    <!-- 当前检测项 begin -->
                                      <td valign="top" width="200px"><table width="200px" border="0" cellpadding="0" cellspacing="0">
                                          <tbody><tr> 
                                            <td class="font13 bg13_2" width="50%" align="left" height="18">&nbsp;&nbsp;&nbsp;&nbsp;当前检测项</td>
                                          </tr>
                                          <tr> 
                                            <td colspan="3" class="pd04" valign="top" height="145"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tbody> 
                                                  <!--添加数据-->
                                                  <%
                                                    String xzName = xzArray[i];
                                                    //String 
                                                    List xzList = entityBean.tableTscQuery(xzName);
													if (null != xzList) {
														for (int a = 0; a < xzList.size(); a++) {
															 TScjcCode xzList_1 = (TScjcCode) xzList.get(a);
                                                  %>
                                                  <tr align="left" >
                                                    <td id="dqjcx">&nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<%=StringUtil.getShortTitle(xzList_1.getZbm() , 12)%></td></tr>
                                                  <%
														}}
                                                  %>
                                                  
                                                
                                              </tbody></table>
                                              </td>
                                          </tr>
                                        </tbody></table></td>
									  <!--参与检测场-->
                                      <td valign="top" width="200px"><table width="200px" border="0" cellpadding="0" cellspacing="0">
                                          <tbody><tr> 
                                            <td class="font13 bg13_2" width="50%" align="left" height="18">&nbsp;&nbsp;&nbsp;&nbsp;参与检测场</td>
                                          </tr>
                                          <tr> 
                                          <td colspan="3" class="pd04" valign="top" height="145"><table width="100%" border="0" cellpadding="0"
										           cellspacing="0">
                                             <tbody>
                                                <%
                                                List jcc = entityBean.tableJccQuery(xzName);
                                                if (null != jcc) {
													for (int a = 0; a < jcc.size(); a++) {
														TSysDepart jcc_1 = (TSysDepart) jcc.get(a);
														%>
												<tr align="left"> 
                                                  <td height="35">・&nbsp;<a href="./farms/<%=jcc_1.getDepartnamePy() %>.jhtm" target="_blank"><%=StringUtil.getShortTitle(jcc_1.getDepartname() , 12)%></a></td>
                                                </tr>
														<% 
													}
                                                }
                                                %>
                                              
                                                 </tbody></table></td>
                                          </tr>
                                        </tbody></table></td>
                                        
									  <!--统计分析begin-->
                                      <td valign="top" width="200"><table width="200" border="0" cellpadding="0" cellspacing="0">
                                          <tbody><tr> 
                                            <td class="font13 bg13_2" width="50%" align="left" height="18">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;统计分析</td>
                                          </tr>
                                          <tr align="center"> 
                                            <td colspan="3" class="pd04 font14" valign="top" height="145">
                                              <table width="100%" border="0" cellpadding="0" cellspacing="0" id="TJFX">
                                                <tbody>
                                                <tr height="30"> 
                                                  <td align="center">年&nbsp;&nbsp;&nbsp;份：</td>
                                                  <td align="left"><select style="width: 60%">  
															<option value="">
																----请选择----
															</option>
					
															<%
									                        for( int a = year;a > 2008;a--){
									                        %>
								                           <option value=<%=a %>><%= a %></option>
								                           <%
								                             }
														   %>
														</select></td>
                                                </tr>
                                                <tr height="30"> 
                                                  <td align="center">月&nbsp;&nbsp;&nbsp;份：</td>
                                                  <td align="left"><select style="width: 60%">  
															<option value="">
																----请选择----
															</option>
					
															<%
									                        for( int k = 1;k <= 12;k++){
									                        %>
								                           <option value=<%=k %>><%= k %></option>
								                           <%
								                             }
														   %>
														</select></td>
                                                </tr>
                                                <tr height="30"> 
                                                  <td align="center">类&nbsp;&nbsp;&nbsp;型：</td>
                                                  <td align="left"><select name="lx" id="lx" style="width: 60%">
                                                         <option value="">----请选择----</option>  
														 <option value="统计">统计</option>
								                         <option value="对比">对比</option>
														</select></td>
                                                </tr>
                                                <tr height="30"> 
                                                  <td align="center">检&nbsp;&nbsp;&nbsp;测：</td>
                                                  <td align="left"><select name="jc" id="jc" style="width: 60%">
                                                  <option value="">----请选择----</option> 
                                                   <%
                                                   
                                                    List zxList2 = entityBean.tableTscQuery(xzName);
													if (null != zxList2) {
														for (int a = 0; a < zxList2.size(); a++) {
															 TScjcCode zxList_2 = (TScjcCode) zxList2.get(a);
                                                  %>  
												<option value="<%=zxList_2.getZbm()%>">
														<%=StringUtil.getShortTitle(zxList_2.getZbm() , 12)%>&nbsp;
												</option>
												<%
														}}
												%>
														</select></td>
                                                </tr>
                                                <tr height="5">
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                </tr>
                                                <tr height="25">
                                                <td>&nbsp;</td>
                                                <td align="left">
                                                	<button class="button" type="button" onclick="window.location='./identity/index.action'"><span>查&nbsp;&nbsp;&nbsp;询</span></button>
                                                </tr>
                                              </tbody></table></td>
                                          </tr>
                                        </tbody></table></td>
                                       <!--统计分析end--> 
                                    </tr>
                                  </tbody></table>
                              
                                  </td>
                            </tr>
                            </tbody></table>
                                    <%
                              }
                                  %>
                               
                            <!-- 种猪 end -->
                           </td>                        
                         </tr>
                      </tbody></table></td>
                    <!--内容代码结束-->
                    <td valign="top" width="35"><a href="javascript:void(0);" onmouseover="onShowTab('zwxx')"><img id="Arrow0" src="faceui/images/001_close.gif" width="35" border="0" height="220"></a></td>
                  </tr>
                </tbody></table>
              </div>
            <!--种猪育种代码结束-->
            <!--奶牛DHI代码开始-->
              <div style="left: 35px; top: 0px; z-index: 2; display: block; overflow: hidden;" class="SlideTabItem" id="bsdt">
                <table width="630" border="0" cellpadding="0" cellspacing="0">
                  <tbody><tr> 
                    <!--内容代码开始-->
                    <td class="bsdtBG" valign="top" width="49%"> <table width="49%" align="center" border="0" cellpadding="11" cellspacing="0" height="220">
                        <tbody><tr> 
                          <td class="bg12" valign="top">
                            <table width="594" border="0" cellpadding="0" cellspacing="0" id="nndhi">
                              <tbody><tr> 
                                <td valign="top" width="32%" >
								<!--月度采样分析-->
								<fmt:bundle basename="sysconfig" >
								   <table width="280" border="0" cellpadding="0" cellspacing="0">
                                    <tbody><tr> 
                                      <td class="font13 bg12_2" align="left" height="18">&nbsp;&nbsp;&nbsp;&nbsp;月度采样分析</td>
                                    </tr>
                                    <tr> 
                                      <td colspan="3" class="font14" > 
                                              <table width="280" align="left" border="0" cellpadding="0" cellspacing="0">
                                                <tbody>
                                                <tr height="5px"><td></td></tr>
                                                <tr height="25px">  
                                                 <td>
					&nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">参测牛群结构分布</a>
					                             </td>
                                                   </tr>
                                                   <tr height="25px">  
                                                 <td>
					&nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">305奶 区间分布</a></td>
                                                   </tr>
                                                   <tr height="25px">  
                                                 <td>
					&nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">5CC区间分布</a></td>
                                                   </tr>
                                                </tbody></table></td>
                                   </tr>
                                  </tbody></table>
								  <!--采样数据走势分析-->
                                  <table width="280" border="0" cellpadding="0" cellspacing="0">
                                    <tbody><tr> 
                                      <td class="font13 bg12_2" align="left" height="18">&nbsp;&nbsp;&nbsp;&nbsp;采样数据走势分析</td>
                                    </tr>
                                    <tr> 
                                      <td colspan="3" class="font14" valign="top"> 
                                              <table width="280" align="left" border="0" cellpadding="0" cellspacing="0">
                                                <tbody>
                                                <tr height="5px"><td></td></tr>
                                                <tr height="25px">  
                                                 <td>
					&nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">参测牛群结构分布</a></td>
                                                   </tr>
                                                   <tr height="25px">  
                                                 <td>
					&nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">305奶 区间分布</a></td>
                                                   </tr>
                                                   <tr height="25px">  
                                                 <td>
					&nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">5CC区间分布</a></td>
                                                   </tr>
                                      </tbody></table></td>
                                    </tr>
                                  </tbody></table></td>
								  <!--数据上传-->
                                <td valign="top" width="52%"><table width="52%" border="0" cellpadding="0" cellspacing="0">
                                    <tbody><tr> 
                                      <td class="font13 bg12_2" align="left" height="18">&nbsp;&nbsp;&nbsp;&nbsp;数据上传</td>
                                    </tr>
                                    <tr> 
                                      <td class="pd02 font14" valign="top">
                                        <table width="280" border="0" cellpadding="0" cellspacing="0">
                                          <tbody>
                                          <tr height="5px"><td></td></tr>
                                          <tr height="25px"> 
                                            <td>
                  &nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">牧场数据上传</a></td>
                                             </tr>
                                             <tr height="25px"> 
                                            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">DHI数据上传</a></td>
                                             </tr>
                                             <tr height="25px"> 
                                            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">更多...</a></td>
                                             </tr>
                                        </tbody></table></td>
                                    </tr>
                                  </tbody></table>
								  <!--绿色通道begin-->
                                  <table width="52%" border="0" cellpadding="0" cellspacing="0">
                                    <tbody><tr> 
                                      <td class="font13 bg12_2" width="52%" align="left" height="18">&nbsp;&nbsp;&nbsp;&nbsp;奶牛选配</td>
                                    </tr>
                                    <tr> 
                                      <td class="pd02 font14" valign="top">
                                        <table width="280" border="0" cellpadding="0" cellspacing="0">
                                          <tbody>
                                          <tr height="5px"><td></td></tr>
                                          <tr height="25px"> 
                                            <td>
             &nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">近交系数计算</a></td>
                                             </tr>
                                             <tr height="25px"> 
                                            <td>
          &nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">血缘选配模拟</a></td>
                                             </tr>
                                             <tr height="25px"> 
                                            <td>
          &nbsp;&nbsp;&nbsp;&nbsp;・&nbsp;<a href="<fmt:message key="DhiLoginUrl"/>" target="_blank">更多...</a></td>
                                             </tr>
                                        </tbody></table>
                                        </td>
                                    </tr>
                                  </tbody></table>
                                  <!--绿色通道end-->
                                  </fmt:bundle>
                                  </td>
                              </tr>
                            </tbody></table></td>
                        </tr>
                      </tbody></table></td>
                    <!--内容代码结束-->
                    <td valign="top" width="35"><a href="javascript:void(0);" onmouseover="onShowTab('bsdt')"><img id="Arrow1" src="faceui/images/002_close.gif" width="35" border="0" height="220"></a></td>
                  </tr>
                </tbody></table>
              </div>
              <!--奶牛DHI代码结束-->
              <!--生产检测代码开始-->
              <div style="left: 70px; top: 0px; z-index: 1; display: block; overflow: hidden;" class="SlideTabItem" id="zmhd">
                <table width="630" border="0" cellpadding="0" cellspacing="0">
                  <tbody><tr>
                   <!--内容代码开始-->
                    <td class="zwxxBG" valign="top" width="49%">
                      <table width="594" align="center" border="0" cellpadding="11" cellspacing="0" height="220">
                        <tbody><tr> 
                          <td class="bg11" valign="top"><table width="594" border="0" cellpadding="0" cellspacing="0">
                              <tbody><tr> 
                                <td height="8"></td>
                              </tr>
                            </tbody></table>
                            <table width="85%" border="0" cellpadding="0" cellspacing="0">
                              <tbody><tr>
                              <fmt:bundle basename="sysconfig" >
                              <!--猪场信息查询--> 
                                <td valign="top" width="195px">
                                <table width="195px" border="0" cellpadding="0" cellspacing="0">
                                    <tbody><tr> 
                                      <td class="font13 bg11_2" width="8%" align="center" height="18">猪场信息查询</td>
                                    </tr>
                                    <tr> 
                                      <td colspan="3" class="font14" style="padding: 6px 0pt 0pt;" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                          <tbody><tr> 
                                            <td width="30" height="28">地&nbsp;&nbsp;&nbsp;区：</td>
                                            <td><input name="areaname" type="text" value="" size="13"> 
                                            </td>
                                          </tr>
                                          <tr height="28">
                                            <td>品&nbsp;&nbsp;&nbsp;种：</td>
                                            <td><select name="zcpz" style="width: 68%">  
															<option value="">
																---主产品种---
															</option>
															<%
															List zcpzs = entityBean.tableZcpzQuery();
															if (null != zcpzs) {
																for (int a = 0; a < zcpzs.size(); a++) {
																	TSysCodePzxx xzList_1 = (TSysCodePzxx) zcpzs.get(a);
									                        %>
								                           <option value=<%=xzList_1.getPzbh() %>><%=xzList_1.getPzmc()%></option>
								                           <%
								                             }
															}
														   %>
												</select>
											</td>
                                          </tr>
                                          <tr height="28">
                                            <td>猪&nbsp;&nbsp;&nbsp;场：</td>
                                            <td> <input name="zcmc" type="text" size="13" value=""></td>
                                          </tr>
                                          <tr height="28"> 
                                             <td>企&nbsp;&nbsp;&nbsp;业：</td>
                                             <td><select name="qyxz"  style="width: 68%">
                                                   <option value="">---企业性质---</option>
                                                   <option value=国有>国有</option>
                                                   <option value=集体>集体</option>
                                                   <option value=民营>民营</option>
                                                   <option value=股份>股份</option>
                                                   <option value=私有>私有</option>
                                                   <option value=个人>个人</option>
                                               </select>
                                             </td>
                                          </tr>
                                          <tr height="28">
                                             <td>编&nbsp;&nbsp;&nbsp;号：</td>
                                             <td><input name="zcbh" type="text" size="13" value=""></td>
                                          </tr>
                                          <tr height="40">
                                           <td></td>
                                           <td align="left"><button class="button" type="button" onclick="window.location='<fmt:message key="SwineSiteUrl.zhcx"/>'"><span>查&nbsp;&nbsp;&nbsp;询</span></button></td>
                                          </tr>
                                         </tbody></table></td>
                                    </tr>
                                  </tbody></table></td>
								<!--遗传进展趋势查询-->
                                <td valign="top" width="195px">
								<table width="195px" border="0" cellpadding="0" cellspacing="0">
                                    <tbody><tr> 
                                      <td class="font13 bg11_2" width="9%" align="center" height="18">遗传进展趋势查询</td>
                                    </tr>
                                    <tr> 
                                      <td colspan="3" class="pd01 font14" valign="top" style="padding: 6px 0pt 0pt;"> 
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                          <tbody>
                                          <tr height="28"> 
                                            <td width="30px">地&nbsp;&nbsp;&nbsp;区：</td>
                                            <td><input name="areaname" type="text" value="" size="13"> 
                                            </td>
                                          </tr>
							              <tr height="28"> 
							                  <td width="30px">品&nbsp;&nbsp;&nbsp;种：</td> 
							                  <td> <select name="breed" style="width: 68%">
							                  <option>---所有品种---</option>
							                    <%
													if (null != zcpzs) {
														for (int a = 0; a < zcpzs.size(); a++) {
															TSysCodePzxx xzList_1 = (TSysCodePzxx) zcpzs.get(a);
												%>
													<option value=<%=xzList_1.getPzbh() %>><%=xzList_1.getPzmc()%></option>
												<%
													}
													}
												%>
							                   </select>
							                 </td>
							              </tr>
							              <tr height="28"> 
							                  <td>性&nbsp;&nbsp;&nbsp;状：</td>
							                  <td><select name="show" style="width: 68%">
							                         <option>---显示性状---</option>
							                         <option value="父系指数">父系指数</option>
											         <option value="母系指数">母系指数</option>
											         <option value="繁殖指数">繁殖指数</option>
											         <option value="自定指数">自定指数</option>
											         <option value="被膘厚EBV">被膘厚EBV</option>
											         <option value="产仔数EBV">产仔数EBV</option>
											         <option value="眼肌面积EBV">眼肌面积EBV</option>
											         <option value="眼肌面积EBV">饲料转化率EBV</option>
											  </select></td>
							               </tr>
							               <tr height="28"> 
							                  <td>性&nbsp;&nbsp;&nbsp;别：</td>
							                  <td>
							                    <input name="R_SEX" type="radio" value="1" >
							                                                                         公　 
							                    <input type="radio" name="R_SEX" value="0" >
							                                                                          母 
							                  </td>                                                        
							                </tr>
							                <tr height="28"> 
							                  <td>排&nbsp;&nbsp;&nbsp;序：</td>
							                  <td><select name="show" style="width: 68%">
							                         <option>---排序性状---</option>
							                         <option value="父系指数">父系指数</option>
											         <option value="繁殖指数">繁殖指数</option>
											  </select></td>
							               </tr>
							                <tr height="40"> 
							                  <td></td>
							                  <td align="left"><button class="button" type="button" onclick="window.location='<fmt:message key="SwineSiteUrl.zhcx"/>'"><span>查&nbsp;&nbsp;&nbsp;询</span></button></td>
							                </tr>
							               </tbody>
							              </table>
							             </td>
							            </tr>
            </tbody></table></td>
			           <!--种猪信息查询-->
                                <td valign="top" width="195px"><table width="195px" border="0" cellpadding="0" cellspacing="0">
                                    <tbody><tr> 
                                      <td class="font13 bg11_2" width="8%" align="center" height="18">指定条件查询</td>
                                    </tr>
                                    <tr> 
                                      <td colspan="3" class="pd01 font14" valign="top" style="padding: 6px 0pt 0pt;"><table class="font14" width="100%" border="0" cellpadding="0" cellspacing="0">
                                          <tbody>
                                           <tr> 
                                            <td width="30px" height="28">地&nbsp;&nbsp;&nbsp;区：</td>
                                            <td><input name="areaname" type="text" value="" size="13"> 
                                            </td>
                                          </tr>
							              <tr height="28"> 
							                  <td width="30px">品&nbsp;&nbsp;&nbsp;种：</td> 
							                  <td> <select name="breed" style="width: 68%">
							                  <option>---所有品种---</option>
							                    <%
													if (null != zcpzs) {
														for (int a = 0; a < zcpzs.size(); a++) {
															TSysCodePzxx xzList_1 = (TSysCodePzxx) zcpzs.get(a);
												%>
													<option value=<%=xzList_1.getPzbh() %>><%=xzList_1.getPzmc()%></option>
												<%
													}
													}
												%>
							                   </select>
							                 </td>
							              </tr>
							              <tr height="28"> 
							                  <td>性&nbsp;&nbsp;&nbsp;状：</td>
							                  <td><select name="show" style="width: 68%">
							                         <option>---显示性状---</option>
							                         <option value="父系指数">父系指数</option>
											         <option value="母系指数">母系指数</option>
											         <option value="繁殖指数">繁殖指数</option>
											         <option value="自定指数">自定指数</option>
											         <option value="被膘厚EBV">被膘厚EBV</option>
											         <option value="产仔数EBV">产仔数EBV</option>
											         <option value="眼肌面积EBV">眼肌面积EBV</option>
											         <option value="眼肌面积EBV">饲料转化率EBV</option>
											  </select></td>
							               </tr>
							               <tr height="28"> 
							                  <td>性&nbsp;&nbsp;&nbsp;别：</td>
							                  <td >
							                    <input name="R_SEX" type="radio" value="1" >
							                                                                         公　 
							                    <input type="radio" name="R_SEX" value="0" >
							                                                                          母 
							                  </td>                                                        
							                </tr>
							                <tr height="28" id="inputCS">
							                  <td align="left">出&nbsp;&nbsp;&nbsp;生：</td>
							                  <td><input type="text" name="data1" size="2"/>&nbsp;至&nbsp;<input type="text" name="data2" size="2"/></td>
							                </tr>
                                           <tr height="40">
                                            <td></td>
                                          	<td align="left"><button class="button" type="button" onclick="window.location='<fmt:message key="SwineSiteUrl.zhcx"/>'"><span>查&nbsp;&nbsp;&nbsp;询</span></button></td>
                                          </tr>
                                        </tbody></table></td>
                                    </tr>
                                  </tbody></table>
                                  </td>
                                  <!--种猪信息查询end-->
                                  </fmt:bundle>
                              </tr>
                            </tbody></table></td>
                        </tr>
                      </tbody></table></td>
                   
                    
                   <td valign="top" width="35"><a href="javascript:void(0);" onmouseover="onShowTab('zmhd')">
                        <img id="Arrow2" src="faceui/images/003_open.gif" width="35" border="0" height="220"></a></td>
                  </tr>
                </tbody></table>
              </div>
              <!--生产检测代码结束-->
            </div>
</td>
      </tr>
    </tbody></table></td>
  </tr>
</tbody></table>
</div>
<div class="zxqcx" style="padding-top:60px;padding-left:16px;width: 18%;border-left:1px solid #e8c470;">
   <table border="0" cellpadding="0" height="192">
		<tr height="35" valign="middle">
		   <td align="left">
		        县&nbsp;&nbsp;&nbsp;区：
		   </td>
		   <td>
		   &nbsp;&nbsp;<input type="text" name="textfield1" id="textfield1" size="13"/>
		   </td>
		</tr>
		<tr height="45" valign="middle">
		   <td>
		           畜&nbsp;&nbsp;&nbsp;种：
		   </td>
		   <td align="left">&nbsp;
		   <select name="textfield3" id="textfield3">
		   <option value="">----请选择----</option>
		   <%
				List xzs2 = showBean.tableXzQuery();
				if(null != xzs2 && !xzs2.isEmpty())
				for( int p = 0;p < xzs2.size();p++){
				TSysCode xz_2 = (TSysCode)xzs2.get(p);
		   %>
				<option value="<%= xz_2.getZdbm() %>"><%= xz_2.getZdmc() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
				<%
				}
		   %>
		   </select>
		   </td>
		</tr>
		<tr height="35" valign="middle">
		   <td align="left">
		        场&nbsp;&nbsp;&nbsp;名：
		   </td>
		   <td align="left">
		   &nbsp;&nbsp;<input type="text" name="textfield2" id="textfield2" size="13"/>
		   </td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		</tr>
		<tr>
		  <td>&nbsp;</td>
		  <td><button class="button" type="button" onclick="check();"><span>查&nbsp;&nbsp;&nbsp;询</span></button></td>
		</tr>
   </table>
</div>
</div>

<script type="text/javascript">
onPageLoad();
</script>
