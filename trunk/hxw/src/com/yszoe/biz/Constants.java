package com.yszoe.biz;

import com.yszoe.identity.IdConstants;

public interface Constants {

	long FILE_SIZE_1M = 1048576;// 1M = 1048576 byte

	String FILE_SIZE_PHOTO = "MaxPhotoSize";// 系统参数设置照片的大小

	String MESSAGE_FILE_SIZE = "MessageFileMaxSize"; // 系统参数设置消息发送 附件大小

	String SESSION_USER_FLAG = IdConstants.SESSION_USER;

	String IMPORT_XLS_TEMP_TABLE_NAME = "XLS_IMPORT";// 导入excel数据时用于临时存数据的表的表名

	String PROD_CHECK_DKSQB = "procd.checkExcelData";// 数据上传后，处理验证数据的存储过程

	String PROD_IMPORT_DKSQB = "procd.importExcelData";// 数据上传后，处理导入的存储过程

	int DEPART_CODE_STEP = 3;// departid几位表示一级？

	// 执行成功返回码
	String MESSAGE_RETURN_SUCCESS_CODE = "1";

	// 执行失败返回码
	String MESSAGE_RETURN_FAILURE_CODE = "0";

	String MESSAGE_INIT_FAILURE = "初始化数据失败";

	String MESSAGE_SAVE_SUCCESS = "保存成功";

	String MESSAGE_SAVE_FAILURE = "保存失败";

	String MESSAGE_OPERATE_FAILURE = "操作失败";

	String MESSAGE_REMOVE_SUCCESS = "删除完毕";

	String MESSAGE_INPUT_NULL = "数据对象为空";

	String MESSAGE_LOAD_FAILURE = "数据加载失败";

	String MESSAGE_QUERY_FAILURE = "数据查询失败";

	String MESSAGE_FHZF_YHDL = "另一用户已使用此账号登录"; // AjaxServiceImpl调用存储过程的方法使用

	String MESSAGE_INVALID_PARAMETERS = "参数无效！"; // AjaxServiceImpl调用存储过程的方法使用

	String MESSAGE_STATE_UNREAD = "0";

	String MESSAGE_STATE_READ = "1";

	String INIT_USER_PASSWORD = "88888888";

	String TJZHZDS = "TJZHZDS";// 默认的同级（同一部门）账户最大数

	/**
	 * 用户操作日志类型
	 */
	int LOG_ACTION_SAVE = 1; // 保存

	int LOG_ACTION_UPDATE = 2; // 更新

	int LOG_ACTION_DEL = 3; // 删除

	/**
	 * 登录用户（部门）类型
	 */
	String DEPARTTYPE_ADMIN = "0"; // 管理员
	String DEPARTTYPE_COMPANY = "1"; // 公司
	String DEPARTTYPE_FARM = "2"; // 种畜禽场
	String DEPARTTYPE_AREA = "3"; // 区县

	/**
	 * 审核状态
	 */
	String SHZT_CG = "0"; // 草稿
	String SHZT_YSB = "1"; // 待审核
	String SHZT_SH = "2"; // 审核
	String SHZT_TH = "-2"; // 退回

	/**
	 * 刷新内存 类型
	 */
	String REFRESH_DTBD = "dtbd"; // 动态表单
	String REFRESH_PROP = "prop"; // 系统参数
	String REFRESH_ALL = "all"; // 全部

	/**
	 * 添加专家 用户信息表相应数据值
	 */
	String USERDEPART = "110";// 直属部门
	String EXPERTTEAM = "20110614151332765113";// 专家组WID
	String EXPERTSTATE = "2";// 专家用户默认状态

	/**
	 * 种畜禽场用户申请会员信息表相应数据值
	 */
	String ZXQCTEAM = "20110507165715219161";// 种畜禽组WID
	String GSTEAM = "20110622171143093151";// 公司领导组WID
	String ZXQCSTATE = "0";// 种畜禽用户默认状态：禁用
	
	
	/**
	 * DHI平台奶牛场组相应数据值
	 */
	String TSYSBUSERTEAM = "AutoMake03";// DHI平台奶牛场组ID

	/**
	 * 数据字段为奶牛相应数据值
	 */
	String DHIXZ = "02";// 数据字段为奶牛相应数据值
	String GBSXZ = "01";// 数据字段为奶牛相应数据值

	/**
	 * 报送周期
	 */
	String BSZQ_YF = "1"; // 月份
	String BSZQ_JD = "2"; // 季度
	String BSZQ_BN = "3"; // 半年
	String BSZQ_NF = "4"; // 年份

	/**
	 * 统计规则
	 */
	String TJGZ_QH = "1"; // 求和
	String TJGZ_QPJ = "2"; // 求平均

	/**
	 * 树机构类型
	 */
	String TREETYPE_CODE_PZPX = "4"; // 畜种品种品系树

	/**
	 * 监测任务填报时间过期后是否允许填报
	 */
	String SFYXTB_YX = "1"; // 允许
	String SFYXTB_JZ = "0"; // 禁止
}
