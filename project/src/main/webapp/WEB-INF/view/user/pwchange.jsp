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
	width:30%;
	text-align: center;
	height: 50px;
	
}
td {
	background-color :white;
	height: 50px;
}

#table{
	width: 700px;
}

.table_div {
 margin: 0% 30% 0% 20%;
 padding-bottom: 3%;
}


a {
	text-decoration: none;
}
.w3-input {
	border: none;
}

</style>
</head>
<body>
	<div style="display: block; margin: auto; width: 1100px; height: auto; padding-top: 100px;"
		class="w3-center">
		<div class="w3-padding-32">
			<div class="page">
				<span class="txt">비밀번호 수정</span>
			</div>

						<form:form modelAttribute="user" method="post" action="pwchange">
						<input type="hidden" name="userId" value="${loginUser.userId}">
						<input type="hidden" name="nickname" value="유효성검증을위한데이터">
						<input type="hidden" name="name" value="유효성검증을위한데이터">
						<input type="hidden" name="tel" value="010-1111-1111">
						<input type="hidden" name="email" value="a@a.aaa">
						
						
						
							<spring:hasBindErrors name="user">
								<font color="red"> 
									<c:forEach items="${errors.globalErrors}" var="error">
										<spring:message code="${error.code}" />
										<br>
									</c:forEach>
								</font>
							</spring:hasBindErrors>
			<div class="table_div">
					<table class="w3-table-all" id="table">
								<tr>									
									<td>
										<form:input path="pw" class="w3-input" placeholder="비밀번호"/> 
										<font color="red"> 
											<form:errors path="pw" />
										</font>
									</td>
								</tr>
								<tr>									
									<td>
										<form:input path="pw1" class="w3-input" placeholder="변경할 비밀번호" /> 
										<font color="red"> 
											<form:errors path="pw1" />
										</font>
									</td>
								</tr>
								<tr>									
									<td>
										<form:input path="pw2"  class="w3-input"  placeholder="변경할 비밀번호 재확인" /> 
										<font color="red"> 
											<form:errors path="pw2" />
										</font>
									</td>
								</tr>
					</table>
							</div>
							<br>						
								<div class="w3-center">
									<a href="userinfo?userId=${user.userId}">
										<button type="button"
											class="w3-button w3-white w3-border w3-border-orange w3-round-large">취소</button>
									</a>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;
									<button type="submit"
										class="w3-button w3-white w3-border w3-border-orange w3-round-large">수정</button>
								</div>
				
						</form:form>
				</div>
			</div>
	
</body>
</html>