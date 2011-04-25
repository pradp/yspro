package com.imchooser.infoms.service.biz.impl;

import java.sql.SQLException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.util.DBUtil;
import com.imchooser.infoms.service.sys.ExcelImportCustomService;
import com.imchooser.infoms.util.SQLConfigUtil;

/**
 * 游泳成绩导入
 * @author Yangjianliang
 * datetime 2010-5-13
 */
public class ExcelImportYycj implements ExcelImportCustomService {

	private static final Log LOG = LogFactory.getLog(ExcelImportYycj.class);

	/* (non-Javadoc)
	 * @see com.imchooser.infoms.service.sys.ExcelImportCustomService#customMethodAfterImport()
	 */
	public void customMethodAfterImport() {
		String prod = SQLConfigUtil.getProcName("procd.sports_jk_yy");
		String result = null;
		try {
			result = DBUtil.execOracleProcQueryString(prod);
		} catch (SQLException e) {
			LOG.error(e);
			throw new RuntimeException(e.getMessage());
		}
		if(!"1".equals(result)){//1是成功，其他值是有错误的。
			throw new RuntimeException(result);
		}
	}

	/* (non-Javadoc)
	 * @see com.imchooser.infoms.service.sys.ExcelImportCustomService#customMethodBeforeImport()
	 */
	public void customMethodBeforeImport() {
		// 清除临时表数据
		DBUtil.executeSQL("delete from t_sport_jk_yy");
	}

}
