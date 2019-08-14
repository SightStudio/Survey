package com.app.official.service.subject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.common.collection.CommonVO;
import com.common.collection.CommonVOList;
import com.common.dao.CommonDaoIF;
import com.common.service.BaseService;

@Service
public class PUBLIC_SubjectServiceImpl extends BaseService 
							 		   implements PUBLIC_SubjectServiceIF {
	
	@Autowired
	CommonDaoIF dao;
	
	/**
	 * <pre>
	 *   설문지 정보 가져오기   
	 * </pre>
	 * @since  2019. 7. 5.
	 */
	public CommonVO getSurveyInfo(CommonVO param) throws Exception {
		
		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();
		
		// [2] 질문지 목록 검색
		CommonVOList<CommonVO> surveyList = dao.selectList("com.app.mapper.official.survey.selectSurveyDetail", param);
		result.put("surveyList", surveyList);
		
		// [3] 질문지 답안 유형 가져오기
		CommonVOList<CommonVO> answerTypeList = dao.selectList("com.app.mapper.official.question.selectAnswerType", null);
		result.put("answerTypeList", answerTypeList);
		
		// [4] 피평가자 검색
		CommonVO employee = dao.select("com.app.mapper.official.employee.selectEmployeeWithSheet", param);
		result.put("employee", employee);
		
		return result;
	}
	
	@Override
	public CommonVO getSubjectList(CommonVO param) throws Exception {

		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();
		
		// [2] 피평가자 목록 조회 
		CommonVOList<CommonVO> subjectList = dao.selectList("com.app.mapper.official.subject.selectSubjectList", param);
		result.put("subjectList", subjectList);
		
		return result;
	}
}