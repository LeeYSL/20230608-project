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

td {
	background-color :white;
}

a {
	text-decoration: none;
}


</style>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div
			style="display: block; margin: auto; width: 800px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<div class="join_top">
							<span class="txt">비밀번호 수정</span>
						</div>
					</div>

						<form:form modelAttribute="user" method="post" action="pwchange">
							<spring:hasBindErrors name="user">
								<font color="red"> 
									<c:forEach items="${errors.globalErrors}" var="error">
										<spring:message code="${error.code}" />
										<br>
									</c:forEach>
								</font>
							</spring:hasBindErrors>
							
							<table class="w3-table-all w3-white w3-border w3-border-orange w3-round-large">
								<tr>
									<td>
										<form:input path="pw" class="w3-input" placeholder="비밀번호" /> 
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
										<form:input path="pw2" class="w3-input" placeholder="변경할 비밀번호 재확인" /> 
										<font color="red"> 
											<form:errors path="pw2" />
										</font>
									</td>
								</tr>
							</table>
							<hr>
							<div class="bottom_btn">
								<div>
									<a href="userinfo?userId=${user.userId}">
										<button type="button"
											class="w3-button w3-white w3-border w3-border-orange w3-round-large">취소</button>
									</a>
									<button type="submit"
										class="w3-button w3-white w3-border w3-border-orange w3-round-large">수정</button>
								</div>
							</div>
						</form:form>
				</div>
			</div>
		</div>
	</div>


</body>
</html>