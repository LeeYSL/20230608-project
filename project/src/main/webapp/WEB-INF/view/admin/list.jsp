<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원리스트</title>
<script type="text/javascript">
	function listpage(page){
		document.searchform.pageNum.value=page;
		document.searchform.submit();
	}
	function allchkbox(allchk){
		$(".idchks").prop("checked",allchk.checked)
		
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
		<div style="display: block; margin: auto; width: 1100px; height: 100%">
			<div class="w3-padding-32">
			<form action="list" method="post" name="searchform">
				<table class="w3-table-all">
					<tr>
						<td width="30%">
						<input type="hidden" name="pageNum" value="1">
							<div>
								<select name="type" class="w3-input">
									<option value="">전체</option>
									<option value="user_id">아이디</option>
									<option value="nickname">닉네임</option>
									<option value="email">이메일</option>
									<option value="tel">휴대전화번호</option>
								</select>
							</div>
						</td>
						<td width="60%">
							<div>
								<input type="text" name="searchcontent" class="w3-input">
							</div>
						</td>
						<td width="10%">
							<div>
								<button class="w3-button w3-white w3-border w3-border-orange w3-round-large">검색</button>
							</div>
						<td>
					</tr>
				</table>
				</form>
			</div>
			<br>
			<div>
				<table class="w3-table-all">
					<tr>
						<th>아이디</th>
						<th>닉네임</th>
						<th>이메일</th>
						<th>휴대전화번호</th>
						<th><input type="checkbox" name="allchk" onchange="allchkbox(this)"></th>
					</tr>

					<c:forEach var="user" items="${userlist}">
						<tr>
							<td><a href="../user/userinfo?userId=${user.userId}">${user.userId}</a>
							</td>
							<td>${user.nickname}</td>
							<td>${user.email}</td>
							<td>${user.tel}</td>
							<td><input type="checkbox" name="idchks" class="idchks" value="${user.userId}"></td>
						</tr>
					</c:forEach>
						<tr>
							<td colspan="5" class="w3-center">
								<c:if test="${pageNum > 1}">
									<a href="javascript:listpage('${pageNum -1}')">[이전]</a>
								</c:if>
								<c:if test="${pageNum <= 1}">[이전]</c:if>
								<c:forEach var="a" begin="${startpage}" end="${endpage}">
									<c:if test="${a == pageNum}">[${a}]</c:if>
									<c:if test="${a != pageNum}">
										<a href="javascript:listpage('${a}')">[${a}]</a>
									</c:if>
								</c:forEach>
								<c:if test="${pageNum < maxpage}">
									<a href="javascript:listpage('${pageNum +1}')">[다음]</a>
								</c:if>
								<c:if test="${pageNum >= maxpage}">[다음]</c:if>
							</td>
						</tr>
				</table>
			</div>
			<div>
			<br>		
				<a href="mail">
					<button class="w3-button w3-white w3-border w3-border-orange w3-round-large w3-right">메일보내기</button>
				</a>
			</div>
		</div>
	</div>
</body>
</html>