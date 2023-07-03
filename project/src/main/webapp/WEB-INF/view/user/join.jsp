<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(".chk_btn").click(function(){
	const userId = $(".userId").val();
	console.log("내이메일:"+userId);
	const check=$(".check")
	
	$.ajax({
		type:"GET",
		url:'<c:url value="/user/userIdCheck?userId="/>'+userId,
				success:function(data){
					console.log("data:"+data);
					check.attr('disabled',false);
					code=data;
					alert('인증번호가 전송되었습니다.')
				}
	});
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
	height: 50%;
	line-height: 50px;
	text-align: center;
	background: #ff8400;
	color: white;
}
</style>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1000px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
					<header class="l_member_header">
						<h1 class="tit">
							<span>회원가입</span>
						</h1>
						
							<li class="step1"><span class="number">01</span> 회원선택</li>
							<li class="step2"><span class="number">02</span> 약관동의</li>
							<li class="step3"><span class="number">03</span> 정보입력</li>
							<li class="step4"><span class="number">04</span> 가입완료</li>
						
					</header>
					</div>
					<br>
					<br>
					<br>
						<form:form modelAttribute="user" enctype="multipart/form-data"  name="f" action="join">
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
									<th>아이디</th>
									<td>
										<form:input path="userId" class="w3-input" placeholder="아이디"  style="width:50%;"/>
										<font color="red"> 
											<form:errors path="userId" />
										</font>								
									</td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td>
										<form:input path="pw" class="w3-input" placeholder="비밀번호" /> 
										<font color="red"> 
											<form:errors path="pw" />
										</font>
									</td>
								</tr>
								<tr>
									<th>비밀번호 재확인</th>
									<td>
										<form:input path="pw1" class="w3-input" placeholder="비밀번호 재확인" /> 
										<font color="red"> 
											<form:errors path="pw1" />
										</font>
									</td>
								</tr>
								<tr>
									<th>닉네임</th>
									<td>
										<form:input path="nickname"  class="w3-input"  placeholder="별명" /> 
										<font color="red"> 
											<form:errors path="nickname" />
										</font>
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>
										<form:input path="name"  class="w3-input" placeholder="이름" /> 
										<font color="red"> 
											<form:errors path="name" />
										</font>
									</td>
								</tr>
								<tr>
									<th>휴대전화번호</th>
									<td>
										<form:input path="tel"  class="w3-input"  placeholder="휴대전화번호" /> 
										<font color="red"> 
											<form:errors path="tel" />
										</font>
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<form:input path="email"  class="w3-input"  placeholder="이메일" /> 
										<font color="red"> 
											<form:errors path="email" />
										</font>
										<input type="text" id="check" placeholder="인증번호입력" disabled="disabled">		
										<input type="button" id="chk_btn" value="인증번호전송">	
									</td>
								</tr>								
								<tr>
									<th>주소</th>
									<td>
										<select name="address" class="w3-select">
											<option value="">===주소===</option>
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
										<input type="file" name="file1" class="w3-input" >
									</td>
								
								</tr>
							</table>
							<input type="hidden" name="batch" value="${param.batch}">
													
							<hr>
							<div class="bottom_btn">
								<div>
									<button type="submit"
										class="w3-button w3-white w3-border w3-border-orange w3-round-large">가입</button>
								</div>
							</div>
						</form:form>
				</div>
			</div>
		</div>
	</div>


</body>
</html>