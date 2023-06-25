<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사장 회원 가게 목록 조회하기</title>
</head>
<body>
	<form action="ownerRest" method="post" name="owrestList">
		<table>
		   <tr>
		   <tr>
		  
			<tr>
				<th>식당 이름</th>
				<th>식당 위치</th>
				<th>식당 전화번호</th>
				<th></th>
			</tr>
			<c:forEach items="${ownerRest}" var="orsrvt">
				<tr>
					<td align="center">${orsrvt.name}</td>
					<td align="center">${orsrvt.address}</td>
					<td align="center">${orsrvt.restPhoneNo}</td>

					<td><input type="hidden" ${orsrvt.userId}></td>
					<td>
					  <a href="ownerRestInfo?num=${orsrvt.num}"> 
					  <input type="button" value="상세보기">
					  </a>
				    </td>
				</tr>
				
			</c:forEach>
		</table>
	</form>
</body>
</html>