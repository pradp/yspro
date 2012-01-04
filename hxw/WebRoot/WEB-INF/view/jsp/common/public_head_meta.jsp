<%@ page language="java" pageEncoding="UTF-8"%>

    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/faceui/css/layout.css"/>
    <script type="text/javascript" src="<%=request.getContextPath() %>/faceui/js/jquery.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/faceui/js/common.js"></script>
	<style>
	<!--
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
		color: #FD9305;
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
	-->
	</style>
	<script type="text/javascript">
	<!--
	var timeout	= 500;
	var closetimer	= 0;
	var ddmenuitem	= 0;
	// open hidden layer
	function mopen(id){	
		// cancel close timer
		mcancelclosetime();
		// close old layer
		if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
		// get new layer and show it
		ddmenuitem = document.getElementById(id);
		ddmenuitem.style.visibility = 'visible';
	}
	// close showed layer
	function mclose(){
		if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
	}
	// go close timer
	function mclosetime(){
		closetimer = window.setTimeout(mclose, timeout);
	}
	// cancel close timer
	function mcancelclosetime(){
		if(closetimer){
			window.clearTimeout(closetimer);
			closetimer = null;
		}
	}
	
	// close layer when click-out
	document.onclick = mclose; 
	//-->
	</script>

