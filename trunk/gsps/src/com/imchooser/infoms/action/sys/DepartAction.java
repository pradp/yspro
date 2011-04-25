
package com.imchooser.infoms.action.sys;

import java.util.List;

import com.imchooser.framework.identity.entity.TSysDepart;
import com.imchooser.infoms.entity.sys.TDepartDetail;
import com.imchooser.infoms.service.sys.impl.DepartServiceImpl;

@SuppressWarnings("serial")
public class DepartAction extends BaseActionAbstractSupport {

	private TSysDepart tsysDepart;
	private String updepartid;
	private String updepartname;
	private String todepartid;
	private String fromdepartid;
	private TDepartDetail departDetail;
	private String successFlag;
	public String getSuccessFlag() {
		return successFlag;
	}

	public void setSuccessFlag(String successFlag) {
		this.successFlag = successFlag;
	}

	public TDepartDetail getDepartDetail() {
		return departDetail;
	}

	public void setDepartDetail(TDepartDetail departDetail) {
		this.departDetail = departDetail;
	}

	public TSysDepart getTsysDepart() {
		return tsysDepart;
	}

	public void setTsysDepart(TSysDepart tsysDepart) {
		this.tsysDepart = tsysDepart;
	}

	public String departTree(){
		return SUCCESS;
	}

	public String selectDepart() throws Exception{
		DepartServiceImpl base = (DepartServiceImpl)getBaseService();
		List<?> list = base.selectDeparts(this,this.getPager());
		this.setResultData(list);
		return SUCCESS;
	}
	
	public String mergeDepart(){
		//SxDksqbService service = (SxDksqbService)getBaseService();
		return SUCCESS;
	}

	public String checkusertype(){
		//SxDksqbService service = (SxDksqbService)getBaseService();
		return SUCCESS;
	}
	
	public void search() throws Exception{
		DepartServiceImpl base=(DepartServiceImpl)getBaseService();
		List<?> list = base.search(this,this.getPager());
		this.setResultData(list);
	}
	
	public void departdetail() throws Exception{
		DepartServiceImpl base=(DepartServiceImpl)getBaseService();
		base.departdetail(this);
	}
	
	public String getUpdepartname() {
		return updepartname;
	}

	public void setUpdepartname(String updepartname) {
		this.updepartname = updepartname;
	}

	public String getUpdepartid() {
		return updepartid;
	}

	public void setUpdepartid(String updepartid) {
		this.updepartid = updepartid;
	}

	public String getTodepartid() {
		return todepartid;
	}

	public void setTodepartid(String todepartid) {
		this.todepartid = todepartid;
	}

	public String getFromdepartid() {
		return fromdepartid;
	}

	public void setFromdepartid(String fromdepartid) {
		this.fromdepartid = fromdepartid;
	}
}
