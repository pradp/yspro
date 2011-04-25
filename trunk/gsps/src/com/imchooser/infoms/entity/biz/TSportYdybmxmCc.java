package com.imchooser.infoms.entity.biz;

/**
 * AbstractTSportYdybmxmCc entity provides the base persistence definition of
 * the TSportYdybmxmCc entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class TSportYdybmxmCc implements java.io.Serializable {

	// Fields

	private String wid;
	private String dxmmc;
	private String ydywid;
	private String zczh;
	private String xm;
	private String sfzh;
	private String bsxmwid1;
	private String bsxmwid2;
	private String bsxmwid3;
	private String bsxmwid4;
	private String bsxmwid5;
	private String bsxmwid6;
	private String bsxmwid7;
	private String bsxmwid8;
	private String bsxmwid9;
	private String bsxmwid10;
	private String bsxmwid11;
	private String bsxmwid12;
	private String bsxmwid13;
	private String state; // 手动添加 非持续化
	private String shzt; // 手动添加 非持续化
	private String dbd; // 手动添加 非持续化
	private String xb; // 手动添加 非持续化
	private String xxmmc1;// 手动添加 非持续化
	private String xxmmc2;// 手动添加 非持续化
	private String xxmmc3;// 手动添加 非持续化
	private String xxmmc4;// 手动添加 非持续化
	private String xxmmc5;// 手动添加 非持续化
	private String xxmmc6;// 手动添加 非持续化
	private String xxmmc7;// 手动添加 非持续化
	private String xxmmc8;// 手动添加 非持续化
	private String xxmmc9;// 手动添加 非持续化
	private String xxmmc10;// 手动添加 非持续化
	private String xxmmc11;// 手动添加 非持续化
	private String xxmmc12;// 手动添加 非持续化
	private String xxmmc13;// 手动添加 非持续化
	private String xxmmc;// 手动添加 非持续化
	private String zb;
	private String zbbm;// 手动添加 非持续化
	private String xbz;// 手动添加 非持续化
	private String xbbm;// 手动添加 非持续化
	private String zch;// 手动添加 非持续化
	private String selectedinfo;// 手动添加 非持续化
	private String zb_cn;// 手动添加 非持续化
	private String st;// 手动添加 非持续化
	private String shzt2;// 手动添加 非持续化
	private String awid;// 手动添加 非持续化
	private String isEdit;//手动添加 非持续化 ----是否可编辑（保存模式）
	// Constructors

	public TSportYdybmxmCc(String wid, String dxmmc, String ydywid, String zczh, String xm, String sfzh,
			String bsxmwid1, String bsxmwid2, String bsxmwid3, String bsxmwid4, String bsxmwid5, String bsxmwid6,
			String bsxmwid7, String bsxmwid8, String bsxmwid9) {
		super();
		this.wid = wid;
		this.dxmmc = dxmmc;
		this.ydywid = ydywid;
		this.zczh = zczh;
		this.xm = xm;
		this.sfzh = sfzh;
		this.bsxmwid1 = bsxmwid1;
		this.bsxmwid2 = bsxmwid2;
		this.bsxmwid3 = bsxmwid3;
		this.bsxmwid4 = bsxmwid4;
		this.bsxmwid5 = bsxmwid5;
		this.bsxmwid6 = bsxmwid6;
		this.bsxmwid7 = bsxmwid7;
		this.bsxmwid8 = bsxmwid8;
		this.bsxmwid9 = bsxmwid9;
	}

	public TSportYdybmxmCc() {
		super();
	}

	// SportYdybmxmCcServiceImpl中的list使用
	public TSportYdybmxmCc(String dxmmc, String xm, String zczh, String sfzh, String ydywid, String xb, String dbd,
			String state, String shzt, String xxmmc1, String bsxmwid1, String xxmmc2, String bsxmwid2, String xxmmc3,
			String bsxmwid3, String xxmmc4, String bsxmwid4, String xxmmc5, String bsxmwid5, String xxmmc6,
			String bsxmwid6, String xxmmc7, String bsxmwid7, String xxmmc8, String bsxmwid8, String xxmmc9,
			String bsxmwid9,String xxmmc,String zb,String xbz) {
		this.dxmmc = dxmmc;
		this.xm = xm;
		this.zczh = zczh;
		this.sfzh = sfzh;
		this.ydywid = ydywid;
		this.xb = xb;
		this.dbd = dbd;
		this.state = state;
		this.shzt = shzt;
		this.xxmmc1 = xxmmc1;
		this.bsxmwid1 = bsxmwid1;
		this.xxmmc2 = xxmmc2;
		this.bsxmwid2 = bsxmwid2;
		this.xxmmc3 = xxmmc3;
		this.bsxmwid3 = bsxmwid3;
		this.xxmmc4 = xxmmc4;
		this.bsxmwid4 = bsxmwid4;
		this.xxmmc5 = xxmmc5;
		this.bsxmwid5 = bsxmwid5;
		this.xxmmc6 = xxmmc6;
		this.bsxmwid6 = bsxmwid6;
		this.xxmmc7 = xxmmc7;
		this.bsxmwid7 = bsxmwid7;
		this.xxmmc8 = xxmmc8;
		this.bsxmwid8 = bsxmwid8;
		this.xxmmc9 = xxmmc9;
		this.bsxmwid9 = bsxmwid9;
		this.xxmmc =xxmmc;
		this.zb = zb;
		this.xbz = xbz;
	}

	// Property accessors

	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	public String getDxmmc() {
		return this.dxmmc;
	}

	public void setDxmmc(String dxmmc) {
		this.dxmmc = dxmmc;
	}

	public String getYdywid() {
		return this.ydywid;
	}

	public void setYdywid(String ydywid) {
		this.ydywid = ydywid;
	}

	public String getZczh() {
		return this.zczh;
	}

	public void setZczh(String zczh) {
		this.zczh = zczh;
	}

	public String getXm() {
		return this.xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	public String getSfzh() {
		return this.sfzh;
	}

	public void setSfzh(String sfzh) {
		this.sfzh = sfzh;
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

	public String getDbd() {
		return dbd;
	}

	public void setDbd(String dbd) {
		this.dbd = dbd;
	}

	public String getXb() {
		return xb;
	}

	public void setXb(String xb) {
		this.xb = xb;
	}

	public String getBsxmwid1() {
		return bsxmwid1;
	}

	public void setBsxmwid1(String bsxmwid1) {
		this.bsxmwid1 = bsxmwid1;
	}

	public String getBsxmwid2() {
		return bsxmwid2;
	}

	public void setBsxmwid2(String bsxmwid2) {
		this.bsxmwid2 = bsxmwid2;
	}

	public String getBsxmwid3() {
		return bsxmwid3;
	}

	public void setBsxmwid3(String bsxmwid3) {
		this.bsxmwid3 = bsxmwid3;
	}

	public String getBsxmwid4() {
		return bsxmwid4;
	}

	public void setBsxmwid4(String bsxmwid4) {
		this.bsxmwid4 = bsxmwid4;
	}

	public String getBsxmwid5() {
		return bsxmwid5;
	}

	public void setBsxmwid5(String bsxmwid5) {
		this.bsxmwid5 = bsxmwid5;
	}

	public String getBsxmwid6() {
		return bsxmwid6;
	}

	public void setBsxmwid6(String bsxmwid6) {
		this.bsxmwid6 = bsxmwid6;
	}

	public String getBsxmwid7() {
		return bsxmwid7;
	}

	public void setBsxmwid7(String bsxmwid7) {
		this.bsxmwid7 = bsxmwid7;
	}

	public String getBsxmwid8() {
		return bsxmwid8;
	}

	public void setBsxmwid8(String bsxmwid8) {
		this.bsxmwid8 = bsxmwid8;
	}

	public String getBsxmwid9() {
		return bsxmwid9;
	}

	public void setBsxmwid9(String bsxmwid9) {
		this.bsxmwid9 = bsxmwid9;
	}

	public String getXxmmc1() {
		return xxmmc1;
	}

	public void setXxmmc1(String xxmmc1) {
		this.xxmmc1 = xxmmc1;
	}

	public String getXxmmc2() {
		return xxmmc2;
	}

	public void setXxmmc2(String xxmmc2) {
		this.xxmmc2 = xxmmc2;
	}

	public String getXxmmc3() {
		return xxmmc3;
	}

	public void setXxmmc3(String xxmmc3) {
		this.xxmmc3 = xxmmc3;
	}

	public String getXxmmc4() {
		return xxmmc4;
	}

	public void setXxmmc4(String xxmmc4) {
		this.xxmmc4 = xxmmc4;
	}

	public String getXxmmc5() {
		return xxmmc5;
	}

	public void setXxmmc5(String xxmmc5) {
		this.xxmmc5 = xxmmc5;
	}

	public String getXxmmc6() {
		return xxmmc6;
	}

	public void setXxmmc6(String xxmmc6) {
		this.xxmmc6 = xxmmc6;
	}

	public String getXxmmc7() {
		return xxmmc7;
	}

	public void setXxmmc7(String xxmmc7) {
		this.xxmmc7 = xxmmc7;
	}

	public String getXxmmc8() {
		return xxmmc8;
	}

	public void setXxmmc8(String xxmmc8) {
		this.xxmmc8 = xxmmc8;
	}

	public String getXxmmc9() {
		return xxmmc9;
	}

	public void setXxmmc9(String xxmmc9) {
		this.xxmmc9 = xxmmc9;
	}

	public String getXxmmc() {
		return xxmmc;
	}

	public void setXxmmc(String xxmmc) {
		this.xxmmc = xxmmc;
	}

	public String getZb() {
		return zb;
	}

	public void setZb(String zb) {
		this.zb = zb;
	}

	public String getXbz() {
		return xbz;
	}

	public void setXbz(String xbz) {
		this.xbz = xbz;
	}

	public String getBsxmwid10() {
		return bsxmwid10;
	}

	public void setBsxmwid10(String bsxmwid10) {
		this.bsxmwid10 = bsxmwid10;
	}

	public String getBsxmwid11() {
		return bsxmwid11;
	}

	public void setBsxmwid11(String bsxmwid11) {
		this.bsxmwid11 = bsxmwid11;
	}

	public String getBsxmwid12() {
		return bsxmwid12;
	}

	public void setBsxmwid12(String bsxmwid12) {
		this.bsxmwid12 = bsxmwid12;
	}

	public String getBsxmwid13() {
		return bsxmwid13;
	}

	public void setBsxmwid13(String bsxmwid13) {
		this.bsxmwid13 = bsxmwid13;
	}

	public String getXxmmc10() {
		return xxmmc10;
	}

	public void setXxmmc10(String xxmmc10) {
		this.xxmmc10 = xxmmc10;
	}

	public String getXxmmc11() {
		return xxmmc11;
	}

	public void setXxmmc11(String xxmmc11) {
		this.xxmmc11 = xxmmc11;
	}

	public String getXxmmc12() {
		return xxmmc12;
	}

	public void setXxmmc12(String xxmmc12) {
		this.xxmmc12 = xxmmc12;
	}

	public String getXxmmc13() {
		return xxmmc13;
	}

	public void setXxmmc13(String xxmmc13) {
		this.xxmmc13 = xxmmc13;
	}

	public String getZbbm() {
		return zbbm;
	}

	public void setZbbm(String zbbm) {
		this.zbbm = zbbm;
	}

	public String getXbbm() {
		return xbbm;
	}

	public void setXbbm(String xbbm) {
		this.xbbm = xbbm;
	}

	public String getZch() {
		return zch;
	}

	public void setZch(String zch) {
		this.zch = zch;
	}

	public String getSelectedinfo() {
		return selectedinfo;
	}

	public void setSelectedinfo(String selectedinfo) {
		this.selectedinfo = selectedinfo;
	}

	public String getZb_cn() {
		return zb_cn;
	}

	public void setZb_cn(String zbCn) {
		zb_cn = zbCn;
	}

	public String getSt() {
		return st;
	}

	public void setSt(String st) {
		this.st = st;
	}

	public String getShzt2() {
		return shzt2;
	}

	public void setShzt2(String shzt2) {
		this.shzt2 = shzt2;
	}

	public String getAwid() {
		return awid;
	}

	public void setAwid(String awid) {
		this.awid = awid;
	}

	public String getIsEdit() {
		return isEdit;
	}

	public void setIsEdit(String isEdit) {
		this.isEdit = isEdit;
	}

}