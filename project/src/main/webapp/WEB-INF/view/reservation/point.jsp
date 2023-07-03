<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>별점</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {

		$('.starRev span').click(function() {
			$(this).parent().children('span').removeClass('on');
			$(this).addClass('on').prevAll('span').addClass('on');
			return false;
		});

		/* 	function changeStar(btn){
		 $(this).parent().children('span').removeClass('on');
		 $(this).addClass('on').prevAll('span').addClass('on');
		 return false;
		
		
		 onclick으로 해서 했을 때
		 } */
	});
	function point(btn) {
		
		let num =$(btn).attr('name');
		let point = $('.on').length;
		
		$.ajax({
		  url  : '/project/reservation/point',
		  type : 'POST',
		  data : {
			  'num' : num,
			  'point' : point //on으로 눌린 걸로 점수 몇 점인지 체크
		  },
		  success : function(result) {
			  $('td[name="${num}"]',opener.document).text(point+"점" );
		         self.close();
		  },
		  error : function(error) {
			    console.log(error);
		  },
		});
		
	}
</script>
<style type="text/css">
.starR {
	display: inline-block;
	width: 30px;
	height: 30px;
	color: transparent;
	text-shadow: 0 0 0 #f0f0f0;
	font-size: 1.8em;
	box-sizing: border-box;
	cursor: pointer;
}

/* 별 이모지에 마우스 오버 시 */
.starR:hover {
	text-shadow: 0 0 0 #ccc;
}

/* 별 이모지를 클릭 후 class="on"이 되었을 경우 */
.starR.on {
	text-shadow: 0 0 0 #ffbc00;
}
</style>
</head>
<body>
	<h2>별점 후기</h2>
	<div class="starRev">
		<span class="starR">⭐</span> 
		<span class="starR">⭐</span> 
		<span class="starR">⭐</span> 
		<span class="starR">⭐</span> 
		<span class="starR">⭐</span>
		&nbsp;&nbsp;&nbsp;
		<button type="button" name="${num}" onclick="point(this)">별점등록</button>
	</div>
</body>
</html>