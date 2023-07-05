<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	function listpage(page) {
		document.searchform.pageNum.value = page;
		document.searchform.submit();
	}
</script>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1100px;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
					</div>
					<br>
					<form action="restaurantList" method="post" name="searchform">
						<table class="w3-table-all">
							<tr>
								<td width="30%"><input type="hidden" name="pageNum"
									value="1">
									<div>
										<select name="type" class="w3-input">
											<option value="">전체</option>
											<option value="name">가게 이름</option>
											<option value="address">지역</option>
											<option value="menu">메뉴</option>
										</select>
									</div></td>
								<td width="60%">
									<div>
										<input type="text" name="searchcontent" class="w3-input">
									</div>
								</td>
								<td width="10%">
									<div>
										<button
											class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge">검색</button>
									</div>
								</td>
						</table>
					</form>
				</div>
				<br>
				<div>
					<table class="w3-table-all">
						<tr>	
							<th></th>
							<th style="text-align: center;">가게 이름</th>
							<th style="text-align: center;">주소</th>
							<th style="text-align: center;">전화번호</th>
							<th style="text-align: center;">별점</th>
							<th></th>
						</tr>
						<c:forEach items="${restList}" var="rest">
							<tr>
								<td align="center">
									<c:if test="${rest.fileurl != null}">
										<img width="100" height="100" src="file/${rest.fileurl}">
									</c:if> 
									<c:if test="${rest.fileurl == null}">
										<img width="100" height="100" src="${path}\image\Zxc.jpg">
									</c:if>
								</td>
								<td align="center">이름 : ${rest.name}</td>
								<td align="center">주소 : ${rest.address}</td>
								<td align="center">전화번호 : ${rest.restPhoneNo}</td>

								<td align="center"><span class="starR=on">⭐</span> : ${rest.point}</td>
								<td>
									<a href="restaurantInfo?num=${rest.restNum}"> 
									<input type="button" value="상세보기"
										class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge" >
									</a>
								</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="6" class="w3-center">
								<c:if test="${pageNum > 1}">
									<a href="javascript:listpage('${pageNum -1}')">[이전]</a>
								</c:if> <c:if test="${pageNum <= 1}">[이전]</c:if> 
								<c:forEach var="a"
									begin="${startpage}" end="${endpage}">
									<c:if test="${a == pageNum}">[${a}]</c:if>
									<c:if test="${a != pageNum}">
										<a href="javascript:listpage('${a}')">[${a}]</a>
									</c:if>
								</c:forEach> 
								<c:if test="${pageNum < maxpage}">
									<a href="javascript:listpage('${pageNum +1}')">[다음]</a>
								</c:if> 
								<c:if test="${pageNum >= maxpage}">[다음]</c:if>
							</td>
						</tr>
					</table>
					<input type="hidden" ${rest.restNum}>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
