<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>   
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
	border: 0.5px gray solid;
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
		<table>
			<tr>
				<td id="tab1" class="tab"><a href="javascript:user_div()">개인
						회원가입</a></td>
				<td id="tab2" class="tab"><a href="javascript:owner_div()">사업자
						회원가입</a></td>
		</table>

		<div id="uregister" class="info">
			<table>
				<tr>
					<button type="button">가입하기</button>
				</tr>
			</table>
		</div>
		<div id="oregister" class="info">
			<table>
				<tr>
					<button type="button">인증</button>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>