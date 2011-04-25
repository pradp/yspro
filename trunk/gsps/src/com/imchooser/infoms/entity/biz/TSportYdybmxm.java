package com.imchooser.infoms.entity.biz;



/**
 * TSportYdybmxm entity. @author MyEclipse Persistence Tools
 * 运动员报名项目信息
 */

@SuppressWarnings("serial")
public class TSportYdybmxm  implements java.io.Serializable {


    // Fields    

     private String wid;
     private String bsxmwid;
     private String ydywid;
     private String dxmmc;
     private String xm;//手动添加  非持久化
     private String bsxm;//手动添加  非持久化
     private String fenzu;
     private String zb;

    // Constructors

    /** default constructor */
    public TSportYdybmxm() {
    }

	/** minimal constructor */
    public TSportYdybmxm(String wid) {
        this.wid = wid;
    }
    
    /** full constructor */
    public TSportYdybmxm(String wid, String bsxmwid, String ydywid) {
        this.wid = wid;
        this.bsxmwid = bsxmwid;
        this.ydywid = ydywid;
    }

    //SportYdyxxServiceImpl中的submitOrSave使用
    public TSportYdybmxm(String xm, String bsxm) {
        this.xm = xm;
        this.bsxm = bsxm;
    }

    // Property accessors

    public String getWid() {
        return this.wid;
    }
    
    public void setWid(String wid) {
        this.wid = wid;
    }

    public String getBsxmwid() {
        return this.bsxmwid;
    }
    
    public void setBsxmwid(String bsxmwid) {
        this.bsxmwid = bsxmwid;
    }

    public String getYdywid() {
        return this.ydywid;
    }
    
    public void setYdywid(String ydywid) {
        this.ydywid = ydywid;
    }

	public String getDxmmc() {
		return dxmmc;
	}

	public void setDxmmc(String dxmmc) {
		this.dxmmc = dxmmc;
	}

	public String getXm() {
		return xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	public String getBsxm() {
		return bsxm;
	}

	public void setBsxm(String bsxm) {
		this.bsxm = bsxm;
	}

	public String getFenzu() {
		return fenzu;
	}

	public void setFenzu(String fenzu) {
		this.fenzu = fenzu;
	}

	public String getZb() {
		return zb;
	}

	public void setZb(String zb) {
		this.zb = zb;
	}
    
   
}