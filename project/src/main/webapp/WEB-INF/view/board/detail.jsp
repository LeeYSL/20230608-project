<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	width:10%;
	text-align: center;
	
}
td {
	background-color :white;
}

a {
	text-decoration: none;
}


</style>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 900px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<div class="join_top">
							<span class="txt">${boardName}</span>
						</div>
					</div>					
							<table class="w3-table-all">
								<tr>
									<th>제목</th>
									<td>									
										${board.title}
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										${board.content}
									</td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td>
										<c:if test="${!empty board.fileurl}">
											<a href="file/${board.fileurl}">${board.fileurl}</a>
										</c:if>
									</td>
								</tr>
						</table>
						<br>		
							<div>
								<div>
									<a href="reply?num=${board.num}">
										<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">답변</button>
									</a>
									<c:if test="${sessionScope.loginUser.userId == board.userId }">
									&nbsp;	&nbsp;	&nbsp;	&nbsp;
									<a href="update?num=${board.num}">
										<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">수정</button>
									</a>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;
									<a href="delete?num=${board.num}">
										<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">삭제</button>
									</a>
									</c:if>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;
									<a href="list?boardId=${board.boardId}">
										<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">목록</button>
									</a>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;																		
								</div>
							</div>
							<hr>	
							<form:form modelAttribute="comment"  method="post" action="comment">
								<div>
								<table>
									<tr>
										<td>
											<form:textarea path="content" cols="20" row="10" class="w3-input" placeholder="댓글" />
											<font color="red">
												<form:errors path="content" />
											</font>
											<input type="hidden" name="wirter" value="${sessionScope.loginUser.userId}">
											<input type="hidden" name="num" value="${param.num}">
										</td>
										<td>
											<button type="submit">댓글 등록</button>
										</td>
									</tr>
								</table>
								</div>
							</form:form>
							<hr>
							<div>
								<table class="w3-table-all">
									<tr>
										<td>
											${comm.userId}
										</td>
										<td>
											${comm.content}
										</td>
										<td>
											${comm.date}
										</td>
										<c:if test="${sessionScope.loginUser.userId == comm.writer}">
											<td>
												<a href="delete?num=${comm.num}?seq=${comm.seq}">
													<button type="button">삭제</button>
												</a>
											</td>
										</c:if>
									</tr>
								</table>
							</div>
										
				</div>
			</div>
		</div>
	</div>


</body>
</html>