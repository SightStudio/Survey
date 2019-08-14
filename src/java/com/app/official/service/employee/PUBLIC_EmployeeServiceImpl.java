package com.app.official.service.employee;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.common.collection.CommonVO;
import com.common.collection.CommonVOList;
import com.common.dao.CommonDaoIF;
import com.common.exception.BizException;
import com.common.service.BaseService;
import com.common.session.SessionUtil;

@Service
public class PUBLIC_EmployeeServiceImpl extends BaseService 
							     	    implements PUBLIC_EmployeeServiceIF {
	@Autowired
	CommonDaoIF dao;
	
	/**
	 * <pre>
	 *     사원 목록 조회 메서드
	 * </pre>
	 * @since  2019. 6. 30.
	 */
	@Override
	public CommonVO getEmployeeList(CommonVO param) throws Exception {
		
		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();
		
		// [2] 회원 가입
		CommonVOList<CommonVO> employeeList = dao.selectList("com.app.mapper.official.employee.selectEmployeeList", null);
		result.put("employeeList", employeeList);
		
		return result;
	}
	
	/**
	 * <pre>
	 *    사원 로그인
	 * </pre>
	 * @since  2019. 7. 4.
	 */
	@Override
	public CommonVO login(CommonVO param) throws Exception {
		
		// [1] 결과 컨테이너 세팅
		CommonVO result     = new CommonVO();
		HttpSession session = SessionUtil.getSession();
		CommonVO userInfo   = dao.select("com.app.mapper.official.employee.selectEmployee", param);
		
		// [2] 아이디 검증
		if( userInfo == null) {
			throw new BizException("000002", "[로그인 에러] 해당 아이디가 존재하지 않습니다.");
		}
		
		// [2] 비밀번호 검증			
		if( !userInfo.getString("PW").equals(param.getString("PW"))) {
			throw new BizException("000003", "[로그인 에러] 비밀번호가 일치하지 않습니다.");
		}
		
		// [3] 검증 통과시 세션에 user 정보 할당
		userInfo.put("ROLE", "PUBLIC");
		session.removeAttribute("USER");
		session.setAttribute("USER", userInfo);
		return result;
	}

	/**
	 * <pre>
	 *   사원 로그 아웃   
	 * </pre>
	 * @since  2019. 7. 4.
	 */
	@Override
	public CommonVO logout(CommonVO param) throws Exception {
		
		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();
		
		HttpSession session = SessionUtil.getSession();
		session.removeAttribute("USER");
		
		return result;
	}
}
