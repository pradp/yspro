package com.imchooser.infoms.service.biz.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportCjcxPjlAction;
import com.imchooser.infoms.entity.biz.TSportCjYdy;

public class SportCjcxPjlServiceImpl extends BaseServiceAbstractSupport
{
  @SuppressWarnings("unchecked")
public List<?> list(Object myaction, Pager page)
    throws Exception
  {
    SportCjcxPjlAction action = (SportCjcxPjlAction)myaction;

    String sql_list = " select ( select c.zdmc from T_Sys_Code c where c.zdbm=t.pjllx and c.zdlb='YDY_PJLLX' ) as pjllx, t.pjllx as pjllx1, replace(wmsys.wm_concat((select b.xm from  T_Sport_Ydyxx b where t.ydybm=b.wid )),',','，')as ydybm,  " +
    		" t.dxmmc,t.xxmmc,  t.bz as bz,t.dbd,t.yjlcj,t.cj, s.fbzt,to_char(s.bssj,'yyyy-MM-dd')as bssj,count(*) as rs  from T_Sport_Cj_Ydy t,t_sport_ssrc s where t.pjllx>0 and t.scbm=s.wid and s.fbzt=3  " +
    		" group by t.xxmmc,t.pjllx,t.dxmmc,t.dbd,t.cj,t.yjlcj,s.fbzt,s.bssj,t.bz order by s.bssj desc";

    List<TSportCjYdy> listCj = DBUtil.queryAllBeanList(sql_list, TSportCjYdy.class, new Object[0]);
    action.setListCj(listCj);

    int[] rdcs = getCount(listCj, "举重", "1");
    action.setParameter("jz_pljlx1_rs", String.valueOf(rdcs[0]));
    action.setParameter("jz_pljlx1_ds", String.valueOf(rdcs[1]));
    action.setParameter("jz_pljlx1_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "举重", "2");
    action.setParameter("jz_pljlx2_rs", String.valueOf(rdcs[0]));
    action.setParameter("jz_pljlx2_ds", String.valueOf(rdcs[1]));
    action.setParameter("jz_pljlx2_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "举重", "3");
    action.setParameter("jz_pljlx3_rs", String.valueOf(rdcs[0]));
    action.setParameter("jz_pljlx3_ds", String.valueOf(rdcs[1]));
    action.setParameter("jz_pljlx3_cs", String.valueOf(rdcs[2]));

    rdcs = getCount(listCj, "射击", "1");
    action.setParameter("sji_pljlx1_rs", String.valueOf(rdcs[0]));
    action.setParameter("sji_pljlx1_ds", String.valueOf(rdcs[1]));
    action.setParameter("sji_pljlx1_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "射击", "2");
    action.setParameter("sji_pljlx2_rs", String.valueOf(rdcs[0]));
    action.setParameter("sji_pljlx2_ds", String.valueOf(rdcs[1]));
    action.setParameter("sji_pljlx2_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "射击", "3");
    action.setParameter("sji_pljlx3_rs", String.valueOf(rdcs[0]));
    action.setParameter("sji_pljlx3_ds", String.valueOf(rdcs[1]));
    action.setParameter("sji_pljlx3_cs", String.valueOf(rdcs[2]));

    rdcs = getCount(listCj, "射箭", "1");
    action.setParameter("sjian_pljlx1_rs", String.valueOf(rdcs[0]));
    action.setParameter("sjian_pljlx1_ds", String.valueOf(rdcs[1]));
    action.setParameter("sjian_pljlx1_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "射箭", "2");
    action.setParameter("sjian_pljlx2_rs", String.valueOf(rdcs[0]));
    action.setParameter("sjian_pljlx2_ds", String.valueOf(rdcs[1]));
    action.setParameter("sjian_pljlx2_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "射箭", "3");
    action.setParameter("sjian_pljlx3_rs", String.valueOf(rdcs[0]));
    action.setParameter("sjian_pljlx3_ds", String.valueOf(rdcs[1]));
    action.setParameter("sjian_pljlx3_cs", String.valueOf(rdcs[2]));

    rdcs = getCount(listCj, "田径", "1");
    action.setParameter("tj_pljlx1_rs", String.valueOf(rdcs[0]));
    action.setParameter("tj_pljlx1_ds", String.valueOf(rdcs[1]));
    action.setParameter("tj_pljlx1_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "田径", "2");
    action.setParameter("tj_pljlx2_rs", String.valueOf(rdcs[0]));
    action.setParameter("tj_pljlx2_ds", String.valueOf(rdcs[1]));
    action.setParameter("tj_pljlx2_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "田径", "3");
    action.setParameter("tj_pljlx3_rs", String.valueOf(rdcs[0]));
    action.setParameter("tj_pljlx3_ds", String.valueOf(rdcs[1]));
    action.setParameter("tj_pljlx3_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "田径", "4");
    action.setParameter("tj_pljlx4_rs", String.valueOf(rdcs[0]));
    action.setParameter("tj_pljlx4_ds", String.valueOf(rdcs[1]));
    action.setParameter("tj_pljlx4_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "田径", "5");
    action.setParameter("tj_pljlx5_rs", String.valueOf(rdcs[0]));
    action.setParameter("tj_pljlx5_ds", String.valueOf(rdcs[1]));
    action.setParameter("tj_pljlx5_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "田径", "6");
    action.setParameter("tj_pljlx6_rs", String.valueOf(rdcs[0]));
    action.setParameter("tj_pljlx6_ds", String.valueOf(rdcs[1]));
    action.setParameter("tj_pljlx6_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "田径", "7");
    action.setParameter("tj_pljlx7_rs", String.valueOf(rdcs[0]));
    action.setParameter("tj_pljlx7_ds", String.valueOf(rdcs[1]));
    action.setParameter("tj_pljlx7_cs", String.valueOf(rdcs[2]));

    rdcs = getCount(listCj, "游泳", "1");
    action.setParameter("yy_pljlx1_rs", String.valueOf(rdcs[0]));
    action.setParameter("yy_pljlx1_ds", String.valueOf(rdcs[1]));
    action.setParameter("yy_pljlx1_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "游泳", "2");
    action.setParameter("yy_pljlx2_rs", String.valueOf(rdcs[0]));
    action.setParameter("yy_pljlx2_ds", String.valueOf(rdcs[1]));
    action.setParameter("yy_pljlx2_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "游泳", "3");
    action.setParameter("yy_pljlx3_rs", String.valueOf(rdcs[0]));
    action.setParameter("yy_pljlx3_ds", String.valueOf(rdcs[1]));
    action.setParameter("yy_pljlx3_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "游泳", "4");
    action.setParameter("yy_pljlx4_rs", String.valueOf(rdcs[0]));
    action.setParameter("yy_pljlx4_ds", String.valueOf(rdcs[1]));
    action.setParameter("yy_pljlx4_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "游泳", "5");
    action.setParameter("yy_pljlx5_rs", String.valueOf(rdcs[0]));
    action.setParameter("yy_pljlx5_ds", String.valueOf(rdcs[1]));
    action.setParameter("yy_pljlx5_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "游泳", "6");
    action.setParameter("yy_pljlx6_rs", String.valueOf(rdcs[0]));
    action.setParameter("yy_pljlx6_ds", String.valueOf(rdcs[1]));
    action.setParameter("yy_pljlx6_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "游泳", "7");
    action.setParameter("yy_pljlx7_rs", String.valueOf(rdcs[0]));
    action.setParameter("yy_pljlx7_ds", String.valueOf(rdcs[1]));
    action.setParameter("yy_pljlx7_cs", String.valueOf(rdcs[2]));

    rdcs = getCount(listCj, "自行车", "1");
    action.setParameter("zxc_pljlx1_rs", String.valueOf(rdcs[0]));
    action.setParameter("zxc_pljlx1_ds", String.valueOf(rdcs[1]));
    action.setParameter("zxc_pljlx1_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "自行车", "2");
    action.setParameter("zxc_pljlx2_rs", String.valueOf(rdcs[0]));
    action.setParameter("zxc_pljlx2_ds", String.valueOf(rdcs[1]));
    action.setParameter("zxc_pljlx2_cs", String.valueOf(rdcs[2]));
    rdcs = getCount(listCj, "自行车", "3");
    action.setParameter("zxc_pljlx3_rs", String.valueOf(rdcs[0]));
    action.setParameter("zxc_pljlx3_ds", String.valueOf(rdcs[1]));
    action.setParameter("zxc_pljlx3_cs", String.valueOf(rdcs[2]));
    return null;
  }

  @SuppressWarnings("unchecked")
private int[] getCount(List<TSportCjYdy> listCj, String dxmmc, String pjllx)
  {
    String ydybm = "";
    int[] rdcs = new int[3];
    Set ds_set = new HashSet();
    for (TSportCjYdy cjYdy : listCj) {
      if ((cjYdy.getDxmmc().equals(dxmmc)) && (cjYdy.getPjllx1().equals(pjllx))) {
        if (!ydybm.equals(cjYdy.getYdybm())) {
          rdcs[0] += cjYdy.getRs();
        }
        ds_set.add(cjYdy.getDbd());
        rdcs[2] += 1;
      }
    }
    rdcs[1] = ds_set.size();
    return rdcs;
  }

  public void load(Object arg0) throws Exception
  {
  }

  public boolean remove(Object arg0) throws Exception {
    return false;
  }

  public void saveOrUpdate(Object arg0)
    throws Exception
  {
  }
}