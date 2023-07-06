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
		<div style="display: block; margin: auto; width: 1100px; ">
			<div class="w3-padding-32">
				<div class="side">
					<div class="page">
						<header class="l_member_header">
							<h1 class="tit">
								<span>내 가게 예약 목록</span>
							</h1>
						</header>
					</div>
						<table class="w3-table-all">
							<tr>
						<!-- 	<th style="text-align: center;">예약 번호</th>  -->	
								<th style="text-align: center: ;">가게 이름</th>
								<th style="text-align: left: ;">예약자 성함</th>
								<th style="text-align: center;">예약자 전화번호</th>
								<th style="text-align: center;">예약 날짜</th>
								<th style="text-align: center;">예약 시간</th>
								<th style="text-align: center;">예약 인원</th>
								<th style="text-align: center;">예약 상태</th>
								<th></th>
							</tr>

							<c:forEach items="${rsrvtList}" var="rsrvt">
								<!--reservation 객체를 만들어서 rstvt라는 이름에 넣고 필요한 요소들을 뽑아온다.  -->
								<tr>
								<!--  <td align="center" style=" vertical-align:middle;">${rsrvt.num}</td> -->	
								    <td name="restName" style=" vertical-align:middle;">${rsrvt.name}</td>
									<td name="rsrvtName" style=" vertical-align:middle;">${rsrvt.rsrvtName}</td>
									<td name="phoneNo" style="text-align: center; vertical-align:middle;">${rsrvt.phoneNo}</td>
									<td name="rsrvtDate" style="text-align: center; vertical-align:middle;">${rsrvt.rsrvtDate}</td>
									<td name="rsrvtTime" style="text-align: center; vertical-align:middle;">${rsrvt.rsrvtTime}</td>
									<td name="people" style="text-align: center ; vertical-align:middle;">${rsrvt.people}</td>
 								<%-- <td name="people" style=" vertical-align:middle;">${rsrvt.people}</td>  --%>
									
									<td><select class="w3-select" name="confirm${rsrvt.num}" style=" vertical-align:middle;">
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
								<c:if test="${rsrvtList.size() == 0}">
									<td colspan="9" style="text-align: center;">등록된 예약이 없습니다.</td>
								</c:if> 
								<c:if test="${rsrvtList.size() != 0}">
									<td colspan="9" class="w3-center">
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
								</c:if>
							</tr>
						</table>
						<input type="hidden" name="pageNum" value="1">
					   <input type="hidden" ${rsrvt.num}>
					</div>
				</div>
			</div>
		</div>
</body>
</html>