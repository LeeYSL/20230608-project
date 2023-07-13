<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답글</title>
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
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1100px; height: 100%;">
			<div class="w3-padding-32">

				<div class="side">
					<div class="page">
						<div class="join_top">
							<span class="txt">${boardName} 답변</span>
						</div>
					</div>
						<form:form modelAttribute="board" action="reply" enctype="multipart/form-data" name="f">							
							<form:hidden path="num" />
							<form:hidden path="boardId" />
							<form:hidden path="grp" />
							<form:hidden path="grpLevel" />
							<form:hidden path="grpStep" />	
							<form:hidden path="secret" />
							<form:hidden path="secret2" />
							
							<table class="w3-table-all">
								<tr>
									<th>제목</th>
									<td>									
										<form:input path="title"  value="RE:${board.title}" class="w3-input" /> 
										<font color="red"> 
											<form:errors path="title" />
										</font>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<textarea name="content" cols="20" rows="20" class="w3-input"></textarea> 
										<font color="red"> 
											<form:errors path="content" />
										</font>
										
									</td>
								</tr>
						<%--	<script>CKEDITOR.replace("content",{filebrowserImageUploadUrl : "imgupload"})</script>  --%>
								<tr>
									<th>첨부파일</th>
									<td>
										<input type="file" name="file1"  class="w3-input" /> 
									</td>
								</tr>
						</table>
						<input type="hidden" name="userId" value="${sessionScope.loginUser.userId}">			
							<hr>
							<div>
								<div>
									<a href="list?boardId=${board.boardId}">
										<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">취소</button>
									</a>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;
									<button type="submit" class="w3-button w3-white w3-border w3-border-orange w3-round-large">등록</button>

								</div>
							</div>
						</form:form>
				</div>
			</div>
		</div>
</div>


</body>
</html>