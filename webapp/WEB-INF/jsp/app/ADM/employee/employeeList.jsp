<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 로그인 확인  --%>
<c:if test="${empty ADMIN}">
	<script> location.href = '${HOME}/ADM/login' </script>
</c:if>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Survey</title>
	
	<!-- init CSS -->
	<link rel="stylesheet" href="${CSS}/common/init/bulma.min.css" />
	<link rel="stylesheet" href="${CSS}/common/init/bulma-extensions.min.css" />
	
	<!-- init JS -->
    <script src="${JS}/common/jquery/jquery-3.4.0.min.js"></script>
    <script src="${JS}/common/bulma-extensions.min.js"></script>
   
	<style>
		table tr.is-selected { background-color : #F5F5F5 !important; color:#000 !important;}
		#empTable > tbody > tr {cursor: pointer;}
		#empTable tr th, #empTable tr td {vertical-align: middle; text-align: center !important;}
	</style>
</head>
<body>
	<c:set var="VO" value="${response}" />
	<c:set var="REQ" value="${request}" />
	
	<div class="container is-fluid">
	
		<%-- HEADER 영역 START --%>
		<%@ include file="../../../common/ADM_HEADER.jsp" %>
		<%-- HEADER 영역 END --%>
		
		<article class="message">
			<div class="message-header">
				<p>사원 관리</p>
				<p>평가 상태 : [ ${REQ.serverStatus.STATUS_DESC} ]</p>
				<p><a class="button" href="${HOME}/ADM/employee/register">사원 추가</a></p>
			</div>
		</article>
		
		<c:if test="${REQ.serverStatus.STATUS eq 0}">
			<p class="title is-6 has-text-danger">평가 상태가 
				<span class="has-text-dark">[평가 준비]</span>인 경우에만 
				<span class="has-text-dark">[사원 수정/삭제]</span>
			를 할 수 있습니다.</p>
		</c:if>
		
		<%-- 직위 & 직위 세부 템플릿 START --%>
		<select class="is-hidden role-select-list">
			<c:forEach var="role" items="${VO.roleList}">
				<option data-p-role-seq="${role.PROLE_SEQ}" 
						value="${role.ROLE_SEQ}">${role.ROLE_NAME}</option>
			</c:forEach>
		</select>
		
		<select class="is-hidden dept-select-list">
			<c:forEach var="dept" items="${VO.deptList}">
				<option data-p-dept-seq="${dept.PDEPT_SEQ}" 
						value="${dept.DEPT_SEQ}">${dept.DEPT_NAME}</option>
			</c:forEach>
		</select>
		<%-- 직위 & 직위 세부 템플릿 END --%>
		
		<table id="empTable" class="table is-bordered is-size-7">
		  <thead>
		    <tr>
		      <th style="width:3%;">No</th>
		      <th style="width:7%;">이름</th>
		      <th style="width:7%;">ID</th>
    		  <th style="width:7%;">PW</th>
		      <th style="width:7%;">사번</th>
		      <th style="width:10%;">상위부서</th>
		      <th style="width:10%;">부서명</th>
		      <th style="width:7%;">사원구분</th>
		      <th style="width:7%;">직위</th>
		      <th style="width:8%;">직책</th>
		      <th style="width:17%;">이메일</th>
		      <th style="width:10%;">관리</th>
		    </tr>
		  </thead>
		  <tfoot>
		    <tr>
   		      <th>No</th>
    		  <th>이름</th>
    		  <th>ID</th>
    		  <th>PW</th>
    		  <th>사번</th>
		      <th>상위부서</th>
		      <th>부서명</th>
		      <th>사원구분</th>
		      <th>직위</th>
		      <th>직책</th>
		      <th>이메일</th>
		      <th>관리</th>
		    </tr>
		  </tfoot>
		  <tbody>
		  
		  	<c:forEach var="E" items="${VO.empList}" varStatus="e_stat">
				<tr data-emp-no="${E.NO}">
					<td>${e_stat.count}</td>
					<td><input type="text" class="input is-small emp-name" value="${E.EMP_NAME}"> </td>
					<td><input type="text" class="input is-small emp-id"   value="${E.EMP_ID}">   </td>
					<td><input type="text" class="input is-small emp-pw"   value="${E.EMP_PW}">   </td>
					<td><input type="text" class="input is-small emp-no"   value="${E.EMP_NO}">   </td>
					
					<td>
						<div class="select">
							<select class="p-dept-select">
								<c:forEach var="pDept" items="${VO.pDeptList}">
									<option value="${pDept.DEPT_SEQ}" 
										<c:if test="${pDept.DEPT_SEQ eq E.PDEPT_SEQ}"> selected</c:if>
									>${pDept.DEPT_NAME}</option>
								</c:forEach>
							</select>
						</div>
					</td>
					
					<td>
						<div class="select">
							<select class="dept-select">
								<c:forEach var="dept" items="${VO.deptList}">
									<c:if test="${dept.PDEPT_SEQ eq E.PDEPT_SEQ}">
										<option value="${dept.DEPT_SEQ}" 
											<c:if test="${dept.DEPT_SEQ eq E.DEPT_SEQ}">										
												selected
											</c:if>>
											${dept.DEPT_NAME}
										</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
					</td>
					
					<td>
						<div class="select">
							<select class="p-role-select">
								<c:forEach var="pRole" items="${VO.pRoleList}">
									<option value="${pRole.ROLE_SEQ}"
										<c:if test="${pRole.ROLE_SEQ eq E.PROLE_SEQ}">selected</c:if>
									>${pRole.ROLE_NAME}</option>
								</c:forEach>
							</select>
						</div>
					</td>
					<td>
						<div class="select">
							<select class="role-select">
								<c:forEach var="role" items="${VO.roleList}">
									<c:if test="${role.PROLE_SEQ eq E.PROLE_SEQ}">
										<option value="${role.ROLE_SEQ}" 
											<c:if test="${role.ROLE_SEQ eq E.ROLE_SEQ}">										
												selected 
											</c:if>>
											${role.ROLE_NAME}
										</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
					</td>
					<td><input type="text" class="input is-small emp-position" value="${E.POSITION}"></td>
					<td><input type="text" class="input is-small emp-email"    value="${E.EMAIL}">   </td>
					<td>
						<a class="button is-warning modify-btn" <c:if test="${REQ.serverStatus.STATUS eq 0}">disabled</c:if>>수정</a>
						<a class="button is-danger  rm-btn" <c:if test="${REQ.serverStatus.STATUS eq 0}">disabled</c:if> >삭제</a>
					</td>
				</tr>
			</c:forEach>
		  </tbody>
	   </table><!-- #empTable END -->
	   </div>
	</div>
</body>

<script>
$(document).ready(function() {
	
	$(document).on('mouseenter', '#empTable > tbody > tr', function() {	
		$(this).addClass('is-selected');
	});
	
	$(document).on('mouseleave', '#empTable > tbody > tr', function() {
		$(this).removeClass('is-selected');
	});
	
	<%--
		사원 구분 값 변화에 따른 직위 Select Box 렌더링 함수
		@since 2019.07.03
	--%>
	$('.p-role-select').change(function() {
		var tr = $(this).closest('tr');
		var roleSelect = tr.find('.role-select');
		
		roleSelect.empty();
		
		var pRoleSeq = $(this).val();
		$('.role-select-list > option').filter( function(){
			if(pRoleSeq == $(this).data('p-role-seq')) return true; 
		}).each( function(){
			var el = $(this).clone().removeClass('is-hidden');
			roleSelect.append(el);
		})
	});
	
	<%--
		사원 구분 값 변화에 따른 [부서] Select Box 렌더링 함수
		@since 2019.07.03
	--%>
	$('.p-dept-select').change(function() {
		var tr = $(this).closest('tr');
		var roleSelect = tr.find('.dept-select');
		
		roleSelect.empty();
		
		var pRoleSeq = $(this).val();
		$('.dept-select-list > option').filter( function(){
			if(pRoleSeq == $(this).data('p-dept-seq')) return true; 
		}).each( function(){
			var el = $(this).clone().removeClass('is-hidden');
			roleSelect.append(el);
		})
	});
	
	<%-- 수정내역 등록 삭제 함수 --%>
	$('.modify-btn:not([disabled])').click(function(){
		var tr = $(this).closest('tr');
		var param = $.makeParam(tr);
		
		if(param.validFlag) {
			if(confirm('해당 정보로 사원을 수정하시겠습니까?')) {
				$.modifyEmp(param.data);	
			}
		} else {
			alert('공백이 값이 있습니다. 다시 확인해주세요');
		}
	});
	
	<%-- 수정내역 등록 삭제 함수 --%>
	$('.rm-btn:not([disabled])').click(function(){
		var tr = $(this).closest('tr');
		if(confirm('해당 정보로 사원을 삭제하시겠습니까?')) {
			$.removeEmp(tr);	
		}
	});
});


$.makeParam = function(tr) {
	var validFlag = true;
	
	// [1] 파라미터 세팅
	var data = {
		emp_seq      : tr.data('emp-no'),
		emp_name     : tr.find('.emp-name').val().trim(),
		emp_id       : tr.find('.emp-id').val().trim(),
		emp_pw       : tr.find('.emp-pw').val().trim(),
		emp_no       : tr.find('.emp-no').val().trim(),
		p_dept_seq   : tr.find('.p-dept-select').val().trim(),
		dept_seq     : tr.find('.dept-select').val().trim(),
		p_role_seq   : tr.find('.p-role-select').val().trim(),
		role_seq     : tr.find('.role-select').val().trim(),
		emp_position : tr.find('.emp-position').val().trim(),
		emp_email    : tr.find('.emp-email').val().trim(),
	}
	
	// [1-1] 공백 검증
	for( key in data ){
		if(data[key] === '') {
			validFlag = false;
		}
	}
	
	return {
		validFlag : validFlag,		
		data      : data
	}
}

<%--수정 내역 등록함수--%>
$.modifyEmp = function(param) {
	var RESTurl = '${HOME}/ADM/employee/edit';
	
	var data = {
		emp_seq      : param.emp_seq,
		emp_name     : param.emp_name,
		emp_id       : param.emp_id,
		emp_pw       : param.emp_pw,
		emp_no       : param.emp_no,
		p_dept_seq   : param.p_dept_seq,
		dept_seq     : param.dept_seq,
		p_role_seq   : param.p_role_seq,
		role_seq     : param.role_seq,
		emp_position : param.emp_position,
		emp_email    : param.emp_email,
	}
	console.log(data);
	$.ajax({
		type        : "POST",
		url         : RESTurl,
		data        : data,
		dataType    : "json",
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				alert('사원 정보가 정상적으로 변경되었습니다.');
				location.reload();
			} else {
				alert(result.REPL_MSG);
			}
		}
	});
	
}

<%-- 사원 삭제 함수--%>
$.removeEmp = function(tr) {
	var RESTurl = '${HOME}/ADM/employee/'+tr.data('emp-no');
	
	$.ajax({
		type        : "delete",
		url         : RESTurl,
		dataType    : "json",
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				alert('사원 정보가 정상적으로 삭제되었습니다.');
				location.reload();
			} else {
				alert(result.REPL_MSG);
			}
		}
	});
	
}

</script>
</html>