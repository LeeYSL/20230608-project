<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style type="text/css">
table {
	border: 0.1% solid gray;
}

.w3-input {
	border: none;
}
</style>
</head>
<body>
	<div style="padding-top: 40px;">
	<h5 class="w3-center">아이디 찾기</h5>
	<div class="w3-container" style="padding-top: 20px;">
		<form:form modelAttribute="user" action="idsearch" method="post">
			<spring:hasBindErrors name="user">
				<font color="red">
					<c:forEach items="${errors.globalErrors}" var="error">
						<spring:message code="${error.code}"/>
					</c:forEach>
				</font>
			</spring:hasBindErrors>
			
			<table class="w3-table-all">
				<tr>
					<th style="text-align: center;">이름</th>
					<td>
						<input type="text" name="name" class="w3-input w3-center">
						<font color="red">
							<form:errors path="name"/>
						</font>
					</td>
				</tr>
				<tr>
					<th style="text-align: center;">이메일</th>
					<td class="w3-center">
						<input type="text" name="email" class="w3-input w3-center">
						<font color="red">
							<form:errors path="email"/>
						</font>
					</td>				
				</tr>
				
			</table>
			<div class="w3-center" style="padding-top:20px;">					
				<button type="submit" class="w3-button w3-white w3-border w3-border-orange w3-round-large">아이디 찾기</button>					
			</div>	
		</form:form>
	</div>
	</div>
</body>
</html>