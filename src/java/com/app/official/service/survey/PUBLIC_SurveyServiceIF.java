package com.app.official.service.survey;

import com.common.collection.CommonVO;

public interface PUBLIC_SurveyServiceIF {
	
	public CommonVO getSurveyInfo(CommonVO param) throws Exception;
	
	public CommonVO registerSurvey(CommonVO param) throws Exception;
}
