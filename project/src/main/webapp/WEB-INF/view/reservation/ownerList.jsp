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
			<c:forEach items="${rsrvtList}" var="rsrvt"> <!--reservation 객체를 만들어서 rstvt라는 이름에 넣고 필요한 요소들을 뽑아온다.  -->
				<tr>
					<td align="center">${rsrvt.num}</td>
					<td align="center">${rsrvt.rsrvtName}</td>
					<td align="center">${rsrvt.phoneNo}</td>
					<td align="center">${rsrvt.rsrvtDate}</td>
					<td align="center">${rsrvt.rsrvtTime}</td>
					<td align="center">${rsrvt.people}</td>
					<td align="center">${rsrvt.confirm}</td>
					<td><select>
							<option value="1">승인 대기</option>
							<option value="2">승인</option>
							<option value="3">거절</option>
						</select></td>
					<td><input type="submit" value="확정" name="confirm"></td>
				</tr>
			</c:forEach>
		</table>
</body>
</html>