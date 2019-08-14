<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
<%-- 로그아웃 --%>
$(document).ready(function() {
	$('#btn-logout').click(function() {
		$.ajax({
			type : "GET",
			url : '${HOME}/PUBLIC/logout',
			dataType : "json",
			traditional : true,
			success : function(msg) {
				var result = msg.response;
				if(result.REPL_CD == '000000') {
					location.href = '${HOME}/PUBLIC/login'
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
				<a class="navbar-item" href="${HOME}/index"> Home </a> 
			</div>
		</div>

		<div class="navbar-end">
			<div class="navbar-item">${USER.NAME}</div>
			<div class="navbar-item">${USER.EMP_NO}</div>
			<div class="navbar-item">
				<div class="buttons">
					<a id="btn-logout" class="button is-primary"> <strong>Log Out</strong> </a>
				</div>
			</div>
		</div>
	</nav>
</header>