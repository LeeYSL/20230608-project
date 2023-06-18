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


</style>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div
			style="display: block; margin: auto; width: 800px; height: 533px;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<div class="join_top">
							<a href="userinfo?userId=${sessionScope.loginUser.userId}">
								<span class="txt">${sessionScope.loginUser.nickname}</span>
							</a>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>


</body>
</html>