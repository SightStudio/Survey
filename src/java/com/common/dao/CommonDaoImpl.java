package com.common.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Repository;

import com.common.collection.CLog;
import com.common.collection.CommonVO;
import com.common.collection.CommonVOList;

/**
 * 공통 Dao 인터페이스 imple
 * 
 * @since  2019.03.03
 */
@Repository
public class CommonDaoImpl implements CommonDaoIF{
	
	@Autowired
	CLog log;
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public int insert(String mapperId, CommonVO param){
		return sqlSession.insert(mapperId, param);
	}

	@Override
	public int update(String mapperId, CommonVO param) {
		return sqlSession.update(mapperId, param);
	}

	@Override
	public int delete(String mapperId, CommonVO param) {
		return sqlSession.delete(mapperId, param);
	}

	@Override
	public CommonVO select(String mapperId, CommonVO param) {
		return sqlSession.selectOne(mapperId, param);
	}
	
	@Override
	public CommonVOList<CommonVO> selectList(String mapperId, CommonVO param) {
		return new CommonVOList<>(sqlSession.selectList(mapperId, param));
	}
	
	/**
	 * <pre>
	 * 	서버 상태 캐시 초기화  
	 * </pre>
	 * @since  2019. 7. 11.
	 */
	@Override
	@CacheEvict(cacheNames = "serverStatus", allEntries = true)
	public void refreshServerStatus() {
		log.i("[알림] 서버 상태 캐싱이 Refresh 되었습니다.");
	}
}
