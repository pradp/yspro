package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportSsrc;
import com.imchooser.infoms.service.biz.impl.SportSsrcServiceImpl;

/*
 **赛事日程
 * 
 * @author DaiQinggao
 * @date 2010-03-24
 */
@SuppressWarnings("serial")
public class SportSsrcAction extends SportBsxmAction {

	private TSportSsrc tsportSsrc;
	private TSportBsxm tsportBsxm;

	public TSportSsrc getTsportSsrc() {
		return tsportSsrc;
	}

	public void setTsportSsrc(TSportSsrc tsportSsrc) {
		this.tsportSsrc = tsportSsrc;
	}

	public TSportBsxm getTsportBsxm() {
		return tsportBsxm;
	}

	public void setTsportBsxm(TSportBsxm tsportBsxm) {
		this.tsportBsxm = tsportBsxm;
	}

	/**批量修改赛程阶段
	 * 
	 * @return
	 * @throws Exception
	 */
	public String xmjdsz() throws Exception {
		return "xmjdsz";
	}

	public String submitXmjdsz() throws Exception {
		SportSsrcServiceImpl service = (SportSsrcServiceImpl) getBaseService();
		try{
			service.submitXmjdsz(this);
		}catch(Exception e){
			addActionError(e.getMessage());
		}
		return "submitXmjdsz";
	}
}
