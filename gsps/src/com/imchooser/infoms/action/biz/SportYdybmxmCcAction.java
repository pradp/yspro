package com.imchooser.infoms.action.biz;

import java.io.UnsupportedEncodingException;
import java.util.Collections;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.util.DBUtil;
import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportYdybmxm;
import com.imchooser.infoms.entity.biz.TSportYdybmxmCc;
import com.imchooser.infoms.entity.biz.TSportYdyxx;
import com.imchooser.infoms.entity.sys.ApplicationEnum;
import com.imchooser.infoms.service.biz.impl.SportYdybmxmCcServiceImpl;

/**
 * 运动员二次报名(按人)
 * 
 * @author LiBing DateTime 2010-7-4
 */
@SuppressWarnings("serial")
public class SportYdybmxmCcAction extends BaseActionAbstractSupport {

	private static final Log LOG = LogFactory.getLog(SportYdybmxmCcAction.class);
	
	private TSportYdybmxmCc tsportYdybmxmCc;
	private TSportBsxm tsportBsxm;
	private TSportYdybmxm tsportYdybmxm;
	private TSportYdyxx tsportYdyxx;

	public TSportYdybmxmCc getTsportYdybmxmCc() {
		return tsportYdybmxmCc;
	}

	public void setTsportYdybmxmCc(TSportYdybmxmCc tsportYdybmxmCc) {
		this.tsportYdybmxmCc = tsportYdybmxmCc;
	}

	public TSportBsxm getTsportBsxm() {
		return tsportBsxm;
	}

	public void setTsportBsxm(TSportBsxm tsportBsxm) {
		this.tsportBsxm = tsportBsxm;
	}

	public TSportYdybmxm getTsportYdybmxm() {
		return tsportYdybmxm;
	}

	public void setTsportYdybmxm(TSportYdybmxm tsportYdybmxm) {
		this.tsportYdybmxm = tsportYdybmxm;
	}

	public TSportYdyxx getTsportYdyxx() {
		return tsportYdyxx;
	}

	public void setTsportYdyxx(TSportYdyxx tsportYdyxx) {
		this.tsportYdyxx = tsportYdyxx;
	}

	public String saveList2(){      //手动调用list页面
		SportYdybmxmCcServiceImpl service = (SportYdybmxmCcServiceImpl) getBaseService();
		try {
			service.saveOrUpdate(this);
			List<?> list = service.list(this, this.getPager());
			this.setResultData(list);
		} catch (Exception e) {
			addActionError(e.getMessage());
		}
		return "list";
	}
	/**
	 * 打印二次报名信息
	 */
	public String printRcbm() throws Exception {
		SportYdybmxmCcServiceImpl service = (SportYdybmxmCcServiceImpl) getBaseService();
		try {
			service.printRcbm(this);
		} catch (Exception e) {
			addActionError(e.getMessage());
		}
		return "printRcbm";
	}

	/**
	 * 得到代表团名称
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getDbd() throws Exception {
		String sql = "select a.areaid as id,a.areaname as caption from t_sys_area a where 1=1 and a.arealevel='2'";
		List<ApplicationEnum> list = (List<ApplicationEnum>) DBUtil.queryAllBeanList(sql, ApplicationEnum.class);
		return list;
	}

	/**
	 * input页面的大项目名称与list页面关联
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getYdyDxmmc() throws Exception {
		String hql = "select new ApplicationEnum(t.dxmmc,t.dxmmc) from TSportYdybmxmCc t where t.ydywid=? group by t.dxmmc ";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql, this.getWid());
		if (list != null && list.size() > 0) {
			try {
				for (ApplicationEnum app : list) {
					app.setId(java.net.URLEncoder.encode(app.getId(), "UTF-8"));
				}
			} catch (UnsupportedEncodingException e) {
				LOG.error(e);
			}
			return list;
		} else {
			return Collections.EMPTY_LIST;
		}
	}

}
