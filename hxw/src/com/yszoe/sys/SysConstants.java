package com.yszoe.sys;

import com.yszoe.identity.IdConstants;

public interface SysConstants {

	long FILE_SIZE_1M = 1048576;// 1M = 1048576 byte

	String FILE_SIZE_PHOTO = "MaxPhotoSize";// 系统参数设置照片的大小

	String MESSAGE_FILE_SIZE = "MessageFileMaxSize"; // 系统参数设置消息发送 附件大小

	String SESSION_USER_FLAG = IdConstants.SESSION_USER;

	String USER_TYPE_BIZ_DIRECTOR = IdConstants.USER_TYPE_BIZ_DIRECTOR;// 业务主管(登录用户类型)

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

	/************************* 标准维护 *****************************/
	String SYSCODE_ZJLX = "zjlx";// 证件类型
	String SYSCODE_SHZT = "shzt";// 审核状态
	String SYSCODE_CLZT = "clzt";// 处理状态

	/************************* 系统参数定义 *****************************/

	int LOG_ACTION_SAVE = 1; // 用户操作日志类型:保存

	int LOG_ACTION_UPDATE = 2; // 用户操作日志类型:更新

	int LOG_ACTION_DEL = 3; // 用户操作日志类型:删除

	int LOG_ACTION_CANCEL = 4; // 用户操作日志类型:取消成绩

	int LOG_ACTION_RECOVER = 5; // 用户操作日志类型:恢复成绩

	int LOG_ACTION_APPROVE = 6; // 用户操作日志类型:审核

	int LOG_ACTION_PUBLISH = 7; // 用户操作日志类型:发布

	int LOG_ACTION_CANCEL_PUBLISH = 8; // 用户操作日志类型:撤销发布

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
	String CZDX_T_SYS_BUTTON_RULE = "TSysButtonRule"; // 模块功能开放规则表
	String CZDX_T_SYS_BUTTON = "TSysButton"; // 按钮字典
	String CZDX_T_SYS_GROUP = "TSysGroup"; // 用户组
	String CZDX_T_SYS_MENU = "TSysMenu"; // 系统菜单
	String CZDX_T_SYS_ROLE = "TSysRole"; // 系统角色
	String CZDX_T_SCJC_DUTY = "TScjcDuty"; // 生产监测任务
	String CZDX_T_SCJC_CODE = "TScjcCode"; // 生产监测指标字典
	String CZDX_T_SCJC_XX = "TScjcXx"; // 生产监测信息登记
	String CZDX_T_SYS_MESSAGE_CTRL = "TSysMessageCtrl"; // 消息管理
	String CZDX_T_CS_LX = "TCsLx"; // 测试类型
	String CZDX_T_CS_XM = "TCsXm"; // 测试项目

	/**
	 * 是与否
	 */
	String TRUE = "1";
	String FLASE = "0";

	/*
	 * 校验身份(业务主管)
	 */
	String JYSF_FZG = "0"; // 非业务主管
	String JYSF_ZG = "1"; // 业务主管
	String JYSF_BCZ = "2"; // 账号不存在
	String JYSF_MMCW = "3"; // 密码错误

	/**
	 * 审核状态
	 */
	String SHZT_WKS = "0"; // 未开始
	String SHZT_CG = "1"; // 草稿
	String SHZT_SHTG = "9"; // 审核通过
	String SHZT_SZXTH = "-9"; // 中心退回

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
	 * 系统消息模块 发送状态
	 */
	String FSZT_YFS = "1"; // 已发送
	String FSZT_CG = "0"; // 未发送,草稿

	String YHLX_ADMIN = "";
	String YHLX_UNLABELLED = "";

	/**
	 * 刷新内存 类型
	 */
	String REFRESH_DTBD = "dtbd"; // 动态表单
	String REFRESH_PROP = "prop"; // 系统参数
	String REFRESH_ALL = "all"; // 全部

	/**
	 * 操作类型
	 */
	String CZLX_XZ = "1"; // 新增
	String CZLX_XG = "2"; // 修改

	/**
	 * 树机构类型
	 */
	String TREETYPE_DEPART_AREA = "1"; // 区域部门树
	String TREETYPE_DEPART = "0"; // 部门树
	String TREETYPE_AREA = "2"; // 区域数
	String TREETYPE_MENU = "3"; // 菜单树
}
