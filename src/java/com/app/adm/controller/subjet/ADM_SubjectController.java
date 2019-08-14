package com.app.adm.controller.subjet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.app.adm.service.subject.ADM_SubjectServiceIF;
import com.common.collection.CommonVO;
import com.common.controller.BaseController;

@Controller
public class ADM_SubjectController extends BaseController {
	
	@Autowired
	ADM_SubjectServiceIF subjectService;
	
	/**
	 * <pre>
	 *    특정 사원 피평가자 페이지 조회 목록
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@GetMapping("ADM/subject/{NO}")
	public ModelAndView registerSubject(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("ADM/subject/registerSubject");
		
		CommonVO result = subjectService.getSubjectInfo(param);
		mav.addObject("request", param);
		mav.addObject("response", result);

		return mav;
	}

	// ======================================= JSON URL =======================================
	
	/**
	 * <pre>
	 *     사원 피평가자 설정 현황 조회 Ajax  
	 * </pre>
	 * @since  2019. 7. 6.
	 */
	@GetMapping("ADM/subject/all")
	public ModelAndView getSubjectAll(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		
		CommonVO result = subjectService.getEmployeeListWithSubject(param);

		mav.addObject("request" , param);
		mav.addObject("response", result);
		
		return mav;
	}
	
	/**
	 * <pre>
	 *    특정 사원 피평가자 목록조회 AJAX
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@GetMapping("ADM/subject/{NO}/detail")
	public ModelAndView getQuestionListALL(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		
		CommonVO result = subjectService.getSubjectList(param);
		mav.addObject("request",  param);
		mav.addObject("response", result);

		return mav;
	}
	
	/**
	 * <pre>
	 *    피평가자 목록 등록 AJAX 함수
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@PostMapping("ADM/subject/{NO}")
	public ModelAndView registerSubjectAction(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		
		CommonVO result = subjectService.registerSubjectList(param);
		mav.addObject("request", param);
		mav.addObject("response", result);

		return mav;
	}

	
	/**
	 * <pre>
	 *    특정 사원 피평가자 목록조회 AJAX
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@GetMapping("ADM/unevaluate")
	public ModelAndView getUnEvaluateListALL(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		
		CommonVO result = subjectService.getUnEvaluatedList(param);
		mav.addObject("request",  param);
		mav.addObject("response", result);

		return mav;
	}
}