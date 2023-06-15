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
				<td><form:input path="name" placeholder="상호명" /> <font
					color="red"> <form:errors path="name" />
				</font></td>
			</tr>
			<tr>
				<td><form:input path="picture" placeholder="가게사진" /> <font
					color="red"> <form:errors path="picture" />
				</font>
				</td>
			</tr>
			<tr>
				<td>
					<form:input path="open" placeholder="여는시간" /> 
					<font color="red"> <form:errors path="open" /></font>
				</td>
	        </tr>
	        <tr>			
				<td><form:input path="close" placeholder="닫는시간" /> <font
					color="red"> <form:errors path="close" />
				</font></td>
			</tr>
			<tr>
				<td><form:input path="tel" placeholder="전화번호" /> <font
					color="red"> <form:errors path="tel" />
				</font></td>
			</tr>
			<tr>
				<td><form:input path="maxpeople" placeholder="최대인원수" /> <font
					color="red"> <form:errors path="maxpeople" />
				</font></td>
			</tr>
			<tr>
			<tr>
				<td><form:input path="address" placeholder="주소" /> <font
					color="red"> <form:errors path="address" />
				</font></td>
			</tr>
			<tr>
				<td><form:input path="licenseNum" placeholder="사업자번호" /> <font
					color="red"> <form:errors path="licenseNum" />
				</font></td>
			</tr>
			<tr>
				<td><form:checkbox path="dayoff.mon" value="Y"/>월요일
                <font
					color="red"> <form:errors path="dayoff.mon"  />
				</font></td>
				<td><form:checkbox path="dayoff.tue" value="Y"/>화요일
                <font
					color="red"> <form:errors path="dayoff.tue" />
				</font></td>
				<td><form:checkbox path="dayoff.wed" value="Y"/>수요일
                <font
					color="red"> <form:errors path="dayoff.wed" />
				</font></td>
				<td><form:checkbox path="dayoff.thur" value="Y"/>목요일
                <font
					color="red"> <form:errors path="dayoff.thur" />
				</font></td>
				<td><form:checkbox path="dayoff.fri" value="Y"/>금요일
                <font
					color="red"> <form:errors path="dayoff.fri" />
				</font></td>
				<td><form:checkbox path="dayoff.sat" value="Y"/>토요일
                <font
					color="red"> <form:errors path="dayoff.sat" />
				</font></td>
				<td><form:checkbox path="dayoff.sun" value="Y"/>일요일
                <font
					color="red"> <form:errors path="dayoff.sun" />
				</font></td>
				<td><form:checkbox path="dayoff.holiday" value="Y"/>공휴일
                <font
					color="red"> <form:errors path="dayoff.holiday" />
				</font></td>
			</tr>
		</table>
		<br>
		<td><input type="submit" value="등록" name="add"></td>
	</form:form>
</body>
</html>