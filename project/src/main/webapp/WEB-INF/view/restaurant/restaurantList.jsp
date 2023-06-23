<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
	<form action="restaurantList" method="post" name="searchform">
	
		<div>
			<select name="type">
				<option value="">전체</option>
				<option value="name">가게이름</option>
				<option value="addresss">지역</option>
				<option value="addresss">지역</option>
				<option value="menu">메뉴</option>
			</select>
		</div>
		<div>
			<input type="text" name="searchcontent" class="w3-input">
		</div>
		<div>
			<%-- 	<form:form modelAttribute="restaurant" method="post"
		action="restaurantList">  --%>
			<img src="../../img/${rest.pictureUrl}">
			<h2>가게 이름</h2>
			<h2>가게 전화번호</h2>
		</div>
		<div></div>
		<table class="w3-table-all">
			<c:forEach items="${restList}" var="rest">
				<tr>
					<td align="center">이름 : ${rest.name}</td>
					<td align="center">주소 : ${rest.address}</td>
				</tr>
			</c:forEach>
		</table>
	</form>
</body>
</html>
