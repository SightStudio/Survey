package com.app.adm.service.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.common.collection.CommonVO;
import com.common.dao.CommonDaoIF;
import com.common.exception.BizException;
import com.common.service.BaseService;
import com.common.session.SessionUtil;

@Service
public class ADM_AdminServiceImpl extends BaseService 
							      implements ADM_AdminServiceIF {
	@Autowired
	CommonDaoIF dao;

	/**
	 * <pre>
	 *    관리자 로그인
	 * </pre>
	 * @since  2019. 7. 4.
	 */
	@Override
	public CommonVO login(CommonVO param) throws Exception {
		
		// [1] 결과 컨테이너 세팅
		CommonVO result     = new CommonVO();
		HttpSession session = SessionUtil.getSession();
		CommonVO userInfo   = dao.select("com.app.mapper.adm.admin.selectAdmin", param);
		
		// [2] 아이디 검증
		if( userInfo == null) {
			throw new BizException("000003", "[로그인 에러] 해당 아이디가 존재하지 않습니다.");
		}
		
		// [3] 비밀번호 검증			
		if( !userInfo.getString("PW").equals(param.getString("PW"))) {
			throw new BizException("000004", "[로그인 에러] 비밀번호가 일치하지 않습니다.");
		}
		
		// [4] 검증 통과시 세션에 user 정보 할당
		session.removeAttribute("ADMIN");
		session.setAttribute("ADMIN", userInfo);
		return result;
	}

	/**
	 * <pre>
	 *   관리자 로그 아웃   
	 * </pre>
	 * @since  2019. 7. 4.
	 */
	@Override
	public CommonVO logout(CommonVO param) throws Exception {
		
		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();
		
		HttpSession session = SessionUtil.getSession();
		session.removeAttribute("ADMIN");
		
		return result;
	}

	@Override
	public CommonVO startSurvey(CommonVO param) throws Exception {
		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();
		
		// [2] 평가 상태 -> 평가 진행중으로 변경
		dao.delete("com.app.mapper.common.serverStatus.startSurvey", null);
		
		// [3] 서버 평가 상태 캐시 refresh
		dao.refreshServerStatus();
		
		return result;
	}
}
