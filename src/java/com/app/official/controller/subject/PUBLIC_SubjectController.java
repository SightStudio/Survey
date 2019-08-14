package com.app.official.controller.subject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.app.official.service.subject.PUBLIC_SubjectServiceIF;
import com.common.collection.CommonVO;
import com.common.controller.BaseController;

@Controller
public class PUBLIC_SubjectController extends BaseController {
	
	@Autowired
	PUBLIC_SubjectServiceIF subjectService;
	
	@GetMapping("PUBLIC/subjectList/{NO}")
	public ModelAndView getSubjectList(@ModelAttribute("param") CommonVO param) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		CommonVO result = subjectService.getSubjectList(param);

		mav.addObject("request" , param);
		mav.addObject("response", result);
		
		return mav;
	}
}