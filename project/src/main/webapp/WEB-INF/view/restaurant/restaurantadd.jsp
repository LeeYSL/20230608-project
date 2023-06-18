<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가게 등록</title>
</head>
<body>
	<h2>가게 등록</h2>
	<div>가게등록하는 창입니다.</div>
	<form:form modelAttribute="restaurant" method="post"
		action="restaurantadd">
		<spring:hasBindErrors name="restaurant">
			<font color="red"> <c:forEach items="${errors.globalErrors}"
					var="error">
					<spring:message code="${error.code}" />
					<br>
				</c:forEach>
			</font>
		</spring:hasBindErrors>
		<table>
			<tr>
				<td><form:input path="name" placeholder="상호명" /> </td>
				<td><font color="red"> <form:errors path="name" /></font></td>
			</tr>
			<tr>
				<td><input style="width:185" type="file" name="picture" ></td>
			</tr>
			<tr>
				<td>
					<form:select path="open">
						<option value="0">여는 시간</option>
						<c:forEach var="i"  begin="1" end="24">
        					<option value="${i}">${i>9?i:'0'}${i>9?'':i}:00</option>
    					</c:forEach>
    				</form:select>
				</td>
				<td><font color="red"> <form:errors path="open" /></font></td>
	        </tr>
	        <tr>			
				<td>
					<form:select path="close">
						<option value="0">닫는 시간</option>
						<c:forEach var="i"  begin="1" end="24">
        					<option value="${i}">${i>9?i:'0'}${i>9?'':i}:00</option>
    					</c:forEach>
    				</form:select>
				</td>
				<td><font color="red"> <form:errors path="close" /></font></td>
			</tr>
			<tr>
				<td><form:input path="tel" placeholder="전화번호" /> </td>
				<td><font color="red"> <form:errors path="tel" /></font></td>
			</tr>
			<tr>
				<td>
					<form:select path="maxpeople">
			             <option value="0" >===최대 예약 인원 수===</option>
			             <option value="1">1명</option>
			             <option value="2">2명</option>
			             <option value="3">3명</option>
			             <option value="4">4명</option>
					</form:select>
				</td>
				<td><font color="red"> <form:errors path="maxpeople" /></font></td>
			</tr>
			<tr>
			<tr>
				<td><form:input path="address" placeholder="주소" /> </td>
				<td><font color="red"> <form:errors path="address" /></font></td>
			</tr>
			<tr>
				<td><form:input path="licenseNum" placeholder="사업자번호" /> </td>
				<td><font color="red"> <form:errors path="licenseNum" /></font></td>
			</tr>
		</table>
		<table>
			<tr>
				<td><form:checkbox path="dayoff.mon" value="Y"/>월요일
					<form:checkbox path="dayoff.tue" value="Y"/>화요일
					<form:checkbox path="dayoff.wed" value="Y"/>수요일
					<form:checkbox path="dayoff.thur" value="Y"/>목요일
					<form:checkbox path="dayoff.fri" value="Y"/>금요일
					<form:checkbox path="dayoff.sat" value="Y"/>토요일
					<form:checkbox path="dayoff.sun" value="Y"/>일요일
					<form:checkbox path="dayoff.holiday" value="Y"/>공휴일
				</td>
			</tr>
		</table>
		<br>
		<td><input type="submit" value="등록" name="add"></td>
		<input type="button" value="취소" name="add">
	</form:form>
</body>
</html>