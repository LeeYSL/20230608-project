<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 추가</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
function sendEmail() {
	let emailCheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	
	if (!emailCheck.test($("#email").val())) {
		alert("이메일 형식에 맞추어 작성하세요");
	} else {
		let email = $("#email").val();  //입력한 이메일
		
		$.ajax({
			url: "mailSender.do",
			type: "get",
			data: {'email':email},
			success: function(rnum) {
				//alert("s");
				alert("기입하신 이메일로 인증번호를 전송했습니다.");
				
				$("#codeInput").attr("disabled", false); //입력칸 활성화
				code = rnum;
				
				
			},
			error: function () {
				alert("이메일 전송에 오류가 생겼습니다.");
			}
		});
		
	}	
}

$(document).ready(function() {
	$("#codeInput").blur(function() {	
		console.log(code);
		if(code == $("#codeInput").val()) { //인증번호 같다면
			$("#codecheck_blank").css("color", "blue");
			$("#codecheck_blank").text("인증되었습니다.");
			$("#button").prop("disabled", false);
		//	email = true;
		}else {
			$("#codecheck_blank").css("color", "red");
			$("#codecheck_blank").text("인증번호를 다시 입력해주세요.");			
		//	email = false;
			$("#button").prop("disabled", true);
		}
	});
});



</script>

<style type="text/css">
.page {

	height: 10%;
	display: block;
}

th {
	background-color: #ff8400;
	color: white;
	width:20%;
	text-align: center;
	
}
td {
	background-color :white;
}
#mail_check_input_box_false{
	background: #ebebe4; 
}
#mail_check_input_box_true{
	background: white; 
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
.w3-input {
	border: none;
}

a {
	text-decoration: none;
	color : black;
}
</style>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1100px; height: 100%">
			<div class="w3-padding-32">
				<header class="l_member_header">
					<div>
						<h1 class="tit" >
						<span>관리자 추가</span>
						</h1>
					</div>				
				</header>	
				<br>
				<br>
				<br>
					<div>
						<p class="w3-right" style="color:red;"> * 는 필수 입력사항입니다.</p>
					</div>
						<form:form modelAttribute="user" enctype="multipart/form-data"  name="f" action="add">
						<spring:hasBindErrors name="user">
							<font color="red"> 
								<c:forEach items="${errors.globalErrors}" var="error">
									<spring:message code="${error.code}" />
									<br>
								</c:forEach>
							</font>
						</spring:hasBindErrors>
							<table class="w3-table-all">
								<tr>
									<th>아이디 *</th>
									<td>
										<form:input path="userId" class="w3-input" placeholder="영문으로 시작, 숫자 포함 가능, 6~12자" style="text-align: center;" />
										<font color="red"> 
											<form:errors path="userId" />
										</font>								
									</td>
								</tr>
								<tr>
									<th>비밀번호 *</th>
									<td>
										<form:input path="pw" class="w3-input" placeholder="영문과 숫자 1개 이상씩 포함 8~16자" style="text-align: center;"  /> 
										<font color="red"> 
											<form:errors path="pw" />
										</font>
									</td>
								</tr>
								<tr>
									<th>비밀번호 재확인 *</th>
									<td>
										<form:input path="pw1" class="w3-input" style="text-align: center;"  /> 
										<font color="red"> 
											<form:errors path="pw1" />
										</font>
									</td>
								</tr>
								<tr>
									<th>닉네임 *</th>
									<td>
										<form:input path="nickname"  class="w3-input"  placeholder="별명" style="text-align: center;"  /> 
										<font color="red"> 
											<form:errors path="nickname" />
										</font>
									</td>
								</tr>
								<tr>
									<th>이름 *</th>
									<td>
										<form:input path="name"  class="w3-input" placeholder="한글만 가능합니다." style="text-align: center;"  /> 
										<font color="red"> 
											<form:errors path="name" />
										</font>
									</td>
								</tr>
								<tr>
									<th>휴대전화번호 *</th>
									<td>
										<form:input path="tel"  class="w3-input"  placeholder="휴대전화번호 '-'를 포함하여 적어주세요" style="text-align: center;"  /> 
										<font color="red"> 
											<form:errors path="tel" />
										</font>
									</td>
								</tr>
								<tr>
									<th>이메일 *</th>
									<td class=" w3-center">
										<div class=" w3-center">
										<form:input path="email"  class="w3-input w3-left" name="email" id="email" placeholder="xxx@aaa.bbb 이메일 형식으로 입력하세요."   style="width:40%; text-align: center;"/> 
										
										
										<input type="button" onclick="sendEmail()" value="인증번호전송" class="w3-button w3-white w3-border w3-border-orange w3-round-large"   style="width:30%;">	
										
										<input type="text" class="w3-input w3-right" id="codeInput" placeholder="인증번호입력" disabled="disabled"   style="width:20%; text-align: center;">											
										</div>
										<font color="red"> 
											<form:errors path="email" />
										</font>
									</td>
								</tr>	
								<tr>
									<th>이메일인증여부 *</th>
									<td id="codecheck_blank"  style="text-align: center;" ></td>
								</tr>							
								<tr>
									<th>주소</th>
									<td>
										<select name="address" class="w3-select">
											<option value=""  style="text-align: center;" >주소</option>
											<option>강남구</option>
											<option>강동구</option>
											<option>강북구</option>
											<option>강서구</option>
											<option>관악구</option>
											<option>광진구</option>
											<option>구로구</option>
											<option>금천구</option>
											<option>노원구</option>
											<option>도봉구</option>
											<option>동대문구</option>
											<option>동작구</option>
											<option>마포구</option>
											<option>서대문구</option>
											<option>서초구</option>
											<option>성동구</option>
											<option>성북구</option>
											<option>송파구</option>
											<option>양천구</option>
											<option>영등포구</option>
											<option>용산구</option>
											<option>은평구</option>
											<option>종로구</option>
											<option>중구</option>
											<option>중랑구</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>프로필사진</th>
									<td>
										<input type="file" name="file1"class="w3-input" >
									</td>
								
								</tr>
							</table>
							<input type="hidden" name="batch" value="1">

							
													
						
							<div class="bottom_btn" class="w3-right" style="padding-top: 50px;">
								
									<button type="submit"
										class="w3-button w3-white w3-border w3-border-orange w3-round-large w3-center" id="button" class="button" disabled="disabled">가입</button>
								
							</div>
						</form:form>
				</div>
	</div>
</div>

</body>
</html>