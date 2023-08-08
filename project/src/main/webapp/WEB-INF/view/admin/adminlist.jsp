<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자리스트</title>
<script type="text/javascript">
	function adminlistpage(page){
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
	height: 40px;
}

a {
	text-decoration: none;
		color : black;
}


</style>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1100px; height: 110%">
			<div class="w3-padding-32">
				<header class="l_member_header">
					<div>
						<h1 class="tit" >
						<span>관리자 리스트</span>
						</h1>
					</div>				
				</header>	
				<br>
				<br>
				<br>
			<form action="adminlist" method="post" name="searchform">
				<table class="w3-table-all">
					<tr>
						<td width="30%">
						<input type="hidden" name="pageNum" value="1">
							<div>
								<select name="type" class="w3-input">
									<option value="" ${type == null ? 'selected="selected"' : '' }>전체</option>
									<option value="user_id" ${type == 'user_id' ? 'selected="selected"' : '' }>아이디</option>
									<option value="nickname" ${type == 'nickname' ? 'selected="selected"' : '' }>닉네임</option>
									<option value="email" ${type == 'email' ? 'selected="selected"' : '' }>이메일</option>
									<option value="tel" ${type == 'tel' ? 'selected="selected"' : '' }>휴대전화번호</option>
								</select>
							</div>
						</td>
						<td width="60%">
							<div>
								<input type="text" name="searchcontent" value="${searchcontent}" class="w3-input">
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
				<div style="text-align: right; font-size: 20px;">총 관리자수 : ${delListcount} 명</div>
			</div>
			<br>			
			<div>
				<table class="w3-table-all">
					<tr>
						<th width="20%" class="w3-center">아이디</th>
						<th width="20%" class="w3-center">닉네임</th>
						<th width="20%" class="w3-center">이메일</th>
						<th width="15%" class="w3-center">휴대전화번호</th>
						<th width="25%" class="w3-center"></th>
					</tr>

					<c:forEach var="user" items="${adminlist}">
						<tr >
							<td height="40px;"><a href="../user/userinfo?userId=${user.userId}">${user.userId}</a>
							</td>
							<td class="w3-center">${user.nickname}</td>
							<td class="w3-center">${user.email}</td>
							<td class="w3-center">${user.tel}</td>
							<td class="w3-center">
								<form action="admindelete" method="post">
								<c:if test="${user.delYn == 'N'}">
								<button name="userId" class="w3-button w3-center" value="${user.userId}">
									<i class="glyphicon glyphicon-remove"></i>
								</button>
								</c:if>
								<c:if test="${user.delYn == 'Y' }">
								탈퇴일 : <fmt:formatDate value="${user.delDate}" pattern="yyyy-MM-dd" />
								</c:if>
								
								</form>
							</td>
						</tr>
					</c:forEach>
						<tr>
															<td colspan="6" style="text-align: center;"><c:if
										test="${pageNum <= 1}">[이전]</c:if> <c:if
										test="${pageNum > 1 }">
										<a href="adminlist?pageNum=${pageNum-1}">[이전]</a>
									</c:if> <c:forEach var="a" begin="${startpage}" end="${endpage}">
										<c:if test="${a==pageNum}">[${a}]</c:if>
										<c:if test="${a != pageNum }">
											<a href="adminlist?pageNum=${a}">[${a}]</a>
										</c:if>
									</c:forEach> <c:if test="${pageNum >= maxpage}">[다음]</c:if> <c:if
										test="${pageNum < maxpage}">
										<a href="adminlist?pageNum=${pageNum+1}">[다음]</a>
									</c:if></td>
						</tr>
				</table>
			</div>
			<div>
			</div>
		</div>
	</div>
</body>
</html>