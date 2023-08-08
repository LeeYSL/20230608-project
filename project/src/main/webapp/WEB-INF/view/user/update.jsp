<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		function file_delete() {
			document.f.fileurl.value = ""
			file_desc.style.display = "none";
		}
		function searchAddress() {
			new daum.Postcode({
				oncomplete : function(data) { // oncomplete : 콜백함수
					$("#address").val(data.address);
				}
			}).open();
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
	width:30%;
	text-align: center;
	height: 50px;
	
}
td {
	background-color :white;
	height: 50px;
}

#table{
	width: 700px;
}

.table_div {
 margin: 0% 30% 0% 20%;
 padding-bottom: 3%;
}


a {
	text-decoration: none;
}


</style>
</head>
<body>
	<div style="display: block; margin: auto; width: 1100px; height: auto; padding-top: 100px;"
		class="w3-center">
		<div class="w3-padding-32">
			<div class="page">
				<span class="txt">회원 정보 수정</span>
			</div>

						<form:form modelAttribute="user" enctype="multipart/form-data"  name="f" action="update">
							<spring:hasBindErrors name="user">
								<font color="red"> 
									<c:forEach items="${errors.globalErrors}" var="error">
										<spring:message code="${error.code}" />
										<br>
									</c:forEach>
								</font>
							</spring:hasBindErrors>
			<div class="table_div">
					<table class="w3-table-all" id="table">
								<tr>
									<th>아이디</th>
									<td>
										<form:input path="userId" class="w3-input"  readonly="true"/> 
										<font color="red"> 
											<form:errors path="userId" />
										</font>
									</td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td>
										<form:input type="password" path="pw" class="w3-input" placeholder="비밀번호" /> 
										<font color="red"> 
											<form:errors path="pw" />
										</font>
									</td>
								</tr>
								<tr>
									<th>닉네임</th>
									<td>
										<form:input path="nickname"  class="w3-input"  placeholder="별명" /> 
										<font color="red"> 
											<form:errors path="nickname" />
										</font>
									</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>
										<form:input path="name"  class="w3-input"  readonly="true" /> 
										<font color="red"> 
											<form:errors path="name" />
										</font>
									</td>
								</tr>
								<tr>
									<th>휴대전화번호</th>
									<td>
										<form:input path="tel"  class="w3-input"  placeholder="휴대폰번호" /> 
										<font color="red"> 
											<form:errors path="tel" />
										</font>
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<form:input path="email"  class="w3-input" readonly="true" placeholder="이메일" /> 
										<font color="red"> 
											<form:errors path="email" />
										</font>
									</td>
								</tr>									
								<tr>
								<tr>
									<th>주소</th>
									<td>
										<form:input path="address" name="address" class="w3-input" id="address" onclick="searchAddress();" />						
									</td>
								</tr>
								<tr>
									<th>프로필사진</th>
									<td>
										<c:if test="${!empty user.fileurl}">
											<div id="file_desc">
												<a href="file/${user.fileurl}">${user.fileurl}</a>
												<a href="javascript:file_delete()">[첨부파일삭제]</a>
											</div>
										</c:if>
										<form:hidden path="fileurl"/>
										<input type="file" name="file1"  class="w3-input" /> 
										
									</td>
								</tr>							
							</table>
							</div>
							<br>
							<input type="hidden" name="batch" value="${user.batch}">


								<div class="w3-center">
									<a href="userinfo?userId=${user.userId}">
										<button type="button"
											class="w3-button w3-white w3-border w3-border-orange w3-round-large">취소</button>
									</a>
									&nbsp;	&nbsp;	&nbsp;	&nbsp;
									<button type="submit"
										class="w3-button w3-white w3-border w3-border-orange w3-round-large">수정</button>
								</div>
				
						</form:form>
				</div>
			</div>
	
</body>
</html>