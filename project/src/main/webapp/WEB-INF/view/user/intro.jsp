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
$(function() {
	$("#btn").click(function() {
		$.ajax({
	 		 url: 'https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=LdPS5IiOBYPeASfcwjEedxieH9Jey0kSkZtJsnuT7Id4vqmw%2BGe6%2FgTbBSYlOsma%2BRpXoKEJDLYtUg1ePWRbbA%3D%3D',
	  		 crossDomain: true,
	 		 method: 'post',
	 		 headers: {
	   				 'accept': 'application/json',
	  				 'Authorization': 'LdPS5IiOBYPeASfcwjEedxieH9Jey0kSkZtJsnuT7Id4vqmw+Ge6/gTbBSYlOsma+RpXoKEJDLYtUg1ePWRbbA=='
		 	 },
	 	 		contentType: 'application/json',
	 		 // data: '{\n  "b_no": [\n    "0000000000"\n  ]\n}',
	 			data: JSON.stringify({
	   								'b_no': [
	      									$("#b").val()
	    							]
	 			 }),
	 		success:function(response)  {
	 			for(let i=0; i<response.data.length;i++) {
	 	//			$('#result').append(response.data[i].b_stt_cd);
	 	//			$('#result').append(response.data[i].tax_type);
	 				if((response.data[i].b_stt_cd) == 01) {
	 					alert("가입이 가능합니다.");
	 					window.location = "agree?batch=2"
	 				} else {
	 					alert("사업자 등록번호가 조회되지 않습니다.");
	 				}
	 			
	 			}
	 		},
	 		error:function() {
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
							<li class="step1 now"><span class="number">01</span> 회원선택</li>
							<li class="step2 "><span class="number">02</span> 약관동의</li>
							<li class="step3"><span class="number">03</span> 정보입력</li>
							<li class="step4"><span class="number">04</span> 가입완료</li>						
					</header>		
				<br>
				<hr>
				<div class="w3-padding-64">
				<div class="w3-col m5 w3-left">
					<!-- Profile -->
					<div class="w3-card w3-white">
						<div class="w3-container">
							<h4 class="w3-center">일반 회원</h4>
							<p class="w3-center">
								<a href="agree?batch=3">
									<button type="button"
										class="w3-button w3-white w3-border w3-border-orange w3-round-large">가입하기</button>
								</a>
							</p>
						</div>
					</div>
				</div>

				<div class="w3-col m5 w3-right">
					<!-- Profile -->
					<div class="w3-card w3-round">
						<div class="w3-container">
							<h4 class="w3-center">사업자 회원</h4>
							<div class="w3-container w3-padding-32 w3-center">
								<div class="w3-padding-32">
										<div class="side">
											<h5>사업자 등록번호</h5>
											<table class="w3-table-all">
												<tr>
													<td><input type="text" id="b"
														class="w3-input w3-center"
														placeholder=" '-' 제외하고 번호만 입력해 주세요"></td>
												</tr>
											</table>
											<br>
											<button type="submit" id="btn"
												class="w3-button w3-white w3-border w3-border-orange w3-round-large">조회</button>
										</div>
									<br>
									<div id="result"></div>
								</div>
							</div>
						</div>
					</div>
					</div>
				</div>
			</div>
		</div>
</body>
</html>