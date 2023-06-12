<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="page">
		<div class="join_top">
			<span class="txt">회원가입</span>
		</div>
	</div>
	<div class="join_insert">
		<form:form modelAttribute="user" method="post" action="join">
			<div class="join_title">
				<b>개인정보</b> 
				입력
			</div>
			<table> 
			 <tr>
			 	<th>아이디</th>
			 	<td>
			 		<input type="text" name="id" style="width:150px">
			 		<span class="btn_style_pack">
			 			<a href="none" onclick="idCheck()">
						"아이디중복확인"
						</a>
			 		</span>
			 		<div class="tip_text">영, 숫자조합 (6~12자)</div>
			 	</td>
			 </tr>
			 <tr>
			 	<th>비밀번호</th>
			 	<td>
			 		<input type="password" name="password1"style="width:150px">
			 		<div class="tip_text">영, 숫자조합 (6~12자)</div>
			 	</td>
			 </tr>
			  <tr>
			 	<th>비밀번호 확인</th>
			 	<td>
				 	<input type="password" name="password2"style="width:150px">
			 	</td>
			 </tr>
			 <tr>
			 	<th>이름</th>
			 	<td>
			 		<input type="text" name="name" style="width:150px">
			 	</td>
			 </tr>
			 <tr>
			 	<th>생년월일</th>
			 	<td>
			 		<input type="text" name="birthday" style="width:150px">
			 	</td>
			 </tr>
			 <tr>
			 	<th>핸드폰번호</th>
			 	<td>
			 		<input type="text" name="tel" style="width:150px">
			 	</td>
			 </tr>
			 <tr>
			 	<th>이메일주소</th>
			 	<td>
			 		<input type="text" name="email" style="width:150px">
			 	</td>
			 </tr>
			 <tr>
			 	<th>지역</th>
			 	<td>
			 		<input type="">
			 	</td>
			 </tr>
			 			 
			 <input type="hidden" name="batchChk" value="1">
			</table>
			<div class="bottom_btn"> 
				<div>
					<a href="">취소</a>
					<a href="" onclick="join_submit()">회원가입</a>
				</div>
			</div>
		</form:form>
	</div>
	
	
</body>
</html>