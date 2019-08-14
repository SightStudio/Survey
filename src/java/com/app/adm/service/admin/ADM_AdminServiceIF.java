package com.app.adm.service.admin;

import com.common.collection.CommonVO;

public interface ADM_AdminServiceIF {

	// 사용자 로그인
	public CommonVO login(CommonVO param) throws Exception;
	
	// 사용자 로그아웃
	public CommonVO logout(CommonVO param) throws Exception;
	
	// 서버 설문 시작
	public CommonVO startSurvey(CommonVO param) throws Exception;
}
