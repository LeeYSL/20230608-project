<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

$(function() {
	$("#btn").click(function() {
		$.ajax({
	 		 url: 'https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=LdPS5IiOBYPeASfcwjEedxieH9Jey0kSkZtJsnuT7Id4vqmw%2BGe6%2FgTbBSYlOsma%2BRpXoKEJDLYtUg1ePWRbbA%3D%3D',
	  		 crossDomain: true,
	 		 method: 'post',
	 		 headers: {
	   				 'accept': 'application/json',
	  				 'Authorization': 'LdPS5IiOBYPeASfcwjEedxieH9Jey0kSkZtJsnuT7Id4vqmw+Ge6/gTbBSYlOsma+RpXoKEJDLYtUg1ePWRbbA=='
		 	 },
	 	 		contentType: 'application/json',
	 		 // data: '{\n  "b_no": [\n    "0000000000"\n  ]\n}',
	 			data: JSON.stringify({
	   								'b_no': [
	      									$("#b").val()
	    							]
	 			 }),
	 		success:function(response)  {
	 			for(let i=0; i<response.data.length;i++) {
	 	//			$('#result').append(response.data[i].b_stt_cd);
	 	//			$('#result').append(response.data[i].tax_type);
	 				if((response.data[i].b_stt_cd) == 01) {
	 					$('#result').append("가입이 가능")	 					
	 				} else {
	 					$('#result').append("가입 불가능")
	 				}
	 			
	 			}
	 		},
	 		error:function() {
	 			alert("error error error에러")
	 		}
			})
	})
})
</script>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div
			style="display: block; margin: auto; width: 1100px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<h5>사업자 회원가입</h5>
					<table class="w3-table-all">
						<tr>
							<td><input type="text" id="b" class="w3-input"></td>
						</tr>
					</table>
					<button id="btn">조회</button>
				</div>
				<br>
				<div id="result"></div>
			</div>
		</div>
	</div>

</body>
</html>