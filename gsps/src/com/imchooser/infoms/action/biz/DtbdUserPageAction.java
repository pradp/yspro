package com.imchooser.infoms.action.biz;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.imchooser.framework.util.DBUtil;
import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TDtbdCreatetable;
import com.imchooser.infoms.entity.biz.TDtbdCreatetableFieldinfo;
import com.imchooser.infoms.entity.sys.ApplicationEnum;

/**
 * 动态表单用户Action
 * @author wangjunjun
 *
 */
@SuppressWarnings("serial")
public class DtbdUserPageAction extends BaseActionAbstractSupport{
	private TDtbdCreatetable dtbdTable; 
	private TDtbdCreatetableFieldinfo dtbdFieldInfo;
	private Map<String, String> map_total;
	List<TDtbdCreatetableFieldinfo> list_DTBDFieldInfo_Select;
	List<TDtbdCreatetableFieldinfo> list_DTBDFieldInfo_TableHead;
	private String s_nd; //界面搜索年度
	private String tableName; //表名
	private String bbnd; //报表年度
	private String bbyf; //报表月份
	public TDtbdCreatetable getDtbdTable() {
		return dtbdTable;
	}
	public void setDtbdTable(TDtbdCreatetable dtbdTable) {
		this.dtbdTable = dtbdTable;
	}
	public TDtbdCreatetableFieldinfo getDtbdFieldInfo() {
		return dtbdFieldInfo;
	}
	public void setDtbdFieldInfo(TDtbdCreatetableFieldinfo dtbdFieldInfo) {
		this.dtbdFieldInfo = dtbdFieldInfo;
	}
	public Map<String, String> getMap_total() {
		return map_total;
	}
	public void setMap_total(Map<String, String> mapTotal) {
		map_total = mapTotal;
	}
	public List<TDtbdCreatetableFieldinfo> getList_DTBDFieldInfo_Select() {
		return list_DTBDFieldInfo_Select;
	}
	public void setList_DTBDFieldInfo_Select(List<TDtbdCreatetableFieldinfo> listDTBDFieldInfoSelect) {
		list_DTBDFieldInfo_Select = listDTBDFieldInfoSelect;
	}
	public List<TDtbdCreatetableFieldinfo> getList_DTBDFieldInfo_TableHead() {
		return list_DTBDFieldInfo_TableHead;
	}
	public void setList_DTBDFieldInfo_TableHead(List<TDtbdCreatetableFieldinfo> listDTBDFieldInfoTableHead) {
		list_DTBDFieldInfo_TableHead = listDTBDFieldInfoTableHead;
	}
	public String getS_nd() {
		return s_nd;
	}
	public void setS_nd(String sNd) {
		s_nd = sNd;
	}

	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getNd(String tableName,String type,String romait) {
		if(!type.equals(romait)){
			tableName = tableName+"_HZ";
		}
		String sql = "select bbnd as id, bbnd as caption from "+tableName+" group by bbnd order by bbnd desc";
		List<ApplicationEnum> list  = DBUtil.queryAllBeanList(sql, ApplicationEnum.class);
		ApplicationEnum a = new ApplicationEnum();
		
		a.setId("");
		a.setCaption("--请选择--");
		if(list!=null && list.size()>0){
			list.add(0, a);
		}else{
			list = new  ArrayList<ApplicationEnum>();
			list.add(0,a);
		}
		return list;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getBbnd() {
		return bbnd;
	}
	public void setBbnd(String bbnd) {
		this.bbnd = bbnd;
	}
	public String getBbyf() {
		return bbyf;
	}
	public void setBbyf(String bbyf) {
		this.bbyf = bbyf;
	}
}
