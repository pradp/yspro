package com.yszoe.cms.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yszoe.cms.service.impl.CmsPublicChannelRSSServiceImpl;

/**
 * CMS展示前台部分，restful url风格
 * @author Yangjianliang
 * datetime 2011-7-8
 */
@Controller
public class CmsPublicChannelRSSController {

//	private static final Log LOG = LogFactory.getLog(CmsPublicChannelRSSController.class);


	@Autowired
	CmsPublicChannelRSSServiceImpl cmsPublicChannelRSSService;

	@RequestMapping(value = "/{channelid}", method = RequestMethod.GET)
	public void rss(@PathVariable String channelid, 
			HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws IOException {

		String rss = cmsPublicChannelRSSService.getRSS(channelid);
		// 输出xml:     
		response.setContentType("text/xml;charset=UTF-8");     
		PrintWriter pw = response.getWriter();     
		pw.print(rss);     
		pw.close(); 
	}

}
