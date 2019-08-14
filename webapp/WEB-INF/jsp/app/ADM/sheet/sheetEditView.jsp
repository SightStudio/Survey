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
    	.table tr.is-selected { background-color : rgba(32, 156, 238, 0.72) !important }
    	.table tr th, .table tr td {vertical-align: middle; text-align: center !important;}
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
				<p>평가지 관리 메뉴</p>
				<p>평가 상태 : [ ${REQ.serverStatus.STATUS_DESC} ]</p>
				<p></p>
			</div>
		</article>
		
		<c:if test="${REQ.serverStatus.STATUS eq 0}">
			<p class="title is-6 has-text-danger">평가 상태가 
				<span class="has-text-dark">[평가 준비]</span>인 경우에만 
				<span class="has-text-dark">[평가지 수정]</span>
			를 할 수 있습니다.</p>
		</c:if>
		
		<section class="section">
			<div class="level">
				<p class="title is-4">평가지 관리</p>
				<a class="button is-medium btn-submit" <c:if test="${REQ.serverStatus.STATUS eq 0}">disabled</c:if>>수정하기</a>
			</div>
			
			<p class="title is-6">* 각 행의 셀에 같은 내용이 들어가 있으면 병합되서 출력됩니다.</p>
			<p class="title is-6">* 수정 내용은 상단의 <span class="has-text-danger">[질문 -> 평가지 조회]</span> 에서 확인 할 수 있습니다.</p>
			
			<div class="conatiner sheet-common">
				<p class="title is-5">공통 평가지</p>
				<table class="table t-common is-fullwidth is-bordered">
					<thead>
						<tr>
							<th style="width:10%;">구분</th>
							<th style="width:10%;">평가항목</th>
							<th style="width:12%;">사원</th>
							<th style="width:12%;">대리</th>
							<th style="width:12%;">과장/차장</th>
							<th style="width:12%;">팀장</th>
							<th style="width:12%;">부문장</th>
							<th style="width:8%;">평가</th>
							<th style="width:10%;"colspan="2">제어</th>
						</tr>
					</thead>
					<tbody data-name="tb-common" class="tb-common">
						
						<c:choose>
							<c:when test="${fn:length(VO.commonList) eq 0}">
								<tr data-row-type="common" data-row="1">
									<td><input type="text" class="input title-depth-1" title="구분" value="규범준수"></td>
									<td><input type="text" class="input title-depth-2" title="구분" value="사회규범"></td>
									<td colspan="5">
										<input type="text" class="input col-detail" title="내용">	
									</td>
									<td>2지선다</td>
									<td><a class="button is-link   btn-add-row">추가</a></td>
									<td><a class="button is-danger btn-rm-row" >삭제</a></td>
								</tr>
							</c:when>
							
							<c:otherwise>
								<c:forEach var="C" items="${VO.commonList}" varStatus="c_stat">
										<tr data-row-type="common" data-row="${c_stat.count}">
											<td><input type="text" class="input title-depth-1" title="구분" value="${C.TITLE_DEPTH_1}"></td>
											<td><input type="text" class="input title-depth-2" title="구분" value="${C.TITLE_DEPTH_2}"></td>
											<td colspan="5">
												<input type="text" class="input col-detail" title="내용" value="${C.COL_1_DETAIL}">	
											</td>
											<td>2지선다</td>
											<td><a class="button is-link   btn-add-row <c:if test="${not c_stat.last}">is-hidden</c:if>">추가</a></td>
											<td><a class="button is-danger btn-rm-row" >삭제</a></td>
										</tr>
									</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div><!-- .conatiner.sheet-common END -->
			<br>
			<div class="conatiner sheet-office">
				<p class="title is-5">1) 사무직 평가지</p>
				<table class="table t-office is-fullwidth is-bordered">
					<thead>
						<tr>
							<th style="width:10%;">구분</th>
							<th style="width:10%;">평가항목</th>
							<th style="width:12%;">사원</th>
							<th style="width:12%;">대리</th>
							<th style="width:12%;">과장/차장</th>
							<th style="width:12%;">팀장</th>
							<th style="width:12%;">부문장</th>
							<th style="width:8%;">평가</th>
							<th style="width:10%;"colspan="2">제어</th>
						</tr>
					</thead>
					<tbody  class="tb-office" data-name="tb-office" data-role-seq="2">
						
						<c:choose>
							<c:when test="${fn:length(VO.officeList) eq 0}">
								<tr data-row-type="office" data-row="1">
									<td><input type="text" class="input title-depth-1" title="구분" value="규범준수"></td>
									<td><input type="text" class="input title-depth-2" title="구분" value="사회규범"></td>
									
									<!-- 설문 START -->
									<td><textarea rows="4" class="textarea col-1-detail" title="내용"></textarea></td>
									<td><textarea rows="4" class="textarea col-2-detail" title="내용"></textarea></td>
									<td><textarea rows="4" class="textarea col-3-detail" title="내용"></textarea></td>
									<td><textarea rows="4" class="textarea col-4-detail" title="내용"></textarea></td>
									<td><textarea rows="4" class="textarea col-5-detail" title="내용"></textarea></td>
									<!-- 설문 END -->
									
									<td>4지선다</td>
									<td><a class="button is-link   btn-add-row">추가</a></td>
									<td><a class="button is-danger btn-rm-row" >삭제</a></td>
								</tr>
							</c:when>
							
							<c:otherwise>
								<c:forEach var="O" items="${VO.officeList}" varStatus="o_stat">
										<tr data-row-type="office" data-row="${o_stat.count}">
											<td><input type="text" class="input title-depth-1" title="구분" value="${O.TITLE_DEPTH_1}"></td>
											<td><input type="text" class="input title-depth-2" title="구분" value="${O.TITLE_DEPTH_2}"></td>
											<td><textarea rows="4" class="textarea col-1-detail" title="내용">${O.COL_1_DETAIL}</textarea></td>
											<td><textarea rows="4" class="textarea col-2-detail" title="내용">${O.COL_2_DETAIL}</textarea></td>
											<td><textarea rows="4" class="textarea col-3-detail" title="내용">${O.COL_3_DETAIL}</textarea></td>
											<td><textarea rows="4" class="textarea col-4-detail" title="내용">${O.COL_4_DETAIL}</textarea></td>
											<td><textarea rows="4" class="textarea col-5-detail" title="내용">${O.COL_5_DETAIL}</textarea></td>
											<td>4지선다</td>
											
											<td><a class="button is-link   btn-add-row <c:if test="${not o_stat.last}">is-hidden</c:if>">추가</a></td>
											<td><a class="button is-danger btn-rm-row">삭제</a></td>
										</tr>
									</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div><!-- .conatiner.sheet-office END -->
			<br>
			<div class="conatiner sheet-produce">
				<p class="title is-5">2) 생산직 평가지</p>
				<table class="table t-produce is-fullwidth is-bordered">
					<thead>
						<tr>
							<th style="width:10%;">구분</th>
							<th style="width:10%;">평가항목</th>
							<th style="width:12%;">사원</th>
							<th style="width:12%;">기사</th>
							<th style="width:12%;">선임기사</th>
							<th style="width:12%;">수석기사</th>
							<th style="width:12%;">기장</th>
							<th style="width:8%;">평가</th>
							<th style="width:10%;"colspan="2">제어</th>
						</tr>
					</thead>
					<tbody data-name="tb-produce" data-role-seq="3" class="tb-produce">
						<c:choose>
							<c:when test="${fn:length(VO.produceList) eq 0}">
								<tr data-row-type="produce" data-row="1">
									<td><input type="text" class="input title-depth-1" title="구분" value="규범준수"></td>
									<td><input type="text" class="input title-depth-2" title="구분" value="사회규범"></td>
									
									<!-- 설문 START -->
									<td><textarea rows="2" class="textarea col-1-detail" title="내용"></textarea></td>
									<td><textarea rows="2" class="textarea col-2-detail" title="내용"></textarea></td>
									<td><textarea rows="2" class="textarea col-3-detail" title="내용"></textarea></td>
									<td><textarea rows="2" class="textarea col-4-detail" title="내용"></textarea></td>
									<td><textarea rows="2" class="textarea col-5-detail" title="내용"></textarea></td>
									<!-- 설문 END -->
									
									<td>4지선다</td>
									<td><a class="button is-link   btn-add-row">추가</a></td>
									<td><a class="button is-danger btn-rm-row" >삭제</a></td>
								</tr>
							</c:when>
							
							<c:otherwise>
								<c:forEach var="P" items="${VO.produceList}" varStatus="p_stat">
										<tr data-row-type="office" data-row="${p_stat.count}">
											<td><input type="text" class="input title-depth-1"   title="구분" value="${P.TITLE_DEPTH_1}"></td>
											<td><input type="text" class="input title-depth-2"   title="구분" value="${P.TITLE_DEPTH_2}"></td>
											<td><textarea rows="4" class="textarea col-1-detail" title="내용">${P.COL_1_DETAIL}</textarea></td>
											<td><textarea rows="4" class="textarea col-2-detail" title="내용">${P.COL_2_DETAIL}</textarea></td>
											<td><textarea rows="4" class="textarea col-3-detail" title="내용">${P.COL_3_DETAIL}</textarea></td>
											<td><textarea rows="4" class="textarea col-4-detail" title="내용">${P.COL_4_DETAIL}</textarea></td>
											<td><textarea rows="4" class="textarea col-5-detail" title="내용">${P.COL_5_DETAIL}</textarea></td>
											
											<td>4지선다</td>
											<td><a class="button is-link   btn-add-row <c:if test="${not p_stat.last}">is-hidden</c:if>">추가</a></td>
											<td><a class="button is-danger btn-rm-row">삭제</a></td>
										</tr>
									</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div><!-- .conatiner.sheet-produce END -->
			<br>
			<p class="is-fullwidth has-text-right">
				<a class="button is-medium btn-submit" <c:if test="${REQ.serverStatus.STATUS eq 0}">disabled</c:if>>수정하기</a>
			</p>
		</section>
	</div>
</body>
<script>
$(document).ready(function() {
	
	<%-- 행 추가 함수 --%>
	$(document).on('click', '.btn-add-row', function() {
		var row = $(this).closest('tr');
		var rowNum = row.data('row');
		var newRow = row.clone();
		
		newRow.attr('data-row', parseInt(rowNum)+1);
		row.closest('tbody').append(newRow);
		$(this).addClass('is-hidden');
	});
	
	<%-- 행 삭제 함수 --%>
	$(document).on('click', '.btn-rm-row', function() {
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
	$('.btn-submit:not([disabled])').click(function(){
		var param = $.makeParam();
		
		if(param.validFlag) {
			if(confirm('평가지를 교체 하시겠습니까?')) {
				$.submitSheet(param.data);	
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

<%-- 수정 내역 파라미터 생성함수--%>
$.makeParam = function() {
	
	var common    = $('.tb-common');      // 공통 평가지
	var office    = $('.tb-office');      // 사무직
	var produce   = $('.tb-produce');     // 생산직
	var validFlag = true;

	var commonList  = [];
	var officeList  = [];
	var produceList = [];
	
	// [1] 공통 평가지 세팅
	common.find('tr').each(function(idx) {
		var el = $(this);
		var data = {
			row           : el.data('row'),
			title_depth_1 : el.find('.title-depth-1').val().trim(),
			title_depth_2 : el.find('.title-depth-2').val().trim(),
			col_1_detail  : el.find('.col-detail').val().trim(),
			col_2_detail  : el.find('.col-detail').val().trim(),
			col_3_detail  : el.find('.col-detail').val().trim(),
			col_4_detail  : el.find('.col-detail').val().trim(),
			col_5_detail  : el.find('.col-detail').val().trim(),
			a_seq         : 1,
			is_common     : 1,
		}
		
		// [1-1] 공백 검증
		for( key in data ){
			if(data[key] === '') {
				validFlag = false;
			}
		}
		commonList.push(data);
	});
	
	// [2] 사무원 평가지 세팅
	office.find('tr').each(function(idx) {
		var el = $(this);
		var data = {
			row           : el.data('row'),
			title_depth_1 : el.find('.title-depth-1').val().trim(),
			title_depth_2 : el.find('.title-depth-2').val().trim(),
			col_1_detail  : el.find('.col-1-detail').val().trim(),
			col_2_detail  : el.find('.col-2-detail').val().trim(),
			col_3_detail  : el.find('.col-3-detail').val().trim(),
			col_4_detail  : el.find('.col-4-detail').val().trim(),
			col_5_detail  : el.find('.col-5-detail').val().trim(),
			a_seq         : 2,
			is_common     : 0,
		}
		
		// [2-1] 공백 검증
		for( key in data ){
			if(data[key] === '') {
				validFlag = false;
			}
		}
		officeList.push(data);
	});
	
	// [3] 생산직 평가지 세팅
	produce.find('tr').each(function(idx){
		var el = $(this);
		var data = {
			row           : el.data('row'),
			title_depth_1 : el.find('.title-depth-1').val().trim(),
			title_depth_2 : el.find('.title-depth-2').val().trim(),
			col_1_detail  : el.find('.col-1-detail').val().trim(),
			col_2_detail  : el.find('.col-2-detail').val().trim(),
			col_3_detail  : el.find('.col-3-detail').val().trim(),
			col_4_detail  : el.find('.col-4-detail').val().trim(),
			col_5_detail  : el.find('.col-5-detail').val().trim(),
			a_seq         : 2,
			is_common     : 0,
		}
		
		// [2-1] 공백 검증
		for( key in data ){
			if(data[key] === '') {
				validFlag = false;
			}
		}
		produceList.push(data);
	});
	
	var data = {
			
		office  : {
			sheet_name : '설문1) 사무직',
			role_seq   : office.data('role-seq'),
			detail_list : JSON.stringify(commonList.concat(officeList)),
		},
		produce : {
			sheet_name : '설문2) 생산직',
			role_seq   : produce.data('role-seq'),
			detail_list : JSON.stringify(commonList.concat(produceList)),
		},
	}
	return {
		validFlag   : validFlag,		
		data        : data
	}
}
<%--수정 내역 등록함수--%>
$.submitSheet = function(data) {
	var RESTurl = '${HOME}/ADM/sheet';
	
	var param = {
		office_sheet_name  : data.office.sheet_name,
		office_role_seq    : data.office.role_seq,
		office_detail_list : data.office.detail_list,
		
		produce_sheet_name  : data.produce.sheet_name,
		produce_role_seq    : data.produce.role_seq,
		produce_detail_list : data.produce.detail_list,
	}
	
	$.ajax({
		type        : "POST",
		url         : RESTurl,
		data        : param,
		dataType    : "json",
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				alert('질문지가 성공적으로 교체되었습니다.');
				if(confirm('평가지 조회페이지로 이동하여 수정된 평가지를 확인하시겠습니까?')) {
					location.href = '${HOME}/ADM/sheetView';
				}
			} else {
				alert(result.REPL_MSG);
			}
		}
	});
}
</script>
</html>