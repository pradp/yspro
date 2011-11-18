/***********************************************************
 * 
 * 说 明：按钮字典查看、保存处理
 * 作 者：yangjianliang
 * 日 期：2011-5-1
 *
 **********************************************************/
package com.yszoe.identity.action;

import com.yszoe.identity.entity.TSysButton;
import com.yszoe.sys.action.AbstractBaseActionSupport;

public class IdButtonAction extends AbstractBaseActionSupport {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private TSysButton tsysButton;

	/**
	 * @return the tsysButton
	 */
	public TSysButton getTsysButton() {
		return tsysButton;
	}

	/**
	 * @param tsysButton the tsysButton to set
	 */
	public void setTsysButton(TSysButton tsysButton) {
		this.tsysButton = tsysButton;
	}

}
