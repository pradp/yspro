/*---------------------------------------------------------------|
 | ysTree 3.1 | www.imchooser.com                                |
 |---------------------------------------------------------------|
 | Copyright (c) 2009-2014 Jason Yang                            |
 |                                                               |
 | 此JS树基于dTree(www.destroydrop.com)改进而来，新增功能如下：         |
 | 1、支持checkbox功能，配置ystree.config.showCheckBox=true；        |
 | 2、增加点击节点后触发事件接口，客户端overide此事件函数实现响应点击动作；  |
 | 3、根据实际使用需要，把最可能修改的参数放在构造函数的前面部分；            |
 | 4、自动引入CSS文件；                                                   |
 |                                                               |
 | Updated: 17.04.2009                                           |
 |---------------------------------------------------------------*/

//alert('im in');
var ysStyle_ImagesPath = "resource/images/style1/";
var ystreecheckboxname = "ystreeCheckBoxName";//if show checkbox, the checkbox name.
var valueContainerId = "nodeid";//存放checkbox值的input控件的ID,配合你页面中定义的input控件的id

/**
 * 当点击树节点文字时触发的事件函数
 * 客户端可override此方法
 * @param {Object} nodeid 被点击的节点的id
 * @param {Object} clickIndex 被点击的节点的索引值
 * 示例：document.getElementById("node_"+nodeid) 取得节点DOM对象
 * document.getElementById("checkbox_"+nodeid) 取得checkbox对象
 * ystree.aNodes[clickIndex] 取得ystree节点对象
 * ystree.getNodeObjectById(nodeid) 取得ystree节点对象
 * add by yangjianliang at 20090421.
 */
function nodeText_clicked(nodeid, clickIndex){
    //example:
    //alert(nodeid);//the same as:
    //var id = document.getElementById("node_"+nodeid).id;
    //alert(id);
}

/**
 * 当点击树节点开关图片时触发的事件函数
 * 客户端可override此方法
 * @param {Object} nodeid 被点击的节点的id
 * @param {Object} clickIndex 被点击的节点的索引值
 * 示例：document.getElementById("node_"+nodeid) 取得节点DOM对象
 * document.getElementById("checkbox_"+nodeid) 取得checkbox对象
 * ystree.aNodes[clickIndex] 取得ystree节点对象
 * ystree.getNodeObjectById(nodeid) 取得ystree节点对象
 * add by yangjianliang at 20090421.
 */
function loaddata(nodeid, clickIndex){
	
}

// Node object
function Node(id, pid, name, checkboxValue, openNode, url, title, target, icon, iconOpen){

    this.id = id;
    
    this.pid = pid;
    
    this.name = name;
    
    this.checkboxValue = checkboxValue;
    
    this._io = openNode || false;
    
    this.url = url;
    
    this.title = title;
    
    this.target = target;
    
    this.icon = icon;
    
    this.iconOpen = iconOpen;
    
    this._is = false;
    
    this._ls = false;
    
    this._hc = false;
    
    this._ai = 0;
    
    this._p;
    
}

// Tree object
function YsTree(objName){
    //这里objName传入实例对象名称，便于后面prototype属性引用。
    //如：var at = new ysTree('at');
    this.config = {
    
        target: null,
        
        folderLinks: true,
        
        useSelection: true,
        
        useCookies: false,//默认关闭记住状态功能
        
        useLines: true,
        
        useIcons: true,
        
        useStatusText: false,
        
        closeSameLevel: false,
        
        inOrder: false,
        
        showCheckBox: false
    
    };
    
    this.icon = {
    
        root: ysStyle_ImagesPath + 'base.gif',
        
        folder: ysStyle_ImagesPath + 'folder.gif',
        
        folderOpen: ysStyle_ImagesPath + 'folderopen.gif',
        
        node: ysStyle_ImagesPath + 'page.gif',
        
        empty: ysStyle_ImagesPath + 'empty.gif',
        
        line: ysStyle_ImagesPath + 'line.gif',
        
        join: ysStyle_ImagesPath + 'join.gif',
        
        joinBottom: ysStyle_ImagesPath + 'joinbottom.gif',
        
        plus: ysStyle_ImagesPath + 'plus.gif',
        
        plusBottom: ysStyle_ImagesPath + 'plusbottom.gif',
        
        minus: ysStyle_ImagesPath + 'minus.gif',
        
        minusBottom: ysStyle_ImagesPath + 'minusbottom.gif',
        
        nlPlus: ysStyle_ImagesPath + 'nolines_plus.gif',
        
        nlMinus: ysStyle_ImagesPath + 'nolines_minus.gif'
    
    };
    
    this.obj = objName;
    
    this.aNodes = [];
    
    this.aIndent = [];
    
    this.root = new Node('');
    
    this.selectedNode = null;
    
    this.selectedFound = false;
    
    this.completed = false;
    
}

// Adds a new node to the node array
YsTree.prototype.add = function(id, pid, name, checkboxValue, openNode, url, title, target, icon, iconOpen){

    this.aNodes[this.aNodes.length] = new Node(id, pid, name, checkboxValue, openNode, url, title, target, icon, iconOpen);
    
}

// Open/close all nodes
YsTree.prototype.openAll = function(){

    this.oAll(true);
    
}

YsTree.prototype.closeAll = function(){

    this.oAll(false);
    
}

// Outputs the tree to the page
YsTree.prototype.toString = function(){

    var str = '<div class="ystree">\n';
    
    if (document.getElementById) {
    
        if (this.config.useCookies) 
            this.selectedNode = this.getSelected();
        
        str += this.addNode(this.root);
        
    }
    else 
        str += 'Browser not supported.';
    
    str += '</div>';
    
    if (!this.selectedFound) {
        this.selectedNode = null;
    }
    
    this.completed = true;
    
    return str;
    
}

// Creates the tree structure
YsTree.prototype.addNode = function(pNode){

    var str = '';
    
    var n = 0;
    
    if (this.config.inOrder) 
        n = pNode._ai;
    
    for (n; n < this.aNodes.length; n++) {
    
        if (this.aNodes[n].pid == pNode.id) {
        
            var cn = this.aNodes[n];
            
            cn._p = pNode;
            
            cn._ai = n;
            
            this.setCS(cn);
            
            if (!cn.target && this.config.target) 
                cn.target = this.config.target;
            
            if (cn._hc && !cn._io && this.config.useCookies) 
                cn._io = this.isOpen(cn.id);
            
            if (!this.config.folderLinks && cn._hc) 
                cn.url = null;
            
            if (this.config.useSelection && cn.id == this.selectedNode && !this.selectedFound) {
            
                cn._is = true;
                
                this.selectedNode = n;
                
                this.selectedFound = true;
                
            }
            
            str += this.node(cn, n);
            
            if (cn._ls) 
                break;
            
        }
        
    }
    
    return str;
    
}

// Creates the node icon, url and text. nodeId is nodeNumber
YsTree.prototype.node = function(node, nodeId){

    var str = '<div class="ysTreeNode">' + this.indent(node, nodeId);
    
    if (this.config.useIcons) {
    
        if (!node.icon) 
            node.icon = (this.root.id == node.pid) ? this.icon.root : ((node._hc) ? this.icon.folder : this.icon.node);
        
        if (!node.iconOpen) 
            node.iconOpen = (node._hc) ? this.icon.folderOpen : this.icon.node;
        
        if (this.root.id == node.pid) {
        
            node.icon = this.icon.root;
            
            node.iconOpen = this.icon.root;
            
        }
        if (this.config.showCheckBox) {
        
            var _checkboxValue_ = "";
            if (node.checkboxValue == null) {
                _checkboxValue_ = node.id;
            }
            else {
                _checkboxValue_ = node.checkboxValue;
            }
            str += '<input type="checkbox" id="checkbox_' + node.id + '" name="' + ystreecheckboxname + '" value="' + _checkboxValue_ + '" onclick="resetValue(this)"/>';
        }
        str += '<img id="i' + this.obj + nodeId + '" src="' + ((node._io) ? node.iconOpen : node.icon) + '" />';
        
    }
    
    if (node.url && node.url.length > 0) {
    
        str += '<a id="node_' + node.id + '" class="' + ((this.config.useSelection) ? ((node._is ? 'nodeSel' : 'node')) : 'node') + '" onclick="' + node.url + '"';
        
        if (node.title) 
            str += ' title="' + node.title + '"';
        
        if (node.target) 
            str += ' target="' + node.target + '"';
        
        if (this.config.useStatusText) 
            str += ' onmouseover="window.status=\'' + node.name + '\';return true;" onmouseout="window.status=\'\';return true;" ';
        
        if (this.config.useSelection && ((node._hc && this.config.folderLinks) || !node._hc)) 
        
            str += ' onclick="javascript: ' + this.obj + '.s(' + nodeId + ');"';
        
        str += '>';
    }
    else {
        if (this.config.showCheckBox) {
            str += '<label for="checkbox_' + node.id + '" id="node_' + node.id + '" onclick="' + this.obj + '.s(' + nodeId + ');" class="node" style="cursor:pointer;">';
        }
        else {
            str += '<a id="node_' + node.id + '" onclick="javascript:' + this.obj + '.s(' + nodeId + ');" class="node">';
        }
    }
    
    str += node.name;
    
    if (node.url && node.url.length > 0) {
        str += '</a>';
    }
    else {
        if (this.config.showCheckBox) {
            str += '</label>';
        }
        else {
            str += '</a>';
        }
    }
    
    str += '</div>';
    
    if (node._hc) {
    
        str += '<div id="d' + this.obj + nodeId + '" class="clip" style="display:' + ((this.root.id == node.pid || node._io) ? 'block' : 'none') + ';">';
        
        str += this.addNode(node);
        
        str += '</div>';
        
    }
    
    this.aIndent.pop();
    
    return str;
    
}

// Adds the empty and line icons
YsTree.prototype.indent = function(node, nodeId){

    var str = '';
    
    if (this.root.id != node.pid) {
    
        for (var n = 0; n < this.aIndent.length; n++) 
        
            str += '<img src="' + ((this.aIndent[n] == 1 && this.config.useLines) ? this.icon.line : this.icon.empty) + '" />';
        
        (node._ls) ? this.aIndent.push(0) : this.aIndent.push(1);
        
        if (node._hc) {
        
            str += '<a onclick="javascript: ' + this.obj + '.o(' + nodeId + ');"><img id="j' + this.obj + nodeId + '" src="';
            
            if (!this.config.useLines) 
                str += (node._io) ? this.icon.nlMinus : this.icon.nlPlus;
            
            else 
                str += ((node._io) ? ((node._ls && this.config.useLines) ? this.icon.minusBottom : this.icon.minus) : ((node._ls && this.config.useLines) ? this.icon.plusBottom : this.icon.plus));
            
            str += '" alt="" /></a>';
            
        }
        else 
            str += '<img src="' + ((this.config.useLines) ? ((node._ls) ? this.icon.joinBottom : this.icon.join) : this.icon.empty) + '" alt="" />';
        
    }
    
    return str;
    
}

// Checks if a node has any children and if it is the last sibling
YsTree.prototype.setCS = function(node){

    var lastId;
    
    for (var n = 0; n < this.aNodes.length; n++) {
    
        if (this.aNodes[n].pid == node.id) 
            node._hc = true;
        
        if (this.aNodes[n].pid == node.pid) 
            lastId = this.aNodes[n].id;
        
    }
    
    if (lastId == node.id) 
        node._ls = true;
    
}

// Returns the selected node
YsTree.prototype.getSelected = function(){

    var sn = this.getCookie('cs' + this.obj);
    
    return (sn) ? sn : null;
    
}

// Highlights the selected node
YsTree.prototype.s = function(index){

    var cn = this.aNodes[index];
    
    nodeText_clicked(cn.id, index);
    
    if (!this.config.useSelection) 
        return;
    
    if (cn._hc && !this.config.folderLinks) 
        return;
    
    if (this.selectedNode != index) {
    
        if (this.selectedNode || this.selectedNode == 0) {
        
            eOld = document.getElementById("node_" + this.aNodes[this.selectedNode].id);
            
            eOld.className = "node";
            
        }
        
        eNew = document.getElementById("node_" + cn.id);
        
        eNew.className = "nodeSel";
        
        this.selectedNode = index;
        
        if (this.config.useCookies) 
            this.setCookie('cs' + this.obj, index);
        
    }
    
}

// Toggle Open or close
YsTree.prototype.o = function(index){

    var cn = this.aNodes[index];
    
    this.nodeStatus(!cn._io, index, cn._ls);
    
    cn._io = !cn._io;
    
    if (this.config.closeSameLevel) 
        this.closeLevel(cn);
    
    if (this.config.useCookies) 
        this.updateCookie();
    
}

// Open or close all nodes
YsTree.prototype.oAll = function(status){

    for (var n = 0; n < this.aNodes.length; n++) {
    
        if (this.aNodes[n]._hc && this.aNodes[n].pid != this.root.id) {
        
            this.nodeStatus(status, n, this.aNodes[n]._ls)
            
            this.aNodes[n]._io = status;
            
        }
        
    }
    
    if (this.config.useCookies) 
        this.updateCookie();
    
}

// Opens the tree to a specific node
YsTree.prototype.openTo = function(nId, bSelect, bFirst){

    if (!bFirst) {
    
        for (var n = 0; n < this.aNodes.length; n++) {
        
            if (this.aNodes[n].id == nId) {
            
                nId = n;
                
                break;
                
            }
            
        }
        
    }
    
    var cn = this.aNodes[nId];
    
    if (cn.pid == this.root.id || !cn._p) 
        return;
    
    cn._io = true;
    
    cn._is = bSelect;
    
    if (this.completed && cn._hc) 
        this.nodeStatus(true, cn._ai, cn._ls);
    
    if (this.completed && bSelect) 
        this.s(cn._ai);
    
    else 
        if (bSelect) 
            this._sn = cn._ai;
    
    this.openTo(cn._p._ai, false, true);
    
}

// Closes all nodes on the same level as certain node
YsTree.prototype.closeLevel = function(node){
    for (var n = 0; n < this.aNodes.length; n++) {
        if (this.aNodes[n].pid == node.pid && this.aNodes[n].id != node.id && this.aNodes[n]._hc) {
        
            this.nodeStatus(false, n, this.aNodes[n]._ls);
            
            this.aNodes[n]._io = false;
            
            this.closeAllChildren(this.aNodes[n]);
        }
    }
}

// Closes all children of a node
YsTree.prototype.closeAllChildren = function(node){
    for (var n = 0; n < this.aNodes.length; n++) {
        if (this.aNodes[n].pid == node.id && this.aNodes[n]._hc) {
            if (this.aNodes[n]._io) 
                this.nodeStatus(false, n, this.aNodes[n]._ls);
            this.aNodes[n]._io = false;
            this.closeAllChildren(this.aNodes[n]);
        }
    }
}

// Change the status of a node(open or closed)
YsTree.prototype.nodeStatus = function(status, id, bottom){
	
	if(status){//在关闭的节点上点击时，status=true。然后根据节点状态调用AJAX方法取数据
		loaddata(this.aNodes[id].id, id);//参数1：被点击节点的id；参数2：是索引号
	}

    eDiv = document.getElementById('d' + this.obj + id);
    
    eJoin = document.getElementById('j' + this.obj + id);
    
    if (this.config.useIcons) {
    
        eIcon = document.getElementById('i' + this.obj + id);
        
        eIcon.src = (status) ? this.icon.folderOpen : this.icon.folder;
        
    }
    
    eJoin.src = (this.config.useLines) ? ((status) ? ((bottom) ? this.icon.minusBottom : this.icon.minus) : ((bottom) ? this.icon.plusBottom : this.icon.plus)) : ((status) ? this.icon.nlMinus : this.icon.nlPlus);
    
    eDiv.style.display = (status) ? 'block' : 'none';
    
}

// [Cookie] Clears a cookie
YsTree.prototype.clearCookie = function(){

    var now = new Date();
    
    var yesterday = new Date(now.getTime() - 1000 * 60 * 60 * 24);
    
    this.setCookie('co' + this.obj, 'cookieValue', yesterday);
    
    this.setCookie('cs' + this.obj, 'cookieValue', yesterday);
    
}

// [Cookie] Sets value in a cookie
YsTree.prototype.setCookie = function(cookieName, cookieValue, expires, path, domain, secure){

    document.cookie = escape(cookieName) + '=' + escape(cookieValue) +
    (expires ? '; expires=' + expires.toGMTString() : '') +
    (path ? '; path=' + path : '') +
    (domain ? '; domain=' + domain : '') +
    (secure ? '; secure' : '');
    
}

// [Cookie] Gets a value from a cookie
YsTree.prototype.getCookie = function(cookieName){

    var cookieValue = '';
    
    var posName = document.cookie.indexOf(escape(cookieName) + '=');
    
    if (posName != -1) {
    
        var posValue = posName + (escape(cookieName) + '=').length;
        
        var endPos = document.cookie.indexOf(';', posValue);
        
        if (endPos != -1) 
            cookieValue = unescape(document.cookie.substring(posValue, endPos));
        
        else 
            cookieValue = unescape(document.cookie.substring(posValue));
        
    }
    
    return (cookieValue);
    
}

// [Cookie] Returns ids of open nodes as a string
YsTree.prototype.updateCookie = function(){

    var str = '';
    
    for (var n = 0; n < this.aNodes.length; n++) {
    
        if (this.aNodes[n]._io && this.aNodes[n].pid != this.root.id) {
        
            if (str) 
                str += '.';
            
            str += this.aNodes[n].id;
            
        }
        
    }
    
    this.setCookie('co' + this.obj, str);
    
}

// [Cookie] Checks if a node id is in a cookie
YsTree.prototype.isOpen = function(id){

    var aOpen = this.getCookie('co' + this.obj).split('.');
    
    for (var n = 0; n < aOpen.length; n++) 
    
        if (aOpen[n] == id) 
            return true;
    
    return false;
    
}

// If Push and pop is not implemented by the browser
if (!Array.prototype.push) {

    Array.prototype.push = function array_push(){
    
        for (var i = 0; i < arguments.length; i++) 
        
            this[this.length] = arguments[i];
        
        return this.length;
        
    }
    
}

if (!Array.prototype.pop) {

    Array.prototype.pop = function array_pop(){
    
        lastElement = this[this.length - 1];
        
        this.length = Math.max(this.length - 1, 0);
        
        return lastElement;
        
    }
    
}

if (!Array.prototype.remove) {
    Array.prototype.remove = function(dx){
        if (isNaN(dx) || dx > this.length) {
            return false;
        }
	  this.splice(dx,1);
    }
}

/**
 * 根据节点ID值，查找节点对象
 * @param {Object} nodeid：node对象的id。
 * @return 返回节点对象，如果没有，返回null
 */
YsTree.prototype.getNodeObjectById = function (nodeid){
	var arr = ystree.aNodes;
	for(var i=0;i<arr.length;i++){
		var node = arr[i];
		if(node.id==nodeid){
			return node;
		}
	}
	return null;
}

/************************************************* 下面的方法都是为支持checkbox功能而加 ********************************************************/
/**
 * 当点击checkbox后，为表单元素重新付值
 * @param {Object} obj :checkbox ,
 */
function resetValue(obj){
	super_resetValue(obj);
}
/**
 * 当点击checkbox后，为表单元素重新付值
 * @param {Object} obj  checkbox
 * @param {Object} parentContainerId  父页面控件id
 * valueContainerId : 存放checkbox值的input控件的ID
 */
function super_resetValue(obj,parentContainerId){
    selectAllSon(obj);
    var c = document.getElementsByName(ystreecheckboxname);
    var tmp = "";
    for (var i = 0; i < c.length; i++) {
        if (c[i].checked) {
            tmp += c[i].value + ",";
        }
    }
    tmp = tmp.substring(0, tmp.length - 1);
    if (document.getElementById(valueContainerId)) 
        document.getElementById(valueContainerId).value = tmp;
    else 
        if (document.getElementsByName(valueContainerId)[0]) {
            document.getElementsByName(valueContainerId)[0].value = tmp;
        }
    //给父页面控件赋值
	if(parent.document.getElementById(parentContainerId)){
		parent.document.getElementById(parentContainerId).value = CropCheckBoxValueAsString(ystreecheckboxname);
	}else if(window.dialogArguments.document.getElementById(parentContainerId)){
		window.dialogArguments.document.getElementById(parentContainerId).value = CropCheckBoxValueAsString(ystreecheckboxname);
	}
}

/**
 * 控制是否要选中和被点节点相关的一些节点，比如子节点，父节点
 * @param {Object} obj
 */
function selectAllSon(obj,type){
	for ( var i = 0; i < ystree.aNodes.length; i++) {
		if(ystree.aNodes[i].pid == obj.value && (type==null || type=="undefind" || type=="1")){
			$("input[@type='checkbox']").each(function(){
				if(this.value==ystree.aNodes[i].id){
					this.checked = obj.checked;
					selectAllSon(this,"1");
				}
			});
		}else if(ystree.aNodes[i].id == obj.value && (type==null || type=="undefind" || type=="2")) {
			var kk = 0; var jj = 0;
			for ( var j = 0; j < ystree.aNodes.length; j++) {
				if(ystree.aNodes[i].pid == ystree.aNodes[j].pid){
					$("input[@type='checkbox']").each(function(){
						if(this.value==ystree.aNodes[j].id){
							kk = kk + 2; 
							if(this.checked) jj = jj + 2; //选中
							if(this.indeterminate) jj = jj + 1; //半选中
						}
					});
				}
			}
			$("input[@type='checkbox']").each(function(){
				if(this.value==ystree.aNodes[i].pid){
					if(kk==jj && kk!=0){
						this.indeterminate = false;
						this.checked = true;
					}else if(jj==0){
						this.indeterminate = false;
						this.checked = false;
					}else{
						this.indeterminate = true;
					}
					selectAllSon(this,"2");
				}
			});
		}
    }
}

function isMySonAllSelected(currID){
    var f = true;
    var c = document.getElementsByName(ystreecheckboxname);
    for (var i = 0; i < c.length; i++) {
        if (c[i].id != currID && c[i].id.indexOf(currID) == 0) {
            if (c[i].checked == false) {
                f = false;
                break;
            }
        }
    }
    return f;
}

/**
 * 根据父节点从服务端查询其子节点数据，然后生成此节点的子节点html
 * @param treedata 子节点的json数组
 * @param {Object} index
 * @param {Object} level 上级的层次,用于计算节点前的虚线数
 * @memberOf {TypeName} 
 */
YsTree.prototype.createChildNode = function(treedata, index, level){
	if(treedata!=null && treedata!="[]"){
		var jsonarray=eval("("+treedata+")");
        var node = "";
        for(var i=0;i<jsonarray.length;i++){
        	 var currentIndex = this.aNodes.length-1;
             currentIndex += 1;
        	 var obj = jsonarray[i];
             var name = obj.name;
             var count = parseInt(obj.childCount); 
             if(count!=0){
             	this.add(obj.id,obj.pid,obj.name,obj.url,false); 
             	this.add(currentIndex,obj.id,'加载中','');
             	//this.aNodes[currentIndex]._io = true;
             }else{
             	this.add(obj.id,obj.pid,obj.name,obj.url,true);
             	//this.node(this.aNodes[currentIndex],obj.id);
             }
             var len_id = obj.id.length/3 - 2;
             if(level!=null && level!='undefind'){
            	 len_id = level;
             }
             var divinner="";
             if(this.config.showCheckBox){
            	if(count == 0){
	              	divinner="<div class='ysTreeNode'>";
	              	for(var iel=0;iel<len_id;iel++){
	              		divinner += "<img src='resource/images/style1/line.gif'/>";
	              	}
	              	if(i==jsonarray.length-1){
	              		divinner += "<img alt='' src='resource/images/style1/joinbottom.gif'/>";
	              	}else{
	              		divinner += "<img alt='' src='resource/images/style1/join.gif'/>";
	              	}
	              	divinner+= "<input id='checkbox_"+obj.id+"' type='checkbox' onclick='resetValue(this)' value='"+obj.id+"' name='ystreeCheckBoxName'/>"
	                      	+  "<img id='iystree"+currentIndex+"' src='resource/images/style1/page.gif'/>"
	                      	+  "<label id='node_"+obj.id+"' class='nodeSel' style='cursor: pointer;' onclick='ystree.s("+currentIndex+");' for='checkbox_"+obj.id+"'>"+name+"</label>"
	                      	+  "</div>";
              	}else{
	              	divinner += "<div class='ysTreeNode'>";
	              	for(var iel=0;iel<len_id;iel++){
	              		divinner += "<img src='resource/images/style1/line.gif'/>";
	              	}
	              	divinner  += "<a onclick='javascript: ystree.o("+currentIndex+");'>"
	              			  +  "<img id='jystree"+currentIndex+"' alt='' src='resource/images/style1/plus.gif'></a>"
	              	          +  "<input id='checkbox_"+obj.id+"' type='checkbox' onclick='resetValue(this)'value='"+obj.id+"' name='ystreeCheckBoxName'>"
							  +  "<img id='iystree"+currentIndex+"' src='resource/images/style1/folder.gif'>"
                              +  "<a id='node_"+obj.id+"' class='node' onclick='javascript: ystree.s("+currentIndex+");'>"+name+"</a>"
	                      	  +  "</div>"
							  +	 "<div id='dystree"+currentIndex+"' class='clip' style='display:none;'>"
							  +	 "<div class='ysTreeNode'>";
	              	
	              	for(var iel=0;iel<len_id;iel++){
	              		divinner += "<img src='resource/images/style1/line.gif'/>";
	              	}
					divinner  += "<img alt='' src='resource/images/style1/join.gif'>"
							  +  "<input id='checkbox_"+currentIndex+"' type='checkbox' onclick='resetValue(this)' value='' name='ystreeCheckBoxName'>"
							  //+  "<img src='resource/images/style1/empty.gif'>"
							  //+  "< alt='' src='resource/images/style1/joinbottom.gif'>"
							  +  "<img id='iystree"+(currentIndex+1)+"' src='resource/images/style1/page.gif'>"
							  +  "<a id='node_"+(currentIndex+1)+"' class='node' onclick='javascript: ystree.s("+(currentIndex+1)+");'>加载中</a>"
							  +  "</div>"
							  +  "</div>";
              	}
                 
             }else{
            	if(count==0){
	              	divinner="<div class='ysTreeNode'>";
	              	for(var iel=0;iel<len_id;iel++){
	              		divinner += "<img src='resource/images/style1/line.gif'/>";
	              	}
	              	if(i==jsonarray.length-1){
	              		divinner += "<img alt='' src='resource/images/style1/joinbottom.gif'/>";
	              	}else{
	              		divinner += "<img alt='' src='resource/images/style1/join.gif'/>";
	              	}
	              	divinner+="<img id='iystree"+currentIndex+"' src='resource/images/style1/page.gif'/>"
	                        +"<a id='node_"+obj.id+"' class='node' onclick='javascript: ystree.s("+currentIndex+")';>"+name+"</a>"
	                        +"</div>";
              	}else{
	              	divinner += "<div class='ysTreeNode'>";
	              	for(var iel=0;iel<len_id;iel++){
	              		divinner += "<img src='resource/images/style1/line.gif'/>";
	              	}
	              	divinner  += "<a onclick='javascript: ystree.o("+currentIndex+");'><img id='jystree"+currentIndex+"' alt='' src='resource/images/style1/plus.gif'></a>"
							  +  "<img id='iystree"+currentIndex+"' src='resource/images/style1/folder.gif'>"
                              +  "<a id='node_"+obj.id+"' class='node' onclick='javascript: ystree.s("+currentIndex+");'>"+name+"</a>"
	                      	  +  "</div>"
							  +	 "<div id='dystree"+currentIndex+"' class='clip' style='display:none;'>"
							  +	 "<div class='ysTreeNode'>"
							  +  "<img src='resource/images/style1/empty.gif'>"
							  +  "<img alt='' src='resource/images/style1/joinbottom.gif'>"
							  +  "<img id='iystree"+(currentIndex+1)+"' src='resource/images/style1/page.gif'>"
							  +  "<a id='node_"+(currentIndex+1)+"' class='node' onclick='javascript: ystree.s("+(currentIndex+1)+");'>加载中</a>"
							  +  "</div>"
							  +  "</div>";
              	}
             }
             node =node+divinner;
         }
         document.getElementById("dystree"+index).innerHTML=node;
       }else{
          // alert("no data!");// 
          var nd = this.aNodes[index];
          var text = "";
          if(this.config.showCheckBox){
              text="<img alt='' src='resource/images/style1/join.gif'/>"
                  +"<input id='checkbox_"+nd.id+"' type='checkbox' onclick='resetValue(this)' value='"+nd.id+"' name='ystreeCheckBoxName'/>"
                  +"<img id='iystree"+index+"' src='resource/images/style1/page.gif'/>"
                  +"<label id='node_"+nd.id+"' class='nodeSel' style='cursor: pointer;' onclick='ystree.s("+index+");' for='checkbox_"+nd.id+"'>"+nd.name+"</label>";
              
           }else{
        	   text = "<img alt='' src='resource/images/style1/join.gif'/>"
               +"<img id='iystree"+index+"' src='resource/images/style1/page.gif'/>"
               +"<a id='node_"+nd.id+"' class='nodeSel' onclick='javascript: ystree.s("+index+");'>"+nd.name+"</a>";
           }
           document.getElementById("iystree"+index).parentElement.innerHTML = text;//把文件夹变成文件的形式
           //document.getElementById("dystree"+index).innerHTML="";此用法会使层拉开距离
           document.getElementById("dystree"+index).style.display="none";
          
       }
}
/**
 * 获取打开节点的层次
 * @param {Object} value 节点值
 * @param {Object} level 
 * @return {TypeName} 
 */
function getLevel(value,level){
	if(level == null || level == "undefind"){
		level = 0;
	}
	for(var i=0;i<ystree.aNodes.length;i++){
		if(ystree.aNodes[i].id == value){
			for(var j=0;j<ystree.aNodes.length;j++){
				if(ystree.aNodes[j].id == ystree.aNodes[i].pid){
					level++;
					return getLevel(ystree.aNodes[j].id,level);
				}
			}
		}
	}
	return level;
}

/**
 * 有复选框时 点击确定按钮
 * @param {Object} type 类型 1为不能选根节点 2为只能选择最底层的子节点
 */
function doClickEnter(type){
	var chooseDepart = CropCheckBoxValueAsString(ystreecheckboxname);
	var c_ = chooseDepart.split(",");
	var id = "";
	var name = "";
	if(type == null || type == 'undefind'){
		type = 0;
	}else if(type >= 1){
		if(chooseDepart == ystree.aNodes[0].id){
			alert("不能只选择根节点！");
			return false;
		}
	}
	for(var i=0;i<c_.length;i++){
		for (var j = (type>=1?1:0); j < ystree.aNodes.length; j++) {
			if(ystree.aNodes[j].id == c_[i]){ 
				if(type == 2 && j+1<ystree.aNodes.length && ystree.aNodes[j+1].pid == ystree.aNodes[j].id){
					//不能选择有下级的节点
				}else{
					if((","+id+",").indexOf(","+ystree.aNodes[j].id+",")==-1){
						if(id!=''){
							id += ",";
							name += ",";
						}
						id += ystree.aNodes[j].id;
						name += ystree.aNodes[j].name;
					}
				}
			}
		}
	}

	var tem_valueObjid = window.dialogArguments.tem_valueObjid;
	var tem_nameObjid = window.dialogArguments.tem_nameObjid;
	window.dialogArguments.document.getElementById(tem_valueObjid).value = id;
	window.dialogArguments.document.getElementById(tem_nameObjid).value = name;
	window.close();
}
/**
 * 初始化时根据记录勾选
 * @memberOf {TypeName} 
 */
function doInit(){
	if (ystree.config.showCheckBox) {
		var tem_valueObjid = window.dialogArguments.tem_valueObjid;
		var id = window.dialogArguments.document.getElementById(tem_valueObjid);
		if(id && id.value != null && id.value !=''){
			$("input[@type='checkbox']").each(function(){
				if((','+id.value+',').indexOf(','+this.value+',')!=-1){
					this.checked = true;
					selectAllSon(this,'2');
				}
			})
		}
	}
}