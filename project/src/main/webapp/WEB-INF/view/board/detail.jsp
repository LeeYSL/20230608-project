<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function update_comment(btn) {
		$('input[name="content"]').attr('value',
				$(btn).parents('td').children('input[name="content"]').val());
		$('input[name="num"]').attr('value',
				$(btn).parents('td').children('input[name="num"]').val());
		document.commUpdate.submit();
	}
	function detail(page) {
		document.c.pageNum.value = page;
		document.c.submit();
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
	width: 10%;
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
	<div style="display: block; margin: auto; width: 1100px; height: auto; padding-top: 100px;"
		class="w3-center">
		<div class="w3-padding-32">
			<div class="page">
				<span class="txt">${boardName}</span>
			</div>


			<table class="w3-table-all">
				<tr>
					<th class="w3-center">제목</th>
					<td>${board.title}</td>
				</tr>
				<tr>
					<th class="w3-center">작성자</th>
					<td>${board.nickname}</td>
				</tr>
				
				<tr>
					<th class="w3-center">내용</th>
					<td height="500px;">${board.content}</td>
				</tr>
				<tr>
					<th class="w3-center">첨부파일</th>
					<td><c:if test="${!empty board.fileurl}">
							<a href="file/${board.fileurl}">${board.fileurl}</a>
						</c:if></td>
				</tr>
			</table>
			<br>
			<div>
				<div>
					<c:if test="${loginUser.batch ==  1}">
						<a href="reply?num=${board.num}">
							<button type="button"
								class="w3-button w3-white w3-border w3-border-orange w3-round-large">답변</button>
						</a>
					</c:if>
					<c:if test="${sessionScope.loginUser.userId == board.userId }">
							&nbsp;	&nbsp;	&nbsp;	&nbsp;
							<a href="update?num=${board.num}">
							<button type="button"
								class="w3-button w3-white w3-border w3-border-orange w3-round-large">수정</button>
							</a>
							&nbsp;	&nbsp;	&nbsp;	&nbsp;
							<a href="delete?num=${board.num}">
							<button type="button"
								class="w3-button w3-white w3-border w3-border-orange w3-round-large">삭제</button>
						</a>
					</c:if>
					&nbsp; &nbsp; &nbsp; &nbsp; <a href="list?boardId=${board.boardId}">
						<button type="button"
							class="w3-button w3-white w3-border w3-border-orange w3-round-large">목록</button>
					</a> &nbsp; &nbsp; &nbsp; &nbsp;
				</div>
			</div>
			<hr>
				<c:if test="${loginUser != null }">
			<form:form modelAttribute="comment" method="post" action="comment">
				<div>
					<table>
						<tr>
							<td><form:textarea path="content" cols="120" row="10"
									class="w3-input" style="resize: none;"
									placeholder="댓글을 입력해주세요." /> <font color="red"> <form:errors
										path="content" />
							</font> <input type="hidden" name="userId"
								value="${sessionScope.loginUser.userId}"> <input
								type="hidden" name="num" value="${param.num}"></td>
							<td>
								<button type="submit"
									class="w3-button w3-white w3-border w3-border-orange w3-round-large">댓글등록</button>
							</td>
						</tr>
					</table>
				</div>
			</form:form>
			<hr>
				</c:if>
			<div>
			<form action="commdelete" method="post" name="c">
					<input type="hidden" name="pageNum" value="1"> 
					<input type="hidden" name="num" value="${param.num}">
			</form>
					<table class="w3-table-all">
						<c:if test="${commcount > 0}">
							<c:forEach var="comm" items="${commlist}">
								<tr>
									<td width="2%" style="line-height: 50px;">${commno}</td>
									<c:set var="commno" value="${commno-1}" />
									<td>
									<td width="10%" style="line-height: 50px;">${comm.nickname}
									</td>
									<td width="78%" style="line-height: 50px;">
										${comm.content}</td>
									<td width="10%" style="line-height: 50px;"><fmt:formatDate
											value="${comm.date}" pattern="yyyyMMdd" var="cdate" /> <c:if
											test="${cdate == today}">
											<fmt:formatDate value="${comm.date}" pattern="HH:mm:ss" />
										</c:if> <c:if test="${cdate != today}">
											<fmt:formatDate value="${comm.date}" pattern="yyyy-MM-dd" />
										</c:if></td>
										
									<c:if test="${sessionScope.loginUser.userId == comm.userId}">
										<td width="15%"><a
											href="commdelete?num=${comm.num}&seq=${comm.seq}">
												<button type="button"
													class="w3-button w3-white w3-border w3-border-orange w3-round-large">삭제</button>
										</a>
							
										</td>
									</c:if>
								</tr>
							</c:forEach>
							<tr>
															<td colspan="6" style="text-align: center;"><c:if
										test="${pageNum <= 1}">[이전]</c:if> <c:if
										test="${pageNum > 1 }">
										<a href="detail?num=${board.num}&pageNum=${pageNum-1}">[이전]</a>
									</c:if> <c:forEach var="a" begin="${startpage}" end="${endpage}">
										<c:if test="${a==pageNum}">[${a}]</c:if>
										<c:if test="${a != pageNum }">
											<a href="detail?num=${board.num}&pageNum=${a}">[${a}]</a>
										</c:if>
									</c:forEach> <c:if test="${pageNum >= maxpage}">[다음]</c:if> <c:if
										test="${pageNum < maxpage}">
										<a href="detail?num=${board.num}&pageNum=${pageNum+1}">[다음]</a>
									</c:if></td>
							
							
							<%--
								<td colspan="6" class="w3-center"><c:if
										test="${pageNum > 1}">
										<a href="javascript:detail('${pageNum -1}')">[이전]</a>
									</c:if> <c:if test="${pageNum <= 1}">[이전]</c:if> <c:forEach var="a"
										begin="${startpage}" end="${endpage}">
										<c:if test="${a == pageNum}">[${a}]</c:if>
										<c:if test="${a != pageNum}">
											<a href="javascript:detail('${a}')">[${a}]</a>
										</c:if>
									</c:forEach> <c:if test="${pageNum < maxpage}">
										<a href="javascript:detail('${pageNum +1}')">[다음]</a>
									</c:if> <c:if test="${pageNum >= maxpage}">[다음]</c:if></td>
									 --%>
									
							</tr>
						</c:if>
						<c:if test="${commcount ==  0}">
							<tr>
								<td colspan="3" style="text-align: center;">등록된 댓글이 없습니다.</td>
							</tr>
						</c:if>
					</table>



			</div>
		</div>
	</div>

</body>
</html>