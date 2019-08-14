package com.app.official.controller.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.app.official.service.employee.PUBLIC_EmployeeServiceIF;
import com.common.collection.CommonVO;
import com.common.controller.BaseController;

@Controller
public class PUBLIC_HomeController extends BaseController {
	
	@Autowired
	PUBLIC_EmployeeServiceIF empService;
	
	/**
	 * <pre>
	 *   사용자 메인 페이지 이동
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@GetMapping("index")
	public ModelAndView admin(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("PUBLIC/home");
		mav.addObject("request", param);
		
		return mav;
	}
	
	/**
	 * 로그인 실행 페이지
	 * 
	 * @since  2019.05.05
	 */
	@GetMapping("PUBLIC/login")
	public ModelAndView publicLogin(@ModelAttribute("param") CommonVO param) throws Exception {
		ModelAndView mav = new ModelAndView("PUBLIC/login/login");
		return mav;
	}
	
	/**
	 * 사원 로그인 실행 페이지
	 * 
	 * @since  2019.05.05
	 */
	@PostMapping("PUBLIC/login")
	public ModelAndView doPublicLogin(@ModelAttribute("param") CommonVO param) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		CommonVO result = empService.login(param);
		
		mav.addObject("request", param);
		mav.addObject("response", result);
		return mav;
	}
	
	/**
	 * 사원 로그아웃 실행 페이지
	 * 
	 * @since  2019.05.05
	 */
	@GetMapping("PUBLIC/logout")
	public ModelAndView doLogout(@ModelAttribute("param") CommonVO param) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		CommonVO result = empService.logout(param);
		
		mav.addObject("request", param);
		mav.addObject("response", result);
		return mav;
	}
}