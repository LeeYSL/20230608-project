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
	<form action="myList">
		<h2>���� ���</h2>
		<table>
			<tr>
				<th>������ ����</th>
				<th>������ ��ȭ��ȣ</th>
				<th>���� ��¥</th>
				<th>���� �ð�</th>
				<th>���� �ο�</th>
				<th>���� ����</th>
			</tr>
			<c:forEach items="${rsrvtList}" var="rsrvt">
				<tr>
					<td align="center">${rsrvt.rsrvtName}</td>
					<td align="center">${rsrvt.phoneNo}</td>
					<td align="center">${rsrvt.rsrvtDate}</td>
					<td align="center">${rsrvt.rsrvtTime}</td>
					<td align="center">${rsrvt.people}</td>
					<td>
					<select>
						<option value="1">Ȯ��</option>
						<option value="2">���� ���</option>
					</select>
					<input type="hidden" ${rsrvt.confirm}>
					 <input type="hidden" ${rsrvt.userId}>
					 <td><input type="hidden" ${rsrvt.num}></td>
					<td><input type="submit" value="Ȯ��" name="confirm"></td>
					<td>
					    <a href="myListInfo?num=${rsrvt.num}">
					      <input type="button" value="�󼼺���">
					    </a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>
</body> ��