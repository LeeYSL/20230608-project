<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>�� ���� ���</title>
</head>
<body>
<h2>${userName}</h2>
	<table>
	<tr>
		<form action="mylist" method="post" name="myList">
			<tr>
				<td colspan="5">
			</tr>
			<tr>
				<th>��ȣ</th>
				<th>������</th>
				<th>�����ο�</th>
				<th>���೯¥</th>
				<th>��¥</th>
				<input type="button" value="�������">
				<c:forEach var="rsrvt" items="{rsrvtList}">
				
				
				
				</c:forEach>
			</tr>
		</form>
		</tr>
	</table>
</body>
</html>