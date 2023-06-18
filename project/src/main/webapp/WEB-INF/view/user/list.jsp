<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원리스트</title>

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
		<div style="display: block; margin: auto; width: 900px; height: 533px;">
			<div class="w3-padding-32">
				<table class="w3-table-all">
					<tr>
						<td width="30%">
							<div>
								<select name="type" class="w3-input">
									<option>전체</option>
									<option>아이디</option>
									<option>닉네임</option>
									<option>이메일</option>
									<option>휴대전화번호</option>
								</select>
							</div>
						</td>
						<td width="60%">
							<div>
								<input type="text" class="w3-input">
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
						<th>아이디</th>
						<th>닉네임</th>
						<th>이메일</th>
						<th>휴대전화번호</th>
						<th><input type="checkbox"></th>
					</tr>

					<c:forEach var="user" items="${list}">
						<tr>
							<td><a href="userinfo?userId=${user.userId}">${user.userId}</a>
							</td>
							<td>${user.nickname}</td>
							<td>${user.email}</td>
							<td>${user.tel}</td>
							<td><input type="checkbox"></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>
</html>