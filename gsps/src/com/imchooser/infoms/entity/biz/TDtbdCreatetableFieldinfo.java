package com.imchooser.infoms.entity.biz;
/**
 * 表实体T_dtbd_CretaeTable_FieldInfo
 * @author zhuzhonglei
 *
 */
public class TDtbdCreatetableFieldinfo {
	private String wid;
	private String createTableID;//(外键)T_dtbd_CretaeTable主键ID
	private String fieldName;//字段名称
	private String fieldChineseName;//字段中文名
	private String fieldType;//字段类型(0:字符型;1:数字型;)
	private String fieldForm;//字段格式
	private String isNull;//是否为空(0:不允许;1:允许)
	private String fieldLength;//字段长度
	private String fieldDefine;//默认值
	private String isFieldEnter;//录入字段是否激活;(0:未激活;1:激活;)
	private String isMustIn;//是否必填字段;(0:不必填;1:必填;)
	private String fieldEnterOrder;//录入字段顺序
	private String fieldDisplayName;//字段显示名/浏览名
	private String isFieldDisplay;//字段是否显示;(0:不显示;1:显示)
	private String fieldWidth;//字段显示占得宽度px
	private String fieldOrder;//字段显示顺序
	private String isFieldQuery;//字段是否可以查询(0:不可查询;1:可查询;)
	private String isStatistics;//统计字段(1:统计)
	private String remarks;//备注
	private String view_data; // 手工添加 非持久化
	private String depttype;//权限类型;存放不同权限的浏览页面,在Action中获得
	private String isSum;//统计总额,只针对数值列;(0:不统计;1:统计)
	private String isAvg;//统计平均额;(0:不统计;1:统计)
	private String fzzd;//分组字段;(0:不是分组字段;1:是分组字段)
	private String fieldsum; //求和对应字段
	private String fieldavg; //求平均对应字段
	private String fieldtj;//求统计对应字段
	
	public String getFieldtj() {
		return fieldtj;
	}

	public void setFieldtj(String fieldtj) {
		this.fieldtj = fieldtj;
	}

	public TDtbdCreatetableFieldinfo() {
		super();
	}
	
	public TDtbdCreatetableFieldinfo(String wid, String createTableID, String fieldName, String fieldChineseName,
			String fieldType, String fieldForm, String isNull, String fieldLength, String fieldDefine,
			String isFieldEnter, String isMustIn, String fieldEnterOrder, String fieldDisplayName,
			String isFieldDisplay, String fieldWidth, String fieldOrder, String isFieldQuery, String isStatistics,
			String remarks, String viewData, String depttype, String isSum, String isAvg, String fzzd, String fieldsum,
			String fieldavg) {
		super();
		this.wid = wid;
		this.createTableID = createTableID;
		this.fieldName = fieldName;
		this.fieldChineseName = fieldChineseName;
		this.fieldType = fieldType;
		this.fieldForm = fieldForm;
		this.isNull = isNull;
		this.fieldLength = fieldLength;
		this.fieldDefine = fieldDefine;
		this.isFieldEnter = isFieldEnter;
		this.isMustIn = isMustIn;
		this.fieldEnterOrder = fieldEnterOrder;
		this.fieldDisplayName = fieldDisplayName;
		this.isFieldDisplay = isFieldDisplay;
		this.fieldWidth = fieldWidth;
		this.fieldOrder = fieldOrder;
		this.isFieldQuery = isFieldQuery;
		this.isStatistics = isStatistics;
		this.remarks = remarks;
		view_data = viewData;
		this.depttype = depttype;
		this.isSum =isSum;
		this.isAvg = isAvg;
		this.fzzd = fzzd;
		this.fieldsum = fieldsum;
		this.fieldavg = fieldavg;
	}

	public String getWid() {
		return wid;
	}
	public void setWid(String wid) {
		this.wid = wid;
	}
	public String getCreateTableID() {
		return createTableID;
	}
	public void setCreateTableID(String createTableID) {
		this.createTableID = createTableID;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getFieldChineseName() {
		return fieldChineseName;
	}
	public void setFieldChineseName(String fieldChineseName) {
		this.fieldChineseName = fieldChineseName;
	}
	public String getFieldType() {
		return fieldType;
	}
	public void setFieldType(String fieldType) {
		this.fieldType = fieldType;
	}
	public String getFieldForm() {
		return fieldForm;
	}
	public void setFieldForm(String fieldForm) {
		this.fieldForm = fieldForm;
	}
	public String getFieldLength() {
		return fieldLength;
	}
	public void setFieldLength(String fieldLength) {
		this.fieldLength = fieldLength;
	}
	public String getFieldDefine() {
		return fieldDefine;
	}
	public void setFieldDefine(String fieldDefine) {
		this.fieldDefine = fieldDefine;
	}
	public String getIsFieldEnter() {
		return isFieldEnter;
	}
	public void setIsFieldEnter(String isFieldEnter) {
		this.isFieldEnter = isFieldEnter;
	}
	public String getIsMustIn() {
		return isMustIn;
	}
	public void setIsMustIn(String isMustIn) {
		this.isMustIn = isMustIn;
	}
	
	public String getFieldEnterOrder() {
		return fieldEnterOrder;
	}
	public void setFieldEnterOrder(String fieldEnterOrder) {
		this.fieldEnterOrder = fieldEnterOrder;
	}
	public String getFieldDisplayName() {
		return fieldDisplayName;
	}
	public void setFieldDisplayName(String fieldDisplayName) {
		this.fieldDisplayName = fieldDisplayName;
	}
	public String getIsFieldDisplay() {
		return isFieldDisplay;
	}
	public void setIsFieldDisplay(String isFieldDisplay) {
		this.isFieldDisplay = isFieldDisplay;
	}
	public String getFieldWidth() {
		return fieldWidth;
	}
	public void setFieldWidth(String fieldWidth) {
		this.fieldWidth = fieldWidth;
	}
	public String getFieldOrder() {
		return fieldOrder;
	}
	public void setFieldOrder(String fieldOrder) {
		this.fieldOrder = fieldOrder;
	}
	public String getIsFieldQuery() {
		return isFieldQuery;
	}
	public void setIsFieldQuery(String isFieldQuery) {
		this.isFieldQuery = isFieldQuery;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getIsNull() {
		return isNull;
	}
	public void setIsNull(String isNull) {
		this.isNull = isNull;
	}
	public String getIsStatistics() {
		return isStatistics;
	}
	public void setIsStatistics(String isStatistics) {
		this.isStatistics = isStatistics;
	}
	public String getView_data() {
		return view_data;
	}
	public void setView_data(String viewData) {
		view_data = viewData;
	}
	public String getDepttype() {
		return depttype;
	}
	public void setDepttype(String depttype) {
		this.depttype = depttype;
	}

	public String getIsSum() {
		return isSum;
	}

	public void setIsSum(String isSum) {
		this.isSum = isSum;
	}

	public String getIsAvg() {
		return isAvg;
	}

	public void setIsAvg(String isAvg) {
		this.isAvg = isAvg;
	}

	public String getFzzd() {
		return fzzd;
	}
	public void setFzzd(String fzzd) {
		this.fzzd = fzzd;
	}
	public String getFieldsum() {
		return fieldsum;
	}
	public void setFieldsum(String fieldsum) {
		this.fieldsum = fieldsum;
	}
	public String getFieldavg() {
		return fieldavg;
	}
	public void setFieldavg(String fieldavg) {
		this.fieldavg = fieldavg;
	}	
	
}
