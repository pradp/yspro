package com.imchooser.infoms.entity.sys;



/**
 * TSysArea entity. @author MyEclipse Persistence Tools
 * 区域信息表
 */

public class TSysArea  implements java.io.Serializable {


    // Fields    

     private String areaid;
     private String areaname;
     private String upareaid;
     private String upareaname;//手工添加，虚拟字段
     private String state;
     private String arealevel;

    // Constructors

    /** default constructor */
    public TSysArea() {
    }
    
    /** full constructor */
    public TSysArea(String areaid, String areaname, String upareaid, String state, String arealevel) {
        this.areaid = areaid;
        this.areaname = areaname;
        this.upareaid = upareaid;
        this.state = state;
        this.arealevel = arealevel;
    }
    
    public TSysArea( String areaid,String areaname) {
    	this.areaid = areaid;
        this.areaname = areaname;
    }
    
    // Property accessors

    public String getAreaid() {
        return this.areaid;
    }
    
    public void setAreaid(String areaid) {
        this.areaid = areaid;
    }

    public String getAreaname() {
        return this.areaname;
    }
    
    public void setAreaname(String areaname) {
        this.areaname = areaname;
    }

    public String getUpareaid() {
        return this.upareaid;
    }
    
    public void setUpareaid(String upareaid) {
        this.upareaid = upareaid;
    }

    public String getState() {
        return this.state;
    }
    
    public void setState(String state) {
        this.state = state;
    }

	public String getArealevel() {
		return arealevel;
	}

	public void setArealevel(String arealevel) {
		this.arealevel = arealevel;
	}


	public String getUpareaname() {
		return upareaname;
	}


	public void setUpareaname(String upareaname) {
		this.upareaname = upareaname;
	}
   
}