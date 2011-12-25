package com.yszoe.cms.action;

import java.util.ArrayList;
import java.util.List;

import com.yszoe.cms.entity.TXxfbLm;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.sys.action.AbstractBaseActionSupport;
import com.yszoe.sys.entity.ApplicationEnum;


/**
 * 信息发布栏目管理
 * @author Yangjianliang
 * datetime 2011-6-27
 */
public class CmsSortAction extends AbstractBaseActionSupport {

	private TXxfbLm txxfbLm;

	/**
	 * @return the txxfbLm
	 */
	public TXxfbLm getTxxfbLm() {
		return txxfbLm;
	}

	/**
	 * @param txxfbLm the txxfbLm to set
	 */
	public void setTxxfbLm(TXxfbLm txxfbLm) {
		this.txxfbLm = txxfbLm;
	}
	
	public List<ApplicationEnum> getParentwids(){
//		String sql = "SELECT wid id, DECODE( NVL(LEVEL2,0),0, SUBSTR('││││││',1,LEVEL1 - 1)||'└', DECODE(LEVEL2 - LEVEL1, 0, SUBSTR('││││││',1,LEVEL1 - 1)||'├', 1,SUBSTR('││││││',1,LEVEL1 - 1)||'├', SUBSTR('││││││',1,LEVEL1 - 1)||'└' ) )||lmmc caption FROM (SELECT wid,lmmc,parentwid, LEVEL LEVEL1,LEAD(LEVEL,1) OVER (ORDER BY ROWNUM) LEVEL2 FROM t_xxfb_lm CONNECT BY parentwid=PRIOR wid START WITH parentwid='000' ORDER BY wid) ";
//		List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class);//仅支持oracle
		
		//用java实现，保证数据库兼容性
		String hql = "from TXxfbLm order by wid";
//		List<ApplicationEnum> list = getApplicationEnumService().getApplicationEnums(true, hql);
		List<TXxfbLm> list = getApplicationEnumService().getBaseDao().getHibernateTemplate().find(hql);
		
		return buildTree(list);
	}
	
	protected List<ApplicationEnum> buildTree(List<TXxfbLm> list){
		List<ApplicationEnum> tree = new ArrayList<ApplicationEnum>();
		//组成树状形式
		for(int i=0; i<list.size(); i++){
			ApplicationEnum ae = new ApplicationEnum();
			TXxfbLm lm = list.get(i);
			ae.setId(lm.getWid());
			StringBuilder mc = new StringBuilder("");
			int l = lm.getWid().length()/3 - 2;
			for(int k=0; k<l; k++){
				mc.append("│");
			}
			ae.setCaption(mc + "├" + lm.getLmmc());
			tree.add(ae);
		}
		return tree;
	}
}
