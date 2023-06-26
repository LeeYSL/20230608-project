<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function listpage(page){
		document.searchform.pageNum.value=page;
		document.searchform.submit();
	}

</script>
<style type="text/css">
.page {
	height: 10%;
	display: block;
}

.txt {
	font-size: 200%;
}

th {
	background-color: #ff8400;
	color: white;
	text-align: center;
}

td {
	background-color: white;
}

a {
	text-decoration: none;
}
</style>

</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1100px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<div class="join_top">
							<span class="txt">${boardName}</span>
						</div>
					</div>


						<form action="list" method="post" name="searchform">
					<table class="w3-table-all">
						<tr>
							<td width="30%">
							<input type="hidden" name="pageNum" value="1">
							<input type="hidden" name="boardId" value="${param.boardId}">
								<div>
									<select name="type" class="w3-input">
										<option value="">전체</option>
										<option value="title">제목</option>
										<option value="user_id">작성자</option>
										<option value="content">글내용</option>
									</select>
								</div>
							</td>
							<td width="60%">
								<div>
									<input type="text" name="searchcontent" class="w3-input">
								</div>
							</td>
							<td width="10%">
								<div>
									<button
										class="w3-button w3-white w3-border w3-border-orange w3-round-large">검색</button>
								</div>
							<td>
						</tr>
					</table>
				</form>
				</div>
				<br>
				<div>
					<table class="w3-table-all">
						<tr height="10%">
							<th width="10%"></th>
							<th width="55%">제목</th>
							<th width="15%">작성자</th>
							<th width="10%">작성일</th>
							<th width="10%">조회수</th>
						</tr>

						<c:forEach var="board" items="${boardlist}">
							<tr height="10%">
								<td>${boardno}</td>
									<c:set var="boardno" value="${boardno-1}" />
								<td>
								
									<c:if test="${board.secret== NULL}">
										<a href="detail?num=${board.num}"> ${board.title} </a>
									</c:if>
								
									<c:if test="${board.secret!=null}">
										<c:choose>										
											<c:when test="${board.userId==sessionScope.loginUser.userId || sessionScope.loginUser.batch == 1}">
												<a href="detail?num=${board.num}">
													${board.title}
												</a>										
											</c:when>
											<c:otherwise>
												비밀글은 작성자와 관리자만 볼 수 있습니다.
											</c:otherwise>
										</c:choose>
									</c:if>	
								
								</td>
								<td>${board.userId}</td>
								
								<td>
									<fmt:formatDate value="${board.regDate}" pattern="yyyyMMdd" var="rdate" />
										<c:if test="${today == rdate}">
											<fmt:formatDate value="${board.regDate}" pattern="HH:mm:ss" />
										</c:if>
										<c:if test ="${today != rdate}">
											<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd" />
										</c:if>
								</td>
								<td>${board.readCnt}</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="6" class="w3-center">
								<c:if test="${pageNum > 1}">
									<a href="javascript:listpage('${pageNum -1}')">[이전]</a>
								</c:if>
								<c:if test="${pageNum <= 1}">[이전]</c:if>
								<c:forEach var="a" begin="${startpage}" end="${endpage}">
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
					
				</div>
				<div>
				<br>
					<c:if test="${boardId == 1 && sessionScope.loginUser.batch ==1 }">
						<a href="write">
							<button class="w3-button w3-white w3-border w3-border-orange w3-round-large w3-right">글쓰기</button>
						</a>
					</c:if>
					<c:if test="${boardId == 2}">
						<a href="write">
							<button class="w3-button w3-white w3-border w3-border-orange w3-round-large w3-right">글쓰기</button>
						</a>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>