/************************************************************************/
/********************HRMS_v323 UTIL.JS **********************************/
/********************name:util.js ***************************************/
/********************modedate:2003-10-14 09:53 **************************/
/********************version: 2.0 ***************************************/
/********************copyright:zxcshenqin@126.com ***********************/
/************************************************************************/


window.attachEvent("onload", function () {
		var scrollBorderColor	="#aaaaaa";
		var scrollFaceColor	="#dedede";
		with (document.body.style) {
			scrollbarDarkShadowColor	=	scrollBorderColor;
			scrollbar3dLightColor		=	scrollBorderColor;
			scrollbarArrowColor		=	"#eeeeee";
			scrollbarBaseColor		=	scrollFaceColor;
			scrollbarFaceColor		=	scrollFaceColor;
			scrollbarHighlightColor		=	scrollFaceColor;
			scrollbarShadowColor		=	scrollFaceColor;
			scrollbarTrackColor		=	"#eeeeee";
		}
	  });	 	 

/*
function window.onhelp(){return false} 
function KeyDown(){
  	if ((window.event.altKey)&&((window.event.keyCode==37)||(window.event.keyCode==39))){ 
     	event.returnValue=false;
   }
  	if((event.keyCode==116)||(event.ctrlKey && event.keyCode==82)){
     	event.keyCode=0;
     	event.returnValue=false;
   }
  	if ((event.ctrlKey)&&(event.keyCode==78)){   
     	event.returnValue=false;
   }
  	if ((event.shiftKey)&&(event.keyCode==121)){ 
     	event.returnValue=false;
   }
  	if (window.event.srcElement.tagName == "A" && window.event.shiftKey){ 
      window.event.returnValue = false; 
   }
  if ((window.event.altKey)&&(window.event.keyCode==115)){
      window.showModelessDialog("about:blank","","dialogWidth:1px;dialogheight:1px");
      return false;
  }
}
document.onkeydown=KeyDown;

function Click(){
	window.event.returnValue=false;
}
document.oncontextmenu=Click;
*/

var marked_row = new Array;
var preRow="";
var preRowNum = "";
function setPointer(theRow, theRowNum, theAction,colorValue )
{
  	var theDefaultColor = '#f0f0f2';
	var thePointerColor = colorValue;
	var theMarkColor = colorValue;

	var theCells = null;
	if ((thePointerColor == '' && theMarkColor == '') || typeof(theRow.style) == 'undefined')
	{
		return false;
	}
	if (typeof(document.getElementsByTagName) != 'undefined')
	{
		theCells = theRow.getElementsByTagName('td');
	}
	else if (typeof(theRow.cells) != 'undefined')
	{
		theCells = theRow.cells;
	}else {
		return false;
	}
	var rowCellsCnt  = theCells.length;
	var domDetect    = null;
	var currentColor = null;
	var newColor     = null;
	if (typeof(window.opera) == 'undefined' && typeof(theCells[0].getAttribute) != 'undefined')
	{
		currentColor = theCells[0].getAttribute('bgcolor');
		domDetect    = true;
	}
 	else
	{
		currentColor = theCells[0].style.backgroundColor;
		domDetect    = false;
	} 	
	if (colorValue)
	{
		var c = null;
		if (domDetect)
		{
			for (c = 0; c < rowCellsCnt; c++)
			{
				theCells[c].setAttribute('bgcolor', colorValue, 0);
			} 
		}
		else
		{
			for (c = 0; c < rowCellsCnt; c++)
			{
				theCells[c].style.backgroundColor = colorValue;
			}
		}
	}
	if(preRowNum!="") {
      if(theRowNum!=preRowNum) {
      	setPointer(preRow,preRowNum, 'click','#f0f0f2');
      }   
   }       
   preRow=theRow;
  	preRowNum=theRowNum;  
	return true;
}


function adjustDate(dateString,adjustYear)
{
   var str = dateString;
   var dateArray = dateString.split('-');
   var month=0;
   var day=0;
   var year=0;
   
  	year = parseInt(dateArray[0],10)+parseInt(adjustYear,10);
	month = parseInt(dateArray[1],10);
   day = parseInt(dateArray[2],10);
   
   if(month==1) {
      if(day==1) {
         day=31;
         month=12;
         year=year-1;
      } else {
         day = day-1;
      }   
   } else if(day==1) {
      if((month==5)||(month==7)||(month==10)||(month==12)) {
         day=30;
         month = month-1;
      } else if((month==2)||(month==4)||(month==6)||(month==8)||(month==9)||(month=11)) { 
         day = 31;
         month=month-1;
      } else {
         if (year%4==0){
            if(year%100==0) {
               if(year%400==0) {
                  day=29;
               } else {
                  day=28;
               }   
            } else {
               day=29;
            }
         } else {
            day=28;
         }   
         month=2;
      }       
   } else {
      day = day-1;
   }
   return year+'-'+month+'-'+day;       
}

function adjustMonth(dateString,adjustYear,adjustMonth)
{	
   var str = dateString;
   var dateArray = dateString.split('-'); 
   var month=0;
   var day=0;
   var year=0;
   if(adjustYear == null ){
   	year = parseInt(dateArray[0],10);
   	month = parseInt(dateArray[1],10)+parseInt(adjustMonth,10);
   	if( month > 12  )
   	{
   		year = year+ parseInt((parseInt(month-1)) / 12 );
   		if((parseInt((parseInt(month))%12 )==0)&& (parseInt((month-1) / 12 ) > 0 ) ){
   			month = 12 ;
   		}else{
   			month = parseInt(month % 12) ;
   		}
   	}
   }else{
   	year = parseInt(dateArray[0],10)+parseInt(adjustYear,10);
	   month = parseInt(dateArray[1],10);
   }
   day = parseInt(dateArray[2],10);   
   if(month==1) {
      if(day==1) {
         day=31;
         month=12;
         year=year-1;
      } else {
         day = day-1;
      }   
   } else if(day==1) {
      if((month==5)||(month==7)||(month==10)||(month==12)) {
         day=30;
         month = month-1;
      } else if((month==2)||(month==4)||(month==6)||(month==8)||(month==9)||(month==11)) { 
         day = 31;
         month=month-1;
      } else {      
         if (year%4==0){
            if(year%100==0) {
               if(year%400==0) {
                  day=29;
               } else {
                  day=28;
               }   
            } else {
               day=29;
            }
         } else {
            day=28;
         }   
         month=2;
      }       
   } else if(day==31) {
   	if (month==2){
   		if (year%4==0){
            if(year%100==0) {
               if(year%400==0) {
                  day=29;
               } else {
                  day=28;
               }   
            } else {
               day=29;
            }
         } else {
            day=28;
         }   
         month=2;
      }          	
   } else {
   	day=day-1;
   }  
   return year+'-'+month+'-'+day;  
}


function comparedate(formName,begindateField,enddateField,begindateDesc,enddateDesc,mode)
{
	if(checkInvalid(trim(eval(formName+"."+begindateField).value))
		&&checkInvalid(trim(eval(formName+"."+enddateField).value)))
	{
		if(!compdate(eval(formName+"."+begindateField).value,eval(formName+"."+enddateField).value,mode))
		{
			var modestr='';
	      if(mode=='>=') { modestr="大于等于";
		   } else if(mode=='>') { modestr="大于";
	      } else if(mode=='<') { modestr="小于";
	      } else if(mode=='<=') { modestr="小于等于";
	      } else if(mode=='==') { modestr="等于";
   	   } else if(mode=='!=') { modestr="不等于";
         }	
      alert(begindateDesc+"必须"+modestr+enddateDesc); 
		eval(formName+"."+begindateField).focus();
	return false;
		}
	}
	return true;
}
 
function compareNumber(formName,field1,field2,fieldDesc1,fieldDesc2,mode) {
   if(checkInvalid(trim(eval(formName+"."+field1).value))
		&&checkInvalid(trim(eval(formName+"."+field2).value))) {
		var var1=trim(eval(formName+"."+field1).value);
		var var2=trim(eval(formName+"."+field2).value);
		if(eval(var1+mode+var2)) {
		   return true;
	   } else  { 
	      var modestr='';
	      if(mode=='>=') { modestr="大于等于";
		   } else if(mode=='>') { modestr="大于";
	      } else if(mode=='<') { modestr="小于";
	      } else if(mode=='<=') { modestr="小于等于";
	      } else if(mode=='==') { modestr="等于";
   	   } else if(mode=='!=') { modestr="不等于";
         }	    
	      alert(fieldDesc1+"必须"+modestr+fieldDesc2);
	      eval(formName+"."+field1).focus();
	      return false
      }	      
   }
   return true;
}

function checkDateField(formName,fieldName,fieldDesc)
{
	if(checkInvalid(trim(eval(formName+"."+fieldName+".value"))))
	{
		if(!(verifyDate(trim(eval(formName+"."+fieldName+".value")))))
		{
			alert(fieldDesc+" 必须是有效的日期");
			eval(formName+"."+fieldName+".focus()");
			return false;
		}
	}
	return true;
}

function checkYearField(formName,fieldName,fieldDesc){
	if (checkNullField(formName,fieldName,fieldDesc) == false ) {
	   return false;
	} else {
	   if (checkIntField(formName,fieldName,fieldDesc) == false ) {
	      return false;
	   } else {
	      if ((eval(formName+'.'+fieldName+'.value<1900')) || (eval(formName+'.'+fieldName+'.value>2100')) ) {
	      	alert('请输入有效的年份');
	      	eval(formName+"."+fieldName+".focus()");
	         return false;
	      } else {
	         return true;
	      }    
	   }     
	}
}

/*
   @date:2004-5-9 10:01
   @author:shenqin
*/
function checkAgeField(formName,fieldName,fieldDesc){
	if (checkNullField(formName,fieldName,fieldDesc) == false ) {
	   return false;
	} else {
	   if (checkIntField(formName,fieldName,fieldDesc) == false ) {
	      return false;
	   } else {
	      if ((eval(formName+'.'+fieldName+'.value<0')) || (eval(formName+'.'+fieldName+'.value>130')) ) {
	      	alert('请输入有效的年龄');
	      	eval(formName+"."+fieldName+".focus()");
	         return false;
	      } else {
	         return true;
	      }    
	   }     
	}
}

function checkMonthField(formName,fieldName,fieldDesc){
	if (checkNullField(formName,fieldName,fieldDesc) == false ) {
	   return false;
	} else {
	   if (checkIntField(formName,fieldName,fieldDesc) == false ) {
	      return false;
	   } else {
	      if ((eval(formName+'.'+fieldName+'.value< 1')) || (eval(formName+'.'+fieldName+'.value>12')) ) {
	      	alert('请输入有效的月份！');
	      	eval(formName+"."+fieldName+".focus()");
	         return false;
	      } else {
	         return true;
	      }    
	   }     
	}
}

function checkDateFieldEx(formName,fieldName,fieldDesc){
	if(checkInvalid(trim(eval(formName+"."+fieldName+".value"))))	{
		if(!(verifyDateEx(trim(eval(formName+"."+fieldName+".value")))))		{
			alert(fieldDesc+" 必须是有效的日期");
			eval(formName+"."+fieldName+".focus()");
			return false;
		}
	}
	return true;
}


function verifyDateEx(dateString) {
   var str = dateString;
   var dateArray = dateString.split('-');
   var format=0;
   var month=0;
   var day=0;
   var year=0;
   if(str.length<5  || str.length>10 ) {
      return false;
   } else {
   	for(var j = 0; j< str.length; ++j) {
   		var ch = str.substring(j, j + 1);
   		if ( (ch < "0" || "9" < ch) && (ch != "-") )	{
   			return false;
   		}
   	}   	
   	if ((dateArray.length!=3)&&(dateArray.length!=2)){
   		return false;
   	}   	
   	year = dateArray[0];
   	month = dateArray[1];
   	day = (dateArray.length == 2 )? 01 : dateArray[2]; 
   	if (!isDate(year,month,day)) {
   		return false;
    	}
    	return true;
   }
}

function comparedateEx(formName,begindateField,enddateField,begindateDesc,enddateDesc,mode){
	if(checkInvalid(trim(eval(formName+"."+begindateField).value))
		&&checkInvalid(trim(eval(formName+"."+enddateField).value)))
	{
		if(!compdateEx(eval(formName+"."+begindateField).value,eval(formName+"."+enddateField).value,mode))
		{
			var modestr='';
	      if(mode=='>=') { 
	         modestr="大于等于";
			} else if(mode=='>') { 
				modestr="大于";
	   	} else if(mode=='<') { 
	   	   modestr="小于";
	   	} else if(mode=='<=') { 
	   	   modestr="小于等于";
	   	} else if(mode=='==') { 
	   	   modestr="等于";
   		} else if(mode=='!=') { 
   		   modestr="不等于";
   		}	
   	alert(begindateDesc+"必须"+modestr+enddateDesc); 
		eval(formName+"."+begindateField).focus();
		return false;
	   }
   }
	return true;
}


function compdateEx(begindate,enddate,mode)
{
   var beginmonth=0;
   var beginday=0;
   var beginyear=0;
   var endmonth=0;
   var endday=0;
   var endyear=0;

   var begindateArray = begindate.split('-');
   var enddateArray = enddate.split('-');

   beginday = (begindateArray.length == 2 )? 01 : begindateArray[2]; 
   beginmonth = begindateArray[1];
   beginyear = begindateArray[0];
   endday = (enddateArray.length == 2 )? 01 : enddateArray[2]; 
   endmonth = enddateArray[1];
   endyear = enddateArray[0];

   if(beginmonth.length==1)
   	beginmonth="0"+beginmonth;
   if(beginday.length==1)
   	beginday="0"+beginday;
   if(endmonth.length==1)
   	endmonth="0"+endmonth;
   if(endday.length==1)
   	endday="0"+endday;

   var getbegindate=beginyear+beginmonth+beginday;
   var getenddate=endyear+endmonth+endday;
   var retvalue=eval(getbegindate+mode+getenddate);
   return retvalue;
}

//@date: 2003-6-1 14:26
//@fuction: 用于年份和月份的联合比较校验
function comparedateUnite(formName,beginYearField,beginMonthField,endYearField,endMonthField,begindateDesc,enddateDesc,mode)
{
   var begindateField=trim(eval(formName+"."+beginYearField+".value"))+"-"+trim(eval(formName+"."+beginMonthField).value);
   var enddateField=trim(eval(formName+"."+endYearField).value)+"-"+trim(eval(formName+"."+endMonthField).value);
   if(checkInvalid(begindateField)&& checkInvalid(enddateField) )
	{
		if(!compdateEx(begindateField,enddateField,mode))
		{
			var modestr='';
	      if(mode=='>=') { 
	         modestr="大于等于";
			} else if(mode=='>') { 
				modestr="大于";
	   	} else if(mode=='<') { 
	   	   modestr="小于";
	   	} else if(mode=='<=') { 
	   	   modestr="小于等于";
	   	} else if(mode=='==') { 
	   	   modestr="等于";
   		} else if(mode=='!=') { 
   		   modestr="不等于";
   		}	
   	alert(begindateDesc+"必须"+modestr+enddateDesc); 
		eval("document."+formName+"."+endYearField+".focus()");
		return false;
	   }
   }
	return true;
}

function getVerifyDateEx(formName,fieldName) {
   var dateString = trim(eval(formName+"."+fieldName+".value"));
   var dateArray = dateString.split('-');
   var format=0;
   var month=0;
   var day=0;
   var year=0;
  	year = dateArray[0];
  	month = dateArray[1];
  	day = (dateArray.length == 2 )? 01 : dateArray[2];
  	eval("document."+formName+"."+fieldName+".value ='"+ year+"-"+month+"-"+day+"'");
}

/**
 *2003-6-17 09:55上午新增时间校验函数
 *
 *
 */
function checkTimeFieldEx(formName,hourname,minutename,fieldDesc){
   var hourvalue=trim(eval("document."+formName+"."+hourname+".value"));
   var minutevalue=trim(eval("document."+formName+"."+minutename+".value"));
   hourvalue=(hourvalue == "")? 0 : hourvalue;
   minutevalue=(minutevalue == "")? 0 : minutevalue;
   if(hourvalue > 23||hourvalue < 0 ||isNaN(hourvalue)){
      alert(fieldDesc+" 必须是有效的时间！");
      eval(formName+"."+fieldName+".focus()");
   }
   if(minutevalue > 59||minutevalue < 0||isNaN(minutevalue) ){
      alert(fieldDesc+" 必须是有效的时间！");
      eval(formName+"."+fieldName+".focus()");
      return false;
   }      
   return true;
}
/**
 *2003-6-17 09:55上午新增时间校验函数
 *
 *

function checkTimeField(formName,hourname,minutename,fieldDesc){
	if (checkNullField(formName,hourname,fieldDesc) == false ) {
	   return false;
	}
	if (checkNullField(formName,minutename,fieldDesc) == false ) {
	   return false;
	}	   
	if (checkIntField(formName,hourname,fieldDesc) == false ) {
	      return false;
	}
	if (checkIntField(formName,minutename,fieldDesc) == false ) {
	      return false;
	}
	if ((eval(formName+'.'+hourname+'.value<0')) || (eval(formName+'.'+hourname+'.value>23')) ) {
	   alert('请输入有效的时间！');
	   eval(formName+"."+hourname+".focus()");
	   return false;
	}
	if ((eval(formName+'.'+minutename+'.value<0')) || (eval(formName+'.'+minutename+'.value>59')) ) {
	   alert('请输入有效的时间！');
	   eval(formName+"."+minutename+".focus()");
	   return false;
	}
	return true;
}
 */
 
/**
 * 2003-7-29 22:14
 * 新增时间校验函数
 */
function checkTime(formName,timename){
   var timevalue=eval("document."+formName+"."+timename+".value");
   var timeArray = timevalue.split(':'); 
	var hours="00";
   var minute="00";
   var second="00";  

   if(timeArray.length == 0 ){
      hours = "00" ;
      minute = "00" ; 
      second = "00" ;
   }else if(timeArray.length == 1 ){
      hours = ( timeArray[0]=="")? "00" : timeArray[0] ; 
      minute = "0" ; 
      second = "0" ;
   }else if(timeArray.length == 2 ){
      hours = ( timeArray[0]=="")? "00" : timeArray[0] ; 
      minute = ( timeArray[1]=="")? "00" : timeArray[1] ; 
      second = "00" ;
   }else if(timeArray.length == 3 ){
      hours = ( timeArray[0]=="")? "00" : timeArray[0] ;
      minute = ( timeArray[1]=="")? "00" : timeArray[1] ; 
      second = ( timeArray[2]=="")? "00" : timeArray[2] ; 
   }   
	if ( hours < 0  || hours >23 ) {
	   return false;
	}
	if ( minute < 0  || minute >59 ) {
	   return false;
	}
	if ( second < 0  || second >59 ) {	  
	   return false;
	}	
	return true;
}

/*
function checkTimeField(formName,fieldName,fieldDesc){
   var timeStr=trim(eval("document."+formName+"."+fieldName+".value"));  
   if(checkInvalid(timeStr)) {
      if(timeStr.split(":")[0]/1>23||timeStr.split(":")[0]/1<0||isNaN(timeStr.split(":")[0])){
         alert(fieldDesc+" 必须是有效的时间！");
         eval(formName+"."+fieldName+".focus()");
         return false;
      }
      if(timeStr.split(":")[1]/1>59||timeStr.split(":")[1]/1<0||isNaN(timeStr.split(":")[1])) {
         alert(fieldDesc+" 必须是有效的时间！");
         eval(formName+"."+fieldName+".focus()");
         return false;
      }
   }
   return true;
}
*/
/**
 * 2003-7-29 22:14
 * 新增时间校验函数
 */
function checkTimeField(formName,timename,fieldDesc){
	var timeStr=trim(eval("document."+formName+"."+timename+".value")); 
   if(!checkTime(formName,timename)||timeStr.indexOf(":",1)==-1 ){
      alert(fieldDesc+" 必须是有效的时间！");
		eval(formName+"."+timename+".focus()");
      return false;
   }
   return true;  
}
/**
 * 2003-7-29 22:14
 * 新增时间校验函数
 */
function comparetimeField(formName,begintimeField,endtimeField,begintimeDesc,endtimeDesc,mode){
   if(!checkTimeField(formName,begintimeField,begintimeDesc)){
      return false;
   }
   if(!checkTimeField(formName,endtimeField,endtimeDesc)){
      return false;
   }
   var begintimevalue=eval("document."+formName+"."+begintimeField+".value");
   var endtimevalue=eval("document."+formName+"."+endtimeField+".value");
   if(!comparetime(formName,begintimevalue,endtimevalue,begintimeDesc,endtimeDesc,mode)){
      return false;
   }
   return true;
}
/**
 * fuctonName: comptime
 * 2003-6-23 05:16下午
 * 新增时间比较函数
 */
function comptime(begintime,endtime,mode){
   var beginhours="00";
   var beginminute="00";
   var beginsecond="00";
   var endhours="00";
   var endminute="00";
   var endsecond="00";
   
   var begintimeArray = begintime.split(':');
   var endtimeArray = endtime.split(':');

// 获取时间的数值
   if(begintimeArray.length == 0 ){
      beginhours = "00" ;
      beginminute = "00" ; 
      beginsecond = "00" ;
   }else if(begintimeArray.length == 1 ){
      beginhours = ( begintimeArray[0]=="")? "00" : begintimeArray[0] ; 
      beginminute = "00" ; 
      beginsecond = "00" ;
   }else if(begintimeArray.length == 2 ){
      beginhours = ( begintimeArray[0]=="")? "00" : begintimeArray[0] ; 
      beginminute = ( begintimeArray[1]=="")? "00" : begintimeArray[1] ; 
      beginsecond = "00" ;
   }else if(begintimeArray.length == 3 ){
      beginhours = ( begintimeArray[0]=="")? "00" : begintimeArray[0] ;
      beginminute = ( begintimeArray[1]=="")? "00" : begintimeArray[1] ; 
      beginsecond = ( begintimeArray[2]=="")? "00" : begintimeArray[2] ; 
   }
   
   if(endtimeArray.length == 0 ){
      endhours = "00" ;
      endminute = "00"; 
      endsecond = "00" ;
   }else if(endtimeArray.length == 1 ){
      endhours = (endtimeArray[0]=="")? "00" : endtimeArray[0] ;
      endminute = "00" ; 
      endsecond = "00" ;
   }else if(endtimeArray.length == 2 ){
      endhours = (endtimeArray[0]=="")? "00" : endtimeArray[0] ;
      endminute = (endtimeArray[1]=="")? "00" : endtimeArray[1] ;
      endsecond = "00" ;
   }else if(endtimeArray.length == 3 ){
      endhours = (endtimeArray[0]=="")? "00" : endtimeArray[0] ;
      endminute = (endtimeArray[1]=="")? "00" : endtimeArray[1] ;
      endsecond = (endtimeArray[2]=="")? "00" : endtimeArray[2] ;
   }
     
// 数据格式化
   beginhours = (beginhours.length == 1 )? "0"+beginhours : beginhours;
   beginminute = (beginminute.length == 1 )? "0"+beginminute : beginminute; 
   beginsecond = (beginsecond.length == 1 )? "0"+beginsecond : beginsecond; 
   endhours = (endhours.length == 1 )? "0"+endhours : endhours;
   endminute = (endminute.length == 1 )? "0"+endminute : endminute;
   endsecond = (endsecond.length == 1 )? "0"+endsecond : endsecond; 
  
   var getbegintime=beginhours+beginminute+beginsecond;
   var getendtime=endhours+endminute+endsecond;
   var retvalue=eval(getbegintime+mode+getendtime);
   return retvalue;
}

/**
 * fuctonName: comptime
 * 2003-6-23 05:16下午
 * 新增时间比较函数
 */
function comparetime(formName,begintimeField,endtimeField,begintimeDesc,endtimeDesc,mode){
	if(!comptime(begintimeField,endtimeField,mode)){
		var modestr='';
	   if(mode=='>=') {
	      modestr="大于等于";
		} else if(mode=='>') { 
		   modestr="大于";
	   } else if(mode=='<') { 
	      modestr="小于";
	   } else if(mode=='<=') { 
	      modestr="小于等于";
	   } else if(mode=='==') { 
	      modestr="等于";
      } else if(mode=='!=') { 
 	      modestr="不等于";
      }	
      alert(begintimeDesc+"必须"+modestr+endtimeDesc); 
		//eval(formName+"."+begintimeField).focus();
	   return false;
		}
	return true;
}


function checkFloatField(formName,fieldName,fieldDesc)
{
	return checkFloatField(formName,fieldName,fieldDesc,null,null)
}

function checkFloatFieldWithMax(formName,fieldName,fieldDesc,maxValue)
{
	return checkFloatField(formName,fieldName,fieldDesc,null,maxValue)
}

function checkFloatFieldWithMin(formName,fieldName,fieldDesc,minValue)
{
	return checkFloatField(formName,fieldName,fieldDesc,minValue,null)
}

function checkFieldWithMin(formName,fieldName,fieldDesc,minValue)
{
	if(eval(formName+"."+fieldName+".value")<minValue)
	{
		alert(fieldDesc+" 必须大于"+minValue);
		eval(formName+"."+fieldName).focus();
		return false;
	}
	return true;
}

function checkFieldWithMax(formName,fieldName,fieldDesc,maxValue)
{
	if(eval(formName+"."+fieldName+".value")>maxValue)
	{
		alert(fieldDesc+" 必须小于"+maxValue);
		eval(formName+"."+fieldName).focus();
		return false;
	}
	return true;
}

function checkFloatField(formName,fieldName,fieldDesc,minValue,maxValue)
{
	if(checkInvalid(trim(eval(formName+"."+fieldName+".value"))))
	{
		if(!(toFloat(trim(eval(formName+"."+fieldName+".value")))))
		{
			alert(fieldDesc+"必须是小数");
			eval(formName+"."+fieldName+".focus()");
			return false;
		}
		if(minValue!=null)
		{
			if(eval(formName+"."+fieldName+".value")<minValue)
			{
				alert(fieldDesc+"必须大于"+minValue+"...");
				eval(formName+"."+fieldName).focus();
				return false;
			}
		}
		if(maxValue!=null)
		{
			if(eval(formName+"."+fieldName+".value")>maxValue)
			{
				alert(fieldDesc+"必须小于"+maxValue+"...");
				eval(formName+"."+fieldName).focus();
				return false;
			}
		}
	}
	return true;
}

function checkIntField(formName,fieldName,fieldDesc)
{
	if(checkInvalid(trim(eval(formName+"."+fieldName+".value"))))
	{
		if(!(toInteger(trim(eval(formName+"."+fieldName+".value")))))
		{
			alert(fieldDesc+" 必须是整数。");
			eval(formName+"."+fieldName+".focus()");
			return false;
		}
	}
	return true;
}

//2003-6-16 03:24下午 新增函数
/*
 * fieldName:     hiddenFieldName
 * fieldTextName: textFieldName 
 */
function checkKeyField(formName,fieldName,fieldTextName,fieldDesc){
   if(!(checkInvalid(eval(formName+"."+fieldName+".value")))){
		alert(fieldDesc+" 不能为空！");
		eval(formName+"."+fieldTextName+".focus()");
		return false;
	}
	if(eval("document."+formName+"."+fieldName+".value")== 0 ){
	   alert(fieldDesc+" 不能为空！");
		eval(formName+"."+fieldTextName+".focus()");
		return false;
	}	
	return true;
}

function checkNullField(formName,fieldName,fieldDesc)
{
  return checkNullField(formName,fieldName,fieldDesc,null);
}

function checkNullField(formName,fieldName,fieldDesc,message)
{
	if(!checkInvalid( eval("document."+formName+"."+fieldName+".value")))
	{
	   if(message==null) {
		  alert(fieldDesc+" 不能为空！");
		}
		else {
		  alert(fieldDesc+" 不能为空,"+message);
		}		
		if(eval(formName+'.'+fieldName+'.type!=\'hidden\''))
		{
		   eval(formName+"."+fieldName+".focus()");
		}
		return false;
	}
	return true;
}

function checkStringLength(formName,fieldName,fieldDesc,strLength,mode) {
   var str='';     
	var theLen=0;
 	var teststr='';  
   if((checkInvalid(eval(formName+"."+fieldName+".value")))) {
  	str= trim(eval(formName+"."+fieldName+".value"));     
	for (i=0;i<str.length;i++)
	{
		teststr=str.charAt(i); 
	   if(str.charCodeAt(i)>255)
	   	theLen=theLen + 2;
	   else
			theLen=theLen + 1;
	}
      if(mode=='==') {
         if(theLen==strLength) return true;
         else {
            alert(fieldDesc+" 的长度必须是"+strLength+"。");
		      eval(formName+"."+fieldName+".focus()");
            return false;
         }   
      } else if(mode=='>=') {
         if(theLen>=strLength) return true;
         else {
            alert(fieldDesc+" 的长度必须不小于"+strLength+"。");
		      eval(formName+"."+fieldName+".focus()");
            return false;
         }   
      } else if(mode=='<=') {
         if(theLen<=strLength) return true;
         else {
            alert(fieldDesc+" 的长度必须不大于"+strLength+"。");
		      eval(formName+"."+fieldName+".focus()");
            return false;
         }   
      }
   }
   return true;
}
      
function checkInvalid(value)
{
   
	if((trim(value).length==0) || (value==null))
	{
		return false;
	}
	return true;
}

function toInteger(checkString)
{
    newString = "";    
    count = 0;        
    for (i = 0; i < checkString.length; i++) {
        ch = checkString.substring(i, i+1);
        if (ch >= "0" && ch <= "9") {
            newString += ch;
        }
    }
    if (checkString != newString) {
    	return false;
    }else
    {
        return true;
	}
}

function toFloat(checkString)
{
    newString = "";    
    count = 0;        
    pCount = 0;
    for (i = 0; i < checkString.length; i++) {
        ch = checkString.substring(i, i+1);
        if ((ch >= "0" && ch <= "9")){
            newString += ch;
        }
        else if(ch=="."&&pCount<1){
        	newString += ch;
        	pCount++;
        }
    }
    if (checkString != newString) {
    	return false;
    }else
    {
        return true;
	}
}

function trim(str)
{
	str = trimLeft(str);
	str = trimRight(str);
	return str;
}

/*
	2003-12-10 09:38
   解决全角空格的问题
*/
function trimLeft(str){
	while(str.indexOf(" ")==0){
		str = str.substr(1,str.length);
	}
   while(str.indexOf("　")> -1 ){
	   str = str.substr(2,str.length);
	}
	return str;
}

function trimRight(str){
	if(str=="")
		return str;
	while(str.lastIndexOf(" ")==(str.length-1)){
		str = str.substr(0,str.length-1);
	}
	while(str.lastIndexOf("　") > -1){		   
		str = str.substr(0,str.length-2);
	}
	return str;
}

function isDate(year,month,day)
{
     	if(month<=0 || month>=13)
     		return false;
   	if( month==2 && ((year/4)==parseInt(year/4)) )
      	{ if(day<=0 || day>29) return false; }
   	if( month==2 && ((year/4)!=parseInt(year/4)) )
      	{ if(day<=0 || day>28) return false; }
   	if( month==4 || month==6 || month==9 || month==11 )
      	{ if(day<=0 || day>30) return false; }
   	if( month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12 )
      	{ if(day<=0 || day>31) return false; }
	return true;

}

function verifyDate(dateString)
{
   var str = dateString;
   var dateArray = dateString.split('-');
   var format=0;
   var month=0;
   var day=0;
   var year=0;
   var err=false;

   if(str.length<8  || str.length>10)
   {
      err=true;
      return false;
   }
   else
   {
   	for(var j = 0; j< str.length; ++j)
   	{
   		var ch = str.substring(j, j + 1);
   		if ( (ch < "0" || "9" < ch) && (ch != "-") )
   		{
   			err=true;
   			break;
   		}
   	}
   	if(err==true)
   	{
   		return false;
   	}
   	if (dateArray.length!=3)
      {
   		return false;
   	}
   	month = dateArray[1];
	   day = dateArray[2];
   	year = dateArray[0];
    if (!isDate(year,month,day))
    {
   		return false;
   	}
    return true;
   }
}

function compdate(begindate,enddate,mode)
{
	var beginmonth=0;
   var beginday=0;
   var beginyear=0;
   var endmonth=0;
   var endday=0;
   var endyear=0;
   var retvalue=false;

   var begindateArray = begindate.split('-');
   var enddateArray = enddate.split('-');

   beginday = begindateArray[2];
   beginmonth = begindateArray[1];
   beginyear = begindateArray[0];
   endday = enddateArray[2];
   endmonth = enddateArray[1];
   endyear = enddateArray[0];

   if(beginmonth.length==1)
   	beginmonth="0"+beginmonth;
   if(beginday.length==1)
   	beginday="0"+beginday;
   if(endmonth.length==1)
   	endmonth="0"+endmonth;
   if(endday.length==1)
   	endday="0"+endday;

   var getbegindate=beginyear+beginmonth+beginday;
   var getenddate=endyear+endmonth+endday;
   var retvalue=eval(getbegindate+mode+getenddate);
   return retvalue;   
}

function checkSelection(formName,checkMode) {
   var returnvalue = true;
	var eleCount=eval("document."+formName+".elements.length");
	var i=0;
	var k=0;
	while(i<eleCount) {
		if(eval("document."+formName+".elements[i].type")=="checkbox"){
			if(eval("document."+formName+".elements[i].checked")==true){
				++k;	
				}
					
		}
		++i;
	}
	if(k==0) returnvalue = false;
	else if((k>1)&&(checkMode=='single')) returnvalue = false;
   return       returnvalue;
}   


function dosubmit(actionTypeValue,actionValue,targetValue,checkMode,hintValue,formName) {
   if(checkMode!=null) {
      if(checkSelection(formName,checkMode)==false) {
         if(checkMode=='checked')
            alert("至少选择一个"+hintValue);
         else if(checkMode=='single')   
            alert("只能选择一个"+hintValue);
         return false;
      }
   }         
   document.list.actionType.value = actionTypeValue;
	document.list.action=actionValue;
   document.list.target = targetValue;
	document.list.submit();
}


function common_dosubmit(actionTypeValue,actionValue,targetValue,formName) {
   eval('document.'+formName+'.actionType.value = \"'+actionTypeValue+'\"');
	eval('document.'+formName+'.action=\"'+actionValue+'\"');
   eval('document.'+formName+'.target = \"'+targetValue+'\"');
	eval('document.'+formName+'.submit()');
}

function checkFormFloatNullInput(formName,fieldDesc) {
	var eleCount=eval("document."+formName+".elements.length");
	var i=0;
	while(i<eleCount) {
		if(eval("document."+formName+".elements[i].type")=="text")
		{
		   if (!checkNullField(formName,eval(formName+'.elements[i].name'),fieldDesc)) {
		      return false;
		      break;
		   }
			if (!checkFloatField(formName,eval(formName+'.elements[i].name'),fieldDesc)) {
				return false;
				break;
			}	
		}
		++i;
	}
   return true;
}      

function checkFormFloatInput(formName,fieldDesc) {
   var returnvalue = true;
	var eleCount=eval("document."+formName+".elements.length");
	var i=0;
	while(i<eleCount) {
		if(eval("document."+formName+".elements[i].type")=="text")
		{
			if (checkFloatField(formName,eval(formName+'.elements[i].name'),fieldDesc)==false) {
				returnvalue = false;
				break;
			}	
		}
		++i;
	}
   return   returnvalue;
}      

function checkFormIntInput(frmName,fieldDesc) {
   var returnvalue = true;
	var eleCount=eval("document."+formName+".elements.length");
	var i=0;
	while(i<eleCount) {
		if(eval("document."+formName+".elements[i].type")=="text")
		{
			if (checkIntField(formName,eval(formName+'.elements[i].name'),fieldDesc)==false) {
				returnvalue = false;
				break;
			}	
		}
		++i;
	}
   return   returnvalue;
}      

function checkFormDateInput(formName,fieldDesc) {
   var returnvalue = true;
	var eleCount=eval("document."+formName+".elements.length");
	var i=0;
	while(i<eleCount) {
		if(eval("document."+formName+".elements[i].type")=="text")
		{
			if (Checkdatefield(formName,eval(formName+'.elements[i].name'),fieldDesc)==false) {
				returnvalue = false;
				break;
			}	
		}
		++i;
	}
   return   returnvalue;
}      

/*
 @date:2004-5-15 17:32
 @author:shenqin
 @function: 获取对象属性
*/
function getFieldKeyValue(formName,fieldName,keyValue) {
   var keyValueStr='';   
   keyValueStr=eval("document."+formName+"."+fieldName+"."+keyValue);
   return  keyValueStr;	
}
 
function checkSelectField(formName,fieldName,fieldDesc){
	if(eval("document."+formName+"."+fieldName+".selectedIndex")==-1){
		alert("请选择"+fieldDesc+"!");
		eval("document."+formName+"."+fieldName+".focus()");
		return false;
	}else{
		return true;
	}
}

/*
date:2004-2-28 16:17
author:zxcshenqin@163.com
*/
function isSelectField(formName,fieldName,optionsValue){
   var optionLength = eval(formName+"."+fieldName+".options.length");
   for(var i=0; i < optionLength ; i++){  
		if((eval(formName+"."+fieldName).options[i].selected ) ){
		   if(eval(formName+"."+fieldName).options[i].value == optionsValue){
		      return true;		     
		   }
	  	}
	}
	return false;	
}



function compnent_onkeydown(formName,index) {
	if ((event.keyCode==13)) 
	{
		++index;
		while((index<compnent_list.length)&&( eval("document."+formName+"."+compnent_list[index]+".disabled")==true ))
		{	
			++index;
			
		}
		if(index<compnent_list.length)
			eval("document."+formName+"."+compnent_list[index]+".focus()");
	}
}

function compnent_onkeydownex(formName,index) {
	event.cancelBubble = true;
	srcElement = index;
	if ((event.keyCode==13)) 
	{
		++index;
		while((index<compnent_list.length)&&( eval("document."+formName+"."+compnent_list[index]+".disabled")==true ))
		{	
			++index;
			
		}
		if(index<compnent_list.length)
			eval("document."+formName+"."+compnent_list[index]+".focus()");
	}
}

function compnent_onkeyup(formName, index) {
	if(srcElement!=tagElement) {
	   if ((event.keyCode==13)) {
   	   ++index;
	      if(index<compnent_list.length)
		      eval("document."+formName+"."+compnent_list[index]+".focus()");
	   }
	}
	srcElement = -1;
}

/**2003-11-10 06:58下午**/
function firstFocus(formName,fieldName) { 
   newCommonList(formName); 
   eval("document."+formName+"."+fieldName+".focus()");    
}
/** 2003-6-21 03:32下午 */
//创建表单元素的数组
var common_list = new Array;
function newCommonList(formName) {  
   var eleCount=eval("document."+formName+".elements.length");
	var i=0;
	var j=0;
	for(i=0;i<eleCount;i++) {
	   if(eval("document."+formName+".elements[i].type")=="text" || eval("document."+formName+".elements[i].type")=="select-one" || eval("document."+formName+".elements[i].type")=="checkbox" ){ 
		   common_list[j]=eval("document."+formName+".elements[i].name");
		   j++;
		}
   }//endfor 
   return true;
}
/**2003-6-21 05:08下午*/
/**
 * 下一不存在控件不存在时，返回假；
 * 否则，返回真。
*/

function common_onkeydown(formName,obj) {
   var listLength=common_list.length;
   var j=0;  
   var i= 0; 
   var tag = -1;
   for (;i<listLength;i++){
      if(tag==-1) {
         if( common_list[i]==obj.name ){
            tag = i;
         } 
      } else {
         if( eval("document."+formName+"."+common_list[i]+".disabled")==false ) {
            break;
         }
      }
   } 
   if(tag==-1) {//当前不存在
      return true;
   } else {
      if(i==listLength) {//下一不存在
         return false;//提交
      } else {
         if ((event.keyCode==13)) {
            eval("document."+formName+"."+common_list[i]+".focus()");
            return true;
         } else {
            return true;
         }
      }
   }
}


function common_dosubmit(actionTypeValue,actionValue,targetValue,formName) {
   eval('document.'+formName+'.actionType.value = \"'+actionTypeValue+'\"');
	eval('document.'+formName+'.action=\"'+actionValue+'\"');
   eval('document.'+formName+'.target = \"'+targetValue+'\"');
	eval('document.'+formName+'.submit()');
}

function isEmail(formName,fieldName) 
{ 	
 	var email=trim(eval("document."+formName+"."+fieldName+".value") ); 
 	invalidChars = " /;,:{}[]|*%$#!()`<>?"; 
if (email == "") 
   { 
  		return false; 
   } 
for (i=0; i< invalidChars.length; i++) 
    { 
  badChar = invalidChars.charAt(i) 
  if (email.indexOf(badChar,0) > -1) 
         { 
   return false; 
         } 
    } 
atPos = email.indexOf("@",1) 
if (atPos == -1) 
    { 
  return false; 
    } 
if (email.indexOf("@", atPos+1) != -1) 
 { 
  return false; 
 } 
 periodPos = email.indexOf(".",atPos) 
if(periodPos == -1) 
     { 
  return false; 
     } 
if ( atPos +2 > periodPos) 
 { 
  return false; 
 } 
 if ( periodPos +3 > email.length) 
 { 
  return false; 
 } 
 return true; 
} 

function istel(formName,fieldName){ 
  return istel(formName,fieldName,null); 
} 

/*
 @date:2004-6-2 10:28
 @author:shenqin
 @function: 重载函数，增加参数
*/
function istel(formName,fieldName,desc){ 
   var tel=eval("document."+formName+"."+fieldName+".value");  
   var validchars = "-()1234567890 ";    
   for (i=0;i<tel.length;i++){ 
      telchar=tel.charAt(i); 
      if (validchars.indexOf(telchar, 0) == -1){
         if(desc==null){
	         alert("您所输入的电话号码无效，请重新输入正确的信息！");	
	      }else{
	         alert("您所输入的"+desc+"无效，请重新输入正确的信息！");	
	      }
	      eval("document."+formName+"."+fieldName+".focus()");
	      return false;
	   } 
   } 
   return true; 
} 

function isMovetelNumber(formName,fieldName)
{
	var movetelNumber=eval("this.document."+formName+"."+fieldName+".value");
	if((movetelNumber.length!=11)||(movetelNumber.substring(0,2)!="13")||(isNaN(movetelNumber)) )
	{
   	alert("您所输入的号码无效！请重新输入正确的信息！");
     	eval("document."+formName+"."+fieldName+".focus()");
   	return false;
	}
}

function checkNullFieldEmpty(formName,fieldName)
{
	if(!(checkInvalid(eval(formName+"."+fieldName+".value"))))
	{
		return false;
	}
	return true;
}


function idChecked(formName,fieldName,fieldDesc)
{
   //alert(formName+"===="+fieldName+"===="+fieldDesc);
   if(checkNullFieldEmpty(formName,fieldName))
   {
   var W= new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1); 
  	var A= new Array('1','0','X','9','8','7','6','5','4','3','2');
	var i, j, s=0; 
	var checkID,birthday;
	var ss=eval(formName+"."+fieldName+".value");
	var newss=ss;
 	if(ss.length==15)
  	  {
  		 birthday='19'+ss.substring(6,8)+'-'+ss.substring(8,10)+'-'+ss.substring(10,12);
  		if(!(verifyDate(birthday)))  			
  			{
  			var conf = window.confirm("身份证号码中的出生年月错误，点击【确认】修改，点击【取消】继续操作");
  			if(conf==true){
				eval("document."+formName+"."+fieldName+".focus()");
				return false;
			}else{
				return false;
			}
  			return false;
  			}
  		}  		
      		else if(ss.length==18)
       		{
       			birthday=ss.substring(6,10)+'-'+ss.substring(10,12)+'-'+ss.substring(12,14);
       			newss =ss.substring(0, 17);       			
       			if(verifyDate(birthday))
       		   { 
       			   for(i=0;i<17;i++)
       				{
       				j=parseInt(ss.substring(i,(i+1)))*W[i];
       				s=s+j; 
       				}//end for
       				s=s%11;
       				checkID=newss+A[s];
       			   if(ss.toUpperCase()!=checkID)       				
  			      {
  			        var conf = window.confirm("您输入的身份证号码错误，点击【确认】修改，点击【取消】继续操作");
		  			if(conf==true){
						eval("document."+formName+"."+fieldName+".focus()");
						return false;
					}else{
						return false;
					}
  			        return false;
  			      }       	
       		        }
       		        else
  			 {
  			 	var conf = window.confirm("输入"+fieldDesc+"的身份证号码中的出生年月错误，点击【确认】修改，点击【取消】继续操作");
				if(conf==true){
					eval("document."+formName+"."+fieldName+".focus()");
					return false;
				}else{
					return false;
				}
  			    return false;
  			 }
       	      
		}  	
  	else        
  	{
  		var conf = window.confirm("您输入的身份证号码错误，点击【确认】修改，点击【取消】继续操作");
		if(conf==true){
		eval("document."+formName+"."+fieldName+".focus()");
			return false;
		}else{
			return false;
		}
  		return false;
  	}      
    }
    else { 
    alert("请输入"+fieldDesc+"的身份证号码！");
    eval("document."+formName+"."+fieldName+".focus()");
    return false;   }
    return true;
}

function synchronizeChecked(formName,idName,genderName) {
	return synchronizeChecked(formName,idName,null,genderName);
}

function synchronizeChecked(formName,idName,birthdayName,genderName) {
	var birthdayValue="";
	var genderFlag=0;
	var idString=trim(eval(formName+"."+idName+".value"));
	if(!checkNullFieldEmpty(formName,idName))
		return false;			
	if(!idChecked(formName,idName))
	{
		eval("document."+formName+"."+idName+".focus()");
      return false;
   }
	if(birthdayName!=null )
	{	
		if(!checkDateField(formName,birthdayName,'出生日期'))	{
			eval("document."+formName+"."+birthdayName+".focus()");
			return false;
		}
	}
	if(idString.length==15)	{
  		birthdayValue='19'+idString.substring(6,8)+'-'+idString.substring(8,10)+'-'+idString.substring(10,12);
  		genderFlag=(idString.substring(14,15))%2;  		
	}  
  	else if(idString.length==18)  {
    	birthdayValue=idString.substring(6,10)+'-'+idString.substring(10,12)+'-'+idString.substring(12,14);
    	genderFlag=(idString.substring(16,17))%2;
	}
	if(genderName!= null ) {
		if(genderFlag==1) {
			if(eval("document."+formName+"."+genderName+".selectedIndex")!=1)	{
				
				alert("您输入的性别与身份证中的信息不一致！请重新输入！");
				eval("document."+formName+"."+idName+".focus()");
				return false;
			}
		}
		if(genderFlag==0)	{
			if(eval("document."+formName+"."+genderName+".selectedIndex")!=2)	{
				alert("您输入的性别与身份证中的信息不一致！请重新输入！");
				eval("document."+formName+"."+idName+".focus()");
				return false;
			}
		}
	}
	if(birthdayName!=null){
		if(trim(eval(formName+"."+birthdayName+".value") )!='')
		{
			if(birthdayValue!=(trim(eval(formName+"."+birthdayName+".value") ) ) ){
				alert("您输入的出生日期与身份证中的信息不一致！请重新输入！");
				eval("document."+formName+"."+idName+".focus()");
				return false;
			}
		} else {
			return eval("document."+formName+"."+birthdayName+".value=birthdayValue");			
		}
	}
	return true;
}


function numformat(formName,fieldName){ 	
	if(checkFloatField(formName,fieldName,'工资项',0,99999))	{
   	eval("document."+formName+"."+fieldName.substring(0,fieldName.length-5)+".value=document."+formName+"."+fieldName+".value");
   	var temp=formatCurrency(formName,fieldName);
		eval("document."+formName+"."+fieldName+".value=temp");	
   }	  
}
function formatCurrency(formName,fieldName){
	var symbol="";	
	num = trim(eval(formName+"."+fieldName+".value"));
	if(num < 0){
		symbol = "-";
		num = Math.abs(num);
	}
	num = num.toString().replace(/￥|\,/g,'');
	cents = Math.floor((num*100+0.5)%100); 
	num = Math.floor(num).toString();
	if(cents < 10)
		cents = "0" + cents; 
	for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++) 
		num = num.substring(0,num.length-(4*i+3))+','+num.substring(num.length-(4*i+3)); 
	return ('￥'+ symbol + num + '.' + cents); 
}
 
function formatCurrencyValue(num) {
	var symbol="";
	if(num < 0){
		symbol = "-";
		num = Math.abs(num);
	}	
	num = num.toString().replace(/￥|\,/g,'');	
	cents = Math.floor((num*100+0.5)%100); 	
	num = Math.floor(num).toString();
	if(cents < 10)
		cents = "0" + cents; 
	for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++) 
		num = num.substring(0,num.length-(4*i+3))+','+num.substring(num.length-(4*i+3)); 
	return ('￥'+ symbol + num + '.' + cents ); 
}
 
function recover(formName,fieldName){	
	eval("document."+formName+"."+fieldName+".value=document."+formName+"."+fieldName.substring(0,fieldName.length-5)+".value");
	eval("document."+formName+"."+fieldName.substring(0,fieldName.length-5)+".value=document."+formName+"."+fieldName+".value");
}

function checkTextarea(formName,fieldName,maxlength,fieldDesc){
	var str = eval("document."+formName+"."+fieldName+".value");
	var theLen=0;
 	var teststr='';
	for (i=0;i<str.length;i++){
		teststr=str.charAt(i); 
	   if(str.charCodeAt(i)>255)
	   	theLen=theLen + 2;
	   else
			theLen=theLen + 1;
	}	
 	if (theLen>(maxlength*2)){   	
	  alert(fieldDesc+'的内容不能超过'+maxlength+"字！"); 
	  eval("document."+formName+"."+fieldName+".focus()");    
     return false;
   }else{
	   return  true;
   }
}

function ipcheck(formName,fieldName){	
	var ipAddress=trim(eval(formName+"."+fieldName+".value"));
	if(!checkIPAddress (ipAddress))
	{
		alert('您输入的IP地址无效，请重新输入有效的IP地址！');
		eval("document."+formName+"."+fieldName+".focus()");    
		return false;
	}	else return true;
}

function checkIPAddress (ipAddressString) 
	{
 		var reSpaceCheck = /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/;
 		var passedTest = false;
   
   	if (reSpaceCheck.test(ipAddressString)) 
   	{
  			ipAddressString.match(reSpaceCheck);
			if (RegExp.$1 <= 255 && RegExp.$1 >= 0 
	   	&& RegExp.$2 <= 255 && RegExp.$2 >= 0 
			&& RegExp.$3 <= 255 && RegExp.$3 >= 0 
			&& RegExp.$4 <= 255 && RegExp.$4 >= 0)
			{
				passedTest = true;
			}
		}
  
	  	if (!passedTest) 
  		{  			
 			return false;
  		}
   
 		return true;
	}
	

function checkValidchar(formName,fieldName,fieldDesc,validchars ) 
{ 		var validString="";
 		if(checkInvalid(eval("document."+formName+"."+fieldName+".value")))
 		 validString=eval("document."+formName+"."+fieldName+".value");
 		for (i=0;i<validString.length;++i)
 		{
 			abcchar=validString.charAt(i);   	
  		  	if(validchars.indexOf(abcchar) == -1)
  			{			
  		 		alert(fieldDesc+"的字符无效，请重新输入正确的信息！");	
	 			eval("document."+formName+"."+fieldName+".focus()");
	 			return false;
	 		}
		}
 	return true; 
} 
	
function checkValidcharFirst(formName,fieldName,fieldDesc,firstChar,firstCharDesc,validchars) 
{ 
 	var abc=trim(eval("document."+formName+"."+fieldName+".value")); 
 	for (i=0;i<abc.length;++i) 
 	{ 
 		abcchar=abc.charAt(i);   		
  		if(i==0)
  		{
  			if(firstChar.indexOf(abcchar) == -1)
  			{
  				alert(fieldDesc+"的首字符必须为"+firstCharDesc+"，请重新输入正确的信息！");	
	 			eval("document."+formName+"."+fieldName+".focus()");
	 			return false;
  			}
  	  	}
  	  	else
  	  	{
 			if(validchars.indexOf(abcchar) == -1)
 			{			
 	 			alert(fieldDesc+"的字符无效，请重新输入正确的信息！");	
 				eval("document."+formName+"."+fieldName+".focus()");
 				return false;
 			}
 		}	 
	}
 	return true; 
} 

function selectChecked(formName,fieldName,fieldDesc)
{  
	var i=0;
	var k=0;
	checkMode=eval(formName+"."+fieldName+".type");
	var optionLength = eval(formName+"."+fieldName+".options.length");
	for(var i=0; i < optionLength ; i++)
	{  
		if((eval(formName+"."+fieldName).options[i].selected ) )
	  	{
	  		++k;
	  	}
	}
	if(k==0)
	{
		alert(fieldDesc+"至少要选择一项！" );
		return false;
	}
	else if((k>1)&&(checkMode=="select-one" ) )
	{
		alert(fieldDesc+"只能选择一项！" );
		return false;	
	}
	return true;		
}

function fieldReset(formName,inValidchars) 

{
	var eleCount=eval("document."+formName+".elements.length");
	for(i=0;i<eleCount;i++) 
	{
		var charAt=eval("document."+formName+".elements["+i+"].name");
		if(eval("document."+formName+".elements["+i+"].type")=="text")
		{
			eval("document."+formName+".elements["+i+"].value=''"); 			
		}
		if((inValidchars.indexOf(charAt)== -1)&&(eval("document."+formName+".elements["+i+"].type")=="hidden"))
		{
			eval("document."+formName+".elements["+i+"].value=''"); 			
		}
		if(eval("document."+formName+".elements["+i+"].type")=='select-one')
		{
			eval("document."+formName+".elements["+i+"].selectedIndex=0" ); 
		}
	}	
}

function checkAllChange(formName,checkName,selectName) 
{
   var eleCount=eval("document."+formName+".elements.length");
   var index=eval("document."+formName+"."+selectName+".selectedIndex")
   if(!eval("document."+formName+"."+checkName+".checked"))
	{
		if(!confirm("真的要全部处理吗？"))
   	{
   		return false;
   	}
		eval("document."+formName+"."+checkName+".checked=true");
	}
	for(var i=0; i < eleCount; i++ )
	{  
		if((eval("document."+formName+".elements["+i+"].type") == "select-one" )&&(eval("document."+formName+".elements["+i+"].name")!= selectName))
		{
			var fieldName=eval("document."+formName+".elements["+i+"].name");
			eval("document."+formName+"."+fieldName+".selectedIndex="+index);
		}
	}
}

function selectAllChange(formName,checkName,selectName,selectedName,selecteLength){
   var index=eval("document."+formName+"."+selectName+".selectedIndex")
   if(!eval("document."+formName+"."+checkName+".checked"))	{
		if(!confirm("真的要全部处理吗？"))	{
   		return false;
   	}
		eval("document."+formName+"."+checkName+".checked=true");
	}
	for(var i=0; i <= selecteLength; i++ )	{  
		var fieldName=eval("document."+formName+"."+selectedName+i+".name");
		eval("document."+formName+"."+fieldName+".selectedIndex="+index);
	}
}


function buttonOnce(formName,fieldName)
{  
	 eval('document.'+formName+'.'+fieldName+'.disabled=true;');
	 return true;
}

function buttonReset(formName,fieldName)
{  
	 eval('document.'+formName+'.'+fieldName+'.disabled=false;');
	 return true;
}

function checkedBoxChange(formName,id){
	var eleCount=eval("document."+formName+".elements.length");
	for(var i=0;i<eleCount;i++){
		if(eval("document."+formName+".elements["+i+"].type")=='checkbox'){
			checkedBoxChangeReset(formName);
			if(eval("document."+formName+".elements["+i+"].value")== id){			
				if(eval("document."+formName+".elements["+i+"].checked")==false){
					eval("document."+formName+".elements["+i+"].checked = true");
					break;
				}
			}
		}
	}
}	
function checkedBoxChangeEx(formName,fieldname,id){
	var eleCount=eval("document."+formName+".elements.length");
	for(var i=0;i<eleCount;i++){
		if(eval("document."+formName+".elements["+i+"].type")=='checkbox' && eval("document."+formName+".elements["+i+"].name")==fieldname ){
			checkedBoxChangeResetEx(formName,fieldname);
			if(eval("document."+formName+".elements["+i+"].value")== id){			
				if(eval("document."+formName+".elements["+i+"].checked")==false){
					eval("document."+formName+".elements["+i+"].checked = true");
					break;
				}
			}
		}
	}
}	

function checkedBoxChangeReset(formName){
	var eleCount=eval("document."+formName+".elements.length");
	for(var i=0;i<eleCount;i++){
		if(eval("document."+formName+".elements["+i+"].type")=='checkbox'){
			if(eval("document."+formName+".elements["+i+"].checked")== true ){
				eval("document."+formName+".elements["+i+"].checked = false");
			}
		}
	}
}

function checkedBoxChangeResetEx(formName,fieldname){
	var eleCount=eval("document."+formName+".elements.length");
	for(var i=0;i<eleCount;i++){
		if(eval("document."+formName+".elements["+i+"].type")=='checkbox' && eval("document."+formName+".elements["+i+"].name")==fieldname ){
			if(eval("document."+formName+".elements["+i+"].checked")== true ){
				eval("document."+formName+".elements["+i+"].checked = false");
			}
		}
	}
}

	


function radioAllChange(formName,id)
{

	if(!eval("document."+formName+".payTypeCheck.checked"))
	{
		if(!confirm("真的要全部处理吗？"))
   	{
   		return false;
   	}
		eval("document."+formName+".payTypeCheck.checked=true");		
	}
	radioChange(formName,id);
}

function radioChange(formName,id){
	var eleCount=eval("document."+formName+".elements.length");
	for(var i=0;i<eleCount;i++){
		if((eval("document."+formName+".elements["+i+"].type")=='radio')&&(eval("document."+formName+".elements["+i+"].disabled")== false )){
			if(eval("document."+formName+".elements["+i+"].value") == id){	
				eval("document."+formName+".elements["+i+"].checked  = true ");
			}else {
				eval("document."+formName+".elements["+i+"].checked  = false ");
			}
		}
	}
}

function radioChangeReset(formName){
	var eleCount=eval("document."+formName+".elements.length");
	for(var i=0;i<eleCount;i++){
		if((eval("document."+formName+".elements["+i+"].type")=='radio')&&(eval("document."+formName+".elements["+i+"].disabled")== false )){
			if(eval("document."+formName+".elements["+i+"].value") == 0){
				eval("document."+formName+".elements["+i+"].checked  = true");
			}else{
				eval("document."+formName+".elements["+i+"].checked  = false");
			}
		}
	}
}	

/* 2003-12-22 09:55 新增随动函数，解决部门和岗位的关联关系 */
function keyFiledChange(formName,changeFieldKey,changeFieldName){
	eval(formName+"."+changeFieldKey).value="";
	eval(formName+"."+changeFieldName).value="";
}

function keyFiledChangeEx(formName,idName,changeFieldKey,changeFieldName){
	eval(idName).innerText="";	
	eval(formName+"."+changeFieldKey).value="";
	eval(formName+"."+changeFieldName).value="";
}

//2003-5-19 09:46上午
//获取IE的版本号
var IEVer = window.navigator.appVersion;
IEVer = IEVer.substr( IEVer.indexOf('MSIE') + 5, 3 );
var oPopup = (IEVer >= 6.0 )?window.createPopup():null;
function richToolTip(id)
{
  return richToolTip(id,null,null,null,null,true);
}
function richToolTip(id,height)
{
  return richToolTip(id,height,null,null,null,true);
}
function richToolTip(id,height,width)
{
  return richToolTip(id,height,width,null,null,true);
}
function richToolTip(id,height,width,leftpx,toppx,flag)
{
    if(flag==false)
    {
      return false;
    }   
    if(width==null)
      width=180;
    if(height==null)
      height=150; 
    if(leftpx==null)
      leftpx=200; 
    if(toppx==null)
      toppx=150;         
    var lefter = event.offsetY+leftpx;
    var topper = event.offsetX+toppx;
    if(IEVer >= 6.0)
    {
    	oPopup.document.body.innerHTML = eval("show_"+id+".innerHTML"); 
    	oPopup.show(topper, lefter, width, height, id );
    }
    else
    {
    	return false;
    }
}

function hidenRichToolTip()
{
   if(IEVer >= 6.0 ) {
      oPopup.hide();
   } else {
      return false;
   }
}

function richToolTipShowUp(id) {
	richToolTip(id,140,160,-10,140,true );
}

function richToolTipShow(id) {
	richToolTip(id,150,160,200,0,true );
}
//2003-6-15 22:00 新增函数 
/*
 *formName               
 *fieldName       textField
 *fieldTextName   HiddenField
 *fieldDesc       textDesc
 *fieldToName     SelectName
 */
/**
 * mod:2003-6-16 21:30
*/
function addTextSelect(formName,fieldName,fieldTextName,fieldDesc,fieldToName ){
   if(!checkKeyField(formName,fieldName,fieldTextName,fieldDesc)){
      return false;
   }      
   var selectLength=eval("document."+formName+"."+fieldToName+".length");
   for( var j=0;j < selectLength ;j++){
      if(eval("document."+formName+"."+fieldToName).options[j].value == eval("document."+formName+"."+fieldTextName+".value")){
         alert(fieldDesc+"已经在列表中，请重新选择！");
         return false;
      }
   }
   eval("document."+formName+"."+fieldToName).options[selectLength] = new Option(eval("document."+formName+"."+fieldName+".value"), eval("document."+formName+"."+fieldTextName+".value"),0,0);
   eval("document."+formName+"."+fieldTextName+".value=''");
   eval("document."+formName+"."+fieldName+".value=''");
   return true;
}

/*2003-5-12 01:01下午*/
//以下代码用于报表项目设置
function selectChange(control, controlToPopulate, ItemKeyArray, ItemValueArray, GroupArray) {
  var myEle ;
  var x ;
  for (var q=controlToPopulate.options.length;q>=0;q--) 
  		controlToPopulate.options[q]=null;
  for ( x = 0 ; x < ItemKeyArray.length  ; x++ ) 
  {
     if ( GroupArray[x] == control.value ) 
     {
        myEle = document.createElement("option") ;
        myEle.value = ItemKeyArray[x] ;
        myEle.text = ItemValueArray[x] ;
        controlToPopulate.add(myEle) ;
     }
  } 
}
function selectAllItem(formName,fieldName){
	for (var y=0;y<eval("document."+formName+"."+fieldName+".length");y++)	{
      eval("document."+formName+"."+fieldName+".options["+y+"]").selected = true;            
   }      
}

/* function : 2003-12-19 10:26上午 */
function selectAllItemValue(formName,fieldName){
	var strItem = "";	
	for (var y=0;y<eval("document."+formName+"."+fieldName+".length");y++)	{
      eval("document."+formName+"."+fieldName+".options["+y+"]").selected = true;
      strItem = strItem + "&"+fieldName+"="+ eval("document."+formName+"."+fieldName+".options["+y+"].value");             
   } 
   return strItem;    
}

/*
 @date:2004-5-12 8:56
 @author:shenqin
 @vision:v3.3.2 
 @function: 返回链接所需要的url字符串  
*/

function checkboxAllItemValue(formName,fieldName){
	var strItem = "";	
	var eleCount=eval("document."+formName+".elements.length");
	for(var i=0;i<eleCount;i++){
	   if( ( (eval("document."+formName+".elements["+i+"].type"))=='checkbox')&&(eval("document."+formName+".elements["+i+"].name"))== fieldName ){
			if(eval("document."+formName+".elements["+i+"].checked") == true ){
				strItem = strItem + "&"+fieldName+"="+ eval("document."+formName+".elements["+i+"].value");  
			}
		} 
   } 
   return strItem;    
}

function GetObjID(formName,fieldName){ 
	for ( var ObjID=0; ObjID < eval("window."+formName).elements.length; ObjID++ )
      if (eval("window."+formName).elements[ObjID].name == fieldName ){  
      	return(ObjID);
         break;
      }
  return(-1);
}

//2004-2-13 15:58
//新增函数，获取checkbox当前选中值
function GetCheckBoxValue(formName,fieldName){
	var checkBoxValue = "";	
	var eleCount=eval("document."+formName+".elements.length");
	for(var i=0;i<eleCount;i++){
		if( ( (eval("document."+formName+".elements["+i+"].type"))=='checkbox')&&(eval("document."+formName+".elements["+i+"].name"))== fieldName ){
			if(eval("document."+formName+".elements["+i+"].checked") == true ){
				return eval("document."+formName+".elements["+i+"].value"); 
			}
		}
	}
   return checkBoxValue;    
}

/*
date:2004-2-16 10:37
fun: test formName,fieldName is checked
*/
function IsCheckBoxChecked(formName,fieldName){
	var eleCount=eval("document."+formName+".elements.length");
	for(var i=0;i<eleCount;i++){
		if( ( (eval("document."+formName+".elements["+i+"].type"))=='checkbox')&&(eval("document."+formName+".elements["+i+"].name"))== fieldName ){
			if(eval("document."+formName+".elements["+i+"].checked") == true ){
				return true; 
			}						
		}
	}
   return false;    
}


function InsertItem(formName,ObjID, Location){ 
	len=eval("document."+formName).elements[ObjID].length;
  	for (counter=len; counter>Location; counter--) {  
  		Value = eval("document."+formName).elements[ObjID].options[counter-1].value;
      Text2Insert  = eval("document."+formName).elements[ObjID].options[counter-1].text;
      eval("document."+formName).elements[ObjID].options[counter] = new Option(Text2Insert, Value);
  	}
}

function GetLocation(formName,ObjID, Value){ 
	total=eval("document."+formName).elements[ObjID].length;
  	for (pp=0; pp<total; pp++)
      if (eval("document."+formName).elements[ObjID].options[pp].text == "---"+Value+"---"){  
      	return (pp);
         break;
      }
  	return (-1);
}


function overalert(formName,ID){ 
	var over  = 0;
  	thelength = eval("document."+formName).elements[ID].length;
  	for (m=0; m<thelength; m++) {  
  		thevalue = eval("document."+formName).elements[DesObjID].options[m].value;
      thevalue = thevalue.substring(2);
      if (thevalue!="00")
         over=over+1;
  }
  return(over);
}

function HasTotal(formName,ID){ 
	if(ID != -1 ){  
		for (var cc=0; cc<eval("document."+formName).elements[ID].length; cc++ ) {
			if (eval("document."+formName).elements[ID].options[cc].selected ) {
				if (eval("document."+formName).elements[ID].options[cc].value == "0000"){  
            	return true;
            }
         }
     }
     return false;
  }
  return false;
}


function IsSelected(formName,ID, Value){
 	if (ID != -1 && Value != ""){  
 		for (var cc=0; cc<eval("document."+formName).elements[ID].length; cc++ ){ 
 			if (eval("document."+formName).elements[ID].options[cc].value == Value)
            return true;
     	}
     	return false;
  	}
  	return false;
}

function AppendItem(formName,ObjName, DesName){ 
	ObjID    = GetObjID(formName,ObjName);
  	DesObjID = GetObjID(formName,DesName);
  	if (ObjID != -1 && DesObjID != -1){  
  		if ( IsSelected(formName,DesObjID, "0000") )
  		    ;
     else{  
     	if ( HasTotal(formName,ObjID) )
        {  eval("document."+formName).elements[DesObjID].length = 0;
           eval("document."+formName).elements[DesObjID].options[0]= new Option("---不限---", "0000");

        }
        else
        { // if (eval("document."+formName).elements[DesObjID].length == 5)
          //    window.alert("最多选五项。");
          // else
           {  //GET SELECTED ITEM NUMBER
              SelNum = 0;
              for (var j=0; j<eval("document."+formName).elements[ObjID].length; j++)
              {   if ( eval("document."+formName).elements[ObjID].options[j].selected)
                  SelNum ++;
              }
           //   if ((SelNum + eval("document."+formName).elements[DesObjID].length) > 5)
          //    else
              {  //add
                 for (j=0; j<eval("document."+formName).elements[ObjID].length; j++)
                 {   if (eval("document."+formName).elements[ObjID].options[j].selected)
                     {  //GET VALUE
                        dd = eval("document."+formName).elements[ObjID].options[j].value;
                        if (!IsSelected(formName,DesObjID, dd))
                        {  //GET LENGTH
                           DesLen = eval("document."+formName).elements[DesObjID].length;
                           // NEW OPTION
                           eval("document."+formName).elements[DesObjID].options[DesLen]= new Option(eval("document."+formName).elements[ObjID].options[j].text, eval("document."+formName).elements[ObjID].options[j].value);
                        }
                        else
                           ;
                     }
                 }
              }
           }
        }
     }
     //CLEAR
     	for (j=0; j<eval("document."+formName).elements[ObjID].length; j++){
          eval("document."+formName).elements[ObjID].options[j].selected = false;
         // eval("window."+formName).elements[ObjID].options[j] = null;
   	} 	
  	}
}

function RemoveItem(formName,fieldName){ 
	ObjID = GetObjID(formName,fieldName);
  	if ( ObjID != -1 ){  
  		var  check_index = new Array();
     	for (i=eval("window."+formName).elements[ObjID].length-1; i>=0; i--)	{ 
     		if (eval("window."+formName).elements[ObjID].options[i].selected){  
         	check_index[i] = true;
            eval("window."+formName).elements[ObjID].options[i].selected = false;
         }else{
            check_index[i] = false;
         }
      }
      for (i=eval("window."+formName).elements[ObjID].length-1; i>=0; i--) {   
      	if (check_index[i])
             eval("window."+formName).elements[ObjID].options[i] = null;
      }
   }
}

function RemoveAllItem(formName,fieldName){
	selectAllItem(formName,fieldName);
	RemoveItem(formName,fieldName);
}

function moveSelected(formName,fieldName,flag){
	select=eval("document."+formName+"."+fieldName);
	var i=0;
	var j=select.selectedIndex;
	var swapOption = new Object();	
	if (select.selectedIndex != -1) {
		if((flag=='down')||(flag=='up'))	{
	   	if (flag=='down') {
	      	if (select.selectedIndex != select.options.length - 1)
	        		i = select.selectedIndex + 1;
	     	 	else
	        	return;
	    	}
	    	else if(flag=='up') {
	      	if (select.selectedIndex != 0)
	         	i = select.selectedIndex - 1;
	      	else
	        	return;
	    	}
	    swapOption.text = select.options[select.selectedIndex].text;
	    swapOption.value = select.options[select.selectedIndex].value;
	    swapOption.selected = select.options[select.selectedIndex].selected;
	    swapOption.defaultSelected = select.options[select.selectedIndex].defaultSelected;
	    for (var property in swapOption)
	    select.options[j][property] = select.options[i][property];
	    for (var property in swapOption)
	    select.options[i][property] = swapOption[property];
	    return true;	  
	   }
	   else if((flag=='start')||(flag=='end'))  {
	    	if(flag=='start')	{
	    		for(j=select.selectedIndex;j>0 ;j--){
	    			if (select.selectedIndex != 0)
	         		i = select.selectedIndex - 1;
	      		else
	        			return;	      		
	        	swapOption.text = select.options[select.selectedIndex].text;
	    		swapOption.value = select.options[select.selectedIndex].value;
	    		swapOption.selected = select.options[select.selectedIndex].selected;
	    		swapOption.defaultSelected = select.options[select.selectedIndex].defaultSelected;
	    		for (var property in swapOption)
	    		select.options[j][property] = select.options[i][property];
	    		for (var property in swapOption)
	    		select.options[i][property] = swapOption[property];	
	    		}	    		
	    	}
	    	else if(flag=='end') {
	    		for(j=select.selectedIndex;j<select.options.length;j++){
	      		if (select.selectedIndex != select.options.length - 1)
	        			i = select.selectedIndex + 1;
	     	 		else
	        			return;
	      		swapOption.text = select.options[select.selectedIndex].text;
	    			swapOption.value = select.options[select.selectedIndex].value;
	    			swapOption.selected = select.options[select.selectedIndex].selected;
	    			swapOption.defaultSelected = select.options[select.selectedIndex].defaultSelected;
	    			for (var property in swapOption)
	    				select.options[j][property] = select.options[i][property];
	    			for (var property in swapOption)
	    				select.options[i][property] = swapOption[property];
	    		}
	    	}//end else
	    }
	  }else{
	  		alert("请选择所要调整列的名称！");
	  }
} 

function AppendAllItem(formName,fieldName, DesName){
	selectAllItem(formName,fieldName);
	AppendItem(formName,fieldName, DesName);
	return true;
}
/*2003-5-12 01:11下午*/
//用于树型结构的选择

function selectallCheckbox(formName,v){
	var m=eval("document."+formName+".length");
  	for (i=0;i<m;i++)  	{
		if(eval("document."+formName+".elements["+i+"].type")=='checkbox') {
			if(eval("document."+formName+".elements["+i+"].name")!='selectAll'){	
     			eval("document."+formName+".elements["+i+"].checked = "+v);
     		}
     	}
   }
} 

function checkboxChange(formName,childNode){
	var eleCount=eval("document."+formName+".elements.length");
	var v=false;
	for(var i=0;i<eleCount;i++) {
		if(eval("document."+formName+".elements["+i+"].type")=="checkbox"){	
			var parentNode=eval("document."+formName+".elements["+i+"].value");
			if((parentNode=="")&&(parentNode==childNode)){
				if(eval("document."+formName+".elements["+i+"].checked")==true){
					selectallCheckbox(formName,'true');
					return true;
				}else{
					selectallCheckbox(formName,'false');
					return true;
				}
			}else{
				if(parentNode==childNode){
					if(eval("document."+formName+".elements["+i+"].checked")==true ){
						v=true;
					}else{
						v=false;
					}						
				}else{	
		   		if((parentNode.indexOf(childNode,0) == 0 )&&(eval("document."+formName+".elements["+i+"].checked")!= v )){					
						eval("document."+formName+".elements["+i+"].checked = "+v);
		   		}		   		
		   	}		   					
			}
		}
	}//end for
} 

/***保险部分的菜单函数 ***/ 
/** 2003-08-08 04:44下午 **/ 

function menuShow(obj,maxh,obj2,arrow) {
  if(obj.style.pixelHeight<maxh)  {
    obj.style.pixelHeight+=maxh/1;
 	 obj.filters.alpha.opacity+=0;
    arrow.innerHTML="<FONT face=webdings>6</FONT></span>"
    if(obj.style.pixelHeight>=maxh/1) {
      obj.style.display="block";
      obj.style.pixelHeight = maxh;
    }  
    myObj=obj;
    myMaxh=maxh;
    myObj2=obj2;
    myarrow=arrow
    setTimeout("menuShow(myObj,myMaxh,myObj2,myarrow)","5");
  }
}

function menuHide(obj,maxh,obj2,arrow){
  if(obj.style.pixelHeight>0)  {
    if(obj.style.pixelHeight==maxh/1)
      obj.style.display="none";
    obj.style.pixelHeight-=maxh/1;
    obj.filters.alpha.opacity-=0;
    arrow.innerHTML="<FONT face=webdings>4</FONT></span>"
    myObj=obj;
    myMaxh=maxh
    myObj2=obj2;
    myarrow=arrow
    setTimeout("menuHide(myObj,myMaxh,myObj2,myarrow)","5");
  }
  else
    if(whichContinue)
      whichContinue.click();
}

function menuChange(obj,maxh,obj2,arrow){
  if(obj.style.pixelHeight)  {
    menuHide(obj,maxh,obj2,arrow);
    whichOpen="";
    whichcontinue="";
  }
  else
    if(whichOpen) {
      whichContinue=obj2;
      whichOpen.click();
    } else {
      menuShow(obj,maxh,obj2,arrow);
      whichOpen=obj2;
      whichContinue="";
    }
}

/**
 * date:2003-9-20 9:49
 * 处理鼠标over的事件
 */
function changeButtonStyle(formName,fieldName,flag) {
	if(flag==true){
      eval(formName+"."+fieldName+".style.backgroundImage='url(/infoms/images/menu/button_a.gif)'");
   }else{
      eval(formName+"."+fieldName+".style.backgroundImage='url(/infoms/images/menu/button_v.gif)'");
  	}
}

/*
 *date:2004-4-29 8:56
 *@formName
 *@fieldName
 *@fieldTextName
 *return true or false;
 *function:清除隐藏域
*/
function clearHiddenText(formName,fieldName,fieldTextName) {
	if(!checkNullFieldEmpty(formName,fieldTextName)){
      eval(formName+"."+fieldName+".value=''");
   }
}

function clearKeyFiled(formName,changeFieldKey,changeFieldName){
	eval("document."+formName+"."+changeFieldKey+".value=''");
	eval("document."+formName+"."+changeFieldName+".value=''");
} 