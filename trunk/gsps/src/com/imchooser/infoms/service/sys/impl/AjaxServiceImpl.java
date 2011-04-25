package com.imchooser.infoms.service.sys.impl;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Transaction;

import uk.ltd.getahead.dwr.WebContextFactory;

import com.imchooser.framework.dao.BaseDao;
import com.imchooser.framework.identity.IdConstants;
import com.imchooser.framework.identity.entity.LoginUserVO;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.entity.biz.TSportCjJt;
import com.imchooser.infoms.entity.biz.TSportCjYdy;
import com.imchooser.infoms.entity.biz.TSportYdybmxm;
import com.imchooser.infoms.entity.sys.ApplicationEnum;
import com.imchooser.infoms.entity.sys.TSysMessageGxqf;
import com.imchooser.infoms.service.sys.AjaxService;
import com.imchooser.infoms.util.BusinessLogUtil;
import com.imchooser.infoms.util.CommonQuery;
import com.imchooser.infoms.util.GenAllStaticHtml;
import com.imchooser.infoms.util.PropConfigUtil;
import com.imchooser.infoms.util.SQLConfigUtil;
import com.imchooser.infoms.util.excel.ExcelDBUtil;
import com.imchooser.util.StringUtil;

/**
 * 提供客户端用JS通过DWR调用。 注意此类没有做安全控制，且其内的所有方法都对外公开， 所以这些方法实现必须考虑数据安全性，一般只做查询数据用。
 * 
 * @author Yangjianliang datetime 2009-6-7
 */
public class AjaxServiceImpl implements AjaxService {

	private static final Log LOG = LogFactory.getLog(AjaxServiceImpl.class);

	private BaseDao baseDao;

	/**
	 * 检查调用此方法的人是否已经登录
	 * 
	 * @return 已经登录返回true，否则返回false
	 */
	public static boolean hasBeenLogining() {
		Object loginUser = getLoginUser();
		if (loginUser == null) {
			return false;
		}
		return true;
	}

	/**
	 * 返回已经登录人的对象
	 * 
	 * @return LoginUserVO实例
	 */
	public static LoginUserVO getLoginUser() {
		HttpSession session = WebContextFactory.get().getSession();
		if (session == null) {
			return null;
		}
		LoginUserVO loginUser = (LoginUserVO) session.getAttribute(IdConstants.SESSION_USER);
		return loginUser;
	}

	public boolean checkRecordExist(String targetTableObject, String columnName, String columnValue) {

		String hql = "select count(*) from " + targetTableObject + " where " + columnName + "='" + columnValue + "'";
		long i = baseDao.count(hql);
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}

	public boolean changeMsgState(String msgId, String state) {
		if (StringUtils.isNotBlank(msgId) && StringUtils.isNotBlank(state)) {
			TSysMessageGxqf tSysMessageGxqf = (TSysMessageGxqf) baseDao.findById(TSysMessageGxqf.class, msgId);

			tSysMessageGxqf.setXxzt(state);
			tSysMessageGxqf.setXxydsj(new Date());
			baseDao.saveOrUpdate(tSysMessageGxqf);
		}
		return true;
	}

	public String getMsgStat(String userId) throws Exception {
		String hql = "select count(*) from TSysMessageGxqf where xxjsr=? and xxzt=? and fszt='1'";

		String msgSize = String.valueOf(baseDao.findFieldValue(hql, userId, Constants.MESSAGE_STATE_UNREAD));
		return msgSize;
	}

	/**
	 * 查询当前登录者的待处理的比赛
	 * 
	 * @return 待处理数据量
	 * @throws Exception
	 */
	public int getPendingApproveGames() throws Exception {
		String sql = "select count(*) from T_SPORT_SSRC where FBZT=? or FBZT=? ";

		int num = 0;
		LoginUserVO loginUser = getLoginUser();
		if (loginUser != null && "1".equals(loginUser.getUsertype())) {// 成绩发布者
			num = DBUtil.count(sql, "2", "-3");// 待发布、撤销

		} else if (loginUser != null && "2".equals(loginUser.getUsertype())) {// 成绩审核者
			num = DBUtil.count(sql, "1", "-2");// 待审核、退回审核

		} else if (loginUser != null && "3".equals(loginUser.getUsertype())) {// 成绩登记者
			num = DBUtil.count(sql, "0.5", "-1");// 登记中、退回登记

		}
		return num;
	}

	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}

	public String getMsgRefreshTime() throws Exception {
		String refreshTime = CommonQuery.getSysProperty("xxsxsj");
		return refreshTime;
	}

	public Map<String, String> getSelectContents(String sqlmapid, String findValue) throws Exception {

		if (sqlmapid == null) {
			LOG.error("非法SQL语句编号");
			throw new Exception("不存在这样的SQL语句编号！");
		}
		String sql = SQLConfigUtil.getSqlString(sqlmapid);
		if (sql == null || sql.trim().equals("")) {
			throw new Exception("不存在这样的SQL语句！");
		}
		ResultSet rs = DBUtil.queryRowSet(sql, findValue);
		Map<String, String> map = new HashMap<String, String>();
		if (rs != null) {
			while (rs.next()) {
				map.put(rs.getString(1), rs.getString(2));
			}
		}
		return map;
	}

	/*
	 * 校验新增组织机构是否已存在
	 */
	public boolean checkDepartData(String departname, String updepartid) {
		String hql = "from TSysDepart where departname=? and updepartid=?";
		long c = baseDao.count(hql, departname, updepartid);
		if (c != 0) {
			return false;
		}
		return true;
	}

	/**
	 * 用于系统参数维护页面的刷新
	 */
	public String refreshSysProp() {
		if (hasBeenLogining()) {
			try {
				PropConfigUtil.loadSysProps();
				return "true:";
			} catch (Exception e) {
				return "false:" + e.getMessage();
			}
		} else {
			return Constants.MESSAGE_FHZF_YHDL;
		}
	}

	/**
	 * 获取当前时间的年月
	 * 
	 * @return
	 */
	public String year_month() {
		String year_month = null;
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		if (month >= 10) {
			year_month = year + "" + month;
		} else {
			year_month = year + "0" + month;
		}
		return year_month;
	}

	/**
	 * 动态加载表字段
	 * 
	 * @param table
	 * @return
	 * @throws Exception
	 */
	public Object[] getFields(String table) throws Exception {
		return ExcelDBUtil.getTableFields(table).toArray();
	}

	/**
	 * 系统消息发送
	 * 
	 * @param wid
	 * @return 发送成功与否
	 */
	public boolean sendShortMessage(String wid) {
		if (hasBeenLogining()) {
		String sql = null;
		sql = "update t_sys_message t set t.FSZT = '1' where wid = ?";
		boolean successF = DBUtil.executeSQL(sql, wid) > 0;
		sql = "update t_sys_message_gxqf t set t.FSZT = '1' where message_wid = ?";
		boolean successS = DBUtil.executeSQL(sql, wid) > 0;
		return successF && successS;
		}
		throw new RuntimeException("未登录用户，无权限操作！");
	}

	/**
	 * 查询大市下面区县
	 * 
	 * @param qx
	 * @return
	 * @throws SQLException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getSelectQx(String ds) throws SQLException {
		String dsz = "";
		try {
			dsz = URLDecoder.decode(ds, "UTF-8");// 解码;
		} catch (UnsupportedEncodingException e) {
		}
		String sql = "select t.departid from t_sys_depart t where t.departname=?";
		String departid = (String) DBUtil.queryFieldValue(sql, dsz);
		String sqlcolumn1 = " select t.areaid as id,"
				+ " substr(t.areaname,length((select a.areaname from T_Sys_Area a where a.areaid=? ))+1,length(t.areaname)) as caption ";
		String sql_cx1 = " from T_Sys_Area t where (t.arealevel='3' or t.arealevel='4') and t.upareaid=? ";
		List<ApplicationEnum> list = (List<ApplicationEnum>) DBUtil.queryAllBeanList(sqlcolumn1 + sql_cx1,
				ApplicationEnum.class, departid, departid);
		if (list != null) {
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 区县--");
			list.add(0, app);

		} else {
			list = new ArrayList<ApplicationEnum>();
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 区县--");
			list.add(app);
		}

		return list;
	}

	/**
	 * 查询比赛项目中的小项目名称
	 * 
	 * @param dxmmc
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getSelectDxmmc(String dxmmc) throws Exception {

		String sql = "select xxmmc as id,xxmmc as caption from T_Sport_Bsxm a where a.dxmmc=? group by a.xxmmc order by  f_pinyin(xxmmc),xxmmc";
		ResultSet rs = DBUtil.queryRowSet(sql, dxmmc);
		Map<String, String> map = new HashMap<String, String>();
		if (rs != null) {
			while (rs.next()) {
				map.put(rs.getString(1), rs.getString(2));
			}
		}
		return map;
	}

	/**
	 * 查询比赛项目中的组别名称
	 * 
	 * @param dxmmc
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getSelectZb(String dxmmc) throws Exception {
		String sql = "select  max(c.zb), max((select t.zdmc from T_Sys_Code t where t.zdbm=c.zb and t.zdlb='BSXM_ZB' ))  from T_Sport_Bsxm c where c.dxmmc = ? group by c.zb order by max(c.zb) asc";
		ResultSet rs = DBUtil.queryRowSet(sql, dxmmc);
		Map<String, String> map = new HashMap<String, String>();
		if (rs != null) {
			while (rs.next()) {
				if (StringUtils.isNotBlank(rs.getString(1))) {
					map.put(rs.getString(1), rs.getString(2));
				}
			}
		}
		return map;
	}

	/**
	 * 查询比赛项目中的性别组名称
	 * 
	 * @param dxmmc
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getSelectXbz(String dxmmc) throws Exception {
		String sql = "select  max(c.xbz), max((select t.zdmc from T_Sys_Code t where t.zdbm=c.xbz and t.zdlb='BSXM_XBZ' ))  from T_Sport_Bsxm c where c.dxmmc = ? group by c.xbz order by max(c.xbz) asc";
		ResultSet rs = DBUtil.queryRowSet(sql, dxmmc);
		Map<String, String> map = new HashMap<String, String>();
		if (rs != null) {
			while (rs.next()) {
				if (StringUtils.isNotBlank(rs.getString(1))) {
					map.put(rs.getString(1), rs.getString(2));
				}
			}
		}
		return map;
	}

	/**
	 * 查询比赛项目中的小项目名称
	 * 
	 * @param dxmmc
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getSelectxxmmc(String dxmmc) throws Exception {
		String sql = "select xxmmc as id,xxmmc as caption from T_Sport_Bsxm a where a.dxmmc=? group by a.xxmmc order by  f_pinyin(xxmmc),xxmmc";
		ResultSet rs = DBUtil.queryRowSet(sql, dxmmc);
		Map<String, String> map = new HashMap<String, String>();
		if (rs != null) {
			while (rs.next()) {
				if (StringUtils.isNotBlank(rs.getString(1))) {
					map.put(rs.getString(1), rs.getString(2));
				}
			}
		}
		return map;
	}

	/**
	 * 查询比赛项目中的大项目名称
	 * 
	 * @param xmdj
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getSelectXmdj(String xmdj) throws Exception {
		String sql = " select max(a.dxmmc),max(a.dxmmc)  from T_Sport_Bsxm a where a.xmdj = ? group by a.dxmmc order by max(a.wid) desc ";
		ResultSet rs = DBUtil.queryRowSet(sql, xmdj);
		Map<String, String> map = new HashMap<String, String>();
		if (rs != null) {
			while (rs.next()) {
				if (StringUtils.isNotBlank(rs.getString(1))) {
					map.put(rs.getString(1), rs.getString(2));
				}
			}
		}
		return map;
	}

	/**
	 * 获得代表队
	 * 
	 * @param dbt 代表团
	 * @return
	 */
	public List<ApplicationEnum> getDbd(String dbt) {
		String hql = "select new ApplicationEnum(t.departid,t.departname ) from TSysDepart t where t.updepartid=? ";
		List<ApplicationEnum> list = this.baseDao.findByHql(hql, dbt);
		if (list != null) {
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("-请选择-");
			list.add(0, app);

		} else {
			list = new ArrayList<ApplicationEnum>();
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("-请选择-");
			list.add(app);
		}
		return list;
	}

	/**
	 * 获得运动员
	 * 
	 * @param dbd 代表队
	 * @return
	 */
	public List<ApplicationEnum> getYdy(String dbd) {
		String hql = "select new ApplicationEnum(a.wid,a.xm ) from TSportYdyxx a where a.yddbm=? order by length(xmpy),NLSSORT(a.xm,'NLS_SORT = SCHINESE_PINYIN_M')";
		List<ApplicationEnum> list = this.baseDao.findByHql(hql, dbd);
		if (list != null) {
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("-请选择-");
			list.add(0, app);
		} else {
			list = new ArrayList<ApplicationEnum>();
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("-请选择-");
			list.add(app);
		}
		return list;
	}

	/**
	 * 根据大项目获得小项目（级联） ----待审批数据
	 * 
	 * @param dbd
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getSelectXxmmc(String dxmmc) throws UnsupportedEncodingException {
		String mc = "";
		try {
			mc = URLDecoder.decode(dxmmc, "UTF-8");// 解码;
		} catch (UnsupportedEncodingException e) {
		}
		String sql = "select xxmmc as id,xxmmc as caption from T_Sport_Bsxm a where a.dxmmc=? group by a.xxmmc order by  f_pinyin(xxmmc),xxmmc";
		List<ApplicationEnum> list = (List<ApplicationEnum>) DBUtil.queryAllBeanList(sql, ApplicationEnum.class, mc);
		if (list != null) {
			for (ApplicationEnum app : list) {
				app.setId(java.net.URLEncoder.encode(app.getId(), "UTF-8"));
			}
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("-请选择-");
			list.add(0, app);

		} else {
			list = new ArrayList<ApplicationEnum>();
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("-请选择-");
			list.add(app);
		}

		return list;
	}

	/**
	 * 获得 组别 ----待审批数据
	 * 
	 * @param bsxm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public List<ApplicationEnum> getBsxmZb(String bsxm) throws UnsupportedEncodingException {
		String mc = "";
		try {
			mc = URLDecoder.decode(bsxm, "UTF-8");// 解码;
		} catch (UnsupportedEncodingException e) {
		}
		String hql = "select new ApplicationEnum(t.zdbm,t.zdmc) from TSysCode t where t.zdlb='BSXM_ZB'  and t.zdbm in (select a.zb from TSportBsxm a where a.dxmmc='"
				+ mc + "' ) group by t.zdmc,t.zdbm ";
		List<ApplicationEnum> list = this.baseDao.findByHql(hql);
		if (list != null) {
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("-请选择-");
			list.add(0, app);

		} else {
			list = new ArrayList<ApplicationEnum>();
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("-请选择-");
			list.add(app);
		}
		return list;
	}

	/**
	 * 获得性别组----待审批数据
	 * 
	 * @param bsxm
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public List<ApplicationEnum> getBsxmXbz(String bsxm) throws UnsupportedEncodingException {
		String mc = "";
		try {
			mc = URLDecoder.decode(bsxm, "UTF-8");// 解码;
		} catch (UnsupportedEncodingException e) {
			LOG.error(e);
		}
		String hql = "select new ApplicationEnum(t.zdbm,t.zdmc) from TSysCode t where t.zdlb='BSXM_XBZ' and t.zdbm in (select a.xbz from TSportBsxm a where a.dxmmc='"
				+ mc + "' ) group by t.zdmc,t.zdbm ";
		List<ApplicationEnum> list = this.baseDao.findByHql(hql);
		if (list != null) {
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("-请选择-");
			list.add(0, app);

		} else {
			list = new ArrayList<ApplicationEnum>();
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("-请选择-");
			list.add(app);
		}
		return list;
	}

	/**
	 * 根据时间 、大项目获得 组别 ----项目查询
	 * 
	 * @param bsxm
	 * @param time
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getBsxmZbByTime(String bsxm, String time) throws UnsupportedEncodingException {
		String sql = "select a.zdbm as id,a.zdmc as caption from t_sys_code a ,t_sport_bsxm b, t_sport_ssrc c "
				+ "where a.zdlb='BSXM_ZB' and a.zdbm=b.zb and b.wid=c.xmbm ";
		if (StringUtils.isNotBlank(time) && !"all".equals(time)) {
			sql += " and to_char(c.bssj,'yyyy-MM-dd')='" + time + "' ";
		}
		sql += " and b.dxmmc=? group by a.zdbm,a.zdmc ";

		bsxm = URLDecoder.decode(bsxm, "UTF-8");
		List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class, bsxm);
		if (list != null) {
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 组别--");
			list.add(0, app);

		} else {
			list = new ArrayList<ApplicationEnum>();
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 组别--");
			list.add(app);
		}
		return list;
	}

	/**
	 * 根据时间 、大项目、组别 获得 性别组 ----项目查询
	 * 
	 * @param bsxm
	 * @param time
	 * @param zb
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getXbzByTimeZb(String bsxm, String time, String zb)
			throws UnsupportedEncodingException {
		String sql = "select a.zdbm as id,a.zdmc as caption from t_sys_code a ,t_sport_bsxm b, t_sport_ssrc c "
				+ "where a.zdlb='BSXM_XBZ' and a.zdbm=b.xbz and b.wid=c.xmbm ";
		if (StringUtils.isNotBlank(time) && !"all".equals(time)) {
			sql += " and to_char(c.bssj,'yyyy-MM-dd')='" + time + "' ";
		}

		sql += " and b.dxmmc=? and b.zb=? group by a.zdbm,a.zdmc ";

		bsxm = URLDecoder.decode(bsxm, "UTF-8");
		List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class, bsxm, zb);
		if (list != null) {
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 性别组--");
			list.add(0, app);

		} else {
			list = new ArrayList<ApplicationEnum>();
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 性别组--");
			list.add(app);
		}
		return list;
	}

	/**
	 * 根据时间 、大项目、组别、性别组 获得 小项目 ----项目查询
	 * 
	 * @param bsxm
	 * @param time
	 * @param zb
	 * @param xbz
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getXxmmcByTimeZbXbz(String bsxm, String time, String zb, String xbz)
			throws UnsupportedEncodingException {
		String sql = "select b.xxmmc as id,b.xxmmc as caption from t_sport_bsxm b, t_sport_ssrc c "
				+ "where  b.wid=c.xmbm ";
		if (StringUtils.isNotBlank(time) && !"all".equals(time)) {
			sql += " and to_char(c.bssj,'yyyy-MM-dd')='" + time + "' ";
		}

		sql += " and b.dxmmc=? and b.zb=? and xbz=? group by b.xxmmc ";

		bsxm = URLDecoder.decode(bsxm, "UTF-8");
		List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class, bsxm, zb, xbz);
		if (list != null) {
			for (ApplicationEnum app : list) {
				app.setId(java.net.URLEncoder.encode(app.getId(), "UTF-8"));
			}
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 级（赛）别 --");
			list.add(0, app);

		} else {
			list = new ArrayList<ApplicationEnum>();
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 级（赛）别--");
			list.add(app);
		}
		return list;
	}

	/**
	 * 根据时间 、大项目、组别、性别组 、小项目获得 编排分组 ----项目查询
	 * 
	 * @param bsxm
	 * @param time
	 * @param zb
	 * @param xbz
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getBpfz(String bsxm, String time, String zb, String xbz, String xxm)
			throws UnsupportedEncodingException {
		String sql = "select c.bpfz as id,d.zdmc as caption from t_sport_bsxm b, t_sport_ssrc c,t_sys_code d  "
				+ "where  b.wid=c.xmbm and c.bpfz=d.zdbm and d.zdlb='SSRC_BPFZ' ";
		if (StringUtils.isNotBlank(time)) {
			sql += " and to_char(c.bssj,'yyyy-MM-dd')='" + time + "' ";
		}
		if (StringUtils.isNotBlank(bsxm)) {
			bsxm = URLDecoder.decode(bsxm, "UTF-8");
			sql += " and b.dxmmc='" + bsxm + "' ";
		}
		if (StringUtils.isNotBlank(zb)) {
			sql += " and b.zb='" + zb + "' ";
		}
		if (StringUtils.isNotBlank(xbz)) {
			sql += " and b.xbz='" + xbz + "' ";
		}

		sql += " group by c.bpfz,d.zdmc ";

		List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class);
		if (list != null) {
			for (ApplicationEnum app : list) {
				app.setId(java.net.URLEncoder.encode(app.getId(), "UTF-8"));
			}
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 分组--");
			list.add(0, app);

		} else {
			list = new ArrayList<ApplicationEnum>();
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 分组--");
			list.add(app);
		}
		return list;
	}

	/**
	 * 根据时间 、大项目、组别、性别组 、小项目获得 编排分组 ----项目查询
	 * 
	 * @param bsxm
	 * @param time
	 * @param zb
	 * @param xbz
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getScbm(String bsxm, String time, String zb, String xbz, String xxm, String bpfz)
			throws UnsupportedEncodingException {
		String sql = "select c.scbm as id,d.zdmc as caption from t_sport_bsxm b, t_sport_ssrc c,t_sys_code d  "
				+ "where  b.wid=c.xmbm and c.scbm=d.zdbm and d.zdlb='SSRC_SCBM' ";
		if (StringUtils.isNotBlank(time)) {
			sql += " and to_char(c.bssj,'yyyy-MM-dd')='" + time + "' ";
		}
		if (StringUtils.isNotBlank(bsxm)) {
			bsxm = URLDecoder.decode(bsxm, "UTF-8");
			sql += " and b.dxmmc='" + bsxm + "' ";
		}
		if (StringUtils.isNotBlank(zb)) {
			sql += " and b.zb='" + zb + "' ";
		}
		if (StringUtils.isNotBlank(xbz)) {
			sql += " and b.xbz='" + xbz + "' ";
		}

		if (StringUtils.isNotBlank(bpfz)) {
			sql += " and c.bpfz='" + bpfz + "' ";
		}

		sql += " group by c.scbm,d.zdmc ";

		List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class);
		if (list != null) {
			for (ApplicationEnum app : list) {
				app.setId(java.net.URLEncoder.encode(app.getId(), "UTF-8"));
			}
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 分组--");
			list.add(0, app);

		} else {
			list = new ArrayList<ApplicationEnum>();
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择 分组--");
			list.add(app);
		}
		return list;
	}

	/**
	 * 检查此运动员在指定赛程里是否已存在 用于防止重复参加 检查此运动员是否属于本代表团 或代表队 的 用于防止误添加
	 * 
	 * @param scbm 赛程编码
	 * @param ydybm 运动员编码
	 * @param departid 代表团 或代表队编码
	 * @param xmbm 项目编码
	 * @return
	 * @throws SQLException
	 */
	public String validatePerson(String scbm, String ydybm, String departid, String xmbm) throws SQLException {
		String[] ydybms = ydybm.split(",");
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < ydybms.length; i++) {
			String str = ydybms[i];
			String[] wids = str.split("_");
			if (i == 0) {
				sb.append(wids[0]);
			} else {
				sb.append("," + wids[0]);
			}
		}
		String ydybm_new = sb.toString();
		ydybm_new = ydybm_new.replaceAll(",", "'  or a.ydybm='");
		String sql = " select count(*) from t_sport_cj_ydy a where a.scbm=? and (a.ydybm='" + ydybm_new + "') ";
		long c = DBUtil.count(sql, scbm);
		// String sql3 = "select t.dxmmc from t_sport_bsxm t where t.wid=?";
		// Object dxmmc = DBUtil.queryFieldValue(sql3, xmbm);
		if (c > 0) {
			return "no";
		} else {
			/*
			 * String sql2 = ""; if (StringUtil.isNotBlank(departid)) { sql2 =
			 * "select t.yddbm from t_sport_ydyxx t where t.wid=?"; Object obj =
			 * DBUtil.queryFieldValue(sql2, ydybm);
			 * 
			 * if (obj != null) { String depart2 = String.valueOf(obj); if
			 * (departid.length() == 6) { depart2 = depart2.substring(0, 6); }
			 * //String sqlYdyXm =
			 * " select t.bsxmwid,a.state from t_sport_ydyxx a left join  t_sport_ydybmxm t  on t.ydywid=a.wid where a.wid=? "
			 * ; String sqlYdyXm =
			 * " select t.dxmmc,a.state from t_sport_ydyxx a left join  t_sport_ydybmxm t  on t.ydywid=a.wid where a.wid=? "
			 * ; List<Object[]> objs = DBUtil.queryAllList(sqlYdyXm, ydybm); if
			 * (objs != null && objs.get(0) != null) { if
			 * (("1").equals(String.valueOf(objs.get(0)[1]))) { if
			 * ((String.valueOf(dxmmc)).equals(String.valueOf(objs.get(0)[0]))
			 * && ("1").equals(String.valueOf(objs.get(0)[1]))) { if
			 * (!departid.equals(depart2)) { return "passBut"; } } return
			 * "ydybf"; } } return "wbcxm"; } }else{ //String sqlYdyXm =
			 * " select t.bsxmwid,a.state from t_sport_ydyxx a left join  t_sport_ydybmxm t  on t.ydywid=a.wid where a.wid=? "
			 * ; String sqlYdyXm =
			 * " select t.dxmmc,a.state from t_sport_ydyxx a left join  t_sport_ydybmxm t  on t.ydywid=a.wid where a.wid=? "
			 * ; List<Object[]> objs = DBUtil.queryAllList(sqlYdyXm, ydybm); if
			 * (objs != null && objs.get(0) != null) { if
			 * ((String.valueOf(dxmmc)).equals(String.valueOf(objs.get(0)[0]))
			 * && ("1").equals(String.valueOf(objs.get(0)[1]))) { return "ok"; }
			 * else if (("1").equals(String.valueOf(objs.get(0)[1]))) { return
			 * "ydybf"; } else { return "wbcxm"; } } else { return "wbcxm"; } }
			 */
			return "ok";
		}
	}

	/**
	 * 更新团队人员
	 * 
	 * @param xmbm 项目编码
	 * @param departIds 代表团或代表队Id
	 * @param scbm 赛程编码
	 */
	public String resetCjYdy(String xmbm, String[] departIds, String scbm) {
		// 查出 本赛程所属 部门和项目下 且没有添加 运动员 的 集体 对战项目
		// String hqlCjJT =
		// "FROM TSportCjJt a  WHERE a.SCBM NOT IN (SELECT b.SCBM FROM TSportCjYdy b  WHERE b.departid = a.departid) AND   a.SCBM IN (SELECT c.wid FROM TSportSsrc c WHERE c.XMBM = ?) ";

		String or = "";
		if (hasBeenLogining() && departIds != null && departIds.length > 0) {
			for (int i = 0; i < departIds.length; i++) {
				if (i == 0) {
					or += " a.departid='" + departIds[i] + "' ";
				} else {
					or += " or a.departid='" + departIds[i] + "' ";
				}
			}

			String hqlCjJT = "from TSportCjJt a  where a.scbm NOT IN (select b.scbm FROM TSportCjYdy b  WHERE b.departid = a.departid and a.wid=b.jtwid) AND   a.scbm IN (SELECT c.wid FROM TSportSsrc c WHERE c.xmbm = ? and (c.fbzt='0' or c.fbzt='0.5' or c.fbzt='-1') ) and ("
					+ or + ")";
			List<TSportCjJt> listCjJt = this.baseDao.findByHql(hqlCjJT, xmbm);
			// 查出 本赛次所有的 运动员成绩
			String hqlCjYdy = " from TSportCjYdy b where b.scbm =?";
			List<TSportCjYdy> listCjYdy = this.baseDao.findByHql(hqlCjYdy, scbm);
			ArrayList<TSportCjYdy> tsc = new ArrayList<TSportCjYdy>();
			if (listCjJt != null && listCjJt.size() > 0) {
				for (TSportCjJt cjjt : listCjJt) {
					if (listCjYdy != null && listCjYdy.size() > 0) {
						for (TSportCjYdy cjydy : listCjYdy) {
							if (StringUtil.isNotBlank(cjjt.getDepartid()) && StringUtil.isNotBlank(cjydy.getDepartid())
									&& cjjt.getDepartid().equals(cjydy.getDepartid())) {
								TSportCjYdy cjYdy2 = new TSportCjYdy();
								cjYdy2.setWid(SeqFactory.getNewSequenceAlone());
								cjYdy2.setDjjydh(cjjt.getDjjydh());
								cjYdy2.setScbm(cjjt.getScbm());
								cjYdy2.setYdybm(cjydy.getYdybm());

								if (StringUtil.isNotBlank(cjjt.getCj())) {
									cjYdy2.setCj(cjjt.getCj());
								} else {
									cjYdy2.setCj("");
								}
								if (cjjt.getDf() != null) {
									cjYdy2.setDf(cjjt.getDf());
								} else {
									cjYdy2.setDf(0.00);
								}
								if (cjjt.getJps() != null) {
									cjYdy2.setJps(cjjt.getJps());
								} else {
									cjYdy2.setJps(0.00);
								}
								if (cjjt.getYps() != null) {
									cjYdy2.setYps(cjjt.getYps());
								} else {
									cjYdy2.setYps(0.00);
								}
								if (cjjt.getTps() != null) {
									cjYdy2.setTps(cjjt.getTps());
								} else {
									cjYdy2.setTps(0.00);
								}
								cjYdy2.setDbd(cjydy.getDbd());
								cjYdy2.setMc(cjjt.getMc());
								cjYdy2.setSfjs(cjjt.getSfjs());
								if (cjjt.getJjf() != null) {
									cjYdy2.setJjf(cjjt.getJjf());
								} else {
									cjYdy2.setJjf(0.00);
								}
								cjYdy2.setShzt(cjjt.getShzt());
								cjYdy2.setCreatetime(new Date());
								cjYdy2.setBz("");
								cjYdy2.setPjllx(cjjt.getPjllx());
								if (cjjt.getYjlcj() != null) {
									cjYdy2.setYjlcj(String.valueOf(cjjt.getYjlcj()));
								} else {
									cjYdy2.setYjlcj("");
								}
								cjYdy2.setSfjtxm(cjydy.getSfjtxm());
								cjYdy2.setSfjrxyl(cjjt.getSfjrxyl());
								if (cjjt.getJjjps() != null) {
									cjYdy2.setJjjps(cjjt.getJjjps());
								} else {
									cjYdy2.setJjjps(0.00);
								}
								if (cjjt.getJjyps() != null) {
									cjYdy2.setJjyps(cjjt.getJjyps());
								} else {
									cjYdy2.setJjyps(0.00);
								}

								if (cjjt.getJjtps() != null) {
									cjYdy2.setJjtps(cjjt.getJjtps());
								} else {
									cjYdy2.setJjtps(0.00);
								}
								cjYdy2.setJtwid(cjjt.getWid());
								cjYdy2.setDxmmc(cjjt.getDxmmc());
								cjYdy2.setXxmmc(cjjt.getXxmmc());
								cjYdy2.setBpxh("");
								cjYdy2.setYdyxm(cjydy.getYdyxm());
								cjYdy2.setSfbjydhcj(cjjt.getSfbjydhcj());
								cjYdy2.setDepartid(cjjt.getDepartid());
								tsc.add(cjYdy2);
							}
						}
					}else{
						return "null";
					}
				}
				this.baseDao.saveAll(tsc);
				return "ok";
			}else{
				return "ok";
			}
		}else{
			throw new RuntimeException("未登录用户，无权限操作！");
		}
	}

	/**
	 * 赛程状态审核流程（包含从提交审核到确认发布，以及退回的全部流程）
	 * 
	 * @param sczt 赛程状态（对应赛事日程表的发布状态）
	 * @param scbm 赛程编码（赛事日程表主键）
	 * @param bsxm 比赛项目编码（比赛项目表主键）
	 * @param sfjs 是否决赛（1：是，0：否）
	 * @return 状态变更结果信息
	 * @throws SQLException
	 * @throws IOException 
	 */
	public String auditGameProcess(String sczt, String scbm, String bsxm, String sfjs, String isjtxm, String sc)
			throws SQLException, IOException {
		if (hasBeenLogining()) {
			String msg = "";
			String loginId = getLoginUser().getUserLoginId();
			if ("1".equals(sczt)) {
				// 提交审核 1
				if (StringUtils.isNotBlank(scbm) && StringUtils.isNotBlank(isjtxm)) {

					String sql = null;// 验证赛程下面的参赛者是否为空
					if ("1".equals(isjtxm) || "2".equals(isjtxm)) {
						sql = " select count(*) from t_sport_cj_jt t where t.scbm=? ";
					} else {
						sql = " select count(*) from t_sport_cj_ydy t where t.scbm=? ";
					}
					int i = DBUtil.count(sql, scbm);
					if (i > 0) {
						if ("1".equals(isjtxm) || "2".equals(isjtxm)) {
							sql = "update t_sport_cj_jt a set a.shzt='2' where a.scbm=? and (a.shzt='0' or a.shzt='-1')  ";
						} else {
							sql = "update t_sport_cj_ydy b set b.shzt='2' where b.scbm=? and (b.shzt='0' or b.shzt='-1' )";
						}
						i = DBUtil.executeSQL(sql, scbm);
						if (i != -1) {
							// 改变fbzt 为 成绩审核中
							sql = "update t_sport_ssrc t set t.fbzt='1' where wid=?";
							DBUtil.executeSQL(sql, scbm);
							return "提交待审核成功！";
						}
					} else {
						return "提交待审核失败！缺少参赛者！";
					}

				}
				return "提交待审核失败！";
			} else if ("2".equals(sczt)) {
				// 提交到发布流程 2
				if (StringUtils.isNotBlank(scbm) && StringUtils.isNotBlank(isjtxm)) {
					// 更改赛成 发布状态 为 待发布：2
					String changeFbzt = " update t_sport_ssrc t set t.fbzt='2' where t.wid=?";
					int i = DBUtil.executeSQL(changeFbzt, scbm);
					if (i != -1) {
						// 决赛调用 汇总

						if ("2".equals(sc)) {
							DBUtil.execOracleProcQueryString(SQLConfigUtil.getProcName("procd.sports_hzsxmx"), bsxm,
									scbm);
							DBUtil.execOracleProcQueryString(SQLConfigUtil.getProcName("procd.sports_hztdmx"), bsxm,
									scbm);
						}
						return "提交发布成功！";
					}
				}
				return "提交发布失败！";
			} else if ("preview".equals(sczt)) {
				// 预览赛次成绩 preview 决赛调用预览
				if ("2".equals(sc)) {
					DBUtil.execOracleProcQueryString(SQLConfigUtil.getProcName("procd.sports_hzsxmx"), bsxm, scbm);
					DBUtil.execOracleProcQueryString(SQLConfigUtil.getProcName("procd.sports_hztdmx"), bsxm, scbm);
				}
				return "";
			} else if ("3".equals(sczt)) {
				// 确认发布 3
				String newscbm = scbmLink(scbm);
				String changefbzt = "update t_sport_ssrc t set t.fbzt='" + sczt + "',t.fbsj=sysdate where t.wid in ("
						+ newscbm + ")";
				int i = DBUtil.executeSQL(changefbzt);
				if (i != -1) {
					String str[] = scbm.split(",");
					//赛程决赛个数
					String sql_count = "select count(*) from t_sport_ssrc t where t.wid in(" + newscbm
							+ ") and t.scbm='2'";
					int count = DBUtil.count(sql_count);
					if (count > 0) {
						for (String _scbm : str) {
							msg = DBUtil.execOracleProcQueryString(SQLConfigUtil.getProcName("procd.sports_jrpmxm"),
									_scbm);
						}
						// 此存储过程会把明细预览表选择的赛程放入正式的明细表，所以必须同步调用下面的汇总排名，以保持明细和汇总的一致。
						if ("1".equals(msg)) {// 执行成功
							DBUtil.execUniProcNoneQuery(SQLConfigUtil.getProcName("procd.sports_hzsxhz"));
							DBUtil.execUniProcNoneQuery(SQLConfigUtil.getProcName("procd.sports_hztdhz"));
						}
						
					}
					BusinessLogUtil.log(loginId, Constants.CZDX_T_SPORT_SSRC, Constants.LOG_ACTION_PUBLISH);
					return "发布成功！";
				}
				return "发布失败！";
			} else if ("-3".equals(sczt)) {
				// 撤销发布 -3
				String newscbm = scbmLink(scbm);
				String changefbzt = "update t_sport_ssrc t set t.fbzt='" + sczt + "',t.fbsj=sysdate where t.wid in ("
						+ newscbm + ")";
				int i = DBUtil.executeSQL(changefbzt);
				if (i != -1) {
					if ("2".equals(sc)) {// 赛程=2， 是决赛。撤销决赛需要重新计算成绩分布
						String sql1 = "update t_sport_cj_jt t set t.shzt=? where t.scbm=? and t.shzt='1'";// 更新本赛程并且是确认通过的成绩的状态
						String sql2 = "update t_sport_cj_ydy t set t.shzt=? where t.scbm=? and t.shzt='1'";
						DBUtil.executeSQL(sql1, "-1", scbm);// 界面控制撤销赛程只能单选操作！
						DBUtil.executeSQL(sql2, "-1", scbm);
						msg = DBUtil.execOracleProcQueryString(SQLConfigUtil.getProcName("procd.sports_hzsxmx"), bsxm,
								scbm);// 汇总明细
						if ("1".equals(msg)) {// 执行成功
							msg = DBUtil.execOracleProcQueryString(SQLConfigUtil.getProcName("procd.sports_hztdmx"),
									bsxm, scbm);// 汇总明细
						}
						if ("1".equals(msg)) {// 执行成功
							msg = DBUtil.execOracleProcQueryString(SQLConfigUtil.getProcName("procd.sports_jrpmxm"),
									scbm);
						}
						if ("1".equals(msg)) {// 执行成功
							DBUtil.execUniProcNoneQuery(SQLConfigUtil.getProcName("procd.sports_hzsxhz"));// 汇总综合排名
							DBUtil.execUniProcNoneQuery(SQLConfigUtil.getProcName("procd.sports_hztdhz"));// 汇总综合排名
						}
						sql1 = "update t_sport_cj_jt t set t.shzt=? where t.scbm=? and t.shzt='-1'";// 更新本赛程并且是确认通过的成绩的状态
						sql2 = "update t_sport_cj_ydy t set t.shzt=? where t.scbm=? and t.shzt='-1'";
						DBUtil.executeSQL(sql1, "1", scbm);
						DBUtil.executeSQL(sql2, "1", scbm);
						BusinessLogUtil.log(loginId, Constants.CZDX_T_SPORT_SSRC, Constants.LOG_ACTION_CANCEL_PUBLISH);
					}
					return "撤销发布成功！";
				}
				return "撤销发布失败！";
			} else if ("-2".equals(sczt)) {
				// 退回到审核流程 -2
				String newscbm = scbmLink(scbm);
				String changefbzt = "update t_sport_ssrc t set t.fbzt='" + sczt + "',t.fbsj=sysdate where t.wid in ("
						+ newscbm + ")";
				int i = DBUtil.executeSQL(changefbzt);
				if (i == -1) {
					return "退回审核失败！";
				}
				return "退回审核成功！";
			} else {
				return "操作失败！";
			}

		}
		throw new RuntimeException("未登录用户，无权限操作！");

	}

	/**
	 * 成绩审核
	 * 
	 * @param shzt 审核状态（指成绩的状态）
	 * @param wids 要审核的成绩的WID集合
	 * @param scbm 赛程编码
	 * @param isjtxm 是否集体项目
	 * @return 审核结果信息
	 * @throws SQLException
	 */
	public String auditScore(String shzt, String[] wids, String scbm, String isjtxm) throws SQLException {
		if (hasBeenLogining()) {
			String loginId = getLoginUser().getUserLoginId();
			if ("1".equals(shzt)) {
				// 通过
				if (wids != null && wids.length > 0) {
					String sql = "";
					String sql3 = widsLink(wids);
					// 1 集体项目 2： 多人项目 <多人项目和集体项目相同的处理>
					if ("1".equals(isjtxm) || "2".equals(isjtxm)) {
						sql = " update  t_sport_cj_jt t  set t.shzt='1' " + sql3;
						String sql2 = " update  t_sport_cj_ydy t  set t.shzt='1' where t.scbm=(select a.scbm from t_sport_cj_jt a where a.wid='"
								+ wids[0] + "') ";
						int i = DBUtil.executeSQL(sql2);
						if (i != -1) {
						} else {
							return "成绩通过失败！";
						}
					} else if ("0".equals(isjtxm)) {
						sql = " update t_sport_cj_ydy t set t.shzt='1' " + sql3;
					}
					int i = DBUtil.executeSQL(sql);

					if (i != -1) {
						BusinessLogUtil.log(loginId, Constants.CZDX_T_SPORT_CJ_YDY, Constants.LOG_ACTION_APPROVE);
						return "成绩通过成功！";
					} else {
						return "成绩通过失败！";
					}
				}
				return "成绩通过失败！";

			} else if ("-1".equals(shzt)) {
				// 退回
				if (wids != null && wids.length > 0) {
					String sql3 = widsLink(wids);
					String sql = "";

					if ("1".equals(isjtxm) || "2".equals(isjtxm)) {
						sql = " update  t_sport_cj_jt t  set t.shzt='-1' " + sql3;
						String sql2 = " update  t_sport_cj_ydy t  set t.shzt='-1' where t.scbm=(select a.scbm from t_sport_cj_jt a where a.wid='"
								+ wids[0] + "') ";
						int i = DBUtil.executeSQL(sql2);
						if (i != -1) {
						} else {
							return "取消审批失败！";
						}
					} else if ("0".equals(isjtxm)) {
						sql = " update t_sport_cj_ydy t set t.shzt='-1' " + sql3;
					}
					int i = DBUtil.executeSQL(sql);

					if (i != -1) {
						DBUtil.executeSQL("update t_sport_ssrc t set t.fbzt='-1' where t.wid=? ", scbm);
						return "成绩退回成功！";
					} else {
						return "成绩退回失败！";
					}
				}
				return "成绩退回失败！";
			} else if ("-2".equals(shzt)) {
				// 取消成绩
				if (wids != null && wids.length > 0) {
					String sql = "";
					String sql3 = widsLink(wids);
					// 1 集体项目 2： 多人项目 <多人项目和集体项目相同的处理>
					if ("1".equals(isjtxm) || "2".equals(isjtxm)) {
						int count = DBUtil.count(" select count(*) from t_sport_cj_jt t where t.wid in ("
								+ widsLink2(wids) + ") and t.shzt='-2' ");
						if (count == 0) {
							sql = " update  t_sport_cj_jt t  set t.shzt='-2' " + sql3;
							String sql2 = " update  t_sport_cj_ydy t  set t.shzt='-2' where t.scbm in (select a.scbm from t_sport_cj_jt a where a.wid='"
									+ wids[0] + "') ";
							int i = DBUtil.executeSQL(sql2);
							if (i != -1) {
								int j = DBUtil.executeSQL(sql);

								if (j != -1) {
									String qxcj = "update t_sport_ssrc t set t.fbzt='-2' where t.wid=? ";
									DBUtil.executeSQL(qxcj, scbm);
									BusinessLogUtil.log(loginId, Constants.CZDX_T_SPORT_CJ_YDY,
											Constants.LOG_ACTION_CANCEL);
									return "取消成绩成功！";
								} else {
									return "取消成绩失败！";
								}
							} else {
								return "取消成绩失败！";
							}
						} else {
							return "取消成绩失败，操作数据中存在已取消的数据";
						}

					} else if ("0".equals(isjtxm)) {

						sql = " update t_sport_cj_ydy t set t.shzt='-2' " + sql3;
						int i = DBUtil.executeSQL(sql);

						if (i != -1) {
							String qxcj = "update t_sport_ssrc t set t.fbzt='-2' where t.wid=? ";
							DBUtil.executeSQL(qxcj, scbm);
							BusinessLogUtil.log(loginId, Constants.CZDX_T_SPORT_CJ_YDY, Constants.LOG_ACTION_CANCEL);
							return "取消成绩成功！";
						} else {
							return "取消成绩失败！";
						}
					}
				}
				return "取消成绩失败！";
			} else if ("hfcj".equals(shzt)) {
				// 恢复成绩
				if (wids != null && wids.length > 0) {
					String sql = "";
					String sql3 = widsLink(wids);
					// 1 集体项目 2： 多人项目 <多人项目和集体项目相同的处理>
					if ("1".equals(isjtxm) || "2".equals(isjtxm)) {
						int count = DBUtil.count(" select count(*) from t_sport_cj_jt t where t.wid in ("
								+ widsLink2(wids) + ") and t.shzt!='-2' ");
						if (count == 0) {
							sql = " update  t_sport_cj_jt t  set t.shzt='1' " + sql3;
							String sql2 = " update  t_sport_cj_ydy t  set t.shzt='1' where t.scbm in (select a.scbm from t_sport_cj_jt a where a.wid='"
									+ wids[0] + "') ";
							int i = DBUtil.executeSQL(sql);
							if (i != -1) {
								DBUtil.executeSQL(sql2);
								BusinessLogUtil.log(loginId, Constants.CZDX_T_SPORT_CJ_YDY,
										Constants.LOG_ACTION_RECOVER);
								return "成绩恢复成功！";
							} else {
								return "成绩恢复失败！";
							}
						} else {
							return "成绩恢复失败，只能针对取消成绩的数据进行恢复成绩操作！";
						}

					} else if ("0".equals(isjtxm)) {
						sql = " update t_sport_cj_ydy t set t.shzt='1' " + sql3;
						int i = DBUtil.executeSQL(sql);

						if (i != -1) {
							BusinessLogUtil.log(loginId, Constants.CZDX_T_SPORT_CJ_YDY, Constants.LOG_ACTION_RECOVER);
							return "恢复成绩成功！";
						} else {
							return "恢复成绩失败！";
						}
					}
				}
				return "恢复成绩失败！";
			} else {
				return "操作失败！";
			}
		} 
		throw new RuntimeException("未登录用户，无权限操作！");
	}

	/**
	 * 赛程编码 字符串用","拼凑
	 * 
	 * @param scbm 赛程编码
	 * @return String
	 * @throws SQLException
	 */
	public String scbmLink(String scbm) throws SQLException {
		if (hasBeenLogining()) {
			if (StringUtils.isNotBlank(scbm)) {
				String str[] = scbm.split(",");
				StringBuilder sb = new StringBuilder();
				int m = 0;
				for (String st : str) {
					if (m == 0) {
						sb.append("'" + st + "'");
					} else {
						sb.append(",'" + st + "'");
					}
					m++;
				}
				return sb.toString();// 新拼成的赛程编号，保留原赛程编号下面使用
			}
		}
		throw new RuntimeException("未登录用户，无权限操作！");

	}

	/**
	 * 删除选择项目
	 * 
	 * @param wid
	 * @return String
	 * @throws SQLException
	 */
	public String removeYdyxm(String wid, String ydybm) throws SQLException {
		if (hasBeenLogining()) {

			String sql = "delete from t_sport_ydybmxm t where t.wid = ?";
			int i = DBUtil.executeSQL(sql, wid);
			if (i != -1) {
				String sql1 = "select count(*) from t_sport_ydybmxm t where t.ydywid = ?";
				long c = DBUtil.count(sql1, ydybm);
				if (c == 0) {
					String sql2 = "update t_sport_ydyxx a set a.state ='0' where a.wid=? ";
					DBUtil.executeSQL(sql2, ydybm);
				}
				return "执行成功!";
			}
		}
		throw new RuntimeException("未登录用户，无权限操作！");
	}

	/**
	 * 数据报送
	 * 
	 * @param ids wid 集合
	 * @return String
	 * @throws SQLException
	 */
	public String bssjCommit(String departid) throws SQLException {
		if (hasBeenLogining()) {
			// // 检测是否存在 登记状态为空的 不报送必须把 勾选人，取消报送
			// String checkBs =
			// " select count(*) from t_sport_ydybmxm_cc a , t_sport_ydyxx b where a.ydywid=b.wid  and b.state is null  and b.yddbm like '"
			// + getLoginUser().getDepart().getDepartid() + "%' ";
			// int count = DBUtil.count(checkBs);
			// if (count > 0) {
			// return "有未进行确认的数据！";
			// } else {
			String sql = " update t_sport_ydyxx t set t.shzt ='1' where (t.shzt !='2' or t.shzt !='1')  and t.yddbm like ?";
			int i = DBUtil.executeSQL(sql, departid + "%");
			if (i != -1) {
				return "执行成功!";
				// }
			}
		}
		throw new RuntimeException("未登录用户，无权限操作！");
	}

	/**
	 * 审核通过
	 * 
	 * @param ids wid 集合
	 * @return String
	 * @throws SQLException
	 */
	public String shtgCommit(String ids) throws SQLException {
		if (hasBeenLogining()) {
			ids = ids.replaceAll(",", "','"); // 将wid间的, 取代为','
			String sql = " update t_sport_ydyxx t set t.shzt ='2' where (t.shzt ='1' or t.shzt ='-1') and wid in ('"
					+ ids + "')";
			int i = DBUtil.executeSQL(sql);
			if (i != -1) {
				return "执行成功!";
			}
		}
		throw new RuntimeException("未登录用户，无权限操作！");
	}

	/**
	 * 审核退回
	 * 
	 * @param ids wid 集合
	 * @return String
	 * @throws SQLException
	 */
	public String shthCommit(String ids) throws SQLException {
		if (hasBeenLogining()) {
			ids = ids.replaceAll(",", "','"); // 将wid间的, 取代为','
			String sql = " update t_sport_ydyxx t set t.shzt ='-1' where (t.shzt ='1' or t.shzt ='2') and wid in ('"
					+ ids + "')";
			int i = DBUtil.executeSQL(sql);
			if (i != -1) {
				return "执行成功!";
			}
		}
		throw new RuntimeException("未登录用户，无权限操作！");
	}

	/**
	 * 更新运动员状态为 无效运动员
	 * 
	 * @param ids wid 集合
	 * @return String
	 * @throws SQLException
	 */
	public String updateydy(String ids) throws SQLException {
		if (hasBeenLogining()) {
			ids = ids.replaceAll(",", "','"); // 将wid间的, 取代为','
			String selSql = "select  count(*) from t_sport_ydyxx t where wid in ('" + ids
					+ "') and (t.shzt='1' or t.shzt='2')";
			int k = DBUtil.count(selSql);
			if (k > 0) {
				return "执行失败：当前运动员状态不允许执行此操作！";
			} else {
				String delSql = "delete  from t_sport_ydybmxm t where t.ydywid in ('" + ids + "')";
				int i = DBUtil.executeSQL(delSql);
				if (i != -1) {
					String sql = " update t_sport_ydyxx t set t.state ='0' where wid in ('" + ids + "')";
					DBUtil.executeSQL(sql);
				}
				return "执行成功！";
			}
		}
		throw new RuntimeException("未登录用户，无权限操作！");
	}

	/**
	 * 用于确认可选多项参赛项目
	 * 
	 * @param ids wid 集合
	 * @return String
	 * @throws SQLException
	 */
	public String submitRcbmxm(String ids) throws SQLException {
		if (hasBeenLogining()) {
			ids = ids.replaceAll(",", "','"); // 将wid间的, 取代为','
			String selSql = "select  count(*) from t_sport_ydyxx t where wid in ('" + ids
					+ "') and (t.shzt='1' or t.shzt='2')";
			int k = DBUtil.count(selSql);
			if (k > 0) {
				return "执行失败：当前运动员状态不允许执行此操作！";
			} else {
				String delSql = "delete  from t_sport_ydybmxm t where t.ydywid in ('" + ids + "')";
				int i = DBUtil.executeSQL(delSql);
				if (i != -1) {
					String sql = " update t_sport_ydyxx t set t.state ='0' where wid in ('" + ids + "')";
					DBUtil.executeSQL(sql);
				}
				return "执行成功！";
			}
		}
		throw new RuntimeException("未登录用户，无权限操作！");
	}

	/**
	 * 更新赛事日程的审核意见
	 * 
	 * @param ids wid 集合 shyj 审核意见
	 * @return String
	 * @throws SQLException
	 */
	public String changeShyj(String ids, String shyj, String shzt, String scbm) throws SQLException {
		if (hasBeenLogining()) {
			ids = ids.replaceAll(",", "','"); // 将wid间的, 取代为','
			if ("-2".equals(shzt)) { // 发布人退回赛程
				String sql = " update t_sport_ssrc t set t.shyj = '" + shyj + "' where t.wid in ('" + ids + "')";
				DBUtil.executeSQL(sql);
				return "执行成功！";
			} else if ("-1".equals(shzt)) { // 审核人退回成绩
				String sql = " update t_sport_ssrc t set t.shyj = '" + shyj + "' where t.wid = '" + scbm + "' ";
				DBUtil.executeSQL(sql);
				return "执行成功！";

			}

		}
		throw new RuntimeException("未登录用户，无权限操作！");
	}

	/**
	 * 用于确认可选多项参赛项目
	 * 
	 * @param ids wid集合
	 * @param ydybm
	 * @return String
	 * @throws SQLException
	 * @throws UnsupportedEncodingException
	 */
	public String submitXmbm(String ids, String ydybm, String xmmc) throws SQLException, UnsupportedEncodingException {

		if (hasBeenLogining()) {
			String str[] = ids.split(",");
			String ydybms[] = ydybm.split(",");
			String xmmcs[] = xmmc.split(",");
			List<String[]> strnew = new ArrayList<String[]>();
			List<TSportYdybmxm> stlist = new ArrayList<TSportYdybmxm>();
			for (int i = 0; i < str.length; i++) {
				String[] ff = new String[2];
				ff[0] = str[i];
				ff[1] = xmmcs[0];
				strnew.add(ff);
			}

			String sql = "delete from t_sport_ydybmxm a where a.ydywid in ('" + ydybm + "') ";
			DBUtil.executeSQL(sql);
			for (int i = 0; i < strnew.size(); i++) {
				for (String strs : ydybms) {
					TSportYdybmxm tsportYdybmxm = new TSportYdybmxm();
					tsportYdybmxm.setWid(SeqFactory.getNewSequenceAlone());// 自动获取wid
					tsportYdybmxm.setYdywid(strs);
					tsportYdybmxm.setBsxmwid(String.valueOf(strnew.get(i)[0]));
					String dxmmc = (String) (java.net.URLDecoder.decode(String.valueOf(strnew.get(i)[1]), "utf-8"));
					tsportYdybmxm.setDxmmc(dxmmc);
					stlist.add(tsportYdybmxm);
				}
			}

			if (stlist.size() > 0) {
				String sqlydy = " update t_sport_ydyxx t set t.state='1' where t.wid in ('" + ydybm + "')";
				DBUtil.executeSQL(sqlydy);
				this.baseDao.saveAll(stlist);
			}
			return "执行成功!";
		} else {
			throw new RuntimeException("未登录用户，无权限操作！");
		}

	}

	/**
	 * " wid之间 以 " or " 拼接
	 * 
	 * @param wids 集体成绩表 或 运动员成绩表 wid 集合
	 * @return
	 */
	public String widsLink(String[] wids) {

		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < wids.length; i++) {
			if (StringUtils.isNotBlank(wids[i])) {
				if (i == 0) {
					sb.append("  where wid='" + wids[i] + "' ");
				} else {
					sb.append(" or wid='" + wids[i] + "' ");
				}
			}
		}
		return sb.toString();
	}

	/**
	 * " wid之间 以 " , " 拼接
	 * 
	 * @param wids 集体成绩表 或 运动员成绩表 wid 集合
	 * @return
	 */
	public String widsLink2(String[] wids) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < wids.length; i++) {
			if (StringUtils.isNotBlank(wids[i])) {
				if (i == 0) {
					sb.append("'" + wids[i] + "' ");
				} else {
					sb.append(",'" + wids[i] + "' ");
				}
			}
		}
		return sb.toString();
	}

	/**
	 * 获取代表团比赛时间 ----- 代表团成绩查询
	 * 
	 * @param departid 代表团id
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getAllDbtTime(String departid, String dxmmc) throws UnsupportedEncodingException {
			String sql = " select to_char(a.bssj,'yyyy-MM-dd') as id, to_char(a.bssj,'yyyy-MM-dd') as caption  from t_sport_cj_td_mx t,t_sport_ssrc a  where t.scbm=a.wid and  t.departid=? ";
			if (StringUtils.isNotBlank(dxmmc)) {
				sql += " and t.dxmmc='" + java.net.URLDecoder.decode(dxmmc, "utf-8") + "' ";
			}
			sql += "group by to_char(a.bssj,'yyyy-MM-dd') order by to_char(a.bssj,'yyyy-MM-dd') ";
			List<ApplicationEnum> listapp = DBUtil.queryAllBeanList(sql, ApplicationEnum.class, departid);
			if (listapp.isEmpty()) {
				listapp = new ArrayList<ApplicationEnum>();
			}
			ApplicationEnum app = new ApplicationEnum();
			app.setId("all");
			app.setCaption("全部时间");
			listapp.add(0, app);
			return listapp;
	}

	/**
	 * 获取代表团比赛时间 ----- 代表团成绩查询
	 * 
	 * @param departid 代表团id
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws Exception
	 */

	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getDxmmcByTimeAndDbt(String departid) throws UnsupportedEncodingException {
			String sql = "select  a.dxmmc as id, a.dxmmc as caption from t_sport_cj_td_mx a,t_sport_ssrc b,t_sport_bsxm c  where a.scbm=b.wid  and  a.dxmmc=c.dxmmc and a.departid=? ";
			sql += " group by a.dxmmc,c.pxh order by c.pxh ";
			List<ApplicationEnum> listapp = DBUtil.queryAllBeanList(sql, ApplicationEnum.class, departid);
			if (listapp.isEmpty()) {
				listapp = new ArrayList<ApplicationEnum>();
			} else {
				for (ApplicationEnum app : listapp) {
					app.setId(java.net.URLEncoder.encode(app.getId(), "utf8"));
				}
			}
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择--");
			listapp.add(0, app);
			return listapp;
	}

	/**
	 * 获取代表团比赛时间 ----- 数据统计
	 * 
	 * @param departid 代表团id（可选）
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getDxmmcByTimeAndDbt2(String departid) throws UnsupportedEncodingException {
			String sql = "select  a.dxmmc as id, a.dxmmc as caption from t_sport_cj_td_mx a,t_sport_ssrc b  where a.scbm=b.wid  ";
			if (StringUtil.isNotBlank(departid)) {
				sql += " and a.departid='" + departid + "' ";
			}
			sql += " group by a.dxmmc ";
			List<ApplicationEnum> listapp = DBUtil.queryAllBeanList(sql, ApplicationEnum.class);
			if (listapp.isEmpty()) {
				listapp = new ArrayList<ApplicationEnum>();
			} else {
				for (ApplicationEnum app : listapp) {
					app.setId(java.net.URLEncoder.encode(app.getId(), "utf8"));
				}
			}
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择--");
			listapp.add(0, app);
			return listapp;
	}

	/**
	 * 获取代表团比赛时间 ----- 数据统计
	 * 
	 * @param departid 代表团id
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getAllDbtTime2(String departid, String dxmmc) throws UnsupportedEncodingException {
			String sql = " select to_char(a.bssj,'yyyy-MM-dd') as id, to_char(a.bssj,'yyyy-MM-dd') as caption  from t_sport_cj_td_mx t,t_sport_ssrc a  where t.scbm=a.wid  ";
			if (StringUtil.isNotBlank(departid)) {
				sql += " and t.departid='" + departid + "' ";
			}
			if (StringUtils.isNotBlank(dxmmc)) {
				sql += " and t.dxmmc='" + java.net.URLDecoder.decode(dxmmc, "utf-8") + "' ";
			}
			sql += "group by to_char(a.bssj,'yyyy-MM-dd') order by to_char(a.bssj,'yyyy-MM-dd') ";
			List<ApplicationEnum> listapp = DBUtil.queryAllBeanList(sql, ApplicationEnum.class);
			if (listapp.isEmpty()) {
				listapp = new ArrayList<ApplicationEnum>();
			}
			ApplicationEnum app = new ApplicationEnum();
			app.setId("all");
			app.setCaption("全部时间");
			listapp.add(0, app);
			return listapp;
	}

	/**
	 * 获取小项目根据时间、大项目名称 ----- 代表团成绩查询
	 * 
	 * @param departid 代表团id
	 * @param time 时间
	 * @param dxmmc 大项目名称
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getXxmmcByTimeAndDxmmc(String departid, String time, String dxmmc)
			throws UnsupportedEncodingException {
			String sql = " select b.xxmmc as id, b.xxmmc as caption from t_sport_cj_td_mx t,t_sport_ssrc a,t_sport_bsxm b  where t.scbm=a.wid and a.xmbm=b.wid and  t.departid=?";
			// 排除全部时间
			if (StringUtils.isNotBlank(time) && !"all".equals(time)) {
				sql += " and to_char(a.bssj,'yyyy-MM-dd')='" + time + "'";
			}
			if (StringUtils.isNotBlank(dxmmc)) {
				sql += " and b.dxmmc='" + java.net.URLDecoder.decode(dxmmc, "utf-8") + "'";
			}
			sql += "group by b.xxmmc ";
			List<ApplicationEnum> listapp = DBUtil.queryAllBeanList(sql, ApplicationEnum.class, departid);
			if (listapp.isEmpty()) {
				listapp = new ArrayList<ApplicationEnum>();
			} else {
				for (ApplicationEnum app : listapp) {
					app.setId(java.net.URLEncoder.encode(app.getId(), "utf8"));
				}
			}
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择--");
			listapp.add(0, app);
			return listapp;
	}

	/**
	 * 获取组别根据时间、大项目、小项目名称 ----- 代表团成绩查询
	 * 
	 * @param departid 代表团id
	 * @param time 时间
	 * @param dxmmc 大项目名称
	 * @param xxmmc 小项目名称
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getZbByTimeAndDxmmcAndXxmmc(String departid, String time, String dxmmc, String xxmmc)
			throws UnsupportedEncodingException {
			String sql = " select c.zdbm as id, c.zdmc as caption from t_sport_cj_td_mx t,t_sport_ssrc a,t_sport_bsxm b,t_sys_code c where t.scbm=a.wid and c.zdlb='BSXM_ZB' and c.zdbm=b.zb and a.xmbm=b.wid and  t.departid=?";
			// 排除全部时间
			if (StringUtils.isNotBlank(time) && !"all".equals(time)) {
				sql += " and to_char(a.bssj,'yyyy-MM-dd')='" + time + "'";
			}
			if (StringUtils.isNotBlank(dxmmc)) {
				sql += " and b.dxmmc='" + java.net.URLDecoder.decode(dxmmc, "utf-8") + "'";
			}
			if (StringUtils.isNotBlank(xxmmc)) {
				sql += " and  b.xxmmc='" + java.net.URLDecoder.decode(xxmmc, "utf-8") + "'";
			}
			sql += "  group by c.zdbm,c.zdmc ";
			List<ApplicationEnum> listapp = null;
			if (StringUtils.isNotBlank(dxmmc)) {
				listapp = DBUtil.queryAllBeanList(sql, ApplicationEnum.class, departid);
			}
			if (listapp == null) {
				listapp = new ArrayList<ApplicationEnum>();
			}
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择--");
			listapp.add(0, app);
			return listapp;
	}

	/**
	 * 获取组别根据时间、大项目、小项目名称 ----- 代表团成绩查询
	 * 
	 * @param departid 代表团id
	 * @param time 时间
	 * @param dxmmc 大项目名称
	 * @param xxmmc 小项目名称
	 * @param zb 组别
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getXbzByTimeAndDxmmcAndXxmmcAndZb(String departid, String time, String dxmmc,
			String xxmmc, String zb) throws UnsupportedEncodingException {
			String sql = " select c.zdbm as id, c.zdmc as caption from t_sport_cj_td_mx t,t_sport_ssrc a,t_sport_bsxm b,t_sys_code c where t.scbm=a.wid and c.zdlb='BSXM_XBZ' and c.zdbm=b.xbz and a.xmbm=b.wid and  t.departid=?";
			// 排除全部时间
			if (StringUtils.isNotBlank(time) && !"all".equals(time)) {
				sql += " and to_char(a.bssj,'yyyy-MM-dd')='" + time + "'";
			}
			if (StringUtils.isNotBlank(dxmmc)) {
				sql += " and b.dxmmc='" + java.net.URLDecoder.decode(dxmmc, "utf-8") + "'";
			}
			if (StringUtils.isNotBlank(xxmmc)) {
				sql += " and  b.xxmmc='" + java.net.URLDecoder.decode(xxmmc, "utf-8") + "'";
			}
			if (StringUtils.isNotBlank(zb)) {
				sql += " and   b.zb='" + zb + "'";
			}
			sql += "  group by c.zdbm,c.zdmc ";
			List<ApplicationEnum> listapp = null;
			if (StringUtils.isNotBlank(dxmmc)) {
				listapp = DBUtil.queryAllBeanList(sql, ApplicationEnum.class, departid);
			}
			if (listapp == null) {
				listapp = new ArrayList<ApplicationEnum>();
			}
			ApplicationEnum app = new ApplicationEnum();
			app.setId("");
			app.setCaption("--请选择--");
			listapp.add(0, app);
			return listapp;
	}

	/**
	 * 清除人员关联的大项目
	 * 
	 * @param wid
	 * @return
	 */
	public String delRy_Cc(String wid) {
		if (hasBeenLogining()) {
			if (StringUtils.isNotBlank(wid)) {
				String str[] = wid.split(",");
				StringBuilder sb = new StringBuilder();
				if (str != null) {
					for (int i = 0; i < str.length; i++) {
						if (i == 0) {
							sb.append(" t.ydywid='" + str[i] + "' ");
						} else {
							sb.append(" or  t.ydywid='" + str[i] + "' ");
						}
					}
				}
				String sql = " delete from t_sport_ydybmxm_cc t where " + sb.toString();
				int j = DBUtil.executeSQL(sql);
				if (j != -1) {
					return "yes";
				} else {
					return "no";
				}
			}
			return "no";
		} else {
			throw new RuntimeException("未登录用户，无权限操作！");
		}
	}

	/**
	 *  强制退回
	 * @param scbm //赛程编码
	 * @return
	 */
	public String shth_del(String scbm) {
		if (hasBeenLogining()) {
			// 删除 集体中的 相关数据 (事物处理)
			if (StringUtils.isNotBlank(scbm)) {
				org.hibernate.Session session = this.baseDao.getCurrentSession();
				Transaction tx1 = session.beginTransaction();
				String hqlDeleteCjJt = "delete TSportCjJt as t where t.scbm = :scbm";
				String hqlDeleteCjYdy = "delete TSportCjYdy as t where t.scbm = :scbm";
				String hqlUpdateSsrc = "update TSportSsrc as t set t.fbzt='-1' where t.wid = :scbm";
				session.createQuery(hqlDeleteCjJt).setString("scbm", scbm).executeUpdate();
				session.createQuery(hqlDeleteCjYdy).setString("scbm", scbm).executeUpdate();
				session.createQuery(hqlUpdateSsrc).setString("scbm", scbm).executeUpdate();
				tx1.commit();
				session.close();
				return "退回成功！";
			}
			return "退回失败！";
		} else {
			throw new RuntimeException("未登录用户，无权限操作！");
		}
	}
	
	/**
	 * 异步生成静态页面
	 */
	public void genPublicHtmlAsync(){
		if (hasBeenLogining()) {
			//服务器请求地址
			HttpServletRequest requet = WebContextFactory.get().getHttpServletRequest();
			String serverPath = requet.getScheme()+"://127.0.0.1:"+requet.getServerPort()+requet.getContextPath()+"/";
			//更新静态页面
			GenAllStaticHtml.gen(serverPath);
		}
	}

	/**
	 * 立即生成静态页面
	 * @throws IOException 
	 */
	public void genPublicHtmlNow() throws IOException{
		if (hasBeenLogining()) {
			//服务器请求地址
			HttpServletRequest requet = WebContextFactory.get().getHttpServletRequest();
			String serverPath = requet.getScheme()+"://127.0.0.1:"+requet.getServerPort()+requet.getContextPath()+"/";
			//更新静态页面
			GenAllStaticHtml.setServerPath(serverPath);
			GenAllStaticHtml.createHtmlAllPages();
		}
	}
}
