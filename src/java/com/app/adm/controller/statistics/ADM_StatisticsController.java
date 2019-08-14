package com.app.adm.controller.statistics;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.app.adm.service.statistics.ADM_StatisticsServiceIF;
import com.common.collection.CommonVO;
import com.common.controller.BaseController;

@Controller
public class ADM_StatisticsController extends BaseController {
	
	@Autowired
	ADM_StatisticsServiceIF statisticsService;
	
	@GetMapping("ADM/statistics")
	public ModelAndView statisticsView(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("ADM/statistics/surveyStatistics");
		CommonVO result = statisticsService.getStatistic(param);
		
		mav.addObject("request", param);
		mav.addObject("response", result);
		return mav;
	}
	
	@PostMapping("ADM/statistics/downExcel/{FILE_NAME}")
	public ModelAndView getStatisticsInExcel(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("downloadView"); 
		
		CommonVO result = statisticsService.getStatisticInExcel(null);
		mav.addObject("downloadFile", result.get("downloadFile"));
		return mav;
	}
	
	// -------------------------------------  JSON URL -------------------------------------  
	@GetMapping("ADM/statistics/excuseList/{NO}")
	public ModelAndView adminHome(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		CommonVO result = statisticsService.getSurveyExcuseList(param);
		
		mav.addObject("request", param);
		mav.addObject("response", result);
		return mav;
	}
	
	@DeleteMapping("ADM/statistics/resetAll")
	public ModelAndView resetSurveyStatus(@ModelAttribute("param") CommonVO param) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		CommonVO result = statisticsService.resetStatistics(param);
				
		mav.addObject("request", param);
		mav.addObject("response", result);
		return mav;
	}
}