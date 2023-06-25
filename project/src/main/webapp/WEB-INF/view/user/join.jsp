<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
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
	width:20%;
	text-align: center;
	
}
td {
	background-color :white;
}


</style>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1000px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<div class="join_top">
							<span class="txt">회원가입</span>
						</div>
					</div>
						<form:form modelAttribute="user" method="post" action="join">
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
										<form:input path="userId" class="w3-input" placeholder="이메일"  style="width:50%;"/>
										<font color="red"> 
											<form:errors path="userId" />
										</font>
									<%--
										<input type="text" class="w3-input" placeholder="인증번호" style="width:30%;">
										<input type="button" value="인증번호 전송" class="w3-button w3-white w3-border w3-border-orange w3-round-large" >
									 --%>
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
										<input type="file" name="photo">
									</td>
								
								</tr>
							</table>
							<input type="hidden" name="batch" value="1">
													
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