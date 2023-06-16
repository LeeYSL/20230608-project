<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<table>
			<tr>
				<td>
					검색넣기
				</td>
			</tr>
		</table>
	</div>
	<div>
		<table>
			<tr>
				<td></td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
				<td>좋아요</td>
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

</body>
</html>