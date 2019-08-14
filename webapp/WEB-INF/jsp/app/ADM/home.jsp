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
	<link rel="stylesheet" href="${CSS}/common/init/bulma.min.css"/>
	<link rel="stylesheet" href="${CSS}/common/init/bulma-extensions.min.css" />
	
	<!-- init JS -->
    <script src="${JS}/common/jquery/jquery-3.4.0.min.js"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
    
     <style>
    	table tr.is-selected { background-color : rgba(32, 156, 238, 0.72) !important}
    	#empTable > tbody > tr{ cursor: pointer; }
    	#empTable tr th, #empTable tr td {vertical-align: middle; text-align: center !important;}
    	#evaluate-modal .modal-card, .modal-content{ width: 1280px; }
    	#unevaluate-table td, #unevaluate-table th { text-align : center; }
    </style>
</head>
<body>
	<c:set var="VO"  value="${response}" />
	<c:set var="REQ" value="${request}"  />
	
	<div class="container is-fluid">
	
		<%-- HEADER 영역 START --%>
		<%@ include file="../../common/ADM_HEADER.jsp" %>
		<%-- HEADER 영역 END --%>
		
		<article class="message">
			<div class="message-header">
				<p>사원 목록 / 피평가자 등록</p>
				<p>평가 상태 : [ ${REQ.serverStatus.STATUS_DESC} ]</p>
				<a class="button is-small" id="btn-start-modal">설문 시작</a>
			</div>
		</article>
		
		<div class="level">
			<p class="title is-5 is-marginless"> 클릭하여 피평가자 지정 </p>
			<p class="button is-small is-warning is-size-6 has-text-weight-bold tooltip is-tooltip-bottom" 
			   id   ="btn-evaluate-modal"
			   data-tooltip="평가되지 않은 내역을 확인합니다."> 미평가 인원 확인 </p>
		</div>
		
		<table id="empTable" class="table is-pulled-left">
			<thead>
				<tr>
					<th>No</th>
					<th>이름</th>
					<th>사번</th>
					<th>상위부서</th>
					<th>부서명</th>
					<th>직위</th>
					<th>직책</th>
					<th>사원구분</th>
					<th>이메일</th>
					<th>피평가자 지정여부</th>
					<th>해당 사원 평가자수</th>
				</tr>
			</thead>
			<tfoot>
		  		<tr>
					<th>No</th>
					<th>이름</th>
					<th>사번</th>
					<th>상위부서</th>
					<th>부서명</th>
					<th>직위</th>
					<th>직책</th>
					<th>사원구분</th>
					<th>이메일</th>
					<th>피평가자 지정여부</th>
					<th>해당 사원 평가자수</th>
		  		</tr>
			</tfoot>
			<tbody>
				<!-- AJAX HTML HERE -->
			</tbody>
	   </table>
	</div> <!-- .container end -->
	
	
	<%-- 평가 상태 MODAL START --%>
	<div class="modal" id="start-modal">
		<div class="modal-background"></div>
		
		<div class="modal-card">
			<header class="modal-card-head">
				<p class="modal-card-title">평가 시작</p>
				<button class="delete" aria-label="close"></button>
			</header>
			
			<section class="modal-card-body">
				<div class="conatiner">
					<p class="title is-6">현재 평가 상태 : [ ${REQ.serverStatus.STATUS_DESC} ]</p>
					<article class="message">
						<div class="message-body">
					    	<strong class="has-text-danger">경고) 서버상태를 <a class="has-text-dark">평가 준비</a>에서 <a class="has-text-dark">평가 진행중</a>으로 변경합니다</strong><br>
					    	평가 시작가 시작되면 설문지 내용, 피평가자 설정 상태, 사원 정보를 변경할 수 없습니다. 
					    	<br>설문지 및 피평가자 상태를 변경하려면 상단 헤더에서 <strong><a>[질문-응답 현황]</a></strong>에서 <strong><a>[평가 초기화]</a></strong>를 실행해야합니다.
					    	<br><br>
					    	위 내용에 동의하며, 평가지를 시작려면 <br>
					    	아래의 입력란에
					    	<strong class="has-text-danger"><a>동의합니다</a></strong>
							라고 입력하여 주십시오
						</div>
					</article>
					<input type="text" id="agree-confirm" class="input is-danger">
					<a id="survey-start-btn" class="button is-danger has-text-weight-bold is-fullwidth" disabled>평가 시작</a>
				</div>
			</section>
			
			<footer class="modal-card-foot has-text-right">
			</footer>
		</div> <!-- .modal-card END -->
	</div><!-- #reset-modal END -->
	<%-- 평가 상태 MODAL END --%>
	
	<%-- 미평가인원 확인 MODAL START --%>
	<div class="modal" id="evaluate-modal">
		<div class="modal-background"></div>
		
		<div class="modal-card">
			<header class="modal-card-head">
				<p class="modal-card-title">미평가자 내역</p>
				<button class="delete" aria-label="close"></button>
			</header>
			
			<section class="modal-card-body">
				<table id="unevaluate-table" class="table is-fullwidth">
					<thead>
						<tr>
							<th colspan="4" style="width: 45%;">평가자</th>
							<th style="width: 10%;"></th>
							<th colspan="4" style="width: 45%;">피평가자</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			
			</section>
			
			<footer class="modal-card-foot has-text-right">
			</footer>
		</div> <!-- .modal-card END -->
	</div><!-- #reset-modal END -->
	<%-- 미평가인원 확인 MODAL END --%>
</body>
<script>
$(document).ready(function() {
	
	// 사원 목록 렌더링
	$.getEmpList();
	
	$(document).on('mouseenter', '#empTable > tbody > tr', function() {	
		$(this).addClass('is-selected');
	});
	$(document).on('mouseleave', '#empTable > tbody > tr', function() {
		$(this).removeClass('is-selected');
	});
	
	<%--사원 피평가자 적용현황 조회로 이동--%> 
	$(document).on('click', '#empTable > tbody > tr', function() {
		location.href='${HOME}/ADM/subject/'+$(this).data('no');
	});
	
	<%-- [ 설문상태 초기화 모달 ] 열고닫기 이벤트 START --%>
	var startModal = $('#start-modal') ;
	startModal.find('.modal-background').click( function(){ startModal.removeClass('is-active');})
	startModal.find('.delete').click( function(){ startModal.removeClass('is-active');})
	$('#btn-start-modal').click( function() { startModal.addClass('is-active'); });
	<%-- [ 설문상태 초기화 모달 ] 열고닫기 이벤트 END --%>
	
	<%-- 리셋 최종 확인 검증 이벤트 --%>
	$('#agree-confirm').on('keyup keydown', function(){
		var input = $(this).val(); 
		input == '동의합니다' ? $('#survey-start-btn').removeAttr('disabled') 
						   : $('#survey-start-btn').attr('disabled','')
	})
	
	<%--최종 리셋 이벤트--%>
	$(document).on('click', '#survey-start-btn:not([disabled])', function(){
		if(confirm('평가를 시작하시겠습니까?')) {
			$.startSurvey();			
		}
	})
	
	<%-- [ 설문상태 초기화 모달 ] 열고닫기 이벤트 START --%>
	var evaluate = $('#evaluate-modal') ;
	evaluate.find('.modal-background').click( function() { evaluate.removeClass('is-active'); })
	evaluate.find('.delete').click( function() { evaluate.removeClass('is-active');})
	$('#btn-evaluate-modal').click( function() { 
		evaluate.addClass('is-active');
		$.getUnEvaluateList();
		
	});
	<%-- [ 설문상태 초기화 모달 ] 열고닫기 이벤트 END --%>
});

<%--
	사원 목록 가져오는  함수
	@since  2019.05.13
--%>
$.getEmpList = function() {

	var RESTurl = '${HOME}/ADM/subject/all';
	var returnArr = [];
	
	$.ajax({
		type : "GET",
		url : RESTurl,
		dataType : "json",
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				$.renderEmpList(result.empList);
			} else {
				alert(result.REPL_CD);
			}
		}
	});
}

<%--
	사원 목록을 렌더링 하는  함수
	@since  2019.05.13
--%>
$.renderEmpList = function(empList) {
	
	var empTable = $('#empTable');
	var empTbody = $('#empTable').find('tbody');
	var renderHTML = [];
	
	// [1] 테이블 내용 제거
	empTbody.empty();
	
	// [2] 결과 렌더링 DOM 생성
	empList.forEach( function(emp) {
		renderHTML.push(
			'<tr data-no="'+emp.NO+'">',
			'    <th>'+ emp.NO                           				     +'</td>',
			'    <th>'+ emp.NAME                          					 +'</th>',
			'    <td>'+ emp.EMP_NO                        					 +'</td>',
			'    <td>'+ emp.SUPER_DEPT_NAME               					 +'</td>',
			'    <td>'+ emp.DEPT_NAME                     					 +'</td>',
			'    <td>'+ emp.ROLE_NAME                     					 +'</td>',
			'    <td>'+ emp.POSITION                      					 +'</td>',
			'    <td>'+ emp.SUPER_ROLE_NAME               					 +'</td>',
			'    <td>'+ emp.EMAIL                         					 +'</td>',
			'    <td>'+ (emp.SUBJECT_CNT > 0 ? 'Y / '+emp.SUBJECT_CNT : 'N') +'</td>',
			'    <td>'+ emp.WRITER_CNT +'</td>',
			'</tr> '
		);
	});
	
	empTbody.append(renderHTML.join(''));
}

$.startSurvey = function() {
	var RESTurl = '${HOME}/ADM/startSurvey'
	$.ajax({
		type : "POST",
		url : RESTurl,
		dataType : "json",
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				alert('정보) 평가가 시작되었습니다.')
				location.reload();
			} else {
				alert(result.REPL_MSG);
			}
		}
	});
}

$.getUnEvaluateList = function() {
	var RESTurl = '${HOME}/ADM/unevaluate'
	$.ajax({
		type : "GET",
		url : RESTurl,
		dataType : "json",
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				$.renderUnEvaluateList(result.unEvalutedList) 
			} else {
				alert(result.REPL_MSG);
			}
		}
	});
}

$.renderUnEvaluateList = function(dataList) {
	var unevalTable = $('#unevaluate-table');
	var tbody = unevalTable.find('tbody');
	var renderHTML = [];
	
	// [1] 테이블 내용 제거
	tbody.empty();
	
	// [2] 결과 렌더링 DOM 생성
	dataList.forEach( function(el) {
		renderHTML.push(
			'<tr data-writer-seq="'+el.WRITER_SEQ+'" data-suject-seq="'+el.SUBJECT_SEQ+'">',
			'    <td>'+ el.WRITER_EMP_NO           +'</td>',
			'    <th>'+ el.WRITER_NAME             +'</th>',
			'    <td>'+ el.WRITER_P_DEPT_NAME      +'</td>',
			'    <td>'+ el.WRITER_DEPT_NAME        +'</td>',
			'    <td> 									  ',
			'		<span class="icon">					  ',
			'			<i class="fas fa-arrow-right"></i>',
			'		</span>								  ',
			'	 </td>									  ',
			'    <td>'+ el.SUBJECT_EMP_NO          +'</td>',
			'    <th>'+ el.SUBJECT_NAME            +'</th>',
			'    <td>'+ el.SUBJECT_P_DEPT_NAME     +'</td>',
			'    <td>'+ el.SUBJECT_DEPT_NAME       +'</td>',
			'</tr> '
		);
	});
	
	tbody.append(renderHTML.join(''));
}
</script>
</html>