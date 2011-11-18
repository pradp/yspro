package com.yszoe.biz;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.biz.entity.TExpertqaAppealadd;
import com.yszoe.biz.entity.TExpertqaExperts;
import com.yszoe.cms.entity.TXxfbLm;
import com.yszoe.cms.entity.TXxfbWz;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.identity.entity.TSysDepart;
import com.yszoe.sys.entity.TSysCode;
import com.yszoe.sys.util.SysConfigUtil;

/**
 * 首页内容查询 将数据库信息读取出来并显示在首页
 * 
 * @author YanBing datetime 2011-8-15
 */
public class IndexPageQuery {
	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(IndexPageQuery.class);

	/**
	 * 查看文章表的数据信息，指定栏目下的。 首页展示前10条用
	 * 
	 * @param lmwid
	 * @return
	 * @throws SQLException
	 */
	public List<TXxfbWz> getTop10ArticlesByChannel(String lmwid) throws SQLException {

		return getTopArticlesByChannel(lmwid, 10);
	}

	@SuppressWarnings("unchecked")
	public List<TXxfbWz> getTopArticlesByChannel(String lmwid, int num) throws SQLException {

		String sql = "select * from (select wid, bt, syydt, zy, sftj, wzlx, bturl, zhxgrq, ordernum, "
				+ "(select lm.lmmc from t_xxfb_lm lm where lm.wid=lmwid) as fbt,"
				+ "(select lm.lmbm from t_xxfb_lm lm where lm.wid=lmwid) as lmwid from T_XXFB_WZ where T_XXFB_WZ.LMWID=?"
				+ " AND SFSYXS !='1' AND STATE=2 order by ordernum desc,wid desc) where rownum<=" + num;
		List<TXxfbWz> list = DBUtil.queryAllBeanList(sql, TXxfbWz.class, lmwid);// 读取所有信息
		return list;
	}

	/**
	 * 首页推荐导读新闻。 后台标记为首页推荐，且通过审核的最新两条
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<TXxfbWz> getTop2RecommendArticles() throws SQLException {
		String sql = "select * from (select WID,BT,ZY,BTURL,WZLX,(select lm.lmbm from t_xxfb_lm lm where lm.wid=lmwid) as lmwid from T_XXFB_WZ where "
				+ "SFSYXS='1' and STATE='2' order by wid desc) where rownum<3";
		@SuppressWarnings("unchecked")
		List<TXxfbWz> list = DBUtil.queryAllBeanList(sql, TXxfbWz.class);
		return list;
	}

	/**
	 * 首页显示用。最新的10条新闻。
	 * 不包括：头条推荐2条、品种介绍栏目、资料下载栏目、育种技术栏目
	 * @return
	 * @throws SQLException
	 */
	@Deprecated
	public List<TXxfbWz> getTop10NewArticles() throws SQLException {
		String sql = "select * from (select wid, bt, syydt, zy, sftj, wzlx, bturl, zhxgrq, ordernum, "
				+ "(select lm.lmmc from t_xxfb_lm lm where lm.wid=lmwid) as fbt, "
				+ "(select lm.lmbm from t_xxfb_lm lm where lm.wid=lmwid) as lmwid from T_XXFB_WZ where "
				+ "SFSYXS!='1' and STATE='2' and lmwid !='" + SysConfigUtil.getString("zlxzWid") + "' and lmwid !='"
				+ SysConfigUtil.getString("yzjsWid") + "' and lmwid !='" + SysConfigUtil.getString("pzjsWid") + "'" +
						" order by lmwid,zhxgrq desc) where rownum<11";
		@SuppressWarnings("unchecked")
		List<TXxfbWz> list = DBUtil.queryAllBeanList(sql, TXxfbWz.class);
		return list;
	}

	/**
	 * 在T_SYS_CODE表中查询畜种信息
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<TSysCode> tableXzQuery() {
		String sql = "select zdlb,zdbm,zdmc from T_SYS_CODE where zdlb='sort_id' and sfsy='1' order by zdbm asc";
		List<TSysCode> list2 = DBUtil.queryAllBeanList(sql, TSysCode.class);// 读取TSysCode表所有信息

		return list2;
	}

	/**
	 * 最新公布的专家答疑
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<TExpertqaAppealadd> getAnswerList() {
		String sql = "select * from (select nvl2(translate(d.writer, '\\1234567890 ', '\\'), d.writer, u.username) as appealid, t.answer, r.username as expertid, d.title as attach"
				+ " from T_EXPERTQA_APPEAL d left join T_EXPERTQA_APPEALADD t on t.appealid=d.wid left join t_sys_user r on t.expertid=r.userid left join t_sys_user u on d.writer=u.userid"
				+ " where d.ispublish = '1' order by t.dateofreply desc) where rownum <= 4";
		List<TExpertqaAppealadd> list = DBUtil.queryAllBeanList(sql, TExpertqaAppealadd.class);// 读取所有信息
		return list;
	}

	/**
	 * 答疑公布中咨询专家名称
	 */
	@SuppressWarnings("unchecked")
	public List<TExpertqaExperts> getExpertsList() throws Exception {
		String sql = "select wid,sort_id as sortId,userid,name from T_EXPERTQA_EXPERTS order by wid desc";
		List<TExpertqaExperts> list = DBUtil.queryAllBeanList(sql, TExpertqaExperts.class);
		return list;
	}

	/**
	 * 读取T_XXFB_LM表信息
	 */
	@SuppressWarnings("unchecked")
	public List<TXxfbLm> tableLmQuery(String str) {
		String sql = "select * from T_XXFB_LM where wid = ?";
		List<TXxfbLm> list = DBUtil.queryAllBeanList(sql, TXxfbLm.class, str);
		return list;
	}

	/**
	 * 种畜禽场展示信息，最新加入的10个场
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<TSysDepart> getFarmslist() throws Exception {
		String sql = "select * from (select t.departname,t.departid,t.departname_py as departnamePy, l.shsj "
				+ " from T_SYS_DEPART t,T_DEPART_DETAIL l"
				+ " where l.departid = t.departid and departtype in('1','2') and state='1'" + " order by shsj desc) where rownum <= 10 ";
		List<TSysDepart> list = DBUtil.queryAllBeanList(sql, TSysDepart.class);
		return list;
	}

	/**
	 * 查看热门文章
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<TXxfbWz> getRmlist() throws Exception {
		String sql = "select * from (select WID,BT,ZY,BTURL,WZLX,(select lm.lmbm from t_xxfb_lm lm where lm.wid=lmwid) as lmwid from T_XXFB_WZ where state='2' and lmwid !='"
				+ SysConfigUtil.getString("zlxzWid") + "' order by djs desc) where rownum<11 ";
		List<TXxfbWz> list = DBUtil.queryAllBeanList(sql, TXxfbWz.class);
		return list;
	}

	// 编辑推荐文章
	@SuppressWarnings("unchecked")
	public List<TXxfbWz> getTjlist() throws Exception {
		String sql = "select * from (select WID,BT,ZY,BTURL,WZLX,(select lm.lmbm from t_xxfb_lm lm where lm.wid=lmwid) as lmwid from T_XXFB_WZ where state='2' and sftj='1' and lmwid !='"
				+ SysConfigUtil.getString("zlxzWid") + "' order by wid desc) where rownum<10";
		List<TXxfbWz> list = DBUtil.queryAllBeanList(sql, TXxfbWz.class);
		return list;
	}

	// 读取畜种所参与的监测场
	@SuppressWarnings("unchecked")
	public List<TSysDepart> tableJccQuery(String jcc) {
		String sql = "select distinct departname,departname_Py as departnamePy from "
				+ "t_sys_depart a left join t_scjc_depart b on a.departid=b.departid "
				+ "left join t_scjc_duty c on b.dutyid=c.wid " + "where c.xz=? and rownum <= 15";
		List<TSysDepart> list = DBUtil.queryAllBeanList(sql, TSysDepart.class, jcc);// 读取TSysCode表所有信息
		return list;
	}

	/**
	 * 获取首页导航图片信息 包括导航信息和新增部门信息
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String getXxfbWzDdxw() {
		String sql = "select * from (select WID,BT,syydt,(select lm.lmbm from t_xxfb_lm lm where lm.wid=lmwid) as lmwid from t_xxfb_wz where state='2' and wzlx='3' and syydt is not null order by wid desc) where rownum<=4";
		List<TXxfbWz> list_wz = DBUtil.queryAllBeanList(sql, TXxfbWz.class);
		sql = "select * from (select a.departname,a.departname_py,b.zxqct from t_sys_depart a,t_depart_detail b"
				+ " where a.departid=b.departid and a.state='1' and a.departtype='2' and zxqct is not null order by djsj desc) where rownum<=2";
		List<Object[]> list_depart = DBUtil.queryAllList(sql);
		StringBuffer sb = new StringBuffer("[");
		int list_wz_length = list_wz.size();
		int list_depart_length = list_depart.size();
		if (list_wz_length != 0) {
			for (int i = 0; i < list_wz_length - list_depart_length; i++) {
				TXxfbWz t = list_wz.get(i);
				if (null != t)
					sb.append("{url:'/html/").append(t.getLmwid()).append("-").append(t.getWid()).append(".jhtm',title:'").append(t.getBt()).append(
							"',src:'").append(t.getSyydt()).append("'},");
			}
		}
		if (list_depart_length != 0) {
			for (int i = 0; i < list_depart_length; i++) {
				Object[] o = list_depart.get(i);
				sb.append("{url:'/farms/").append(String.valueOf(o[1])).append(".jhtm',title:'").append(
						String.valueOf(o[0])).append("',src:'").append(String.valueOf(o[2])).append("'},");
			}
		}
		sb.setCharAt(sb.toString().length() - 1, ']');
		if (sb.toString().length() == 1) {
			return "[]";
		}
		return sb.toString();
	}
}
