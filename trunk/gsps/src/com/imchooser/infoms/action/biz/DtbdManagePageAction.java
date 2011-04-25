package com.imchooser.infoms.action.biz;

import java.util.ArrayList;
import java.util.List;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TDtbdCreatetable;
import com.imchooser.infoms.entity.biz.TDtbdCreatetableFieldinfo;
import com.imchooser.infoms.service.biz.DTBDManagePageService;

/**
 * 动态表单管理员Action
 * @author Administrator
 *
 */
@SuppressWarnings("serial")
public class DtbdManagePageAction extends BaseActionAbstractSupport {	
	private TDtbdCreatetable tableInfo;
	private List<TDtbdCreatetableFieldinfo> listField=new ArrayList<TDtbdCreatetableFieldinfo>();	
	
	public void configFiledIn(){
		DTBDManagePageService service=(DTBDManagePageService)this.getBaseService();
		service.saveconfigFiledIn(this);
	}
	
	public TDtbdCreatetable getTableInfo() {
		return tableInfo;
	}
	public void setTableInfo(TDtbdCreatetable tableInfo) {
		this.tableInfo = tableInfo;
	}	
	public List<TDtbdCreatetableFieldinfo> getListField() {
		return listField;
	}
	public void setListField(List<TDtbdCreatetableFieldinfo> listField) {
		this.listField = listField;
	}
	
}
