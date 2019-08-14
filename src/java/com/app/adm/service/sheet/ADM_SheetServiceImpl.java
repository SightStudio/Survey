package com.app.adm.service.sheet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.common.collection.CommonVO;
import com.common.collection.CommonVOList;
import com.common.dao.CommonDaoIF;
import com.common.service.BaseService;

@Service
public class ADM_SheetServiceImpl extends BaseService 
							      implements ADM_SheetServiceIF {
	@Autowired
	CommonDaoIF dao;
	
	// 질문지 조회
	@Override
	public CommonVO getSheetList(CommonVO param) throws Exception {
		CommonVO result = new CommonVO();
		
		// [1] 공통 리스트 선택
		CommonVOList<CommonVO> commonList = dao.selectList("com.app.mapper.adm.sheet.selectSheetCommonList", null);
		result.put("commonList", commonList);
		
		// [2] 사무직 리스트 선택
		param.put("ROLE_SEQ","2");
		CommonVOList<CommonVO> officeList = dao.selectList("com.app.mapper.adm.sheet.selectSheetDetailList", param);
		result.put("officeList", officeList);
		
		// [3] 생산직 리스트 선택
		param.put("ROLE_SEQ","3");
		CommonVOList<CommonVO> produceList = dao.selectList("com.app.mapper.adm.sheet.selectSheetDetailList", param);
		result.put("produceList", produceList);

		return result;
	}
	
	// 질문지 등록
	@Override
	public CommonVO registerSheetList(CommonVO param) throws Exception {
		CommonVO result = new CommonVO();
		
		// [1] 기존 설문지 전체 삭제처리 
		dao.delete("com.app.mapper.adm.sheet.deleteSheet", null);
		
		// [2] 사무직 질문지 처리
		CommonVO office = new CommonVO();
		office.put("sheet_name", param.getString("office_sheet_name"));
		office.put("role_seq"  , param.getString("office_role_seq"));
		dao.insert("com.app.mapper.adm.sheet.insertSheet", office);
		
		CommonVOList<CommonVO> officeDetailList = new CommonVOList<>(param.getString("office_detail_list"));
		office.put("detailList", officeDetailList);
		dao.insert("com.app.mapper.adm.sheet.insertSheetDetail", office);
		
		// [3] 생산직 질문지 처리
		CommonVO produce = new CommonVO();
		produce.put("sheet_name", param.getString("produce_sheet_name"));
		produce.put("role_seq"  , param.getString("produce_role_seq"));
		dao.insert("com.app.mapper.adm.sheet.insertSheet", produce);
		
		CommonVOList<CommonVO> produceDetailList = new CommonVOList<>(param.getString("produce_detail_list"));
		produce.put("detailList", produceDetailList);
		dao.insert("com.app.mapper.adm.sheet.insertSheetDetail", produce);
		
		return result;
	}
}
