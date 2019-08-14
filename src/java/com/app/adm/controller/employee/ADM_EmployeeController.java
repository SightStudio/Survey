package com.app.adm.controller.employee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.app.adm.service.employee.ADM_EmployeeServiceIF;
import com.common.collection.CommonVO;
import com.common.controller.BaseController;

@Controller
public class ADM_EmployeeController extends BaseController {
	
	@Autowired
	ADM_EmployeeServiceIF empService;
	
	/**
	 * <pre>
	 *  사원 조회 수정 삭제페이지
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@GetMapping("ADM/employee/list")
	public ModelAndView employeeListView(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("ADM/employee/employeeList");
		
		CommonVO result = empService.getEmployeeList(param);

		mav.addObject("request" , param);
		mav.addObject("response", result);
		
		return mav;
	}
	
	/**
	 * <pre>
	 *   사원 등록 페이지
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@GetMapping("ADM/employee/register")
	public ModelAndView employeeRegisterView(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("ADM/employee/registerEmployee");
		CommonVO result = empService.getEmployeeInsertInfo(param);

		mav.addObject("request" , param);
		mav.addObject("response", result);
		
		return mav;
	}

	// ================================================ JSON URL ===================================================
	
	@PostMapping("ADM/employee/register")
	public ModelAndView registerEmployee(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		CommonVO result = empService.registerEmployee(param);

		mav.addObject("request" , param);
		mav.addObject("response", result);
		
		return mav;
	}
	
	@PostMapping("ADM/employee/edit")
	public ModelAndView modifyEmployee(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		CommonVO result = empService.modifyEmployee(param);

		mav.addObject("request" , param);
		mav.addObject("response", result);
		
		return mav;
	}
	
	@DeleteMapping("ADM/employee/{emp_seq}")
	public ModelAndView removeEmployee(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		CommonVO result = empService.removeEmployee(param);

		mav.addObject("request" , param);
		mav.addObject("response", result);
		
		return mav;
	}
	
}





