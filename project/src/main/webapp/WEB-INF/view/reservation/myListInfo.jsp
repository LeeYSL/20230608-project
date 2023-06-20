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
		<table>
			<tr>
				<td>가게이름</td>
				<td align="center"><form:input path="name" value="${rsrvt.name}" disabled="true"/></td>
			</tr>
			<tr>
				<td>가게 전화번호</td>
				<td align="center"><form:input path="restPhoneNo" value="${rsrvt.restPhoneNo}" disabled="true"/></td>
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
				<td>인원 수</td>
				<td align="center"><form:input path="people" value="${rsrvt.people}" disabled="true"/></td>
			</tr>
			<tr>
				<td>예약 날짜</td>
				<td align="center"><form:input path="rsrvtDate" value="${rsrvt.rsrvtDate}" disabled="true"/></td>
			</tr>
			<tr>
				<td>예약 시간</td>
				<td align="center"><form:input path="rsrvtTime" value="${rsrvt.rsrvtTime}" disabled="true"/></td>
			</tr>
			<tr>
				<td><input type="submit" value="수정 완료" name="update">
				    <input type="button" value="확인">
				</td>
			</tr>
		</table>
		<input type="hidden" name="num" value="${rsrvt.num}"/>
	</form:form>
</body>
</html>