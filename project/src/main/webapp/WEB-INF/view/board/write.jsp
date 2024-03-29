<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>밥티켓</title>
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

  textarea {
    width: 100%;
    height: 30em;
    border:  0.1px strong;
    resize: none;
  }
</style>
</head>
<body>
		<div style="display: block; margin: auto; width: 1100px; height: 100%; padding-top:100px;" class="w3-center">
			<div class="w3-padding-32">

					<div class="page">
						<span class="txt">
							<c:if test="${boardId ==1}">Notice 글쓰기</c:if>
							<c:if test="${boardId ==2}">QnA 글쓰기</c:if>
							<c:if test="${boardId ==3}">자유게시판 글쓰기</c:if>
						</span>						
					</div>
						<form:form modelAttribute="board" action="write" enctype="multipart/form-data" name="f">							
							<table class="w3-table-all">
								<c:if test="${boardId == 2 }">				
									<tr>
										<th colspan="2"  style="text-align: center;">
											<input type="checkbox" name="secret" value="Y" >&nbsp;<span>비밀글 설정</span>					
										</th>
									</tr>
								</c:if>
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
										<form:textarea path="content" id="content" cols="20" rows="20" class="w3-input"/> 
								<script>CKEDITOR.replace("content",{filebrowserImageUploadUrl : "imgupload"})</script>
										<font color="red"> 
											<form:errors path="content" />
										</font>
									</td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td>
										<input type="file" name="file1"  class="w3-input" /> 
									</td>
								</tr>
						</table>
						<input type="hidden" name="userId" value="${sessionScope.loginUser.userId}">	
						<input type="hidden" name="secret2" value="${sessionScope.loginUser.userId}">		
							<hr>
							<div>
								<div>
									<a href="list?boardId=${boardId}">
										<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">취소</button>
									</a>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;
									<button type="submit" class="w3-button w3-white w3-border w3-border-orange w3-round-large">등록</button>

								</div>
							</div>
						</form:form>
				</div>
			</div>



</body>
</html>