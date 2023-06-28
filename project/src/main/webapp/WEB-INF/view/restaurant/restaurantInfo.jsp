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
							<h2>가게 상세 보기</h2>
							<table>
								<tr>
									<th>식당사진</th>
									<td><img width="100" height="100"
										src="file/${restInfo.fileurl}"></td>
								</tr>
								<tr>
									<th>식당이름</th>
									<td>${restInfo.name}</td>
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
								 <td>
								  	<c:if test="${not empty dayoff}"> 
									    ${not empty dayoff}
							       </c:if>
							       </td>
								</tr>
								<tr>
									<th>메뉴</th>
									<td>${memuList}</td>
								</tr>
								<tr>
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
