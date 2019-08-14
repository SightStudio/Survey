package com.app.adm.service.sheet;

import com.common.collection.CommonVO;

public interface ADM_SheetServiceIF {
	
	// 질문지 조회
	public CommonVO getSheetList(CommonVO param) throws Exception;
	
	// 질문지 등록
	public CommonVO registerSheetList(CommonVO param) throws Exception;
}
