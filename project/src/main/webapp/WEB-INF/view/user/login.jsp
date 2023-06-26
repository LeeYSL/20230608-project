<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="login">
	<div class="w3-container w3-padding-32 w3-center">  
		<div style="display:block; margin:auto; width:800px; height:533px;">
			<div class="w3-padding-32">
				<div>
					<input type="text" name="userId" placeholder="아이디" class="w3-input">
				</div>
				<div>
					<input type="text" name="pw" placeholder="비밀번호는 8자~16자" class="w3-input">
				</div>
			</div>
			<div>
				<button type="submit" class="w3-button w3-white w3-border w3-border-orange w3-round-large">로그인</button>
			</div>
			<br>
			
			<div>
				<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">아이디 찾기</button>
				<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">비밀번호 찾기</button>
				<input type="button" onclick="location.href='intro'" class="w3-button w3-white w3-border w3-border-orange w3-round-large" value="회원가입">
			</div>
		</div>
	</div>
	</form>
</body>
</html>