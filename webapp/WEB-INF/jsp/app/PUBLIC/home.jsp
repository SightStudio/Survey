<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 로그인 확인  --%>
<c:if test="${empty USER}">
	<script> location.href = '${HOME}/PUBLIC/login' </script>
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
    
     <style>
    	table tr.is-selected { background-color : rgba(32, 156, 238, 0.72) !important}
    	#empTable > tbody > tr.is-available{cursor: pointer;}
    	#empTable tr th, #empTable tr td {vertical-align: middle; text-align: center !important;}
    </style>
</head>
<body>
	<div class="container is-fluid">
		
		<c:set var="REQ" value="${request}" />
		
		<%-- HEADER 영역 START --%>
		<%@ include file="../../common/PUBLIC_HEADER.jsp" %>
		<%-- HEADER 영역 END --%>
		
		<input type="hidden" id="server-status" value="${REQ.serverStatus.STATUS}" />
		
		<article class="message">
			<div class="message-header">
				<p>평가 대상</p>
				<p>평가 상태 : [ ${REQ.serverStatus.STATUS_DESC} ]</p>
				<p></p>
			</div>
		</article>
		
		<c:if test="${REQ.serverStatus.STATUS eq 1}">
			<p class="title is-6 has-text-danger">평가 상태가 [ 평가 진행 중 ]일 경우만 시작할 수 있습니다. 관리자에게 문의해주세요</p>
		</c:if>
		
		<p class="title is-5"> 평가 대상 목록 </p>
		<table id="empTable" class="table">
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
		      <th>평가 여부</th>
		    </tr>
		  </thead>
		  <tbody>
			<!-- AJAX HTML HERE -->
		  </tbody>
	  </table>
	</div>
</body>

<script>
$(document).ready(function() {
	
	// 피평가자 목록 렌더링
	$.getSubjectList();
	
	$(document).on('mouseenter ', '#empTable > tbody > tr.is-available.active', function() {	
		$(this).addClass('is-selected');
	});
	
	$(document).on('mouseleave ', '#empTable > tbody > tr.is-available.active', function() {
		$(this).removeClass('is-selected');
	});
	
	$(document).on('click', '#empTable > tbody > tr.is-available.active', function() {

		var p_role_seq       = $(this).data('p-role-seq');
		var asso_survey_seq = $(this).data('asso-mapping-seq');
		var subject_seq      = $(this).data('no');
		
		location.href='${HOME}/PUBLIC/survey/register/'+asso_survey_seq+'/'+p_role_seq+'/'+subject_seq;
	});
});

<%--
	피평가자 목록 가져오는  함수
	@since  2019.05.13
--%>
$.getSubjectList = function() {

	var RESTurl = '${HOME}/PUBLIC/subjectList/${USER.NO}';
	var returnArr = [];
	
	$.ajax({
		type : "GET",
		url : RESTurl,
		dataType : "json",
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				$.renderEmpList(result.subjectList);					
			} else {
				alert(result.REPL_MSG);
			}
		}
	});
}

<%--
	피평가자 목록을 렌더링하는 함수
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
		var serverStatus = $('#server-status').val() == 0 ? 'active' : 'disabled'
		
		var btnStatus = emp.IS_SURVEY_FINISHED == 'N' 
					 ? '<a class="button is-info"'+serverStatus+'>평가 시작</a>'
					 : '<a class="button disabled has-background-grey-light">평가 완료</a>';
		
		var isAvailable = emp.IS_SURVEY_FINISHED == 'N' ? 'is-available' : '';
					 
		renderHTML.push(
			'<tr class="'+isAvailable+' '+serverStatus+'" data-asso-mapping-seq="'+emp.ASSO_SURVEY_SEQ+'"'+
			'	 		  				 data-no="'+emp.NO+'"'                            +
			'	 		  				 data-role-seq="'+emp.ROLE_SEQ+'"'                + 
			'	 		  				 data-p-role-seq="'+emp.P_ROLE_SEQ+'">',
			'    <th>'+ emp.NO              +'</td>',
			'    <th>'+ emp.NAME            +'</th>',
			'    <td>'+ emp.EMP_NO          +'</td>',
			'    <td>'+ emp.SUPER_DEPT_NAME +'</td>',
			'    <td>'+ emp.DEPT_NAME       +'</td>',
			'    <td>'+ emp.ROLE_NAME       +'</td>',
			'    <td>'+ emp.POSITION        +'</td>',
			'    <td>'+ emp.SUPER_ROLE_NAME +'</td>',
			'    <td>'+ emp.EMAIL           +'</td>',
			'    <td>'+ btnStatus           +'</td>',
			'</tr>'
		);
	});
	
	empTbody.append(renderHTML.join(''));
}

</script>
</html>