package com.imchooser.infoms.entity.biz;



/**
 * TSportScdfgz entity. @author MyEclipse Persistence Tools
 * 赛次得分规则
 */

@SuppressWarnings("serial")
public class TSportScdfgz  implements java.io.Serializable {


    // Fields    

     private String wid;
     private String xmbm;
     private Short pmjb;
     private Double pmdf;
     private Double pmjps;
     private Double pmyps;
     private Double pmtps;
     private String sfdjgz;


    // Constructors

    /** default constructor */
    public TSportScdfgz() {
    }

	/** minimal constructor */
    public TSportScdfgz(String wid) {
        this.wid = wid;
    }
    
    /** full constructor */
    public TSportScdfgz(String wid, String xmbm, Short pmjb, Double pmdf, Double pmjps, Double pmyps, Double pmtps, String sfdjgz) {
        this.wid = wid;
        this.xmbm = xmbm;
        this.pmjb = pmjb;
        this.pmdf = pmdf;
        this.pmjps = pmjps;
        this.pmyps = pmyps;
        this.pmtps = pmtps;
        this.sfdjgz = sfdjgz;
    }

   
    // Property accessors

    public String getWid() {
        return this.wid;
    }
    
    public void setWid(String wid) {
        this.wid = wid;
    }

    public String getXmbm() {
        return this.xmbm;
    }
    
    public void setXmbm(String xmbm) {
        this.xmbm = xmbm;
    }

    public Short getPmjb() {
        return this.pmjb;
    }
    
    public void setPmjb(Short pmjb) {
        this.pmjb = pmjb;
    }

    public Double getPmdf() {
        return this.pmdf;
    }
    
    public void setPmdf(Double pmdf) {
        this.pmdf = pmdf;
    }

    public Double getPmjps() {
        return this.pmjps;
    }
    
    public void setPmjps(Double pmjps) {
        this.pmjps = pmjps;
    }

    public Double getPmyps() {
        return this.pmyps;
    }
    
    public void setPmyps(Double pmyps) {
        this.pmyps = pmyps;
    }

    public Double getPmtps() {
        return this.pmtps;
    }
    
    public void setPmtps(Double pmtps) {
        this.pmtps = pmtps;
    }

    public String getSfdjgz() {
        return this.sfdjgz;
    }
    
    public void setSfdjgz(String sfdjgz) {
        this.sfdjgz = sfdjgz;
    }
   








}