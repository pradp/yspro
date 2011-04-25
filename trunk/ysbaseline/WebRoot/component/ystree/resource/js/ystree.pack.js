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
    
        str += '<a id="node_' + node.id + '" class="' + ((this.config.useSelection) ? ((node._is ? 'nodeSel' : 'node')) : 'node') + '" href="' + node.url + '"';
        
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
            str += '<a id="node_' + node.id + '" href="javascript: ' + this.obj + '.s(' + nodeId + ');" class="node">';
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
        
            str += '<a href="javascript: ' + this.obj + '.o(' + nodeId + ');"><img id="j' + this.obj + nodeId + '" src="';
            
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
        
        eIcon.src = (status) ? this.aNodes[id].iconOpen : this.aNodes[id].icon;
        
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
 * valueContainerId : 存放checkbox值的input控件的ID
 */
function resetValue(obj){
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

	if(parent.document.getElementById("menues")){
		var menues = parent.document.getElementById("menues").value;
		if(obj.checked == true){
			if(obj.value.length==6){
				var checkedid = obj.id;
				for(var i=c.length-1;i>=0;i--){
					if(c[i].id.indexOf(checkedid)==0){
					//说明该节点是被点节点的子孙节点
						menues += ","+c[i].value;
					}
				}
			}else{
				if(menues.indexOf(obj.value.substring(0,6)+",")==-1){
					menues += ","+obj.value.substring(0,6);
				}
			}
			var strs = menues + "," + obj.value;
			if(strs.indexOf(",")==0){
				parent.document.getElementById("menues").value = strs.substring(1,strs.length);
			}else{
				parent.document.getElementById("menues").value = strs;
			}
		}else{
			var m = "";
			var menue = menues.split(",");
			for(var i=0;i<menue.length;i++){
				menue[i] = menue[i].replace(/(^\s*)|(\s*$)/g, "");  
				if(obj.value.length==6){
					if(menue[i].substring(0,6)!=obj.value){
						//说明该节点是被点节点的子孙节点
						if(i!=0 && m!='')
							m += ",";
						m +=  menue[i];
					}
				}else{
					if(menue[i]!="" && menue[i]!=obj.value){
						if(i!=0 && m!='')
							m += ",";
						m +=  menue[i];
					}
				}
			}
			parent.document.getElementById("menues").value = m;
		}
	}
}

/**
 * 控制是否要选中和被点节点相关的一些节点，比如子节点，父节点
 * @param {Object} obj
 */
function selectAllSon(obj){
	var checkedid = obj.id;
	var c = document.getElementsByName(ystreecheckboxname);
	for(var i=c.length-1;i>=0;i--){
		if(c[i].id == checkedid){
		//说明该节点和被点节点是同级
		
		}else if(c[i].id.indexOf(checkedid)==0){
		//说明该节点是被点节点的子孙节点
			c[i].checked = obj.checked;
		}else if(checkedid.indexOf( c[i].id )==0){
		//说明该节点是被点节点的祖先节点
		//alert(c[i].id);
		//以下注释掉。因为权限菜单需求中，父节点可以被单独选中
			/*
			if(isMySonAllSelected( c[i].id )){
				c[i].checked = true;
			}else{
				c[i].checked = false;
			}
			*/
			if(obj.checked){
				c[i].checked = true;
			}
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
 * @return void
 */
YsTree.prototype.createChildNode = function(treedata, index){
	if(treedata!=null && treedata!="[]"){
		var jsonarray=eval("("+treedata+")");
        var node = "";
        var currentIndex = this.aNodes.length-1;
        for(var i=0;i<jsonarray.length;i++){
        	 var obj = jsonarray[i];
             currentIndex += 1;
             this.add(obj.id,obj.pid,obj.name,obj.url,true); 
             var divinner="";
             if(this.config.showCheckBox){
              	divinner="<div class='ysTreeNode'><img src='resource/images/style1/line.gif'/>"
                      +"<img alt='' src='resource/images/style1/join.gif'/>"
                      +"<input id='checkbox_"+obj.id+"' type='checkbox' onclick='resetValue(this)' value='"+obj.id+"' name='ystreeCheckBoxName'/>"
                      +"<img id='iystree"+currentIndex+"' src='resource/images/style1/page.gif'/>"
                      +"<label id='node_"+obj.id+"' class='nodeSel' style='cursor: pointer;' onclick='ystree.s("+currentIndex+");' for='checkbox_"+obj.id+"'>"+obj.name+"</label>"
                      +"</div>";
                 
             }else{
              	divinner="<div class='ysTreeNode'><img src='resource/images/style1/line.gif'/>"
                      +"<img alt='' src='resource/images/style1/join.gif'/><img id='iystree"+currentIndex+"' src='resource/images/style1/page.gif'/>"
                      +"<a id='node_"+obj.id+"' class='node' href='javascript: ystree.s("+currentIndex+")';>"+obj.name+"</a>"
                      +"</div>";
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
               +"<a id='node_"+nd.id+"' class='nodeSel' href='javascript: ystree.s("+index+");'>"+nd.name+"</a>";
           }
           document.getElementById("iystree"+index).parentElement.innerHTML = text;//把文件夹变成文件的形式
           //document.getElementById("dystree"+index).innerHTML="";此用法会使层拉开距离
           document.getElementById("dystree"+index).style.display="none";
          
       }
}
