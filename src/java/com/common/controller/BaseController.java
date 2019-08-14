package com.common.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.common.collection.CLog;
import com.common.collection.CommonVO;

@Controller
public class BaseController {
	
	@Autowired
	public HttpServletRequest req;
	
	@Autowired
	public CLog log;
	
	@ModelAttribute("param")
	public CommonVO initVO() {
		return (CommonVO) req.getAttribute("param");
	}
}
