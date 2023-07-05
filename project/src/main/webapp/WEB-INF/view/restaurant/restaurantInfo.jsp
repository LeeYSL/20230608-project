<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>가게 상세 조회</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=760e9cd842f22392ca00d06757e9481a&libraries=services"></script>
<script type="text/javascript">
	$(function() { //document.ready
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch($('#address').text(), function(result, status) {

			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {

				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

				// 결과값으로 받은 위치를 마커로 표시합니다
				var marker = new kakao.maps.Marker({
					map : map,
					position : coords
				});

				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);
			}
		});
	})
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
			style="display: block; margin: auto; width: 1100px;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
					<br>
						<c:if test="${restInfo.fileurl != null}">
							<img class="w3-border w3-padding" width="400" height="200" src="file/${restInfo.fileurl}">
						</c:if> <c:if test="${restInfo.fileurl == null}">
							<img class="w3-border w3-padding" width="400" height="200" src="${path}\image\Zxc.jpg">
						</c:if>
						<header class="l_member_header">
							<h1 class="tit">
								<span>${restInfo.name}</span>
							</h1>
							평균 별점 : ${pointNum} 점
						</header>
					</div>
					<br>
					<table class="w3-table-all">
						<tr>
							<th>식당 위치</th>
							<td>
								<p id="address">${restInfo.address}</p>
								<div id="map" style="width: 100%; height: 300px;"></div>
							</td>
						</tr>
						<tr>
							<th>식당 전화번호</th>
							<td>${restInfo.restPhoneNo}
						</tr>
						<tr>
							<th>open</th>
							<td>${restInfo.open} : 00</td>
						</tr>
						<tr>
							<th>close</th>
							<td>${restInfo.close} : 00</td>
						</tr>
						<tr>
							<th>휴무일</th>
							<td ><input type="checkbox" id="mon" class="w3-check"
								<c:if test="${dayoff.mon eq 'Y'}">checked</c:if>
								onclick="return false;" />월요일 <input type="checkbox" id="tue" class="w3-check"
								<c:if test="${dayoff.tue eq 'Y'}">checked</c:if> 
								onclick="return false;" />화요일 <input type="checkbox" id="wed" class="w3-check"
								<c:if test="${dayoff.wed eq 'Y'}">checked</c:if>
								onclick="return false;" />수요일 <input type="checkbox" id="thur" class="w3-check"
								<c:if test="${dayoff.thur eq 'Y'}">checked</c:if>
								onclick="return false;" />목요일 <input type="checkbox" id="fri" class="w3-check"
								<c:if test="${dayoff.fri eq 'Y'}">checked</c:if>
								onclick="return false;" />금요일 <input type="checkbox" id="sat" class="w3-check"
								<c:if test="${dayoff.sat eq 'Y'}">checked</c:if>
								onclick="return false;" />토요일 <input type="checkbox" id="sun" class="w3-check"
								<c:if test="${dayoff.sun eq 'Y'}">checked</c:if>
								onclick="return false;" />일요일</td>
						</tr>
					</table>
					<br>
					<table class="w3-table-all" id="menuTable">
						<tr>
							<td colspan="3" style="text-align: center;">메뉴</td>
						</tr>
						<tr>
							<th style="text-align: center; vertical-align:middle; width: 180;">메뉴 이름</th>
							<th style="text-align: center; vertical-align:middle; width: 100;">가격</th>
						</tr>
						<tbody>
							<c:forEach items="${memuList}" var="menu" varStatus="status">
								<tr name="menuTr">
									<td style="text-align: center;"><input name="menuList[${status.index}].menuName"
										 class="w3-input" placeholder="메뉴 이름"
										value="${menu.menuName}" /></td>
									<td style="text-align: center;"><input name="menuList[${status.index}].price"
										 placeholder="가격" class="w3-input" value="${menu.price} 원" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<br>
					<c:if test="${!empty sessionScope.loginUser }">
							<button type="button"
								onclick="location.href='/project/reservation/reservationadd?num=${restInfo.restNum}'"
								class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge">예약
							</button>
					</c:if>
					<input type="hidden" ${menu.restNum}> 
					<input type="hidden" ${restInfo.restNum}> 
					<input type="hidden" ${dayoff}>
					<input type="hidden" ${memuList}> 
					<input type="hidden" ${restInfo}>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
