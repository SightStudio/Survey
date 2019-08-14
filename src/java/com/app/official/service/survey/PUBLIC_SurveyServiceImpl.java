package com.app.official.service.survey;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.common.collection.CommonVO;
import com.common.collection.CommonVOList;
import com.common.dao.CommonDaoIF;
import com.common.service.BaseService;

@Service
public class PUBLIC_SurveyServiceImpl extends BaseService 
							 		  implements PUBLIC_SurveyServiceIF {
	
	@Autowired
	CommonDaoIF dao;
	
	/**
	 * <pre>
	 *   설문지 정보 가져오기   
	 * </pre>
	 * @since  2019. 7. 5.
	 */
	@Override
	public CommonVO getSurveyInfo(CommonVO param) throws Exception {
		
		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();

		// [2] 공통 리스트 선택
		CommonVOList<CommonVO> commonList = dao.selectList("com.app.mapper.official.sheet.selectSheetCommonList", null);
		result.put("commonList", commonList);
		
		// [3] 질문지 리스트 선택
		CommonVOList<CommonVO> sheetList = dao.selectList("com.app.mapper.official.sheet.selectSheetDetailList", param);
		result.put("sheetList", sheetList);
		
		// [4] 질문지 답안 유형 가져오기
		CommonVOList<CommonVO> answerTypeList = dao.selectList("com.app.mapper.official.sheet.selectAnswerType", null);
		result.put("answerTypeList", answerTypeList);
		
		// [5] 피평가자 검색
		CommonVO employee = dao.select("com.app.mapper.official.employee.selectEmployeeWithSheet", param);
		result.put("employee", employee);
		
		// [6] 기타 파타리터 세팅
		result.put("ASSO_SURVEY_SEQ", param.getString("ASSO_SURVEY_SEQ"));
		
		return result;
	}

	@Override
	public CommonVO registerSurvey(CommonVO param) throws Exception {
		
		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();
				
		// [2] 질문지 등록
		dao.insert("com.app.mapper.official.survey.insertSurvey", param);
		
		// [3] 질문지 세부 내역 등록
		CommonVOList<CommonVO> answerList = new CommonVOList<>(param.getString("answerList"));
		param.put("answerList", answerList);
		
		dao.insert("com.app.mapper.official.survey.insertSurveyDetail", param);
		
		return result;
	}
	
}
