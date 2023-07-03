<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일</title>
<script type="text/javascript">
	function idchk(f) {
		if(f.naverid.value == "") {
			alert("네이버 아이디를 입력하세요");
			f.naverid.focus();
			retrun false;
		}
		if(f.naverpw.value == "") {
			alert("네이버 비밀번호를 입력하세요");
			f.naverpw.focus();
			return false;
		}
		return true;
	}

</script>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1100px; height: 100%;">
			<div class="w3-padding-32" style="height: 100%;">
				<div class="side">
					<div class="page">
						<div class="join_top">
							<span class="txt">메일</span>
						</div>
					</div>
				</div>
				<form name="mailform" method="post" action="mail" enctype="multipart/form-data"  onsubmit="return idchk(this)">
						본인 네이버 ID : <input type="text" name="naverid" class="w3-input">
		본인 네이버 비밀번호 : <input type="password" name="naverpw" class="w3-input">
				<table class="w3-table-all">
<%--
					<tr>
						<th>네이버 ID</th>
						<td>
							<input type="text" name="naverid" class="w3-input">
						</td>
					</tr>				
					<tr>
						<th>네이버 비밀번호</th>
						<td>
							<input type="text" name="naverpw" class="w3-input">
						</td>
					</tr>				
 --%>					
					<tr>
						<th>보내는 사람</th>
						<td>${loginUser.email}</td>
					</tr>
					<tr>
						<th>받는 사람</th>
						<td>
							<input type="text" name="recipient" 
							value='<c:forEach items="${list}" var="user">${user.nickname} &lt;${user.email}&gt;,</c:forEach>' 
							class="w3-input">
						</td>
					</tr>
			<tr>
				<td>메세지형식</td>
				<td>
					<select name="mtype" class="w3-input">
						<option value="text/html; charset=utf-8">HTML</option>
						<option value="text/plain; charset=utf-8">TEXT</option>
						<!-- 소스보기 만들어주는 틀이 ckeditor 임? -->
					</select>
				</td>
			</tr>										
					<tr>
						<th>제목</th>
						<td>
							<input type="text" name="title" class="w3-input">
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea name="contents" rows="20" cols="120" class="w3-input"></textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일1</th>
						<td>
							<input type="file" name="file1">
						</td>
					</tr>
					<tr>
						<th>첨부파일2</th>
						<td>
							<input type="file" name="file1">
						</td>
					</tr>					
				</table>
				<br>
				<div>
					<div>
						<button type="submit"
							class="w3-button w3-white w3-border w3-border-orange w3-round-large">전송</button>
					</div>
				</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>