package com.imchooser.infoms.service.biz.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.imchooser.framework.identity.entity.TSysMenu;
import com.imchooser.framework.identity.entity.TSysRoleMenu;
import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.PropDbUtil;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.action.biz.DtbdManagePageAction;
import com.imchooser.infoms.entity.biz.TDtbdCreatetable;
import com.imchooser.infoms.entity.biz.TDtbdCreatetableFieldinfo;
import com.imchooser.infoms.service.biz.DTBDManagePageService;
import com.imchooser.infoms.util.SysConfigUtil;
import com.imchooser.util.Char2spell;
import com.imchooser.util.DateUtil;

/**
 * 动态表单管理员服务类
 * 
 * @author zhuzhonglei
 */
public class DtbdManagePageServiceImpl extends BaseServiceAbstractSupport implements DTBDManagePageService {

	private static Logger log = Logger.getLogger(DtbdManagePageServiceImpl.class);

	private static Map<String, String> map = new HashMap<String, String>();

	static {
		map.put("1", "省中心");
		map.put("6", "高校");
		map.put("8", "高中");
		map.put("7", "市县");
		map.put("9", "院系");
	}

	public List<?> list(Object arg0, Pager pager) throws Exception {

		pager.setTotalRows(DBUtil.count("SELECT COUNT(wid) FROM t_dtbd_createtable"));
		String SQL = "SELECT wid,tablename,chinesename,createuser,createtime,remarks FROM t_dtbd_createtable ORDER BY createtime DESC";

		return DBUtil.queryPageList(pager, SQL);
	}

	public void load(Object arg0) throws Exception {
		DtbdManagePageAction action = (DtbdManagePageAction) arg0;
		String wid = action.getParameter("wid");

		TDtbdCreatetable tableInfo = getBaseDao().findById(TDtbdCreatetable.class, wid);
		action.setTableInfo(tableInfo);

		// 流程
		StringBuilder val = new StringBuilder();
		for (String sub : tableInfo.getSbgz().split(":")) {
			val.append(sub + ",");
		}
		val.deleteCharAt(val.length() - 1);
		action.setParameter("lcsx", val.toString());

		List<TDtbdCreatetableFieldinfo> tdArrList = this
				.getBaseDao()
				.findByHql(
						"FROM TDtbdCreatetableFieldinfo WHERE createTableID=? AND depttype=? AND fieldName LIKE 'FIELD%' ORDER BY wid ASC",
						wid, tableInfo.getSbgz().split(":")[0]);
		action.setListField(tdArrList);
	}

	public boolean remove(Object arg0) throws Exception {
		DtbdManagePageAction action = (DtbdManagePageAction) arg0;
		String[] wids = action.getWid().split(",");
		for (Object wid : wids) {
			TDtbdCreatetable tdbd = getBaseDao().findFieldValue("FROM TDtbdCreatetable WHERE wid=?", wid);
			for(String menuit:tdbd.getMenuid().split(",")){
				this.getBaseDao().deleteAll("TSysMenu", "menuid", "=", menuit);
				this.getBaseDao().deleteAll("TSysRoleMenu", "menuid", "=", menuit);
			}
			this.getBaseDao().deleteAll("TDtbdCreatetable", "wid", "=", (String) wid);
			this.getBaseDao().deleteAll("TSysPropertity", "csmc", "=", "BBND_" + tdbd.getTableName().toUpperCase());
			this.getBaseDao().deleteAll("TSysPropertity", "csmc", "=", "BBYF_" + tdbd.getTableName().toUpperCase());
			this.getBaseDao().deleteAll("TDtbdCreatetableFieldinfo", "createTableID", "=", (String) wid);
			this.getBaseDao().getCurrentSession().createSQLQuery("DROP TABLE " + tdbd.getTableName()).executeUpdate();
			this.getBaseDao().getCurrentSession().createSQLQuery("DROP TABLE " + tdbd.getTableName() + "_HZ")
					.executeUpdate();
		}

		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {
		DtbdManagePageAction action = (DtbdManagePageAction) arg0;
		TDtbdCreatetable tableInfo = action.getTableInfo();
		// 流程获取
		StringBuilder buliLC = new StringBuilder();
		if (null != action.getParameters("lcsx")) {
			Object[] arr = action.getParameters("lcsx");
			for (Object a : arr) {
				buliLC.append(a + ":");
			}
		} else {
			if (null != action.getParameters("lcgx")) {
				Object[] arr = action.getParameters("lcgx");
				for (Object a : arr) {
					buliLC.append(a + ":");
				}
			}
		}
		StringBuilder val = new StringBuilder(); // 传回页面的流程
		for (String sub : buliLC.toString().split(":")) {
			val.append(sub + ",");
		}
		val.deleteCharAt(val.length() - 1);
		action.setParameter("lcsx", val.toString());

		// 移出空值
		for (int i = 0; i < action.getListField().size(); i++) {
			Object obj = action.getListField().get(i);
			if (null == obj || StringUtils.isBlank(((TDtbdCreatetableFieldinfo) obj).getFieldChineseName())) {
				action.getListField().remove(obj);
				i--;
				continue;
			}
		}
		// 删除列
		StringBuffer colErr = new StringBuffer();
		for (String wid : action.getParameter("delids").split(",")) {
			if (StringUtils.isBlank(wid))
				continue;

			Object fieldName = getBaseDao().findFieldValue(
					"select fieldName from TDtbdCreatetableFieldinfo WHERE wid=?", wid);

			int i = DBUtil.count("SELECT COUNT(" + fieldName + ") FROM " + tableInfo.getTableName() + " WHERE "
					+ fieldName + " IS NOT NULL");
			if (i <= 0) {// 判断该列是否有数据
				Object createID = DBUtil.queryFieldValue(
						"SELECT createtableid FROM t_dtbd_createtable_fieldinfo WHERE wid=?", wid);

				this.getBaseDao().getCurrentSession().createSQLQuery(
						"ALTER TABLE " + tableInfo.getTableName() + " DROP COLUMN " + fieldName).executeUpdate();
				this.getBaseDao().getCurrentSession().createSQLQuery(
						"DELETE FROM t_dtbd_createtable_fieldinfo WHERE createtableid='" + createID
								+ "' AND fieldname='" + fieldName + "'").executeUpdate();
			} else {
				colErr.append(fieldName + " 列 |  ");
			}
		}
		// 发送提示信息
		if (colErr.length() > 0) {
			action.setParameter("err", colErr + " 不能删除,请删除该列数据后删除该列！");
		}

		if (StringUtils.isNotBlank(tableInfo.getWid())) {
			String wid = tableInfo.getWid();

			Object name = DBUtil.queryFieldValue("SELECT tablename FROM t_dtbd_createtable WHERE wid=?", wid);

			if (!tableInfo.getTableName().equals(name)) {
				this.getBaseDao().getCurrentSession().createSQLQuery(
						"alter table " + name + " rename to " + tableInfo.getTableName()).executeUpdate();
				this.getBaseDao().getCurrentSession().createSQLQuery(
						"UPDATE t_dtbd_createtable SET tablename='" + tableInfo.getTableName() + "',chinesename='"
								+ tableInfo.getChineseName() + "',remarks='" + tableInfo.getRemarks() + "' WHERE wid='"
								+ wid + "'").executeUpdate();

			} else {
				this.getBaseDao().getCurrentSession().createSQLQuery(
						"UPDATE t_dtbd_createtable SET tablename='" + tableInfo.getTableName() + "',chinesename='"
								+ tableInfo.getChineseName() + "',remarks='" + tableInfo.getRemarks() + "' WHERE wid='"
								+ wid + "'").executeUpdate();
			}
			// 修改表字段长度

			// 获取流程
			Object lc = tableInfo.getSbgz();

			val = new StringBuilder(); // 传回页面的流程
			for (String sub : lc.toString().split(":")) {
				val.append(sub + ",");
			}
			val.deleteCharAt(val.length() - 1);
			action.setParameter("lcsx", val.toString());

			for (TDtbdCreatetableFieldinfo dtbd : action.getListField()) {
				if (StringUtils.isBlank(dtbd.getWid())) {
					StringBuffer addSQL = new StringBuffer("alter table " + tableInfo.getTableName() + " add(");
					if (StringUtils.isBlank(dtbd.getFieldChineseName())) {
						break;
					}
					SimpleDateFormat form = new SimpleDateFormat("yyyyMMddHHmmssSS");
					String suffix = form.format(new Date());
					String myfieldType = null;
					if ("1".equals(dtbd.getFieldType())) { // 数字类型
						myfieldType = " NUMBER(";
						if (StringUtils.isNotBlank(dtbd.getFieldLength())) {
							myfieldType += dtbd.getFieldLength() + ")";
						} else {
							myfieldType += "50)";
						}
					} else if ("4".equals(dtbd.getFieldType()) || "5".equals(dtbd.getFieldType())) { // 日期时间格式
						myfieldType = " DATE";
					} else {
						myfieldType = " VARCHAR2(";
						if (StringUtils.isNotBlank(dtbd.getFieldLength())) {
							myfieldType += dtbd.getFieldLength() + ")";
						} else {
							myfieldType += "50)";
						}
					}
					addSQL.append("FIELD" + suffix + myfieldType + ",");

					dtbd.setWid(SeqFactory.getNewSequenceAlone());
					dtbd.setCreateTableID(wid);
					dtbd.setFieldName("FIELD" + suffix);
					dtbd.setIsMustIn((null != dtbd.getIsMustIn() && ("true").equals(dtbd.getIsMustIn()) ? "1" : "0"));
					dtbd.setDepttype(lc.toString().split(":")[0]);

					// 组装新增列数据

					addSQL.deleteCharAt(addSQL.length() - 1);
					addSQL.append(")");
					if (addSQL.indexOf("FIELD") != -1) {
						getBaseDao().getCurrentSession().createSQLQuery(addSQL.toString()).executeUpdate();
					}
				}
			}
			getBaseDao().saveOrUpdateAll(action.getListField());

		} else {
			tableInfo.setTableName("T_DTBD_" + Char2spell.getPYString(tableInfo.getChineseName()).toUpperCase());

			tableInfo.setTableName(getTableNameEN(tableInfo.getTableName()));

			int c = DBUtil.count("select count(*) from dba_tables WHERE table_name=?", tableInfo.getTableName());
			if (c > 0) {
				SimpleDateFormat format = new SimpleDateFormat("hhmmss");
				tableInfo.setTableName(tableInfo.getTableName() + format.format(new Date()));
			}

			// 创建实体表
			StringBuffer createTableSQL = new StringBuffer();
			createTableSQL.append("create table " + tableInfo.getTableName().toUpperCase());
			createTableSQL.append("(");
			createTableSQL.append("WID VARCHAR2(50) not null,");
			// 用户定义类型
			createTableSQL.append("TJSJ VARCHAR2(50),");
			createTableSQL.append("TBRQ VARCHAR2(50),");
			createTableSQL.append("BBND VARCHAR2(4),");
			if ("1".equals(tableInfo.getHzlx())) {
				createTableSQL.append("BBYF VARCHAR2(2),");
			}
			createTableSQL.append("DWBM VARCHAR2(50),");
			createTableSQL.append("SHZT VARCHAR2(50)");
			for (int i = 0; i < action.getListField().size(); i++) {
				TDtbdCreatetableFieldinfo dtbd = action.getListField().get(i);
				if (null != dtbd.getFieldChineseName() && !"".equals(dtbd.getFieldChineseName())) {
					dtbd.setFieldName("FIELD" + i);
					createTableSQL.append(","
							+ dtbd.getFieldName().toUpperCase()
							+ " "
							+ ("0".equals(dtbd.getFieldType()) ? "VARCHAR2("
									+ (null == dtbd.getFieldLength() || "".equals(dtbd.getFieldLength()) ? "50" : dtbd
											.getFieldLength()) + ")" : "NUMBER"));
				}
			}

			createTableSQL.append(")");
			// 定义主键
			int end = tableInfo.getTableName().length() < 22 ? tableInfo.getTableName().length() - 1 : 22;// 控制主键名称长度在10个
			StringBuffer createTablePrimary = new StringBuffer();
			createTablePrimary
					.append("alter table " + tableInfo.getTableName() + "  add constraint PK_"
							+ tableInfo.getTableName().substring(0, end).toUpperCase() + " primary key (WID)"
							+ "  using index");

			this.getBaseDao().getCurrentSession().createSQLQuery(createTableSQL.toString()).executeUpdate();
			this.getBaseDao().getCurrentSession().createSQLQuery(createTablePrimary.toString()).executeUpdate();
			// 创建汇总表
			StringBuffer hzSQL = new StringBuffer();
			hzSQL.append("create table " + tableInfo.getTableName().toUpperCase() + "_HZ");
			hzSQL.append("(");
			hzSQL.append("WID VARCHAR2(50) not null,");
			hzSQL.append("BBND VARCHAR2(4),");
			if ("1".equals(tableInfo.getHzlx())) {
				hzSQL.append("BBYF VARCHAR2(2),");
			}
			hzSQL.append("SHZT VARCHAR2(50),");
			hzSQL.append("DWBM VARCHAR2(50),");
			hzSQL.append("SHSJ VARCHAR2(50),");
			hzSQL.append("TJSJ VARCHAR2(50),");
			hzSQL.append("JLZS VARCHAR2(50),");
			hzSQL.append("SHYJ VARCHAR2(200)");
			hzSQL.append(")");
			// 汇总表主键
			int hzEnd = tableInfo.getTableName().length() < 19 ? tableInfo.getTableName().length() - 1 : 19;// 控制主键名称长度在10个
			StringBuffer hzPrimary = new StringBuffer();
			hzPrimary.append("alter table " + tableInfo.getTableName() + "_HZ  add constraint PK_HZ_"
					+ tableInfo.getTableName().substring(0, hzEnd).toUpperCase() + " primary key (WID)"
					+ "  using index");
			getBaseDao().getCurrentSession().createSQLQuery(hzSQL.toString()).executeUpdate();
			getBaseDao().getCurrentSession().createSQLQuery(hzPrimary.toString()).executeUpdate();

			// 添加表信息
			String wid = SeqFactory.getNewSequenceAlone();
			tableInfo.setWid(wid);
			tableInfo.setCreateUser(action.getUserLoginId());
			tableInfo.setCreateTime(DateUtil.currentDateTimeString());
			tableInfo.setTableName(tableInfo.getTableName().toUpperCase());
			tableInfo.setCreateSQL(createTableSQL.toString());
			tableInfo.setSbgz(buliLC.toString());

			getBaseDao().save(tableInfo);

			// 添加表字段信息
			int index = 0;
			List<Object[]> listFields = new ArrayList<Object[]>();
			List<Object[]> listHZ = new ArrayList<Object[]>();

			List<TDtbdCreatetableFieldinfo> defineFields = new ArrayList<TDtbdCreatetableFieldinfo>();
			for (String deptType : buliLC.toString().split(":")) {
				if (index == 0) {// 判断是否是最低级权限
					for (TDtbdCreatetableFieldinfo dtbd : action.getListField()) {
						if (StringUtils.isBlank(dtbd.getFieldName())) {
							continue;
						}
						if (StringUtils.isBlank(dtbd.getFieldLength())) {
							if ("0".equals(dtbd.getFieldType())) {
								dtbd.setFieldLength("50");
							} else {
								dtbd.setFieldLength("10");
							}
						}

						dtbd.setWid(SeqFactory.getNewSequenceAlone());
						dtbd.setCreateTableID(wid);
						dtbd.setDepttype(deptType);
						dtbd.setIsNull((null != dtbd.getIsNull() && dtbd.getIsNull().equals("true") ? "1" : "0"));
						dtbd.setIsFieldQuery("0");
					}
					// 添加默认列信息
					listFields.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "TJSJ", "提交时间", "0", "50", "",
							"1", "提交时间", deptType, "0" });
					listFields.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "TBRQ", "填报时间", "0", "50", "",
							"1", "填报时间", deptType, "0" });
					listFields.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "BBND", "报表年度", "0", "4", "",
							"1", "报表年度", deptType, "1" });
					if ("1".equals(tableInfo.getHzlx())) {
						listFields.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "BBYF", "报表月份", "0", "2",
								"", "1", "报表月份", deptType, "1" });
					}
					listFields.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "DWBM", "单位编码", "0", "50", "",
							"1", "存放数据录入的部门ID", deptType, "0" });
					listFields.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "SHZT", "审核状态", "0", "50", "",
							"1", "", deptType, "0" });

					for (Object[] obj : listFields) {
						TDtbdCreatetableFieldinfo fieldInfo = new TDtbdCreatetableFieldinfo();
						fieldInfo.setWid(SeqFactory.getNewSequenceAlone());
						fieldInfo.setCreateTableID(obj[1].toString());
						fieldInfo.setFieldName(obj[2].toString());
						fieldInfo.setFieldChineseName(obj[3].toString());
						fieldInfo.setFieldType(obj[4].toString());
						fieldInfo.setFieldLength(obj[5].toString());
						fieldInfo.setFieldDefine(obj[6].toString());
						fieldInfo.setIsNull(obj[7].toString());
						fieldInfo.setRemarks(obj[8].toString());
						fieldInfo.setDepttype(obj[9].toString());
						fieldInfo.setIsFieldQuery(obj[10].toString());
						if ("SHZT".equals(fieldInfo.getFieldName())) {
							fieldInfo.setFieldDisplayName(fieldInfo.getFieldChineseName());
							fieldInfo.setIsFieldDisplay("1");
						}
						defineFields.add(fieldInfo);
					}

				} else {
					// 清空集合
					listHZ.clear();
					// 汇总表数据
					listHZ.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "BBND", "报表年度", "报表年度", "1", "1",
							deptType });

					if ("1".equals(tableInfo.getHzlx())) {
						listHZ.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "BBYF", "报表月份", "报表月份", "1",
								"2", deptType });
					}
					listHZ.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "SHZT", "审核状态", "审核状态", "1", "3",
							deptType });
					listHZ.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "DWBM", "单位编码", "单位编码", "1", "4",
							deptType });
					listHZ.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "SHSJ", "审核时间", "审核时间", "1", "5",
							deptType });
					listHZ.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "TJSJ", "提交时间", "提交时间", "1", "6",
							deptType });
					listHZ.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "JLZS", "记录条数", "记录条数", "1", "7",
							deptType });
					listHZ.add(new Object[] { SeqFactory.getNewSequenceAlone(), wid, "SHYJ", "审核意见", "审核意见", "1", "8",
							deptType });
					// 付值对象
					for (Object[] obj : listHZ) {
						TDtbdCreatetableFieldinfo fieldInfo = new TDtbdCreatetableFieldinfo();
						fieldInfo.setWid(SeqFactory.getNewSequenceAlone());
						fieldInfo.setCreateTableID(obj[1].toString());
						fieldInfo.setFieldName(obj[2].toString());
						fieldInfo.setFieldChineseName(obj[3].toString());
						fieldInfo.setFieldDisplayName(obj[4].toString());
						fieldInfo.setIsFieldDisplay(obj[5].toString());
						fieldInfo.setFieldOrder(obj[6].toString());
						fieldInfo.setDepttype(obj[7].toString());

						this.getBaseDao().save(fieldInfo);
					}
				}

				index++;// 只取第一个Type的值做为设置控制界面
			}

			getBaseDao().saveAll(action.getListField());// 更新数据库
			getBaseDao().saveAll(defineFields);// 更新默认字段

			// 自动创建菜单
			try {
				this.setMenuRole(arg0, wid, buliLC.toString());
			} catch (Exception ex) {
				log.error(ex);
			}

		}

	}

	public void saveconfigFiledIn(Object obj) {
		DtbdManagePageAction action = (DtbdManagePageAction) obj;
		String tableWid = action.getParameter("wid");
		action.setParameter("wid", tableWid);
		TDtbdCreatetable tableInfo = new TDtbdCreatetable();
		if (StringUtils.isNotBlank(tableWid)) {
			tableInfo = (TDtbdCreatetable) getBaseDao().findById(TDtbdCreatetable.class, tableWid);
		}
		String typeLX = "";
		action.setTableInfo(tableInfo);
		try {
			typeLX = tableInfo.getSbgz();
		} catch (Exception ex) {
			log.error("查询错误！");
		}

		String curr = "";
		if (StringUtils.isBlank(action.getParameter("DeptType"))) {
			curr = typeLX.split(":")[0];
		} else {
			curr = action.getParameter("DeptType");
		}

		// 传入页面类型
		Map<String, String> showMap = new HashMap<String, String>();
		for (String t : typeLX.split(":")) {
			showMap.put(t, map.get(t));
		}
		action.setParameter("DeptType", showMap);
		action.setParameter("cindex", curr);

		// 更新
		if (null != action.getParameter("save") && action.getParameter("save").equals("1")) {

			for (TDtbdCreatetableFieldinfo dtbd : action.getListField()) {
				dtbd.setFieldDisplayName((dtbd.getIsFieldDisplay().equals("true") && (null == dtbd
						.getFieldDisplayName() || "".equals(dtbd.getFieldDisplayName()))) ? dtbd.getFieldChineseName()
						: dtbd.getFieldDisplayName());
				dtbd.setIsFieldEnter(null != dtbd.getIsFieldEnter() && dtbd.getIsFieldEnter().equals("true") ? "1"
						: "0");
				dtbd
						.setIsFieldDisplay(null != dtbd.getIsFieldDisplay() && dtbd.getIsFieldDisplay().equals("true") ? "1"
								: "0");
				dtbd.setIsFieldQuery(null != dtbd.getIsFieldQuery() && dtbd.getIsFieldQuery().equals("true") ? "1"
						: "0");
				dtbd.setIsStatistics(null != dtbd.getIsStatistics() && dtbd.getIsStatistics().equals("true") ? "1"
						: "0");
				dtbd.setIsSum(null != dtbd.getIsSum() && dtbd.getIsSum().equals("true") ? "1" : "0");
				dtbd.setIsAvg(null != dtbd.getIsAvg() && dtbd.getIsAvg().equals("true") ? "1" : "0");
				dtbd.setFzzd(null != dtbd.getFzzd() && dtbd.getFzzd().equals("true") ? "1" : "0");
				dtbd.setIsMustIn(null != dtbd.getIsMustIn() && dtbd.getIsMustIn().equals("true") ? "1" : "0");

				if (null != dtbd.getFieldDisplayName() && !"".equals(dtbd.getFieldDisplayName())) {
					this.getBaseDao().getCurrentSession().createSQLQuery(
							"UPDATE t_dtbd_createtable_fieldinfo SET FIELDDISPLAYNAME='" + dtbd.getFieldDisplayName()
									+ "' WHERE FIELDNAME='" + dtbd.getFieldName() + "' AND createtableid='"
									+ dtbd.getCreateTableID() + "'").executeUpdate();
				}
			}

			this.getBaseDao().saveOrUpdateAll(action.getListField());

			// 获取是否统计记录条数
			String isCount = (null != action.getParameter("isCount") && action.getParameter("isCount").equals("true")) ? "1"
					: "0";
			this.getBaseDao().getCurrentSession().createSQLQuery(
					"UPDATE t_dtbd_createtable SET SFTJTS='" + isCount + "' WHERE wid='" + tableWid + "'")
					.executeUpdate();

			// 设置年度默认值
			String tbnd = action.getParameter("TBND");
			String tbyf = action.getParameter("TBYF");

			Object tableName = "";
			try {
				tableName = DBUtil.queryFieldValue("SELECT TABLENAME FROM t_dtbd_createtable WHERE wid=?", tableWid);
			} catch (SQLException e) {
				log.error(e);
			}

			this.getBaseDao().getCurrentSession().createSQLQuery(
					"UPDATE t_sys_propertity SET cs='" + tbnd + "' WHERE csmc='" + "BBND_" + tableName + "'")
					.executeUpdate();
			if (StringUtils.isNotBlank(tbyf)) {
				this.getBaseDao().getCurrentSession().createSQLQuery(
						"UPDATE t_sys_propertity SET cs='" + tbyf + "' WHERE csmc='" + "BBYF_" + tableName + "'")
						.executeUpdate();
			}
			// 刷新系统参数缓存
			PropDbUtil.loadSysProps();
			// 创建与删除字段
			String[] arrSbgz = typeLX.split(":");

			for (TDtbdCreatetableFieldinfo info : action.getListField()) {
				if ("1".equals(info.getIsSum())) {// 新增总额字段
					if (null == info.getFieldsum() || "".equals(info.getFieldsum())) {
						this.getBaseDao().getCurrentSession().createSQLQuery(
								"alter table " + tableName + "_HZ add " + info.getFieldName() + "_SUM NUMBER")
								.executeUpdate();
						info.setFieldsum(info.getFieldName() + "_SUM");
						// 新增列信息
						if (arrSbgz.length > 2) {
							TDtbdCreatetableFieldinfo subInfoA = new TDtbdCreatetableFieldinfo();
							subInfoA.setWid(SeqFactory.getNewSequenceAlone());
							subInfoA.setCreateTableID(tableWid);
							subInfoA.setFieldName(info.getFieldsum());
							subInfoA.setFieldDisplayName(info.getFieldDisplayName() + "(SUM)");
							subInfoA.setIsFieldDisplay("1");
							subInfoA.setDepttype(arrSbgz[1]);
							this.getBaseDao().save(subInfoA);
							TDtbdCreatetableFieldinfo subInfoB = new TDtbdCreatetableFieldinfo();
							subInfoB.setWid(SeqFactory.getNewSequenceAlone());
							subInfoB.setCreateTableID(tableWid);
							subInfoB.setFieldName(info.getFieldsum());
							subInfoB.setFieldDisplayName(info.getFieldDisplayName() + "(SUM)");
							subInfoB.setIsFieldDisplay("1");
							subInfoB.setDepttype(arrSbgz[2]);
							this.getBaseDao().save(subInfoB);
						} else {
							TDtbdCreatetableFieldinfo subInfoA = new TDtbdCreatetableFieldinfo();
							subInfoA.setWid(SeqFactory.getNewSequenceAlone());
							subInfoA.setCreateTableID(tableWid);
							subInfoA.setFieldName(info.getFieldsum());
							subInfoA.setFieldDisplayName(info.getFieldDisplayName() + "(SUM)");
							subInfoA.setIsFieldDisplay("1");
							subInfoA.setDepttype(arrSbgz[1]);
							this.getBaseDao().save(subInfoA);
						}
					}
				} else {// 删除总额字段
					if (null != info.getFieldsum() && !"".equals(info.getFieldsum())) {
						this.getBaseDao().getCurrentSession().createSQLQuery(
								"alter table " + tableName + "_HZ drop column " + info.getFieldName() + "_SUM")
								.executeUpdate();
						info.setFieldsum("");
						// 删除列信息
						this.getBaseDao().getCurrentSession().createSQLQuery(
								"DELETE FROM t_dtbd_createtable_fieldinfo WHERE createtableid='" + tableWid
										+ "' AND fieldname='" + info.getFieldName() + "_SUM" + "'").executeUpdate();
					}
				}
				if ("1".equals(info.getIsAvg())) {// 新增平均字段
					if (null == info.getFieldavg() || "".equals(info.getFieldavg())) {
						this.getBaseDao().getCurrentSession().createSQLQuery(
								"alter table " + tableName + "_HZ add " + info.getFieldName() + "_AVG NUMBER")
								.executeUpdate();
						info.setFieldavg(info.getFieldName() + "_AVG");
						// 新增列信息
						if (arrSbgz.length > 2) {
							TDtbdCreatetableFieldinfo subInfoA = new TDtbdCreatetableFieldinfo();
							subInfoA.setWid(SeqFactory.getNewSequenceAlone());
							subInfoA.setCreateTableID(tableWid);
							subInfoA.setFieldName(info.getFieldavg());
							subInfoA.setFieldDisplayName(info.getFieldDisplayName() + "(AVG)");
							subInfoA.setIsFieldDisplay("1");
							subInfoA.setDepttype(arrSbgz[1]);
							this.getBaseDao().save(subInfoA);
							TDtbdCreatetableFieldinfo subInfoB = new TDtbdCreatetableFieldinfo();
							subInfoB.setWid(SeqFactory.getNewSequenceAlone());
							subInfoB.setCreateTableID(tableWid);
							subInfoB.setFieldName(info.getFieldavg());
							subInfoB.setFieldDisplayName(info.getFieldDisplayName() + "(AVG)");
							subInfoB.setIsFieldDisplay("1");
							subInfoB.setDepttype(arrSbgz[2]);
							this.getBaseDao().save(subInfoB);
						} else {
							TDtbdCreatetableFieldinfo subInfoA = new TDtbdCreatetableFieldinfo();
							subInfoA.setWid(SeqFactory.getNewSequenceAlone());
							subInfoA.setCreateTableID(tableWid);
							subInfoA.setFieldName(info.getFieldavg());
							subInfoA.setFieldDisplayName(info.getFieldDisplayName() + "(AVG)");
							subInfoA.setIsFieldDisplay("1");
							subInfoA.setDepttype(arrSbgz[1]);
							this.getBaseDao().save(subInfoA);
						}
					}
				} else {// 删除平均字段
					if (null != info.getFieldavg() && !"".equals(info.getFieldavg())) {
						this.getBaseDao().getCurrentSession().createSQLQuery(
								"alter table " + tableName + "_HZ drop column " + info.getFieldName() + "_AVG")
								.executeUpdate();
						info.setFieldavg("");
						// 删除列信息
						this.getBaseDao().getCurrentSession().createSQLQuery(
								"DELETE FROM t_dtbd_createtable_fieldinfo WHERE createtableid='" + info.getFieldName()
										+ "_AVG" + "' AND fieldname='" + tableWid + "'").executeUpdate();
					}
				}
				if ("1".equals(info.getIsStatistics())) {// 新增统计字段
					if (null == info.getFieldtj() || "".equals(info.getFieldtj())) {
						this.getBaseDao().getCurrentSession().createSQLQuery(
								"alter table " + tableName + "_HZ add " + info.getFieldName() + "_TJ NUMBER")
								.executeUpdate();
						info.setFieldtj(info.getFieldName() + "_TJ");
						// 新增列信息
						if (arrSbgz.length > 2) {
							TDtbdCreatetableFieldinfo subInfoA = new TDtbdCreatetableFieldinfo();
							subInfoA.setWid(SeqFactory.getNewSequenceAlone());
							subInfoA.setCreateTableID(tableWid);
							subInfoA.setFieldName(info.getFieldtj());
							subInfoA.setFieldDisplayName(info.getFieldDisplayName() + "(TJ)");
							subInfoA.setIsStatistics("1");
							subInfoA.setDepttype(arrSbgz[1]);
							this.getBaseDao().save(subInfoA);
							TDtbdCreatetableFieldinfo subInfoB = new TDtbdCreatetableFieldinfo();
							subInfoB.setWid(SeqFactory.getNewSequenceAlone());
							subInfoB.setCreateTableID(tableWid);
							subInfoB.setFieldName(info.getFieldtj());
							subInfoB.setFieldDisplayName(info.getFieldDisplayName() + "(TJ)");
							subInfoB.setIsStatistics("1");
							subInfoB.setDepttype(arrSbgz[2]);
							this.getBaseDao().save(subInfoB);
						} else {
							TDtbdCreatetableFieldinfo subInfoA = new TDtbdCreatetableFieldinfo();
							subInfoA.setWid(SeqFactory.getNewSequenceAlone());
							subInfoA.setCreateTableID(tableWid);
							subInfoA.setFieldName(info.getFieldavg());
							subInfoA.setFieldDisplayName(info.getFieldDisplayName() + "(TJ)");
							subInfoA.setIsStatistics("1");
							subInfoA.setDepttype(arrSbgz[1]);
							this.getBaseDao().save(subInfoA);
						}
					}
				} else {// 删除统计字段
					if (null != info.getFieldavg() && !"".equals(info.getFieldavg())) {
						this.getBaseDao().getCurrentSession().createSQLQuery(
								"alter table " + tableName + "_HZ drop column " + info.getFieldName() + "_TJ")
								.executeUpdate();
						info.setFieldtj("");
						// 删除列信息
						this.getBaseDao().getCurrentSession().createSQLQuery(
								"DELETE FROM t_dtbd_createtable_fieldinfo WHERE createtableid='" + tableWid
										+ "' AND fieldname='" + info.getFieldName() + "'").executeUpdate();
					}
				}
			}

			// 更新字段信息表
			this.getBaseDao().saveOrUpdateAll(action.getListField());
			action.addActionMessage("操作成功");
		}

		if (null != tableWid && !"".equals(tableWid)) {
			action.getListField().clear();
			try {
				List<TDtbdCreatetableFieldinfo> arr = this.getBaseDao().findByHql(
						"FROM TDtbdCreatetableFieldinfo WHERE createTableID=? AND depttype=? ORDER BY wid ASC",
						tableWid, curr);
				action.setListField(arr);
				for (TDtbdCreatetableFieldinfo info : action.getListField()) {
					info.setIsAvg(null != info.getIsAvg() && info.getIsAvg().equals("1") ? "true" : "false");
					info
							.setIsFieldDisplay(null != info.getIsFieldDisplay() && info.getIsFieldDisplay().equals("1") ? "true"
									: "false");
					info.setIsFieldEnter(null != info.getIsFieldEnter() && info.getIsFieldEnter().equals("1") ? "true"
							: "false");
					info.setIsFieldQuery(null != info.getIsFieldQuery() && info.getIsFieldQuery().equals("1") ? "true"
							: "false");
					info.setIsMustIn(null != info.getIsMustIn() && info.getIsMustIn().equals("1") ? "true" : "false");
					info.setIsStatistics(null != info.getIsStatistics() && info.getIsStatistics().equals("1") ? "true"
							: "false");
					info.setIsSum(null != info.getIsSum() && info.getIsSum().equals("1") ? "true" : "false");
				}

				Object cou = DBUtil.queryFieldValue("SELECT SFTJTS FROM t_dtbd_createtable WHERE wid=?", tableWid);
				action.setParameter("isCount", (null != cou && cou.equals("1")) ? true : false);// 是否统计总条数
				// 变量可选值
				ResultSet rs = DBUtil
						.queryRowSet(
								"SELECT f.wid,f.fieldchinesename FROM t_dtbd_createtable_fieldinfo f WHERE f.depttype=? AND f.createtableid=?",
								curr, tableWid);
				Map<String, String> sMap = new HashMap<String, String>();
				while (rs.next()) {
					sMap.put(rs.getString("wid"), rs.getString("fieldchinesename"));
				}
				rs.close();
				action.setParameter("selectList", sMap);
			} catch (SQLException ex) {
				log.error("数据库结果集错误！");
			}
			action.setParameter("listField", action.getListField());
			// 查询默认年度
			try {
				Object tableName = DBUtil.queryFieldValue("SELECT TABLENAME FROM t_dtbd_createtable WHERE wid=?",
						tableWid);
				action.setParameter("TBND", DBUtil.queryFieldValue("SELECT cs FROM t_sys_propertity WHERE csmc=?",
						"BBND_" + tableName));
				action.setParameter("TBYF", DBUtil.queryFieldValue("SELECT cs FROM t_sys_propertity WHERE csmc=?",
						"BBYF_" + tableName));
			} catch (SQLException e) {
				log.error(e);
			}
		}

	}

	@Override
	public void openCreate(Object myaction) throws Exception {
		DtbdManagePageAction action = (DtbdManagePageAction) myaction;
		for (int i = 0; i < 10; i++) {
			action.getListField().add(new TDtbdCreatetableFieldinfo());
		}
	}

	/**
	 * @param num 传入数字
	 * @return 返回格式好的数据
	 */
	public String getNumber(int num) {
		String n = String.valueOf(num);
		switch (n.length()) {
		case 1:
			n = "00" + n;
			break;
		case 2:
			n = "0" + n;
			break;
		case 3:
			break;
		}
		return n;
	}

	/**
	 * 将非法字符转换成下划线
	 * 
	 * @param name 传入需要处理的字符
	 * @return 替换成功的传入字符串
	 */
	private String getTableNameEN(String name) {
		StringBuffer strTableName = new StringBuffer();
		for (int i = 0; i < name.length(); i++) {
			char ch = name.charAt(i);
			if ((Character.toUpperCase(ch) >= 65 && Character.toUpperCase(ch) <= 90)
					|| (Character.toUpperCase(ch) >= 48 && Character.toUpperCase(ch) <= 57)) {
				strTableName.append(ch);
			} else {
				strTableName.append("_");
			}
		}
		return strTableName.toString();
	}

	/**
	 * 给用户设置菜单权限
	 * 
	 * @param arg0 action对象
	 * @param wid table表的主键ID
	 * @param buliLC 上报规则
	 * @throws Exception 数据库SQL异常
	 */
	private void setMenuRole(Object arg0, String wid, String buliLC) throws Exception {
		DtbdManagePageAction action = (DtbdManagePageAction) arg0;
		TDtbdCreatetable tableInfo = action.getTableInfo();
		String menuid = (String) SysConfigUtil.getString("menuID");

		Object m = DBUtil.queryFieldValue("SELECT MAX(menuid) FROM t_sys_menu WHERE menuid LIKE '" + menuid + "%'");
		if (null == m || "".equals(m)) {
			m = menuid + "000";
		}
		int maxId = Integer.parseInt(m.toString().substring(m.toString().length() - 3));
		String menuID = menuid + getNumber(maxId + 1);

		TSysMenu tSysMenu = new TSysMenu();
		int c = DBUtil.count("SELECT COUNT(wid) FROM t_dtbd_createtable");
		tSysMenu.setMenuid(menuID);
		// TODO Constants
		tSysMenu.setMenuName(tableInfo.getChineseName() + "汇总");
		tSysMenu.setMenuPath("./business/dtbdUserPage-list.c?tablewid=" + wid + "&lx=hz");
		tSysMenu.setUpMenuId(menuid);
		tSysMenu.setDepth((short) 3);
		tSysMenu.setState("1");
		tSysMenu.setOrdernum(c + 1);

		this.getBaseDao().save(tSysMenu);

		TSysMenu tSysMenuMx = new TSysMenu();
		String menuID_mx = menuid + getNumber(maxId + 2);
		tSysMenuMx.setMenuid(menuID_mx);
		tSysMenuMx.setMenuName(tableInfo.getChineseName() + "明细");
		if ("1".equals(tableInfo.getXzlx())) {// 多层(除了最高级用户外都可以新增)
			tSysMenuMx.setMenuPath("./business/dtbdUserPage-list.c?tablewid=" + wid + "&lx=xz1");
		} else if ("0".equals(tableInfo.getXzlx())) {// 底层(只有最低级用户可以新增)
			tSysMenuMx.setMenuPath("./business/dtbdUserPage-list.c?tablewid=" + wid + "&lx=xz0");
		}
		tSysMenuMx.setUpMenuId(menuid);
		tSysMenuMx.setDepth((short) 3);
		tSysMenuMx.setState("1");
		tSysMenuMx.setOrdernum(c + 2);
		this.getBaseDao().save(tSysMenuMx);

		this.getBaseDao().getCurrentSession().createSQLQuery(
				"UPDATE t_dtbd_createtable SET menuid='" + menuID + "," + menuID_mx + "' WHERE wid='" + wid + "'")
				.executeUpdate();

		String[] role = buliLC.toString().split(":");
		List<TSysRoleMenu> roleList = new ArrayList<TSysRoleMenu>();
		for (String rid : role) {
			if (SysConfigUtil.getString(rid).indexOf(",") != -1) {
				for (String subrole : SysConfigUtil.getString(rid).split(",")) {
					// 查询大菜单是否存在
					int cont = DBUtil.count("SELECT count(*) FROM t_sys_role_menu t WHERE t.menuid=? AND t.roleid=?",
							menuid, subrole);
					if (cont == 0) {
						TSysRoleMenu tSysRoleMenu = new TSysRoleMenu();
						tSysRoleMenu.setId(SeqFactory.getNewSequenceAlone());
						tSysRoleMenu.setRoleid(subrole);
						tSysRoleMenu.setMenuid(menuid);
						this.getBaseDao().save(tSysRoleMenu);// 更新数据库
					}
					TSysRoleMenu tSysRole = new TSysRoleMenu();
					tSysRole.setId(SeqFactory.getNewSequenceAlone());
					tSysRole.setRoleid(subrole);
					tSysRole.setMenuid(menuID);
					roleList.add(tSysRole);// 加入集合
				}
			} else {
				// 查询大菜单是否存在
				int cont = DBUtil.count("SELECT count(*) FROM t_sys_role_menu t WHERE t.menuid=? AND t.roleid=?",
						menuid, rid);
				if (cont == 0) {
					TSysRoleMenu tSysRoleMenu = new TSysRoleMenu();
					tSysRoleMenu.setId(SeqFactory.getNewSequenceAlone());
					tSysRoleMenu.setRoleid(rid);
					tSysRoleMenu.setMenuid(menuid);
					this.getBaseDao().save(tSysRoleMenu);// 更新数据库
				}
				TSysRoleMenu tSysRole = new TSysRoleMenu();
				tSysRole.setId(SeqFactory.getNewSequenceAlone());
				tSysRole.setRoleid(SysConfigUtil.getString(rid));
				tSysRole.setMenuid(menuID);
				roleList.add(tSysRole);// 加入集合
			}
		}
		this.getBaseDao().saveAll(roleList);
		this.getBaseDao().getCurrentSession().createSQLQuery(
				"INSERT INTO t_sys_propertity(wid,csmc,csfl) VALUES('" + SeqFactory.getNewSequenceAlone() + "','"
						+ "BBND_" + tableInfo.getTableName() + "','" + tableInfo.getChineseName() + "')")
				.executeUpdate();
		if ("1".equals(tableInfo.getHzlx())) {
			this.getBaseDao().getCurrentSession().createSQLQuery(
					"INSERT INTO t_sys_propertity(wid,csmc,csfl) VALUES('" + SeqFactory.getNewSequenceAlone() + "','"
							+ "BBYF_" + tableInfo.getTableName() + "','" + tableInfo.getChineseName() + "')")
					.executeUpdate();
		}
	}
}
