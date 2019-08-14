package com.app.official.controller.survey;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.app.official.service.survey.PUBLIC_SurveyServiceIF;
import com.common.collection.CommonVO;
import com.common.controller.BaseController;

@Controller
public class PUBLIC_SurveyController extends BaseController {
	
	@Autowired
	PUBLIC_SurveyServiceIF surveyService;
	
	/**
	 * <pre>
	 *    설문조사 전체 목록 조회  AJAX 
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@GetMapping("PUBLIC/survey/register/{ASSO_SURVEY_SEQ}/{P_ROLE_SEQ}/{NO}")
	public ModelAndView getSurveyInfo(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("PUBLIC/survey/registerSurvey");
		CommonVO response = surveyService.getSurveyInfo(param);
		mav.addObject("request", param);
		mav.addObject("response", response);

		return mav;
	}
	
	
	// ---------------------------------   JSON URL   --------------------------------------
	@PostMapping("PUBLIC/survey/register")
	public ModelAndView registerSurvey(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		CommonVO response = surveyService.registerSurvey(param);
		
		mav.addObject("request", param);
		mav.addObject("response", response);

		return mav;
	}
}