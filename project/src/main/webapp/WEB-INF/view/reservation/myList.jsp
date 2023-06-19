<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 예약 목록</title>
</head>
<body>
	<h2>예약 목록</h2>
	<table>
		<tr>
			<th>예약 번호</th>
			<th>예약자 성함</th>
			<th>예약자 전화번호</th>
			<th>예약 날짜</th>
			<th>예약 시간</th>
			<th>예약 인원</th>
		 	<th>예약 상태</th>
		</tr>
		<tr>
			<c:forEach items="${rsrvtList}" var="rsrvt">
				<td align="center">${rsrvt.num}</td>
				<td align="center">${rsrvt.rsrvtName}</td>
				<td align="center">${rsrvt.phoneNo}</td>
				<td align="center">${rsrvt.rsrvtDate}</td>
				<td align="center">${rsrvt.rsrvtTime}</td>
				<td align="center">${rsrvt.people}</td>
				<td align="center">${rsrvt.confirm}</td>
				
			</c:forEach>
		</tr>
	</table>
</body>
</html>