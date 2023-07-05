<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/demos/style.css">
<meta charset="UTF-8">
<title>내 예약 상세 수정 페이지</title>
<style type="text/css">
th {
	width: 20%;
	height: 55px;
	vertical-align: middle !important;
}

</style>

</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1000px;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<header class="l_member_header">
							<h2 class="tit">
								<span>예약 상세</span>
							</h2>
						</header>
					</div>
					<form:form modelAttribute="reservation" method="post"
						action="myListInfo">
						<table class="w3-table-all">
							<tr>
								<th>가게이름</th>
								<td align="center"><form:input path="name" class="w3-input"
										value="${rsrvt.name}" disabled="true" /></td>
							</tr>
							<tr>
								<th>가게 전화번호</th>
								<td align="center"><form:input path="restPhoneNo" class="w3-input"
										value="${rsrvt.restPhoneNo}" disabled="true" /></td>
							</tr>
							<tr>
								<th>예약자 이름</th>
								<td><form:input path="rsrvtName" value="${rsrvt.rsrvtName}" class="w3-input" /></td>
								<td><font color="red"><form:errors path="rsrvtName" /></font></td>
							</tr>
							<tr>
								<th>예약자 전화번호</th>
								<td><form:input path="phoneNo" value="${rsrvt.phoneNo}" class="w3-input" /></td>
								<td><font color="red"><form:errors path="phoneNo" /></font></td>
							</tr>
							<tr>
								<th>인원 수</th>
								<td align="center"><form:input path="people" class="w3-input"
										value="${rsrvt.people}" disabled="true" /></td>
							</tr>
							<tr>
								<th>예약 날짜</th>
								<td align="center"><form:input path="rsrvtDate" class="w3-input"
										value="${rsrvt.rsrvtDate}" disabled="true" /></td>
							</tr>
							<tr>
								<th>예약 시간</th>
								<td align="center"><form:input path="rsrvtTime" class="w3-input"
										value="${rsrvt.rsrvtTime}" disabled="true" /></td>
							</tr>
							<tr>
								<td colspan="2" style="text-align: center;">
									<input type="submit"
									class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge"
									value="수정 완료" name="update"> <input type="button"
									class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge"
									value="확인"></td>
							</tr>
						</table>
						<input type="hidden" name="num" value="${rsrvt.num}" />
						<input type="hidden" name="num" value="${rsrvt.rsrvtName}" />
					</form:form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>