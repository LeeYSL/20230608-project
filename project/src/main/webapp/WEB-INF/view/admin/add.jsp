<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 추가</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
function sendEmail() {
	let emailCheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	
	if (!emailCheck.test($("#email").val())) {
		$("#emailcheck").css("color", "red");
		$("#emailcheck").text("aaa@bbb.com 형식으로 입력해주세요.");	
	} else {
		let email = $("#email").val();  //입력한 이메일
		$.ajax({
			url: "emailChk",
			type: "get",
			data: {'email':email},
			success: function(cnt) {
	            if (cnt != 1) {
	        		$.ajax({
	        			url: "mailSender.do",
	        			type: "get",
	        			data: {'email':email},
	        			success: function(rnum) {
	        				//alert("s");
	        				alert("가입하신 이메일로 인증번호를 전송했습니다.");
	        				
	        				$("#codeInput").attr("disabled", false); //입력칸 활성화
	        				code = rnum;	        				
	        			},
	        			error: function () {
	        				alert("이메일 전송에 오류가 생겼습니다.");
	        			}
	        		});	
	            } else {
	    			$("#emailcheck").css("color", "red");
	    			$("#emailcheck").text("중복된 이메일이 있습니다.");	
	            }
	        },
			error: function () {
				alert("휴대전화번호 전송에 오류가 생겼습니다.");
			}
		});	
	}	
}

$(document).ready(function() {
	
	$("#pw").keyup(function() {	
		let pwCheck = /^(?=.*?[a-z])(?=.*?[0-9]).{8,16}$/;
		if($("#pw").val() == ""){			
			$("#pwcheck").text("");
			$("#checkbox2").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		} else if (!pwCheck.test($("#pw").val())) {
			$("#pwcheck").css("color", "red");
			$("#pwcheck").text("❌");
			$("#checkbox2").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		}  else {
			$("#pwcheck").css("color", "blue");
			$("#pwcheck").text("✔️");
			$("#checkbox2").prop("checked", true);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		}	
	});
	$("#pw1").keyup(function() {	
		let pw1Check = /^(?=.*?[a-z])(?=.*?[0-9]).{8,16}$/;
		if($("#pw1").val() == ""){			
			$("#pw1check").text("");
			$("#checkbox3").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		} else if (!pw1Check.test($("#pw1").val())||$("#pw").val()!=$("#pw1").val()) {
			$("#pw1check").css("color", "red");
			$("#pw1check").text("❌");
			$("#checkbox3").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		} else {
			$("#pw1check").css("color", "blue");
			$("#pw1check").text("✔️");
			$("#checkbox3").prop("checked", true);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		}	
	});
	$("#name").keyup(function() {	
		let nameCheck = /^[가-힣]{2,10}$/;
		if($("#name").val() == ""){			
			$("#namecheck").text("");
			$("#checkbox5").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		} else if (!nameCheck.test($("#name").val())) {
			$("#namecheck").css("color", "red");
			$("#namecheck").text("❌");	
			$("#checkbox5").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		} else {
			$("#namecheck").css("color", "blue");
			$("#namecheck").text("✔️");
			$("#checkbox5").prop("checked", true);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		}	
	});

	$('#userId').keyup(function () {
	    let userIdCheck = /^[a-z]+[a-z0-9]{4,11}$/;
	    
		if (!userIdCheck.test($("#userId").val())) {
			$("#userIdcheck").css("color", "red");
			$("#userIdcheck").text("영어로 시작,숫자 5~12자");
			$("#checkbox1").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		} else {
			let userId = $("#userId").val();  
			
			$.ajax({
				url: "userIdChk",
				type: "get",
				data: {'userId':userId},
				success: function(cnt) {
		            if (cnt != 1) {
		    			$("#userIdcheck").css("color", "blue");
		    			$("#userIdcheck").text("✔️");
		    			$("#checkbox1").prop("checked", true);
		    			let chk = $(".chkbox:checked").length;
		    			if (chk > 6) {
		    				console.log("체크");
		    				$("#button").prop("disabled", false);
		    			} else {
		    				console.log("언체크");
		    				$("#button").prop("disabled", true);
		    			}
		            } else {
		    			$("#userIdcheck").css("color", "red");
		    			$("#userIdcheck").text("❌");
		    			$("#checkbox1").prop("checked", false);
		    			let chk = $(".chkbox:checked").length;
		    			if (chk > 6) {
		    				console.log("체크");
		    				$("#button").prop("disabled", false);
		    			} else {
		    				console.log("언체크");
		    				$("#button").prop("disabled", true);
		    			}

		            }
		        },
				error: function () {
					alert("아이디 전송에 오류가 생겼습니다.");
				}
			});		
		}
	});	
	$('#nickname').keyup(function () {
	    let nicknameCheck = /^([a-zA-Z0-9|가-힣]){2,12}$/;
	    
		if (!nicknameCheck.test($("#nickname").val())) {
			$("#nicknamecheck").css("color", "red");
			$("#nicknamecheck").text("한글,영어,숫자 2~12자");
			$("#checkbox4").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		} else {
			let nickname = $("#nickname").val();  
			
			$.ajax({
				url: "nicknameChk",
				type: "get",
				data: {'nickname':nickname},
				success: function(cnt) {
		            if (cnt != 1) {
		    			$("#nicknamecheck").css("color", "blue");
		    			$("#nicknamecheck").text("✔️");
		    			$("#checkbox4").prop("checked", true);
		    			let chk = $(".chkbox:checked").length;
		    			if (chk > 6) {
		    				console.log("체크");
		    				$("#button").prop("disabled", false);
		    			} else {
		    				console.log("언체크");
		    				$("#button").prop("disabled", true);
		    			}
		            } else {
		    			$("#nicknamecheck").css("color", "red");
		    			$("#nicknamecheck").text("❌");
		    			$("#checkbox4").prop("checked", false);
		    			let chk = $(".chkbox:checked").length;
		    			if (chk > 6) {
		    				console.log("체크");
		    				$("#button").prop("disabled", false);
		    			} else {
		    				console.log("언체크");
		    				$("#button").prop("disabled", true);
		    			}
		            }
		        },
				error: function () {
					alert("닉네임 전송에 오류가 생겼습니다.");
				}
			});		
		}
	});
	$("#tel").keyup(function() {	
		let telCheck = /^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;
	    
		if (!telCheck.test($("#tel").val())) {
			$("#telcheck").css("color", "red");
			$("#telcheck").text("휴대전화번호를 '-'를 포함하여 적어주세요");
			$("#checkbox6").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		} else {
			let tel = $("#tel").val();  
			
			$.ajax({
				url: "telChk",
				type: "get",
				data: {'tel':tel},
				success: function(cnt) {
		            if (cnt != 1) {
		    			$("#telcheck").css("color", "blue");
		    			$("#telcheck").text("✔️");
		    			$("#checkbox6").prop("checked", true);
		    			let chk = $(".chkbox:checked").length;
		    			if (chk > 6) {
		    				console.log("체크");
		    				$("#button").prop("disabled", false);
		    			} else {
		    				console.log("언체크");
		    				$("#button").prop("disabled", true);
		    			}
		            } else {
		    			$("#telcheck").css("color", "red");
		    			$("#telcheck").text("❌");
		    			$("#checkbox6").prop("checked", false);
		    			let chk = $(".chkbox:checked").length;
		    			if (chk > 6) {
		    				console.log("체크");
		    				$("#button").prop("disabled", false);
		    			} else {
		    				console.log("언체크");
		    				$("#button").prop("disabled", true);
		    			}
		            }
		        },
				error: function () {
					alert("휴대전화번호 전송에 오류가 생겼습니다.");
				}
			});		
		}
	});
	$("#codeInput").keyup(function() {	
		console.log(code);
		if(code == $("#codeInput").val()) { //인증번호 같다면
			$("#emailcheck").css("color", "blue");
			$("#emailcheck").text("✔️");
			$("#checkbox7").prop("checked", true);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		}else {
			$("#emailcheck").css("color", "red");
			$("#emailcheck").text("❌");	
			$("#checkbox7").prop("checked", false);
			let chk = $(".chkbox:checked").length;
			if (chk > 6) {
				console.log("체크");
				$("#button").prop("disabled", false);
			} else {
				console.log("언체크");
				$("#button").prop("disabled", true);
			}
		}
	});
});


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

th {
	background-color: #ff8400;
	color: white;
	width:20%;
	text-align: center;
}
td {
	background-color :white;
}
#mail_check_input_box_false{
	background: #ebebe4; 
}
#mail_check_input_box_true{
	background: white; 
}
li {
	list-style: none;
	float: left;
	width: 25%;
	height: 50px;
	line-height: 50px;
	text-align: center;
	background: white;
	color: #ff8400;
	border: 0.1px solid #ff8400;
}

.now {
	list-style: none;
	float: left;
	width: 25%;
	height: 50px;
	line-height: 50px;
	text-align: center;
	background: #ff8400;
	color: white;
}
.w3-input {
	border: none ;
}
.chkbox {
	display: none;
}
</style>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1100px; height: 80%">
			<div class="w3-padding-32">
				<header class="l_member_header">
					<div>
						<h1 class="tit" >
						<span>관리자 추가</span>
						</h1>
					</div>				
				</header>	
				<br>
				<br>
				<br>
					<div>
						<p class="w3-right" style="color:red;"> * 는 필수 입력사항입니다.</p>
					</div>
						<form:form modelAttribute="user" enctype="multipart/form-data"  name="f" action="add">
							<table class="w3-table-all" >
								<tr>
									<th>아이디 *<input type="checkbox" id="checkbox1" class="chkbox" disabled="disabled"></th>
									<td width="50%">
										<form:input path="userId" name="userId" id="userId" class="w3-input"  placeholder="영문으로 시작, 숫자 포함 가능, 6~12자" />	
									</td>
									<td id="userIdcheck" class="check"/>
									
								</tr>
								<tr>
									<th>비밀번호 *<input type="checkbox" id="checkbox2" class="chkbox"></th>
									<td>
										<form:input path="pw" type="password" name="pw" id="pw" class="w3-input"   placeholder="영문과 숫자 1개 이상씩 포함 8~16자"/> 										
									</td>
									<td id="pwcheck" class="check"/>
									
								</tr>
								<tr>
									<th>비밀번호 재확인 *<input type="checkbox" id="checkbox3" class="chkbox"></th>
									<td>
										<form:input path="pw1" type="password" name="pw1" id="pw1"   class="w3-input" /> 
									</td>
									<td id="pw1check" class="check"/>
																		
								</tr>
								<tr>
									<th>닉네임 *<input type="checkbox" id="checkbox4" class="chkbox"></th>
								
									<td>
										<form:input path="nickname" name="nickname" id="nickname"    class="w3-input"  /> 
									</td>
									<td id="nicknamecheck" class="check"/>
																		
								</tr>
								<tr>
									<th>이름 *<input type="checkbox" id="checkbox5" class="chkbox"></th>
									<td>
										<form:input path="name" name="name" id="name"  class="w3-input"  placeholder="한글만 가능합니다." /> 
									</td>
									<td id="namecheck"  class="check" />
																	
								</tr>
								<tr>
									<th>휴대전화번호 *<input type="checkbox" id="checkbox6" class="chkbox"></th>
									<td>
										<form:input path="tel" name="tel" id="tel" class="w3-input"    placeholder="휴대전화번호 '-'를 포함하여 적어주세요"  /> 
									</td>
									<td id="telcheck" class="check"/>
								
								</tr>
								<tr>
									<th>이메일 *<input type="checkbox" id="checkbox7" class="chkbox"></th>
									<td class=" w3-center">
										<div class=" w3-center">
										<form:input path="email" name="email"  class="w3-input w3-left" id="email" placeholder="xxx@aaa.bbb"      style="width:40%; text-align: center;"/> 																				
										<input type="button" onclick="sendEmail()" value="인증번호전송" class="w3-button w3-white w3-border w3-border-orange w3-round-large"   style="width:25%;">											
										<input type="text" class="w3-input w3-right" id="codeInput" placeholder="인증번호입력" disabled="disabled"  style="width:25%; text-align: center;">											
										</div>
									</td>
									<td id="emailcheck" class="check" />									
								</tr>							
								<tr>
									<th>주소</th>
									<td colspan="2">
										<input type="text" name="address" class="w3-input" id="address" onclick="searchAddress();" >
						
									</td>
								</tr>
								<tr>
									<th>프로필사진</th>
									<td colspan="2">
										<input type="file" name="file1"class="w3-input" >
									</td>
								
								</tr>
							</table>
							<input type="hidden" name="batch" value="1">

							
													
						
							<div class="bottom_btn" class="w3-right" style="padding-top: 50px;">
								
									<button type="submit"
										class="w3-button w3-white w3-border w3-border-orange w3-round-large w3-center button" id="button" disabled="disabled" >가입</button>
								
							</div>
						</form:form>
				</div>	
		</div>
	</div>
</body>
</html>