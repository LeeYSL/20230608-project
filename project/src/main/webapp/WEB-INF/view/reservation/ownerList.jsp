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
		function update(btn){
			//selectbox value 조회
			let confirm = $(btn).parent().siblings().find('select').val();
			
			//업데이트해야할 row의 예약번호를 조회
			let num = $(btn).attr('name');
			
			$.ajax({
				 url:'/project/reservation/ownerList'
				,type:'POST'
				,dataType:'json'
				,data:{'num':num , 'confirm':confirm}
				,success:function(result){
					console.log("success");
				}
				,complete:function(result){
					console.log("complete");
				},error:function(result){
					console.log("err");
					console.log(result);
				}
			})	
		}
	</script>
	
		<h2>예약 목록</h2>
		<table>
			<tr>
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
					<td align="center">${rsrvt.num}</td>
					<td align="center">${rsrvt.rsrvtName}</td>
					<td align="center">${rsrvt.phoneNo}</td>
					<td align="center">${rsrvt.rsrvtDate}</td>
					<td align="center">${rsrvt.rsrvtTime}</td>
					<td align="center">${rsrvt.people}</td>
					<td><select name="confirm${rsrvt.num}">
							<option value="0" ${rsrvt.confirm == '0' ? 'selected="selected"' : '' }>승인 대기</option>
							<option value="1" ${rsrvt.confirm == '1' ? 'selected="selected"' : '' }>승인</option>
							<option value="2" ${rsrvt.confirm == '2' ? 'selected="selected"' : '' }>거절</option>
						</select> <input type="hidden" ${rsrvt.confirm}>
					</td>
					<td>
						<button type="button" name="${rsrvt.num}" onclick="update(this)">확정</button>
					</td>
				</tr>
			</c:forEach>
		</table>
</body>
</html>