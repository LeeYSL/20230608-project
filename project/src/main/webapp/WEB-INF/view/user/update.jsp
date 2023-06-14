<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>    
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.side{
	margin: 0% 25% 0% 25%;
	height: 100%;
	text-align: center;
	display: block ;
}
.page{
	border: 1px gray solid;
	height :10%;
	display: block ;	
}

.txt {
	font-size: 200% ;
}
.join_insert{
	height : 90%;	
	border: 1px gray solid;
	text-align: center;
	display: block ;
}
table {
	border : 1px gray solid;
	width :90%;
	margin: 5%;
}
th {
	width : 20%;
	
}
td {
	width : 80%;
}




</style>
</head>
<body>
<div class="side">
	<div class="page">
		<div class="join_top">
			<span class="txt">내 회원정보</span>
		</div>
	</div>
	<div class="join_insert">
		<form:form modelAttribute="user" method="post" action="join">
			<spring:hasBindErrors name="user">
				<font color="red">
					<c:forEach items="${errors.globalErrors}" var="error">
						<spring:message code="${error.code}" /> <br> 
					</c:forEach>
				</font>
			</spring:hasBindErrors>
		
			<div class="join_title">
				<b>개인정보</b> 
				입력
			</div>
			<table class="join_table"> 
			 <tr>
			 	<td>
			 		<form:input path="userId" placeholder="아이디" />
			 		<font color="red">
						<form:errors path="userId" />
					</font>
			 	</td>
			 </tr>
			 <tr>
			 	<td>
			 		<form:input path="pw" placeholder="비밀번호" />
			 		<font color="red">
						<form:errors path="pw" />
					</font>
			 	</td>
			 </tr>
			 <tr>
			 	<td>
			 		<form:input path="nickname" placeholder="별명" />
			 		<font color="red">
						<form:errors path="nickname" />
					</font>
			 	</td>
			 </tr>
			 <%--
			  <tr>
			 	<td>
				 	<form:input path="pw" placeholder="비밀번호 확인" />
				 	<font color="red">
						<form:errors path="pw" />
					</font>
			 	</td>
			 </tr>
			  --%>
			 <tr>
			 	<td>
			 		<form:input path="name" placeholder="이름" />
			 		<font color="red">
						<form:errors path="name" />
					</font>
			 	</td>
			 </tr>
			 <tr>
			 	<td>
			 		<form:input path="birthday" placeholder="생년월일" />
			 		<font color="red">
						<form:errors path="birthday" />
					</font>
			 	</td>
			 </tr>
			 <tr>
			 	<td>
			 		<form:input path="tel" placeholder="휴대폰번호" />
			 		<font color="red">
						<form:errors path="tel" />
					</font>
			 	</td>
			 </tr>
			 <tr>
			 	<td>
			 		<form:input path="email" placeholder="이메일" />
			 		<font color="red">
						<form:errors path="email" />
					</font>
			 	</td>
			 </tr>
			 <tr>
			 	<td>
			 		<select name="address">
			 			<option>강남구</option>
			 			<option>강동구</option>
			 			<option>강북구</option>
			 			<option>강서구</option>
			 			<option>관악구</option>
			 			<option>광진구</option>
			 			<option>구로구</option>
			 			<option>금천구</option>
			 			<option>노원구</option>
			 			<option>도봉구</option>
			 			<option>동대문구</option>
			 			<option>동작구</option>
			 			<option>마포구</option>
			 			<option>서대문구</option>
			 			<option>서초구</option>
			 			<option>성동구</option>
			 			<option>성북구</option>
			 			<option>송파구</option>
			 			<option>양천구</option>
			 			<option>영등포구</option>
			 			<option>용산구</option>
			 			<option>은평구</option>
			 			<option>종로구</option>
			 			<option>중구</option>
			 			<option>중랑구</option>			 			
			 		</select>
			 		
			 	</td>
			 </tr>			 			 
			</table>
			 <input type="hidden" name="batch" value="1">
			
			<hr>

			
			
			
			<div class="bottom_btn"> 
				<div>
					<button type="button">취소</button>
					<button type="submit">회원가입</button>
				</div>
			</div>
		</form:form>
	</div>
</div>
	

</body>
</html>