<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="UTF-8">
<title>밥티켓</title>
<script type="text/javascript">
	$(function() {
		disp_div('${param.info}');
/* 		$("#binfo").show()
		$("#cinfo").hide()
		$("#rinfo").hide()

		$("#tab1").addClass("select")
		if('${param.info}'=='cinfo'){
			disp_div('cinfo','tab2')	
		}
		if('${param.info}'=='rinfo'){
			disp_div('rinfo','tab3')
		} */
		
	})
	function disp_div(id) {
		let tab = 'tab1';
		if(id == 'cinfo') {
			tab = 'tab2';
		} else if (id == 'rinfo'){
			tab = 'tab3';
		}
		
		$(".info").each(function() {
			$(this).hide()
		})
		$(".tab").each(function() {
			$(this).removeClass("select")
		})
		$("#" + id).show()
		$("#" + tab).addClass("select")
	}
	
	//페이지 이동
	function mypage(f, page){
		$('form[name="'+f+'"]').find('input[name="pageNum"]').val(page);
		$('form[name="'+f+'"]').find('input[name="info"]').val(f);
		$('form[name="'+f+'"]').submit();
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
	text-align: center;
}

td {
	background-color: white;
}

a {
	text-decoration: none;
}
</style>
</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width: 1300px; height: 100%;">
			<div class="w3-padding-32">
				<div class="side">
					<!-- Page Container -->
					<div class="w3-container w3-content" style="max-width: 1200px; margin-top: 80px; " >
						<!-- The Grid -->
						<div class="w3-row">
							<!-- Left Column -->
							<div class="w3-col m3">
								<!-- Profile -->
								<div class="w3-card w3-round w3-white">
									<div class="w3-container">
										<c:forEach items="${myulist}" var="user">
											<h4 class="w3-center">My Profile</h4>
											<p class="w3-center">
												<c:if test="${user.fileurl != null&& ! user.fileurl.trim().equals('')}">
													<img src="file/${user.fileurl}" class="w3-circle" style="height: 106px; width: 106px" alt="Avatar">
												</c:if>
												<c:if test="${user.fileurl == null || user.fileurl.trim().equals('')}">
													<img src="${path}\image\orangeprofile.jpg" class="w3-circle" style="height: 106px; width: 106px" alt="Avatar">
												</c:if>
											</p>
											<hr>
											<p>
												<a href="userinfo?userId=${user.userId}"> 
													<span class="txt">${user.nickname}</span><i class="fa fa-cog fa-fw"></i>
												</a>
											</p>
											<p>
												${user.email}
											</p>
											<p>
												<span class="txt">${user.tel}</span>
											</p>
										</c:forEach>
									</div>
								</div>
								<br>
								<!-- Accordion -->
								<div class="w3-card w3-round">
									<div class="w3-white">
										<a href="javascript:mypage('binfo',1)">
											<button  id="tab1" class="w3-button w3-block w3-theme-l1  w3-center" class="tab">
												게시글
											</button>
										</a> 
										<a href="javascript:mypage('cinfo',1)">
											<button id="tab2" class="w3-button w3-block w3-theme-l1  w3-center" class="tab">
												댓글
											</button>
										</a> 
										<a href="javascript:mypage('rinfo',1)">
											<button id="tab3" class="w3-button w3-block w3-theme-l1  w3-center" class="tab">
												예약
											</button>
										</a>
									</div>
								</div>
								<br>
								<!-- End Left Column -->
							</div>

							<!-- Middle Column -->
							<div class="w3-col m9">
								<%--board --%>
								<div class="info w3-container w3-card w3-white w3-round w3-margin-left " id="binfo" style="display: none;">
									<br>									
									<form name="binfo">	
										<div class="page">
											<h4>게시글 목록</h4>
											<input type="hidden" name="pageNum" value="1"> 
											<input type="hidden" name="userId" value="${param.userId}">
											<input type="hidden" name="info" value="binfo">
										</div>
									</form>							
									<br>
									<hr class="w3-clear">
									<table class="w3-table-all" >
										<c:if test="${myblistcount > 0}">
											<tr>
												<th align="center" width="70%">제목</th>
												<th align="center" width="20%">작성일</th>
											</tr>
											<c:forEach items="${myblist}" var="board">
												<tr>
													<td align="center" width="70%">
														<a href="../board/detail?num=${board.num}">${board.title}</a>
													</td>
													<td align="center" width="20%">
														<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd" />
													</td>
												</tr>
											</c:forEach>
											<tr>
												<td colspan="3" class="w3-center">
													<c:if test="${pageNum > 1}">
														<a href="javascript:mypage('binfo', '${pageNum -1}')">[이전]</a>
													</c:if>
													<c:if test="${pageNum <= 1}">[이전]</c:if> 
													<c:forEach var="a" begin="${startpage}" end="${endpage}">
														<c:if test="${a == pageNum}">[${a}]</c:if>
														<c:if test="${a != pageNum}">
															<a href="javascript:mypage('binfo', '${a}')">[${a}]</a>
														</c:if>
													</c:forEach> 
													<c:if test="${pageNum < maxpage}">
														<a href="javascript:mypage('binfo', '${pageNum +1}')">[다음]</a>
													</c:if> 
													<c:if test="${pageNum >= maxpage}">[다음]</c:if>
												</td>
											</tr>
										</c:if>
										<c:if test="${myblistcount ==  0}">
											<tr>
												<th colspan="3" style="text-align: center;">등록된 게시물이 없습니다.</th>
											</tr>
										</c:if>
									</table>									
									<br>
									
								</div>

								<%--comment --%>
								<div class="info w3-container w3-card w3-white w3-round w3-margin-left " id="cinfo" style="display: none;">
									<br>
									<form name="cinfo">	
										<div class="page">					
											<h4>댓글 목록</h4>
											<input type="hidden" name="pageNum" value="1"> 
											<input type="hidden" name="userId" value="${param.userId}">											
											<input type="hidden" name="info" value="cinfo">
										</div>
									</form>								
									<br>
									<hr class="w3-clear">
									<table class="w3-table-all">
										<c:if test="${myclistcount > 0}">									
											<tr>
												<th align="center" width="80%">댓글</th>
												<th align="center" width="20%">작성일</th>
											</tr>
											<c:forEach items="${myclist}" var="comm">
												<tr>
													<td align="center" width="80%">
														<a href="../board/detail?num=${comm.num}&seq=${comm.seq}">${comm.content}</a>
													</td>
													<td align="center" width="20%">
														<fmt:formatDate value="${comm.date}" pattern="yyyy-MM-dd" />
													</td>
												</tr>
											</c:forEach>
											<tr>
												<td colspan="3" class="w3-center">
													<c:if test="${pageNum > 1}">
														<a href="javascript:mypage('cinfo', '${pageNum -1}')">[이전]</a>
													</c:if> 
													<c:if test="${pageNum <= 1}">[이전]</c:if> 
													<c:forEach var="a" begin="${startpage}" end="${cendpage}">
														<c:if test="${a == pageNum}">[${a}]</c:if>
														<c:if test="${a != pageNum}">
															<a href="javascript:mypage('cinfo', '${a}')">[${a}]</a>
														</c:if>
													</c:forEach> 
													<c:if test="${pageNum < cmaxpage}">
														<a href="javascript:mypage('cinfo', '${pageNum +1}')">[다음]</a>
													</c:if>
													<c:if test="${pageNum >= cmaxpage}">[다음]</c:if>
												</td>
											</tr>
										</c:if>
										<c:if test="${myclistcount ==  0}">
											<tr>
												<th colspan="3" style="text-align: center;">등록된 댓글이 없습니다.</th>
											</tr>
										</c:if>
									</table>		
									<br>
								</div>

								<%--reservation --%>
								<div class="info w3-container w3-card w3-white w3-round w3-margin-left" id="rinfo" style="display: none;">
									<br>
									<form name="rinfo">	
										<div class="page">					
											<h4>예약 목록</h4>
											<input type="hidden" name="pageNum" value="1"> 
											<input type="hidden" name="userId" value="${param.userId}">
											<input type="hidden" name="info" value="rinfo">
										</div>
									</form>										
									<br>
									<hr class="w3-clear">
									<table class="w3-table-all">
										<c:if test="${myrlistcount > 0}">									
											<tr>
												<th align="center" width="60%">식당이름</th>
												<th align="center" width="20%">예약일</th>
												<th align="center" width="20%">예약인원</th>											
											</tr>
											<c:forEach items="${Myrsrvt}" var="rsrvt">
												<tr>
													<td align="center" width="60%">
														${rsrvt.name}
													</td>
													<td align="center" width="20%">
														${rsrvt.rsrvtDate} 
													</td>
													<td align="center" width="20%">
														${rsrvt.people}명
													</td>												
												</tr>
											</c:forEach>
											<tr>
												<td colspan="3" class="w3-center">
													<c:if test="${pageNum > 1}">
														<a href="javascript:mypage('rinfo', '${pageNum -1}')">[이전]</a>
													</c:if> 
													<c:if test="${pageNum <= 1}">[이전]</c:if> 
													<c:forEach var="a" begin="${startpage}" end="${rendpage}">
														<c:if test="${a == pageNum}">[${a}]</c:if>
														<c:if test="${a != pageNum}">
															<a href="javascript:mypage('rinfo', '${a}')">[${a}]</a>
														</c:if>
													</c:forEach> 
													<c:if test="${pageNum < rmaxpage}">
														<a href="javascript:mypage('rinfo', '${pageNum =1}')">[다음]</a>
													</c:if> 
													<c:if test="${pageNum >= rmaxpage}">[다음]</c:if>
												</td>
											</tr>
										</c:if>
										<c:if test="${myrlistcount ==  0}">
											<tr>
												<th colspan="3" style="text-align: center;">등록된 예약이 없습니다.</th>
											</tr>
										</c:if>
									</table>								
									<br>
								</div>

								<!-- End Middle Column -->
							</div>

							<!-- End Grid -->
						</div>

						<!-- End Page Container -->
					</div>
					<br>
				</div>
			</div>
		</div>
	</div>
</body>
</html>