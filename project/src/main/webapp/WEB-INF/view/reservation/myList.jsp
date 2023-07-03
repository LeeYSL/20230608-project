<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta charset="UTF-8">
<title>�� ���� ���</title>
<script type="text/javascript">
	function win_open(page) {
		var op = "width=500, height=350, left=50, top=150";
		open(page, "", op);
	}
</script>
</head>
<body>

	<script>
		function update(btn) {
			//��ұ� ������ 3���� ����
			//	let confirm = $(btn).parent().siblings().find('c:choose').val
			let num = $(btn).attr('name');

			$.ajax({
				url : '/project/reservation/myList',
				type : 'POST',
				data : {
					'num' : num,
					'confirm' : 3
				},
				success : function(result) {
					//������ҷ� ������ �����ϰ� ��� ��ư�� ����
					$(btn).parent().siblings('td[name="tdConfirm"]').find('p')
							.text("���� ���");
					$(btn).hide();
				}
			})
		}
	</script>

	<h2>���� ���</h2>
	<table class="w3-table-all">
		<tr>
		    <th>���� �󼼺���</th>
			<th>���� �̸�</th>
			<th>������ ����</th>
			<th>������ ��ȭ��ȣ</th>
			<th>���� ��¥</th>
			<th>���� �ð�</th>
			<th>���� �ο�</th>
			<th>���� ����</th>
			<th></th>
			<th></th>
			<th></th>
			<th>����</th>
		</tr>
		<c:forEach items="${rsrvtList}" var="rsrvt">
			<tr>
				<td><a href="myListInfo?num=${rsrvt.num}"> <input
						type="button" value="�󼼺���">
				</a></td>
				<td align="center">${rsrvt.name}</td>
				<td align="center">${rsrvt.rsrvtName}</td>
				<td align="center">${rsrvt.phoneNo}</td>
				<td align="center">${rsrvt.rsrvtDate}</td>
				<td align="center">${rsrvt.rsrvtTime}</td>
				<td align="center">${rsrvt.people}</td>
				<td name="tdConfirm"><c:choose>
						<c:when test="${rsrvt.confirm == 0}">
							<p>���� ���</p>
						</c:when>
						<c:when test="${rsrvt.confirm == 1}">
							<p>���� Ȯ��</p>
						</c:when>
						<c:when test="${rsrvt.confirm == 2}">
							<p>���� ����</p>
						</c:when>
						<c:when test="${rsrvt.confirm == 3}">
							<p>���� ���</p>
						</c:when>
						<c:when test="${rsrvt.confirm == 4}">
							<p>�̿� �Ϸ�</p>
						</c:when>
					</c:choose> <input type="hidden" ${rsrvt.userId}>
				<td><input type="hidden" ${rsrvt.num}></td>
				<td><input type="hidden" ${rsrvt.point}></td>
				<td><c:if test="${rsrvt.confirm == 0 || rsrvt.confirm == 1}">
						<button type="button" name="${rsrvt.num}" onclick="update(this)">���</button>
					</c:if>
				<td name="${rsrvt.num}">
					 <c:if test="${rsrvt.confirm == 4 && rsrvt.point == '0'}">
						<button type="button" name="${rsrvt.num}"
								onclick="win_open('point?num=${rsrvt.num}')">���� ���</button>
					</c:if> 
					<c:if test="${rsrvt.confirm == 4 && rsrvt.point != '0'}">
						${rsrvt.point}��
					</c:if>
				</td>
		</c:forEach>
		<tr>
			<td colspan="5" style="text-align: center;"><c:if
					test="${pageNum <= 1}">[����]</c:if> <c:if test="${pageNum > 1 }">
					<a href="myList?pageNum=${pageNum-1}">[����]</a>
				</c:if> <c:forEach var="a" begin="${startpage}" end="${endpage}">
					<c:if test="${a==pageNum}">[${a}]</c:if>
					<c:if test="${a != pageNum }">
						<a href="myList?pageNum=${a}">[${a}]</a>
					</c:if>
				</c:forEach> <c:if test="${pageNum >= maxpage}">[����]</c:if> <c:if
					test="${pageNum < maxpage}">
					<a href="myList?pageNum=${pageNum+1}">[����]</a>
				</c:if></td>
		</tr>
		<c:if test="${listcount == 0}">
			<tr>
				<td colspan="5">��ϵ� ������ �����ϴ�.</td>
			</tr>
		</c:if>
	</table>
</body>