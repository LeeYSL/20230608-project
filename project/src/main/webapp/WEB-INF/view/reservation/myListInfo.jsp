<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 예약 상세 수정 페이지</title>
</head>
<body>
	<form:form modelAttribute="reservation" method="post"
		action="myListInfo">
		<c:forEach items="${errors.globalErrors}" var="error">
			<spring:message code="${error.code}" />
			<br>
		</c:forEach>
		<table>
			<tr>
				<td>가게이름</td>
				<td align="center">${rsrvt.name}</td>
			</tr>
			<tr>
				<td>가게 전화번호</td>
				<td align="center">${rsrvt.restPhoneNo}</td>
			</tr>
			<tr>
				<td>예약자 이름</td>
				<td><form:input path="rsrvtName" value="${rsrvt.rsrvtName}"/></td>
				<td><font color="red"><form:errors path="rsrvtName" /></font></td>
			</tr>
			<tr>
				<td>예약자 전화번호</td>
				<td><form:input path="phoneNo" value="${rsrvt.phoneNo}"/></td>
				<td><font color="red"><form:errors path="phoneNo" /></font></td>
			</tr>
			<tr>
				<td>예약 날짜</td>
				<td align="center">${rsrvt.restDate}</td>
			</tr>
			<tr>
				<td>예약 시간</td>
				<td align="center">${rsrvt.restTime}</td>
			</tr>
			<tr>
				<td><input type="submit" value="수정 완료" name="update">
				    <input type="button" value="확인">
				</td>
			</tr>
		</table>
	</form:form>
</body>
</html>