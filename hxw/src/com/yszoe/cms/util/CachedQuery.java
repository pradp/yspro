package com.yszoe.cms.util;

import java.util.Collections;
import java.util.List;

import com.yszoe.cms.entity.TXxfbLm;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.util.StringUtil;

/**
 * 支持缓存的查询
 * 实现缓存与数据库数据自动同步
 * @author Yangjianliang
 * datetime 2011-8-2
 */
public class CachedQuery {

//	private static final Log LOG = LogFactory.getLog(CachedQuery.class);
	
	private static List<TXxfbLm> lms = Collections.emptyList();

	public static final List<TXxfbLm> getCmsChannels(){
		if(lms.isEmpty()){
		    lms = refreshedCmsChannels();
		}
	    return lms;
	}

	@SuppressWarnings("unchecked")
	public static final List<TXxfbLm> refreshedCmsChannels(){
	    String sql = "select wid, lmmc, lmbm from t_xxfb_lm where state=1 order by ordernum, wid";
	    lms = (List<TXxfbLm>)DBUtil.queryAllBeanList(sql, TXxfbLm.class);
	    return lms;
	}

	/**
	 * 根据栏目别名取得栏目的索引
	 * @param lmbm
	 * @return 不存在的话，返回 null
	 */
	public static final String getCmsChannelIdByLmbm(String lmbm){
		if(lms.isEmpty() || StringUtil.isBlank(lmbm)){
		    lms = refreshedCmsChannels();
		}
		for(TXxfbLm lm : lms){
			if(lmbm.equals(lm.getLmbm())){
				return lm.getWid();
			}
		}
	    return null;
	}

}
