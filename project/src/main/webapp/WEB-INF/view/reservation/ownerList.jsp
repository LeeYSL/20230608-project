<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta charset="UTF-8">
<title>사장 로그인 예약 목록</title>
</head>
<body>
	<script>
		function listpage(page) {
			document.searchform.pageNum.value = page;
			document.searchform.submit();
		}

		function update(btn) {
			//selectbox value 조회
			let confirm = $(btn).parent().siblings().find('select').val();

			//업데이트해야할 row의 예약번호를 조회
			let num = $(btn).attr('name');
	<%--name="${rsrvt.num}" --%>
		$.ajax({
				url : '/project/reservation/ownerList',
				type : 'POST',
				dataType : 'json',
				data : {
					'num' : num,
					'confirm' : confirm,
					//객체로 넘기는 방법
					//	'reservation' : {'restName' : $(btn).parent().siblings('td[name="restName"]').text(),  
					//                        'rsrvtName' : $(btn).parent().siblings('td[name="rsrvtName"]').text(),
					//                        'phoneNo' : $(btn).parent().siblings('td[name="phoneNo"]').text(),
					//                        'rsrvtDate' : $(btn).parent().siblings('td[name="rsrvtDate"]').text(),
					//                        'rsrvtTime' : $(btn).parent().siblings('td[name="rsrvtTime"]').text(),
					//                   	 'people'    : $(btn).parent().siblings('td[name="people"]').text()}		
					//하나씩 넘기는 방법	   	'people'    : $(btn).parent().siblings('td[name="people"]').text();	

					'restName' : $(btn).parent()
							.siblings('td[name="restName"]').text(),
					'rsrvtName' : $(btn).parent().siblings(
							'td[name="rsrvtName"]').text(),
					'phoneNo' : $(btn).parent().siblings('td[name="phoneNo"]')
							.text(),
					'rsrvtDate' : $(btn).parent().siblings(
							'td[name="rsrvtDate"]').text(),
					'rsrvtTime' : $(btn).parent().siblings(
							'td[name="rsrvtTime"]').text(),
					'people' : $(btn).parent().siblings('td[name="people"]')
							.text()
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
	</script>
	<div class="w3-container w3-padding-32 w3-center">
		<div
			style="display: block; margin: auto; width: 1100px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<h2>예약 목록</h2>
						<table class="w3-table-all">
							<tr>
								<th>가게 이름</th>
								<th>예약 번호</th>
								<th>예약자 성함</th>
								<th>예약자 전화번호</th>
								<th>예약 날짜</th>
								<th>예약 시간</th>
								<th>예약 인원</th>
								<th>예약 상태</th>
								<th></th>
							</tr>

							<c:forEach items="${rsrvtList}" var="rsrvt">
								<!--reservation 객체를 만들어서 rstvt라는 이름에 넣고 필요한 요소들을 뽑아온다.  -->
								<tr>
									<td name="restName" align="center">${rsrvt.name}</td>
									<td align="center">${rsrvt.num}</td>
									<td name="rsrvtName" align="center">${rsrvt.rsrvtName}</td>
									<td name="phoneNo" align="center">${rsrvt.phoneNo}</td>
									<td name="rsrvtDate" align="center">${rsrvt.rsrvtDate}</td>
									<td name="rsrvtTime" align="center">${rsrvt.rsrvtTime}</td>
									<td name="people" align="center">${rsrvt.people}</td>
									<td><select name="confirm${rsrvt.num}">
											<option value="0"
												${rsrvt.confirm == '0' ? 'selected="selected"' : '' }>승인
												대기</option>
											<option value="1"
												${rsrvt.confirm == '1' ? 'selected="selected"' : '' }>승인</option>
											<option value="2"
												${rsrvt.confirm == '2' ? 'selected="selected"' : '' }>거절</option>
											<option value="3"
												${rsrvt.confirm == '3' ? 'selected="selected"' : '' }
												disabled="true">예약 취소</option>
											<option value="4"
												${rsrvt.confirm == '4' ? 'selected="selected"' : '' }
												disabled="true">이용 완료</option>
									</select> <input type="hidden" ${rsrvt.confirm}></td>
									<td><c:if test="${rsrvt.confirm == 0}">
											<button type="button" name="${rsrvt.num}"
												class="w3-btn w3-white w3-border w3-border-orange w3-round-xlarge"
												onclick="update(this)">확정</button>
										</c:if></td>
								</tr>
							</c:forEach>

							<tr>
								<td width="30%"><input type="hidden" name="pageNum"
									value="1"> <c:if test="${listcount == 0}">
										<td colspan="5" align="right">등록된 예약이 없습니다.</td>
									</c:if> <c:if test="${listcount != 0}">
										<td colspan="7" class="w3-center"><c:if
												test="${pageNum > 1}">
												<a href="javascript:listpage('${pageNum -1}')">[이전]</a>
											</c:if> <c:if test="${pageNum <= 1}">[이전]</c:if> <c:forEach var="a"
												begin="${startpage}" end="${endpage}">
												<c:if test="${a == pageNum}">[${a}]</c:if>
												<c:if test="${a != pageNum}">
													<a href="javascript:listpage('${a}')">[${a}]</a>
												</c:if>
											</c:forEach> <c:if test="${pageNum < maxpage}">
												<a href="javascript:listpage('${pageNum +1}')">[다음]</a>
											</c:if> <c:if test="${pageNum >= maxpage}">[다음]</c:if></td></c:if>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>