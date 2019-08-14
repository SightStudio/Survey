package com.app.adm.service.employee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.common.collection.CommonVO;
import com.common.collection.CommonVOList;
import com.common.dao.CommonDaoIF;
import com.common.service.BaseService;

@Service
public class ADM_EmployeeServiceImpl extends BaseService 
							     	 implements ADM_EmployeeServiceIF {
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
		
		// [2] 사원 정보 가져오기
		CommonVOList<CommonVO> employeeList = dao.selectList("com.app.mapper.adm.employee.selectEmployeeList", null);
		result.put("empList", employeeList);

		// [3] 직급 가져오기
		CommonVOList<CommonVO> roleList  = dao.selectList("com.app.mapper.adm.role.getRoleList", null);
		result.put("roleList", roleList);

		// [4] 상위 직급 가져오기
		CommonVOList<CommonVO> pRoleList = dao.selectList("com.app.mapper.adm.role.getPRoleList", null);
		result.put("pRoleList", pRoleList);
		
		// [5] 부서 가져오기
		CommonVOList<CommonVO> deptList = dao.selectList("com.app.mapper.adm.dept.getDeptList", null);
		result.put("deptList", deptList);
		
		// [6] 상위 부서 가져오기
		CommonVOList<CommonVO> pDeptList  = dao.selectList("com.app.mapper.adm.dept.getPDeptList", null);
		result.put("pDeptList", pDeptList);
		
		return result;
	}

	@Override
	public CommonVO getEmployeeInsertInfo(CommonVO param) throws Exception {
		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();
		
		// [3] 직급 가져오기
		CommonVOList<CommonVO> roleList  = dao.selectList("com.app.mapper.adm.role.getRoleList", null);
		result.put("roleList", roleList);

		// [4] 상위 직급 가져오기
		CommonVOList<CommonVO> pRoleList = dao.selectList("com.app.mapper.adm.role.getPRoleList", null);
		result.put("pRoleList", pRoleList);
		
		// [5] 부서 가져오기
		CommonVOList<CommonVO> deptList  = dao.selectList("com.app.mapper.adm.dept.getDeptList", null);
		result.put("deptList", deptList);
		
		// [6] 상위 부서 가져오기
		CommonVOList<CommonVO> pDeptList = dao.selectList("com.app.mapper.adm.dept.getPDeptList", null);
		result.put("pDeptList", pDeptList);
		
		return result;
	}

	@Override
	public CommonVO registerEmployee(CommonVO param) throws Exception {
		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();
		
		CommonVOList<CommonVO> empList = new CommonVOList<>(param.getString("empList"));
		param.put("empList", empList);
		
		dao.insert("com.app.mapper.adm.employee.insertEmployee", param);
		return result;
	}

	@Override
	public CommonVO modifyEmployee(CommonVO param) throws Exception {
		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();
		dao.update("com.app.mapper.adm.employee.modifyEmployee", param);
		return result;
	}

	@Override
	public CommonVO removeEmployee(CommonVO param) throws Exception {
		// [1] 결과 컨테이너 세팅
		CommonVO result = new CommonVO();
		dao.update("com.app.mapper.adm.employee.deleteEmployee", param);
		return result;
	}
}
