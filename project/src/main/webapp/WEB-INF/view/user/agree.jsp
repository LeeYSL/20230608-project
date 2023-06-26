<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	function chk(checkbox){
		const button_elem =
			document.getElementById("button");
		button_elem.disabled = checkbox.checked? false:true;
		if(button_elem.disabled){
			button_elem.value=null;
		}else{
			button_elem.focus();
		}	
	}
</script>
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

  textarea {
    width: 100%;
    height: 14em;
    border:  0.1px strong;
    resize: none;
  }
</style>

</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div
			style="display: block; margin: auto; width: 1100px; height: 100%;">
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
					<div class="w3-col w3-center">
						<div class="join_title">
							<b>이용약관</b> 동의
						</div>
						<div class="agree">
							<div class="agree_txt">
								<textarea readonly>수정수정</textarea>
							</div>
							<div class="agree_check">
								<label> <input type="checkbox" id="checkbox1" onclick="chk(this)">
									" 위 내용에 동의합니다."
								</label>
							</div>
						</div>
						<div class="agree">
							<div class="agree_txt">
								<textarea readonly>수정수정</textarea>
							</div>
							<div class="agree_check">
								<label> <input type="checkbox" id="checkbox2" onclick="chk(this)">
									" 위 내용에 동의합니다."
								</label>
							</div>
						</div>
						<div class="agree">
							<div class="agree_txt">
								<textarea readonly>수정수정</textarea>
							</div>
							<div class="agree_check">
								<label> <input type="checkbox" id="checkbox3" onclick="chk(this)">
									" 위 내용에 동의합니다."
								</label>
							</div>
						</div>
					</div>
					<br>
					<div>
						<a href="join?batch=${param.batch}">
							<button class="w3-button w3-white w3-border w3-border-orange w3-round-large" id="button" disabled>다음단계</button>
						</a>
					</div>
			</div>
		</div>
	</div>
</body>
</html>