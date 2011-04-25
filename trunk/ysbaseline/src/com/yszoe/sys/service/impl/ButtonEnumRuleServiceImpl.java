package com.yszoe.sys.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.framework.service.impl.BaseServiceAbstractSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.action.ButtonEnumRuleAction;
import com.yszoe.sys.entity.TSysButtonEnumRule;
import com.yszoe.sys.entity.TSysButtonRule;
import com.yszoe.sys.util.BusinessLogUtil;
/**
 * 模块功能按钮开放规则设置
 * 
 * @author 
 * datetime 
 */
public class ButtonEnumRuleServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {

		String hqlcolumn = "select new TSysButtonRule( r.wid,"
				+ "(select c.zdmc from TSysCode c where c.zdbm=r.cycleType and c.zdlb='cycletype')as cycleType,"
				+ "r.cycleStart,r.cycleEnd,r.state ) ";
		String hql = " from TSysButtonRule r where 1=1";
		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + "  order by r.wid desc ";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	public void load(Object myaction) throws Exception {
		ButtonEnumRuleAction action = (ButtonEnumRuleAction) myaction;
		String id = action.getWid();
		TSysButtonRule tsysButtonRule = (TSysButtonRule) getBaseDao().findById(
				TSysButtonRule.class, id);

		String hql = "from TSysButtonEnumRule where buttonRuleId=?";
		List<TSysButtonEnumRule> buttonEnumRules = getBaseDao().findByHql(hql, id);
		int count = buttonEnumRules.size();
		StringBuffer menues = new StringBuffer("000,");
		Object BUTTON_ENUM_IDS[] = new Object[count];
		
		for(int i = 0; i<count ; i++){
			TSysButtonEnumRule buttonEnumRule = buttonEnumRules.get(i);
			// 选中的菜单
			menues.append( buttonEnumRule.getMenuId().substring(0, 6) )
			.append(",")
			.append( buttonEnumRule.getMenuId() );
			if(i<count-1){
				menues.append(",");
			}
			
			BUTTON_ENUM_IDS[i] = buttonEnumRule.getButtonEnumId();// 选中的权限按钮
		}

		action.setParameter("menues", menues.toString());
		if (SysConstants.BUTTON_RULE_EACH_DAY == Integer.parseInt(tsysButtonRule
				.getCycleType())) {//
			action.setParameter("kshour", tsysButtonRule.getCycleStart().substring(0,tsysButtonRule.getCycleStart().lastIndexOf(":")));
			action.setParameter("ksminute", tsysButtonRule.getCycleStart().substring((tsysButtonRule.getCycleStart().lastIndexOf(":")+1),tsysButtonRule.getCycleStart().length() ));
			action.setParameter("jshour", tsysButtonRule.getCycleEnd().substring(0,tsysButtonRule.getCycleEnd().lastIndexOf(":")));
			action.setParameter("jsminute", tsysButtonRule.getCycleEnd().substring((tsysButtonRule.getCycleEnd().lastIndexOf(":")+1),tsysButtonRule.getCycleEnd().length() ));
		} else if (SysConstants.BUTTON_RULE_EACH_MONTH == Integer.parseInt(tsysButtonRule.getCycleType())) {// 每月
			action.setParameter("ksHao", tsysButtonRule.getCycleStart());
			action.setParameter("jsHao", tsysButtonRule.getCycleEnd());
		} else if (SysConstants.BUTTON_RULE_EACH_YEAR == Integer.parseInt(tsysButtonRule.getCycleType())) {// 每年
			action.setParameter("ksMonth", tsysButtonRule.getCycleStart().substring(0,tsysButtonRule.getCycleStart().lastIndexOf("-")));
			action.setParameter("ksDay", tsysButtonRule.getCycleStart().substring((tsysButtonRule.getCycleStart().lastIndexOf("-")+1),tsysButtonRule.getCycleStart().length()));
			action.setParameter("jsMonth", tsysButtonRule.getCycleEnd().substring(0,tsysButtonRule.getCycleEnd().lastIndexOf("-")));
			action.setParameter("jsDay", tsysButtonRule.getCycleEnd().substring((tsysButtonRule.getCycleEnd().lastIndexOf("-")+1),tsysButtonRule.getCycleEnd().length()));
		}
		action.setParameter("BUTTON_ENUM_ID", BUTTON_ENUM_IDS);
		action.setTsysButtonRule(tsysButtonRule);

	}

	public boolean remove(Object myaction) throws Exception {
		ButtonEnumRuleAction action = (ButtonEnumRuleAction) myaction;
		String ids = action.getWid();
		boolean deleteSuccess2 = getBaseDao().deleteAll("TSysButtonEnumRule",
				"buttonRuleId", "=", ids);
		boolean deleteSuccess1 = getBaseDao().deleteAll("TSysButtonRule",
				"wid", "=", ids);
		if (deleteSuccess1 && deleteSuccess2) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
					SysConstants.CZDX_T_SYS_BUTTON_RULE, SysConstants.LOG_ACTION_DEL);
		}
		return deleteSuccess1 && deleteSuccess2;
	}

	/**
	 * 根据菜单编号判断该菜单是否已配置权限按钮
	 * 
	 * @param myaction
	 * @param menuess
	 *            ：菜单编码
	 * @param BUTTON_ENUM_IDS
	 *            ：权限按钮编码
	 */

	public boolean checkMenues(ButtonEnumRuleAction action, String menuess[],
			String BUTTON_ENUM_IDS[]) {
		boolean flag = true;
		String hql = "from TSysButtonEnumRule where  menuId=? and buttonEnumId=? ";
		String menuesName = null;
		long count = 0;
		String existMenuid = null;
		label:
		for (int i = 0; i < menuess.length; i++) {
			for (int j = 0; j < BUTTON_ENUM_IDS.length; j++) {
				count = getBaseDao().count("select count(*) as c " + hql,
						menuess[i], BUTTON_ENUM_IDS[j]);
				if (count > 0) {
					existMenuid = menuess[i];
					break label;
				}
			}
		}
		if(existMenuid!=null){
			String hqlSelect = "select menuName from TSysMenu  where menuid=?";
			menuesName = String.valueOf(getBaseDao().findFieldValue(hqlSelect, existMenuid));
			action.addActionError("已经存在适用该菜单【"+menuesName + "】的规则，要为该菜单下的按钮设置新规则，请先删除以前的规则");
			flag = false;
		}
		return flag;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		ButtonEnumRuleAction action = (ButtonEnumRuleAction) myaction;
		TSysButtonRule tsysButtonRule = action.getTsysButtonRule();

		String menues = action.getParameter("menues");// 获取选中的菜单id集合值
		Object BUTTON_ENUM_ID[] = action.getParameters("BUTTON_ENUM_ID");// 获取选中的权限按钮的id集合值
		String BUTTON_ENUM_I = "";
		String cycleStart = null;
		String cycleEnd = null;

		for (int i = 0; i < BUTTON_ENUM_ID.length; i++) {
			BUTTON_ENUM_I += BUTTON_ENUM_ID[i].toString() + ",";
		}
		String menuess[] = menues.split(",");
		String BUTTON_ENUM_IDS[] = BUTTON_ENUM_I.split(",");
		if (SysConstants.BUTTON_RULE_EACH_DAY == Integer
				.parseInt(tsysButtonRule.getCycleType())) {// 每天
			cycleStart = action.getParameter("kshour") + ":"
					+ action.getParameter("ksminute");
			cycleEnd = action.getParameter("jshour") + ":"
					+ action.getParameter("jsminute");
			action.setParameter("kshour", action.getParameter("kshour"));
			action
					.setParameter("ksminute", action
							.getParameter("ksminute"));
			action.setParameter("jshour", action.getParameter("jshour"));
			action
					.setParameter("jsminute", action
							.getParameter("jsminute"));
		} else if (SysConstants.BUTTON_RULE_EACH_MONTH == Integer
				.parseInt(tsysButtonRule.getCycleType())) {// 每月
			cycleStart = action.getParameter("ksHao");
			cycleEnd = action.getParameter("jsHao");
			action.setParameter("ksHao", action.getParameter("ksHao"));
			action.setParameter("jsHao", action.getParameter("jsHao"));
		} else if (SysConstants.BUTTON_RULE_EACH_YEAR == Integer
				.parseInt(tsysButtonRule.getCycleType())) {// 每年
			cycleStart = action.getParameter("ksMonth") + "-"
					+ action.getParameter("ksDay");
			cycleEnd = action.getParameter("jsMonth") + "-"
					+ action.getParameter("jsDay");
			action.setParameter("ksMonth", action.getParameter("ksMonth"));
			action.setParameter("ksDay", action.getParameter("ksDay"));
			action.setParameter("jsMonth", action.getParameter("jsMonth"));
			action.setParameter("jsDay", action.getParameter("jsDay"));
		}
		
		if(StringUtils.isBlank(tsysButtonRule.getState())){
			tsysButtonRule.setState("1");
		}
		if (tsysButtonRule.getWid() == null
				|| "".equals(tsysButtonRule.getWid())) {// 新增
			boolean flag = checkMenues(action, menuess, BUTTON_ENUM_IDS);// 根据菜单编号判断该菜单是否已配置权限按钮
			if (flag) {
				tsysButtonRule.setWid(SeqFactory.getNewSequenceAlone());
				tsysButtonRule.setCycleStart(cycleStart);
				tsysButtonRule.setCycleEnd(cycleEnd);
				getBaseDao().save(tsysButtonRule);// 模块功能开放规则表
			}
//			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_Button_Rule, Constants.LOG_ACTION_SAVE);
		} else {// 修改
			getBaseDao().delete(
					"delete TSysButtonEnumRule where buttonRuleId=?",
					tsysButtonRule.getWid());// 先删除//模块功能与开放规则关联表的相关数据
			//先删除后再去判断是否有其他规则里包含该菜单和按钮
			boolean flag = checkMenues(action, menuess, BUTTON_ENUM_IDS);// 根据菜单编号判断该菜单是否已配置权限按钮
			if (flag) {
				tsysButtonRule.setCycleStart(cycleStart);
				tsysButtonRule.setCycleEnd(cycleEnd);
				getBaseDao().update(tsysButtonRule);// 模块功能开放规则表
			}
//			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SYS_Button_Rule, Constants.LOG_ACTION_UPDATE);
		}
		action.setParameter("menues", action.getParameter("menues"));
		action.setParameter("BUTTON_ENUM_ID", action
				.getParameters("BUTTON_ENUM_ID"));
		
		List<TSysButtonEnumRule> tsysButtonEnumRules = new ArrayList<TSysButtonEnumRule>();

		for (int i = 0; i < menuess.length; i++) {
			for (int j = 0; j < BUTTON_ENUM_IDS.length; j++) {
				if (menuess[i].length() == 9) {
					TSysButtonEnumRule tsysButtonEnumRule = new TSysButtonEnumRule();
					tsysButtonEnumRule.setWid(SeqFactory
							.getNewSequenceAlone());
					tsysButtonEnumRule.setMenuId(menuess[i]);
					tsysButtonEnumRule.setButtonRuleId(tsysButtonRule
							.getWid());
					tsysButtonEnumRule.setButtonEnumId(BUTTON_ENUM_IDS[j]);
					tsysButtonEnumRules.add(tsysButtonEnumRule);
				}
			}
		}
		getBaseDao().saveAll(tsysButtonEnumRules);
	
	}
}
