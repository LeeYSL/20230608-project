<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function win_open(page){
		var op ="width=500, height=350, left=50, top=150";
		open(page,"",op);
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
 margin: 0% 30% 0% 30%;
 padding-bottom: 3%;
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
		<div class="w3-padding-32">
			<div class="page">
				<span class="txt">로그인</span>
			</div>
			<form method="post" action="login" name="loginform">
				<div class="table_div">
					<table class="w3-table-all" id="table">
						<tr>									
							<td>
								<input type="text" name="userId" placeholder="아이디" class="w3-input">
							</td>
						</tr>
						<tr>
							<td>
								<input type="password" name="pw" placeholder="비밀번호는 8자~16자" class="w3-input">
							</td>
						</tr>
					</table>
					<br>
					<div class="w3-center">
						<div class="w3-center">
							<button type="submit" class="w3-button w3-white w3-border w3-border-orange w3-round-large">로그인</button>
						</div>
						<br>
						<hr>
						<div class="w3-center">
							<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large" onclick="win_open('idsearch')">아이디 찾기</button>
							&nbsp;	&nbsp;	&nbsp;	&nbsp;
							<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large" onclick="win_open('pwsearch')">비밀번호 찾기</button>
							&nbsp;	&nbsp;	&nbsp;	&nbsp;
							<input type="button" onclick="location.href='intro'" class="w3-button w3-white w3-border w3-border-orange w3-round-large" value="회원가입">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>		
</body>
</html>