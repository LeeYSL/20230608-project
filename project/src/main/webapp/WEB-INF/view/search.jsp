<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title} 찾기</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style type="text/css">
table {
	border: 0.1% solid gray;

}

th {
	background-color: #ff8400;
	color: white;
	text-align: center;
}

td {
	background-color: white;
}

.w3-input {
	border: none;
}
</style>

<script type="text/javascript">
	function sendclose() {
		opener.document.loginform.userid.value='${result}';
		self.close();
	}
</script>
</head>
<body>
	<div style="padding-top: 40px;">
	<h5 class="w3-center">${title}</h5>
	<div class="w3-container" style="padding-top: 20px;">
<table class="w3-table-all" style="padding-top: 20px;">
	<tr class="w3-center">
		<th class="w3-center">${result}</th>
	</tr>
</table>
<div class="w3-center" style="padding-top:20px;">	
			<c:if test="${title=='아이디'}">
				<input type="button" value="닫기" onclick="self.close()" class="w3-button w3-white w3-border w3-border-orange w3-round-large">
			</c:if>
			<c:if test="${title=='비밀번호 초기화'}">
				<input type="button" value="닫기" onclick="self.close()" class="w3-button w3-white w3-border w3-border-orange w3-round-large">
			</c:if>
	</div>	
</div>
</div>		
</body>
</html>