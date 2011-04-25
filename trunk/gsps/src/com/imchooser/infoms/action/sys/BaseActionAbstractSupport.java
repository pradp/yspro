package com.imchooser.infoms.action.sys;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.action.BaseAction;
import com.imchooser.framework.identity.entity.TSysMenu;
import com.imchooser.framework.identity.entity.TSysUser;
import com.imchooser.framework.identity.security.CheckLoginInterceptor;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.entity.biz.TSportSsrc;
import com.imchooser.infoms.entity.sys.ApplicationEnum;
import com.imchooser.infoms.entity.sys.TSysArea;
import com.imchooser.infoms.entity.sys.TSysButtonRule;
import com.imchooser.infoms.service.sys.ApplicationEnumService;
import com.imchooser.infoms.util.OpenTimeCtrlUtil;
import com.imchooser.infoms.util.PropConfigUtil;
import com.imchooser.util.DateUtil;
import com.imchooser.util.StringUtil;

/**
 * 业务系统的基类Action 抽象、封装了一些共用业务方法
 * 
 * @author yangjianliang 2008-9-5
 */
@SuppressWarnings( { "serial", "unchecked" })
public abstract class BaseActionAbstractSupport extends BaseAction {

	private static final Log LOG = LogFactory.getLog(BaseActionAbstractSupport.class);

	/**
	 * 系统数据字典
	 */
	protected ApplicationEnumService applicationEnumService;

	/**
	 * 该系统中所有表的主键都是wid，所以抽象它放到这里
	 */
	private String wid;

	public ApplicationEnumService getApplicationEnumService() {
		return applicationEnumService;
	}

	public void setApplicationEnumService(ApplicationEnumService applicationEnumService) {
		this.applicationEnumService = applicationEnumService;
	}

	public String getWid() {
		return wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	/**
	 * 系统字典
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getSysCode() {

		String zdlb = getParameter("zdlb");
		return getSysCode(zdlb);
	}

	/**
	 * 系统字典
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getSysCode(String zdlb) {

		List<ApplicationEnum> list = null;
		if (zdlb != null) {
			String hql = "select new ApplicationEnum(t.zdbm,t.zdmc) from TSysCode t where t.zdlb=? and t.sfsy='1' order by length(t.zdbm), t.zdbm ";
			list = applicationEnumService.getApplicationEnums(true, hql, zdlb);
		} else {
			list = new ArrayList<ApplicationEnum>(0);
		}
		return list;
	}

	/**
	 * 系统字典类别
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getSysCodeSort() {

		String hql = "select new ApplicationEnum(t.zdlb,t.lbmc) from TSysCodeSort t group by t.zdlb,t.lbmc order by t.zdlb";
		return applicationEnumService.getApplicationEnums(true, hql);
	}

	/**
	 * 性别
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getXb() {
		setParameter("zdlb", "xb");
		List<ApplicationEnum> list = getSysCode();
		ApplicationEnum a = new ApplicationEnum();
		a.setId("");
		a.setCaption("--请选择--");
		list.add(0, a);
		return list;
	}

	/**
	 * 所在高校
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getMyDeparts() {
		String mydepartid = getDepartID();
		String hql = "select new ApplicationEnum(departid,departname) from TSysDepart where state='1' and departid like '"
				+ mydepartid + "%' order by departid";
		return applicationEnumService.getApplicationEnums(false, hql);
	}

	/**
	 * 为了兼容以前的写法
	 * 
	 * @deprecated
	 * @return 当前登录用户的对象
	 */
	public TSysUser getUser() {
		return getLoginUser();
	}

	/**
	 * 历史年度，用于业务查询
	 * 
	 * @param entityName 要查询的表对象名称
	 * @param nd 年度字段列名称
	 * @return 历史年度列表
	 */
	public List<ApplicationEnum> getNd(String entityName, String nd) {
		StringBuffer hql = new StringBuffer("");
		String _nd_ = "substr(" + nd + ",0,4)";
		hql.append("select new ApplicationEnum(").append(_nd_).append(" as bbnd1, ").append(_nd_).append(
				" as bbnd2 ) from ").append(entityName).append(" group by ").append(_nd_).append(" order by ").append(
				_nd_).append(" desc");
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(false, hql.toString());
		ApplicationEnum a = new ApplicationEnum();
		a.setId("");
		a.setCaption("--请选择--");
		list.add(0, a);
		for (int i = 0; i < list.size(); i++) {
			ApplicationEnum b = list.get(i);
			if (StringUtils.isBlank(b.getCaption())) {
				list.remove(i);
				i--;
			}
		}
		return list;
	}

	/**
	 * 开放时间段控制模块中，用到的功能按钮列表
	 * 
	 * @return 功能按钮列表
	 */
	public List<ApplicationEnum> getButtonList() {
		// 对本方法添加功能类型，需要同步更新Constants类里的常量。
		List<ApplicationEnum> list = new ArrayList<ApplicationEnum>(10);
		list.add(new ApplicationEnum(Constants.BUTTON_TYPE_ADD, "新增"));
		list.add(new ApplicationEnum(Constants.BUTTON_TYPE_MODIFY, "修改"));
		list.add(new ApplicationEnum(Constants.BUTTON_TYPE_DEL, "删除"));
		list.add(new ApplicationEnum(Constants.BUTTON_TYPE_SAVE, "保存"));
		list.add(new ApplicationEnum(Constants.BUTTON_TYPE_EXPORT, "导出"));
		list.add(new ApplicationEnum(Constants.BUTTON_TYPE_PRINT, "打印"));
		list.add(new ApplicationEnum(Constants.BUTTON_TYPE_HANDOVER, "上报"));
		list.add(new ApplicationEnum(Constants.BUTTON_TYPE_APPROVE, "审批"));

		return list;
	}

	/**
	 * 查询按钮控制规则
	 * 
	 * @param menuId 菜单编号
	 * @param buttonEnumId 按钮类型编号
	 * @return 规则对象
	 */
	public TSysButtonRule getMenuButtonRule(String menuId, String buttonEnumId) {

		TSysButtonRule buttonRule = null;
		String hql = "select a from TSysButtonRule a, TSysButtonEnumRule b "
				+ "where a.wid=b.buttonRuleId and a.state='1' and b.menuId=? and b.buttonEnumId=? order by a.wid desc";

		List<TSysButtonRule> list = applicationEnumService.getApplicationEnums(true, hql, menuId, buttonEnumId);
		if (list != null && !list.isEmpty()) {
			buttonRule = list.get(0);
		}
		return buttonRule;
	}

	/**
	 * 判断当前访问的页面上的指定类型的按钮是否允许使用
	 * 
	 * @param buttonTypeEnumValue 按钮类型枚举值 引用Constants获取
	 * @return 要显示的按钮符合规则，返回true，否则返回false
	 */
	public boolean getButton(String buttonTypeEnumValue) {

		if (StringUtils.isBlank(buttonTypeEnumValue)) {
			addActionError("功能按钮类型不对！");
			return false;
		}
		boolean hasPermission = false;

		HttpServletRequest request = getRequest();

		TSysMenu menu = CheckLoginInterceptor.getCurrentAccessedMenuObject(request);
		if (menu != null) {
			// 获取到当前访问的菜单对象后，查询它的开放规则
			String menuid = menu.getMenuid();
			TSysButtonRule tsysButtonRule = getMenuButtonRule(menuid, buttonTypeEnumValue);

			if (tsysButtonRule == null) {// 规则没禁用，或者根本没有定义规则。默认开放。
				hasPermission = true;
			} else {
				hasPermission = OpenTimeCtrlUtil.checkButtonPermission(tsysButtonRule);
			}

		} else {
			LOG.info("查询当前访问的页面的MENU_ID为null！该页面上的按钮访问都将默认为允许使用。");
			hasPermission = false;
		}
		return hasPermission;
	}

	/**
	 * 获取参数值
	 * 
	 * @param key
	 * @return
	 */
	public String getHiddenValue(String key) {
		return getParameter(key);
	}

	/**
	 * 今日赛程 （页面显示快速导航）
	 */
	public List<TSportSsrc> todaySc(String rsDate) {
		// TODO 该方法性能杀手
		if (StringUtil.isBlank(rsDate)) {
			// 项目数据完成时 撤销注释
			rsDate = DateUtil.currentDateString();
			// 测试虚拟用 默认
			// rsDate = "2010-03-20";
		}
		this.setParameter("rsDate", rsDate);
		// t.scbm=2 赛次编码 =‘2’ 1：预赛 ; 2：决赛；3：复赛
		String hql = "select new TSportSsrc (b.dxmmc,to_char(count(t.wid))) from TSportSsrc t,TSportBsxm b "
				+ "where to_char(t.bssj,'yyyy-MM-dd')=? and t.xmbm=b.wid and t.scbm='2' group by b.dxmmc";
		List<TSportSsrc> list = applicationEnumService.getBaseDao().findByHql(hql, rsDate);
		if (list != null) {
			return list;
		} else {
			return new ArrayList<TSportSsrc>(0);
		}
	}

	private static List<Object[]> historyGames;
	private static int lastDay = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);

	/**
	 * 历史赛程（页面右边显示快速导航） 查询最近结束的4条比赛
	 */
	public static List<Object[]> getHistoryGames() {
		if (historyGames == null) {
			String date = DateUtil.currentDateString();
			String sql = "select * from (select aa.dxmmc, sum(aa.dd), aa.bssj from"
					+ " (select b.dxmmc dxmmc,count(t.wid) dd ,to_char(t.bssj,'yyyy-MM-dd') bssj from T_Sport_Ssrc t,T_Sport_Bsxm b"
					+ " where t.xmbm=b.wid and to_char(t.bssj,'yyyy-MM-dd')<? and t.scbm=? and t.fbzt='3' group by b.dxmmc,to_char(t.bssj,'yyyy-MM-dd'))"
					+ " aa group by aa.bssj,aa.dxmmc order by aa.bssj desc) where rownum<5";
			historyGames = DBUtil.queryAllList(sql, date, "2");// 2是数据字典里的决赛的标记
		} else {
			int currentDay = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
			if (currentDay != lastDay) {// 一天刷新一次
				String date = DateUtil.currentDateString();
				String sql = "select * from (select aa.dxmmc, sum(aa.dd), aa.bssj from"
						+ " (select b.dxmmc dxmmc,count(t.wid) dd ,to_char(t.bssj,'yyyy-MM-dd') bssj from T_Sport_Ssrc t,T_Sport_Bsxm b"
						+ " where t.xmbm=b.wid and to_char(t.bssj,'yyyy-MM-dd')<? and t.scbm=? and t.fbzt='3' group by b.dxmmc,to_char(t.bssj,'yyyy-MM-dd'))"
						+ " aa group by aa.bssj,aa.dxmmc order by aa.bssj desc) where rownum<5";
				historyGames = DBUtil.queryAllList(sql, date, "2");// 2是数据字典里的决赛的标记
				lastDay = currentDay;
			}
		}

		return historyGames;
	}

	/**
	 * 登录后显示的 历史比赛记录
	 * 
	 * @return
	 */

	public void getHistoryGamesLogined() {
		String departid = this.getDepartID();
		List<Object[]> objs = null;
		List<String> list = new ArrayList<String>();
		if (StringUtils.isNotBlank(departid)) {
			String date = DateUtil.currentDateString();
			String sql = "select * from (select bb.scbm,bb.dxmmc, bb.xxmmc , bb.bssj,bb.cj,bb.sfdzxm,bb.info,bb.sfjtxm,bb.sfjs,bb.sfxnsc  from (select  b.scbm scbm ,max(b.dxmmc) dxmmc ,max(b.xxmmc) xxmmc ,(select to_char(m.bssj,'yyyy-MM-dd') from t_sport_ssrc m where m.wid=b.scbm) bssj,"
					+ "( case when b.scbm in (select a.wid from t_sport_ssrc a , t_sport_bsxm c where c.sfdzxm='1' and a.xmbm=c.wid ) then (select replace(regexp_replace(replace(wmsys.wm_concat(g.dbtmc||' '||g.cj ||'@'||g.dbtmc ),',',':'),'@(.){2,}:(.){2,} ',':'),'@', ' ')   from  t_sport_cj_jt g where g.scbm=b.scbm ) "
					+ "else "
					+ "to_char (max(b.df))end ) cj,(select (select h.sfdzxm from t_sport_bsxm h where h.wid=g.xmbm) from t_sport_ssrc g where g.wid=b.scbm ) sfdzxm, "
					+ "  (select (to_char(g.bssj,'yyyy-MM-dd hh24:mi')||(select '、'|| c.dxmmc from t_sport_bsxm c where c.wid=g.xmbm)||(select '、'||(select u.zdmc from t_sys_code u where u.zdlb='BSXM_ZB' and u.zdbm=c.zb) from t_sport_ssrc m,t_sport_bsxm c where c.wid=m.xmbm  and m.wid=g.wid)||(select '、'||(select u.zdmc from t_sys_code u where u.zdlb='BSXM_XBZ' and u.zdbm=c.xbz) from t_sport_ssrc m,t_sport_bsxm c where c.wid=m.xmbm  and m.wid=g.wid)||(select '、'||c.xxmmc from t_sport_bsxm c where c.wid=g.xmbm)||(select '、'|| u.zdmc from t_sys_code u where u.zdlb='SSRC_SCBM' and u.zdbm=g.scbm)||  case when  (select(select u.zdmc from t_sys_code u where u.zdlb='SSRC_BPFZ' and u.zdbm=m.bpfz) from t_sport_ssrc m where m.wid=g.wid) is null then '' else (select '、'||(select u.zdmc from t_sys_code u where u.zdlb='SSRC_BPFZ' and u.zdbm=m.bpfz) from t_sport_ssrc m where m.wid=g.wid)  end) from t_sport_ssrc g where g.wid=b.scbm ) info, "
					+ "  (select (select b.sfjtxm from t_sport_bsxm b where b.wid=a.xmbm) from  t_sport_ssrc a  where a.wid=b.scbm)  sfjtxm,b.sfjs sfjs,(select j.sfxnsc from t_sport_ssrc j where j.wid=b.scbm) sfxnsc  from t_sport_cj_jt b where  b.scbm in (select a.wid from  t_sport_ssrc a  where  a.fbzt='3' "
					+
					// "and a.sfxnsc!='1'  " +
					" and  to_char(a.bssj,'yyyy-MM-dd')<? ) and b.departid=?  group by b.scbm ,b.sfjs "
					+ "union"
					+ " select d.scbm scbm ,max(d.dxmmc) dxmmc ,max(d.xxmmc) xxmmc ,(select to_char(m.bssj,'yyyy-MM-dd') bssj from t_sport_ssrc m where m.wid=d.scbm) bssj ,to_char(max(d.df))cj,(select h.sfdzxm from t_sport_bsxm h where h.wid=a.xmbm)sfdzxm, "
					+ " (select (to_char(g.bssj,'yyyy-MM-dd hh24:mi')||(select '、'||c.dxmmc from t_sport_bsxm c where c.wid=g.xmbm)||(select '、'||(select u.zdmc from t_sys_code u where u.zdlb='BSXM_ZB' and u.zdbm=c.zb) from t_sport_ssrc m,t_sport_bsxm c where c.wid=m.xmbm  and m.wid=g.wid)||(select '、'|| (select u.zdmc from t_sys_code u where u.zdlb='BSXM_XBZ' and u.zdbm=c.xbz) from t_sport_ssrc m,t_sport_bsxm c where c.wid=m.xmbm  and m.wid=g.wid)||(select '、'||c.xxmmc from t_sport_bsxm c where c.wid=g.xmbm)||(select '、'|| u.zdmc from t_sys_code u where u.zdlb='SSRC_SCBM' and u.zdbm=g.scbm)|| case when (select(select u.zdmc from t_sys_code u where u.zdlb='SSRC_BPFZ' and u.zdbm=m.bpfz) from t_sport_ssrc m where m.wid=g.wid) is null then '' else  (select '、'||(select u.zdmc from t_sys_code u where u.zdlb='SSRC_BPFZ' and u.zdbm=m.bpfz) from t_sport_ssrc m where m.wid=g.wid) end ) from t_sport_ssrc g where g.wid=a.scbm ) info, "
					+ "  (select b.sfjtxm from t_sport_bsxm b where b.wid=a.xmbm) sfjtxm,d.sfjs sfjs,a.sfxnsc as sfxnsc from t_sport_ssrc a , t_sport_cj_ydy d"
					+ " where a.fbzt='3' and a.wid=d.scbm " +
					// "and a.sfxnsc !='1'" +
					" and a.xmbm in (select c.wid from t_sport_bsxm c where c.sfdzxm='1' ) and d.sfjtxm='0' and to_char(a.bssj,'yyyy-MM-dd')<? and d.departid=?  group by  d.scbm ,a.xmbm,a.scbm,d.sfjs,a.sfxnsc) bb order by  bb.bssj desc) where rownum<5";
			objs = DBUtil.queryAllList(sql, date, departid, date, departid);// 2是数据字典里的决赛的标记

			for (Object[] obj : objs) {
				boolean bool = true;
				if (list.size() > 0) {
					for (String str : list) {
						if (obj[3] != null && str.equals(String.valueOf(obj[3]))) {
							bool = false;
						}
					}
				} else {
					if (obj[3] != null) {
						list.add(String.valueOf(obj[3]));
						bool = false;
					}

				}
				if (bool) {
					if (obj[3] != null) {
						list.add(String.valueOf(obj[3]));
					}

				}

			}
		}

		this.setParameter("loginedHistoryGames", objs == null ? Collections.EMPTY_LIST : objs);
		this.setParameter("dates", list);
	}

	/**
	 * 2010-03-20 格式为 2010年3月20日
	 * 
	 * @param str
	 * @return
	 */
	public static String dateFomart(String str) {
		if (StringUtil.isNotBlank(str)) {
			String strs[] = str.split("-");
			if (strs.length == 3) {
				return strs[0] + "年" + Integer.parseInt(strs[1]) + "月" + Integer.parseInt(strs[2]) + "日";
			} else {
				return "";
			}
		} else {
			return "";
		}
	}

	private static List<ApplicationEnum> list_dxmmc;

	/**
	 * 获得所有大项目名称
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getAllDxmmc() {
		if (list_dxmmc == null) {
			String hql = "select new ApplicationEnum(a.dxmmc,a.dxmmc )from TSportBsxm a  group by a.dxmmc,a.pxh order by a.pxh";
			list_dxmmc = applicationEnumService.getBaseDao().findByHql(hql);
			if (list_dxmmc != null) {
				try {
					for (ApplicationEnum app : list_dxmmc) {
						app.setId(java.net.URLEncoder.encode(app.getId(), "UTF-8"));
					}
				} catch (UnsupportedEncodingException e) {
					LOG.error(e);
				}
				return list_dxmmc;
			} else {
				return Collections.EMPTY_LIST;
			}
		} else {
			return list_dxmmc;
		}
	}

	private static Map<String, String> mapDxmmc;

	/**
	 * 获得所有大项目名称Map
	 * 
	 * @return
	 */
	public Map<String, String> getAllDxmmcMap() {
		if (mapDxmmc == null) {
			mapDxmmc = new HashMap<String, String>();
			String hql = "select new ApplicationEnum(a.dxmmc,a.dxmmc )from TSportBsxm a  group by a.dxmmc,a.pxh order by a.pxh";
			List<ApplicationEnum> list_dxmmc2 = applicationEnumService.getBaseDao().findByHql(hql);
			if (list_dxmmc2 != null) {
				for (ApplicationEnum app : list_dxmmc2) {
					mapDxmmc.put(app.getId(), app.getCaption());
				}
				return mapDxmmc;
			} else {
				return Collections.EMPTY_MAP;
			}
		} else {
			return mapDxmmc;
		}
	}

	/**
	 * 获得所有大项目名称Map
	 * 
	 * @return
	 */
	public Map<String, String> getAllXxmmcMap() {
		Map<String, String> mapXxmmc = new HashMap<String, String>();
			String dxmmc = this.getParameter("dxmmc");
			String bsxmwid = this.getParameter("bsxmwid");
			if(StringUtils.isNotBlank(dxmmc)){
				String hql = "select new ApplicationEnum(a.wid,a.xxmmc )from TSportBsxm a where a.dxmmc=? " +
						" and a.zb=(select b.zb  from TSportBsxm b where b.wid=? )" +
						" and a.xbz=(select b.xbz  from TSportBsxm b where b.wid=? )" +
						" group by a.xxmmc,a.wid,a.pxh order by a.pxh";
				List<ApplicationEnum> list_xxmmc2 = applicationEnumService.getBaseDao().findByHql(hql,dxmmc,bsxmwid,bsxmwid);
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
	/**
	 * 获得代表团名称
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getDbtmc() {
		String hql = "select new ApplicationEnum(t.departid,replace(t.departname,'市','') ) from TSysDepart t  where  length(t.departid)=6 ";
		List<ApplicationEnum> list = applicationEnumService.getBaseDao().findByHql(hql);
		if (list != null) {
			return list;
		} else {
			return new ArrayList<ApplicationEnum>(0);
		}
	}

	/**
	 * 获得代表团名称 --- 代表团成绩查询（增加全部代表团）
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getDbtmc2() {
		String hql = "select new ApplicationEnum(t.departid,replace(t.departname,'市','') ) from TSysDepart t  where  length(t.departid)=6  order by t.departcode";
		List<ApplicationEnum> list = applicationEnumService.getBaseDao().findByHql(hql);
		ApplicationEnum app = new ApplicationEnum();
		app.setId("all");
		app.setCaption("全部代表团");
		return list;
	}

	/**
	 * 获得代表团名称(运动员成绩登记)
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getDbtmc4Ydydj() {
		String hql = "select t.departid as id ,replace(t.departname,'市','') as caption  from T_Sys_Depart t  where  length(t.departid)=6 order by NLSSORT(t.departname,'NLS_SORT = SCHINESE_PINYIN_M') ";
		List<ApplicationEnum> list = DBUtil.queryAllBeanList(hql, ApplicationEnum.class);
		if (list != null) {
			for (ApplicationEnum app : list) {
				app.setId(app.getId() + "_" + app.getCaption());
			}
			return list;
		} else {
			return new ArrayList<ApplicationEnum>(0);
		}
	}

	private static List<String[]> listDate;// 赛事日程列表
	private static int dateIndex;// 最近比赛日期在日程列表中的下标
	private static String lastDateIndexDay;// 最近日期
	private static int maxDay; // 比赛总天数
	private static int middleDay; // 比赛日期页面中间的下标
	private static Map mapDate = new HashMap<String, String>(); // key: 时间

	// value: 索引 用于
	// 滑动选中时间的自动居中
	// mi值 =
	// 索引（value）

	public static void setListDate(List<String[]> listDate) {
		BaseActionAbstractSupport.listDate = listDate;
	}

	public static List<String[]> getListDate() throws Exception {
		if (StringUtils.isBlank(lastDateIndexDay) || !DateUtil.currentDateString().equals(lastDateIndexDay)
				|| (null == listDate || listDate.isEmpty())) {
			List<String[]> listDateD = new ArrayList<String[]>();
			String sql = "select substr(a.da,0,10),sum(c) from (select  to_char(bssj,'yyyy-MM-dd HH24:mi') as da,count(*) c from t_sport_ssrc group by to_char(bssj,'yyyy-MM-dd HH24:mi') ) a" +
					" group by  substr(a.da,0,10) order by substr(a.da,0,10)";
			List<Object[]> list = DBUtil.queryAllList(sql);
			for (int i = list.size() - 1; i > -1; i--) {
				String[] oo = new String[4];
				Object[] o = list.get(i);
				if (null != o && null != o[0] && null != o[1]) {
					String date = String.valueOf(o[0]);
					String c = o[1].toString();
					oo[0] = date.substring(5, 7) + "月  " + DateUtil.getWeekDay(date);
					oo[1] = date.substring(8);
					oo[2] = c;
					oo[3] = date;
					listDateD.add(0, oo);
				}
			}
			listDate = listDateD;
			lastDateIndexDay = DateUtil.currentDateString();
			dateIndex = getColseDay();
			putMapDate();
		}
		return listDate;
	}

	public static int getDateIndex() {
		if (StringUtils.isBlank(lastDateIndexDay)) {
			lastDateIndexDay = DateUtil.currentDateString();
			dateIndex = getColseDay();
		} else {
			if (!DateUtil.currentDateString().equals(lastDateIndexDay)) {
				dateIndex = getColseDay();
				lastDateIndexDay = DateUtil.currentDateString();
			}
		}
		return dateIndex;
	}

	/**
	 * 取最近的日期所在的索引
	 * 
	 * @param listDate 日期集合
	 * @return
	 */
	public static int getColseDay() {
		String sql = "select distinct to_char(bssj,'yyyy-mm-dd') as da from t_sport_ssrc where bssj is not null order by to_char(bssj,'yyyy-mm-dd')";
		List<Object[]> list = DBUtil.queryAllList(sql);
		int index = 0;
		if (!list.isEmpty()) {
			long min = DateUtil.dateDayInteval(DateUtil.currentDateString(), list.get(0)[0].toString());
			for (int i = 0; i < list.size(); i++) {
				long c = DateUtil.dateDayInteval(DateUtil.currentDateString(), list.get(i)[0].toString());
				if (!(c > Math.abs(min))) {
					index = i;
					min = c;
				}
			}
		}
		return index;
	}

	/**
	 * 获取比赛日程天数
	 * 
	 * @return
	 * @throws Exception
	 */
	public static int getMaxDay() throws Exception {
		if (maxDay == 0) {
			maxDay = DBUtil
					.count("select count(*) from (select 1 from t_sport_ssrc  group by to_char(bssj,'yyyy-mm-dd'))");
		}
		return maxDay;
	}

	/**
	 * 赛事日程天数 默认下标
	 * 
	 * @return
	 * @throws Exception
	 */
	public int getMiddleDay() throws Exception {
		if (middleDay == 0) {
			int index = getColseDay();
			int c = getMaxDay();
			if (index < 4) {
				middleDay = 3;
			} else if (index > c - 5) {
				middleDay = c - 4;
			} else {
				middleDay = index;
			}
		}
		return middleDay;
	}

	public static void putMapDate() throws Exception {
		if (mapDate != null && mapDate.size() == 0) {
			if (listDate != null) {
				for (int i = 0; i < listDate.size(); i++) {
					mapDate.put(listDate.get(i)[3], String.valueOf(i));
				}
			}

		}
	}

	public String getMi(String bssj) throws Exception {
		getListDate();
		return mapDate.get(bssj).toString();
	}

	private static int countThisDay; // 当前日期的比赛项目数
	private static String thisDay; // 当前日期

	public static String getThisDay() throws Exception {
		if (StringUtils.isBlank(thisDay) || !dateFomart(DateUtil.currentDateString()).equals(thisDay)) {
			countThisDay = DBUtil
					.count(
							"select count(*) from t_sport_ssrc where to_char(bssj,'yyyy-mm-dd') = ? ",
							DateUtil.currentDateString());
			thisDay = dateFomart(DateUtil.currentDateString());
		}
		return thisDay;
	}

	public static int getCountThisDay() {
		return countThisDay;
	}

	private List<Object[]> todayCsxm;

	/**
	 * 获得 登录团队的今日参赛的项目
	 * 
	 * @return
	 */
	public List<?> getTodayCsxm() {
		String date = DateUtil.currentDateString();
		// String date = "2010-03-20";
		String departid = this.getDepartID();
		String sql = "select  b.dxmmc,b.xxmmc,a.wid,a.fbzt,c.sfjtxm,a.sfxnsc,c.sfdzxm,replace(to_char(a.bssj,'yyyy-MM-dd HH24:mi')||'  '||c.xxmmc||'，'||"+
		"(select g.zdmc from t_sys_code g where g.zdlb='SSRC_SCBM' and g.zdbm=a.scbm)||'，'||"+
		"(select g.zdmc from t_sys_code g where g.zdlb='SSRC_BPFZ' and g.zdbm=a.bpfz)||' '||a.bscd,'，','、')  from t_sport_ssrc a left join t_sport_cj_jt b on a.wid=b.scbm left join t_sport_bsxm c on c.wid=a.xmbm where to_char(a.bssj,'yyyy-MM-dd')='"
				+ date
				+ "' and b.departid='"
				+ departid
				+ "'  and a.SFXNSC !='1' group by b.dxmmc,b.xxmmc,a.wid,a.fbzt,c.sfjtxm,a.sfxnsc,c.sfdzxm,c.xxmmc,a.bssj,a.scbm,a.bpfz,a.bscd   "
				+ "union"
				+ " select  c.dxmmc,c.xxmmc , a.wid ,a.fbzt,e.sfjtxm,a.sfxnsc,e.sfdzxm,replace(to_char(a.bssj,'yyyy-MM-dd HH24:mi')||'  '||e.xxmmc||'，'||"+
				"(select g.zdmc from t_sys_code g where g.zdlb='SSRC_SCBM' and g.zdbm=a.scbm)||'，'||"+
				"(select g.zdmc from t_sys_code g where g.zdlb='SSRC_BPFZ' and g.zdbm=a.bpfz)||' '||a.bscd,'，','、')   from t_sport_ssrc a left join t_sport_cj_ydy c on a.wid=c.scbm left join t_sport_bsxm e on e.wid=a.xmbm where to_char(a.bssj,'yyyy-MM-dd')='"
				+ date
				+ "' and c.departid='"
				+ departid
				+ "'   and a.SFXNSC !='1' group by c.dxmmc,c.xxmmc,a.wid,a.fbzt,e.sfjtxm,a.sfxnsc,e.sfdzxm ,e.xxmmc,a.bssj,a.scbm,a.bpfz,a.bscd  ";
		todayCsxm = DBUtil.queryAllList(sql);
		for (Object[] obj : todayCsxm) {
			if (obj[1] != null) {
				if (String.valueOf(obj[1]).length() > 15) {
					obj[1] = String.valueOf(obj[1]).substring(0, 12) + "...";
				}
			}
		}
		return todayCsxm;
	}

	/**
	 * 查询通知公告
	 * 
	 * @return
	 */
	public List<Object[]> getMessage() {
		List<Object[]> message;
		String sql = " select t.wid,t.xxbt,xxnr from t_sys_message t where rownum<5 order by t.xxfssj desc ";
		message = DBUtil.queryAllList(sql);
		return message;
	}

	// 开幕式时间
	private static String kmssj;
	// 闭幕式时间
	private static String bmssj;

	/**
	 * 获得 开幕式、闭幕式时间
	 */
	public static String getKmssj() {
		if (StringUtil.isBlank(kmssj)) {
			kmssj = PropConfigUtil.get("bskssj");
		}
		return kmssj;
	}

	public static String getBmssj() {
		if (StringUtil.isBlank(bmssj)) {
			bmssj = PropConfigUtil.get("bsjssj");
		}
		return bmssj;
	}

	/**
	 * 获得发布状态列表
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getFbztList() {
		String hql = "select new ApplicationEnum(t.zdbm,t.zdmc) from TSysCode t where t.zdlb='FBZT' ";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		if (list != null) {
			return list;
		} else {
			return new ArrayList<ApplicationEnum>(0);
		}
	}

	/**
	 * 获得 组别
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public List<ApplicationEnum> getBsxmZb() throws UnsupportedEncodingException {
		String bsxm = this.getParameter("bsxm");
		if (StringUtil.isBlank(bsxm)) {
			bsxm = this.getParameter("dxmmc");
		}
		String hql = "select new ApplicationEnum(t.zdbm,t.zdmc) from TSysCode t where t.zdlb='BSXM_ZB'  and t.zdbm in (select a.zb from TSportBsxm a where a.dxmmc='"
				+ bsxm + "' ) group by t.zdmc,t.zdbm ";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		return list;
	}

	/**
	 * 获得 性别组
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public List<ApplicationEnum> getBsxmXbz() throws UnsupportedEncodingException {
		String bsxm = this.getParameter("bsxm");
		if (StringUtil.isBlank(bsxm)) {
			bsxm = this.getParameter("dxmmc");
		}
		String hql = "select new ApplicationEnum(t.zdbm,t.zdmc) from TSysCode t where t.zdlb='BSXM_XBZ' and t.zdbm in (select a.xbz from TSportBsxm a where a.dxmmc='"
				+ bsxm + "' ) group by t.zdmc,t.zdbm ";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		return list;
	}

	/**
	 * 获得小项目
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public List<ApplicationEnum> getBsxmByName() throws UnsupportedEncodingException {
		String bsxm = this.getParameter("bsxm");
		if (StringUtil.isBlank(bsxm)) {
			bsxm = this.getParameter("dxmmc");
		}
		String sql = "select xxmmc as id,xxmmc as caption from T_Sport_Bsxm a where a.dxmmc=? group by a.xxmmc order by  f_pinyin(xxmmc),xxmmc";
		List<ApplicationEnum> list = (List<ApplicationEnum>) DBUtil.queryAllBeanList(sql, ApplicationEnum.class, bsxm);
		if (list != null) {
			for (ApplicationEnum app : list) {
				app.setId(java.net.URLEncoder.encode(app.getId(), "utf8"));
			}
		}

		return list;
	}

	/**
	 * 获得 所有比赛时间
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<ApplicationEnum> getBssjList() throws Exception {
		String bsxm = this.getParameter("dxmmc");
		String sql = "select to_char(a.bssj,'yyyy-MM-dd') as id ,to_char(a.bssj,'yyyy-MM-dd') as caption from t_sport_ssrc a ,t_sport_bsxm b where a.xmbm=b.wid and b.dxmmc=? group by to_char(a.bssj,'yyyy-MM-dd') order by to_char(a.bssj,'yyyy-MM-dd')";
		List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class, bsxm);
		return list;
	}

	/**
	 * 获得 比赛时间
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<ApplicationEnum> getBssjList1() throws Exception {
		String sql = "select to_char(a.bssj,'yyyyMMdd') as id ,to_char(a.bssj,'yyyy-MM-dd') as caption from t_sport_ssrc a ,t_sport_bsxm b where a.xmbm=b.wid  group by to_char(a.bssj,'yyyy-MM-dd'),to_char(a.bssj,'yyyyMMdd') order by to_char(a.bssj,'yyyy-MM-dd') desc";
		List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class);
		return list;
	}
	
	/**
	 * 获得赛次
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public List<ApplicationEnum> getBsxmSc() throws UnsupportedEncodingException {
		String hql = "select new ApplicationEnum(a.zdbm,a.zdmc) from TSysCode a where a.zdlb='SSRC_SCBM' ";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		return list;
	}

	/**
	 * 获得代表地名称
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public List<ApplicationEnum> getDbdName() throws UnsupportedEncodingException {
		String sql = "select a.areaname as id,a.areaname as caption from t_sys_area a where 1=1 and a.arealevel='2'";
		List<ApplicationEnum> list = (List<ApplicationEnum>) DBUtil.queryAllBeanList(sql, ApplicationEnum.class);
		return list;
	}

	/**
	 * 获得代表团名称
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public List<ApplicationEnum> getDbdMc() throws UnsupportedEncodingException {
		String sql = "select a.areaid as id,a.areaname as caption from t_sys_area a where 1=1 and a.arealevel='2'";
		List<ApplicationEnum> list = (List<ApplicationEnum>) DBUtil.queryAllBeanList(sql, ApplicationEnum.class);
		return list;
	}

	/**
	 * 获得代表团
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public List<TSysArea> getDbt() throws UnsupportedEncodingException {
		String hql = " select new TSysArea( t.areaid, substr(t.areaname,1,length(t.areaname)-1) as areaname ) "
				+ "from TSysArea t where t.arealevel='2'";
		List<TSysArea> list = applicationEnumService.getApplicationEnums(true, hql);
		return list;

	}

	/**
	 * 刷新业务数据缓存
	 * 
	 * @return
	 * @throws Exception
	 */
	public String sxhc() throws Exception {
		if (applicationEnumService != null) {
			// 刷新历史赛程
			historyGames = null;
			getHistoryGames();
			// 刷新大项目名称
			list_dxmmc = null;
			getAllDxmmc();
			// 刷新当前日期的比赛项目数
			thisDay = null;

			getThisDay();
			// 刷新赛事日程日期控件
			listDate = null;
			getListDate();
			this.setParameter("mess", "刷新缓存成功！");
		} else {
			this.setParameter("mess", "刷新缓存失败！");
		}
		return "sxhc";
	}

	public Map<String, String> getBsLx() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("1", "已结束");
		map.put("0", "未结束");
		return map;

	}
}