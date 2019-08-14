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
		.table thead th, .table thead td {vertical-align: middle; text-align: center !important; border: 1px solid #000 !important;}
		.table tbody th, .table tbody td {vertical-align: middle; text-align: center !important; border: 1px solid #000 !important;}
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
				<p>질문지 평가 현황</p>
				<p>평가 상태 : [ ${REQ.serverStatus.STATUS_DESC} ]</p>
				
				<p>
					<a class="button is-small" id="btn-reset-modal">평가 초기화</a>
					<a class="button is-small tooltip is-tooltip-bottom" 
					   id="btn-excel-download"
					   data-tooltip="시간이 다소 걸릴 수 있습니다.">엑셀 다운로드</a>
				</p>
			</div>
		</article>
		
		<div class="container">
			<table class="table is-bordered is-striped is-hoverable is-size-7">
				<thead>
					<tr>
						<th style="width:7%;"  rowspan="4">부서명</th>
						<th style="width:7%;"  rowspan="4">사번</th>
						<th style="width:5%;"  rowspan="4">이름</th>
						<th style="width:3%;"  rowspan="4">사유</th>
						<th style="width:8%;"  rowspan="4">직위</th>
						<th style="width:8%;"  rowspan="4">직책</th>
						<th style="width:30%;" colspan="4">공통 : 전직원</th>
						<th style="width:30%;" colspan="4">사무직 / 생산직 구분</th>
					</tr>
					
					<tr>
						<th colspan="4">1) 규범준수</th>
						<th colspan="4">2) 업무수행</th>
					</tr>
					<tr>
						<td style="width: 7%;" rowspan="2">예</td>
						<td style="width: 7%;" rowspan="2">아니요</td>
						<td style="width: 7%;" rowspan="2">예</td>
						<td style="width: 7%;" rowspan="2">아니요</td>
						<td style="width: 8%;">미흡</td>
						<td style="width: 8%;">보통</td>
						<td style="width: 8%;">우수</td>
						<td style="width: 8%;">탁월</td>
					</tr>
					
					<tr>
						<td>기대수준에 미치지 못함</td>
						<td>기대수준을 충족시킴</td>
						<td>일부 기대수준을 뛰어넘음</td>
						<td>모든 기대수준을 상회하며 매우우수</td>
					</tr>
				</thead>
			
				<tbody>
					<c:forEach var="S" items="${VO.statisticList}" varStatus="s_stat">
					<tr data-emp-seq="${S.EMP_SEQ}" data-emp-name="${S.EMP_NAME}">
						<td>${S.DEPT_NAME}</td>
						<td>${S.EMP_NO}</td>
						<th>${S.EMP_NAME}</th>
						<td>
							<c:choose>
								<c:when test="${S.EXCUSE_CNT eq 0}">
									<span class="tag is-dark is-rounded">${S.EXCUSE_CNT}</span>
								</c:when>
								
								<c:otherwise>
									<span class="tag is-info is-rounded btn-openable">${S.EXCUSE_CNT}</span>
								</c:otherwise>
							</c:choose>
						</td>
						<td>${S.ROLE_NAME}</td>
						<td>${S.EMP_POSITION}</td>
						<td>${S.IS_YES}개</td>
						<td>${S.IS_NO}개</td>
						<td>${S.IS_YES_PERCENT}%</td>
						<td>${S.IS_NO_PERCENT}%</td>
						<td>${S.IS_1}개 ( ${S.IS_1_PERCENT}% )</td>
						<td>${S.IS_2}개 ( ${S.IS_2_PERCENT}% )</td>
						<td>${S.IS_3}개 ( ${S.IS_3_PERCENT}% )</td>
						<td>${S.IS_4}개 ( ${S.IS_4_PERCENT}% )</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div><!-- .container END -->
	</div><!-- body .container END -->
	
	<!-- MODAL 영역 -->
	<div class="modal" id="excuse-modal">
		<div class="modal-background"></div>
		
		<div class="modal-card">
			<header class="modal-card-head">
				<p class="modal-card-title">미준수 사유 조회(<span class="is-size-5" id="modal-target-name"></span>)</p>
				<button class="delete" aria-label="close"></button>
			</header>
			
			<section class="modal-card-body">
				<div class="conatiner">
					<p class="title is-6">1번)</p>
					<textare class="textarea readonly"></textare>
					<br>
				</div>
				
				<div class="conatiner">
					<p class="title is-6">2번)</p>
					<textare class="textarea readonly"></textare>
				</div>
			</section>
			
			<footer class="modal-card-foot has-text-right">
				<button class="button btn-close">닫기</button>
			</footer>
		</div> <!-- .modal-card END -->
	</div><!-- #excuse-modal END -->
	
	<!-- MODAL 영역 -->
	<div class="modal" id="reset-modal">
		<div class="modal-background"></div>
		
		<div class="modal-card">
			<header class="modal-card-head">
				<p class="modal-card-title">평가 초기화</p>
				<button class="delete" aria-label="close"></button>
			</header>
			
			<section class="modal-card-body">
				<div class="conatiner">
					<p class="title is-6">현재 평가 상태 : [ ${REQ.serverStatus.STATUS_DESC} ]</p>
					<article class="message">
						<div class="message-body">
					    	<strong class="has-text-danger">경고) 서버상태를 <a class="has-text-dark">평가 진행</a>에서 <a class="has-text-dark">평가 준비</a>로 변경합니다</strong><br>
					    	평가 초기화를 누를 경우, 모든 평가지 데이터 및 피평가자 지정상태가  초기화됩니다. 기존 질문 내역데이터는 복구가 불가능하며, 
					    	<br><a>이 결정은 되돌릴 수 없습니다.</a>
					    	<br><br>
					    	위 내용에 동의하며, 평가지를 초기화려면 <br>
					    	아래의 입력란에
					    	<strong class="has-text-danger"><a>동의합니다</a></strong>
							라고 입력하여 주십시오
						</div>
					</article>
					<input type="text" id="agree-confirm" class="input is-danger">
					<a id="survey-reset-btn" class="button is-danger has-text-weight-bold is-fullwidth" disabled>평가 초기화 시작</a>
				</div>
			</section>
			
			<footer class="modal-card-foot has-text-right">
			</footer>
		</div> <!-- .modal-card END -->
	</div><!-- #reset-modal END -->
</body>

<script>
$(document).ready(function() {
	
	<%-- 마우스 호버 액션 START --%>
	$('.btn-openable').closest('tr').on('mouseenter', function() {	
		$(this).addClass('is-selected');
	});
	$('.btn-openable').closest('tr').on('mouseleave', function() {
		$(this).removeClass('is-selected');
	});
	<%-- 마우스 호버 액션 END --%>
	
	
	<%--[ 질문자 세부 설문내용 모달 ] 열고 닫기 이벤트 START --%>
	var modal = $('#excuse-modal');
	modal.find('.modal-background').click( function(){ modal.removeClass('is-active');})
	modal.find('.btn-close').click( function(){ modal.removeClass('is-active');})
	modal.find('.delete').click( function(){ modal.removeClass('is-active'); })
	
	$('.btn-openable').closest('tr').click( function() {
		$.getExcuseList(modal, $(this).data('emp-seq'), $(this).data('emp-name'));
		modal.addClass('is-active');
	});
	<%--[ 질문자 세부 설문내용 모달 ] 열고 닫기 이벤트 START --%>
	
	<%-- [ 설문상태 초기화 모달 ] 열고닫기 이벤트 START --%>
	var resetModal = $('#reset-modal') ;
	resetModal.find('.modal-background').click( function(){ resetModal.removeClass('is-active');})
	resetModal.find('.delete').click( function(){ resetModal.removeClass('is-active');})
	$('#btn-reset-modal').click( function() {
		resetModal.addClass('is-active');
	});
	<%-- [ 설문상태 초기화 모달 ] 열고닫기 이벤트 END --%>
	
	<%-- 리셋 최종 확인 검증 이벤트 --%>
	$('#agree-confirm').on('keyup keydown', function(){
		var input = $(this).val(); 
		input == '동의합니다' ? $('#survey-reset-btn').removeAttr('disabled') 
						   : $('#survey-reset-btn').attr('disabled','')
	})
	
	<%--최종 리셋 이벤트--%>
	$(document).on('click', '#survey-reset-btn:not([disabled])', function(){
		if(confirm('설문 상태를 초기화 하시겠습니까?')) {
			$.resetSurvey();			
		}
	})
	
	$('#btn-excel-download').click(function() {
		$.getStatisticsInExcel();
	})
});

<%--
	미준수 사유 목록 가져와서 팝업에 렌더링 하는 함수
	@since  2019.05.13
--%>
$.getExcuseList = function(modalEL, EMP_SEQ, EMP_NAME) {

	var RESTurl = '${HOME}/ADM/statistics/excuseList/'+EMP_SEQ;
	
	$.ajax({
		type : "GET",
		url : RESTurl,
		dataType : "json",
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				$.renderExcuseList(modalEL, EMP_NAME, result.excuseList);
			} else {
				alert(result.REPL_CD);
			}
		}
	});
}

$.renderExcuseList = function(modalEL, EMP_NAME, excuseList) {
	modalEL.find('#modal-target-name').text(EMP_NAME);
	var modalBody = modalEL.find('.modal-card-body');
	var renderHTML = [];
	
	modalBody.empty();
	
	excuseList.forEach( function(excuse, idx) {
		renderHTML.push(
			'<div class="conatiner">',
			'    <p class="title is-6">'+(idx+1)+'번) '+excuse.WRITER_NAME+'['+excuse.WRITER_EMP_NO+']'+'</p>',
			'    <textare class="textarea readonly" rows="10">'+excuse.SURVEY_EXCUSE+'</textare>',
			'    <br>',
			'</div>'
		);
	});

	modalBody.append(renderHTML.join(''));
}

$.resetSurvey = function() {
	
	var RESTurl = '${HOME}/ADM/statistics/resetAll'
	
	$.ajax({
		type : "DELETE",
		url : RESTurl,
		dataType : "json",
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				alert('정보) 서버 상태가 초기화 되었습니다.')
				location.href='${HOME}/ADM/index'
			} else {
				alert(result.REPL_CD);
			}
		}
	});
}

$.getStatisticsInExcel = function() {
	
	var form = $('<form></form>');
	var league_seq =  $('#bottom_league_seq').val();
	
	form.attr('action', '${HOME}/ADM/statistics/downExcel/statistics.xlsx');
	form.attr('method', 'POST');
	form.appendTo('body');
	
	form.submit();
	form.remove();
}
</script>
</html>