package com.app.adm.controller.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.app.adm.service.admin.ADM_AdminServiceIF;
import com.common.collection.CommonVO;
import com.common.controller.BaseController;

@Controller
public class ADM_HomeController extends BaseController {
	
	@Autowired
	ADM_AdminServiceIF adminService;
	
	/**
	 * <pre>
	 *   관리자 로그인 페이지로 이동
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@GetMapping("ADM/index")
	public ModelAndView adminHome(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("ADM/home");
		mav.addObject("request",  param);
		return mav;
	}
	
	/**
	 * <pre>
	 *   관리자 로그인 페이지로 이동
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@GetMapping("ADM/login")
	public ModelAndView admin(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("ADM/login/login");
		return mav;
	}
	
	/**
	 * 사원 로그인 실행 페이지
	 * 
	 * @since  2019.05.05
	 */
	@PostMapping("ADM/login")
	public ModelAndView doPublicLogin(@ModelAttribute("param") CommonVO param) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		CommonVO result = adminService.login(param);
		
		mav.addObject("request", param);
		mav.addObject("response", result);
		return mav;
	}
	
	/**
	 * 사원 로그아웃 실행 페이지
	 * 
	 * @since  2019.05.05
	 */
	@GetMapping("ADM/logout")
	public ModelAndView doLogout(@ModelAttribute("param") CommonVO param) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		CommonVO result = adminService.logout(param);
		
		mav.addObject("request", param);
		mav.addObject("response", result);
		return mav;
	}
	
	@PostMapping("ADM/startSurvey")
	public ModelAndView startSurvey(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		
		CommonVO result = adminService.startSurvey(param);
		mav.addObject("request", param);
		mav.addObject("response", result);
		
		return mav;
	}
}