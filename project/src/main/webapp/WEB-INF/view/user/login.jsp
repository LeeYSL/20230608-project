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
		<div>
			<div>
				<div>
					<input type="text" name="userId" placeholder="아이디">
				</div>
				<div>
					<input type="text" name="pw" placeholder="비밀번호는 8자~16자">
				</div>
			</div>
			<div>
				<button type="submit">로그인</button>
			</div>
			<div>
				<button type="button">아이디 찾기</button>
				<button type="button">비밀번호 찾기</button>
			</div>
		</div>
	</form>
</body>
</html>