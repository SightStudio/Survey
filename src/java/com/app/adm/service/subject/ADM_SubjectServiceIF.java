package com.app.adm.service.subject;

import com.common.collection.CommonVO;

public interface ADM_SubjectServiceIF {
	
	// 사원 피평가자 설정 현황 조회
	public CommonVO getEmployeeListWithSubject(CommonVO param) throws Exception;

	// 특정 사원 피평가자 페이지 정보
	public CommonVO getSubjectInfo(CommonVO param) throws Exception;
	
	// 특정 사원 피평가자 목록조회
	public CommonVO getSubjectList(CommonVO param) throws Exception;
	
	// 특정 사원 피평가자 목록 등록
	public CommonVO registerSubjectList(CommonVO param) throws Exception;
	
	// 미평자가 목록 조회
	public CommonVO getUnEvaluatedList(CommonVO param) throws Exception;
}
