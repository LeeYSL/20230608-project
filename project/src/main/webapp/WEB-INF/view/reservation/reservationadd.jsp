<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta charset="UTF-8">
<title>예약 페이지</title>
<style type="text/css">
.side {
	margin: 0% 25% 0% 25%;
	height: 100%;
	text-align: center;
	display: block;
}

.page {
	border: 1px gray solid;
	height: 10%;
	display: block;
}

.txt {
	font-size: 200%;
}

.join_insert {
	height: 90%;
	border: 1px gray solid;
	text-align: center;
	display: block;
}

table {
	border: 1px gray solid;
	width: 90%;
	margin: 5%;
}

th {
	width: 20%;
}
</style>

<script>
	//예약날짜에 달력 세팅
	$(function() {
		$("#datepicker").datepicker({minDate:"+1d"});
	});

	$.datepicker.setDefaults({
		dateFormat : 'yymmdd',
		prevText : '이전 달',
		nextText : '다음 달',
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
				'10월', '11월', '12월' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
				'9월', '10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		showMonthAfterYear : true,
		yearSuffix : '년'
	});
	
	//예약 버튼 눌렀을 때 예약날짜 + 예약시간 합쳐줌
	function setDate() {
		const date = $('#datepicker');
		const beforeVal = date.val();
		date.val(beforeVal + $('#rsrvtTime').val());
	}
</script>

</head>
<body>
	<div class="side">
		<div class="page">
			<div>
				<div class="txt">예약 창입니다.</div>
			</div>
		</div>
		<div class="join_insert">
			<form:form modelAttribute="reservation" method="post"
				onsubmit="return setDate()" action="reservationadd">
				<spring:hasBindErrors name="reservation">
					<font color="red"> <c:forEach items="${errors.globalErrors}"
							var="error">
							<spring:message code="${error.code}" />
							<br>
						</c:forEach>
					</font>
				</spring:hasBindErrors>
				<div class="join_title">
					<h2>${restaurant.name}</h2>
				</div>
				<table class="join_table">
					<tr>
						<td><form:input path="rsrvtName" placeholder="예약자 이름" /> <font
							color="red"> <form:errors path="rsrvtName" />
						</font></td>
					</tr>
					<tr>
						<td><form:input path="phoneNo" placeholder="전화번호" /> <font
							color="red"> <form:errors path="phoneNo" />
						</font></td>
					</tr>
					<tr>
						<td><form:select style="width:200" path="people">
								<option value="0">===예약인원===</option>
								<option value="1">1명</option>
								<option value="2">2명</option>
								<option value="3">3명</option>
								<option value="4">4명</option>
							</form:select> <font color="red"> <form:errors path="people" />
						</font></td>
					</tr>
					<tr>
						<td><form:input id="datepicker" path="rsrvtDate"
								placeholder="예약날짜" /> <font color="red"> <form:errors
									path="rsrvtDate" />
						</font></td>
					</tr>
					<tr>
						<td>
							<form:select id="rsrvtTime" path="rsrvtTime">
								<option value="">예약 시간</option>
								<c:forEach var="i" begin="1" end="24">
									<option value="${i}">${i>9?i:'0'}${i>9?'':i}:00</option>
								</c:forEach>
							</form:select>
							<font color="red"> <form:errors path="rsrvtTime" />
						</font></td>
					</tr>
				</table>
				<input type="submit" value="예약" name="add">
				<!-- 예약 상세 페이지로 이동하긴 -->
				<input type="button" value="취소" name="add">
			</form:form>
		</div>
	</div>
</body>
</html>