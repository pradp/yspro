package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportDrcjbAction;
import com.imchooser.infoms.entity.biz.TSportDrcjb;

/** 
 * 带入成绩
 * 
 * @author ChenLihong
 * 
 * @date:2010-3-18
 */
public class SportDrcjbServiceImpl extends BaseServiceAbstractSupport {

	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(SportDrcjbServiceImpl.class);

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportDrcjbAction action = (SportDrcjbAction) myaction;
		TSportDrcjb tsportDrcjb = action.getTsportDrcjb();
		//System.out.println("登录人所属部门：==" + action.getDepart().getDepartid());
		String hqlcolumn = "select new  TSportDrcjb( s.wid,s.djjydh,s.scbm, "
				+ " (select d.departname from TSysDepart d where d.departid=s.yddbm) as  yddbm,"
				+ " s.aydrjps,s.aydryps,s.aydrtps,(s.aydrjps+s.aydryps+s.aydrtps ) as aydrzf ," 
				+ " s.qydrjps,s.qydryps,s.qydrtps,(s.qydrjps+s.qydryps+s.qydrtps) as qydrzf,"
				+ " s.sszsdrjps,s.sszsdryps,s.sszsdrtbs,(s.sszsdrjps+s.sszsdryps+s.sszsdrtbs) as sszsdrzf,"
				+ " s.zjdrjps,s.zjdryps,s.zjdrtps,(s.zjdrjps+s.zjdryps+s.zjdrtps) as zjdrzf)";
		String hql = "  from TSportDrcjb  s  where  s.yddbm  like ?";
		if (tsportDrcjb != null) {
			if (tsportDrcjb.getYddbm() != null && !"".equals(tsportDrcjb.getYddbm())) {
				 hql += " and s.yddbm  in (select departid from TSysDepart where departname like '%" + tsportDrcjb.getYddbm() + "%') ";
			}
		}
		String depid = action.getDepartID();
		long c = getBaseDao().count("select count(*) as c " + hql, depid + "%");
		hql = hqlcolumn + hql + "  order by s.wid desc ";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager, depid + "%");
		return list;
	}

	public void load(Object arg0) throws Exception {
		// TODO Auto-generated method stub

	}

	public boolean remove(Object arg0) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {
		// TODO Auto-generated method stub

	}

}
