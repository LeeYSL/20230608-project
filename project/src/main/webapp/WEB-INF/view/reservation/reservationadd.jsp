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
   <div>예매 창입니다.</div>
   <form:form modelAttribute="reservation" method="post" action="reservationadd">
      <spring:hasBindErrors name="reservation"></spring:hasBindErrors>
   
   
   
   </form:form>
</body>
</html>