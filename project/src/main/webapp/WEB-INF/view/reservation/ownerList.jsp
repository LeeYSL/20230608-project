<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사장 로그인 예약 목록</title>
</head>
<body>
	<h2>예약 리스트</h2>
	<form:form modelAttribute="reservation" method="post"
		action="confirm">
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
			<c:forEach items="${reservation}" var="rsrvt">
				<tr>
					<td align="center">${rsrvt.num}</td>
					<td align="center">${rsrvt.rsrvtName}</td>
					<td align="center">${rsrvt.phoneNo}</td>
					<td align="center">${rsrvt.rsrvtDate}</td>
					<td align="center">${rsrvt.rsrvtTime}</td>
					<td align="center">${rsrvt.people}</td>
					<td align="center">${rsrvt.confirm}</td>
					<td><form:select path="confirm">
							<option value="1">승인 대기</option>
							<option value="2">승인</option>
							<option value="1">거절</option>
						</form:select></td>
					<td><input type="submit" value="확정" name="confirm"></td>
				</tr>
			</c:forEach>
		</table>
	</form:form>
</body>
</html>