<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
.side{
	margin: 0% 25% 0% 25%;
	height: 100%;
	text-align: center;
	display: block ;
}
.page{
	border: 1px gray solid;
	height :10%;
	display: block ;	
}

.txt {
	font-size: 200% ;
}
.join_insert{
	height : 90%;	
	border: 1px gray solid;
	text-align: center;
	display: block ;
}
table {
	border : 1px gray solid;
	width :90%;
	margin: 5%;
}
th {
	width : 20%;
	
}
td {
	width : 80%;
}




</style>
</head>
<body>
<div class="side">
	<div class="page">
		<div class="join_top">
			<span class="txt">게시판 글쓰기</span>
		</div>
	</div>
	<div class="join_insert">
		<form:form modelAttribute="board" method="post" action="write">
			<spring:hasBindErrors name="user">
				<font color="red">
					<c:forEach items="${errors.globalErrors}" var="error">
						<spring:message code="${error.code}" /> <br> 
					</c:forEach>
				</font>
			</spring:hasBindErrors>
		
			<div class="join_title">
				<b>게시판이름</b> 
				
			</div>
			<table class="join_table"> 
			 <tr>
			 	<td>
			 		제목
			 	</td>
			 	<td>
			 		<form:input path="title" />
			 		<font color="red">
						<form:errors path="title" />
					</font>
			 	</td>
			 </tr>
			 <tr>
			 	<td>
			 		내용
			 	</td>
			 	<td>
			 		<form:input path="content" />
			 		<font color="red">
						<form:errors path="content" />
					</font>
			 	</td>
			 </tr>
			 <tr>
			 	<td>
			 		첨부파일
			 	</td>
			 	<td>
					<input type="file" name="file1">
			 	</td>
			 </tr>	 
			</table>			
			<hr>

			<div class="bottom_btn"> 
				<div>
					<button type="button">취소</button>
					<button type="submit">게시글 등록</button>
				</div>
			</div>
		</form:form>
	</div>
</div>
	
</body>
</html>