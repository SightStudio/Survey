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
		table tr.is-selected { background-color : rgba(32, 156, 238, 0.72) !important}
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
				<p>피평가자 지정</p>
				<p>평가 상태 : [ ${REQ.serverStatus.STATUS_DESC} ]</p>
				<p></p>
			</div>
		</article>
		
		<c:if test="${REQ.serverStatus.STATUS eq 0}">
			<p class="title is-6 has-text-danger">평가 상태가 
				<span class="has-text-dark">[평가 준비]</span>인 경우에만
				<span class="has-text-dark">[피평가자 지정]</span>
			를 할 수 있습니다.</p>
		</c:if>
		
		<div class="level">
			<div class="container">
				<p><a href="${HOME}/ADM/index" class="button">전체 목록으로 돌아가기</a></p><br>
				<p class="title is-5 is-marginless">
					${VO.employee.NAME} [${VO.employee.SUPER_ROLE_NAME}]님 피평가자 목록
				</p>
			</div>
			
			<div class="container">
				<nav class="breadcrumb has-succeeds-separator is-right" aria-label="breadcrumbs">
				  <ul>
				    <li><a>${VO.employee.SUPER_DEPT_NAME}</a></li>
				    <li><a>${VO.employee.DEPT_NAME }</a></li>
				  </ul>
				  <ul>
				    <li><a>${VO.employee.SUPER_ROLE_NAME }</a></li>
				    <li><a>${VO.employee.ROLE_NAME }</a></li>
				    <li><a>${VO.employee.NAME }</a></li>
				  </ul>
				</nav>
				
				<p class="buttons is-right">
					<a class="button btn-modify" <c:if test="${REQ.serverStatus.STATUS eq 0}">disabled</c:if> >수정하기</a>
				</p>
			</div>
		</div> <!-- .level END -->
		
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
		      <th>선택</th>
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
		      <th>선택</th>
		    </tr>
		  </tfoot>
		  <tbody>
			<!-- AJAX HTML HERE -->
		  </tbody>
	   </table><!-- #empTable END -->
	   </div>
	</div>
</body>

<script>
$(document).ready(function() {
	
	// 피평가자  목록을 가져오기
	$.getEmpList();
	
	$(document).on('mouseenter', '#empTable > tbody > tr', function() {	
		$(this).addClass('is-selected');
	});
	
	$(document).on('mouseleave', '#empTable > tbody > tr', function() {
		$(this).removeClass('is-selected');
	});
	
	<%-- 수정내역 등록 삭제 함수 --%>
	$('.btn-modify:not([disabled])').click(function(){
		
		var table = $('#empTable');
		var checkBoxList = table.find('.emp-no-switch:checked');
		var subjectList = [];
		
		// 피평가자 seq 리스트 세팅
		checkBoxList.each(function(){
			subjectList.push({ subject_seq : $(this).closest('tr').data('no') });	
		})
		
		var data = { 
			writer_seq : '${VO.employee.NO}',
			subjectSeqList : JSON.stringify(subjectList)
		}
		
		$.modifySubject(data);
	});
});

<%--
	피평가자  목록을 가져와서 렌더링 하기
	@since  2019.05.13
--%>
$.getEmpList = function() {

	var RESTurl = '${HOME}/ADM/subject/${VO.employee.NO}/detail';
	
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
	피평가자  목록을 렌더링 하는  함수
	@since  2019.05.13
--%>
$.renderEmpList = function(empList) {
	
	var empTable = $('#empTable');
	var empTbody = $('#empTable').find('tbody');
	var renderHTML = [];
	
	var getCheckSwitch = 
		function(no , isChecked) {
			var switchID = 'switch-emp-'+no;
			isChecked == true ?  isChecked='checked="checked"' : isChecked='' 
			var switchEL = 
				'<div class="field">                                             ' + 
			    '  <input id="'+switchID+'" type="checkbox" name="'+switchID +'" ' +
			    '         class="emp-no-switch switch" '+isChecked+'>      ' + 
			    '  <label for="'+switchID+'"></label>                            ' + 
				'</div>															 '  
			
			return switchEL;
		}
	
	// [1] 테이블 내용 제거
	empTbody.empty();
	
	// [2] 결과 렌더링 DOM 생성
	empList.forEach( function(emp) {
		renderHTML.push(
			'<tr data-no="'+emp.NO                      +'">',
			'    <th>'+ emp.NO                             +'</td>',
			'    <th>'+ emp.NAME                           +'</th>',
			'    <td>'+ emp.EMP_NO                         +'</td>',
			'    <td>'+ emp.SUPER_DEPT_NAME                +'</td>',
			'    <td>'+ emp.DEPT_NAME                      +'</td>',
			'    <td>'+ emp.ROLE_NAME                      +'</td>',
			'    <td>'+ emp.POSITION                       +'</td>',
			'    <td>'+ emp.SUPER_ROLE_NAME                +'</td>',
			'    <td>'+ (emp.WRITER_SEQ == undefined ? getCheckSwitch(emp.NO, false) :  getCheckSwitch(emp.NO, true)) +'</td>',
			'</tr>'
		);
	});
	
	empTbody.append(renderHTML.join(''));
}

<%--
	피평가자  목록을 수정하는 함수
	@since  2019.05.13
--%>
$.modifySubject = function(data) {
	var RESTurl = '${HOME}/ADM/subject/${VO.employee.NO}';
	
	$.ajax({
		type        : "POST",
		url         : RESTurl,
		data        : data,
		dataType    : "json",
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				alert('피평가자 설정이 완료되었습니다')
				location.href='${HOME}/ADM/index'
			} else {
				alert(result.REPL_MSG);
			}
		}
	});
}

</script>
</html>