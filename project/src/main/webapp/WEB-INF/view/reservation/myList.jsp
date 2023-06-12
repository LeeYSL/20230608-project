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
<h2>${userName}</h2>
	<table>
	<tr>
		<form action="mylist" method="post" name="myList">
			<tr>
				<td colspan="5">
			</tr>
			<tr>
				<th>번호</th>
				<th>예약자</th>
				<th>예약인원</th>
				<th>예약날짜</th>
				<th>날짜</th>
				<input type="button" value="예약취소">
				<c:forEach var="rsrvt" items="{rsrvtList}">
				
				
				
				</c:forEach>
			</tr>
		</form>
		</tr>
	</table>
</body>
</html>