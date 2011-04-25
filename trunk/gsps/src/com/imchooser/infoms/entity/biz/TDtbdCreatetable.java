package com.imchooser.infoms.entity.biz;

/**
 * 表T_dtbd_CretaeTable实体类
 * 
 * @author zhuzhonglei
 */
public class TDtbdCreatetable {
	private String wid;
	private String createUser;// 创建人
	private String createTime;// 创建时间
	private String tableName;// 数据表名称
	private String chineseName;// 数据表别名称
	private String createSQL;// 建表SQL(用于保存建表SQL便于日后维护)
	private String remarks;// 备注
	private String menuid;// 菜单ID
	private String sbgz;// 上报规则，存放上报权限类型的值
	private String sftjts;// 统计条数。(0:不同计;1:统计)
	private String xzlx;// 新增类型 字典表dtbd_xzlx
	private String hzlx;// 汇总类型 字典表dtbd_hzlx

	public TDtbdCreatetable() {
		super();
	}

	public TDtbdCreatetable(String wid, String createUser, String createTime, String tableName, String chineseName,
			String createSQL, String remarks, String menuid, String sbgz, String sftjts, String xzlx, String hzlx) {
		super();
		this.wid = wid;
		this.createUser = createUser;
		this.createTime = createTime;
		this.tableName = tableName;
		this.chineseName = chineseName;
		this.createSQL = createSQL;
		this.remarks = remarks;
		this.menuid = menuid;
		this.sbgz = sbgz;
		this.sftjts = sftjts;
		this.xzlx = xzlx;
		this.hzlx = hzlx;
	}

	public String getWid() {
		return wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getChineseName() {
		return chineseName;
	}

	public void setChineseName(String chineseName) {
		this.chineseName = chineseName;
	}

	public String getCreateSQL() {
		return createSQL;
	}

	public void setCreateSQL(String createSQL) {
		this.createSQL = createSQL;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getMenuid() {
		return menuid;
	}

	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}

	public String getSbgz() {
		return sbgz;
	}

	public void setSbgz(String sbgz) {
		this.sbgz = sbgz;
	}

	public String getSftjts() {
		return sftjts;
	}

	public void setSftjts(String sftjts) {
		this.sftjts = sftjts;
	}

	public String getXzlx() {
		return xzlx;
	}

	public void setXzlx(String xzlx) {
		this.xzlx = xzlx;
	}

	public String getHzlx() {
		return hzlx;
	}

	public void setHzlx(String hzlx) {
		this.hzlx = hzlx;
	}

}
