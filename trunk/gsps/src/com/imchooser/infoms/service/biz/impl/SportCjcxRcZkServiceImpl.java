package com.imchooser.infoms.service.biz.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportCjcxRcZkAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.util.StringUtil;

/**
 * 比赛项目 赛程总表 （赛事日程表）
 * 
 * @author Wangjunjun
 * @date 2010-3-22
 */

public class SportCjcxRcZkServiceImpl extends BaseServiceAbstractSupport {

	@SuppressWarnings("static-access")
	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportCjcxRcZkAction action = (SportCjcxRcZkAction)myaction;
		//查出所有的项目
		//String hql = " select t.dxmmc from TSportBsxm t group by t.dxmmc order by t.dxmmc";
		String hql = "  select t.dxmmc  from T_Sport_Bsxm t  left join T_Sport_Ssrc a on a.xmbm=t.wid group by t.dxmmc order by max(a.bssj) desc";
		action.setParameter("cssS", action.getParameter("cssS"));
		String jd = action.getParameter("jd");
		if(StringUtil.isBlank(jd)){
 			List<String[]> dates= action.getListDate();
 			//取得最近日期索引
 			int i = action.getColseDay();
 			//取得最近的日期
 			String date = dates.get(i)[3];
 			//获取第几阶段
			Object obj = DBUtil.queryFieldValue("select max(a.djjd) from t_sport_ssrc a where to_char(a.bssj,'yyyy-MM-dd')=?", date);
			if(obj!=null){
				jd = String.valueOf(obj);
			}else{
				jd="3";
			}
		}
		action.setParameter("jd", jd);
		
		List<TSportBsxm> bsxmsj3 =getScoreTime(jd,action);
		action.setParameter("bsxmsj3", bsxmsj3);
		List<Object[]> Bsxmfiledvalue = DBUtil.queryAllList(hql);
		ArrayList<TSportBsxm> listBsxms  = new ArrayList<TSportBsxm>();
		if(Bsxmfiledvalue!=null){
			for(Object[] obj_value : Bsxmfiledvalue){
				TSportBsxm bsxm = new TSportBsxm();
				if(obj_value!=null && obj_value[0]!=null ){
					bsxm.setDxmmc(String.valueOf(obj_value[0]));
				}else{
					bsxm.setDxmmc("");
				}
				listBsxms.add(bsxm);
			}
		}
		//右边 小计
		String sql_right_total= " select  b.dxmmc,nvl(sum(c.jps),0) from T_Sport_Bsxm b left join t_sport_ssrc t " +
				"on t.xmbm=b.wid and t.scbm='2' left join (select sum(a.pmjps) as jps,a.xmbm " +
				"from t_sport_scdfgz a group by xmbm) c on c.xmbm=b.wid and c.xmbm=t.xmbm group by b.dxmmc ";
		//数据应该得的金牌数
		String sql_down_total= " select  sum(nvl(g.pmjps,0)) gg ,to_char(d.bssj,'YYYY-MM-DD')," +
				"t.dxmmc from t_sport_ssrc d left join t_sport_scdfgz g on g.xmbm=d.xmbm " +
				"left join t_sport_bsxm t on  t.wid=d.xmbm " +
				"where  d.djjd='"+jd+"'  and d.scbm=2 group by to_char(d.bssj,'YYYY-MM-DD'),t.dxmmc " +
				"union all" +
				" select 0,to_char(d.bssj,'YYYY-MM-DD'),t.dxmmc from t_sport_ssrc d " +
				"left join t_sport_bsxm t on  t.wid=d.xmbm where  d.djjd='"+jd+"' and d.scbm!=2 group by to_char(d.bssj,'YYYY-MM-DD'),t.dxmmc ";
		//下边金牌总数
		String sql_down_total2= " select sum(pmjps),to_char(bssj,'YYYY-MM-DD') as sj from t_sport_scdfgz a , t_sport_ssrc d,t_sport_bsxm b where d.scbm=2 and d.djjd='"+jd+"' and b.wid=d.xmbm and a.xmbm=d.xmbm group by to_char(bssj,'YYYY-MM-DD')";
		//select sum(pmjps),to_char(bssj,'YYYY-MM-DD') as sj from t_sport_scdfgz a , t_sport_ssrc d where d.scbm=2 and d.djjd='3' and a.xmbm=d.xmbm group by to_char(bssj,'YYYY-MM-DD')

		List<Object[]> objs1 = DBUtil.queryAllList(sql_right_total);
		List<Object[]> objs2 = DBUtil.queryAllList(sql_down_total2);
		//数据应该得的金牌数
		List<Object[]> objs3 = DBUtil.queryAllList(sql_down_total);
		action.setParameter("right", objs1);
		action.setParameter("down", objs2);
		//数据应该得的金牌数
		action.setParameter("down2", objs3);
		//action.setListSportCjTdHzs1(cjTdHzs1);
		//action.setListSportCjTdHzs2(cjTdHzs2);
		//action.setListSportCjTdHzs3(cjTdHzs3);
		return listBsxms;
	}
		public void load(Object myaction) throws Exception {
	}

	public boolean remove(Object myaction) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
	}

	/**
	 * 提供比赛的具体时间 wangjunjun
	 * 
	 * @return
	 */
	public List<TSportBsxm> getScoreTime(String djjd,SportCjcxRcZkAction action) {
		List<TSportBsxm> array = new ArrayList<TSportBsxm>();
		String sql = "select  to_char(p.bssj,'yyyy-MM-dd')  from t_sport_ssrc p where 1=1 ";
		if(StringUtil.isNotBlank(djjd)){
			sql += " and p.djjd='"+djjd+"' ";
		}else{
			sql += " and p.djjd='3' ";
		}
		// 加入开幕式 闭幕式的时间
		String kmssj = action.getKmssj();
		String bmssj = action.getBmssj();
		
		sql+=" group by to_char(p.bssj,'yyyy-MM-dd')  order by  to_char(p.bssj,'yyyy-MM-dd')";
		List<Object[]> objs = DBUtil.queryAllList(sql);
		if(objs==null){
			objs = new ArrayList<Object[]>();
		}
		//放入set去除重复数据
		Set<String> set = new HashSet<String>();
		for(Object[] temp : objs){
			set.add(String.valueOf(temp[0]));
		}
		
		if("3".equals(djjd)){
			if(StringUtil.isNotBlank(kmssj)){
				set.add(kmssj);
			}
			if(StringUtil.isNotBlank(bmssj)){
				set.add(bmssj);
			}
		}
		//有set转入list 中 便于排序
		List <String>  liststr = new ArrayList<String>();
		for(String str : set){
			liststr.add(str);
		}
		//sort 方法 从小到大日期排序
		java.util.Collections.sort(liststr);
		
		//收集不同月份
		Set<String> str_mount = new HashSet<String>();
		if (liststr.size() > 0) {
			for (String datestr : liststr) {
				String time = String.valueOf(datestr);
				String[] str_time = null;
				if (StringUtil.isNotBlank(time)) {
					str_time = time.split("-");
				}
				if (str_time != null) {
					TSportBsxm bsxm = new TSportBsxm();
					bsxm.setStartTime(time);
					bsxm.setEndTime(str_time[2]);
					str_mount.add(String.valueOf(str_time[1]));
					array.add(bsxm);
				}
			}
		}
		Object [] obj = str_mount.toArray();
		sort(obj);
		StringBuilder sb_mount = new StringBuilder();
		if(obj!=null && obj.length>0){
			for(int k=0;k<obj.length;k++){
				if(k==0){
					if(obj.length==1){
						sb_mount.append("(月"+obj[k]+")");
					}else{
						sb_mount.append("(月"+obj[k]);
					}
					
				}else if(k==obj.length-1){
					sb_mount.append("/"+obj[k]+")");
				}else{
					sb_mount.append("/"+obj[k]);
				}
				
			}
		}
		action.setParameter("mouths", sb_mount.toString());
		return array;
	}

	//月份顺序排序 
	public static void sort(Object temp[]) {
		for (int i = 0; i < temp.length; i++) {
			for (int j = i+1; j < temp.length; j++) {
				if (Integer.parseInt(String.valueOf(temp[i])) > Integer.parseInt(String.valueOf(temp[j]))) {
					Object x = temp[i];
					temp[i] = temp[j];
					temp[j] = x;
				}
			}
		}
	}
}
