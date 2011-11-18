package com.yszoe.identity.service.impl;

import java.util.List;

import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.identity.action.IdMenuButtonAction;
import com.yszoe.identity.service.IdMenuButtonService;
import com.yszoe.sys.entity.ApplicationEnum;
import com.yszoe.sys.util.SQLConfigUtil;
import com.yszoe.util.StringUtil;

/**
 * 菜单按钮配置
 * 
 * @author Linyang datetime 2011-6-7
 */
@SuppressWarnings("unchecked")
public class IdMenuButtonServiceImpl extends AbstractBaseServiceSupport implements IdMenuButtonService {

	public void export2excel(Object arg0) throws Exception {

	}

	public List<?> list(Object myaction, Pager pager) throws Exception {
		IdMenuButtonAction action = (IdMenuButtonAction) myaction;
		queryAllMenu(action);
		action.setListButton(queryAllButton());
		return null;
	}

	/**
	 * 根据菜单id获取菜单名
	 * 
	 * @param menuid 菜单id
	 * @return 菜单名
	 * @throws Exception
	 */
	private String getMenuName(String menuid) throws Exception {
		String hql = "select menuname from TSysMenu where menuid=?";
		String menuname = (String) getBaseDao().findFieldValue(hql, menuid);
		return menuname;
	}

	/**
	 * 获取二级菜单以下的菜单
	 * 
	 * @throws Exception
	 */
	private void queryAllMenu(Object myaction) throws Exception {
		IdMenuButtonAction action = (IdMenuButtonAction) myaction;
		String upmenuid = action.getParameter("upmenuid");
		if (StringUtil.isNotBlank(upmenuid)) {
			// 改菜单下有子菜单时
			if (getBaseDao().count(" from TSysMenu where upmenuid like ? and state = '1'", upmenuid + "%") > 0) {
				int max_len = Integer.parseInt(String.valueOf(getBaseDao().findFieldValue(
						"select max(length(menuid)) from TSysMenu where upmenuid like ? ", upmenuid + "%")));
				String sql = SQLConfigUtil.getSql("sql.menuButton.loadMySons");
				List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class, upmenuid + "%");
				action.setMax_length_menuid(max_len);
				action.setListMenu(list);
			}
			action.setParameter("upmenuid", upmenuid);
			action.setParameter("menuname", getMenuName(upmenuid));
		}
	}

	/**
	 * 获取按钮名
	 * 
	 * @throws Exception
	 */
	private List<ApplicationEnum> queryAllButton() throws Exception {
		List<ApplicationEnum> list = null;
		String hql = "select new ApplicationEnum(buttonid as id,t.buttonname as caption)"
				+ " from TSysButton t where state = '1' order by ordernum desc,buttonid ";
		list = getBaseDao().findByHql(hql);
		return list;
	}

	public void load(Object arg0) throws Exception {

	}

	public void openCreate(Object arg0) throws Exception {

	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {

	}

}
