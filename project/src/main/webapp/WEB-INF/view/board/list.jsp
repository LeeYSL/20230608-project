<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
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
	<div style="display:block; margin:auto; width:900px; height:100%;">
	<div class="w3-padding-32">
		<table class="w3-table-all" >
			<tr>
				<td width="30%">
					<div>
						<select name="type" class="w3-input">
							<option>전체</option>
							<option>제목</option>
							<option>작성자</option>
							<option>글내용</option>
						</select>
					</div>
				</td>
				<td width="60%">
					<div>
						<input type="text"	class="w3-input">
					</div>
				</td>
				<td width="10%">
					<div>
						<button class="w3-button w3-white w3-border w3-border-orange w3-round-large">검색</button>
					</div>
				<td>
			</tr>
		</table>
	</div>
	<br>
	<div>
		<table class="w3-table-all">
			<tr>
				<th></th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>좋아요</th>
			</tr>
			
			<c:forEach var="board" items="${boardlist}">
				<tr>
					<td>
						${board.num}
					</td>
					<td>
						${board.nickname}
					</td>
					<td>
						${user.nickname}
					</td>
					<td>
						${board.regDate}
					</td>
					<td>
						${board.readCnt}
					</td>
					<td>
						좋아요 넣기
					</td>					
				</tr>
			</c:forEach>
		</table>
		</div>
		<div>
			<a href="write?boardId=${boardId}">
				<button class="w3-button w3-white w3-border w3-border-orange w3-round-large w3-right">글쓰기</button>
			</a>
		</div>
	</div>
</div>
</body>
</html>