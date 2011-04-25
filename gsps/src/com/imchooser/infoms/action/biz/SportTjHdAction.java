package com.imchooser.infoms.action.biz;

import java.sql.SQLException;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportCjTdMx;
import com.imchooser.infoms.service.biz.impl.SportTjHdServiceImpl;

/**
 * 统计核对
 * @author Wangjunjun 2010-7-19
 */
@SuppressWarnings("serial")
public class SportTjHdAction extends BaseActionAbstractSupport  {
	private TSportCjTdMx cjTdMx;

	public TSportCjTdMx getCjTdMx() {
		return cjTdMx;
	}

	public void setCjTdMx(TSportCjTdMx cjTdMx) {
		this.cjTdMx = cjTdMx;
	}
	
	public String rsZs() throws SQLException{
		SportTjHdServiceImpl service = (SportTjHdServiceImpl) getBaseService();
			service.rsZs(this,this.getPager());
		return "rsZs";
	}
}
