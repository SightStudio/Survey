package com.common.dao;

import com.common.collection.CommonVO;
import com.common.collection.CommonVOList;

/**
 * 공통 Dao 인터페이스 
 * 
 * @since  2019.03.03
 */
public interface CommonDaoIF {
	
	// 단일 조회
	public CommonVO select(String mapperId, CommonVO param);

	// 리스트 조회
	public CommonVOList<CommonVO> selectList(String mapperId, CommonVO param);
	
	// 삽입
	public int insert(String mapperId, CommonVO param);
	
	// 수정
	public int update(String mapperId, CommonVO param);
	
	// 삭제
	public int delete(String mapperId, CommonVO param);
	
	// 서버 상태 갱신
	public void refreshServerStatus();
}
