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
		<spring:hasBindErrors name="reservation">
			<font color="red"> <c:forEach items="${errors.globalErrors}"
					var="error">
					<spring:message code="${error.code}" />
					<br>
				</c:forEach>
			</font>
		</spring:hasBindErrors>
		<table>
		<tr> 
				<td>가게이름</td>
				<td><form:input path="name" value="" /></td>
				<td><font color="red"><form:errors path="name" /></font></td>
			</tr>
			<tr>
				<td>가게 전화번호</td>
				<td><form:input path="restPhoneNo" /></td>
				<td><font color="red"><form:errors path="restPhoneNo" /></font></td>
			</tr>
			<tr>
				<td>예약자 이름</td>
				<td><form:input path="rsrvtName" /></td>
				<td><font color="red"><form:errors path="rsrvtName" /></font></td>
			</tr>
			<tr>
				<td>예약자 전화번호</td>
				<td><form:input path="phoneNo" /></td>
				<td><font color="red"><form:errors path="phoneNo" /></font></td>
			</tr>
			<tr>
				<td>예약 날짜</td>
				<td><form:input path="rsrvtDate" /></td>
				<td><font color="red"><form:errors path="rsrvtDate" /></font></td>
			</tr>
			<tr>
				<td>예약 시간</td>
				<td><form:input path="rsrvtTime" /></td>
				<td><font color="red"><form:errors path="rsrvtTime" /></font></td>
			</tr>
			<tr>
			   <td colspan="3"><input type="submit" value="수정등록">&nbsp;
			   <input type="button" value="상품목록" onclick="location.href='list'"></td>
			</tr>
			<tr>
				<td><input type="submit" value="수정 완료" name="update"></td>
				<td><input type="button" value="확인"></td>
			</tr>
		</table>
	</form:form>
</body>
</html>