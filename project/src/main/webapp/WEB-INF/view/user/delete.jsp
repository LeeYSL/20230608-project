<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>

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
	width:30%;
	text-align: center;
	height: 50px;
	
}
td {
	background-color :white;
	height: 50px;
}

#table{
	width: 500px;
}

.table_div {
 margin: 0% 30% 0% 28%;
 border: 1% solid;
}


a {
	text-decoration: none;
}
.w3-input {
	border: none;
}

</style>
</head>
<body>
	<div style="display: block; margin: auto; width: 1100px; height: auto; padding-top: 100px;"
		class="w3-center">
		<div class="w3-padding-64">
			<div class="page">
				<span class="txt">회원 탈퇴</span>
			</div>
			<form method="post" action="delete">
			<input type="hidden" name="userId" value="${param.userId}">	
				<div class="table_div">
					<table class="w3-table-all" id="table">
						<tr>									
							<td>
								<input type="password" name="pw" placeholder="비밀번호"  class="w3-input">
							</td>
						</tr>
						<tr>
							<td>
								<input type="password" name="pw1" placeholder="비밀번호 재확인" class="w3-input">
							</td>
						</tr>
					</table>
					<br>
					<div class="w3-center w3-padding-32">
						<div class="w3-center">
							<a href="userinfo?userId=${param.userId}">
								<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">취소</button>
							</a>
							&nbsp;	&nbsp;	&nbsp;	&nbsp;
							<button type="submit" class="w3-button w3-white w3-border w3-border-orange w3-round-large">탈퇴</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>		
</body>
</html>