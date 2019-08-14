package com.app.adm.service.statistics;

import com.common.collection.CommonVO;

public interface ADM_StatisticsServiceIF {
	
	// 질문지 통계페이지로 이동
	public CommonVO getStatistic(CommonVO param) throws Exception;
	
	// 질문지 통계 엑셀 다운로드
	public CommonVO getStatisticInExcel(CommonVO param) throws Exception;
	
	// 질문지 제보 세부내역 조회
	public CommonVO getSurveyExcuseList(CommonVO param) throws Exception;

	// 질문지 통계 상태 리셋
	public CommonVO resetStatistics(CommonVO param) throws Exception;
}
