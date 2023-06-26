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
		function file_delete() {
			document.f.fileurl.value = ""
			file_desc.style.display = "none";
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
		<div
			style="display: block; margin: auto; width: 1100px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<div class="join_top">
							<span class="txt">${boardName} 수정</span>
						</div>
					</div>

						<form:form modelAttribute="board" action="update" enctype="multipart/form-data" name="f">
						<form:hidden path="num" />							
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
											<div id="file_desc">
												<a href="file/${board.fileurl}">${board.fileurl}</a>
												<a href="javascript:file_delete()">[첨부파일삭제]</a>
											</div>
										</c:if>
										<form:hidden path="fileurl"/>
										<input type="file" name="file1"  class="w3-input" /> 
										
									</td>
								</tr>
						</table>
						<input type="hidden" name="userId" value="${sessionScope.loginUser.userId}">			
							<hr>
							<div>
								<div>
									<a href="list">
										<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">취소</button>
									</a>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;
									<button type="submit" class="w3-button w3-white w3-border w3-border-orange w3-round-large">수정</button>

								</div>
							</div>
						</form:form>
				</div>
			</div>
		</div>
	</div>


</body>
</html>