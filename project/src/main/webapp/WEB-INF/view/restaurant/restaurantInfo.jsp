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
									<th></th>
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
									<td>${dayoff}</td>
								</tr>
								<%-- 	<th>메뉴</th>
									<td>${memuList.menuName}</td>
									<td>${memuList.price}</td> --%>
								<tr>
									<td><input type="hidden" ${restInfo.restNum}></td>
									<td><input type="hidden" ${dayoff}></td>
									<td><input type="hidden" ${memuList}></td>
									<td><input type="hidden" ${restInfo}></td>
									<td><a href="/project/reservation/reservationadd?num=${restInfo.restNum}"> 
											<input type="button" value="예약">
										</a></td>
								</tr>
							</table>
							
							<form:form modelAttribute="review"  method="post" action="review">
								<div>
								<table>
									<tr>
										<td>
											<form:textarea path="content" cols="100" row="10" class="w3-input" placeholder="댓글" />
											<font color="red">
												<form:errors path="content" />
											</font>
											<input type="hidden" name="userId" value="${sessionScope.loginUser.userId}">
											<input type="hidden" name="num" value="${param.num}">
										</td>
										<td>
											<button type="submit" class="w3-button w3-white w3-border w3-border-orange w3-round-large"">댓글 등록</button>
										</td>
									</tr>
								</table>
								</div>
							</form:form>
							<hr>
							<div>
								<form action="reviewDelete" method="post">
								<table class="w3-table-all">
									<c:forEach var="review" items="${reviewList}">
									<tr>
										<td>
											${review.userId}
										</td>
										<td>
											${review.content}
										</td>
										<td>
											<fmt:formatDate value="${review.date}" pattern="yyyyMMdd" var="cdate"/>
												<c:if test="${cdate == today}">
													<fmt:formatDate value="${review.date}" pattern="HH:mm:ss" />												
												</c:if>
												<c:if test="${cdate != today}">
													<fmt:formatDate value="${review.date}" pattern="yyyy-MM-dd" />
												</c:if>
										</td>
										<c:if test="${sessionScope.loginUser.userId == review.userId}">
											<td>
												<a href="commdelete?num=${review.num}&seq=${review.seq}">
													<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">삭제</button>
												</a>
											</td>
										</c:if>
									</tr>
									</c:forEach>
								</table>
									</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
