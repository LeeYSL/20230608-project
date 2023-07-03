<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가게 상세 조회</title>
</head>
<body>

	<div class="w3-container w3-padding-32 w3-center">
		<div
			style="display: block; margin: auto; width: 1100px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<div class="join_top">
							<h2>${restInfo.name}</h2>
							<table>
								<tr>
									<th align="center">평균 별점 : ${pointNum} 점</th>
								</tr>
								<tr>
									<th>식당사진</th>
									<td><c:if test="${restInfo.fileurl != null}">
											<img width="100" height="100" src="file/${restInfo.fileurl}">
										</c:if> <c:if test="${restInfo.fileurl == null}">
											<img width="100" height="100" src="${path}\image\Zxc.jpg">
										</c:if></td>
								</tr>
								<tr>
									<th>식당 위치</th>
									<td>${restInfo.address}</td>
								</tr>
								<tr>
									<th>식당 전화번호</th>
									<td>${restInfo.restPhoneNo}
								</tr>
								<tr>
									<th>open</th>
									<td>${restInfo.open}</td>
								</tr>
								<tr>
									<th>close</th>
									<td>${restInfo.close}</td>
								</tr>
								<tr>
									<th>휴무일</th>
									<td><input type="checkbox" id="mon"
										<c:if test="${dayoff.mon eq 'Y'}">checked</c:if>
										onclick="return false;" />월요일 <input type="checkbox" id="tue"
										<c:if test="${dayoff.tue eq 'Y'}">checked</c:if>
										onclick="return false;" />화요일 <input type="checkbox" id="wed"
										<c:if test="${dayoff.wed eq 'Y'}">checked</c:if>
										onclick="return false;" />수요일 <input type="checkbox"
										id="thur" <c:if test="${dayoff.thur eq 'Y'}">checked</c:if>
										onclick="return false;" />목요일 <input type="checkbox" id="fri"
										<c:if test="${dayoff.fri eq 'Y'}">checked</c:if>
										onclick="return false;" />금요일 <input type="checkbox" id="sat"
										<c:if test="${dayoff.sat eq 'Y'}">checked</c:if>
										onclick="return false;" />토요일 <input type="checkbox" id="sun"
										<c:if test="${dayoff.sun eq 'Y'}">checked</c:if>
										onclick="return false;" />일요일</td>
								</tr>
								<c:forEach items="${memuList}" var="menu">
									<tr>
										<th>메뉴</th>
										<td align="left" colspan="2">메뉴 :${menu.menuName}, 가격:
											${menu.price} 원</td>
									</tr>
								</c:forEach>
								<tr>
									<td><input type="hidden" ${menu.restNum}></td>
									<td><input type="hidden" ${restInfo.restNum}></td>
									<td><input type="hidden" ${dayoff}></td>
									<td><input type="hidden" ${memuList}></td>
									<td><input type="hidden" ${restInfo}></td>
									<c:if test="${!empty sessionScope.loginUser }">
										<td><a
											href="/project/reservation/reservationadd?num=${restInfo.restNum}">
												<input type="button" value="예약">
										</a></td>
									</c:if>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
