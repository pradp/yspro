<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	
  	<title>明细信息</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/idcard.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/sxdksqbImport.js"></script>
	
    <script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
    
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.bgiframe.min.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.ajaxQueue.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/thickbox-compressed.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.css">
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/lib/thickbox.css">
	<script type="text/javascript">
	var basePath = '<s:property value="basePath"/>';
	var departid = '<s:property value="depart.departid"/>';
	var departtype = '<s:property value="depart.departtype"/>';
	var yxmc = '<s:property value="tsxDksqb.yxmc"/>';
	var edje = '<%=com.yszoe.sys.util.CommonQuery.getSysProperty("zddkje") %>';
	</script>
	<base target="_self">
	
  </head>
  
  <body style="text-align:center;">
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>
<s:if test="tsxDksqbImport!=null && tsxDksqbImport.yzzt==0 && tsxDksqbImport.cwtsxx!=null && tsxDksqbImport.cwtsxx.length()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:property value="tsxDksqbImport.cwtsxx"/>
	</div>
</s:if>

<div class="framestyle" style="width:100%">
  <s:form name="theform" method="post" theme="simple">
  <s:hidden name="tsxDksqbImport.wid" id="wid"/>
  <s:hidden name="tsxDksqbImport.byxx" id="byxx"/>
  <s:hidden name="tsxDksqbImport.hjszqx" id="hjszqx"/>
  <s:hidden name="tsxDksqbImport.zzszqx" id="zzszqx"/>
  <s:hidden name="tsxDksqbImport.jzhjszqx" id="jzhjszqx"/>
  <s:hidden name="tsxDksqbImport.jtszqx" id="jtszqx"/>
  
  <s:hidden name="tsxDksqbImport.xxlb1" id="xxlb1"/>
  <s:hidden name="tsxDksqbImport.xxlb2" id="xxlb2"/>
  <s:hidden name="tsxDksqbImport.xxsssf" id="xxsssf"/>
  
<s:if test="depart.departtype=='7'.toString()||depart.departtype=='8'.toString()">
  <s:hidden name="tsxDksqbImport.nj" id="nj"/>
  <s:hidden name="tsxDksqbImport.zy" id="zy"/>
  <s:hidden name="tsxDksqbImport.xz" id="xz"/>
  <s:hidden name="tsxDksqbImport.bj" id="bj"/>
</s:if>
  <s:hidden name="tsxDksqbImport.gxbm" id="gxbm"/>
  <s:hidden name="tsxDksqbImport.slzt" id="slzt"/>
  <s:hidden name="tsxDksqbImport.dklx" id="dklx"/>
  <s:hidden name="sfxz"/>
  

  
 <fieldset> 
　 <legend>借款人基本情况</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">身份证号：</td>
      <td width="30%"><s:textfield name="tsxDksqbImport.sfzh" id="sfzh" maxlength="18" size="23" onblur="checkXssfzh('sfzh')" cssStyle="ime-mode:disabled"/> <label style="color:red">*</label></td>
      <td align="right" width="10%" nowrap="nowrap">姓名：</td>
      <td width="25%"><s:textfield name="tsxDksqbImport.xsxm" id="xsxm" maxlength="15" size="10"/> <label style="color:red">*</label></td>
      <td width="10%" align="right">性别：</td>
      <td width="16%"><s:select id="xb" name="tsxDksqbImport.xb" list="#{'1':'男','2':'女'}" headerKey="" headerValue="-----请选择----"/> <label style="color:red">*</label></td>
    </tr>
    <tr>
      <td align="right" nowrap="nowrap">出生年月：</td>
      <td><s:textfield name="tsxDksqbImport.csny" id="csny" maxlength="10" size="6"/>如：1988-12<label style="color:red">*</label></td>
     
<td align="right" nowrap="nowrap">户籍所在地：</td>
      <td><s:textfield name="tsxDksqbImport.hjszqxName" id="hjszqxName" maxlength="15" size="20" readonly="true"/> <input type="button" value="..." onblur="complete2()" onclick="selectArea('hjszqx','hjszqxName')"/> <label style="color:red">*</label></td>
      <td align="right">学号：</td>
      <td><s:textfield name="tsxDksqbImport.xszh" id="xszh" maxlength="20" size="15"/><label style="color:red">*</label></td>
    </tr>
    <tr>
      <td align="right" nowrap="nowrap">现详细地址：</td>
      <td colspan="3"><s:textfield name="tsxDksqbImport.zzszqxName" id="zzszqxName" maxlength="20" size="20" readonly="true"/> <input type="button" value="..." onclick="selectArea('zzszqx','zzszqxName')"/>
      <s:textfield name="tsxDksqbImport.xxzz" id="xxzz" maxlength="50" size="30"/> <label style="color:red">*</label></td>
      <td align="right">邮政编码：</td>
      <td><s:textfield name="tsxDksqbImport.zzyzbm" id="zzyzbm" maxlength="10" size="15" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/> <label style="color:red">*</label></td>
    </tr>
    <s:if test="depart.departtype!='6'.toString()&&depart.departtype!='9'.toString()">
    <tr>
      <td align="right" nowrap="nowrap">毕业中学：</td>
       <td colspan="3">
       <s:if test="depart.departtype=='8'.toString()">
        <s:property value="depart.departname"/>
         </s:if>
      <s:if test="depart.departtype=='1'.toString()||depart.departtype=='7'.toString()">
      <s:textfield name="tsxDksqbImport.byxxName" id="byxxName" maxlength="50" size="70"/> <label style="color:red">*</label>
     </s:if>
     </td>
      <td align="right">邮政编码：</td>
      <td><s:textfield name="tsxDksqbImport.xxyzbm" id="xxyzbm" maxlength="10" size="15" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/> <label style="color:red">*</label></td>
    </tr> 
    </s:if> 
    <tr> 
      <td align="right" nowrap="nowrap">家庭电话：</td>
      <td><s:textfield name="tsxDksqbImport.xsjtdh" id="xsjtdh" maxlength="15" size="15" cssStyle="ime-mode:disabled"  onkeypress="NumberText(event,false,false);"/> <label style="color:red">*</label></td>
      <td align="right" nowrap="nowrap">移动电话：</td>
      <td><s:textfield name="tsxDksqbImport.xsyddh" id="xsyddh" maxlength="11" size="18" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/> </td>
      <td align="right">宿舍电话：</td>
      <td><s:textfield name="tsxDksqbImport.lxdh" id="lxdh" maxlength="15" size="15" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/> </td>
    </tr>  
    </table>
  </fieldset>
  
 <fieldset> 
　 <legend>共同借款人信息</legend>
   <table width="100%" border="0" align="center">
    <tr>
      <td align="right" width="15%" nowrap="nowrap">姓名：</td>
      <td width="20%"><s:textfield name="tsxDksqbImport.jzxm" id="jzxm" maxlength="15" size="10"/> <label style="color:red">*</label></td>
      <td align="right" width="15%" nowrap="nowrap">证件类型：</td>
<s:set name="zdlb" value="'zjlx'"/>
      <td width="20%"><s:select name="tsxDksqbImport.jzzjlx" id="jzzjlx" list="sysCode" listKey="id" listValue="caption"/> <label style="color:red">*</label></td>
      <td width="10%" align="right">证件号码：</td>
      <td width="20%"><s:textfield name="tsxDksqbImport.jzzjhm" id="jzzjhm" maxlength="20" size="18" onblur="checkJzzjlx('jzzjhm')" cssStyle="ime-mode:disabled"/> <label style="color:red">*</label></td>
    </tr> 
    <tr> 
      <td align="right" nowrap="nowrap">与借款人关系：</td>
<s:set name="zdlb" value="'jzgx'"/>
      <td><s:select name="tsxDksqbImport.jzgx" id="jzgx" list="sysCode" listKey="id" listValue="caption"  headerKey="" headerValue="----请选择-----"  /> <label style="color:red">*</label></td>
      <td align="right" nowrap="nowrap">户籍所在地：</td>
      <td><s:textfield name="tsxDksqbImport.jzhjszqxName" id="jzhjszqxName" maxlength="18" size="15" readonly="true"/> <input type="button" value="..." onblur="complete1()" onclick="selectArea('jzhjszqx','jzhjszqxName')"/> <label style="color:red">*</label></td>
      <td align="right">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">家庭详细地址：</td>
      <td colspan="3"><s:textfield name="tsxDksqbImport.jtszqxName" id="jtszqxName" maxlength="28" size="28" readonly="true"/> <input type="button" value="..." onclick="selectArea('jtszqx','jtszqxName')"/>
      <s:textfield name="tsxDksqbImport.jtxxzz" id="jtxxzz" maxlength="24" size="24"/> <label style="color:red">*</label></td>
      <td align="right">邮政编码：</td>
      <td><s:textfield name="tsxDksqbImport.jtyb" id="jtyb" maxlength="10" size="15" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/> <label style="color:red">*</label></td>
    </tr>    
    <tr> 
      <td align="right" nowrap="nowrap">工作单位：</td>
      <td colspan="3"><s:textfield name="tsxDksqbImport.jzgzdw" id="jzgzdw" maxlength="20" size="40"/> <label style="color:red">*</label></td>
      <td align="right">职务：</td>
      <td><s:textfield name="tsxDksqbImport.jzzw" id="jzzw" maxlength="15" size="15"/> <label style="color:red">*</label></td>
    </tr>  
    <tr> 
      <td align="right" nowrap="nowrap">家庭电话：</td>
      <td><s:textfield name="tsxDksqbImport.jzlxdh" id="jzlxdh" maxlength="15" size="15" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/> <label style="color:red">*</label></td>
      <td align="right" nowrap="nowrap">移动电话：</td>
      <td><s:textfield name="tsxDksqbImport.jzyddh" id="jzyddh" maxlength="11" size="20"  cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"/> </td>
      <td align="right">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>  
    </table>
  </fieldset>
<s:if test="depart.departtype=='9'.toString()||depart.departtype=='6'.toString()">
  <fieldset> 
　 <legend>就学信息</legend>
   <table width="100%" border="0" align="center">
    <tr>
      <td align="right" nowrap="nowrap">高校名称：</td>
       <td>
       <s:property value="tsxDksqbImport.gxbmName"/></td>
      <td align="right" >专业：</td>
      <td id="zyContainer">
       <s:if test="tsxDksqbImport.dklx==0 || tsxDksqbImport.gxbm.length()==12">
         <s:textfield name="tsxDksqbImport.zymc" id="zymc" maxlength="100" size="20"></s:textfield>
       </s:if>
       <s:else>
      <s:select name="tsxDksqbImport.zy" id="zy" list="getMyZy(tsxDksqbImport==null?DepartID:tsxDksqbImport.gxbm)" headerKey="" headerValue="----请选择-----" listKey="id" listValue="caption"/> <label style="color:red">*</label>
      </s:else>
      </td>
      <td  align="right">年级：</td>
      <s:set name="zdlb" value="'nj'"/>
      <td><s:select name="tsxDksqbImport.nj" id="nj" list="sysCode" listKey="id" listValue="caption"/>
        班级：<s:textfield name="tsxDksqbImport.bj" id="bj" maxlength="10" size="2"/>
        <s:set name="zdlb" value="'xz'"/>
        学制：<s:select name="tsxDksqbImport.xz" id="xz" headerKey="" headerValue="-选择-" list="sysCode" listKey="id" listValue="caption"/>年</td>
    </tr> 
    <tr> 
      <td align="right" nowrap="nowrap">学校类别1：</td>
      <td><s:property value="tsxDksqbImport.xxlb1Name"/></td>
      <td align="right" nowrap="nowrap">学校类别2：</td>
      <td><s:property value="tsxDksqbImport.xxlb2Name"/></td>
      <td align="right">所属省份：</td>
      <td> <s:property value="tsxDksqbImport.xxsssfName"/></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    </table>
  </fieldset>
</s:if>

 <fieldset> 
　 <legend>申请贷款信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
<s:set name="zdlb" value="'knlx'"/>
      <td align="right" width="15%" nowrap="nowrap">困难类型：</td>
      <td width="20%"><s:select name="tsxDksqbImport.knlx" id="knlx"  list="sysCode"  headerKey="" headerValue="----请选择-----"  listKey="id" listValue="caption"/> <label style="color:red">*</label></td>
<s:set name="zdlb" value="'sqxn'"/>
      <td align="right" nowrap="nowrap">申请学年：</td>
      <td colspan="3"><s:select name="tsxDksqbImport.sqqsxn" id="sqqsxn"  headerKey="" headerValue="--请选择--" list="sysCode" listKey="id" listValue="caption"/>至<s:select name="tsxDksqbImport.sqjsxn" id="sqjsxn"  headerKey="" headerValue="--请选择--" list="sysCode" listKey="id"  listValue="caption"/>年 <label style="color:red"></label></td>
    </tr> 
    <tr>
<s:set name="zdlb" value="'knlx'"/>  
      <td align="right" nowrap="nowrap">申请贷款金额：</td>
      <td ><s:textfield name="tsxDksqbImport.sqje" id="sqje" maxlength="12" size="6" onkeyup="checkTheMax()" cssStyle="ime-mode:disabled" onkeypress="NumberText(event);"/>元 <label style="color:red">*</label></td>
<s:set name="zdlb" value="'sqqx'"/>
      <td align="right" nowrap="nowrap">申请期限：</td>
      <td><s:select name="tsxDksqbImport.sqqx" id="sqqx" list="sysCode" onclick="setsqqx()" listKey="id" listValue="caption" headerKey="" headerValue="----请选择-----" />年 <label style="color:red">*</label></td>
    </tr>
   </table>
  </fieldset>
  
  <table width="20%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
  <tr align="center" valign="middle"> 
    <td height="30" colspan="7">
    	<ul class="btn_gn">
    			<li><a href="#" title="保存" onClick="dosave()"><span>保存</span></a></li>
	    		<li><a href="#" title="关闭" onclick="window.close()"><span>关闭</span></a></li>
	   </ul>
  </tr>
  </table>
  

</s:form>
</div>
  </body>
</html>
