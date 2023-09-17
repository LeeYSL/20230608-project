<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>밥티켓</title>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#pw").keyup(function() {	
		let pwCheck = /^(?=.*?[a-zA-Z])(?=.*?[0-9]).{8,16}$/;
		if($("#pw").val() == ""){			
			$("#pwcheck").text("");
			$("#checkbox1").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 2) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			} 
		} else if (!pwCheck.test($("#pw").val())) {
				$("#pwcheck").css("color", "red");
				$("#pwcheck").text("❌");
				$("#checkbox1").prop("checked", false);
				let chk = $(".chkbox:checked").length;
				if (chk > 2) {
					console.log("체크");
					$("#button").prop("disabled", false);
				} else {
					console.log("언체크");
					$("#button").prop("disabled", true);
				}
			}  else {
			let pw = $("#pw").val();  
			let userId = $("#userId").val();  
			$.ajax({
				url: "pwChk",
				type: "get",
				data: {'pw':pw,
						'userId':userId
					
				},
				success: function(result) {
		            if (result == true) {
		    			$("#pwcheck").css("color", "blue");
		    			$("#pwcheck").text("✔️");
		    			$("#checkbox1").prop("checked", true);
		    			let chk = $(".chkbox:checked").length;
		    			if (chk > 2) {
		    				console.log("체크");
		    				$("#button").prop("disabled", false);
		    			} else {
		    				console.log("언체크");
		    				$("#button").prop("disabled", true);
		    			}
		            } else {
		    			$("#pwcheck").css("color", "red");
		    			$("#pwcheck").text("❌");
		    			$("#checkbox1").prop("checked", false);
		    			let chk = $(".chkbox:checked").length;
		    			if (chk > 2) {
		    				console.log("체크");
		    				$("#button").prop("disabled", false);
		    			} else {
		    				console.log("언체크");
		    				$("#button").prop("disabled", true);
		    			}
		            }
		        },
				error: function () {
					alert("비밀번호 전송에 오류가 생겼습니다.");
				}
			});		
		}
	});
			
		
		
	
	$("#pw1").keyup(function() {	
		let pw1Check = /^(?=.*?[a-zA-Z])(?=.*?[0-9]).{8,16}$/;
		if($("#pw1").val() == ""){			
			$("#pw1check").text("");
			$("#checkbox2").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 2) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		} else if (!pw1Check.test($("#pw1").val())) {
			$("#pw1check").css("color", "red");
			$("#pw1check").text("❌");
			$("#checkbox2").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 2) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		}  else {
			$("#pw1check").css("color", "blue");
			$("#pw1check").text("✔️");
			$("#checkbox2").prop("checked", true);
			let chk = $(".chkbox:checked").length;
			if (chk > 2) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		}	
	});
	$("#pw2").keyup(function() {	
		let pw2Check = /^(?=.*?[a-zA-Z])(?=.*?[0-9]).{8,16}$/;
		if($("#pw2").val() == ""){			
			$("#pw2check").text("");
			$("#checkbox3").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 2) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		} else if (!pw2Check.test($("#pw2").val())||$("#pw1").val()!=$("#pw2").val()) {
			$("#pw2check").css("color", "red");
			$("#pw2check").text("❌");
			$("#checkbox3").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 2) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		} else {
			$("#pw2check").css("color", "blue");
			$("#pw2check").text("✔️");
			$("#checkbox3").prop("checked", true);
			let chk = $(".chkbox:checked").length;
			if (chk > 2) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		}	
	});	
});
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
.w3-input {
	border: none;
}
.chkbox {
	display: none;

</style>
</head>
<body>
	<div style="display: block; margin: auto; width: 1100px; height: auto; padding-top: 100px;"
		class="w3-center">
		<div class="w3-padding-32">
			<div class="page">
				<span class="txt">비밀번호 수정</span>
			</div>
			<form:form modelAttribute="user" method="post" action="pwchange">
				<div class="table_div">
					<table class="w3-table-all" id="table">
						<tr>
							<th>비밀번호 *<input type="checkbox" id="checkbox1" class="chkbox"></th>
							<td>
								<form:input path="pw" type="password" name="pw" id="pw" class="w3-input"   placeholder="영문과 숫자 1개 이상씩 포함 8~16자"/> 										
							</td>
							<td id="pwcheck" class="check"/>									
						</tr>
						<tr>
							<th>변경할 비밀번호 *<input type="checkbox" id="checkbox2" class="chkbox"></th>
							<td>
								<form:input path="pw1" type="password" name="pw1" id="pw1"   class="w3-input" /> 
							</td>
							<td id="pw1check" class="check"/>																		
						</tr>					
						<tr>
							<th>변경할 비밀번호 재확인 *<input type="checkbox" id="checkbox3" class="chkbox"></th>
							<td>
								<form:input path="pw2" type="password" name="pw2" id="pw2"   class="w3-input" /> 
							</td>
							<td id="pw2check" class="check"/>																		
						</tr>						
					</table>
					<input type="hidden" name="userId" class="userId" id="userId" value="${param.userId}">
				</div>
				<br>						
				<div class="w3-center">
					<a href="userinfo?userId=${user.userId}">
						<button type="button" class="w3-button w3-white w3-border w3-border-orange w3-round-large">취소</button>
					</a>
					&nbsp;	&nbsp;	&nbsp;	&nbsp;
					<button type="submit" class="w3-button w3-white w3-border w3-border-orange w3-round-large w3-center button" id="button" disabled="disabled" >수정</button>
				</div>
			</form:form>
		</div>
	</div>	
</body>
</html>