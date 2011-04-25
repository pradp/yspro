package com.imchooser.infoms.service.biz.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.DtbdUserPageAction;
import com.imchooser.infoms.entity.biz.TDtbdCreatetable;
import com.imchooser.infoms.entity.biz.TDtbdCreatetableFieldinfo;
import com.imchooser.infoms.util.CommonQuery;
import com.imchooser.util.StringUtil;

/**
 * 动态表单用户服务类
 * 
 * @author Wangjunjun datetime 2010-2-26
 */
public class DtbdUserPageServiceImpl extends BaseServiceAbstractSupport {
	@SuppressWarnings("unchecked")
	public List<?> list(Object myaction, Pager pager) throws Exception {

		DtbdUserPageAction action = (DtbdUserPageAction) myaction;
		String wid = action.getParameter("tablewid");
		if (StringUtils.isNotBlank(wid)) {
			action.setParameter("tablewid", wid);
		}
		String userType = action.getDepart().getDeparttype();

		String hql_TableHead = null;
		String hql_QueryFileds = null;

		String shzt = null;
		String ctype = "";

		String departid = action.getDepartID();
		int i = 0;
		// 页面传入数据
		String view_departid = action.getParameter("departid");
		// 取得 表名
		String tableChineseName = "";

		// 统计字段的数量
		int tj_count = 0;
		List<TDtbdCreatetableFieldinfo> list_DTBDFieldInfo_Select = null;
		List<TDtbdCreatetableFieldinfo> list_DTBDFieldInfo_TableHead = null;
		// 上层提交的用户 显示列表
		List<TDtbdCreatetableFieldinfo> list_DTBDFieldInfo_TableHead2 = null;
		String sql_page = null;
		String s_nd = action.getParameter("s_nd");
		String s_yf = action.getParameter("s_yf");

		// 审核提交时 求和 、求平均值
		StringBuilder filed_hz = new StringBuilder();
		StringBuilder action_hz = new StringBuilder();
		String tableName = "";
		// 表数据
		StringBuilder hql_TableData = new StringBuilder();
		StringBuilder sql_groupBy = new StringBuilder();
		// 是否采用Group by 标记
		TDtbdCreatetableFieldinfo group_by = new TDtbdCreatetableFieldinfo();
		List<TDtbdCreatetableFieldinfo> new_tableHead = new ArrayList<TDtbdCreatetableFieldinfo>();
		shzt = action.getParameter("shzt");
		// 提交规则
		String temp_str[] = null;
		// 用于界面查询值

		List<Object[]> list_data = new ArrayList<Object[]>();

		if (wid != null || view_departid != null) {
			Object obj = null;
			if (wid != null && !"".equals(wid)) {
				String hql_tableName = "from TDtbdCreatetable t where t.wid=?";
				obj = getBaseDao().findFieldValue(hql_tableName, wid);
			} else if (view_departid != null && !"".equals(view_departid)) {
				String hql_tableName = "from TDtbdCreatetable t where t.tableName=?";
				String table_name = action.getParameter("tableName");
				obj = getBaseDao().findFieldValue(hql_tableName, table_name);
			}

			// 提交规则的最基层 romait
			String romait = "";
			String romait2 = "";
			if (obj != null) {
				TDtbdCreatetable createtable = (TDtbdCreatetable) obj;
				tableName = createtable.getTableName();
				action.setParameter("tableName", tableName);
				tableChineseName = createtable.getChineseName();
				// 上报规则
				String temp = createtable.getSbgz();
				wid = createtable.getWid();

				if (temp != null) {
					temp_str = temp.split(":");
					if (temp_str != null && temp_str.length > 0) {
						// 上报规则 最底层用户类型
						romait = temp_str[0];
						if (temp_str.length == 2) {
							// 提交规则级别, 为两级提交 传 “1” 否则传
							action.setParameter("tjshgz", "1");
							// 为两层时 可以 队省中心退回数据 操作（list.jsp 界面 标识）
							action.setParameter("twoCeng", "1");
						}
					}
					// 典型 三层上报规则
					if (temp_str != null && temp_str.length == 3) {
						// 中间 层
						romait2 = temp_str[1];
						if (temp_str.length == 2) {
							// 提交规则级别, 为两级提交 传 “1” 否则传
							action.setParameter("tjshgz", "1");
							// 为两层时 可以 队省中心退回数据 操作（list.jsp 界面 标识）
							action.setParameter("twoCeng", "1");
						}
					} else {
						romait2 = romait;
					}

				}
			}
			action.setParameter("romait2", romait2);

			// 页面查询审核状态类型 选择

			// 默认现在年度初始化
			String year = CommonQuery.getThisSchoolYear();

			// 判断年度是否被初始化
			String bbnd = CommonQuery.getSysProperty("BBND_" + tableName);
			String bbyf = CommonQuery.getSysProperty("BBYF_" + tableName);
			action.setBbyf(bbyf);
			if (StringUtils.isNotBlank(bbnd)) {
				String check_hz = "select count(*) from " + tableName + "_HZ t where t.bbnd='" + bbnd + "'";
				int count = DBUtil.count(check_hz);
				if (count > 0) {
					// 有值放入 页面进行判断 后续 保存 功能业用到
					action.setBbnd(bbnd);
					// 有值放入 页面进行判断 可否用新增
					action.setParameter("creat_display", "1");
				} else {
					action.setBbnd(bbnd);
				}
			} else {
				action.setBbnd(year);
			}

			// 汇总表初始化类型 init_type
			if (!StringUtil.isBlank(romait)) {
				if (romait.equals(romait2)) {
					action.setParameter("init_type", romait);
				} else {
					action.setParameter("init_type", romait + "," + romait2);
				}
			}

			// view_departid 是点击查看明细 是传入的 departid
			if (view_departid != null && !"".equals(view_departid)) {
				action.setParameter("departid", view_departid);
				String sql_departType = " select  j.departtype  from TSysDepart j where j.departid=?";
				Object obj_type = getBaseDao().findFieldValue(sql_departType, view_departid);
				ctype = String.valueOf(obj_type);

				// 判断是否是提交规则的最低层
				if (romait.equals(ctype)) {
					action.setParameter("view_model", "zx");
				} else {
					action.setParameter("view_model", "ss");
				}

				if (ctype != null && !"".equals(ctype)) {
					userType = ctype;
				}

			} else if (userType.equals(romait)) {
				action.setParameter("view_model", "zx");
			} else {
				action.setParameter("view_model", "ss");
			}

			// 去的 当前 用户 包括 点击“查看明细” 用户 界面 查询列表的 内容显示确定
			action.setParameter("userType", userType);

			/*
			 * // 用于界面是否显示 部门 if (view_departid != null &&
			 * !"".equals(view_departid)) { if ("8".equals(ctype) ||
			 * "9".equals(ctype)) { action.setParameter("select_type", "0"); }
			 * else { action.setParameter("select_type", "1"); } } else { if
			 * ("8".equals(userType) || "9".equals(userType)) {
			 * action.setParameter("select_type", "0"); } else {
			 * action.setParameter("select_type", "1"); } }
			 */

			// 取得 可查询字段
			hql_QueryFileds = "from TDtbdCreatetableFieldinfo t where t.createTableID=? and t.isFieldQuery=? and t.depttype=? and t.fieldName!='BBND'";
			if (hql_QueryFileds != null) {
				list_DTBDFieldInfo_Select = getBaseDao().findByHql(hql_QueryFileds, wid, "1", romait);
			}
			action.setList_DTBDFieldInfo_Select(list_DTBDFieldInfo_Select);

			action.setParameter("tablewid", wid);
			action.setParameter("romait", romait);
			action.getSession().setAttribute("tableChineseName", tableChineseName);

			// 取得 表头字段
			hql_TableHead = "from TDtbdCreatetableFieldinfo t where t.createTableID=? and t.isFieldDisplay=? and t.depttype=?  order by t.fieldOrder asc";
			if (hql_TableHead != null) {
				list_DTBDFieldInfo_TableHead = getBaseDao().findByHql(hql_TableHead, wid, "1", userType);
			}
			// 取得 底层级字段

			hql_TableHead = "from TDtbdCreatetableFieldinfo t where t.createTableID=? and t.depttype=?  order by t.fieldOrder asc";
			if (hql_TableHead != null) {
				list_DTBDFieldInfo_TableHead2 = getBaseDao().findByHql(hql_TableHead, wid, romait);
			}

			// 判断是否是提交规则的最低层
			if (romait.equals(userType)) {
				action.setParameter("searchType", "1");
				hql_TableData.append("select wid as wid");
				// sql_groupBy.append(" group by wid ");
			} else {
				hql_TableData.append("select dwbm ");
				sql_groupBy.append(" group by dwbm ");
			}

			// 判断是否有查询数据查询数据
			for (TDtbdCreatetableFieldinfo dtbdFieldInfo : list_DTBDFieldInfo_Select) {
				if (dtbdFieldInfo != null && !"".equals(dtbdFieldInfo.getFieldName())) {
					String str_val = action.getParameter(String.valueOf(dtbdFieldInfo.getFieldName()));

					if (str_val != null && !"".equals(str_val)) {
						i = 1;
					}

				}
			}

			// 求统计值
			Map<String, String> map_total = new LinkedHashMap<String, String>();

			if (list_DTBDFieldInfo_TableHead != null) {

				// 表统计
				StringBuilder hql_isStatistics = new StringBuilder();
				hql_isStatistics.append("select ");

				// 拼接求和 求平均 显示字段
				tool(list_DTBDFieldInfo_TableHead, hql_TableData, new_tableHead, sql_groupBy, group_by, userType,
						view_departid, romait);

				// 拼接 统计的字段 和 更改审核状态时 要 求和、求平均 的 传入 sql1 和 sql2
				tj_count = tool2(list_DTBDFieldInfo_TableHead2, filed_hz, action_hz, userType, romait,
						hql_isStatistics, map_total);

				// 表头显示的字段
				action.setList_DTBDFieldInfo_TableHead(new_tableHead);
				// 求和、平均值
				action.setParameter("filed_hz", filed_hz.toString());
				action.setParameter("action_hz", action_hz.toString());

				if ("shzt".equals(group_by.getFieldName())) {
					action.setParameter("shzt_display", String.valueOf(1));
				}

				// 页面辅助遍历的 int 数组
				List list = new ArrayList();
				if (new_tableHead != null) {
					int size = new_tableHead.size();
					for (int n = 0; n <= size; n++) {
						list.add(n);
					}
					action.setParameter("data_size", list);
				} else {
					action.setParameter("data_size", new ArrayList());
				}

				StringBuilder hql_middle = new StringBuilder();
				// list 界面显示的查询值存储
				Map<String, String> map = new HashMap<String, String>();

				/*
				 * String DEPARTTYPE_ADMIN = "1"; // 管理员 String
				 * DEPARTTYPE_GXADMIN = "3"; // 高校管理员 String DEPARTTYPE_QXADMIN
				 * = "3"; // 区县管理员 String DEPARTTYPE_SX = "7"; // 市县教育局 String
				 * DEPARTTYPE_GX = "6"; // 高校 String DEPARTTYPE_ZX = "8"; // 中学
				 * String DEPARTTYPE_YX = "9"; // 院系
				 */

				// 除 规则最底层的
				if (!userType.equals(romait)) {
					hql_middle.append(" from ");
					hql_middle.append(tableName);
					if (romait.equals(userType)) {
						hql_middle.append(" t where 1=1 ");
					} else {
						hql_middle.append("_HZ t where 1=1 ");
					}
					// 省中心
					if (Constants.DEPARTTYPE_ADMIN.equals(userType)) {
						hql_middle.append(" and t.dwbm like'" + departid + "%' ");
					} else if (!StringUtils.isBlank(view_departid)) {
						if (userType.equals(romait)) {
							hql_middle.append(" and t.dwbm like'" + view_departid + "%' ");
						} else {
							hql_middle.append(" and t.dwbm like'" + view_departid + "___' ");
						}
					} else {
						if (userType.equals(romait)) {
							hql_middle.append(" and t.dwbm like'" + departid + "%' ");
						} else {
							hql_middle.append(" and t.dwbm like'" + departid + "___' ");
						}

					}

					if (!StringUtil.isBlank(s_nd)) {
						// 界面查询年度
						hql_middle.append(" and t.bbnd='" + s_nd + "' ");
					} else {
						// 界面无查询年度的 去当前年度
						hql_middle.append(" and t.bbnd='" + year + "' ");
						action.setParameter("s_nd", year);
					}
					if (StringUtil.isNotBlank(s_yf)) {
						// 界面查询月份
						hql_middle.append(" and t.bbyf='" + s_yf + "' ");
					}
					if (!StringUtil.isBlank(shzt)) {
						if ("none".equals(shzt)) {
							hql_middle.append(" and t.shzt='0' ");
						} else {
							hql_middle.append(" and t.shzt='" + shzt + "' ");
						}

					}
					// 页面传入查询值 i >0 表示有
					if (!romait.equals(userType)) {
						if (list_DTBDFieldInfo_Select != null) {
							String dwbm = action.getParameter("DWBM");
							String tjsj = action.getParameter("TJSJ");
							String shsj = action.getParameter("SHSJ");
							action.setParameter("DWBM", dwbm);
							action.setParameter("TJSJ", tjsj);
							action.setParameter("SHSJ", shsj);
							if (!StringUtil.isBlank(dwbm)) {
								map.put("DWBM", dwbm);
								hql_middle
										.append(" and t.dwbm in (select k.departid from  t_sys_depart k where k.departname like '%");
								hql_middle.append(dwbm);
								hql_middle.append("%')");
							}
							if (!StringUtil.isBlank(tjsj)) {
								map.put("TJSJ", tjsj);
								hql_middle.append(" and t.tjsj='");
								hql_middle.append(tjsj);
								hql_middle.append("' ");
							}
							if (!StringUtil.isBlank(shsj)) {
								map.put("SHSJ", shsj);
								hql_middle.append(" and t.shsj='");
								hql_middle.append(shsj);
								hql_middle.append("' ");
							}
							/*
							 * else {hql_middle.append(
							 * " and t.dwbm in (select k.dwbm from ");
							 * hql_middle.append(tableName);
							 * hql_middle.append(" k where 1=1 "); for
							 * (TDtbdCreatetableFieldinfo dtbdFieldInfo :
							 * list_DTBDFieldInfo_Select) { if (dtbdFieldInfo !=
							 * null && !"".equals(dtbdFieldInfo.getFieldName()))
							 * { String str_val =
							 * action.getParameter(String.valueOf(dtbdFieldInfo
							 * .getFieldName())); if (str_val != null &&
							 * !"".equals(str_val)) {
							 * map.put(dtbdFieldInfo.getFieldName(), str_val);
							 * hql_middle.append(" and k.");
							 * hql_middle.append(dtbdFieldInfo.getFieldName());
							 * hql_middle.append(" like ");
							 * hql_middle.append("'%");
							 * hql_middle.append(str_val.trim());
							 * hql_middle.append("%' "); } } }
							 * hql_middle.append(")"); }
							 */

						}
					}

					sql_page = hql_middle.toString();
					hql_middle.append(sql_groupBy.toString());
				} else {
					// 提交 底层的
					hql_middle.append(" from ");
					hql_middle.append(tableName);
					hql_middle.append(" t where 1=1 ");
					String dep_tem = action.getDepartID();
					if (!StringUtils.isBlank(view_departid)) {
						dep_tem = view_departid;
					}
					if (!StringUtil.isBlank(s_nd)) {
						hql_middle.append(" and t.dwbm='" + dep_tem + "' and t.bbnd='" + s_nd + "' ");
					} else {
						hql_middle.append(" and t.dwbm='" + dep_tem + "' and t.bbnd='" + year + "' ");
						action.setParameter("s_nd", year);
					}
					if (!StringUtil.isBlank(shzt)) {
						hql_middle.append(" and t.shzt='" + shzt + "' ");
					}
					// 页面传入查询值 i>0 表示有
					if (i > 0) {
						if (list_DTBDFieldInfo_Select != null) {
							for (TDtbdCreatetableFieldinfo dtbdFieldInfo : list_DTBDFieldInfo_Select) {
								if (dtbdFieldInfo != null && !"".equals(dtbdFieldInfo.getFieldName())) {
									String str_val = action.getParameter(String.valueOf(dtbdFieldInfo.getFieldName()));
									if (str_val != null && !"".equals(str_val)) {
										map.put(dtbdFieldInfo.getFieldName(), str_val);
										hql_middle.append(" and t.");
										hql_middle.append(dtbdFieldInfo.getFieldName());
										if ("dwbm".equalsIgnoreCase(dtbdFieldInfo.getFieldName())) {
											hql_middle.append(" in ");
											hql_middle
													.append("( select r.departid from t_sys_depart r where r.departname like '%");
											hql_middle.append(str_val.trim());
											hql_middle.append("%')");
										} else {
											hql_middle.append(" like '%");
											hql_middle.append(str_val.trim());
											hql_middle.append("%' ");
										}
									}
								}
							}
						}
					}
					sql_page = hql_middle.toString();
					// hql_middle.append(sql_groupBy.toString());
				}

				map.put("shzt", shzt);
				action.setParameter("map", map);

				// 表数据
				hql_TableData.append(hql_middle.toString());
				hql_TableData.append(" order by tjsj asc");

				// 表统计
				// hql_middle.append(" order by shzt asc ");
				hql_isStatistics.append(sql_page);
				sql_page = "select count(*) " + sql_page;
				long c = DBUtil.count(sql_page);
				pager.setTotalRows(c);
				// 表数据
				list_data = DBUtil.queryPageList(pager, hql_TableData.toString());
				// 表统计
				List total_list = null;
				if (tj_count > 0) {
					total_list = DBUtil.queryAllList(hql_isStatistics.toString());
				}

				String cxhz = "";
				if (total_list != null && total_list.size() > 0) {
					Set<String> set = map_total.keySet();
					Object[] obj_set = set.toArray();
					Object[] obj_Data = (Object[]) total_list.get(0);
					if (obj_set != null && obj_Data != null && obj_set.length == obj_Data.length) {
						for (int n = 0; n < obj_set.length; n++) {
							String key = String.valueOf(obj_set[n]);
							if (obj_Data[n] != null) {
								if (n == 0) {
									cxhz += "   " + key + " 总值为：" + String.valueOf(obj_Data[n]);
								} else {
									cxhz += " , " + key + " 总值为：" + String.valueOf(obj_Data[n]);
								}

							} else {
								if (n == 0) {
									cxhz += "   " + key + " 总值为： 0 ";
								} else {
									cxhz += " , " + key + " 总值为：0 ";
								}

							}

						}
						action.setParameter("cxhz", cxhz);
					}
				}

			}

		}

		return list_data;
	}

	/**
	 * 拼接求和 求平均 显示字段
	 * 
	 * @param list_DTBDFieldInfo_TableHead 当前用户的 可显示 字段属性 集合
	 * @param hql_TableData 主查询 sql
	 * @param new_tableHead 表头遍历显示对象集合
	 * @param sql_groupBy groupby sql
	 * @param group_by 用于判断是否采用 grouup 的对象
	 * @param userType 用户类型
	 * @param view_depart 点击查看明细是传入的 departid
	 * @param romait 提交规则最底层用户类型
	 */
	public void tool(List<TDtbdCreatetableFieldinfo> list_DTBDFieldInfo_TableHead, StringBuilder hql_TableData,
			List<TDtbdCreatetableFieldinfo> new_tableHead, StringBuilder sql_groupBy,
			TDtbdCreatetableFieldinfo group_by, String userType, String view_depart, String romait) {
		// 求和、平均值 的 拼接辅助
		int hz_count = 0;
		for (TDtbdCreatetableFieldinfo dtbdFieldInfo : list_DTBDFieldInfo_TableHead) {

			if (dtbdFieldInfo != null && !"".equals(dtbdFieldInfo.getFieldName())) {
				if ("1".equals(dtbdFieldInfo.getIsSum())) {
					// 总值
					TDtbdCreatetableFieldinfo temp = new TDtbdCreatetableFieldinfo();
					if (!userType.equals(romait)) {
						hql_TableData.append(String.valueOf(", sum(" + dtbdFieldInfo.getFieldName() + ") "));
						temp.setFieldDisplayName(getDisplayName(dtbdFieldInfo) + "总值");
						new_tableHead.add(temp);
						hz_count++;
					}
				}

				// 平均值
				if ("1".equals(dtbdFieldInfo.getIsAvg())) {
					if (!userType.equals(romait)) {
						hql_TableData.append(String.valueOf(", avg(" + dtbdFieldInfo.getFieldName() + ")"));
						TDtbdCreatetableFieldinfo temp = new TDtbdCreatetableFieldinfo();
						temp.setFieldDisplayName(getDisplayName(dtbdFieldInfo) + "平均值");
						new_tableHead.add(temp);
						hz_count++;
					}

				}
				int p = 0;
				// 审核状态
				if ("shzt".equalsIgnoreCase(dtbdFieldInfo.getFieldName())) {

					hql_TableData.append(",(select g.zdmc from t_sys_code g where g.zdlb='shzt' and g.zdbm="
							+ dtbdFieldInfo.getFieldName() + ")");
					TDtbdCreatetableFieldinfo temp = new TDtbdCreatetableFieldinfo();
					temp.setFieldDisplayName(getDisplayName(dtbdFieldInfo));
					new_tableHead.add(temp);
					group_by.setFieldName("shzt");
					sql_groupBy.append("," + dtbdFieldInfo.getFieldName());
					p++;
				}

				if ("dwbm".equalsIgnoreCase(dtbdFieldInfo.getFieldName())) {
					if (!(Constants.DEPARTTYPE_YX.equals(userType) || Constants.DEPARTTYPE_ZX.equals(userType))) {
						hql_TableData.append(",(select k.departname from t_sys_depart k where k.departid=t.dwbm)");
					} else {
						hql_TableData.append(",(select k.departname from t_sys_depart k where k.departid=t."
								+ dtbdFieldInfo.getFieldName() + ")");
					}

					TDtbdCreatetableFieldinfo temp = new TDtbdCreatetableFieldinfo();
					temp.setFieldDisplayName(getDisplayName(dtbdFieldInfo));
					new_tableHead.add(temp);
					sql_groupBy.append("," + dtbdFieldInfo.getFieldName());
					p++;
				}

				if (p == 0 && hz_count == 0) {
					if ("2".equals(dtbdFieldInfo.getFieldType())) {
						hql_TableData.append(",(select zdmc from t_sys_code where zdlb= '"
								+ dtbdFieldInfo.getFieldDefine() + "' and zdbm=" + dtbdFieldInfo.getFieldName()
								+ ") as " + dtbdFieldInfo.getFieldName());
					} else {
						hql_TableData.append("," + dtbdFieldInfo.getFieldName());
						sql_groupBy.append("," + dtbdFieldInfo.getFieldName());
					}
					new_tableHead.add(dtbdFieldInfo);
				}
			}
		}
	}

	/**
	 * 返回现实名称
	 * 
	 * @param dtbdFieldInfo 表单配置描述对象
	 * @return
	 */
	private String getDisplayName(TDtbdCreatetableFieldinfo dtbdFieldInfo) {
		if (StringUtils.isNotBlank(dtbdFieldInfo.getFieldDisplayName())) {
			return dtbdFieldInfo.getFieldDisplayName();
		} else {
			return dtbdFieldInfo.getFieldChineseName();
		}
	}

	/**
	 * 拼接 统计的字段 和 更改审核状态时 要 求和、求平均 的 传入 sql1 和 sql2
	 * 
	 * @param list_DTBDFieldInfo_TableHead 提交规则最底层 的 字段属性集合
	 * @param filed_hz 更改审核状态时 要 求和、求平均 的 传入 sql1
	 * @param action_hz 更改审核状态时 要 求和、求平均 的 传入 sql2
	 * @param usertype 用户类型
	 * @param romait 提交规则最底层用户类型
	 * @param hql_isStatistics 统计sql 拼接
	 * @param map_total 统计字段收集
	 * @return
	 */
	public int tool2(List<TDtbdCreatetableFieldinfo> list_DTBDFieldInfo_TableHead, StringBuilder filed_hz,
			StringBuilder action_hz, String usertype, String romait, StringBuilder hql_isStatistics,
			Map<String, String> map_total) {
		int j = 0;
		// 求和、平均值 的 拼接辅助
		int hz_count = 0;
		// 统计字段的个数
		int conut = 0;
		// 统计 的 拼接辅助
		int tj_help = 0;
		for (TDtbdCreatetableFieldinfo dtbdFieldInfo : list_DTBDFieldInfo_TableHead) {
			if (dtbdFieldInfo != null && !"".equals(dtbdFieldInfo.getFieldName())) {
				if ("1".equals(dtbdFieldInfo.getIsSum())) {
					// 总值
					if (romait.equals(usertype)) {
						if (hz_count == 0) {
							filed_hz.append(dtbdFieldInfo.getFieldsum());
							action_hz.append("sum(" + dtbdFieldInfo.getFieldName() + ")");
							hz_count++;
						} else {
							filed_hz.append("," + dtbdFieldInfo.getFieldsum());
							action_hz.append(",sum(" + dtbdFieldInfo.getFieldName() + ")");
						}
					} else {
						if (hz_count == 0) {
							filed_hz.append(dtbdFieldInfo.getFieldsum());
							action_hz.append("sum(" + dtbdFieldInfo.getFieldsum() + ")");
							hz_count++;
						} else {
							filed_hz.append("," + dtbdFieldInfo.getFieldsum());
							action_hz.append(",sum(" + dtbdFieldInfo.getFieldsum() + ")");
						}
					}
				}

				// 平均值
				if ("1".equals(dtbdFieldInfo.getIsAvg())) {
					if (romait.equals(usertype)) {
						if (hz_count == 0) {
							filed_hz.append(dtbdFieldInfo.getFieldavg());
							action_hz.append("avg(" + dtbdFieldInfo.getFieldName() + ")");
							hz_count++;
						} else {
							filed_hz.append("," + dtbdFieldInfo.getFieldavg());
							action_hz.append(",avg(" + dtbdFieldInfo.getFieldName() + ")");
						}
					} else {
						if (hz_count == 0) {
							filed_hz.append(dtbdFieldInfo.getFieldavg());
							action_hz.append("avg(" + dtbdFieldInfo.getFieldavg() + ")");
							hz_count++;
						} else {
							filed_hz.append("," + dtbdFieldInfo.getFieldavg());
							action_hz.append(",avg(" + dtbdFieldInfo.getFieldavg() + ")");
						}
					}

				}
				// 判断是否属于统计字段
				if ("1".equals(dtbdFieldInfo.getIsStatistics())) {
					if (romait.equals(usertype)) {
						if (hz_count == 0) {
							filed_hz.append(dtbdFieldInfo.getFieldtj());
							action_hz.append("sum(" + dtbdFieldInfo.getFieldName() + ")");
							j++;

						} else {
							filed_hz.append("," + dtbdFieldInfo.getFieldtj());
							action_hz.append(",sum(" + dtbdFieldInfo.getFieldName() + ")");

						}
						if (tj_help == 0) {
							hql_isStatistics.append("sum(");
							hql_isStatistics.append(String.valueOf(dtbdFieldInfo.getFieldName()));
							hql_isStatistics.append(")");
							tj_help++;
						} else {
							hql_isStatistics.append(",sum(");
							hql_isStatistics.append(String.valueOf(dtbdFieldInfo.getFieldName()));
							hql_isStatistics.append(")");
						}
						map_total.put(getDisplayName(dtbdFieldInfo), "");
					} else {
						if (hz_count == 0) {
							filed_hz.append(dtbdFieldInfo.getFieldtj());
							action_hz.append("sum(" + dtbdFieldInfo.getFieldtj() + ")");
							j++;
						} else {
							filed_hz.append("," + dtbdFieldInfo.getFieldtj());
							action_hz.append(",sum(" + dtbdFieldInfo.getFieldtj() + ")");
						}
						if (tj_help == 0) {
							hql_isStatistics.append("sum(");
							hql_isStatistics.append(String.valueOf(dtbdFieldInfo.getFieldtj()));
							hql_isStatistics.append(")");
							tj_help++;
						} else {
							hql_isStatistics.append(",sum(");
							hql_isStatistics.append(String.valueOf(dtbdFieldInfo.getFieldtj()));
							hql_isStatistics.append(")");
						}
						map_total.put(getDisplayName(dtbdFieldInfo), "");
					}

					conut++;

				}
			}
		}
		return conut;
	}

	public void load(Object myaction) throws Exception {
		DtbdUserPageAction action = (DtbdUserPageAction) myaction;
		String tableName = "";
		String wid = null;
		tableName = action.getParameter("tableName");
		wid = action.getWid();

		if (wid != null) {
			action.setParameter("update_wid", wid);
		}
		if (tableName != null && !"".equals(tableName) && wid != null && !"".equals(wid)) {
			String hql_init = "from TDtbdCreatetableFieldinfo t where t.createTableID=(select a.wid from TDtbdCreatetable a where a.tableName=?) and t.isFieldEnter=? order by t.fieldEnterOrder asc";
			List<TDtbdCreatetableFieldinfo> list_DTBDFieldInfo = getBaseDao().findByHql(hql_init, tableName, "1");
			StringBuilder sql_value = new StringBuilder();
			sql_value.append("select ");
			if (list_DTBDFieldInfo != null) {
				for (int i = 0; i < list_DTBDFieldInfo.size(); i++) {
					TDtbdCreatetableFieldinfo dtbdFieldInfo = list_DTBDFieldInfo.get(i);
					if (dtbdFieldInfo != null && !"".equals(dtbdFieldInfo.getFieldName())) {
						if (i > 0) {
							sql_value.append(",");
						}
						sql_value.append(dtbdFieldInfo.getFieldName());
					}
				}
			}
			sql_value.append(" from ");
			sql_value.append(tableName);
			sql_value.append(" t where t.wid='");
			sql_value.append(wid);
			sql_value.append("'");

			String shzt_hql = "select shzt from " + tableName + " t where t.wid='" + wid + "'";
			Object obj_shzt = DBUtil.queryFieldValue(shzt_hql);
			String shzt = String.valueOf(obj_shzt);
			if (shzt != null) {

				/*
				 * //String SHZT_DSXSH = "2"; // 待市县审核 String SHZT_DGXSH = "3";
				 * // 待高校审核 String SHZT_SXSHTG = "4"; // 市县审核通过 String
				 * SHZT_GXSHTG = "5"; // 高校审核通过 String SHZT_SXSHTH = "-4"; //
				 * 市县审核退回 String SHZT_GXSHTH = "-5"; // 高校审核退回 String
				 * SHZT_SXDSZXSH = "7"; // 市县待省中心审核 String SHZT_GXDSZXSH = "8";
				 * // 高校待省中心审核 String SHZT_SHTG = "9"; // 审核通过 String SHZT_SZXTH
				 * = "-9"; // 省中心退回
				 */String departtype = action.getDepart().getDeparttype();
				if ("8".equals(departtype) || "9".equals(departtype)) {
					if (Constants.SHZT_CG.equals(shzt) || Constants.SHZT_SXSHTH.equals(shzt)
							|| Constants.SHZT_GXSHTH.equals(shzt) || Constants.SHZT_DSXSH.equals(shzt)
							|| Constants.SHZT_DGXSH.equals(shzt)) {
						action.setParameter("save_display", "1");
					}
				} else if ("7".equals(departtype) || "6".equals(departtype)) {
					if (Constants.SHZT_SXDSZXSH.equals(shzt) || Constants.SHZT_GXDSZXSH.equals(shzt)
							|| Constants.SHZT_SZXTH.equals(shzt) || Constants.SHZT_CG.equals(shzt)) {
						action.setParameter("save_display", "1");
					}
				}

				List<Object[]> list = DBUtil.queryAllList(sql_value.toString());
				if (list_DTBDFieldInfo != null) {
					if (list != null && list.size() > 0) {
						Object[] obj = list.get(0);
						for (int i = 0; i < list_DTBDFieldInfo.size(); i++) {
							TDtbdCreatetableFieldinfo dtbdFieldInfo = list_DTBDFieldInfo.get(i);
							if (dtbdFieldInfo.getFieldType() != null && "1".equals(dtbdFieldInfo.getFieldType())
									&& obj[i] == null) {
								dtbdFieldInfo.setView_data("0");
							} else {
								if (obj[i] != null) {
									dtbdFieldInfo.setView_data(String.valueOf(obj[i]));
								} else {
									dtbdFieldInfo.setView_data("");
								}

							}
						}

					}
				}
			}
			StringBuilder validate_required_fields = new StringBuilder();
			validate_required_fields.append(" validate_required_fields=[");
			if (list_DTBDFieldInfo != null) {
				for (int i = 0; i < list_DTBDFieldInfo.size(); i++) {
					TDtbdCreatetableFieldinfo obj = list_DTBDFieldInfo.get(i);
					if (obj != null && "1".equals(obj.getIsNull())) {
						if (i == 0) {
							validate_required_fields.append("{fieldId:'table_");
							validate_required_fields.append(obj.getFieldName());
							validate_required_fields.append("', message:'");
							validate_required_fields.append(getDisplayName(obj));
							validate_required_fields.append("不能为空！', mustMatch: true}");
						} else {
							validate_required_fields.append(",{fieldId:'table_");
							validate_required_fields.append(obj.getFieldName());
							validate_required_fields.append("', message:'");
							validate_required_fields.append(getDisplayName(obj));
							validate_required_fields.append("不能为空！', mustMatch: true}");
						}

					}
				}
			}
			validate_required_fields.append("]");
			action.setParameter("validate_required_fields", validate_required_fields.toString());
			action.setList_DTBDFieldInfo_Select(list_DTBDFieldInfo);

		}

	}

	public boolean remove(Object myaction) throws Exception {
		DtbdUserPageAction action = (DtbdUserPageAction) myaction;
		boolean deleteSuccess = false;
		String tableName = "";
		if (action != null) {
			tableName = action.getParameter("tableName");
		}
		if (tableName != null && !"".equals(tableName)) {
			String ids = action.getWid();
			String[] str = null;
			if (ids != null && !"".equals(ids)) {
				str = ids.split(",");
			}
			if (str != null && str.length > 0) {
				String delete_sql = "delete from " + tableName;
				for (int i = 0; i < str.length; i++) {
					if (str[i] != null && !"".equals(str[i])) {
						if (i == 0) {
							delete_sql += " where wid='" + str[i] + "'";
						} else {
							delete_sql += " or wid='" + str[i] + "'";
						}
					}
				}
				DBUtil.executeSQL(delete_sql);
			}
		}
		return deleteSuccess;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		DtbdUserPageAction action = (DtbdUserPageAction) myaction;
		String tableName = "";
		String update_wid = "";
		String save_wid = "";
		action.setParameter("save_display", "1");
		if (action != null) {
			tableName = action.getParameter("tableName");
			update_wid = action.getWid();
		}

		if (tableName != null && !"".equals(tableName)) {
			String hql_init = "from TDtbdCreatetableFieldinfo t where t.createTableID=(select a.wid from TDtbdCreatetable a where a.tableName=?) and t.isFieldEnter=? order by t.fieldEnterOrder asc";
			String bbnd = action.getBbnd();
			if (StringUtils.isBlank(bbnd)) {
				bbnd = "";
			}
			String bbyf = CommonQuery.getSysProperty("BBYF_" + tableName);
			List<TDtbdCreatetableFieldinfo> list_DTBDFieldInfo = getBaseDao().findByHql(hql_init, tableName, "1");
			if (list_DTBDFieldInfo != null && list_DTBDFieldInfo.size() > 0) {
				StringBuilder sql_save = new StringBuilder();
				sql_save.append("insert into ");
				sql_save.append(tableName);
				sql_save.append(" (");

				StringBuilder sql_update = new StringBuilder();
				sql_update.append("update ");
				sql_update.append(tableName);
				sql_update.append(" set ");

				StringBuilder sql_save_after = new StringBuilder();
				sql_save_after.append(") values (");
				for (int i = 0; i < list_DTBDFieldInfo.size(); i++) {
					TDtbdCreatetableFieldinfo dtbdFieldInfo = list_DTBDFieldInfo.get(i);
					if (dtbdFieldInfo != null && !"".equals(dtbdFieldInfo.getFieldName())) {
						if (i == 0) {
							sql_save.append("wid,");
							sql_save.append(dtbdFieldInfo.getFieldName());
							sql_save.append(",BBND");
							if (StringUtils.isNotBlank(bbyf)) {
								sql_save.append(",BBYF");
							}
							sql_update.append(dtbdFieldInfo.getFieldName());
							sql_update.append("='");
							sql_update.append(action.getParameter(String.valueOf(dtbdFieldInfo.getFieldName())));
							sql_update.append("'");

							save_wid = SeqFactory.getNewSequenceAlone();
							sql_save_after.append("'");
							sql_save_after.append(save_wid);
							sql_save_after.append("','");
							sql_save_after.append(action.getParameter(String.valueOf(dtbdFieldInfo.getFieldName())));
							sql_save_after.append("','");
							sql_save_after.append(bbnd);
							sql_save_after.append("'");
							if (StringUtils.isNotBlank(bbyf)) {
								sql_save_after.append(",'");
								sql_save_after.append(bbyf);
								sql_save_after.append("'");
							}
						} else {
							sql_save.append(",");
							sql_save.append(dtbdFieldInfo.getFieldName());
							sql_update.append(", ");
							sql_update.append(dtbdFieldInfo.getFieldName());
							sql_update.append("='");
							sql_update.append(action.getParameter(String.valueOf(dtbdFieldInfo.getFieldName())));
							sql_update.append("'");
							sql_save_after.append(",'");
							sql_save_after.append(action.getParameter(String.valueOf(dtbdFieldInfo.getFieldName())));
							sql_save_after.append("'");
						}

					}
				}
				sql_update.append(" where wid='");
				sql_update.append(update_wid);
				sql_update.append("'");
				sql_save.append(",tbrq,dwbm,shzt");
				sql_save.append(sql_save_after.toString());
				sql_save.append(",to_char(sysdate,'yyyy-MM-dd'),'" + action.getDepartID() + "','1'");
				sql_save.append(")");
				if (update_wid == null || "".equals(update_wid)) {
					DBUtil.executeSQL(sql_save.toString());
				} else {
					DBUtil.executeSQL(sql_update.toString());
				}

			}
		}
		if (update_wid != null && !"".equals(update_wid)) {
			action.setWid(update_wid);
			load(action);
		} else {
			action.setWid(save_wid);
			load(action);
		}

	}

	public void openCreate(Object myaction) throws Exception {
		DtbdUserPageAction action = (DtbdUserPageAction) myaction;
		String tableName = "";
		action.setParameter("save_display", "1");
		if (action != null) {
			tableName = action.getParameter("tableName");
			String bbnd = action.getParameter("bbnd");
			action.setTableName(tableName);
			action.setBbnd(bbnd);
		}
		if (tableName != null && !"".equals(tableName)) {
			String hql_init = "from TDtbdCreatetableFieldinfo t where t.createTableID=(select a.wid from TDtbdCreatetable a where a.tableName=?) and t.isFieldEnter=? order by t.fieldEnterOrder asc";

			List<TDtbdCreatetableFieldinfo> list_DTBDFieldInfo = getBaseDao().findByHql(hql_init, tableName, "1");
			StringBuilder validate_required_fields = new StringBuilder();
			validate_required_fields.append(" validate_required_fields=[");
			if (list_DTBDFieldInfo != null) {
				for (int i = 0; i < list_DTBDFieldInfo.size(); i++) {
					TDtbdCreatetableFieldinfo obj = list_DTBDFieldInfo.get(i);
					if (obj != null && "1".equals(obj.getIsMustIn())) {
						obj.setFieldDisplayName(getDisplayName(obj));
						if (i > 0) {
							validate_required_fields.append(",");
						}
						validate_required_fields.append("{fieldId:'table_");
						validate_required_fields.append(obj.getFieldName());
						validate_required_fields.append("', message:'");
						validate_required_fields.append(getDisplayName(obj));
						validate_required_fields.append("不能为空！', mustMatch: true}");

					}
				}
			}
			validate_required_fields.append("]");
			action.setParameter("validate_required_fields", validate_required_fields.toString());

			action.setList_DTBDFieldInfo_Select(list_DTBDFieldInfo);
		}

	}

}
