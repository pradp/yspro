package com.yszoe.sys.util;

import java.util.List;

import com.yszoe.sys.entity.FusionChartsDTO;

/**
 * flash图表控件FusionCharts的xml数据源提供者
 * @author Yangjianliang datetime 2010-12-26
 */
public class ChartXmlDataProvider {

//	private static final Log LOG = LogFactory.getLog(ChartXmlDataProvider.class);

	public static String getXml(FusionChartsDTO fusionChartsDTO) {
		if(null==fusionChartsDTO){
			return "";
		}
		List<String[]> data = fusionChartsDTO.getData();
		if(data==null || data.isEmpty()){
			return "";
		}
		String caption = fusionChartsDTO.getCaption();
		String subCaption = fusionChartsDTO.getSubCaption();
		StringBuffer dataBuffer = new StringBuffer("");
		dataBuffer.append("<chart caption='").append(caption).append("' subCaption='")
		.append(subCaption).append("' shownames='1' showvalues='0' decimals='0' numberPrefix=''>\n");

		for (int i = 0; i < data.size(); i++) {
			String[] set = data.get(i);
			dataBuffer.append("<set label='" + set[0] + "' value='" + set[1] + "' />\n");
		}
		dataBuffer.append("</chart>");
		return dataBuffer.toString();
	}
}
