// JavaScript Document
document.writeln("<div id=meizzDateLayer style=\"position: absolute; width: 142; height: 166; z-index: 9998; display: none\">");
document.writeln("<span id=tmpSelectYearLayer  style=\"z-index: 9999;position: absolute;top: 2; left: 18;display: none\"></span>");
document.writeln("<span id=tmpSelectMonthLayer style=\"z-index: 9999;position: absolute;top: 2; left: 75;display: none\"></span>");
document.writeln("<table border=0 cellspacing=1 cellpadding=0 width=142 height=160 bgcolor=#808080 onselectstart=\"return false\">");
document.writeln("  <tr><td width=142 height=23 bgcolor=#FFFFFF><table border=0 cellspacing=1 cellpadding=0 width=140 height=23>");
document.writeln("      <tr align=center><td width=20 align=center bgcolor=#808080 style=\"font-size:12px;cursor: pointer;color: #FFD700\" ");
document.writeln("        onclick=\"meizzPrevM()\" title=\"\u5411\u524d\u7ffb\u3000\u6708\" Author=meizz><b Author=meizz>&lt;&lt;</b>");
document.writeln("        </td><td width=100 align=center style=\"font-size:12px;cursor:default\" Author=meizz>");
document.writeln("        <span Author=meizz id=meizzYearHead onclick=\"tmpSelectYearInnerHTML(this.innerHTML)\"></span>&nbsp;\u5e74&nbsp;<span");
document.writeln("         id=meizzMonthHead Author=meizz onclick=\"tmpSelectMonthInnerHTML(this.innerHTML)\"></span>&nbsp;\u6708</td>");
document.writeln("        <td width=20 bgcolor=#808080 align=center style=\"font-size:12px;cursor: pointer;color: #FFD700\" ");
document.writeln("         onclick=\"meizzNextM()\" title=\"\u5f80\u540e\u7ffb\u3000\u6708\" Author=meizz><b Author=meizz>&gt;&gt;</b></td></tr>");
document.writeln("    </table></td></tr>");
document.writeln("  <tr><td width=142 height=18 bgcolor=#808080>");
document.writeln("<table border=0 cellspacing=0 cellpadding=0 width=140 height=1 style=\"cursor:default\">");
document.writeln("<tr align=center><td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>\u65e5</td>");
document.writeln("<td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>\u4e00</td><td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>\u4e8c</td>");
document.writeln("<td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>\u4e09</td><td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>\u56db</td>");
document.writeln("<td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>\u4e94</td><td style=\"font-size:12px;color:#FFFFFF\" Author=meizz>\u516d</td></tr>");
document.writeln("</table></td></tr><!-- Author:J.L.Yang(oldk) http://www.njfstech.com/ mail: ys@njfstech.com 2006-01-01 -->");
document.writeln("  <tr><td width=142 height=120>");
document.writeln("    <table border=0 cellspacing=1 cellpadding=0 width=140 height=120 bgcolor=#FFFFFF>");
var n = 0;
for (j = 0; j < 5; j++) {
    document.writeln(" <tr align=center>");
    for (i = 0; i < 7; i++) {
        document.writeln("<td width=20 height=20 id=meizzDay" + n + " style=\"font-size:12px\" Author=meizz onclick=\"meizzDayClick(this.innerHTML);\"></td>");
        n++;
    }
    document.writeln("</tr>");
}
document.writeln("      <tr align=center><td width=20 height=20 style=\"font-size:12px\" id=meizzDay35 Author=meizz ");
document.writeln("         onclick=\"meizzDayClick(this.innerHTML);\"></td>");
document.writeln("        <td width=20 height=20 style=\"font-size:12px\" id=meizzDay36 Author=meizz onclick=\"meizzDayClick(this.innerHTML);\"></td></tr>");
document.writeln("    </table></td></tr><tr><td>");
document.writeln("        <table border=0 cellspacing=1 cellpadding=0 width=100% bgcolor=#FFFFFF>");
document.writeln("          <tr><td Author=meizz align=left><input Author=meizz type=button value=\"<<\" title=\"\u5411\u524d\u7ffb\u3000\u5e74\" onclick=\"meizzPrevY()\" ");
document.writeln("             onfocus=\"this.blur()\" style=\"font-size: 12px; height: 20px\"><input Author=meizz title=\"\u5411\u524d\u7ffb\u3000\u6708\" type=button ");
document.writeln("             value=\"<\" onclick=\"meizzPrevM()\" onfocus=\"this.blur()\" style=\"font-size: 12px; height: 20px\"></td><td ");
document.writeln("             Author=meizz align=center><input Author=meizz type=button value=\u4eca\u5929 onclick=\"meizzToday()\" ");
document.writeln("             onfocus=\"this.blur()\" title=\"\u8f6c\u5230\u4eca\u5929\u7684\u65e5\u671f\" style=\"font-size: 12px; height: 20px\"></td><td ");
document.writeln("             Author=meizz align=right><input Author=meizz type=button value=\">\" onclick=\"meizzNextM()\" ");
document.writeln("             onfocus=\"this.blur()\" title=\"\u5f80\u540e\u7ffb\u3000\u6708\" style=\"font-size: 12px; height: 20px\"><input ");
document.writeln("             Author=meizz type=button value=\">>\" title=\"\u5f80\u540e\u7ffb\u3000\u5e74\" onclick=\"meizzNextY()\"");
document.writeln("             onfocus=\"this.blur()\" style=\"font-size: 12px; height: 20px\"></td>");
document.writeln("</tr></table></td></tr></table></div>");
document.close();
//==================================================== WEB 页面显示部分 ======================================================
var outObject;

//firefox的年份问题
function y2k(number) {
    var num=parseInt(number,10);
    return (num < 1000) ? (num + 1900) : num;
}
function setday(tt, obj) { //主调函数
    if (arguments.length > 2) {
        alert("\u5bf9\u4e0d\u8d77\uff01\u4f20\u5165\u672c\u63a7\u4ef6\u7684\u53c2\u6570\u592a\u591a\uff01");
        return;
    }
    if (arguments.length == 0) {
        alert("\u5bf9\u4e0d\u8d77\uff01\u60a8\u6ca1\u6709\u4f20\u56de\u672c\u63a7\u4ef6\u4efb\u4f55\u53c2\u6570\uff01");
        return;
    }
    var dads = document.getElementById("meizzDateLayer").style;
    var th = tt;
    var ttop = tt.offsetTop;     //TT控件的定位点高
    var thei = tt.clientHeight;  //TT控件本身的高
    var tleft = tt.offsetLeft;    //TT控件的定位点宽
    var ttyp = tt.type;          //TT控件的类型
    while (tt = tt.offsetParent) {
        ttop += tt.offsetTop;
        tleft += tt.offsetLeft;
    }
    dads.top = (ttyp == "image") ? ttop + thei : ttop + thei + 6;
    dads.left = tleft;
    outObject = (arguments.length == 1) ? th : obj;
    dads.display = "";
  //event.returnValue=false;
    return false;
}
var MonHead = new Array(12);               //定义阳历中每个月的最大天数
MonHead[0] = 31;
MonHead[1] = 28;
MonHead[2] = 31;
MonHead[3] = 30;
MonHead[4] = 31;
MonHead[5] = 30;
MonHead[6] = 31;
MonHead[7] = 31;
MonHead[8] = 30;
MonHead[9] = 31;
MonHead[10] = 30;
MonHead[11] = 31;
var meizzTheYear = y2k((new Date()).getYear()); //定义年的变量的初始值
var meizzTheMonth = (new Date()).getMonth() + 1; //定义月的变量的初始值
var meizzWDay = new Array(37);               //定义写日期的数组　
if (window.addEventListener) { // Mozilla, Netscape, Firefox 添加事件监听
    var object = document.body;
    object.addEventListener("click", closeFaceOnclick, false);
} else { // IE
    var object = document.body;
    object.attachEvent("onclick", closeFaceOnclick);
}
function closeFaceOnclick(evt) {
//任意点击时关闭该控件
    var e_out;
	// "target" for Mozilla, Netscape, Firefox et al. ; "srcElement" for IE
    evt["target"] ? e_out = evt.target : e_out = evt.srcElement;
    if (e_out.tagName != "INPUT" && e_out.getAttribute("Author") == null) {
        closeLayer();
    }
}
function meizzWriteHead(yy, mm) { 
//往 head 中写入当前的年与月
    document.getElementById("meizzYearHead").innerHTML = yy;
    document.getElementById("meizzMonthHead").innerHTML = mm;
}
function tmpSelectYearInnerHTML(strYear) { //年份的下拉框
    if (strYear.match(/\D/) != null) {
        alert("\u5e74\u4efd\u8f93\u5165\u53c2\u6570\u4e0d\u662f\u6570\u5b57\uff01");
        return;
    }
    var m = (strYear) ? y2k(strYear) : y2k(new Date().getYear());
    if (m < 1000 || m > 9999) {
        alert("\u5e74\u4efd\u503c\u4e0d\u5728 1000 \u5230 9999 \u4e4b\u95f4\uff01");
        return;
    }
    var n = m - 10;
    if (n < 1000) {
        n = 1000;
    }
    if (n + 26 > 9999) {
        n = 9974;
    }
    var s = "<select Author=meizz name=tmpSelectYear style='font-size: 12px' ";
    s += "onblur='document.getElementById(\"tmpSelectYearLayer\").style.display=\"none\"' ";
    s += "onchange='meizzTheYear = this.value; meizzSetDay(meizzTheYear,meizzTheMonth);";
    s += "document.getElementById(\"tmpSelectYearLayer\").style.display=\"none\";'>\r\n";
    var selectInnerHTML = s;
    for (var i = n; i < n + 26; i++) {
        if (i == m) {
            selectInnerHTML += "<option value='" + i + "' selected>" + i + "\u5e74" + "</option>\r\n";
        } else {
            selectInnerHTML += "<option value='" + i + "'>" + i + "\u5e74" + "</option>\r\n";
        }
    }
    selectInnerHTML += "</select>";
    document.getElementById("tmpSelectYearLayer").style.display = "";
    document.getElementById("tmpSelectYearLayer").innerHTML = selectInnerHTML;
    //document.getElementById("tmpSelectYear").focus();
    var tmpSelectYear=document.getElementById("tmpSelectYear");
    //tmpSelectYear.focus();
}
function tmpSelectMonthInnerHTML(strMonth) { //月份的下拉框
    if (strMonth.match(/\D/) != null) {
        alert("\u6708\u4efd\u8f93\u5165\u53c2\u6570\u4e0d\u662f\u6570\u5b57\uff01");
        return;
    }
    var m = (strMonth) ? strMonth : new Date().getMonth() + 1;
    var s = "<select Author=meizz name=tmpSelectMonth style='font-size: 12px' ";
    s += "onblur='document.getElementById(\"tmpSelectMonthLayer\").style.display=\"none\"' ";
    s += "onchange='meizzTheMonth = this.value; meizzSetDay(meizzTheYear,meizzTheMonth);";
    s += "document.getElementById(\"tmpSelectMonthLayer\").style.display=\"none\";'>\r\n";
    var selectInnerHTML = s;
    for (var i = 1; i < 13; i++) {
        if (i == m) {
            selectInnerHTML += "<option value='" + i + "' selected>" + i + "\u6708" + "</option>\r\n";
        } else {
            selectInnerHTML += "<option value='" + i + "'>" + i + "\u6708" + "</option>\r\n";
        }
    }
    selectInnerHTML += "</select>";
    var layert=document.getElementById("tmpSelectMonthLayer");
    layert.style.display = "";
    layert.innerHTML = selectInnerHTML;
    var tmpSelectMonth=document.getElementById("tmpSelectMonth");
    //tmpSelectMonth.focus();
}
function closeLayer() {              //这个层的关闭
    document.getElementById("meizzDateLayer").style.display = "none";
}
function closeFaceOnkeydown(e) {
    var mye = e ? e : window.event;
    if (mye.getAttribute("keyCode") == 27) {//选择完日期后关闭日期选择
        closeLayer();
    }
}
document.onkeydown = "closeFaceOnkeydown(event)";

function IsPinYear(year) {            //判断是否闰平年
    if (0 == year % 4 && ((year % 100 != 0) || (year % 400 == 0))) {
        return true;
    } else {
        return false;
    }
}
function GetMonthCount(year, month) {  //闰年二月为29天
    var c = MonHead[month - 1];
    if ((month == 2) && IsPinYear(year)) {
        c++;
    }
    return c;
}
function GetDOW(day, month, year) {     //求某天的星期几
    var dt = new Date(year, month - 1, day).getDay() / 7;
    return dt;
}
function meizzPrevY() {  //往前翻 Year
    if (meizzTheYear > 999 && meizzTheYear < 10000) {
        meizzTheYear--;
    } else {
        alert("\u5e74\u4efd\u8d85\u51fa\u8303\u56f4\uff081000-9999\uff09\uff01");
    }
    meizzSetDay(meizzTheYear, meizzTheMonth);
}
function meizzNextY() {  //往后翻 Year
    if (meizzTheYear > 999 && meizzTheYear < 10000) {
        meizzTheYear++;
    } else {
        alert("\u5e74\u4efd\u8d85\u51fa\u8303\u56f4\uff081000-9999\uff09\uff01");
    }
    meizzSetDay(meizzTheYear, meizzTheMonth);
}
function meizzToday() {  //Today Button
    meizzTheYear = y2k(new Date().getYear());
    meizzTheMonth = new Date().getMonth() + 1;
    meizzSetDay(meizzTheYear, meizzTheMonth);
}
function meizzPrevM() {  //往前翻月份
    if (meizzTheMonth > 1) {
        meizzTheMonth--;
    } else {
        meizzTheYear--;
        meizzTheMonth = 12;
    }
    meizzSetDay(meizzTheYear, meizzTheMonth);
}
function meizzNextM() {  //往后翻月份
    if (meizzTheMonth == 12) {
        meizzTheYear++;
        meizzTheMonth = 1;
    } else {
        meizzTheMonth++;
    }
    meizzSetDay(meizzTheYear, meizzTheMonth);
}
function meizzSetDay(yy, mm) {
//主要的写程序
    meizzWriteHead(yy, mm);
    for (var i = 0; i < 37; i++) {
        meizzWDay[i] = "";
    }  //将显示框的内容全部清空
    var day1 = 1, firstday = new Date(yy, mm - 1, 1).getDay();  //某月第一天的星期几
    for (var i = firstday; day1 < GetMonthCount(yy, mm) + 1; i++) {
        meizzWDay[i] = day1;
        day1++;
    }
    for (var i = 0; i < 37; i++) { 
   // var da = eval("document.all.meizzDay"+i)     //书写新的一个月的日期星期排列
        var da = document.getElementById("meizzDay"+i);     //书写新的一个月的日期星期排列
        //if(i==10)alert(da.innerHTML);
        if (meizzWDay[i] != "") {
            da.innerHTML =  meizzWDay[i] ;
            da.style.backgroundColor = (yy == y2k(new Date().getYear()) && mm == new Date().getMonth() + 1 && meizzWDay[i] == new Date().getDate()) ? "#FFD700" : "#ADD8E6";
            da.style.cursor = "pointer";
        } else {
            da.innerHTML = "";
            da.style.backgroundColor = "";
            da.style.cursor = "default";
        }
    }
}
function meizzDayClick(nDay) {  //点击显示框选取日期，主输入函数*************
    
    var n = parseInt(nDay,10);
    var yy = meizzTheYear;
    var mm = meizzTheMonth;
    if (mm < 10) {
        mm = "0" + mm;
    }
    if (outObject) {
        if (isNaN(n)) {
            outObject.value = "";
            return;
        }
        if (n < 10) {
            n = "0" + n;
        }
        outObject.value = yy + "-" + mm + "-" + n; //注：在这里你可以输出改成你想要的格式
        closeLayer();
    } else {
        closeLayer();
        alert("\u60a8\u6240\u8981\u8f93\u51fa\u7684\u63a7\u4ef6\u5bf9\u8c61\u5e76\u4e0d\u5b58\u5728\uff01");
    }
}
meizzSetDay(meizzTheYear, meizzTheMonth);
// -->

//下面是日期格式检查函数
function checktheformDate(sdate,edate){
	if(sdate!="" && checkDateFormat(sdate)==false){
		//document.all.startdate.focus();
		return false;
	}
	if(edate!="" && checkDateFormat(edate)==false){
		//document.all.enddate.focus();
		return false;
	}
	
	if(sdate!="" && edate!="" && better_date(sdate,edate)>=0){
		alert("请检查日期输入！\n \n开始日期应该早于结束日期！");
		//document.all.enddate.focus();
		return false;
	}
	return true;
}

function checkDateFormat(datestr){
	
	if(datestr.length>10 || datestr.length<6){
		alert("日期格式不正确，请按这样的格式输入日期(2005-01-01)！");
		return false;
	}
	var flagstr=datestr.split("-");
	var tmpdate;
	if(flagstr.length!=3){
		//tmpdate=datestr.substring(0,4)+"-"+datestr.substring(4,6);
		alert("日期格式不正确，请在年月日之间分别用\"-\"连接！");
		return false;
	}
	if(flagstr[0].length!=4){
		alert("日期格式不正确，年份应该是4位数！");
		return false;
	}
	if(flagstr[1].length>2 || flagstr[1].length<1){
		alert("日期格式不正确，月份应该是2位数，单月则前面补\"0\"！");
		return false;
	}
	if(flagstr[2].length>2 || flagstr[2].length<1){
		alert("日期格式不正确，日期应该是2位数，单日则前面补\"0\"！");
		return false;
	}

	return true;
}

function better_date(strDateStart,strDateEnd){
	//比较2个日期的大小
   var strSeparator = "-"; //日期分隔符
   var strDateArrayStart;
   var strDateArrayEnd;
   var intDay
   strDateArrayStart = strDateStart.split(strSeparator);
   strDateArrayEnd = strDateEnd.split(strSeparator);
   var strDateS = new Date(strDateArrayStart[0] + "/" + strDateArrayStart[1] + "/" + strDateArrayStart[2]);
   var strDateE = new Date(strDateArrayEnd[0] + "/" + strDateArrayEnd[1] + "/" + strDateArrayEnd[2]);
   intDay = (strDateS-strDateE)/(1000*3600*24)
   return intDay
}
