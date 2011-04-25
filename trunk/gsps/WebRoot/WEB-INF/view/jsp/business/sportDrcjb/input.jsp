<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
    <title>贫困生信息维护</title>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/idcard.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.bgiframe.min.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.ajaxQueue.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/thickbox-compressed.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.css">
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/lib/thickbox.css">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript">
		detailPageStyle();
function checkXssfzh(objid){
	    var sfzh = document.getElementById(objid).value;
        if(sfzh.length!=0){
        	if (!idChecked("theform", objid, "学生")) {
				document.getElementById(objid).value = "";
			}
        }
	    var zzmkp=document.getElementById("zzmkp").value;
	    if(sfzh.length==18){
		      
		        var xb=sfzh.substring(16,17);
		        if (xb=="0"||xb=="2"||xb=="4"||xb=="6"||xb=="8")
		           {   xb="2";}
		         else {xb="1";}
				document.getElementById('xb').value=xb;
		        var csny= sfzh.substring(6,10)+'-'+sfzh.substring(10,12);
				document.getElementById('csny').value=csny;
				document.getElementById('sfzhm').value=(document.getElementById('sfzhm').value).toUpperCase();

		}else if(sfzh.length==15){
		    
		        var xb=sfzh.substr(14,1);
		        if (xb=="0"||xb=="2"||xb=="4"||xb=="6"||xb=="8")
		           {
		           xb="2";}
		            else
		            {xb="1";}
				document.getElementById('xb').value=xb;
			
		        var csny='19'+sfzh.substring(6,8)+'-'+sfzh.substring(8,10);
		        document.getElementById('csny').value=csny;
		}
	    if(objid=="sfzhm" &&zzmkp.length==0){
			loadCheckSfzh_PKS();
		}
	}
	//判断贫困生库是否已存在该身份证号码，只有院系 贫困生资格认定页面要判断
function loadCheckSfzh_PKS(){
		var sfzhm = $("#sfzhm").val();
			ajaxService.checkSfzhm_PKSKDQ(sfzhm, callFillJkrData);
		function callFillJkrData(po){
			if(po=="FALSE"){
				alert("贫困生库已存在该身份证号码的信息！");
				document.getElementById('sfzhm').value="";
				document.getElementById('xb').value="";
				document.getElementById('csny').value="";
				return false;
			}else{
				loadSjxxSqrData();
			}
		}
}
	
function isNum(str){
			var s=document.getElementById(str).value;
			var re = /^[\d]+$/;
        	if(s!=""&&re.test(s)==false){
        		alert('只能是数字!');
        		document.getElementById(str).value="";
        		document.getElementById(str).focus();
        		return false;
        	}
		}
		
	$(document).ready(function(){
	
		var url = "<s:property value="basePath"/>/suggest?aim=depart";
		
		getSuggest("departname","departid",url);
	});
	
	
	   
	//删除一行家庭成员
function removeThisRow(obj){
    $("#" + obj.id).parent().parent().remove();
}
		
function getPersonMaxNum(){
    var num = 0;
    var ryInput = $("input[@name*=tpkskJtcys]").each(function(i){
        if (this.name.indexOf(".wid") != -1) {
            var thisIndexStr = this.name;
            var end = thisIndexStr.substring("tpkskJtcys[".length);
            var thisIndex = end.substring(0, end.indexOf("].wid"));
            if (thisIndex > num) 
                num = thisIndex;
        }
    });
    return num;
}

		//创建一行家庭成员
function createJtxx(){
    var id = (new Date()).getTime() + "";
    var maxNum = getPersonMaxNum();
    var newnum = parseInt(maxNum) + 1;
    var newTag = "tpkskJtcys[" + newnum + "]";
    jQuery.noConflict();
    var cellFuncs = [function(data){
        return "<input name='" + newTag + ".xm' type='text' maxlength='50' size='6'/><input type='hidden' name='" + newTag + ".wid'/>";
    },function(data){
        return "<input name='" + newTag + ".nl' type='text' cssStyle='ime-mode:disabled' onkeypress='NumberText(event,false,false);' maxlength='3' size='4'/>";
    }, function(data){
        var a = document.getElementById("yxsgxFirst").innerHTML;
        a = a.replace(/(^\s*)|(\s*$)/g, ""); 
        var addd = a.indexOf("tpkskJtcys[0]");
        var start = a.substring(0, addd);
        var end = a.substring(addd + "tpkskJtcys[0]".length); 
        return start + newTag + end;
    }, function(data){    
        return "<input name='" + newTag + ".gzdw' type='text' maxlength='50' size='10'/>";
    }, function(data){
        return "<input name='" + newTag + ".zy' type='text' maxlength='150' size='10'/>";
    }, function(data){
        return "<input name='" + newTag + ".nsr' cssStyle='ime-mode:disabled' onkeypress='NumberText(event,false,false);'  type='text' maxlength='50' size='5'/>";
    }, function(data){
        return "<input name='" + newTag + ".jkzk' type='text' maxlength='50' size='20'/>";
    }, function(data){
        return "<input id='" + id + "' type='button' value='删除' onclick='removeThisRow(this)'/>";
    }
];
    DWRUtil.addRows("tpkskJtcys1", [id], cellFuncs, {
        escapeHtml: false
    });
    $ = jQuery;
    ///rebundstyle();
}
		
	function rebundstyle(){
    $("#tpkskJtcys1 > td").css("text-align", "center");
    $("#tpkskJtcys1 > td").attr("align", "center");
    detailPageStyle();
}	

	function loadSjxxSqrData(){
		var sfzh = $("#sfzhm").val();
		var wid = $("#wid").val();
		if(sfzh.length>1&&wid==""){
			ajaxService.loadSjxxSqrData(sfzh, callFillJkrData1);
		}
		function callFillJkrData1(po){
			if(po.sfzhm!=""){
				fillJkrData(po);
			}
		}
	}
	function fillJkrData(po){
		if($("#xm").val()=="")$("#xm").val(po.xm);
		if($("#sfzhm").val()=="")$("#sfzhm").val(po.sfzhm);
		if($("#xb").val()=="")$("#xb").val(po.sfzhm);
		if($("#csny").val()=="")$("#csny").val(po.csny);
		if($("#xxtxdd").val()=="")$("#xxtxdd").val(po.xxtxdd);
		if($("#lxdh").val()=="")$("#lxdh").val(po.lxdh);
		if($("#yzbm").val()=="")$("#yzbm").val(po.yzbm);
		if($("#yxbm").val()=="")$("#yxbm").val(po.yxbm);
		if($("#hjqx").val()=="")$("#hjqx").val(po.hjqx);
		if($("#hjqxName").val()=="")$("#hjqxName").val(po.hjqxName);
		if($("#xszy").val()=="")$("#xszy").val(po.xszy);
		//if($("#xsnj").val()=="")$("#xsnj").val(po.xsnj);
		if($("#pklx").val()=="")$("#pklx").val(po.pklx);
		if($("#gxmc").val()=="")$("#gxmc").val(po.gxmc);
		if($("#yxmc").val()=="")$("#yxmc").val(po.yxmc);
		if($("#rxqhk").val()=="")$("#rxqhk").val(po.rxqhk);
		if($("#mz").val()=="")$("#mz").val(po.mz);
		if($("#zzmm").val()=="")$("#zzmm").val(po.zzmm);
		if($("#jtrks").val()=="")$("#jtrks").val(po.jtrks);
	}
	
validate_required_fields = [
			{fieldId:"sfzhm", message:"身份证号不能为空！", mustMatch: true}, 
			{fieldId:"xm", message:"学生姓名不能为空！", mustMatch: true}, 
			{fieldId:"csny", message:"出生年月不能为空！", mustMatch: true},
			{fieldId:"xb", message:"性别不能为空！", mustMatch: true},
			{fieldId:"zzmm", message:"政治面貌不能为空！", mustMatch: true}, 
			{fieldId:"rxqhk", message:"入学前户口不能为空！", mustMatch: true}, 
			{fieldId:"mz", message:"民族不能为空！", mustMatch: true},
			{fieldId:"jtrks", message:"家庭人口数不能为空！", mustMatch: true},
			{fieldId:"byxy", message:"毕业学校不能为空！", mustMatch: true},
			{fieldId:"grtc", message:"个人特长不能为空！", mustMatch: true},
			{fieldId:"gc", message:"孤 残不能为空！", mustMatch: true},
			{fieldId:"dq", message:"单亲不能为空！", mustMatch: true},
			{fieldId:"lszn", message:"烈士子女不能为空！", mustMatch: true},
			{fieldId:"pkdj", message:"贫困等级不能为空！", mustMatch: true},
			{fieldId:"xlcc", message:"学历不能为空！", mustMatch: true},
			{fieldId:"xszy", message:"专业不能为空！", mustMatch: true},
			{fieldId:"hjqxName", message:"家庭户籍区县不能为空！", mustMatch: true},
			{fieldId:"xsnj", message:"学生年级不能为空！", mustMatch: true},
			{fieldId:"xxtxdd", message:"详细通讯地址不能为空！", mustMatch: true},
			{fieldId:"yzbm", message:"邮政编码不能为空！", mustMatch: true},
			{fieldId:"lxdh", message:"联系电话不能为空！", mustMatch: true},	
			{fieldId:"tjcyxm", message:"家庭成员姓名不能为空！", mustMatch: false},
			{fieldId:"tjcynl", message:"家庭成员年龄不能为空！", mustMatch: false},
			{fieldId:"jtrjnsr", message:"家庭人均年收入不能为空！", mustMatch: true},
			{fieldId:"ywsj", message:"家庭遭受突发意外事件不能为空！", mustMatch: true},
			{fieldId:"jtzszrzhqk", message:"家庭遭受自然灾害情况不能为空！", mustMatch: true},
			{fieldId:"ljrqk", message:"家庭成员因残疾、年迈而劳动能力弱情况不能为空！", mustMatch: true},
			{fieldId:"syqk", message:"家庭成员失业情况不能为空！", mustMatch: true},
			{fieldId:"qzqk", message:"家庭欠债情况不能为空！", mustMatch: true},
			{fieldId:"qtqk", message:"其他情况不能为空！", mustMatch: true},   
			{fieldId:"mzTxdz", message:"详细通讯地址不能为空！", mustMatch: true},
			{fieldId:"mzYzjm", message:"民政部门邮政编码不能为空！", mustMatch: true},
			{fieldId:"mzLxdh", message:"民政部门联系电话不能为空！", mustMatch: true}
		];
		validate_length_range_fields = [
			{fieldId:"yzbm", minLen:6, maxLen:6, message:"家庭邮政编码长度不对！", ignoreIfEmpty: true}, 
			{fieldId:"lxdh", minLen:11, maxLen:12, message:"家庭联系电话长度不对！", ignoreIfEmpty: true},
			{fieldId:"mzYzjm", minLen:6, maxLen:6, message:"民政部门邮政编码长度不对！", ignoreIfEmpty: true},
			{fieldId:"mzLxdh", minLen:10, maxLen:12, message:"民政部门联系电话长度不对！", ignoreIfEmpty: true}
		];

	
function  dosave(){
		///var zzmkp=document.getElementById("zzmkp").value;
		///if(zzmkp!='4'){
		///	if(isValidateForm()&&checkJtcy()){
		///	super_submitForm();
   		/// }
		///}else{
			if(isValidateForm()){
			super_submitForm();
		///}

	}
	}
function checkJtcy(){
		var jtcyXm=document.getElementById("tjcyxm").value;
		var jtcyNl=document.getElementById("tjcynl").value;
		if(jtcyXm.length==0){
			alert("请输入家庭成员姓名");
			document.getElementById(tjcyxm).focus();
			return false;
		}
		if(jtcyNl.length==0){
			alert("请输入家庭成员年龄");
			document.getElementById(jtcyNl).focus();
			return false;
		}
		var re = /^[\d]+$/;
		if(jtcyNl!=""&&re.test(jtcyNl)==false){
				alert('只能是数字!');
        		document.getElementById(jtcyNl).value="";
        		document.getElementById(jtcyNl).focus();
        		return false;
		}
		return true;
	}
//家庭户籍所在地
	var tem_valueObjid,tem_nameObjid;
function selectArea(valueObjid,nameObjid){
		tem_valueObjid = valueObjid;
		tem_nameObjid = nameObjid;
		var url = "<s:property value="basePath"/>/system/depart-commonAreaTree.c";
		openTreeDialog(url);
	}
	

	    </script>
	
	<SCRIPT type="text/javascript">
	//根据学历层次，查询出对应的年级
function getXsNj(){		
		var xlcc=document.getElementById("xlcc").value;			
		var val=null;		
			if(xlcc=="1"&&xlcc!=null){
				val="bknj_pks";
			}
			else if(xlcc=="2"&xlcc!=null){
				val="zknj_pks";
			}
			else if(xlcc=="3"&xlcc!=null){
				val="dexwnj_pks";
			}
			var sqlMapKey = "getSelectContents";
			ajaxService.getSelectXsNj(sqlMapKey,val,cb);	
			detailPageStyle();
	   	}
function cb(result){
		var changeSelectId = "xsnj";
		if(document.getElementById(changeSelectId)){
		}else{
			$("#zyContainer").html('<select name="tpkskDq.xsnj" id="xsnj"><option value="">----请选择-----</option></select>');
		}
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		DWRUtil.removeAllOptions(changeSelectId);
		DWRUtil.addOptions( changeSelectId, result );
		$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
	}
	
	
	
	</SCRIPT>
  </head>
  
  <body style="text-align:center;">
  <s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
  </s:if>

<div class="framestyle" style="width:98%;padding: 0pt 10pt 10pt 10pt;">
  <s:form name="theform" method="post" theme="simple">
  <s:hidden id="wid" name="tpkskDq.wid" />
  <s:hidden name="tpkskDq.hjqx" id="hjqx" />
 <s:hidden name="zzmkp" id="zzmkp" value="%{#parameters.zzmkp[0]}" />

  <table width="100%" border="0" align="center">
    <tr>
    	<th height="40px" width="100%" align="center"><h3>贫困生信息维护</h3></th>
    </tr>
  </table>
  

 <fieldset>
  <legend>学生本人基本情况</legend>
 <table width="100%" border="0" align="left">
      <tr>
      <td align="right" nowrap="nowrap">身份证号：</td>
      <td><s:textfield name="tpkskDq.sfzhm" id="sfzhm" maxlength="18" size="23" onblur="checkXssfzh('sfzhm')" cssStyle="ime-mode:disabled" /><label style="color:red">*</label></td>
      <td align="right" nowrap="nowrap">姓名：</td>
      <td><s:textfield name="tpkskDq.xm"  id="xm"  maxlength="15" size="10"/><label style="color:red">*</label></td>
      <td align="right" nowrap="nowrap">出生年月：</td>
      <td><s:textfield name="tpkskDq.csny" id ="csny"   maxlength="15" size="8"/><label style="color:red">*</label></td>
      </tr>
      <tr>
      <td align="right" nowrap="nowrap" >性别：</td>
      <td><s:select id="xb" name="tpkskDq.xb" list="getSysCode('xb')" headerKey="" headerValue="-------请选择-----" listKey="id" listValue="caption"/><label style="color:red">*</label> </td>
      <td align="right" nowrap="nowrap">政治面貌：</td>
    
       <td><s:select id="zzmm" name="tpkskDq.zzmm" list="getSysCode('zzmm')" headerKey="" headerValue="-------请选择-----" listKey="id" listValue="caption"/> <label style="color:red">*</label></td> 
      <td align="right" nowrap="nowrap">入学前户口：</td>
       <td><s:select id="rxqhk" name="tpkskDq.rxqhk"  list="getSysCode('rxqhk')" headerKey="" headerValue="-------请选择-----" listKey="id" listValue="caption"/> <label style="color:red">*</label></td>
      </tr>
        <tr>
      <td align="right" nowrap="nowrap">民族：</td>
      <td><s:select id="mz" name="tpkskDq.mz" list="getSysCode('mz')" headerKey="" headerValue="-------请选择-----" listKey="id" listValue="caption"/><label style="color:red">*</label> </td>
      <td align="right" nowrap="nowrap">家庭人口数：</td>
      <td><s:textfield name="tpkskDq.jtrks" id="jtrks"  maxlength="15" size="5" onchange="isNum('jtrks')"/><label style="color:red">*</label></td>
      <td align="right" nowrap="nowrap">毕业学校：</td>
      <td><s:textfield name="tpkskDq.byxy" id="byxy"  maxlength="15" size="20"/><label style="color:red">*</label></td>
      </tr>
        <tr>
      <td align="right" nowrap="nowrap">个人特长：</td>
      <td><s:textfield name="tpkskDq.grtc"  id="grtc" maxlength="150" size="31"/><label style="color:red">*</label></td>
      <td align="right" nowrap="nowrap">孤 残：</td>
      <td><s:select id="gc" name="tpkskDq.gc" list="getSysCode('gc')" headerKey="" headerValue="-------请选择-----" listKey="id" listValue="caption"/><label style="color:red">*</label> </td>
      <td align="right" nowrap="nowrap">单亲：</td>
      <td><s:select name="tpkskDq.dq" id="dq" list="getSysCode('dq')" headerKey="" headerValue="----请选择-----" listKey="id" listValue="caption"/> <label style="color:red">*</label></td> 
      </tr> 
       <tr>
      <td align="right" nowrap="nowrap">烈士子女：</td>
      <td><s:select name="tpkskDq.lszn" id="lszn" list="getSysCode('lszn')"  headerKey="" headerValue="----请选择-----" listKey="id" listValue="caption"/> <label style="color:red">*</label></td> 
      <td align="right" nowrap="nowrap">贫困等级：</td>
      <td><s:select name="tpkskDq.pkdj" id="pkdj" list="getSysCode('pkdj')" headerKey="" headerValue="----请选择-----" listKey="id" listValue="caption"/> <label style="color:red">*</label></td> 
     <td align="right" nowrap="nowrap">专业：</td>
      <s:set name="gxbm" value="tpkskDq==null?DepartID:tpkskDq.yxbm" id="yxbm"/>
     <td> <s:select name="tpkskDq.xszy" id="xszy" list="getMyZy()" headerKey="" headerValue="----请选择-----" listKey="id" listValue="caption"/> <label style="color:red">*</label></td>
      </tr>
       <tr>
      <td align="right" nowrap="nowrap">学历层次：</td>
      <td><s:select name="tpkskDq.xlcc" id="xlcc" list="getSysCode('xlcc_pks')"  onchange="getXsNj()" headerKey="" headerValue="----请选择-----" listKey="id" listValue="caption"/> <label style="color:red">*</label></td> 
      <td align="right" nowrap="nowrap">年级：</td>
       <td><s:select name="tpkskDq.xsnj" id="xsnj" list="getSysCode('bknj_pks')" headerKey="" headerValue="---请选择---" listKey="id" listValue="caption"/> <label style="color:red">*</label>
      	班级： <s:textfield name="tpkskDq.xsbj"  id="xsbj" maxlength="10" size="5"/>
       </td> 
      
 
  
      <td align="right" nowrap="nowrap">家庭户籍区县：</td>
      <td><s:textfield name="tpkskDq.hjqxName" id="hjqxName"	maxlength="20" size="20" readonly="true" />
		<input type="button" value="..." onblur="complete2()" onclick="selectArea('hjqx','hjqxName')" />
		<label style="color:red">*</label></td>     
      </tr>    
      <tr>
      <td align="right" nowrap="nowrap">贫困类型：</td>
      <td><s:select name="tpkskDq.pklx" id="pklx" list="getSysCode('knlx')" headerKey="" headerValue="----请选择-----" listKey="id" listValue="caption"/> <label style="color:red">*</label></td> 
       <td align="right" nowrap="nowrap">高校名称：</td>
      <td><s:textfield name="gxmc"  id="gxmc" disabled="true" maxlength="15" size="15"/></td>
       <td align="right" nowrap="nowrap">院系：</td>
      <td><s:textfield name="yxmc"  id="yxmc" disabled="true" maxlength="15" size="15"/></td>
     
      </tr>
  </table>
    </fieldset>
          <br><br>
 <fieldset>
    <legend align="left">家庭通讯信息</legend>
        <table width="100%" border="0" align="center">
            <tr>
		      <td align="right" nowrap="nowrap">详细通讯地址：</td>
		      <td><s:textfield name="tpkskDq.xxtxdd"  id="xxtxdd" maxlength="30" size="31"/><label style="color:red">*</label></td>
		      <td align="right" nowrap="nowrap">邮政编码：</td>
		      <td><s:textfield name="tpkskDq.yzbm" id="yzbm" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"  onchange="isNum('mzYzjm')"  maxlength="6" onchange="isNum('yzbm')" size="10"/><label style="color:red">*</label></td>
		      <td align="right" nowrap="nowrap">联系电话：</td>
		      <td><s:textfield name="tpkskDq.lxdh" id="lxdh" onchange="isNum('lxdh')" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"  onchange="isNum('mzYzjm')"  maxlength="12" size="20"/><label style="color:red">*</label></td>
		      </tr>		     
         </table>
  </fieldset>   
      <br><br>
    <fieldset>
    <legend align="left">家庭成员信息</legend>
        <table width="100%" border="0" align="center">
             <tr>
                 <td >姓名</td>
                 <td >年龄</td>
                 <td >与学生关系</td>
                 <td >工作（学习）单位</td>
                 <td >职业</td>
                 <td >年收入（元）</td>
                 <td >健康状况</td>
                 <td >操作</td>
               </tr>
               <tbody id="tpkskJtcys1">
               <s:if test="tpkskJtcys==null || tpkskJtcys.size==0">
               <tr>
                 <td ><s:textfield name="tpkskJtcys[0].xm" id="tjcyxm" maxlength="20" size="6"/></td>
                 <td ><s:textfield name="tpkskJtcys[0].nl" id="tjcynl" onchange="isNum('tjcynl')" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" maxlength="3" size="4"/></td>
 				 <td id="yxsgxFirst"><s:select name="tpkskJtcys[0].yxsgx" id="yxsgx" list="getSysCode('jzgx')"  listKey="id" listValue="caption"/></td>
                 <td ><s:textfield name="tpkskJtcys[0].gzdw"   maxlength="20" size="10"/></td>
                 <td ><s:textfield name="tpkskJtcys[0].zy"   maxlength="100" size="10"/></td>
                 <td ><s:textfield name="tpkskJtcys[0].nsr" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"   maxlength="100" size="5"/></td>
                 <td ><s:textfield name="tpkskJtcys[0].jkzk"   maxlength="100" size="20"/></td>
                 <td ><input type="button" value="添加" onclick="createJtxx()"/></td>
             </tr>
             </s:if>
            <s:else>
				    	<s:iterator value="tpkskJtcys" status="stat">
			    	  <tr>  
				    	<s:hidden name="tpkskJtcys[%{#stat.index}].wid"/>
				         <td align="center"><s:textfield name="tpkskJtcys[%{#stat.index}].xm" value="%{xm}" maxlength="20" size="6"/></td>
				         <td align="center"><s:textfield name="tpkskJtcys[%{#stat.index}].nl" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"  id="" value="%{nl}" maxlength="3" size="4"/></td>
				         <s:set name="zdlb" value="'jzgx'"></s:set>
				         <td align="center" <s:if test="#stat.index==0">id="yxsgxFirst"</s:if>><s:select name="tpkskJtcys[%{#stat.index}].yxsgx" value="%{yxsgx}" list="sysCode" listKey="id" listValue="caption"/></td>
				         <td align="center"><s:textfield name="tpkskJtcys[%{#stat.index}].gzdw" value="%{gzdw}" maxlength="20" size="10"/></td>
				      
				         <td align="center"><s:textfield name="tpkskJtcys[%{#stat.index}].zy" value="%{zy}" maxlength="100" size="10"/></td>
				         <td align="center"><s:textfield name="tpkskJtcys[%{#stat.index}].nsr" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{nsr}" maxlength="100" size="5"/></td>
				         <td align="center"><s:textfield name="tpkskJtcys[%{#stat.index}].jkzk" value="%{jkzk}" maxlength="100" size="20"/></td>
				         <td align="center">
				         <s:if test="#stat.index==0">
						     <input type="button" value="添加" onclick="createJtxx()"/>
					     </s:if>
					     <s:else>
						     <input id="jtxx_<s:property value="#stat.index"/>" type="button" value="删除" onclick="removeThisRow(this)"/>			     
					     </s:else>
					     </td>
				     </tr>
			    	</s:iterator>
			    	</s:else>
			    	</tbody>
         </table>
  </fieldset>
  <br><br>
 <fieldset>
    <legend align="left">影响家庭经济状况有关信息</legend>
        <table width="100%" border="0" align="center">
            
		      <tr>
		      <td align="right" nowrap="nowrap">家庭人均年收入(元)：</td>
		      <td><s:textfield name="tpkskDq.jtrjnsr"  id="jtrjnsr" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"  onchange="isNum('jtrjnsr')"  maxlength="100" size="10"/><label style="color:red">*</label></td>
		      <td align="right" nowrap="nowrap">家庭遭受自然灾害情况：</td>
		      <td><s:textfield name="tpkskDq.jtzszrzhqk" id="jtzszrzhqk"  maxlength="150" size="20"/><label style="color:red">*</label></td>
		   
		      </tr>
		     <tr>
		      <td align="right" nowrap="nowrap">家庭遭受突发意外事件：</td>
		      <td><s:textfield name="tpkskDq.ywsj"  id="ywsj" maxlength="150" size="20"/><label style="color:red">*</label></td>
		      <td align="right" nowrap="nowrap" >家庭成员因残疾、年迈而劳动能力弱情况：</td>
		      <td><s:textfield name="tpkskDq.ljrqk"  id="ljrqk" maxlength="150" size="25"/><label style="color:red">*</label></td>  
		      </tr>
		       <tr>
		       <td align="right" nowrap="nowrap">家庭成员失业情况：</td>
		      <td><s:textfield name="tpkskDq.syqk" id="syqk"  maxlength="150" size="20"/><label style="color:red">*</label></td>		     
		      <td align="right" nowrap="nowrap">家庭欠债情况：</td>
		      <td><s:textfield name="tpkskDq.qzqk"  id="qzqk" maxlength="150" size="20"/><label style="color:red">*</label></td>
		     
		      </tr>
		      <tr>
		       <td align="right" nowrap="nowrap">其他情况：</td>
		      <td><s:textfield name="tpkskDq.qtqk"  id="qtqk" maxlength="150" size="30"/><label style="color:red">*</label></td>
		      </tr>
         </table>
  </fieldset>
 <br><br>
 <fieldset>
    <legend align="left">民政部门信息</legend>
        <table width="100%" border="0" align="center">
            <tr>  
		      <td align="right" nowrap="nowrap">详细通讯地址：</td>
		      <td><s:textfield name="tpkskDq.mzTxdz"  id="mzTxdz" maxlength="30" size="31"/><label style="color:red">*</label></td>
		      <td align="right" nowrap="nowrap">邮政编码：</td>
		      <td><s:textfield name="tpkskDq.mzYzjm" id="mzYzjm" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"  onchange="isNum('mzYzjm')"  maxlength="6" size="10"/><label style="color:red">*</label></td>
		      <td align="right" nowrap="nowrap">联系电话：</td>
		      <td><s:textfield name="tpkskDq.mzLxdh" id="mzLxdh"  onchange="isNum('mzLxdh')" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);"  onchange="isNum('mzYzjm')"  maxlength="12" size="20"/><label style="color:red">*</label></td>
		      </tr>
         </table>
  </fieldset>
  <fieldset>
    <legend align="left">经办信息</legend>
        <table width="100%" border="0" align="center">
            <tr>
		      <td align="right" nowrap="nowrap">经办人：</td>
		      <td><s:textfield name="tpkskDq.jbr"  id="jbr" maxlength="30" size="31"/></td>
		      <td align="right" nowrap="nowrap">经办单位名称：</td>
		      <td><s:textfield name="tpkskDq.jbdwmc" id="jbdwmc"  maxlength="6" size="10"/></td>
		    </tr>
         </table>
  </fieldset>
  <table width="30%" border="0" align="center">
    <tr>  
       <td align="center">
       <ul class="btn_gn">
	<s:token />
	  	<li><a href="#" title="保存" onClick="dosave()"><span>保存</span></a></li>
	   <li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	   
       </ul></td>
    </tr>
  </table>
   
</s:form>
</div>

  </body>
</html>

