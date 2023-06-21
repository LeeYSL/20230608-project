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
	<form action="myList">
		<h2>예약 목록</h2>
		<table>
			<tr>
				<th>예약자 성함</th>
				<th>예약자 전화번호</th>
				<th>예약 날짜</th>
				<th>예약 시간</th>
				<th>예약 인원</th>
				<th>예약 상태</th>
			</tr>
			<c:forEach items="${rsrvtList}" var="rsrvt">
				<tr>
					<td align="center">${rsrvt.rsrvtName}</td>
					<td align="center">${rsrvt.phoneNo}</td>
					<td align="center">${rsrvt.rsrvtDate}</td>
					<td align="center">${rsrvt.rsrvtTime}</td>
					<td align="center">${rsrvt.people}</td>
					<td>
					<select>
						<option value="1">확인</option>
						<option value="2">예약 취소</option>
					</select>
					<input type="hidden" ${rsrvt.confirm}>
					 <input type="hidden" ${rsrvt.userId}>
					 <td><input type="hidden" ${rsrvt.num}></td>
					<td><input type="submit" value="확정" name="confirm"></td>
					<td>
					    <a href="myListInfo?num=${rsrvt.num}">
					      <input type="button" value="상세보기">
					    </a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>
</body> 　