package com.imchooser.infoms.action.biz;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.util.DBUtil;
import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportYdybmxmCc;
import com.imchooser.infoms.entity.sys.ApplicationEnum;

/**
 * 运动员一次报名
 * 
 * @author WangJunjun DateTime 2010-7-30
 */
@SuppressWarnings("serial")
public class SportYdybmxmCcGLAction extends BaseActionAbstractSupport {

	private TSportYdybmxmCc tsportYdybmxmCc;
	private String xm;
	public TSportYdybmxmCc getTsportYdybmxmCc() {
		return tsportYdybmxmCc;
	}

	public void setTsportYdybmxmCc(TSportYdybmxmCc tsportYdybmxmCc) {
		this.tsportYdybmxmCc = tsportYdybmxmCc;
	}

	public String getXm() {
		return xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}


	public List<ApplicationEnum> getMyDxmmc() throws UnsupportedEncodingException{
		String ydybm = this.getTsportYdybmxmCc().getYdywid();
		String dxmmc = this.getTsportYdybmxmCc().getDxmmc();
		String sql = " select distinct(c.dxmmc) from  T_Sport_Ydybmxm_Cc c where c.ydywid=? and c.dxmmc is not null";
		List<Object[]> listdxm = DBUtil.queryAllList(sql, ydybm);
		List<ApplicationEnum> list_dxmmc = new ArrayList<ApplicationEnum>();
		if (!listdxm.isEmpty()) {
			if (StringUtils.isBlank(dxmmc)) {
				dxmmc = String.valueOf(listdxm.get(0)[0]);
			}
			for (Object[] cc : listdxm) {
				ApplicationEnum applicationEnum = new ApplicationEnum();
				applicationEnum.setId(String.valueOf(cc[0]));
				applicationEnum.setCaption(java.net.URLDecoder.decode(String.valueOf(cc[0]), "utf-8"));
				list_dxmmc.add(applicationEnum);
			}
		}
		return list_dxmmc;
	}
	
	/**
	 * 获得所有大项目名称Map
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> getAllXxmmcMap() {
		Map<String, String> mapXxmmc = new HashMap<String, String>();
			String dxmmc = this.getTsportYdybmxmCc().getDxmmc();
			String bsxmwid = this.getTsportYdybmxmCc().getBsxmwid1();
			String zb = this.getTsportYdybmxmCc().getZbbm();
			String xb = this.getTsportYdybmxmCc().getXbbm();
			if(StringUtils.isNotBlank(dxmmc) && StringUtils.isNotBlank(bsxmwid)&& StringUtils.isNotBlank(zb)&& StringUtils.isNotBlank(xb)){
				String hql = "select new ApplicationEnum(a.wid,a.xxmmc ) from TSportBsxm a where a.dxmmc=? " +
						" and (a.zb= ?)" +
						" and (a.xbz=? or a.xbz='3' or a.xbz is null)" +
						" group by a.xxmmc,a.wid order by length(a.xxmmc)";
				List<ApplicationEnum> list_xxmmc2 = applicationEnumService.getBaseDao().findByHql(hql,dxmmc,zb,xb);
				if (list_xxmmc2 != null) {
					for (ApplicationEnum app : list_xxmmc2) {
						mapXxmmc.put(app.getId(), app.getCaption());
					}
					return mapXxmmc;
				} else {
					return Collections.EMPTY_MAP;
				}
			}
			return Collections.EMPTY_MAP;
	}
}
