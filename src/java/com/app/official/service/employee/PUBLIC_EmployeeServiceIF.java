package com.app.official.service.employee;

import com.common.collection.CommonVO;

public interface PUBLIC_EmployeeServiceIF {
	
	// 사원 목록 조회
	public CommonVO getEmployeeList(CommonVO param) throws Exception;
	
	// 사용자 로그인
	public CommonVO login(CommonVO param) throws Exception;
	
	// 사용자 로그아웃
	public CommonVO logout(CommonVO param) throws Exception;;
}
