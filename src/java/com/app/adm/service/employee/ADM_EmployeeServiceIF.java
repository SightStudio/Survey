package com.app.adm.service.employee;

import com.common.collection.CommonVO;

public interface ADM_EmployeeServiceIF {
	
	// 사원 목록 조회
	public CommonVO getEmployeeList(CommonVO param) throws Exception;
	
	// 사원 추가 페이지
	public CommonVO getEmployeeInsertInfo(CommonVO param) throws Exception;
	
	// 사원 추가 액션
	public CommonVO registerEmployee(CommonVO param) throws Exception;
	
	// 사원 수정 액션
	public CommonVO modifyEmployee(CommonVO param) throws Exception;
	
	// 사원 삭제 액션
	public CommonVO removeEmployee(CommonVO param) throws Exception;
}
