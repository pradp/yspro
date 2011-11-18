
/*
 * Get the number part of a style property value.
 */
function GetStyleNumber(strArg) {
	if (null == strArg || "" == strArg) {
		return 0;
	}
	var i = 0;
	for (i = 0; i < strArg.length; i++) {
		if (isNaN(strArg.charAt(i))) break;
	}
	if (0 == i) {
		return 0;
	}
	var strNum = strArg.substr(0, i);
	return parseInt(strNum, 10);
}

/*##################################################*/
function SlideTab(parentDiv, titleWidth, stepPercent) {

	// Container Div.
	this.container = document.getElementById(parentDiv);
	if (null == this.container) {
		alert("SlideTab.Create: The DIV '" + parentDiv + "' doesn't exist.");
		return;
	}
	this.scopeW = GetStyleNumber(this.container.style.width);
	this.scopeH = GetStyleNumber(this.container.style.height);
	this.scopeT = GetStyleNumber(this.container.style.top);
	this.scopeL = GetStyleNumber(this.container.style.left);
	
	// Title width.
	if (isNaN(titleWidth)) {
		alert("SlideTab.Create: Title width should be a number.");
		return;
	}
	this.titleW = titleWidth;
	// Slide width.
	this.slideW = 0;
	
	// Step percent.
	if (isNaN(stepPercent)) {
		alert("SlideTab.Create: Step percent should be a number.");
		return;
	}
	this.stepPer = stepPercent;
	
	// Tab List.
	this.tabNames = new Array();
	this.tabFlags = new Array();
	this.tabInitX = new Array();
	this.tabPosX = new Array();
	// On Ging.
	this.runningIdx = -1;
	this.toLeft = false;
	// Timer.
	this.timer = null;
	this.percent = 0;
	
	//--------------------------------------------------------

	// Add a tab to this slide.
	this.addTab = function (tabName) {
		this.tabNames.push(tabName);
	}
	
	// Get the tab list length.
	this.getLength = function() {
		return this.tabNames.length;
	}
	
	// Initialize.
	this.init = function() {
		this.container.style.overflow = "hidden";		
		var i = 0;
		for (i = 0; i < this.tabNames.length; i++) {			
			var item = document.getElementById(this.tabNames[i]);
			var itemL = this.scopeL + (this.titleW * i);
			this.tabInitX.push(itemL);
			this.tabPosX.push(itemL);
			item.style.left = itemL + "px";
			item.style.top = this.scopeT + "px";
			item.style.zIndex = this.container.style.zIndex + (this.tabNames.length - i);
			item.style.display = "block";
			item.style.overflow = "hidden";
			this.tabFlags.push('R');
		}
		this.slideW = this.scopeW - (this.titleW * this.tabNames.length);
	}
	
	// Find a tab.
	this.findTab = function(tabName) {
		var i = 0;
		for (i = 0; i < this.tabNames.length; i++) {
			if (this.tabNames[i] == tabName) {
				return i;
			}
		}
		return -1;
	}
	
	// Clean the playing effect.
	this.clean = function() {
		// No running tab.
		if (this.runningIdx == -1) {
			return;
		}
		
		// Stop the playing effect.
		clearInterval(this.timer);
		this.timer = null;
		this.percent = 0;
		
		// Clean the house.
		if (this.toLeft) {
			// A tab should go to the left.
			var i = 0;
			for (i = 0; i <= this.runningIdx; i++) {
				if ('L' != this.tabFlags[i]) {
					var item = document.getElementById(this.tabNames[i]);
					this.tabPosX[i] = this.tabInitX[i] - this.slideW;
					item.style.left = this.tabPosX[i] + "px";
					this.tabFlags[i] = 'L';
					this.tabInitX[i] = this.tabPosX[i];
				}
			}
		} else {		
			// A tab should go to the right.
			var i = 0;
			for (i = this.runningIdx; i < this.tabFlags.length; i++) {
				if ('R' != this.tabFlags[i]) {
					var item = document.getElementById(this.tabNames[i]);
					this.tabPosX[i] = this.tabInitX[i] + this.slideW;
					item.style.left = this.tabPosX[i] + "px";
					this.tabFlags[i] = 'R';
					this.tabInitX[i] = this.tabPosX[i];
				}
			}
		}
		this.runningIdx = -1;
	}
	
	
	this.showing = function(instName, tabName) {
		var idx = this.findTab(tabName);
		this.showByIndex(instName, idx);
		return idx;
	}
	
	// Show the specified tab by index.

	this.showByIndex = function(instName, idx) {
		this.clean();
			
		if ('R' == this.tabFlags[idx]) {
			// Now, the given tab is on the right.
			if (0 == idx) {
				// The first one is open. Do nothing.
				return;
			} else {
				// Not the first one.
				if ('L' == this.tabFlags[idx - 1]) {
					// The left tab is on the left. Do nothing.
					return;
				} else {
					// The left tab should go to the left.
					this.runningIdx = idx - 1;
					this.toLeft = true;
				}
			}
		} else { 
			// Now, the given tab is on the left. It should go to the right.
			this.runningIdx = idx;
			this.toLeft = false;
		}		
		
		this.timer = setInterval(instName + ".doSlide()", 50);
	}
	
	// Do the slide action.
	this.doSlide = function() {
		// Calculate the percent.
		this.percent = this.percent + this.stepPer;
		if (100 < this.percent) {
			this.percent = 100;
		}
		
		if (this.toLeft) {
			// A tab should go to the left.
			var i = 0;
			for (i = 0; i <= this.runningIdx; i++) {
				if ('L' != this.tabFlags[i]) {
					var item = document.getElementById(this.tabNames[i]);
					var delta = this.slideW * (this.percent / 100);
					this.tabPosX[i] = this.tabInitX[i] - delta;
					item.style.left = this.tabPosX[i] + "px";
					if (100 == this.percent) {
						this.tabFlags[i] = 'L';
						this.tabInitX[i] = this.tabPosX[i];
					}
				}
			}
		} else {			
			// A tab should go to the right.
			var i = 0;
			for (i = this.runningIdx; i < this.tabFlags.length; i++) {
				if ('R' != this.tabFlags[i]) {
					var item = document.getElementById(this.tabNames[i]);
					var delta = this.slideW * (this.percent / 100);
					this.tabPosX[i] = this.tabInitX[i] + delta;
					item.style.left = this.tabPosX[i] + "px";
					if (100 == this.percent) {
						this.tabFlags[i] = 'R';
						this.tabInitX[i] = this.tabPosX[i];
					}
				}
			}
		}
		
		// If done, clean the house.
		if (100 == this.percent) {
			this.clean();
		}
	}
	
	// Auto slide.
	this.loopSlide = function(instName) {
		var i = 0;
		var baseLine = this.tabFlags[0];
		var swap = false;
		for (i = 0; i < this.tabFlags.length; i++) {
			if (baseLine != this.tabFlags[i]) {
				swap = true;
				if (i == this.tabFlags.length - 1) {
					this.showByIndex(instName, 0);
				} else {
					this.showByIndex(instName, i + 1);
				}
				break;
			}
		}
		if (!swap) {
			this.showByIndex(instName, 1);
		}
	}
	
}

/*##################################################*/
 
/*
 * Class SwapTab
 */
function SwapTab(idPrefix) {

	this.preFix = idPrefix;
	if (null == this.preFix) {
		alert("SwapTab.Create: invalid argument.");
		return;
	}
	
	// Image URL buffer.
	this.openImgs = new Array();
	this.closeImgs = new Array();
	// Internal buffer.
	this.imgBuffer = new Array();
	
	// Add a swap tab.
	this.addTab = function(openSrc, closeSrc) {
		var img;
		
		this.openImgs.push(openSrc);
		img = new Image();
		img.src = openSrc;
		this.imgBuffer.push(img);
		
		this.closeImgs.push(closeSrc);
		img = new Image();
		img.src = closeSrc;
		this.imgBuffer.push(img);
	}
	
	this.showTab = function(idx) {
		var tabListLen = this.openImgs.length;
		var i = 0;
		for (i = 0; i < tabListLen; i++) {
			var arrowImg = document.getElementById(this.preFix + i);
			if (null == arrowImg) {
				alert("SwapTab.showTab: Image " + this.preFix + i + " not found.");
				return;
			}
			if (i == idx) {
				arrowImg.src = this.openImgs[i];
			} else {
				arrowImg.src = this.closeImgs[i];
			}
		}
	}
}


		var slide;
		var swapTab;
		
		function onPageLoad() {
			slide = new SlideTab("root", 35, 5);
			slide.addTab("zwxx");
			slide.addTab("bsdt");
			slide.addTab("zmhd");
			slide.init();
			
			swapTab = new SwapTab("Arrow");
			swapTab.addTab("faceui/images/001_open.gif", "faceui/images/001_close.gif");
			swapTab.addTab("faceui/images/002_open.gif", "faceui/images/002_close.gif");
			swapTab.addTab("faceui/images/003_open.gif", "faceui/images/003_close.gif");
			swapTab.showTab(0);
			
			
			
		}
		
		function onShowTab(tabName) {
			var idx = slide.showing("slide", tabName);
			swapTab.showTab(idx);			
		}

//weige-js结束
//畜种样式tab
function change(ss){
	if(ss=="top1"){
		document.getElementById("left1").style.display="none";
		document.getElementById("left2").style.display="block";
		document.getElementById("right1").style.display="block";
		document.getElementById("right2").style.display="none";
		document.getElementById("left3").style.display="block";
		document.getElementById("left4").style.display="none";
		document.getElementById("right3").style.display="block";
		document.getElementById("right4").style.display="none";
		document.getElementById("left5").style.display="block";
		document.getElementById("right5").style.display="none";
		document.getElementById("biao1").style.display="block";
		document.getElementById("biao2").style.display="none";
		document.getElementById("biao3").style.display="none";
		document.getElementById("biao4").style.display="none";
		document.getElementById("biao5").style.display="none";
		}
    if(ss=="top2"){
		document.getElementById("left1").style.display="block";
		document.getElementById("left2").style.display="none";
		document.getElementById("right1").style.display="none";
		document.getElementById("right2").style.display="block";
		document.getElementById("left3").style.display="block";
		document.getElementById("left4").style.display="none";
		document.getElementById("right3").style.display="block";
		document.getElementById("right4").style.display="none";
		document.getElementById("left5").style.display="block";
		document.getElementById("right5").style.display="none";
		document.getElementById("biao1").style.display="none";
		document.getElementById("biao2").style.display="block";
		document.getElementById("biao3").style.display="none";
		document.getElementById("biao4").style.display="none";
		document.getElementById("biao5").style.display="none";
	}
	if(ss=="top3"){
		document.getElementById("left1").style.display="block";
		document.getElementById("left2").style.display="none";;
		document.getElementById("right1").style.display="block";
		document.getElementById("right2").style.display="none";
		document.getElementById("left3").style.display="none";
		document.getElementById("left4").style.display="block";
		document.getElementById("right3").style.display="block";
		document.getElementById("right4").style.display="none";
		document.getElementById("left5").style.display="block";
		document.getElementById("right5").style.display="none";
		document.getElementById("biao1").style.display="none";
		document.getElementById("biao2").style.display="none";
		document.getElementById("biao3").style.display="block";
		document.getElementById("biao4").style.display="none";
		document.getElementById("biao5").style.display="none";
	}
	if(ss=="top4"){
		document.getElementById("left1").style.display="block";
		document.getElementById("left2").style.display="none";
		document.getElementById("right1").style.display="block";
		document.getElementById("right2").style.display="none";
		document.getElementById("left3").style.display="block";
		document.getElementById("left4").style.display="none";
		document.getElementById("right3").style.display="none";
		document.getElementById("right4").style.display="block";
		document.getElementById("left5").style.display="block";
		document.getElementById("right5").style.display="none";
		document.getElementById("biao1").style.display="none";
		document.getElementById("biao2").style.display="none";
		document.getElementById("biao3").style.display="none";
		document.getElementById("biao4").style.display="block";
		document.getElementById("biao5").style.display="none";
	}
	if(ss=="top5"){
		document.getElementById("left1").style.display="block";
		document.getElementById("left2").style.display="none";
		document.getElementById("right1").style.display="block";
		document.getElementById("right2").style.display="none";
		document.getElementById("left3").style.display="block";
		document.getElementById("left4").style.display="none";
		document.getElementById("right3").style.display="block";
		document.getElementById("right4").style.display="none";
		document.getElementById("left5").style.display="none";
		document.getElementById("right5").style.display="block";
		document.getElementById("biao1").style.display="none";
		document.getElementById("biao2").style.display="none";
		document.getElementById("biao3").style.display="none";
		document.getElementById("biao4").style.display="none";
		document.getElementById("biao5").style.display="block";
	}
	
}