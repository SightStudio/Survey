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
	
	<!-- init JS -->
    <script src="${JS}/common/jquery/jquery-3.4.0.min.js"></script>
    <script src="${JS}/common/bulma-extensions.min.js"></script>
   
	<style>
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
				<p>사원 추가</p>
				<p>평가 상태 : [ ${REQ.serverStatus.STATUS_DESC} ]</p>
				<p></p>
			</div>
		</article>
		
		<c:if test="${REQ.serverStatus.STATUS eq 0}">
			<p class="title is-6 has-text-danger">평가 상태가 
				<span class="has-text-dark">[평가 준비]</span>인 경우에만 
				<span class="has-text-dark">[사원 추가]</span>
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
		
		<div class="container">
			<p class="has-text-right">
				<a class="button is-success is-outlined is-medium btn-submit" <c:if test="${REQ.serverStatus.STATUS eq 0}">disabled</c:if>>모두 추가하기</a>
			</p>
			<table id="empTable" class="table is-bordered is-size-7">
				<thead>
					<tr>
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
			
				<tbody data-name="tb-insert-employee" class="tb-insert-employee">
					<tr data-row="1">
						<td><input type="text" class="input is-small emp-name"></td>
						<td><input type="text" class="input is-small emp-id"></td>
						<td><input type="text" class="input is-small emp-pw"></td>
						<td><input type="text" class="input is-small emp-no"></td>
						
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
									<!-- rendered by js later -->
									<c:forEach var="dept" items="${VO.deptList}">
										<c:if test="${dept.PDEPT_SEQ eq E.PDEPT_SEQ}">
											<option data-p-dept-seq="${dept.PDEPT_SEQ}" value="${dept.DEPT_SEQ}"
												<c:if test="${dept.DEPT_SEQ eq E.DEPT_SEQ}">selected</c:if>
											>${dept.DEPT_NAME}</option>
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
									<!-- rendered by js later -->
									<c:forEach var="role" items="${VO.roleList}">
										<c:if test="${role.PROLE_SEQ eq E.PROLE_SEQ}">
											<option data-p-role-seq="${role.PROLE_SEQ}" value="${role.ROLE_SEQ}"
												<c:if test="${role.ROLE_SEQ eq E.ROLE_SEQ}">selected</c:if>
											>${role.ROLE_NAME}</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</td>
						<td><input type="text" class="input is-small emp-position"></td>
						<td><input type="text" class="input is-small emp-email"></td>
						<td>
							<a class="button is-link   is-small btn-add-row" <c:if test="${REQ.serverStatus.STATUS eq 0}">disabled</c:if>>추가</a>
							<a class="button is-danger is-small btn-rm-row"  <c:if test="${REQ.serverStatus.STATUS eq 0}">disabled</c:if>>삭제</a>
						</td>
					</tr>
				</tbody>		
			</table>
		</div>
	</div>
</body>
<script>
$(document).ready(function() {
	<%--
		사원 구분 값 변화에 따른 [직위] Select Box 렌더링 함수
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
	
	<%-- 
		행 추가 함수 
		@since 2019.07.03	
	--%>
	$(document).on('click', '.btn-add-row:not([disabled])', function() {
		var row = $(this).closest('tr');
		var rowNum = row.data('row');
		var newRow = row.clone();
		
		newRow.attr('data-row', parseInt(rowNum)+1);
		row.closest('tbody').append(newRow);
		$(this).addClass('is-hidden');
	});
	
	<%-- 
		행 삭제 함수
		@since 2019.07.03 
	--%>
	$(document).on('click', '.btn-rm-row:not([disabled])', function() {
		var row   = $(this).closest('tr');
		var tbody = row.closest('tbody');
		var tbodySelector = '.'+tbody.data('name');
		var trListEl = tbody.find('tr');
		
		if(trListEl.length != 1) {
			row.remove();
			trListEl=$(tbodySelector).find('tr');
			$.reOrderRow(trListEl);
		}
		
		trListEl.last()
				.find('.btn-add-row')
				.removeClass('is-hidden');
	});
	
	<%-- 수정내역 등록 함수 --%>
	$('.btn-submit:not([disabled])').click( function() {
		var param = $.makeParam();
		if(param.validFlag) {
			if(confirm('해당 정보로 사원을 추가하시겠습니까?')) {
				$.submitEmpList(param.data);	
			}
		} else {
			alert('공백이 값이 있습니다. 다시 확인해주세요');
		}
		
	});
});

<%--각 시트의 data-row 순서 재설정 함수--%>
$.reOrderRow = function(trListEl) {
	trListEl.each(function(idx){
		$(this).attr('data-row', idx+1);
	});
}


$.makeParam = function() {
	var tbody   = $('.tb-insert-employee');
	var empList = [];
	var validFlag = true;
	
	// [1] 공통 평가지 세팅
	tbody.find('tr').each(function(idx) {
		var el = $(this);
		var data = {
			emp_name     : el.find('.emp-name').val().trim(),
			emp_id       : el.find('.emp-id').val().trim(),
			emp_pw       : el.find('.emp-pw').val().trim(),
			emp_no       : el.find('.emp-no').val().trim(),
			p_dept_seq   : el.find('.p-dept-select').val().trim(),
			dept_seq     : el.find('.dept-select').val().trim(),
			p_role_seq   : el.find('.p-role-select').val().trim(),
			role_seq     : el.find('.role-select').val().trim(),
			emp_position : el.find('.emp-position').val().trim(),
			emp_email    : el.find('.emp-email').val().trim(),
		}
		
		// [1-1] 공백 검증
		for( key in data ){
			if(data[key] === '') {
				validFlag = false;
			}
		}
		empList.push(data);
	});
	
	return {
		validFlag : validFlag,		
		data : {
			empList : JSON.stringify(empList)
		}
	}
}

<%--수정 내역 등록함수--%>
$.submitEmpList = function(param) {
	var RESTurl = '${HOME}/ADM/employee/register';
	var data = {
		empList : param.empList		
	}
	
	$.ajax({
		type        : "POST",
		url         : RESTurl,
		data        : data,
		dataType    : "json",
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				alert('사원이 정상적으로 추가되었습니다');
				location.href='${HOME}/ADM/employee/list'
			} else {
				alert(result.REPL_MSG);
			}
		}
	});
	
}
</script>
</html>