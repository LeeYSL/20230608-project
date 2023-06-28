<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
</head>
<body>
	<h5 class="w3-center">아이디 찾기</h5>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<div class="w3-container">
		<form:form modelAttribute="user" action="idsearch" method="post">
			<spring:hasBindErrors name="user">
				<font color="red">
					<c:forEach items="${errors.globalErrors}" var="error">
						<spring:message code="${error.code}"/>
					</c:forEach>
				</font>
			</spring:hasBindErrors>
			
			<table class="w3-table">
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="name" class="w3-input">
						<font color="red">
							<form:errors path="name"/>
						</font>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="tel" class="w3-input">
						<font color="red">
							<form:errors path="tel"/>
						</font>
					</td>				
				</tr>
				<tr>
					<td colspan="2" class="w3-center">
						<button type="submit" class="w3-button w3-white w3-border w3-border-orange w3-round-large">아이디 찾기</button>
					</td>
				</tr>
			</table>
		</form:form>
	</div>
</body>
</html>