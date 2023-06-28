<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%-- /project/src/main/webapp/WEB-INF/view/user/userinfo.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		$("#binfo").show()
		$("#cinfo").hide()
		$("#rinfo").hide()
		$("#vinfo").hide()
		$(".commentLine").each(function(){
			$(this).hide()
		})
		$(".reservationLine").each(function(){
			$(this).hide()
		})
		$(".reviewLine").each(function(){
			$(this).hide()
		})
		$("#tab1").addClass("select")
	})
	function disp_div(id,tab) {
		$(".info").each(function(){
			$(this).hide()
		})
		$(".tab").each(function(){
			$(this).removeClass("select")
		})
		$("#"+id).show()
		$("#"+tab).addClass("select")
	}

</script>

</head>
<body>
	<div class="w3-container w3-padding-32 w3-center">
		<div style="display: block; margin: auto; width:1300px; height: 533px;">
			<div class="w3-padding-32">
				<div class="side">



<!-- Page Container -->
<div class="w3-container w3-content" style="max-width:1200px;margin-top:80px">    
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
         	<c:if test="${user.fileurl != null}">
         		<img src="file/${user.fileurl}" class="w3-circle" style="height:106px;width:106px" alt="Avatar">
         	</c:if>
         	<c:if test="${user.fileurl == null}">
         		<img src="/WEB-INF/view/orangeprofile.jpg" class="w3-circle" style="height:106px;width:106px" alt="Avatar">
         	</c:if>	
         </p>
         <hr>
         <p><i class="fa fa-pencil fa-fw w3-margin-right w3-text-theme"></i> ${user.userId}</p>
         <p><i class="fa fa-home fa-fw w3-margin-right w3-text-theme"></i> 
         	<a href="userinfo?userId=${user.userId}">
								<span class="txt">${user.nickname}</span>
							</a></p>
         <p>
         	<i class="fa fa-birthday-cake fa-fw w3-margin-right w3-text-theme"></i>
         	<span class="txt">${user.tel}</span>
         	
         </p>
         </c:forEach>
        </div>
      </div>
      <br>    
      
      <!-- Accordion -->
      <div class="w3-card w3-round">
        <div class="w3-white">
        
        <a href="javascript:disp_div('binfo','tab1')">
          <button onclick="myFunction('Demo1')" id="tab1" class="w3-button w3-block w3-theme-l1 w3-left-align">
          	<i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i> 게시글</button>
        </a>	
                   	
        <a href="javascript:disp_div('cinfo','tab2')">  
          <button onclick="myFunction('Demo2')" class="w3-button w3-block w3-theme-l1 w3-left-align">
          	<i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i> 댓글</button>
        </a>  	
          	
      
          
         <a href="javascript:disp_div('rinfo','tab3')"> 
          <button onclick="myFunction('Demo3')" class="w3-button w3-block w3-theme-l1 w3-left-align">
          	<i class="fa fa-users fa-fw w3-margin-right"></i> 예약</button>
          </a>	
          
 		<a href="javascript:disp_div('vinfo','tab4')">	         
          <button onclick="myFunction('Demo3')" class="w3-button w3-block w3-theme-l1 w3-left-align">
          	<i class="fa fa-users fa-fw w3-margin-right"></i> 리뷰</button>
		</a>
		
		<c:if test="${sessionScope.loginUser.batch ==2}">
		---------------------------------------------
		<a href="javascript:disp_div('vinfo','tab5')">	         
          <button class="w3-button w3-block w3-theme-l1 w3-left-align">
          	<i class="fa fa-users fa-fw w3-margin-right"></i> 가게1</button>
		</a>
		
		<a href="javascript:disp_div('vinfo','tab6')">	         
          <button onclick="myFunction('Demo3')" class="w3-button w3-block w3-theme-l1 w3-left-align">
          	<i class="fa fa-users fa-fw w3-margin-right"></i> 가게2</button>
		</a>
		
		 <a href="javascript:disp_div('vinfo','tab7')">	         
          <button onclick="myFunction('Demo3')" class="w3-button w3-block w3-theme-l1 w3-left-align">
          	<i class="fa fa-users fa-fw w3-margin-right"></i> 가게3</button>
		</a>
		</c:if>

        </div>      
      </div>
      <br>
      
    
    <!-- End Left Column -->
    </div>
    
    <!-- Middle Column -->
    <div class="w3-col m9">
    
      
      
      <%--board --%>
      <div class="info w3-container w3-card w3-white w3-round w3-margin" id="binfo" style="display:none;"><br>
        <h4>내가 쓴 글</h4><br>
        <hr class="w3-clear">
		<table class="w3-table-all">		
			<tr>
				<th width="10%"></th>
				<th align="center" width="70%">제목</th>
				<th align="center" width="20%">작성일</th>
			</tr>
			<c:forEach items="${myblist}" var="board">
				<tr>
					<td width="10%">
						<input type="hidden" name="pageNum" value="1">
						<input type="checkbox">
					</td>
					<td align="center" width="70%">
						<a href="../board/detail?num=${board.num}">${board.title}</a>
					</td>
					<td align="center" width="20%">
						<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd" />
					</td>
				</tr>
			</c:forEach>
						<tr>
							<td colspan="6" class="w3-center">
								<c:if test="${pageNum > 1}">
									<a href="javascript:listpage('${pageNum -1}')">[이전]</a>
								</c:if>
								<c:if test="${pageNum <= 1}">[이전]</c:if>
								<c:forEach var="a" begin="${startpage}" end="${endpage}">
									<c:if test="${a == pageNum}">[${a}]</c:if>
									<c:if test="${a != pageNum}">
										<a href="javascript:listpage('${a}')">[${a}]</a>
									</c:if>
								</c:forEach>
								<c:if test="${pageNum < maxpage}">
									<a href="javascript:listpage('${pageNum +1}')">[다음]</a>
								</c:if>
								<c:if test="${pageNum >= maxpage}">[다음]</c:if>
							</td>
						</tr>			
		</table>
		<br>
      </div>
      
      <%--comment --%>
      <div class="info w3-container w3-card w3-white w3-round w3-margin" id="cinfo" style="display:none;"><br>
       <h4>내가 쓴 댓글</h4><br>
        <hr class="w3-clear">
		<table class="w3-table-all">
			<tr>
				<th align="center" width="80%">댓글</th>
				<th align="center" width="20%">작성일</th>
			</tr>
			<c:forEach items="${myclist}" var="comm" >
				<tr>
					<td align="center" width="80%">
						<a href="../board/detail?num=${comm.num}&seq=${comm.seq}">${comm.content}</a>
					</td>
					<td align="center" width="20%">
						<fmt:formatDate value="${comm.date}" pattern="yyyy-MM-dd" />
					</td>
				</tr>
			</c:forEach>
		</table>
		<br>
      </div>
      
            <%--comment --%>
      <div class="info w3-container w3-card w3-white w3-round w3-margin" id="rinfo" style="display:none;"><br>
       <h4>예약</h4><br>
        <hr class="w3-clear">
		<table class="w3-table-all">
			<tr>
				<th align="center">댓글</th>
				<th align="center">작성일</th>
			</tr>
			<c:forEach items="${myclist}" var="comm" >
				<tr>
					<td align="center">
						<a href="../board/detail?num=${comm.num}&seq=${comm.seq}">${comm.content}</a>
					</td>
					<td align="center">
						<fmt:formatDate value="${comm.date}" pattern="yyyy-MM-dd" />
					</td>
				</tr>
			</c:forEach>
		</table>
		<br>
      </div>
      
            <%--comment --%>
      <div class="info w3-container w3-card w3-white w3-round w3-margin" id="vinfo" style="display:none;"><br>
       <h4>리뷰</h4><br>
        <hr class="w3-clear">
		<table class="w3-table-all">
			<tr>
				<th align="center">댓글</th>
				<th align="center">작성일</th>
			</tr>
			<c:forEach items="${myclist}" var="comm" >
				<tr>
					<td align="center">
						<a href="../board/detail?num=${comm.num}&seq=${comm.seq}">${comm.content}</a>
					</td>
					<td align="center">
						<fmt:formatDate value="${comm.date}" pattern="yyyy-MM-dd" />
					</td>
				</tr>
			</c:forEach>
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