package com.yszoe.cms.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yszoe.cms.service.impl.CmsPublicCommentServiceImpl;
import com.yszoe.identity.IdConstants;
import com.yszoe.identity.entity.TSysUser;
import com.yszoe.util.JSONUtils;

/**
 * CMS前台评论部分，restful url风格
 * @author Yangjianliang
 * datetime 2011-7-27
 */
@Controller
public class CmsPublicCommentController {

	private static final Log LOG = LogFactory.getLog(CmsPublicCommentController.class);

	@Autowired
	CmsPublicCommentServiceImpl CmsPublicCommentService;

	@RequestMapping(value = "/docomment/{articleindexid}.jhtm", method = RequestMethod.POST)
	public @ResponseBody String saveComment(@PathVariable String articleindexid, @RequestParam String plnr,
			HttpServletRequest request, ModelMap modelMap) {

		HttpSession session = request.getSession();
		TSysUser user = (TSysUser)session.getAttribute(IdConstants.SESSION_USER);
		String plrip = request.getRemoteAddr();
		try {
			CmsPublicCommentService.saveComment(articleindexid, plnr, plrip, user, modelMap);
		} catch (Exception e) {
			LOG.error(e);
			modelMap.put("msg", e.getMessage());
		}
		return JSONUtils.castToString(modelMap); 
	}

}
