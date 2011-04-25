package com.imchooser.infoms.util;

import com.imchooser.util.StringUtil;

public class GetDbtUrl {

	public  static String getUrl(String departid){
		if(StringUtil.isNotBlank(departid)){
			int depart = Integer.parseInt(departid);
			switch (depart) {
			case 320001:
				departid = "sportCjcxDbt-nj.html";
				break;
			case 320002:
				departid = "sportCjcxDbt-wx.html";
				break;
			case 320003:
				departid = "sportCjcxDbt-xz.html";
				break;
			case 320004:
				departid = "sportCjcxDbt-cz.html";
				break;
			case 320005:
				departid = "sportCjcxDbt-sz.html";
				break;
			case 320006:
				departid = "sportCjcxDbt-nt.html";
				break;
			case 320007:
				departid = "sportCjcxDbt-lyg.html";
				break;
			case 320008:
				departid = "sportCjcxDbt-ha.html";
				break;
			case 320009:
				departid = "sportCjcxDbt-yc.html";
				break;
			case 320010:
				departid = "sportCjcxDbt-yz.html";
				break;
			case 320011:
				departid = "sportCjcxDbt-zj.html";
				break;
			case 320012:
				departid = "sportCjcxDbt-tz.html";
				break;
			case 320013:
				departid = "sportCjcxDbt-sq.html";
				break;
			}
		}
		return departid;
	}
}
