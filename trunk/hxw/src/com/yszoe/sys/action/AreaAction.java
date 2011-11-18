
package com.yszoe.sys.action;

import com.yszoe.sys.entity.TSysArea;

@SuppressWarnings("serial")
public class AreaAction extends AbstractBaseActionSupport {

	private TSysArea tsysArea;
	
	private boolean isEditSelf;
	
	private boolean showCheckBox;

	/**
	 * action method
	 * 供其他地方选择区域时调用
	 * @return
	 */
	public String areaTree(){
		return toView("areaTree.jsp");
	}

	/**
	 * action method
	 * 供其他地方选择区域时调用
	 * @return
	 */
	public String treeFrame(){
		return toView("treeFrame.jsp");
	}

	public TSysArea getTsysArea() {
		return tsysArea;
	}

	public void setTsysArea(TSysArea tsysArea) {
		this.tsysArea = tsysArea;
	}

	public boolean isEditSelf() {
		return isEditSelf;
	}

	public void setEditSelf(boolean isEditSelf) {
		this.isEditSelf = isEditSelf;
	}

	public boolean isShowCheckBox() {
		return showCheckBox;
	}

	public void setShowCheckBox(boolean showCheckBox) {
		this.showCheckBox = showCheckBox;
	}

}
