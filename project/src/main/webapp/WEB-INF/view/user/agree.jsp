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

	$(document).ready(function() {
		$('.chkbox').click(function() {
			let chk = $(".chkbox:checked").length;
			if (chk > 1) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		})
	});
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

  textarea {
    width: 100%;
    height: 14em;
    border:  0.1px solid #ff8400;
    resize: none;
  }
</style>

</head>
<body>
		<div style="display: block; margin: auto; width: 1100px; height: 100%; padding-top:100px;" class="w3-center">
			<div class="w3-padding-32" style="height: 100%;">
					<header class="l_member_header">
						<div >
						<h1 class="tit" >
							<span>회원가입</span>
						</h1>
						</div>
							<li class="step1"><span class="number">01</span> 회원선택</li>
							<li class="step2 now"><span class="number">02</span> 약관동의</li>
							<li class="step3"><span class="number">03</span> 정보입력</li>
							<li class="step4"><span class="number">04</span> 가입완료</li>
						
					</header>				
					<div class="w3-col w3-center w3-padding-32 ">
						<div class="agree w3-padding-32">
							<div class="agree_txt">
								<textarea readonly>
								
							
								</textarea>
							</div>
							<div class="agree_check">
								<label> <input type="checkbox" id="checkbox1" class="chkbox">
									" 위 내용에 동의합니다."
								</label>
							</div>
						</div>
						<div class="agree w3-padding-32">
							<div class="agree_txt">
								<textarea readonly>수정수정</textarea>
							</div>
							<div class="agree_check">
								<label> <input type="checkbox" id="checkbox2" class="chkbox">
									" 위 내용에 동의합니다."
								</label>
							</div>
						</div>
					</div>
					<br>
					<div>
						<a href="join?batch=${param.batch}">
							<button class="w3-button w3-white w3-border w3-border-orange w3-round-large" id="button" class="button" disabled="disabled">다음단계</button>
						</a>
					</div>
			</div>
		</div>

</body>
</html>