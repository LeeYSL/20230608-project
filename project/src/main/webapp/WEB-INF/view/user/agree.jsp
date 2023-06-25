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
	$(
			function() {
				$("#btn")
						.click(
								function() {
									$
											.ajax({
												url : 'https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=LdPS5IiOBYPeASfcwjEedxieH9Jey0kSkZtJsnuT7Id4vqmw%2BGe6%2FgTbBSYlOsma%2BRpXoKEJDLYtUg1ePWRbbA%3D%3D',
												crossDomain : true,
												method : 'post',
												headers : {
													'accept' : 'application/json',
													'Authorization' : 'LdPS5IiOBYPeASfcwjEedxieH9Jey0kSkZtJsnuT7Id4vqmw+Ge6/gTbBSYlOsma+RpXoKEJDLYtUg1ePWRbbA=='
												},
												contentType : 'application/json',
												// data: '{\n  "b_no": [\n    "0000000000"\n  ]\n}',
												data : JSON.stringify({
													'b_no' : [ $("#b").val() ]
												}),
												success : function(response) {
													for (let i = 0; i < response.data.length; i++) {
														//			$('#result').append(response.data[i].b_stt_cd);
														//			$('#result').append(response.data[i].tax_type);
														if ((response.data[i].b_stt_cd) == 01) {
															$('#result')
																	.append(
																			"가입이 가능")
														} else {
															$('#result')
																	.append(
																			"가입 불가능")
														}

													}
												},
												error : function() {
													alert("error error error에러")
												}
											})
								})
			})
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
				
				<div class="w3-col w3-center">
					<form name="join_agree">
						<div class="join_title">
							<b>이용약관</b> 동의
						</div>
						<div class="agree">
							<div class="agree_txt">
								<textarea readonly>수정수정</textarea>
							</div>
							<div class="agree_check">
								<label> 
									<input type="checkbox" name="join_agree" value="yes"> " 위 내용에 동의합니다."
								</label>
							</div>
						</div>
					</form>
				</div>

				<div class="w3-container w3-padding-32 w3-center">
					<div style="display: block; margin: auto; width: 1100px; height: 100%;">
						<div class="w3-padding-32">
							<div class="side">
								<h5>사업자 등록번호</h5>
								<table class="w3-table-all">
									<tr>
										<td><input type="text" id="b" class="w3-input"></td>
									</tr>
								</table>
								<br>
								<br>
								<button id="btn" class="w3-button w3-white w3-border w3-border-orange w3-round-large">조회</button>
							</div>

							<div id="result"></div>
						</div>
					</div>
				</div>



			</div>
		</div>
	</div>

</body>
</html>