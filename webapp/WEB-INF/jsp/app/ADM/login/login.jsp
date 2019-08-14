<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 로그인 확인  --%>
<c:if test="${not empty ADMIN}">
	<script> location.href = '${HOME}/ADM/index' </script>
</c:if>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Survey</title>
	
	<!-- init CSS -->
	<link rel="stylesheet" href="${CSS}/common/init/bulma.min.css" />
	<link rel="stylesheet" href="${CSS}/login/login.css" />
	
	<!-- init JS -->
    <script src="${JS}/common/jquery/jquery-3.4.0.min.js"></script>
</head>
<body>
	<div id="login">
		<div class="login-card">

			<div class="card-title has-background-dark">
				<h1>
					<p>나투라미디어 다면평가</p>
					<p>관리자 메뉴</p>
				</h1>
			</div>

			<div class="content">
				<form method="POST" id="login-form" action="#">
					<input id="email"    type="text"     name="id" title="ID" placeholder="ID" required autofocus> 
					<input id="password" type="password" name="pw" title="PW" placeholder="PW" required>
					
					<div class="level">
						<a type="submit" href="${HOME}/index" class="btn button btn-primary submit-btn">로그인 하기</a>
						<a type="submit" href="${HOME}/PUBLIC/login" class="btn button btn-primary">평가자로 이동</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

$(document).ready(function() {

	<%--
		로그인 버튼 이벤트
		
		@since  2019.05.13
	--%>
	$('.submit-btn').click(function(e) {
		e.preventDefault();
		
		$.submitForm();	
	});
});

<%--
	로그인 AJax 함수
	
	@since  2019.05.13
--%>
$.submitForm = function() {

	var submitUrl = '${HOME}/ADM/login';
	var dataSet = {
			ID : $('#email').val(),
			PW : $('#password').val(),
	}
	
	$.ajax({
		type : "POST",
		url : submitUrl,
		data : dataSet, 
		traditional : true,
		success : function(msg) {
			var result = msg.response;
			if(result.REPL_CD == '000000') {
				location.href="${HOME}/ADM/index"
			} else {
				alert(result.REPL_MSG);
			}
		}
	});
}
</script>
</html>