<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta charset="UTF-8">
<title>가게 등록</title>
<script>
	//메뉴 추가 버튼 눌렀을 때 테이블에 row 추가.
	function addRow() {
		//메뉴 입력하는 row의 개수
		let idx = $('tr[name="menuTr"]').length;
		
		//추가 버튼을 누르면 row를 추가해줌
		let insertTr = "<tr name='menuTr'>";
  	  	insertTr += '<td><input name="menuList['+idx+'].menuName" style="width:180" placeholder="메뉴 이름"/></td>';
	  	insertTr += '<td><input name="menuList['+idx+'].price" style="width:100" placeholder="가격"/></td>';
	  	insertTr += "<td><button type='button' name='btnDel' onclick='deleteRow(this);'>삭제</button></td>";
	  	insertTr += "</tr>";
	  	
		$('#menuTable tbody:last').append(insertTr);
	}
	
	//메뉴 삭제 버튼 눌렀을 때 해당 row 삭제.
	function deleteRow(del) {
		console.log(del);
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
</head>
<body>
	<h2>상세 보기</h2>
	<div>사장 가게 상세 보기</div>
	<form:form modelAttribute="restaurant" method="post"
		action="restaurantadd" onsubmit="return check();">
		<spring:hasBindErrors name="restaurant">
			<font color="red"> <c:forEach items="${errors.globalErrors}"
					var="error">
					<spring:message code="${error.code}" />
					<br>
				</c:forEach>
			</font>
		</spring:hasBindErrors>
		<table>
			<tr>
				<td><form:input path="name" placeholder="상호명" /> </td>
				<td><font color="red"> <form:errors path="name" /></font></td>
			</tr>
			<tr>
				<td><input style="width:185" type="file" name="picture" ></td>
			</tr>
			<tr>
				<td>
					<form:select path="open">
						<option value="0">여는 시간</option>
						<c:forEach var="i"  begin="1" end="27">
        					<option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}:00</option>
    					</c:forEach>
    				</form:select>
				</td>
				<td><font color="red"> <form:errors path="open" /></font></td>
	        </tr>
	        <tr>			
				<td>
					<form:select path="close">
						<option value="0">닫는 시간</option>
						<c:forEach var="i"  begin="1" end="27">
        					<option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}:00</option>
    					</c:forEach>
    				</form:select>
				</td>
				<td><font color="red"> <form:errors path="close" /></font></td>
			</tr>
			<tr>
				<td><form:input path="restPhoneNo" placeholder="전화번호" /> </td>
				<td><font color="red"> <form:errors path="restPhoneNo" /></font></td>
			</tr>
			<tr>
				<td>
					<form:select path="maxpeople">
			             <option value="0" >===최대 예약 인원 수===</option>
			             <option value="1">1명</option>
			             <option value="2">2명</option>
			             <option value="3">3명</option>
			             <option value="4">4명</option>
					</form:select>
				</td>
				<td><font color="red"> <form:errors path="maxpeople" /></font></td>
			</tr>
			<tr>
			<tr>
				<td><form:input path="address" placeholder="주소" /> </td>
				<td><font color="red"> <form:errors path="address" /></font></td>
			</tr>
			<tr>
				<td><form:input path="licenseNum" placeholder="사업자번호" /> </td>
				<td><font color="red"> <form:errors path="licenseNum" /></font></td>
			</tr>
		</table>
		<br>
		<!--휴무일 선택  -->
		<table style="border-collapse: collapse">
			<tr>
				<td colspan="8" style="text-align: center; border: 1px solid black;">휴무일 선택</td>
			</tr>
			<tr>
				<td style="text-align: center; border: 1px solid black;">
					<form:checkbox path="dayoff.mon" value="Y"/>월요일
					<form:checkbox path="dayoff.tue" value="Y"/>화요일
					<form:checkbox path="dayoff.wed" value="Y"/>수요일
					<form:checkbox path="dayoff.thur" value="Y"/>목요일
					<form:checkbox path="dayoff.fri" value="Y"/>금요일
					<form:checkbox path="dayoff.sat" value="Y"/>토요일
					<form:checkbox path="dayoff.sun" value="Y"/>일요일
					<form:checkbox path="dayoff.holiday" value="Y"/>공휴일
				</td>
			</tr>
		</table>
		<!--메뉴 등록  -->
		<table id="menuTable">
			<tr>
				<td colspan="3" style="text-align: center;">메뉴 등록</td>
			</tr>
			<tr>
				<td style="width:180">메뉴 이름</td>
				<td style="width:100">가격</td>
				<td><button type="button" id="btnAdd" onclick="addRow();">추가</button></td>
			</tr>
			<tbody>
			<tr name="menuTr">
				<td><input name="menuList[0].menuName" style="width:180" placeholder="메뉴 이름"/></td>
				<td><input name="menuList[0].price" style="width:100"  placeholder="가격"/></td>
				<td><button type="button" name="btnDel" onclick="deleteRow(this);">삭제</button></td>
			</tr>
			</tbody>
		</table>
		<br>
		<td><input type="submit" value="등록" name="add"></td>
		<input type="button" value="취소" name="add">
	</form:form>
</body>
</html>