package com.yszoe.cms.service.impl;

import java.util.List;

import com.yszoe.cms.action.CmsSortAction;
import com.yszoe.cms.entity.TXxfbLm;
import com.yszoe.cms.util.CachedQuery;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.util.Char2spell;
import com.yszoe.util.StringUtil;

/**
 * 信息发布栏目管理
 * @author Yangjianliang
 * datetime 2011-6-27
 */
public class CmsSortServiceImpl extends AbstractBaseServiceSupport {

//	private static final Log LOG = LogFactory.getLog(CmsSortServiceImpl.class);

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	public List<?> list(Object arg0, Pager pager) throws Exception {
//		CmsSortAction action = (CmsSortAction)arg0;
		String hql = "from TXxfbLm a ";
		long c = getBaseDao().count("select count(*) as c " + hql);
		pager.setTotalRows(c);
		String hqlCol = "select new TXxfbLm(wid, lmmc, " +
				"(select zdmc from TSysCode where zdbm=a.state and zdlb='qyyf') as state, parentwid, " +
				"(select zdmc from TSysCode where zdbm=a.zcrss and zdlb='BOOLEAN') as zcrss, " +
				"(select zdmc from TSysCode where zdbm=a.yxwygg and zdlb='BOOLEAN') as yxwygg, memo, " +
				"(select zdmc from TSysCode where zdbm=a.sfpl and zdlb='xxfb_plqx') as sfpl, ordernum, " +
				"lmbm, (select count(*) from TXxfbWz where lmwid=a.wid) as children) ";  
		hql = hqlCol + hql +" order by a.wid";
		List<TXxfbLm> list = getBaseDao().findByHql(hql);
		return list;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	public void load(Object arg0) throws Exception {
		CmsSortAction action = (CmsSortAction)arg0;

		String wid = action.getWid();
		TXxfbLm bean = getBaseDao().findById(TXxfbLm.class, wid);
		action.setTxxfbLm(bean);
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#remove(java.lang.Object)
	 */
	public boolean remove(Object arg0) throws Exception {
		CmsSortAction action = (CmsSortAction)arg0;
		String wid = action.getWid();
		long c = getBaseDao().count("select count(*) from TXxfbWz where lmwid like ?", wid+"%");
		if(c>0){
			throw new Exception("删除失败：该栏目下存在文章，请先删除这些文章。");
		}
		boolean hql = getBaseDao().deleteAll("TXxfbLm", "wid", "=", wid);
		return hql;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	public void saveOrUpdate(Object arg0) throws Exception {
		CmsSortAction action = (CmsSortAction)arg0;

		TXxfbLm txxfbLm = action.getTxxfbLm();
		if(StringUtil.isBlank(txxfbLm.getWid())){
			//do insert
			if( StringUtil.isNotBlank(txxfbLm.getLmmc()) && StringUtil.isBlank(txxfbLm.getLmbm()) ){
				txxfbLm.setLmbm( Char2spell.getPYString(txxfbLm.getLmmc()) );
			}
			if(StringUtil.isBlank(txxfbLm.getParentwid())){
				txxfbLm.setParentwid("000");//默认根编码
			}
			txxfbLm.setWid(getNewLmwid(txxfbLm.getParentwid()));
			getBaseDao().save(txxfbLm);
		}else{
			//do update
			getBaseDao().updateNotNull(txxfbLm);
		}
		CachedQuery.refreshedCmsChannels();//刷新栏目缓存
	}


	/**
	 * 根据上级编号自动生成新编号
	 * 
	 * @param parentQueryid 上级号
	 * @return
	 */
	public final String getNewLmwid(String parentQueryid) {

		String ResultID = null;
		String hql = " select substr(max(wid)," + (parentQueryid.length() + 1)
				+ ") from TXxfbLm where parentwid='" + parentQueryid + "' ";
		Object tmp = null;
		tmp = getBaseDao().findFieldValue(hql);

		if (tmp == null) {
			ResultID = parentQueryid + "001";
		} else {
			ResultID = "00" + (Integer.parseInt(tmp.toString()) + 1);
			ResultID = parentQueryid + ResultID.substring(ResultID.length() - 3);
		}

		return ResultID;
	}

}
