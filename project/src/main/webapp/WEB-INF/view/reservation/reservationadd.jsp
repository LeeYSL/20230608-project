<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 페이지</title>
</head>
<body>
	<h2>${restaurant.name}</h2>
	<div>예약 창입니다.</div>
	<form:form modelAttribute="reservation" method="post"
		action="reservationadd">
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
		  	<td>
			 		<form:input path="rsrvtName" placeholder="예약자 이름" />
			 		  <font color="red">
						  <form:errors path="rsrvtName" />
					  </font>
			 	</td>
			 </tr>
			 <tr>
			   <td>
			 	<form:input path="phoneNo" placeholder="전화번호" />
			 		 <font color="red">
						 <form:errors path="phoneNo" />
					 </font>
			   </td>
			 </tr>
			 <tr>
			   <td>
			 	  <form:input path="people" placeholder="인원수" />
			 		  <font color="red">
						  <form:errors path="people" />
					  </font>
			   </td>
			  </tr>
			  <tr>
			   <td>
			 	  <form:input path="rsrvtDate" placeholder="예약날짜" />
			 		  <font color="red">
						  <form:errors path="rsrvtDate" />
					  </font>
			   </td>
			  </tr>
		</table>



	</form:form>
</body>
</html>