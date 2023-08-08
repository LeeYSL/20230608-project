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
		<div style="display: block; margin: auto; width: 1100px; height: 100%; padding-top:100px;" class="w3-center">
			<div class="w3-padding-32">

					<div class="page">
						<span class="txt">${boardName}</span>						
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
										<option value="nickname">작성자</option>
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
					<c:if test="${listcount == 0}">
					등록된 게시물이 없습니다.
					</c:if>
					
					<c:if test="${listcount > 0}">
						<tr height="10%">
							<th width="10%"  class="w3-center">글번호</th>
							<th width="55%"  class="w3-center">제목</th>
							<th width="15%"  class="w3-center">작성자</th>
							<th width="10%"  class="w3-center">작성일</th>
							<th width="10%"  class="w3-center">조회수</th>
						</tr>
						
						<c:forEach var="board" items="${boardlist}">
							<tr height="10%">
								<td  class="w3-center">${boardno}</td>
									<c:set var="boardno" value="${boardno-1}" />
								<td>
								
									<c:if test="${board.secret!=null && !board.secret.trim().equals('')}"><%--비밀글일때 --%>
										<c:choose>										
											<c:when test="${board.userId==sessionScope.loginUser.userId || sessionScope.loginUser.batch == 1 }"> <%--운영자이거나, 작성자일때 --%>
												<c:if test="${! empty board.fileurl}">
													<a href="file/${board.fileurl}">@</a>
												</c:if>										
											</c:when>
											<c:otherwise>												
											</c:otherwise>
										</c:choose>
									</c:if>
									
									<c:if test="${board.secret ==null || board.secret.trim().equals('')}"><%--비밀글 아닐때 --%>
										<c:if test="${! empty board.fileurl}">
											<a href="file/${board.fileurl}">@</a>
										</c:if>																				
									</c:if>																		
								
								
									<c:forEach begin="1" end="${board.grpLevel}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>
									<c:if test="${board.grpLevel > 0}">┖</c:if>															
									<c:if test="${board.secret==null || board.secret.trim().equals('')}"><%--비밀글아닐때 --%>
												<a href="detail?num=${board.num}">
													${board.title}
												</a>
												<c:if test="${board.commCnt >0 }">
												[${board.commCnt}]
												</c:if>	 											
									</c:if>	
								
									<c:if test="${board.secret!=null && !board.secret.trim().equals('')}"><%--비밀글일때 --%>
										<c:choose>										
											<c:when test="${board.secret2==sessionScope.loginUser.userId || sessionScope.loginUser.batch == 1 }"> <%--운영자이거나, 작성자일때 --%>
												<a href="detail?num=${board.num}">													
													${board.title}
												</a>
												<c:if test="${board.commCnt >0 }">
												[${board.commCnt}]
												</c:if>																							
											</c:when>
											<c:otherwise>
												비밀글은 작성자와 관리자만 볼 수 있습니다.
											</c:otherwise>
										</c:choose>
									</c:if>
	
								
								</td>
								<td  class="w3-center">${board.nickname}</td>
								
								<td  class="w3-center">
									<fmt:formatDate value="${board.regDate}" pattern="yyyyMMdd" var="rdate" />
										<c:if test="${today == rdate}">
											<fmt:formatDate value="${board.regDate}" pattern="HH:mm:ss" />
										</c:if>
										<c:if test ="${today != rdate}">
											<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd" />
										</c:if>
								</td>
								<td class="w3-center">${board.readCnt}</td>
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
						</c:if>
					</table>
					
				</div>
				<div>
				<br>
					<c:if test="${boardId == 1 && sessionScope.loginUser.batch ==1 }">
						<a href="write">
							<button class="w3-button w3-white w3-border w3-border-orange w3-round-large w3-right">글쓰기</button>
						</a>
					</c:if>
					<c:if test="${(boardId == 2 || boardId == 3) && sessionScope.loginUser != null}">
						<a href="write">
							<button class="w3-button w3-white w3-border w3-border-orange w3-round-large w3-right">글쓰기</button>
						</a>
					</c:if>
				</div>
			</div>

</body>
</html>