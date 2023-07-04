<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사장 회원 가게 목록 조회하기</title>
</head>
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
	width: 10%;
	text-align: center;
}

td {
	background-color: white;
}

a {
	text-decoration: none;
}

textarea {
	width: 100%;
	height: 30em;
	border: 0.1px strong;
	resize: none;
}
</style>
<body>
	<script type="text/javascript">
		
	<%--$("#deleteRest").click(function() {
		return confilm("삭제 시 복구 불가능 합니다. 삭제하시겠습니까?")
		
	})--%>
		function deleteRest(btn) {
			if (confirm('삭제 시 가게를 복구할 수 없습니다. 삭제 하시겠습니까?')) {

				let num = parseInt($(btn).attr('id'))
				//	parseInt($(btn).attr('id'))

				$.ajax({
					type : 'POST',
					url : '/project/restaurant/ownerRest',
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
						console.log(result);
					}
				})
			}
		}
	</script>
	<div class="w3-container w3-padding-32 w3-center">
		<div
			style="display: block; margin: auto; width: 1100px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<form action="ownerRest" method="post" name="owrestList">
							<table>
								<tr>
								<tr>
								<tr>
									<th>식당 이름</th>
									<th>식당 위치</th>
									<th>식당 전화번호</th>
									<th></th>
								</tr>
								<c:forEach items="${ownerRest}" var="orsrvt">
									<tr>
										<td align="center">${orsrvt.name}</td>
										<td align="center">${orsrvt.address}</td>
										<td align="center">${orsrvt.restPhoneNo}</td>
										<td><input type="hidden" ${orsrvt.restNum}></td>
										<td><input type="hidden" ${orsrvt.userId}></td>
										<td><input type="hidden" ${orsrvt.delYn}></td>
										<td><input type="hidden" ${orsrvt.restNum}></td>
										<td><a href="restUpdate?num=${orsrvt.restNum}"> <input
												type="button" value="상세보기 및 수정">
										</a></td>
										<td><input type="button" id="${orsrvt.restNum}"
											value="가게 삭제" onclick="deleteRest(this)"></td>
										<td><a
											href="${path}/reservation/ownerList?num=${orsrvt.restNum}">
												<input type="button" value="예약 목록">
										</a></td>
									</tr>

								</c:forEach>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>