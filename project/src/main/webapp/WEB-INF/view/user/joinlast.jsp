<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
.page {
	height: 10%;
	display: block;
}

.txt {
	font-size: 200%;
}

th {
	background-color: #ff8400;
	color: white;
	text-align: center;
}

td {
	background-color: white;
}

a {
	text-decoration: none;
}

li {
	list-style: none;
	float: left;
	width: 25%;
	height: 50px;
	line-height: 50px;
	text-align: center;
	background: white;
	color: #ff8400;
	border: 0.1px solid #ff8400;
}

.now {
	list-style: none;
	float: left;
	width: 25%;
	height: 50px;
	line-height: 50px;
	text-align: center;
	background: #ff8400;
	color: white;
}

.w3-card  {
	border: 0.1px solid #ff8400;
}
</style>

</head>
<body>
		<div style="display: block; margin: auto; width: 1100px; height: 80%; padding-top:100px;" class="w3-center">
			<div class="w3-padding-32" style="height: 80%;">
					<header class="l_member_header">
						<div >
						<h1 class="tit" >
							<span>회원가입</span>
						</h1>
						</div>
							<li class="step1"><span class="number">01</span> 회원선택</li>
							<li class="step2 "><span class="number">02</span> 약관동의</li>
							<li class="step3"><span class="number">03</span> 정보입력</li>
							<li class="step4 now"><span class="number">04</span> 가입완료</li>						
					</header>		
					<br>
					<br>
					<br>
					<div style="padding-top: 100px;">
						<div class="w3-white w3-border w3-border-orange w3-round-large w3-center" style="height: 150px; margin: 30px;">
							<div style="padding-top: 25px;">
						<p class="w3-center">가입을 축하드립니다.</p>
						<p class="w3-center">로그인 후 홈페이지 이용이 가능합니다.</p>					
								</div>
						</div>
					</div>
					<div class="bottom_btn" class="w3-right" style="padding-top: 50px;">
						<a href="login">
						<button type="submit"
							class="w3-button w3-white w3-border w3-border-orange w3-round-large w3-center" id="button" class="button">로그인</button>
						</a>
					</div>					
			</div>
		</div>
</body>
</html>