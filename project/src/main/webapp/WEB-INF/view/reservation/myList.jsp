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
	<h2>���� ���</h2>
	<table>
		<tr>
			<th>���� ��ȣ</th>
			<th>������ ����</th>
			<th>������ ��ȭ��ȣ</th>
			<th>���� ��¥</th>
			<th>���� �ð�</th>
			<th>���� �ο�</th>
		 	<th>���� ����</th>
		</tr>
		<tr>
			<c:forEach items="${rsrvtList}" var="rsrvt">
				<td align="center">${rsrvt.num}</td>
				<td align="center">${rsrvt.rsrvtName}</td>
				<td align="center">${rsrvt.phoneNo}</td>
				<td align="center">${rsrvt.rsrvtDate}</td>
				<td align="center">${rsrvt.rsrvtTime}</td>
				<td align="center">${rsrvt.people}</td>
				<td align="center">${rsrvt.confirm}</td>
				
			</c:forEach>
		</tr>
	</table>
</body>
</html>