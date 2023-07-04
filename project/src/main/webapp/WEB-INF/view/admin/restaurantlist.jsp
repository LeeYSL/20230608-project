<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가게리스트</title>
<script type="text/javascript">
	function listpage(page){
		document.searchform.pageNum.value=page;
		document.searchform.submit();
	}
	function allchkbox(allchk){
		$(".restchks").prop("checked",allchk.checked)
		
	}
	function deleteRest(btn) {
		if (confirm('삭제 시 가게를 복구할 수 없습니다. 삭제 하시겠습니까?')) {

			let num = parseInt($(".restchks").attr('value'))
			//	parseInt($(btn).attr('id'))

			$.ajax({
				type : 'POST',
				url : '/project/admin/restaurantlist',
				dataType : 'json',
				data : {
					'num' : num,
					'delYn' : 'Y'
				},
				success : function(result) {
					console.log("success");
				},
				complete : function(result) {
					console.log("complete");
				},
				error : function(result) {
					console.log("err");
				}
			})
		}
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
			<form action="restaurantlist" method="post" name="searchform">
				<table class="w3-table-all">
					<tr>
						<td width="30%">
						<input type="hidden" name="pageNum" value="1">
							<div>
								<select name="type" class="w3-input">
									<option value="">전체</option>
									<option value="name">가게 이름</option>
									<option value="address">지역</option>
									<option value="menu">메뉴</option>
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
						<th>가게번호</th>
						<th>가게이름</th>
						<th>사업자이름</th>
						<th>사업자등록번호</th>
						<th><input type="checkbox" name="allchk" onchange="allchkbox(this)"></th>
					</tr>

					<c:forEach var="rest" items="${restList}">
						<tr>
							<td>
								<a href="../restaurant/restaurantInfo?num=${rest.restNum}">${rest.restNum}</a>
							</td>						
							<td>
								<a href="../restaurant/restaurantInfo?num=${rest.restNum}">${rest.name}</a>
							</td>
							<td>${rest.userId}</td>
							
							<td><a href="../restaurant/restaurantInfo?num=${rest.restNum}">${rest.licenseNum}</a></td>
							<td><input type="checkbox" name="restchks" class="restchks" value="${rest.restNum}"></td>
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
				<input type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large w3-right"
											value="가게 삭제" onclick="deleteRest(this)">
			</div>
		</div>
	</div>
</body>
</html>