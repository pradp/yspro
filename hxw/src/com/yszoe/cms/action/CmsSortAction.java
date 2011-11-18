package com.yszoe.cms.action;

import java.util.List;

import com.yszoe.cms.entity.TXxfbLm;
import com.yszoe.sys.action.AbstractBaseActionSupport;
import com.yszoe.sys.entity.ApplicationEnum;


/**
 * 信息发布栏目管理
 * @author Yangjianliang
 * datetime 2011-6-27
 */
public class CmsSortAction extends AbstractBaseActionSupport {

	private TXxfbLm txxfbLm;

	/**
	 * @return the txxfbLm
	 */
	public TXxfbLm getTxxfbLm() {
		return txxfbLm;
	}

	/**
	 * @param txxfbLm the txxfbLm to set
	 */
	public void setTxxfbLm(TXxfbLm txxfbLm) {
		this.txxfbLm = txxfbLm;
	}
	
	public List<ApplicationEnum> getParentwids(){
		String hql = "select new ApplicationEnum(wid, lmmc) from TXxfbLm where parentwid is null";
		List<ApplicationEnum> list = getApplicationEnumService().getApplicationEnums(true, hql);
		return list;
	}
}
