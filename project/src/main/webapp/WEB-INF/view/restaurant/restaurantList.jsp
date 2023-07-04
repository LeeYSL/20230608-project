<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript">
	function listpage(page) {
		document.searchform.pageNum.value = page;
		document.searchform.submit();
	}
</script>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div
			style="display: block; margin: auto; width: 1100px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<form action="restaurantList" method="post" name="searchform">
							<table>
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
										</div>
										<div>
											<input type="text" name="searchcontent" class="w3-input">
										</div>
										<div>
											<button>검색</button>
										</div>
								<tr>
									<th>가게 이름</th>
									<th>주소</th>
									<th width="10%"></th>
									<th width="10%"></th>
									<th width="10%"></th>
									<th>전화번호</th>
								</tr>
							</table>
							<div></div>
							<table class="w3-table-all">
								<c:forEach items="${restList}" var="rest">
									<tr>
										<td align="center"><c:if
												test="${rest.fileurl != null}">
												<img width="100" height="100" src="file/${rest.fileurl}">
											</c:if> <c:if test="${rest.fileurl == null}">
												<img width="100" height="100" src="${path}\image\Zxc.jpg">
											</c:if>
										</td>

										<td align="center">이름 : ${rest.name}</td>
										<td align="center">주소 : ${rest.address}</td>
										<td align="center">전화번호 : ${rest.restPhoneNo}</td>
										
										<td align="center">평점 : ${rest.point}</td>
										<td><input type="hidden" ${rest.restNum}></td>
										<td><a href="restaurantInfo?num=${rest.restNum}"> <input
												type="button" value="상세보기">
										</a></td>
									</tr>
								</c:forEach>
								<tr>
									<td colspan="6" class="w3-center"><c:if
											test="${pageNum > 1}">
											<a href="javascript:listpage('${pageNum -1}')">[이전]</a>
										</c:if> <c:if test="${pageNum <= 1}">[이전]</c:if> <c:forEach var="a"
											begin="${startpage}" end="${endpage}">
											<c:if test="${a == pageNum}">[${a}]</c:if>
											<c:if test="${a != pageNum}">
												<a href="javascript:listpage('${a}')">[${a}]</a>
											</c:if>
										</c:forEach> <c:if test="${pageNum < maxpage}">
											<a href="javascript:listpage('${pageNum +1}')">[다음]</a>
										</c:if> <c:if test="${pageNum >= maxpage}">[다음]</c:if></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
