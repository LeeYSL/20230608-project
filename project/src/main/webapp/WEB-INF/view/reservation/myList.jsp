<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta charset="UTF-8">
<title>내 예약 목록</title>
</head>
<body>

	<script>
		function update(btn) {
			//취소기 때문에 3으로 고정
			//	let confirm = $(btn).parent().siblings().find('c:choose').val
			let num = $(btn).attr('name');

			$.ajax({
				url : '/project/reservation/myList',
				type : 'POST',
				data : {
					'num' : num,
					'confirm' : 3
				},
				,success:function(result) {
					  //예약취소로 문구로 변경하고 취소 버튼을 숨김
					  $(btn).parent().siblings('td[name="tdConfirm"]').text("예약 취소");
					  $(btn).hide();
				  }
			})
		}
	</script>

	<h2>예약 목록</h2>
	<table class="w3-table-all">
		<tr>
			<th>예약자 성함</th>
			<th>예약자 전화번호</th>
			<th>예약 날짜</th>
			<th>예약 시간</th>
			<th>예약 인원</th>
			<th>예약 상태</th>
		</tr>
		<c:forEach items="${rsrvtList}" var="rsrvt">
			<tr>
				<td align="center">${rsrvt.rsrvtName}</td>
				<td align="center">${rsrvt.phoneNo}</td>
				<td align="center">${rsrvt.rsrvtDate}</td>
				<td align="center">${rsrvt.rsrvtTime}</td>
				<td align="center">${rsrvt.people}</td>
				<td><c:choose>
						<c:when test="${rsrvt.confirm == 0}">
							<p>예약 대기</p>
						</c:when>
						<c:when test="${rsrvt.confirm == 1}">
							<p>예약 확정</p>
						</c:when>
						<c:when test="${rsrvt.confirm == 2}">
							<p>예약 거절</p>
						</c:when>
						<c:when test="${rsrvt.confirm == 3}">
							<p>예약 취소</p>
						</c:when>
					</c:choose> <input type="hidden" ${rsrvt.userId}>
				<td><input type="hidden" ${rsrvt.num}></td>
				<td><c:if test="${rsrvt.confirm == 0 || rsrvt.confirm == 1}">
						<button type="button" name="${rsrvt.num}" onclick="update(this)">취소</button>
					</c:if>
				<td><a href="myListInfo?num=${rsrvt.num}"> <input
						type="button" value="상세보기">
				</a></td>
		</c:forEach>
		<tr>
			<td colspan="5" style="text-align: center;"><c:if
					test="${pageNum <=1 }">[이전]</c:if> <c:if test="${pageNum > 1 }">
					<a href="myList?pageNum="${pageNum-1}>[이전]</a>
				</c:if> <c:forEach var="a" begin="${startpage}" end="${endpage}">
					<c:if test="${a==pageNum}">[${a}]</c:if>
					<c:if test="${a != pageNum }">
						<a href="myList?pageNum=${a}">[${a}]</a>
					</c:if>
				</c:forEach> <c:if test="${pageNum >= maxpage}">[다음]</c:if> <c:if
					test="${pageNum < maxpage}">
					<a href="myList?pageNum="${pageNum+1}>[다음]</a>
				</c:if></td>
		</tr>


		<c:if test="${listcount == 0}">
			<tr>
				<td colspan="5">등록된 예약이 없습니다.</td>

			</tr>

		</c:if>
	</table>
</body>