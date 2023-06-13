<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>가게 등록</h2>
	<div>가게등록하는 창입니다.</div>
	<form:form modelAttribute="restaurant" method="post" action="add">
	<spring:hasBindErrors name="restaurant">
				<font color="red">
					<c:forEach items="${errors.globalErrors}" var="error">
						<spring:message code="${error.code}" /> <br> 
					</c:forEach>
				</font>
			</spring:hasBindErrors>
		<table>
			 <tr>
			 	<td>
			 		<form:input path="name" placeholder="상호명" />
			 		  <font color="red">
						  <form:errors path="name" />
					  </font>
			 	</td>
			 </tr>
			  <tr>
			 	<td>
			 		<form:input path="picture" placeholder="가게사진" />
			 		  <font color="red">
						  <form:errors path="picture" />
					  </font>
			 	</td>
			 </tr>
			 <tr>
			   <td>
			 	<form:input path="tel" placeholder="전화번호" />
			 		 <font color="red">
						 <form:errors path="tel" />
					 </font>
			   </td>
			 </tr>
			 <tr>
			   <td>
			 	  <form:input path="address" placeholder="주소" />
			 		  <font color="red">
						  <form:errors path="address" />
					  </font>
			   </td>
			  </tr>
			  <tr>
			   <td>
			 	  <form:input path="licenseName" placeholder="사업자번호" />
			 		  <font color="red">
						  <form:errors path="licenseName" />
					  </font>
			   </td>
			  </tr>
		</table>
		<tr>
			<td>휴무일</td>
			<h2>휴무일</h2>
			<input type="checkbox" name="dayOff" value="Mon">월요일
			<input type="checkbox" name="dayOff" value="Tue">화요일
			<input type="checkbox" name="dayOff" value="Wed">수요일
			<input type="checkbox" name="dayOff" value="Thur">목요일
			<input type="checkbox" name="dayOff" value="Fri">금요일
			<input type="checkbox" name="dayOff" value="Sat">토요일
			<input type="checkbox" name="dayOff" value="Sun">일요일
			<input type="checkbox" name="dayOff" value="holidDay">공휴일
		</tr>
		<form>
			<table>
				<tr>
					<td>메뉴</td>
					<td>가격</td>
				</tr>
			</table>
		</form>
		<td><input type="submit" value="등록" name="add"></td>
	</form:form>
</body>
</html>