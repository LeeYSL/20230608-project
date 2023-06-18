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
							<span class="txt">${boardId} 글쓰기</span>
						</div>
					</div>

						<form:form modelAttribute="board" action="update" enctype="multipart/form-data" name="f">							
							<table class="w3-table-all">
								<tr>
									<th>제목</th>
									<td>									
										<form:input path="title"  class="w3-input" /> 
										<font color="red"> 
											<form:errors path="title" />
										</font>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<form:textarea path="content" cols="20" rows="20" class="w3-input"/> 
										<font color="red"> 
											<form:errors path="content" />
										</font>
									</td>
								</tr>
						<%--	<script>CKEDITOR.replace("content",{filebrowserImageUploadUrl : "imgupload"})</script>  --%>
								<tr>
									<th>첨부파일</th>
									<td>
										<c:if test="${!empty board.fileurl}">
											<a href="file/${board.fileurl}">${board.fileurl}</a>
										</c:if>
									</td>
								</tr>
						</table>
							<hr>
							<div>
								<div>
									<a href="list?boardId=${boardId}">
										<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">답변</button>
									</a>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;
									<a href="update?num=${num}">
										<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">수정</button>
									</a>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;
									<a href="delete?num=${num}">
										<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">삭제</button>
									</a>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;
									<a href="list?boardId=${boardId}">
										<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">목록</button>
									</a>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;																		
								</div>
							</div>
						</form:form>
				</div>
			</div>
		</div>
	</div>


</body>
</html>