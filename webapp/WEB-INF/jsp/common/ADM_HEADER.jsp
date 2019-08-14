<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
<%-- 로그아웃 --%>
$(document).ready(function() {
	$('#btn-logout').click(function() {
		$.ajax({
			type : "GET",
			url : '${HOME}/ADM/logout',
			dataType : "json",
			traditional : true,
			success : function(msg) {
				var result = msg.response;
				if(result.REPL_CD == '000000') {
					location.href = '${HOME}/ADM/login'
				}
			}
		});
	})
})
</script>
<header id="gnb">
	<nav class="navbar" role="navigation" aria-label="main navigation">
		<div class="navbar-brand">
			<p class="navbar-item logo-container" > 
				<img class="logo" src="${IMG}/common/logo.png">
			</p> 
		</div>

		<div class="navbar-menu">
			<div class="navbar-start">
				<a class="navbar-item" href="${HOME}/ADM/index"> Home </a> 
			</div>
		</div>

		<div class="navbar-end">
			<div class="navbar-item has-dropdown is-hoverable">
				<a class="navbar-link"> 질문 </a>

				<div class="navbar-dropdown">
					<a class="navbar-item" href="${HOME}/ADM/sheet">평가지 수정</a>
					<a class="navbar-item" href="${HOME}/ADM/sheetView">평가지 조회</a>
			  		<hr class="navbar-divider">
					<a class="navbar-item" href="${HOME}/ADM/statistics">응답 현황</a>  
				</div>
			</div>

			<div class="navbar-item has-dropdown is-hoverable">
				<a class="navbar-link"> 사원 </a>

				<div class="navbar-dropdown">
					<a class="navbar-item" href="${HOME}/ADM/employee/list">사원 조회/수정 </a>
					<hr class="navbar-divider"> 
					<a class="navbar-item" href="${HOME}/ADM/employee/register">사원 추가</a> 
				</div>
			</div>
		
			<div class="navbar-item">
				<div class="buttons">
					<a id="btn-logout" class="button is-primary"> <strong>Log Out</strong> </a>
				</div>
			</div>
		</div>
	</nav>
</header>