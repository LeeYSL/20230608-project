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
<style type="text/css">
.mylogin {
	display:block; 
	margin:auto; 
	width:400px; 
	height:400px;

}
.myloginbox {
	width: 600px;
	border:  0.1px solid #ff8400
}
</style>
</head>
<body>
		<div style="display: block; margin: auto; width: 1100px; height: 80%; padding-top:100px;" class="w3-center">
			<div class="w3-padding-32" style="height: 80%;">
				<form method="post" action="login" name="loginform">
					<div class="w3-container w3-padding-32 myloginbox " >  
						<div class="mylogin  w3-center">
							<div class="w3-padding-32" >
								<div class="w3-padding-16">
									<input type="text" name="userId" placeholder="아이디" class="w3-input">
								</div>
								<div class="w3-padding-16">
									<input type="password" name="pw" placeholder="비밀번호는 8자~16자" class="w3-input">
								</div>
							</div>
							<div>
								<button type="submit" class="w3-button w3-white w3-border w3-border-orange w3-round-large">로그인</button>
							</div>
			
							<div>
								<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large" onclick="win_open('idsearch')">아이디 찾기</button>
								<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large" onclick="win_open('pwsearch')">비밀번호 찾기</button>
								<input type="button" onclick="location.href='intro'" class="w3-button w3-white w3-border w3-border-orange w3-round-large" value="회원가입">
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
</body>
</html>