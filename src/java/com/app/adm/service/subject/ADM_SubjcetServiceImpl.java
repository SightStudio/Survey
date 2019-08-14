package com.app.adm.service.subject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.common.collection.CommonVO;
import com.common.collection.CommonVOList;
import com.common.dao.CommonDaoIF;
import com.common.service.BaseService;

@Service
public class ADM_SubjcetServiceImpl extends BaseService 
							        implements ADM_SubjectServiceIF {
	@Autowired
	CommonDaoIF dao;
	
	// 전체 사원 목록 with 피평가자 설정 조회
	@Override
	public CommonVO getEmployeeListWithSubject(CommonVO param) throws Exception {
		
		CommonVO result = new CommonVO();
		CommonVOList<CommonVO> empList = dao.selectList("com.app.mapper.adm.subject.selectEmployeeWithSubject", param);
		result.put("empList", empList);
		
		return result;
	}
	
	@Override
	public CommonVO getSubjectInfo(CommonVO param) throws Exception {
		CommonVO result = new CommonVO();
		
		// [1] 피평가자 검색
		CommonVO employee = dao.select("com.app.mapper.adm.employee.selectEmployee", param);
		result.put("employee", employee);
		
		
		return result;
	}
	
	// 특정사원  피평가자 설정 목록 조회
	@Override
	public CommonVO getSubjectList(CommonVO param) throws Exception {
		
		CommonVO result = new CommonVO();
		
		// [1] 피평가자 검색
		CommonVOList<CommonVO> empList = dao.selectList("com.app.mapper.adm.subject.selectSubjectList", param);
		result.put("empList", empList);

		return result;
	}
	
	// 특정사원  피평가자 목록 등록
	@Override
	public CommonVO registerSubjectList(CommonVO param) throws Exception {
		
		CommonVO result = new CommonVO();
		
		// [1] 기존에 있던 피평가자 목록 제거
		dao.delete("com.app.mapper.adm.subject.deleteAssoSurveyMapping", param);
		
		CommonVOList<CommonVO> subjectSeqList = new CommonVOList<>(param.getString("subjectSeqList"));
		param.put("subjectSeqList", subjectSeqList);
		
		// [2 피평가자 관계 목록 새로 삽입
		if (!subjectSeqList.isEmpty()) {
			dao.insert("com.app.mapper.adm.subject.insertAssoSurveyMapping", param);	
		}
		
		return result;
	}

	@Override
	public CommonVO getUnEvaluatedList(CommonVO param) throws Exception {
		
		CommonVO result = new CommonVO();
		CommonVOList<CommonVO> unEvalutedList = dao.selectList("com.app.mapper.adm.survey.getUnEvaluatedList", null);
		
		result.put("unEvalutedList", unEvalutedList);
		return result;
	}
}
