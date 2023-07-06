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
</head>
<body>

	<script>
		function win_open(page) {
			var op = "width=500, height=350, left=50, top=150";
			open(page, "", op);
		}

		function update(btn) {
			//��ұ� ������ 3���� ����
			//	let confirm = $(btn).parent().siblings().find('c:choose').val
			let num = $(btn).attr('name');

			$.ajax({
				url : '/project/reservation/myList',
				type : 'POST',
				data : {
					'num' : num,
					'confirm' : 3,
					'restName' : $(btn).parent()
							.siblings('td[name="restName"]').text(),
					'rsrvtName' : $(btn).parent().siblings(
							'td[name="rsrvtName"]').text(),
					'phoneNo' : $(btn).parent().siblings('td[name="phoneNo"]')
							.text()
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

	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1100px; ">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<header class="l_member_header">
							<h1 class="tit">
								<span>���� ���</span>
							</h1>
						</header>
					</div>
					<table class="w3-table-all">
						<tr>
							<th style="text-align: center;">���� �󼼺���</th>
							<th style="text-align: center;">���� �̸�</th>
							<th style="text-align: center;">������ ����</th>
							<th style="text-align: center;">������ ��ȭ��ȣ</th>
							<th style="text-align: center;">���� ��¥</th>
							<th style="text-align: center;">���� �ð�</th>
							<th style="text-align: center;">���� �ο�</th>
							<th style="text-align: center;">���� ����</th>
							<th style="text-align: center;">���� ���</th>
							<th style="text-align: center;">����</th>
						</tr>
						<c:forEach items="${rsrvtList}" var="rsrvt">
							<tr>
								<td style="text-align: center;">
									<button type="button" class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge"
											onclick="location.href='myListInfo?num=${rsrvt.num}'">�󼼺���</button>
								</td>
								<td name="restName" style="vertical-align:middle;">${rsrvt.name}</td>
								<td name="rsrvtName" style="vertical-align:middle;">${rsrvt.rsrvtName}</td>
								<td name="phoneNo" style="text-align: center; vertical-align:middle;">${rsrvt.phoneNo}</td>
								<td align="center" style="text-align: center; vertical-align:middle;">${rsrvt.rsrvtDate}</td>
								<td align="center" style="text-align: center; vertical-align:middle;">${rsrvt.rsrvtTime}</td>
								<td align="center" style="vertical-align:middle;">${rsrvt.people}</td>
								<td name="tdConfirm" style="text-align: center; vertical-align:middle;">
									<c:choose>
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
								<td><c:if
										test="${rsrvt.confirm == 0 || rsrvt.confirm == 1}">
										<button type="button" name="${rsrvt.num}"
											class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge"
											onclick="update(this)">���</button>
									</c:if>
								<td name="${rsrvt.num}" style="text-align:center;">
									<c:if test="${rsrvt.confirm == 4 && rsrvt.point == '0'}">
										<button type="button" name="${rsrvt.num}"
											class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge"
											onclick="win_open('point?num=${rsrvt.num}')">���� ���</button>
									</c:if> 
									<c:if test="${rsrvt.confirm == 4 && rsrvt.point != '0'}">
										${rsrvt.point}��
									</c:if>
								</td>
						</c:forEach>
						<tr>
							<c:if test="${listcount == 0}">
								<td colspan="10" align="right">��ϵ� ������ �����ϴ�.</td>
							</c:if>
							<c:if test="${listcount != 0}">
								<td colspan="10" style="text-align: center;"><c:if
										test="${pageNum <= 1}">[����]</c:if> <c:if
										test="${pageNum > 1 }">
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
							</c:if>
						</tr>
					</table>
					<input type="hidden" ${rsrvt.num}>
					<input type="hidden" ${rsrvt.point}>
				</div>
			</div>
		</div>
	</div>
</body>