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
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta charset="UTF-8">
<title>예약 페이지</title>
<style type="text/css">
th {
	width:20%;
	height:55px;
	vertical-align:middle !important;
}
</style>

<script>
	//예약날짜에 달력 세팅
	$(function() {
		let id = '';
		let dayoff = true;
		$("#datepicker").datepicker({
			minDate : "+1d",
			//휴무일 세팅
			beforeShowDay : setDayoff
		});
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

	function setDayoff(date) {
		let day = date.getDay();
		let offList = [];
		$('input[name="dayoff"]').each(function(index, item) {
			if ($(item).val() == "Y") {
				offList.push($(item).attr('id')); //id를 list에 담음
			}
		});

		//false면 선택 안됨
		return [ (offList.indexOf(String(day)) == -1) ];
	}

	function iamPay() {
		 
		let IMP = window.IMP
		IMP.init("imp01555276") //가맹점 식별코드
		IMP.request_pay({
			pg : "kakaopay", // 상점구분. 카카오페이
			pay_method : "card", //결제 방식 : 카드
			merchant_uid : "밥케팅 예약금 결제", //주문번호 : 주문별로 유일한 값으로 필요함 usrrid-session id 값
			name : $('h2').text(), //주문상품명. ex) 사과 외 3건
			amount : "5000", //전체 주문 금액
			buyer_email : $('input[name="userId"]').val(), //주문자 이메일 테스트
			buyer_name : $('input[name="rsrvtName"]').val(),//주문자 성명
			buyer_tel : $('input[name="userTel"]').val(), //주문자 전화번호
		}, function(rsp) {
			if (rsp.success) {
				let msg = "결제가 완료 되었습니다."
		//		msg += "\n:고유:ID : " + rsp.imp_uid
				msg += "\n:상점ID : " + rsp.merchant_uid
				msg += "\n:결제금액 :  " + rsp.paid_amount
				alert(msg)
				$('form').submit();

			} else {
				alert("결제에 실패 했습니다.:" + rsp.error_msg)
			}

		})

	}
</script>

</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div
			style="display: block; margin: auto; width: 1000px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<header class="l_member_header">
							<h2 class="tit">
								<span>${restaurant.name} 예약 페이지</span>
							</h2>
						</header>
					</div>
					<form:form modelAttribute="reservation" method="post"
						action="reservationadd">
						<spring:hasBindErrors name="reservation">
							<font color="red"> <c:forEach
									items="${errors.globalErrors}" var="error">
									<spring:message code="${error.code}" />
									<br>
								</c:forEach>
							</font>
						</spring:hasBindErrors>
						<br>
						<table class="w3-table-all">
							<tr>
								<th>예약자 이름</th>
								<td><form:input path="rsrvtName" class="w3-input" placeholder="예약자 이름" /> <font
									color="red"> <form:errors path="rsrvtName" />
								</font></td>
							</tr>
							<tr>
								<th>예약자 전화번호</th>
								<td><form:input path="phoneNo" placeholder="전화번호" class="w3-input" /> <font
									color="red"> <form:errors path="phoneNo" />
								</font></td>
								<td><input type="hidden" name="restNum" value="${restNum}"></td>
							</tr>
							<tr>
								<th>예약 인원</th>
								<td><form:select path="people" class="w3-select">
										<option value="0">예약인원</option>
										<option value="1">1명</option>
										<option value="2">2명</option>
										<option value="3">3명</option>
										<option value="4">4명</option>
									</form:select> <font color="red"> <form:errors path="people" />
								</font></td>
							</tr>
							<tr>
								<th>예약 날짜</th>
								<td><form:input id="datepicker" path="rsrvtDate" class="w3-input"
										autocomplete='off' placeholder="예약날짜" /> <font color="red">
										<form:errors path="rsrvtDate" />
								</font></td>
							</tr>
							<tr>  
								<th>예약 시간</th>
								<td><form:select id="rsrvtTime" path="rsrvtTime" class="w3-select">
										<option value="">예약 시간</option>
										<c:forEach var="i" begin="${restaurant.open}"
											end="${restaurant.close}">
											<option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}:00</option>
										</c:forEach>
									</form:select> <font color="red"> <form:errors path="rsrvtTime" />
								</font></td>
							</tr>
						</table>
						<br>
							 <input type="submit" class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge" value="예약" name="add">
						<!-- 예약 완료 시 예약 상세 페이지로 이동하기 -->
<!-- 						<input type="button" class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge" 
								name="add" value="예약 및 예약금 결제" onclick="javascript:iamPay()"> -->
								&nbsp;
						<input type="button" class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge" value="취소" onclick="javascript:history.back()">
					</form:form>

					<input type="hidden" id="0" name="dayoff" value="${dayoff.sun}" />
					<input type="hidden" id="1" name="dayoff" value="${dayoff.mon}" />
					<input type="hidden" id="2" name="dayoff" value="${dayoff.tue}" />
					<input type="hidden" id="3" name="dayoff" value="${dayoff.wed}" />
					<input type="hidden" id="4" name="dayoff" value="${dayoff.thur}" />
					<input type="hidden" id="5" name="dayoff" value="${dayoff.fri}" />
					<input type="hidden" id="6" name="dayoff" value="${dayoff.sat}" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>