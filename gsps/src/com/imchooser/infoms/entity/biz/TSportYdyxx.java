package com.imchooser.infoms.entity.biz;

import java.util.Date;


/**
 * TSportYdyxx entity. @author MyEclipse Persistence Tools
 * 运动员信息
 */

@SuppressWarnings("serial")
public class TSportYdyxx  implements java.io.Serializable {

    // Fields    

     private String wid;
     private String yddbm;
     private String yddbmName;//手动添加字段，用于显示汉字名称
     private String xm;
     private String csrq;
     private String xb;
     private Double sg;
     private Double tz;
     private String sfzh;
     private String zch;
     private String xyjfdq1;
     private String xyjfdqName1;//手动添加字段，用于显示汉字名称
     private Double xyjfbl1;
     private Double xydpbl1;
     private String xyjfdq2;
     private String xyjfdqName2;//手动添加字段，用于显示汉字名称
     private Double xyjfbl2;
     private Double xydpbl2;
     private String xyjfdq3;
     private String xyjfdqName3;//手动添加字段，用于显示汉字名称
     private Double xyjfbl3;
     private Double xydpbl3;
     private String xyjfdq4;
     private String xyjfdqName4;//手动添加字段，用于显示汉字名称
     private Double xyjfbl4;
     private Double xydpbl4;
     private String xyjfdq5;
     private String xyjfdqName5;//手动添加字段，用于显示汉字名称
     private Double xyjfbl5;
     private Double xydpbl5;
     private String xyjfdq6;
     private String xyjfdqName6;//手动添加字段，用于显示汉字名称
     private Double xyjfbl6;
     private Double xydpbl6;
     private String xyjfdq7;
     private String xyjfdqName7;//手动添加字段，用于显示汉字名称
     private Double xyjfbl7;
     private Double xydpbl7;
	 private Date createtime;
	 private String zp;
	 private String xmpy;
	 private String state;
	 private String shzt;
	 private String xyjfdq3isorno;//手动添加字段, 用于承训地有无;
	 private String xyjfdq7isorno;//手动添加字段, 用于注册地有无;
	 private String xyjfdq2isorno;//手动添加字段, 用于原注册地有无;
	 private String xyjfdq5isorno;//手动添加字段, 用于原注册地区县有无;
	 private String xyjfdq4isorno;//手动添加字段, 用于原籍有无;

    // Constructors

    /** default constructor */
    public TSportYdyxx() {
    }

	/** minimal constructor */
    public TSportYdyxx(String wid, String yddbm, Date createtime) {
        this.wid = wid;
        this.yddbm = yddbm;
        this.createtime = createtime;
    }
    
    /** full constructor */
    public TSportYdyxx(String wid, String yddbm, String xm, String csrq, String xb, Double sg, Double tz, String sfzh, String zch, 
    		String xyjfdq1, Double xyjfbl1, Double xydpbl1, String xyjfdq2, Double xyjfbl2, Double xydpbl2, String xyjfdq3, Double xyjfbl3, Double xydpbl3,
    		String xyjfdq4, Double xyjfbl4, Double xydpbl4, 
    		String xyjfdq5, Double xyjfbl5, Double xydpbl5,
    		String xyjfdq6, Double xyjfbl6, Double xydpbl6,
    		String xyjfdq7, Double xyjfbl7, Double xydpbl7, Date createtime, String zp,String state,String shzt ) {
        this.wid = wid;
        this.yddbm = yddbm;
        this.xm = xm;
        this.csrq = csrq;
        this.xb = xb;
        this.sg = sg;
        this.tz = tz;
        this.sfzh = sfzh;
        this.zch = zch;
        this.xyjfdq1 = xyjfdq1;
        this.xyjfbl1 = xyjfbl1;
        this.xydpbl1 = xydpbl1;
        this.xyjfdq2 = xyjfdq2;
        this.xyjfbl2 = xyjfbl2;
        this.xydpbl2 = xydpbl2;
        this.xyjfdq3 = xyjfdq3;
        this.xyjfbl3 = xyjfbl3;
        this.xydpbl3 = xydpbl3;
        this.xyjfdq4 = xyjfdq4;
        this.xyjfbl4 = xyjfbl4;
        this.xydpbl4 = xydpbl4;
        this.xyjfdq5 = xyjfdq5;
        this.xyjfbl5 = xyjfbl5;
        this.xydpbl5 = xydpbl5;
        this.xyjfdq6 = xyjfdq6;
        this.xyjfbl6 = xyjfbl6;
        this.xydpbl6 = xydpbl6;
        this.xyjfdq7 = xyjfdq7;
        this.xyjfbl7 = xyjfbl7;
        this.xydpbl7 = xydpbl7;
        this.createtime = createtime;
        this.zp = zp;
        this.state = state;
        this.shzt = shzt;
    }

    //SportYdyxxServiceImpl中的list使用
    public TSportYdyxx(String wid, String yddbm, String xm, String sfzh, String zch,String xyjfdqName1,String xyjfdqName3,String xyjfdqName7,String xyjfdqName2,String xyjfdqName5,String xyjfdqName4) {
        this.wid = wid;
        this.yddbm = yddbm;
        this.xm = xm;
        this.sfzh = sfzh;
        this.zch = zch;
        this.xyjfdqName1 = xyjfdqName1;
        this.xyjfdqName3 = xyjfdqName3;
        this.xyjfdqName7 = xyjfdqName7;
        this.xyjfdqName2 = xyjfdqName2;
        this.xyjfdqName5 = xyjfdqName5;
        this.xyjfdqName4 = xyjfdqName4;
    }
    //SportCjcxYdyxxServiceImpl中的load使用
    public TSportYdyxx(String xm, String zp, String xb, Double sg, Double tz, String zch,String yddbm) {
    	this.xm = xm;
        this.zp = zp;
        this.xb = xb;
        this.sg = sg;
        this.tz = tz;
        this.zch = zch;
        this.yddbm = yddbm;
    }
    
    public TSportYdyxx(String xm) {
    	this.xm = xm;
    }
    
    //SportYdyxxServiceImpl中的load使用
    public TSportYdyxx(String wid, String yddbm, String yddbmName, String xm, String csrq, String xb, Double sg, Double tz, String sfzh, String zch,String state, 
    		String xyjfdq1, String xyjfdqName1, Double xyjfbl1, Double xydpbl1, 
    		String xyjfdq2, String xyjfdqName2, Double xyjfbl2, Double xydpbl2, 
    		String xyjfdq3, String xyjfdqName3, Double xyjfbl3, Double xydpbl3,
    		String xyjfdq4, String xyjfdqName4, Double xyjfbl4, Double xydpbl4,
    		String xyjfdq5, String xyjfdqName5, Double xyjfbl5, Double xydpbl5,
    		String xyjfdq6, String xyjfdqName6, Double xyjfbl6, Double xydpbl6,
    		String xyjfdq7, String xyjfdqName7, Double xyjfbl7, Double xydpbl7,
    		Date createtime) {
        this.wid = wid;
        this.yddbm = yddbm;
        this.yddbmName = yddbmName;
        this.xm = xm;
        this.csrq = csrq;
        this.xb = xb;
        this.sg = sg;
        this.tz = tz;
        this.sfzh = sfzh;
        this.zch = zch;
        this.state= state;
        this.xyjfdq1 = xyjfdq1;
        this.xyjfdqName1 = xyjfdqName1;
        this.xyjfbl1 = xyjfbl1;
        this.xydpbl1 = xydpbl1;
        this.xyjfdq2 = xyjfdq2;
        this.xyjfdqName2 = xyjfdqName2;
        this.xyjfbl2 = xyjfbl2;
        this.xydpbl2 = xydpbl2;
        this.xyjfdq3 = xyjfdq3;
        this.xyjfdqName3 = xyjfdqName3;
        this.xyjfbl3 = xyjfbl3;
        this.xydpbl3 = xydpbl3;
        this.xyjfdq4 = xyjfdq4;
        this.xyjfdqName4 = xyjfdqName4;
        this.xyjfbl4 = xyjfbl4;
        this.xydpbl4 = xydpbl4;
        this.xyjfdq5 = xyjfdq5;
        this.xyjfdqName5 = xyjfdqName5;
        this.xyjfbl5 = xyjfbl5;
        this.xydpbl5 = xydpbl5;
        this.xyjfdq6 = xyjfdq6;
        this.xyjfdqName6 = xyjfdqName6;
        this.xyjfbl6 = xyjfbl6;
        this.xydpbl6 = xydpbl6;
        this.xyjfdq7 = xyjfdq7;
        this.xyjfdqName7 = xyjfdqName7;
        this.xyjfbl7 = xyjfbl7;
        this.xydpbl7 = xydpbl7;
        this.createtime = createtime;
    }
    
    // Property accessors

    public String getWid() {
        return this.wid;
    }
    
    public void setWid(String wid) {
        this.wid = wid;
    }

    public String getYddbm() {
        return this.yddbm;
    }
    
    public void setYddbm(String yddbm) {
        this.yddbm = yddbm;
    }

    public String getXm() {
        return this.xm;
    }
    
    public void setXm(String xm) {
        this.xm = xm;
    }

    public String getCsrq() {
        return this.csrq;
    }
    
    public void setCsrq(String csrq) {
        this.csrq = csrq;
    }

    public String getXb() {
        return this.xb;
    }
    
    public void setXb(String xb) {
        this.xb = xb;
    }

    public Double getSg() {
        return this.sg;
    }
    
    public void setSg(Double sg) {
        this.sg = sg;
    }

    public Double getTz() {
        return this.tz;
    }
    
    public void setTz(Double tz) {
        this.tz = tz;
    }

    public String getSfzh() {
        return this.sfzh;
    }
    
    public void setSfzh(String sfzh) {
        this.sfzh = sfzh;
    }
    
    public String getZch() {
        return this.zch;
    }
    
    public void setZch(String zch) {
        this.zch = zch;
    }

    public Date getCreatetime() {
        return this.createtime;
    }
    
    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }
   
    public String getXyjfdq1() {
		return xyjfdq1;
	}

	public void setXyjfdq1(String xyjfdq1) {
		this.xyjfdq1 = xyjfdq1;
	}

	public Double getXyjfbl1() {
		return xyjfbl1;
	}

	public void setXyjfbl1(Double xyjfbl1) {
		this.xyjfbl1 = xyjfbl1;
	}

	public Double getXydpbl1() {
		return xydpbl1;
	}

	public void setXydpbl1(Double xydpbl1) {
		this.xydpbl1 = xydpbl1;
	}

	public String getXyjfdq2() {
		return xyjfdq2;
	}

	public void setXyjfdq2(String xyjfdq2) {
		this.xyjfdq2 = xyjfdq2;
	}

	public Double getXyjfbl2() {
		return xyjfbl2;
	}

	public void setXyjfbl2(Double xyjfbl2) {
		this.xyjfbl2 = xyjfbl2;
	}

	public Double getXydpbl2() {
		return xydpbl2;
	}

	public void setXydpbl2(Double xydpbl2) {
		this.xydpbl2 = xydpbl2;
	}

	public String getXyjfdq3() {
		return xyjfdq3;
	}

	public void setXyjfdq3(String xyjfdq3) {
		this.xyjfdq3 = xyjfdq3;
	}

	public Double getXyjfbl3() {
		return xyjfbl3;
	}

	public void setXyjfbl3(Double xyjfbl3) {
		this.xyjfbl3 = xyjfbl3;
	}

	public Double getXydpbl3() {
		return xydpbl3;
	}

	public void setXydpbl3(Double xydpbl3) {
		this.xydpbl3 = xydpbl3;
	}

	public String getXyjfdq4() {
		return xyjfdq4;
	}

	public void setXyjfdq4(String xyjfdq4) {
		this.xyjfdq4 = xyjfdq4;
	}

	public Double getXyjfbl4() {
		return xyjfbl4;
	}

	public void setXyjfbl4(Double xyjfbl4) {
		this.xyjfbl4 = xyjfbl4;
	}

	public Double getXydpbl4() {
		return xydpbl4;
	}

	public void setXydpbl4(Double xydpbl4) {
		this.xydpbl4 = xydpbl4;
	}

	public String getXyjfdqName1() {
		return xyjfdqName1;
	}

	public void setXyjfdqName1(String xyjfdqName1) {
		this.xyjfdqName1 = xyjfdqName1;
	}

	public String getXyjfdqName2() {
		return xyjfdqName2;
	}

	public void setXyjfdqName2(String xyjfdqName2) {
		this.xyjfdqName2 = xyjfdqName2;
	}

	public String getXyjfdqName3() {
		return xyjfdqName3;
	}

	public void setXyjfdqName3(String xyjfdqName3) {
		this.xyjfdqName3 = xyjfdqName3;
	}

	public String getXyjfdqName4() {
		return xyjfdqName4;
	}

	public void setXyjfdqName4(String xyjfdqName4) {
		this.xyjfdqName4 = xyjfdqName4;
	}

	public String getYddbmName() {
		return yddbmName;
	}

	public void setYddbmName(String yddbmName) {
		this.yddbmName = yddbmName;
	}

	public String getZp() {
		return zp;
	}

	public void setZp(String zp) {
		this.zp = zp;
	}

	public String getXyjfdq5() {
		return xyjfdq5;
	}

	public void setXyjfdq5(String xyjfdq5) {
		this.xyjfdq5 = xyjfdq5;
	}

	public String getXyjfdqName5() {
		return xyjfdqName5;
	}

	public void setXyjfdqName5(String xyjfdqName5) {
		this.xyjfdqName5 = xyjfdqName5;
	}

	public Double getXyjfbl5() {
		return xyjfbl5;
	}

	public void setXyjfbl5(Double xyjfbl5) {
		this.xyjfbl5 = xyjfbl5;
	}

	public Double getXydpbl5() {
		return xydpbl5;
	}

	public void setXydpbl5(Double xydpbl5) {
		this.xydpbl5 = xydpbl5;
	}

	public String getXyjfdq6() {
		return xyjfdq6;
	}

	public void setXyjfdq6(String xyjfdq6) {
		this.xyjfdq6 = xyjfdq6;
	}

	public String getXyjfdqName6() {
		return xyjfdqName6;
	}

	public void setXyjfdqName6(String xyjfdqName6) {
		this.xyjfdqName6 = xyjfdqName6;
	}

	public Double getXyjfbl6() {
		return xyjfbl6;
	}

	public void setXyjfbl6(Double xyjfbl6) {
		this.xyjfbl6 = xyjfbl6;
	}

	public Double getXydpbl6() {
		return xydpbl6;
	}

	public void setXydpbl6(Double xydpbl6) {
		this.xydpbl6 = xydpbl6;
	}

	public String getXyjfdq7() {
		return xyjfdq7;
	}

	public void setXyjfdq7(String xyjfdq7) {
		this.xyjfdq7 = xyjfdq7;
	}

	public String getXyjfdqName7() {
		return xyjfdqName7;
	}

	public void setXyjfdqName7(String xyjfdqName7) {
		this.xyjfdqName7 = xyjfdqName7;
	}

	public Double getXyjfbl7() {
		return xyjfbl7;
	}

	public void setXyjfbl7(Double xyjfbl7) {
		this.xyjfbl7 = xyjfbl7;
	}

	public Double getXydpbl7() {
		return xydpbl7;
	}

	public void setXydpbl7(Double xydpbl7) {
		this.xydpbl7 = xydpbl7;
	}

	public String getXmpy() {
		return xmpy;
	}

	public void setXmpy(String xmpy) {
		this.xmpy = xmpy;
	}

	public String getXyjfdq3isorno() {
		return xyjfdq3isorno;
	}

	public void setXyjfdq3isorno(String xyjfdq3isorno) {
		this.xyjfdq3isorno = xyjfdq3isorno;
	}

	public String getXyjfdq7isorno() {
		return xyjfdq7isorno;
	}

	public void setXyjfdq7isorno(String xyjfdq7isorno) {
		this.xyjfdq7isorno = xyjfdq7isorno;
	}

	public String getXyjfdq2isorno() {
		return xyjfdq2isorno;
	}

	public void setXyjfdq2isorno(String xyjfdq2isorno) {
		this.xyjfdq2isorno = xyjfdq2isorno;
	}

	public String getXyjfdq5isorno() {
		return xyjfdq5isorno;
	}

	public void setXyjfdq5isorno(String xyjfdq5isorno) {
		this.xyjfdq5isorno = xyjfdq5isorno;
	}

	public String getXyjfdq4isorno() {
		return xyjfdq4isorno;
	}

	public void setXyjfdq4isorno(String xyjfdq4isorno) {
		this.xyjfdq4isorno = xyjfdq4isorno;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getShzt() {
		return shzt;
	}

	public void setShzt(String shzt) {
		this.shzt = shzt;
	}
	

}