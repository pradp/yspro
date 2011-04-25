package com.imchooser.infoms.action.biz;

import java.util.List;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportCjJt;
import com.imchooser.infoms.entity.biz.TSportCjYdy;
import com.imchooser.infoms.entity.biz.TSportSsrc;
import com.imchooser.infoms.service.biz.impl.SportCjYdyServiceImpl;

/*
 * * 运动员成绩表
 * 
 * @author WangJunjun
 * 
 * @date:2010-3-24
 */
@SuppressWarnings("serial")
public class SportCjYdyAction extends BaseActionAbstractSupport {

	private TSportCjYdy sportCjYdy;
	private TSportSsrc sportSsrc;
	private List<TSportCjYdy> listSportCjYdy;
	private TSportBsxm sportBsxm;
	private List<TSportCjJt> jts;
	private String selectDbt;
	public TSportCjYdy getSportCjYdy() {
		return sportCjYdy;
	}

	public void setSportCjYdy(TSportCjYdy sportCjYdy) {
		this.sportCjYdy = sportCjYdy;
	}

	
	public TSportSsrc getSportSsrc() {
		return sportSsrc;
	}

	public void setSportSsrc(TSportSsrc sportSsrc) {
		this.sportSsrc = sportSsrc;
	}

	public List<TSportCjYdy> getListSportCjYdy() {
		return listSportCjYdy;
	}

	public void setListSportCjYdy(List<TSportCjYdy> listSportCjYdy) {
		this.listSportCjYdy = listSportCjYdy;
	}

	public TSportBsxm getSportBsxm() {
		return sportBsxm;
	}

	public void setSportBsxm(TSportBsxm sportBsxm) {
		this.sportBsxm = sportBsxm;
	}
	
	

	public List<TSportCjJt> getJts() {
		return jts;
	}

	public void setJts(List<TSportCjJt> jts) {
		this.jts = jts;
	}


	public String getSelectDbt() {
		return selectDbt;
	}

	public void setSelectDbt(String selectDbt) {
		this.selectDbt = selectDbt;
	}

	public String  xzcsz(){
		SportCjYdyServiceImpl service = (SportCjYdyServiceImpl) getBaseService();
		try {
			service.xzcsz(this, this.getPager());
		} catch (Exception e) {
			addActionError(e.getMessage());
		}
		return "xzcsz";
	}
	
	/*
	 * 审核意见 备注 信息
	 */
	public String  shyj(){
		SportCjYdyServiceImpl service = (SportCjYdyServiceImpl) getBaseService();
		this.setParameter("shzt", this.getParameter("shzt"));
		this.setParameter("scbm", this.getParameter("scbm"));
		this.setParameter("isjtxm", this.getParameter("isjtxm"));
		try {
			service.shyj(this);
		} catch (Exception e) {
			addActionError(e.getMessage());
		}
		return "shyj";
	}
}
