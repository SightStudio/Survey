<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    
    <style>
    	#require-modal .modal-content { width : 1450px !important } 
    	.table tr th, .table tr td {vertical-align: middle; text-align: center !important; border: 1px solid #000 !important;}
    	label.radio {width: 100%;}
    </style>
</head>
<body>
	
	<c:set var="VO" value="${response}" />
	
	<div class="container is-fluid">
	
		<%-- HEADER 영역 START --%>
		<%@ include file="../../../common/ADM_HEADER.jsp" %>
		<%-- HEADER 영역 END --%>
		
		<section class="section">
			<div class="container">
			
				<article class="message">
					<div class="message-header level">
						<p>다면 평가표 미리보기</p>
						<a class="button btn-open-modal">▣ 직무역량 요구 사항 보기</a>
					</div>
				</article>
				
				<div class="box questionList">
					<div class="level">
						<div class="container">
							<p class="title is-3 is-marginless">평가지 작성 </p>
						</div>
							
						<nav class="breadcrumb has-succeeds-separator is-right" aria-label="breadcrumbs">
						  <ul>
						    <li><a></a></li>
						    <li><a></a></li>
						  </ul>
						  <ul>
						    <li><a></a></li>
						    <li><a></a></li>
						    <li><a></a></li>
						  </ul>
						</nav>
					</div> <!-- .level END -->
					
					<div class="notification has-text-weight-bold is-family-primary" style="color:#0000be;">
						평가의 공정성과 익명성을 보장하기 위해 다면평가 개별 최종 점수만 인사위원회에서 관리 합니다.
						타인에 대한 평가는 그분에게 많은 영향을 미치는 만큼 동료를 사랑하는 마음으로 솔직하고 진지하게 평가해주시기 바랍니다.
						여러분이 하신 개별 평가내용은 절대평가로 철저한 비밀이 보장됩니다. 
					</div>
					
					<%-- 테스트 레이아웃 [공통] 시작 --%>
					<div class="common-q-table">
						<p class="title is-6">▶ Natura-way :  지속가능한 성과창출을 위해 나투라미디어인들이 준수하고 개발해야 할 행동양식과 필요한 역량  </p>
						<div class="level">
							<div class="container sheet-common">
								<table class="table t-common is-fullwidth is-bordered">
									<thead>
										<tr>
											<th class="has-background-grey-light" style="width:7%;">구분</th>
											<th class="has-background-grey-light" style="width:7%;">평가항목</th>
											<th class="has-background-grey-light" style="width:10%;">사원</th>
											<th class="has-background-grey-light" style="width:10%;">대리</th>
											<th class="has-background-grey-light" style="width:10%;">과장/차장</th>
											<th class="has-background-grey-light" style="width:10%;">팀장</th>
											<th class="has-background-grey-light" style="width:10%;">부문장</th>
											<th class="has-background-grey-light" style="width:15%;" colspan="2">평가 (규정 준수여부) </th>
										</tr>
									</thead>
									<tbody data-name="tb-common-sheet" class="tb-common-sheet">
										<c:forEach var="C" items="${VO.commonList}" varStatus="c_stat">
												<tr data-row-type="common" data-row="${c_stat.count}">
													<th class="title-depth-1 has-background-grey-light">${C.TITLE_DEPTH_1}</th>
													<th class="title-depth-2 has-background-grey-light">${C.TITLE_DEPTH_2}</th>
													<td colspan="5">${C.COL_1_DETAIL}</td>
													<td>
														<label class="radio"> 예 <input type="radio" name="common_radio_${c_stat.count}"></label>
													</td>
													<td>
														<label class="radio"> 아니요 <input type="radio" name="common_radio_${c_stat.count}"></label>
													</td>
												</tr>
										</c:forEach>
									</tbody>
								</table>
							</div><!-- .conatiner END -->
						</div><!-- .level end -->
						<p class="title is-6">→ 규범 미준수 시 징계대상자 회부, 구체적 사유 작성 (미준수 사유)</p>
						<textarea class="textarea" placeholder="사유를 구체적으로 작성해 주세요"></textarea>
					</div><!-- .common-q-table -->
					<%-- 테스트 레이아웃 [공통] 끝 --%>
					
					<%-- 테스트 레이아웃 [사무직] 시작--%>
					<br>
					<div class="conatiner sheet-office">
						<p class="title is-5">1) 사무직 평가지</p>
						<table class="table t-office is-fullwidth is-bordered">
							<thead>
								<tr>
									<th class="has-background-grey-light" style="width:5%;"  rowspan="2">구분</th>
									<th class="has-background-grey-light" style="width:8%;"  rowspan="2">평가항목</th>
									<th class="has-background-grey-light" style="width:10%;" rowspan="2">사원</th>
									<th class="has-background-grey-light" style="width:11%;" rowspan="2">대리</th>
									<th class="has-background-grey-light" style="width:11%;" rowspan="2">과장/차장</th>
									<th class="has-background-grey-light" style="width:11%;" rowspan="2">팀장</th>
									<th class="has-background-grey-light" style="width:11%;" rowspan="2">부문장</th>
									<th class="has-background-grey-light" style="width:3%;">단계</th>
									<th class="has-background-grey-light" style="width:7%;">미흡</th>
									<th class="has-background-grey-light" style="width:7%;">보통</th>
									<th class="has-background-grey-light" style="width:8%;">우수</th>
									<th class="has-background-grey-light" style="width:7%;">탁월</th>
								</tr>
								<tr>
									<td class="is-size-7 has-background-grey-light">수준</td>
									<td class="is-size-7 has-background-grey-light">기대수준에 미치지 못함</td>
									<td class="is-size-7 has-background-grey-light">기대수준을 충족시킴</td>
									<td class="is-size-7 has-background-grey-light">일부 기대수준을 뛰어넘음</td>
									<td class="is-size-7 has-background-grey-light">모든 기대수준을 상회하며 매우우수</td>
								</tr>
							</thead>
							<tbody class="tb-office-sheet" data-name="tb-office-sheet" data-role-seq="2">
								<c:forEach var="O" items="${VO.officeList}" varStatus="o_stat">
									<tr data-row-type="sheet" data-row="${o_stat.count}">
										<th class="title-depth-1  has-background-grey-light">${O.TITLE_DEPTH_1}</th>
										<th class="title-depth-2  has-background-grey-light">${O.TITLE_DEPTH_2}</th>
										<td class="col-detail">${O.COL_1_DETAIL}</td>
										<td class="col-detail">${O.COL_2_DETAIL}</td>
										<td class="col-detail">${O.COL_3_DETAIL}</td>
										<td class="col-detail">${O.COL_4_DETAIL}</td>
										<td class="col-detail">${O.COL_5_DETAIL}</td>
										
										<td class="vertical-level">수행역량 체크V</td>
										<td><label class="radio"><input type="radio" name="q_${o_stat.count}"></label></td>
										<td><label class="radio"><input type="radio" name="q_${o_stat.count}"></label></td>
										<td><label class="radio"><input type="radio" name="q_${o_stat.count}"></label></td>
										<td><label class="radio"><input type="radio" name="q_${o_stat.count}"></label></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div><!-- .conatiner.sheet-office END -->
					<%-- 테스트 레이아웃 [사무직] 끝 --%>
					<br>
					<%-- 테스트 레이아웃 [생산직] 시작 --%>
					<div class="conatiner sheet-produce">
						<p class="title is-5">2) 생산직 평가지</p>
						<table class="table t-produce is-fullwidth is-bordered">
							<thead>
								<tr>
									<th class="has-background-grey-light" style="width:5%;"  rowspan="2">구분</th>
									<th class="has-background-grey-light" style="width:8%;"  rowspan="2">평가항목</th>
									<th class="has-background-grey-light" style="width:10%;" rowspan="2">사원</th>
									<th class="has-background-grey-light" style="width:11%;" rowspan="2">대리</th>
									<th class="has-background-grey-light" style="width:11%;" rowspan="2">과장/차장</th>
									<th class="has-background-grey-light" style="width:11%;" rowspan="2">팀장</th>
									<th class="has-background-grey-light" style="width:11%;" rowspan="2">부문장</th>
									<th class="has-background-grey-light" style="width:3%;">단계</th>
									<th class="has-background-grey-light" style="width:7%;">미흡</th>
									<th class="has-background-grey-light" style="width:7%;">보통</th>
									<th class="has-background-grey-light" style="width:8%;">우수</th>
									<th class="has-background-grey-light" style="width:7%;">탁월</th>
								</tr>
								<tr>
									<td class="is-size-7 has-background-grey-light">수준</td>
									<td class="is-size-7 has-background-grey-light">기대수준에 미치지 못함</td>
									<td class="is-size-7 has-background-grey-light">기대수준을 충족시킴</td>
									<td class="is-size-7 has-background-grey-light">일부 기대수준을 뛰어넘음</td>
									<td class="is-size-7 has-background-grey-light">모든 기대수준을 상회하며 매우우수</td>
								</tr>
							</thead>
							<tbody class="tb-produce-sheet" data-name="tb-produce-sheet" data-role-seq="2">
								<c:forEach var="P" items="${VO.produceList}" varStatus="p_stat">
									<tr data-row-type="sheet" data-row="${p_stat.count}">
										<th class="title-depth-1 has-background-grey-light">${P.TITLE_DEPTH_1}</th>
										<th class="title-depth-2 has-background-grey-light">${P.TITLE_DEPTH_2}</th>
										<td class="col-detail">${P.COL_1_DETAIL}</td>
										<td class="col-detail">${P.COL_2_DETAIL}</td>
										<td class="col-detail">${P.COL_3_DETAIL}</td>
										<td class="col-detail">${P.COL_4_DETAIL}</td>
										<td class="col-detail">${P.COL_5_DETAIL}</td>
										
										<td class="vertical-level">수행역량 체크V</td>
										<td><label class="radio"><input type="radio" name="q_${p_stat.count}"></label></td>
										<td><label class="radio"><input type="radio" name="q_${p_stat.count}"></label></td>
										<td><label class="radio"><input type="radio" name="q_${p_stat.count}"></label></td>
										<td><label class="radio"><input type="radio" name="q_${p_stat.count}"></label></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div><!-- .conatiner.sheet-office END -->
					<%-- 테스트 레이아웃 [생산직] 끝 --%>
				</div> <!-- .box.questionList END -->
			</div> <!-- .container END -->
		</section> <!-- .section END -->
	</div>
	
	<%-- [▣ 직무역량 요구 사항] 모달 영역 START --%>
	<div id="require-modal" class="modal is-active">
		<div class="modal-background"></div>
		<div class="modal-content">
			<article class="message is-marginless">
				<div class="message-header level">
					<p>▣ 직무역량 요구 사항</p>
					<button class="delete btn-delete" aria-label="delete"></button>
				</div>
			</article>
			
			<div class="box is-radiusless">
				<div class="content">
					<p class="title is-6">1) 사무직</p>
					<table class="table is-bordered is-size-7">
						<thead>
							<tr>
								<th class="has-background-grey-light">직급</th>
								<th class="has-background-grey-light">사원</th>
								<th class="has-background-grey-light">대리</th>
								<th class="has-background-grey-light">과장/차장</th>
								<th class="has-background-grey-light">팀장</th>
								<th class="has-background-grey-light">본부장</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>기대수준</th>
								<td >준수</td>
								<td >분석</td>
								<td >문제정의 / 해결방안 도출</td>
								<td >문제 해결</td>
								<td >목표 / 전략 개발</td>
							</tr>
							<tr>
								<th rowspan="4">필요 역량</th>
								<td colspan="5" >KPI Tree, 팀별 역할과 책임, 전결규정 숙지</td>
							</tr>
							<tr>
								<td>회사 업무 규정 숙지</td>
								<td>공정, 제품 구조와 Application 숙지</td>
								<td>제품별 손익 구조 숙지</td>
								<td>시장, 경쟁 분석</td>
								<td>목표/전략 수립</td>
							</tr>
							
							<tr>
								<td>IT 시스템과 업무용 Application 활용</td>
								<td>Data 취합과 분석</td>
								<td>문제 정의와 해결책 도출</td>
								<td>실행계획 수립과 추진</td>
								<td>실행 점검과 Trouble Shooting</td>
							</tr>
							
							<tr>
								<td>업무 수행에 필요한 전문 지식</td>
								<td colspan="2"> </td>
								<td>업무 프로세스 설계, 분장, 관리, 조언</td>
								<td>인재 육성</td>
							</tr>
						</tbody>
					</table> <!-- .table [ 1. 사무직 ]  END-->
					 
					<p class="title is-6">2) 생산직</p>
					<table class="table is-bordered is-size-7">
						<thead>
							<tr>
								<th class="has-background-grey-light">직급</th>
								<th class="has-background-grey-light">사원</th>
								<th class="has-background-grey-light">기사</th>
								<th class="has-background-grey-light">선임기사</th>
								<th class="has-background-grey-light">수석기사</th>
								<th class="has-background-grey-light">기장</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>기대수준</th>
								<td>준수</td>
								<td>관리</td>
								<td>개선</td>
								<td>문제 해결</td>
								<td>개발</td>
							</tr>
							<tr>
								<th rowspan="5">필요 역량</th>
								<td colspan="5">KPI Tree, 팀별 역할과 책임, 전결규정 숙지</td>
							</tr>
							<tr>
								<td>공정, 제품 구조와 원재료에 대한 이해</td>
								<td>공정, 제품 구조와 Application 숙지</td>
								<td>제품별 손익 구조 숙지</td>
								<td>Line과 설비 점검과 적정 수준 유지</td>
								<td>생산기술/설비 개발</td>
							</tr>
							
							<tr>
								<td>설비 운전 능력과 관리 Point 해석</td>
								<td>제품별 설비 작동 조건 Setting과 운영</td>
								<td>제품별 Line 운영 조건 Setting과 운영 </td>
								<td>생산성/품질 개선 방안 도출과 실행</td>
								<td>인재 육성</td>
							</tr>
							
							<tr>
								<td>생산/제품 Code 해독</td>
								<td>설비/품질 이상 발견</td>
								<td> </td>
								<td>Trouble Shooting (설비, 품질, 부서간 조율)</td>
								<td> </td>
							</tr>
							
							<tr>
								<td>공정/작업관리 기준 숙지</td>
								<td> </td>
								<td> </td>
								<td> </td>
								<td> </td>
							</tr>
						</tbody>
					</table> <!-- .table [ 2. 생산직 ]  END-->
				</div> <!-- .content END -->
			</div> <!-- .box END -->
		</div> <!-- .modal-content END -->
	</div> <!-- #require-modal.modal END -->
</body>
<script>
$(document).ready(function() {
	
	<%--
		직무 평가 요구사항 모달
		@since 2019.07.03
	--%>	
	var modal = $('#require-modal')
	modal.find('.modal-background').click( function(){
		modal.removeClass('is-active');
	})
	modal.find('.modal-content .btn-delete').click( function(){
		modal.removeClass('is-active');
	})
	$('.btn-open-modal').click( function(){
		modal.addClass('is-active');
	})
	
	// [1] 공통 설문지 셀 병합
	$.mergeRow('.tb-common-sheet .title-depth-1');
	$.mergeRow('.tb-common-sheet .title-depth-2');
	
	// [2] 사무직 설문지 셀 병합
	$.mergeRow('.tb-office-sheet .title-depth-1');
	$.mergeRow('.tb-office-sheet .title-depth-2');
	$.mergeRow('.tb-office-sheet .vertical-level')
	$.mergeColumn('.tb-office-sheet .col-detail')
	
	// [3] 생산직 설문지 셀 병합
	// [2] 사무직 설문지 셀 병합
	$.mergeRow('.tb-produce-sheet .title-depth-1');
	$.mergeRow('.tb-produce-sheet .title-depth-2');
	$.mergeRow('.tb-produce-sheet .vertical-level')
	$.mergeColumn('.tb-produce-sheet .col-detail')
});


<%-- 엑셀 row 병합 함수 --%>
$.mergeRow = function (selector){
	$(selector).each( function() {
	    var rows = $(selector + ":contains('" + $(this).text() + "')");
	    if (rows.length > 1) {
	        rows.eq(0).attr("rowspan", rows.length);
	        rows.not(":eq(0)").remove();
	    }
	})
};

<%-- 엑셀 column 병합 함수 --%>
$.mergeColumn = function (selector){
	$(selector).each( function() {
	    var rows = $(selector+ ":contains('" + $(this).text() + "')");
	    if (rows.length > 1) {
	        rows.eq(0).attr("colspan", rows.length);
	        rows.not(":eq(0)").remove();
	    }
	})
};
</script>
</html>