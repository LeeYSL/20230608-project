<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"> ></script>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>가게 등록</title>
<script>
	function searchAddress() {
		new daum.Postcode({
	        oncomplete: function(data) { // oncomplete : 콜백함수
	        	$("#address").val(data.address);
	        }
	    }).open();
	}

	//메뉴 추가 버튼 눌렀을 때 테이블에 row 추가.
	function addRow() {
		//메뉴 입력하는 row의 개수
		let idx = $('tr[name="menuTr"]').length;
		
		//추가 버튼을 누르면 row를 추가해줌
		let insertTr = "<tr name='menuTr'>";
  	  	insertTr += '<td style="text-align: center;"><input name="menuList['+idx+'].menuName" class="w3-input" placeholder="메뉴 이름"/></td>';
	  	insertTr += '<td style="text-align: center;"><input name="menuList['+idx+'].price" class="w3-input" placeholder="가격"/></td>';
	  	insertTr += "<td style='text-align: center;'>";
	  	insertTr += "<button type='button' name='btnDel' class='w3-btn w3-white w3-border w3-border-orange w3-round-xlarge' onclick='deleteRow(this);'>삭제</button></td>";
	  	insertTr += "</tr>";
	  	
		$('#menuTable tbody:last').append(insertTr);
	}
	
	//메뉴 삭제 버튼 눌렀을 때 해당 row 삭제.
	function deleteRow(del) {
		$(del).parent().parent().remove();
	}
	
	//등록 버튼 클릭 시 여는 시간 보다 닫는시간이 더 늦은지 체크
	function check() {
		const open = parseInt($('#open').val());
		const close = parseInt($('#close').val());
		
		if (open > close) {
			alert("여는시간이 닫는 시간보다 작아야합니다.");
			return false;
		}
	}
</script>
<style type="text/css">
th {
	width:20%;
}
</style>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div
			style="display: block; margin: auto; width: 1000px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<header class="l_member_header">
							<h1 class="tit">
								<span>가게 등록</span>
							</h1>
						</header>
					</div>
					<form:form modelAttribute="restaurant"
						enctype="multipart/form-data" method="post" action="restaurantadd"
						onsubmit="return check()">
						<spring:hasBindErrors name="restaurant">
							<font color="red"> <c:forEach
									items="${errors.globalErrors}" var="error">
									<spring:message code="${error.code}" />
									<br>
								</c:forEach>
							</font>
						</spring:hasBindErrors>
						<table class="w3-table-all">
							<tr>
								<th>상호명</th>
								<td><form:input path="name" class="w3-input" placeholder="상호명" /></td>
								<td><font color="red"> <form:errors path="name" /></font></td>
							</tr>
							<tr>
								<th>가게 이미지</th>
								<td><input style="width: 185" type="file" name="picture"></td>
							</tr>
							<tr>
								<th>영업 시작 시간</th>
								<td><form:select path="open" class="w3-select">
										<option value="0">영업 시작 시간</option>
										<c:forEach var="i" begin="1" end="27">
											<option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}:00</option>
										</c:forEach>
									</form:select></td>
								<td><font color="red"> <form:errors path="open" /></font></td>
							</tr>
							<tr>
							    <th>영업 종료 시간</th>
								<td><form:select path="close" class="w3-select">
										<option value="0">영업 종료 시간</option>
										<c:forEach var="i" begin="1" end="27">
											<option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}:00</option>
										</c:forEach>
									</form:select></td>
								<td><font color="red"> <form:errors path="close" /></font></td>
							</tr>
							<tr>
								<th>가게 전화번호</th>
								<td><form:input path="restPhoneNo" class="w3-input" placeholder="전화번호" /></td>
								<td><font color="red"> <form:errors
											path="restPhoneNo" /></font></td>
							</tr>
							<tr>
								<th>최대 예약 인원 수</th>
								<td><form:select path="maxpeople" class="w3-select">
										<option value="0">1타임당 예약 인원 수</option>
										<c:forEach var="i" begin="1" end="20">
											<option value="${i}">${i}명</option>
										</c:forEach>
									</form:select></td>
								<td><font color="red"> <form:errors path="maxpeople" /></font></td>
							</tr>
							<tr>
							<tr>
								<th>가게 주소</th>
								<td><form:input path="address" class="w3-input" placeholder="주소"
										onclick="searchAddress();" /></td>
								<td><font color="red"> <form:errors path="address" /></font></td>
							</tr>
							<tr>
								<th>사업자 번호</th>
								<td><form:input path="licenseNum" class="w3-input" placeholder="사업자 번호" /></td>
								<td><font color="red"> <form:errors
											path="licenseNum" /></font></td>
							</tr>
						</table>
						<br>
						<!--휴무일 선택  -->
						<table class="w3-table-all" >
							<tr>
								<th colspan="8"
									style="text-align: center; border: 1px solid black;">휴무일 선택</th>
							</tr>
							<tr>
								<td style="text-align: center; border: 1px solid black;"><form:checkbox
										path="dayoff.mon" class="w3-check" value="Y" />월요일 <form:checkbox
										path="dayoff.tue" class="w3-check" value="Y" />화요일 <form:checkbox
										path="dayoff.wed" class="w3-check" value="Y" />수요일 <form:checkbox
										path="dayoff.thur" class="w3-check" value="Y" />목요일 <form:checkbox
										path="dayoff.fri" class="w3-check" value="Y" />금요일 <form:checkbox
										path="dayoff.sat" class="w3-check" value="Y" />토요일 <form:checkbox
										path="dayoff.sun" class="w3-check" value="Y" />일요일</td>
							</tr>
						</table>
						<br>
						<!--메뉴 등록  -->
						<table class="w3-table-all" id="menuTable">
							<tr>
								<td colspan="3" style="text-align: center;">메뉴 등록</td>
							</tr>
							<tr>
								<th style="text-align: center; vertical-align:middle; width: 180;">메뉴 이름</th>
								<th style="text-align: center; vertical-align:middle; width: 100;">가격</th>
								<th style="text-align: center;">
								<button type="button" id="btnAdd" class="w3-btn w3-orange w3-border w3-border-white w3-round-xlarge" onclick="addRow();">추가</button></th>
							</tr>
							<tbody>
								<tr name="menuTr">
									<td style="text-align: center;">
										<input name="menuList[0].menuName" class="w3-input"
										placeholder="메뉴 이름" />
									</td>
									<td style="text-align: center;">
										<input name="menuList[0].price" class="w3-input"
										placeholder="가격" />
									</td>
									<td style="text-align: center;">
										<button type="button" class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge" name="btnDel"
											onclick="deleteRow(this);">삭제</button>
									</td>
								</tr>
							</tbody>
						</table>
						<br>
						<input type="submit" class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge" value="등록" name="add"> 
						<button type="button" onclick="location.href='/project/restaurant/restaurantList'" class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge" >취소
						</button>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>