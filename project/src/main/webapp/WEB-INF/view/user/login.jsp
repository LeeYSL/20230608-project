<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function win_open(page){
		var op ="width=500, height=350, left=50, top=150";
		open(page,"",op);
	}

</script>
</head>
<body>
	<form method="post" action="login" name="loginform">
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
				<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large" onclick="win_open('idsearch')">아이디 찾기</button>
				<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large" onclick="win_open('pwsearch')">비밀번호 찾기</button>
				<input type="button" onclick="location.href='intro'" class="w3-button w3-white w3-border w3-border-orange w3-round-large" value="회원가입">
			</div>
		</div>
	</div>
			<%-- 네이버로그인 부분 --%>
		<p>
		<a href="${apiURL}">
			<img height="30" src="http://static.nid.naver.com/oauth/small_g_in.PNG">
		</a>
	</form>
</body>
</html>