package com.yszoe.sys.entity;

/**
 * 按钮对象
 * @author Yangjianliang
 * datetime 2009-10-26
 */
public class TSysButton {

	private int buttonIndex;
	
	private String buttonName;

	public TSysButton() {
		super();
	}

	public TSysButton(int buttonIndex, String buttonName) {
		super();
		this.buttonIndex = buttonIndex;
		this.buttonName = buttonName;
	}

	public int getButtonIndex() {
		return buttonIndex;
	}

	public void setButtonIndex(int buttonIndex) {
		this.buttonIndex = buttonIndex;
	}

	public String getButtonName() {
		return buttonName;
	}

	public void setButtonName(String buttonName) {
		this.buttonName = buttonName;
	}
	
	
}
