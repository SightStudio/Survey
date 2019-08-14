package com.app.adm.controller.sheet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.app.adm.service.sheet.ADM_SheetServiceIF;
import com.common.collection.CommonVO;
import com.common.controller.BaseController;

@Controller
public class ADM_SheetController extends BaseController {
	
	@Autowired
	ADM_SheetServiceIF sheetService;

	/**
	 * <pre>
	 *   질문지 조회 페이지로 이동
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@GetMapping("ADM/sheet")
	public ModelAndView getSheetEditView(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("ADM/sheet/sheetEditView");
		
		CommonVO response = sheetService.getSheetList(param);
		mav.addObject("request", param);
		mav.addObject("response", response);

		return mav;
	}
	
	@GetMapping("ADM/sheetView")
	public ModelAndView getSheetView(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("ADM/sheet/sheetView");
		
		CommonVO response = sheetService.getSheetList(param);
		mav.addObject("request", param);
		mav.addObject("response", response);

		return mav;
	}
	
	// ======================================= JSON URL =======================================
	
	/**
	 * <pre>
	 *   질문지 조회 등록 페이지
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@PostMapping("ADM/sheet")
	public ModelAndView registerSheetList(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		
		CommonVO response = sheetService.registerSheetList(param);
		mav.addObject("request", param);
		mav.addObject("response", response);

		return mav;
	}
}