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
	width:20%;
	text-align: center;
	
}
td {
	background-color :white;
}


</style>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 800px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<div class="join_top">
							<span class="txt">내 회원정보</span>
						</div>
					</div>
					<table class="w3-table-all">
						<tr>
							<th>아이디</th>
							<td>${user.userId}</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<a href="pwchange?userId=${user.userId}">
									<input type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large" value="비밀번호 수정">
								</a>
							</td>	
						</tr>
						<tr>
							<th>닉네임</th>
							<td>${user.nickname}</td>

						</tr>
						<tr>
							<th>이름</th>
							<td>${user.name}</td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td><fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd" /></td>
						</tr>
						<tr>
							<th>휴대전화번호</th>
							<td>${user.tel}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${user.email}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>${user.address}</td>
						</tr>

					</table>
					<div>
						<div>
							<a href="update?userId=${user.userId}">
								<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">회원정보 수정</button>
							</a>
						</div>
						<div>
							<a href="delete?userId=${user.userId}">
								<button type="button"
									class="w3-button w3-white w3-border w3-border-orange w3-round-large">회원탈퇴</button>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

</html>