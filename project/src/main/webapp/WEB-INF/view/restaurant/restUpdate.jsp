<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"> ></script>
<meta charset="UTF-8">
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

	//휴무일 수정 시 value를 Y로 바꾼다.
	function changeValue(box) {
		const chk = $(box).is(':checked'); //체크 여부 확인, boolean값으로 반환함
		$(box).val(chk ? 'Y' : '');
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
	<form:form modelAttribute="restaurant" enctype="multipart/form-data" method="post"
		action="restUpdate" onsubmit="return check();">
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
				<td><form:input path="name" value="${restInfo.name}" /></td>
				<td><font color="red"> <form:errors path="name" /></font></td>
			</tr>
			<tr>
				<td><c:if test="${restInfo.fileurl != null}">
						<img width="100" height="100" src="file/${restInfo.fileurl}">
					</c:if> <c:if test="${restInfo.fileurl == null}">
						<img width="100" height="100" src="${path}\image\Zxc.jpg">
					</c:if>
				</td>
			</tr>
			<tr>
				<td>
				 <h5>사진 재등록 시 기존 사진은 삭제 됩니다.</h5>
				 <input style="width: 185" type="file" name="picture" ></td>
			</tr>
			<tr>
				<td><form:select path="open">
						<option value="${restInfo.open }">open : ${restInfo.open }</option>
						<c:forEach var="i" begin="1" end="27">
							<option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}:00</option>
						</c:forEach>
					</form:select></td>
				<td><font color="red"> <form:errors path="open" /></font></td>
			</tr>
			<tr>
				<td><form:select path="close">
						<option value="${restInfo.close}">close : ${restInfo.close}</option>
						<c:forEach var="i" begin="1" end="27">
							<option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}:00</option>
						</c:forEach>
					</form:select></td>
				<td><font color="red"> <form:errors path="close" /></font></td>
			</tr>
			<tr>
				<td><form:input path="restPhoneNo"
						value="${restInfo.restPhoneNo}" /></td>
				<td><font color="red"> <form:errors path="restPhoneNo" /></font></td>
			</tr>
			<tr>
				<td><form:select path="maxpeople">
						<option value="${restInfo.maxpeople}">1타임당 예약 인원 수 : ${restInfo.maxpeople}명</option>
						<c:forEach var="i" begin="1" end="20">
							<option value="${i}">${i}명</option>
						</c:forEach>
					</form:select></td>
				<td><font color="red"> <form:errors path="maxpeople" /></font></td>
			</tr>
			<tr>
			<tr>
				<td><form:input path="address"
						value="${restInfo.address}" onclick="searchAddress();" /></td>
				<td><font color="red"> <form:errors path="address" /></font></td>
			</tr>
			<tr>
				<td><form:input path="licenseNum"
						value="${restInfo.licenseNum}" readonly="true" /></td>
				<td><font color="red"> <form:errors path="licenseNum" /></font></td>
			</tr>
		</table>
		<br>
		<!--휴무일 선택  -->
		<table style="border-collapse: collapse">
			<tr>
				<td colspan="8" style="text-align: center; border: 1px solid black;">휴무일
					선택</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="dayoff.mon"
					<c:if test="${dayoff.mon eq 'Y'}">checked</c:if> onclick="changeValue(this);" value="${dayoff.mon}" />월요일 
					<input type="checkbox" name="dayoff.tue"
					<c:if test="${dayoff.tue eq 'Y'}">checked</c:if> onclick="changeValue(this);" value="${dayoff.tue}" />화요일 
					<input type="checkbox" name="dayoff.wed"
					<c:if test="${dayoff.wed eq 'Y'}">checked</c:if> onclick="changeValue(this);" value="${dayoff.wed}"/>수요일 
					<input type="checkbox" name="dayoff.thur"
					<c:if test="${dayoff.thur eq 'Y'}">checked</c:if> onclick="changeValue(this);" value="${dayoff.thur}"/>목요일 
					<input type="checkbox" name="dayoff.fri"
					<c:if test="${dayoff.fri eq 'Y'}">checked</c:if> onclick="changeValue(this);" value="${dayoff.fri}"/>금요일 
					<input type="checkbox" name="dayoff.sat"
					<c:if test="${dayoff.sat eq 'Y'}">checked</c:if> onclick="changeValue(this);" value="${dayoff.sat}"/>토요일 
					<input type="checkbox" name="dayoff.sun"
					<c:if test="${dayoff.sun eq 'Y'}">checked</c:if> onclick="changeValue(this);" value="${dayoff.sun}"/>일요일
				</td>
			</tr>
		</table>
		<br>
		<!--메뉴 등록  -->
		<table id="menuTable">
			<tr>
				<td colspan="3" style="text-align: center;">메뉴 등록</td>
			</tr>
			<tr>
				<td style="width: 180">메뉴 이름</td>
				<td style="width: 100">가격</td>
				<td><button type="button" id="btnAdd" onclick="addRow();">추가</button></td>
			</tr>
			<tbody>
				<c:forEach items="${memuList}" var="menu" varStatus="status">
					<tr name="menuTr">
						<td><input name="menuList[${status.index}].menuName" style="width: 180"
							placeholder="메뉴 이름" value="${menu.menuName}" /></td>
						<td><input name="menuList[${status.index}].price" style="width: 100"
							placeholder="가격" value="${menu.price}"/></td>
						<td><button type="button" name="btnDel"
								onclick="deleteRow(this);">삭제</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
		<td><input type="hidden" name="restNum" value="${restInfo.restNum}"></td>
		<td><input type="hidden" name="restInfo" value="${memuList}"></td>
		<td><input type="submit" value="수정" name="update"></td>
		<td><a
			href="/project/restaurant/ownerRest?num=${restInfo.userId}"> <input
				type="button" value="취소">
		</a>
	</form:form>
</body>
</html>