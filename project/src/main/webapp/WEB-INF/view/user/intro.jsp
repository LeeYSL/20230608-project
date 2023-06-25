<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	height: 50%;
	line-height: 50px;
	text-align: center;
	background: orange;
	color: white;
}
</style>

</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1100px; height: 100%;">
			<div class="w3-padding-32">
				<div class="page">
					<header class="l_member_header">
						<h1 class="tit">
							<span>회원가입</span>
						</h1>
						<ol class="c_member_location">
							<li class="step1"><span class="number">01</span> 회원선택</li>
							<li class="step2"><span class="number">02</span> 약관동의</li>
							<li class="step3"><span class="number">03</span> 정보입력</li>
							<li class="step4"><span class="number">04</span> 가입완료</li>
						</ol>
					</header>
				</div>
				<br>
				<hr>
				<div class="w3-col m5 w3-left">
					<!-- Profile -->
					<div class="w3-card w3-round w3-white">
						<div class="w3-container">
							<h4 class="w3-center">일반 회원</h4>
							<p class="w3-center">
								<a href=""><button type="button">가입하기</button></a>
							</p>
						</div>
					</div>
				</div>
				
				<div class="w3-col m5 w3-right">
					<!-- Profile -->
					<div class="w3-card w3-round w3-white">
						<div class="w3-container">
							<h4 class="w3-center">사업자 회원</h4>
							<p class="w3-center">
								<a href=""><button type="button">가입하기</button></a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>