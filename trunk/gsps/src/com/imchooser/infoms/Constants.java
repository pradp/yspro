package com.imchooser.infoms;

import com.imchooser.framework.identity.IdConstants;
import com.imchooser.infoms.servlets.SysInitAutoLoad;

public interface Constants {

	long FILE_SIZE_1M = 1048576;// 1M = 1048576 byte
	
	String AREAID_ZBF = "320001";// 第一个代表团的编码
	
	String AREAID_ZBF_NAME = "南京"; // 第一个代表团的编码对于名称
	
	String FILE_SIZE_PHOTO = "MaxPhotoSize";// 系统参数设置照片的大小

	String MESSAGE_FILE_SIZE = "MessageFileMaxSize"; // 系统参数设置消息发送 附件大小

	String SESSION_USER_FLAG = IdConstants.SESSION_USER;

	String USER_TYPE_BIZ_DIRECTOR = IdConstants.USER_TYPE_BIZ_DIRECTOR;// 业务主管(登录用户类型)

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

	String DEPART_GX_JUNDU = SysInitAutoLoad.PROVINCE_CODE + "0002405";// 高校，测试账号部门号

	String DEPART_SX_JUNDU = SysInitAutoLoad.PROVINCE_CODE + "0001999";// 市县，测试账号部门号

	String QXTJYHZDS = "QXTJYHZDS";// 区县添加同级用户最大数

	String TJZHZDS = "TJZHZDS";// 默认的同级（同一部门）账户最大数

	int MAX_SQJE = 6000;// 最大申请金额(生源地贷款)

	/************************* 标准维护 *****************************/
	String SYSCODE_ZJLX = "zjlx";// 证件类型
	String SYSCODE_SHZT = "shzt";// 审核状态
	String SYSCODE_CLZT = "clzt";// 处理状态
	
	String SYSCODE_XXLY_SZXQFTZ = "100";// 省中心群发通知
	String SYSCODE_XXLY_HYJLXX = "097";// 用户交流消息
	String SYSCODE_XXLY_GXSBXX = "098";// 高校申报消息
	String SYSCODE_XXLY_SXSBXX = "099";// 市县申报消息
	String SYSCODE_XXLY_QFXSXX = "050";// 群发学生消息
	String SYSCODE_XXLY_ZDXSXX = "051";// 指定学生消息

	/************************* 系统参数定义 *****************************/
	String SYS_PROPERTY_GZZZSBND = "gzzzsbnd";// 高中资助申报年度

	int LOG_ACTION_SAVE = 1; // 用户操作日志类型:保存

	int LOG_ACTION_UPDATE = 2; // 用户操作日志类型:更新

	int LOG_ACTION_DEL = 3; // 用户操作日志类型:删除

	int LOG_ACTION_CANCEL = 4; // 用户操作日志类型:取消成绩

	int LOG_ACTION_RECOVER = 5; // 用户操作日志类型:恢复成绩

	int LOG_ACTION_APPROVE = 6; // 用户操作日志类型:审核
	
	int LOG_ACTION_PUBLISH = 7; // 用户操作日志类型:发布
	
	int LOG_ACTION_CANCEL_PUBLISH = 8; // 用户操作日志类型:撤销发布


	/**
	 * 资助类型
	 */
	String ZZLX_GX_GJJXJ = "1"; // 高校国家奖学金
	String ZZLX_GX_LZJXJ = "2"; // 高校励志奖学金
	String ZZLX_GX_GJZXJ = "3"; // 高校国家助学金
	String ZZLX_SX_SYDDK = "4"; // 市县生源地贷款
	String ZZLX_GX_SYDDK = "5"; // 高校生源地贷款
	String ZZLX_ZX_GZZXJ = "6"; // 高中助学金贷款

	/**
	 * 用户操作日志:操作对象
	 */
	String CZDX_T_CODE_DEPART = "TCodeDepart"; // 部门字典
	String CZDX_T_SYS_CODE = "TSysCode"; // 系统字典
	String CZDX_T_SYS_CODESORT = "TSysCodeSort"; // 系统字典类别
	String CZDX_T_SYS_DEPART = "TSysDepart"; // 系统部门
	String CZDX_T_SYS_AREA = "TSysArea"; // 系统区域
	String CZDX_T_SYS_MESSAGE = "TSysMessage"; // 系统消息
	String CZDX_T_SYS_PROPERTITY = "TSysPropertity"; // 系统参数
	String CZDX_T_SYS_USER = "TSysUser"; // 系统用户
	String CZDX_T_SPORT_YDYXX = "TSportYdyxx"; ////运动员信息
	String CZDX_T_SPORT_CJ_YDY = "TSportCjYdy"; //运动员成绩登记、审核、发布维护
	String CZDX_T_SPORT_TD_SX_JJf = "TsportTdHzCjJjf"; //地区汇总成绩加减分	
	String CZDX_T_SYS_BUTTON_RULE = "TSysButtonRule"; // 模块功能开放规则表
	String CZDX_T_SPORT_SSRC = "TSportSsrc"; //赛程维护
	String CZDX_T_SPORT_BSXM = "TSportBsxm"; //比赛项目维护
	String CZDX_T_SPORT_SCDFGZ = "TSportScdfgz"; //赛程得分规则维护
	String CZDX_T_SPORT_YDYBMXM = "TSportYdybmxm"; //运动员二次报名
	String CZDX_T_SPORT_YDYBMXM_CC = "TSportYdybmxmCc"; //运动员一次报名

	/**
	 * 登录用户（部门）类型
	 */
	String DEPARTTYPE_ADMIN = "1"; // 管理员
	String DEPARTTYPE_GXADMIN = "3"; // 高校管理员
	String DEPARTTYPE_QXADMIN = "3"; // 区县管理员
	String DEPARTTYPE_SX = "7"; // 市县教育局
	String DEPARTTYPE_GX = "6"; // 高校
	String DEPARTTYPE_ZX = "8"; // 中学
	String DEPARTTYPE_YX = "9"; // 院系

	/**
	 * 部门是否省内
	 */
	String SFSN_SN = "1";// 省内
	String SFSN_SW = "0";// 省外

	/**
	 * 就业拨付信息中的变更与否的判断
	 */
	String JYBF_SFBG_S = "是";
	String JYBF_SFBG_F = "否";

	// 判断今年是否已登记
	String SFDY_S = "exsit";
	// 国家奖学金模块 :判断今年是否登记过励志奖学金
	String SFDJ_LZJXJ_S = "lz_exsit";
	// 励志奖学金模块 :判断今年是否登记过国家奖学金
	String SFDJ_GJJXJ_S = "gj_exsit";

	/*
	 * 校验身份(业务主管)
	 */
	String JYSF_FZG = "0"; // 非业务主管
	String JYSF_ZG = "1"; // 业务主管
	String JYSF_BCZ = "2"; // 账号不存在
	String JYSF_MMCW = "3"; // 密码错误
	/*
	 * 高中助学金审核状态
	 */
	String SHZT_GZZXJ_WTJSH = "01"; // 未提交审核
	String SHZT_GZZXJ_DSXSH = "2"; // 待市县审核
	String SHZT_GZZXJ_SXTH = "-4"; // 市县退回
	String SHZT_GZZXJ_SXTG = "4"; // 市县审核通过
	String SHZT_GZZXJ_DSZXSH = "7"; // 待省中心审核
	String SHZT_GZZXJ_SHTG = "9"; // 审核通过
	String SHZT_GZZXJ_SZXTH = "-9"; // 省中心退回

	/*
	 * 贫困生库
	 */
	String SYSCODE_PKSK_SHZT = "shzt_pks";// 贫困生库审核状态
	String SHZT_PKSK_CG = "0";// 贫困生库中的审核状态 0:草稿
	String SHZT_PKSK_DS = "1";// 贫困生库中的审核状态 0:待审
	String SHZT_PKSK_ZZ = "2";// 贫困生库中的审核状态 0:正式
	String SHZT_PKSK_TH = "3";// 贫困生库中的审核状态 0:退回

	String PKS_SHZTCW = "1";// 审核状态错误
	String PKS_SBSHCG = "2";// 上报高校审核成功
	String PKS_GXCCBL = "3";// 超出比列
	String PKS_SHZT_TGXX = "已审核通过！"; // 贫困生审核通过信息
	String PKS_SHZT_THXX = "已审核退回！";// 贫困生审核退回信息
	String PKS_SFZHM_T = "FALSE";// 贫困生库已存在该身份证号码

	int PKS_CZLXLOG_XZ = 1;// 1新增；2提升困难等级；3降低困难登记；4修改数据（未变档）；5撤销
	int PKS_CZLXLOG_TS = 2;
	int PKS_CZLXLOG_JD = 3;
	int PKS_CZLXLOG_XG = 4;
	int PKS_CZLXLOG_CX = 5;

	String PKS_ZZMK_GJJXJ = "1";// 国家奖学金
	String PKS_ZZMK_SYDDK = "4";// 生源地贷款
	String PKS_ZZMK_LZJXJ = "2";// 励志奖学金
	String PKS_ZZMK_GJZXJ = "3";// 国家助学金

	/**
	 * 审核状态
	 */
	String SHZT_WKS = "0"; // 未开始
	String SHZT_CG = "1"; // 草稿
	String SHZT_DSXSH = "2"; // 待市县审核
	String SHZT_DGXSH = "3"; // 待高校审核
	String SHZT_SXSHTG = "4"; // 市县审核通过
	String SHZT_GXSHTG = "5"; // 高校审核通过
	String SHZT_SXSHTH = "-4"; // 市县审核退回
	String SHZT_GXSHTH = "-5"; // 高校审核退回
	String SHZT_SXDSZXSH = "7"; // 市县待省中心审核
	String SHZT_GXDSZXSH = "8"; // 高校待省中心审核
	String SHZT_SHTG = "9"; // 审核通过
	String SHZT_SZXTH = "-9"; // 省中心退回

	/**
	 * 模块功能开放时间控制，按钮类型
	 * 注意：变化新的功能类型，需要同步BaseActionAbstractSupport里的getButtonList()方法里的数据。
	 */
	String BUTTON_TYPE_ADD = "1";// 新增
	String BUTTON_TYPE_MODIFY = "2";// 修改
	String BUTTON_TYPE_DEL = "3";// 删除
	String BUTTON_TYPE_SAVE = "4";// 保存
	String BUTTON_TYPE_EXPORT = "5";// 导出
	String BUTTON_TYPE_PRINT = "6";// 打印
	String BUTTON_TYPE_HANDOVER = "7";// 上报
	String BUTTON_TYPE_APPROVE = "8";// 审批

	/**
	 * 模块功能开放时间控制，控制规则类型
	 */
	int BUTTON_RULE_EACH_DAY = 1;// 每天
	int BUTTON_RULE_EACH_MONTH = 2;// 每月
	int BUTTON_RULE_EACH_YEAR = 3;// 每年

	/**
	 * 审核类型
	 */
	String SHLX_SB = "1"; // 提交到上级部门
	String SHLX_TG = "2"; // 审核通过
	String SHLX_TH = "3"; // 审核退回

	/**
	 * 消息类型
	 */
	String MESSAGE_LX_FS = "1"; // 发送
	String MESSAGE_LX_JS = "2"; // 接受

	/**
	 * 确认状态 农信社发放核对模块
	 */
	String QRZT_WHD = "0"; // 未核对
	String QRZT_TG = "1"; // 核对通过
	String QRZT_YW = "-1"; // 核对有误
	String QRZT_QBDC = "2"; // 全部导出
	String QRZT_YWDC = "-2"; // 有误数据导出

	/**
	 * 高校类型 江苏 高校资助工作汇总模块
	 */
	String GXLX_PTGB = "1"; // 普通(公办)
	String GXLX_CRPTJH = "2"; // 成人(普通计划)
	String GXLX_DLEJXY = "3"; // 独立(二级)学院
	String GXLX_PTMB = "4"; // 普通(民办)
	String GXLX_PTZWHZ = "5"; // 普通(中外合作)

	/**
	 * 信息审批状态 代偿模块
	 */
	String XXSPZT_CG = "0"; // 草稿
	String XXSPZT_SZXTH = "2"; // 省中心退回
	String XXSPZT_DSZXSH = "3"; // 待省中心审核
	String XXSPZT_SHTG = "4"; // 审核通过
	String XXSPZT_YRWDJ = "5"; // 已入伍登记
	String XXSPZT_BFZ = "6"; // 拨付中
	String XXSPZT_BFW = "7"; // 拨付完

	/**
	 * 系统消息模块 发送状态
	 */
	String FSZT_YFS = "1"; // 已发送
	String FSZT_CG = "0"; // 未发送,草稿

	/**
	 * 公共通信平台 黑名单和敏感词 是否为全局
	 */
	String ISGLOBAL_TRUE = "1"; // 是全局
	String ISGLOBAL_FALSE = "0"; // 不是全局

	String UNISMS_BIZ_SYSTEM_PSEUDOCODE = "jundu";// 公共通讯平台接入授权码的伪码
	String UNISMS_MY_ID = "MyUniSMSID"; // 公共通讯平台接入ID

	String YWJY_DQLX_RC = "1";// 义务教育 地区类型 农村
	String YWJY_DQLX_CS = "2";// 义务教育 地区类型 城市
	String YWJY_XXLX_MB = "1";// 义务教育 学校类型 民办
	String YWJY_XXLX_XJ = "2";// 义务教育 学校类型 小计

	String YWJY_SHZT_WTJSH = "01"; // 未提交审核
	String YWJY_SHZT_DSH = "02"; // 待审核
	String YWJY_SHZT_SHTG = "03"; // 审核通过
	String YWJY_SHZT_SHWTG = "04"; // 审核未通过

	/**
	 * 贷款数据核对
	 */
	String HDZT_ZQSJ = "1"; // 账号及院系无冲突
	String HDZT_WDK = "2"; // 未贷款
	String HDZT_WFF = "3"; // 未发放
	String HDZT_WSQ = "4"; // 未申请
	String HDZT_YXYW = "5"; // 院校冲突
	String HDZT_ZHYW = "6"; // 账号冲突
	String HDZT_ZZDKSJ = "7"; // 最终贷款数据

}
