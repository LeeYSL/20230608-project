<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<style type="text/css">
.page {

	height: 10%;
	display: block;
}

.txt {
	font-size: 200%;
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
		<div style="display: block; margin: auto; width: 800px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<div class="join_top">
							<span class="txt">회원탈퇴</span>
						</div>
					</div>
						<form method="post" action="delete">
							<input type="hidden" name="userId" value="${param.userId}">					
							<table class="w3-table-all w3-white w3-border w3-border-orange w3-round-large">
								<tr>
									<td>
										<input type="text" name="pw" class="w3-input" placeholder="비밀번호" /> 
									</td>
								</tr>
								<tr>
									<td>
										<input type="text" name="pw1"  class="w3-input" placeholder="비밀번호 재확인" /> 
									</td>
								</tr>
							</table>
							<hr>
							<div class="bottom_btn">
								<div>
									<a href="userinfo?userId=${param.userId}">
										<button type="button"
											class="w3-button w3-white w3-border w3-border-orange w3-round-large">취소</button>
									</a>
									<button type="submit"
										class="w3-button w3-white w3-border w3-border-orange w3-round-large">탈퇴하기</button>
								</div>
							</div>
						</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>