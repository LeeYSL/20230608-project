<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
				<td><form:input path="name" placeholder="${restInfo.name}" /></td>
				<td><font color="red"> <form:errors path="name" /></font></td>
			</tr>
			<tr>
				<td><img width="100" height="100"
					src="file/${restInfo.fileurl}"></td>
			</tr>
			<tr>
				<td>
				 <h5>사진 재등록 시 기존 사진은 삭제 됩니다.</h5>
				 <input style="width: 185" type="file" name="picture"></td>
			</tr>
			<tr>
				<td><form:select path="open">
						<option value="0">open : ${restInfo.open }</option>
						<c:forEach var="i" begin="1" end="27">
							<option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}:00</option>
						</c:forEach>
					</form:select></td>
				<td><font color="red"> <form:errors path="open" /></font></td>
			</tr>
			<tr>
				<td><form:select path="close">
						<option value="0">close : ${restInfo.close}</option>
						<c:forEach var="i" begin="1" end="27">
							<option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}:00</option>
						</c:forEach>
					</form:select></td>
				<td><font color="red"> <form:errors path="close" /></font></td>
			</tr>
			<tr>
				<td><form:input path="restPhoneNo"
						placeholder="${restInfo.restPhoneNo}" /></td>
				<td><font color="red"> <form:errors path="restPhoneNo" /></font></td>
			</tr>
			<tr>
				<td><form:select path="maxpeople">
						<option value="0">최대 인원 수 : ${restInfo.maxpeople}</option>
						<option value="1">1명</option>
						<option value="2">2명</option>
						<option value="3">3명</option>
						<option value="4">4명</option>
					</form:select></td>
				<td><font color="red"> <form:errors path="maxpeople" /></font></td>
			</tr>
			<tr>
			<tr>
				<td><form:input path="address"
						placeholder="${restInfo.address}" /></td>
				<td><font color="red"> <form:errors path="address" /></font></td>
			</tr>
			<tr>
				<td><form:input path="licenseNum"
						placeholder="${restInfo.licenseNum}" readonly="true" /></td>
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
				<td><input type="checkbox" id="mon"
					<c:if test="${dayoff.mon eq 'Y'}">checked</c:if>
					onclick="return true;" />월요일 <input type="checkbox" id="tue"
					<c:if test="${dayoff.tue eq 'Y'}">checked</c:if>
					onclick="return true;" />화요일 <input type="checkbox" id="wed"
					<c:if test="${dayoff.wed eq 'Y'}">checked</c:if>
					onclick="return true;" />수요일 <input type="checkbox" id="thur"
					<c:if test="${dayoff.thur eq 'Y'}">checked</c:if>
					onclick="return true;" />목요일 <input type="checkbox" id="fri"
					<c:if test="${dayoff.fri eq 'Y'}">checked</c:if>
					onclick="return true;" />금요일 <input type="checkbox" id="sat"
					<c:if test="${dayoff.sat eq 'Y'}">checked</c:if>
					onclick="return true;" />토요일 <input type="checkbox" id="sun"
					<c:if test="${dayoff.sun eq 'Y'}">checked</c:if>
					onclick="return true;" />일요일</td>
			</tr>
		</table>
		<br>
		<table>

			<c:forEach items="${memuList}" var="menu">
				<h3>기존메뉴</h3>
				<tr>
					<td align="left" colspan="2">메뉴 :${menu.menuName}, 가격:
						${menu.price} 원</td>
				</tr>
			</c:forEach>

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
				<tr name="menuTr">
					<td><input name="menuList[0].menuName" style="width: 180"
						placeholder="메뉴 이름" /></td>
					<td><input name="menuList[0].price" style="width: 100"
						placeholder="가격" /></td>
					<td><button type="button" name="btnDel"
							onclick="deleteRow(this);">삭제</button></td>
				</tr>
			</tbody>
		</table>
		<br>
		<td><input type="hidden" name="restInfo" value="${restInfo}"></td>
		<td><input type="hidden" name="restInfo" value="${memuList}"></td>
		<td><input type="submit" value="수정" name="update"></td>
		<td><a
			href="/project/restaurant/ownerRest?num=${restInfo.userId}"> <input
				type="button" value="취소">
		</a>
	</form:form>
</body>
</html>