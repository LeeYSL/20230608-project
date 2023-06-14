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
.side {
	margin: 0% 25% 0% 25%;
	height: 100%;
	text-align: center;
	display: block;
}

.page {
	border: 1px gray solid;
	height: 10%;
	display: block;
}

.txt {
	font-size: 200%;
}

.join_insert {
	height: 90%;
	border: 1px gray solid;
	text-align: center;
	display: block;
}

table {
	border: 1px gray solid;
	width: 90%;
	margin: 5%;
}

th {
	width: 20%;
}

td {
	width: 80%;
}
</style>
</head>
<body>
	<div class="side">
		<div class="page">
			<div class="join_top">
				<span class="txt">내 회원정보</span>
			</div>
		</div>
		<div class="join_insert">
			
				<table>
					<tr>
						<td>아이디</td>
						<td>${user.userId}</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="button" value="비밀번호 수정"></td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td>${user.nickname}</td>
					</tr>
					<tr>
						<td>이름</td>
						<td>${user.name}</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td>${user.tel}</td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td>${user.birthday}</td>
					</tr>
					<tr>
						<td>주소</td>
						<td><fmt:formatDate value="${user.address}" pattern="yyyy-MM-dd" /></td>
					</tr>
				</table>
			
		</div>
	</div>


</body>
</html>