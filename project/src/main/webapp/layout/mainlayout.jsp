<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html> 
<html>
<head>
<title><sitemesh:write property="title" /></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<script type="text/javascript" src= 
"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Arial", sans-serif}
.w3-bar-block .w3-bar-item {padding:20px}
a {text-decoration: none;}
</style>
<sitemesh:write property="head" />
</head>
<body>

<!-- Sidebar (hidden by default) -->
<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:20%;min-width:300px" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()"
  class="w3-bar-item w3-button">＊Close Menu</a>
  <a href="/project/restaurant/restaurantList" onclick="w3_close()" class="w3-bar-item w3-button">＊Restaurant</a>
  <a href="/project/reservation/myList?userId=${sessionScope.loginUser.userId}" onclick="w3_close()" class="w3-bar-item w3-button">＊예약 관리</a>
  <c:if test="${sessionScope.loginUser != null}">
  	<a href="/project/user/mypage?userId=${sessionScope.loginUser.userId}" onclick="w3_close()" class="w3-bar-item w3-button">＊MyPage</a>
  </c:if>
  <c:if test="${sessionScope.loginUser == null}">
  	<a href="/project/user/login" onclick="w3_close()" class="w3-bar-item w3-button">＊MyPage</a>
  </c:if>
  
  <a href="/project/board/list?boardId=1" onclick="w3_close()" class="w3-bar-item w3-button">＊공지사항</a>
  <a href="/project/board/list?boardId=2" onclick="w3_close()" class="w3-bar-item w3-button">＊QNA</a>
  	<c:if test="${sessionScope.loginUser.batch ==2 }">
  	- - - - - - - - - -	- - - - - - - - - -	- 
  	<!-- 	<a href="/project/reservation/ownerList?userId=${sessionScope.loginUser.userId}" onclick="w3_close()" class="w3-bar-item w3-button">식당 예약 관리</a>  -->
  	</c:if> 
  		<c:if test="${sessionScope.loginUser.batch ==2 }">
  		<a href="/project/restaurant/ownerRest?userId=${sessionScope.loginUser.userId}" onclick="w3_close()" class="w3-bar-item w3-button">＊식당 및 예약 관리</a>
  	</c:if>
</nav>

<!-- Top menu -->
<div class="w3-top">
  <div class="w3-white w3-xlarge" style="max-width:1200px;margin:auto">
    <div class="w3-button w3-padding-16 w3-left" onclick="w3_open()">&#9776;</div>
    <div class="w3-center w3-padding-16"><img width="150" height="50" src="${path}\image\abc.png0.png" onclick="location.href='/project'">
    		<c:if test="${empty sessionScope.loginUser}">    			
    			<a href="/project/user/login"  class="w3-right">Login</a>
			</c:if>
			<c:if test="${!empty sessionScope.loginUser}">
				<a href="/project/user/logout"  class="w3-right">Logout</a>
				 
				<a href="/project/user/mypage?userId=${sessionScope.loginUser.userId}" class="w3-right">${sessionScope.loginUser.nickname}님</a>
			</c:if>	
		</div>
  	</div>
</div>
  
   <div class="w3-panel">
  <sitemesh:write property="body" />
  </div> 
  <hr>
  
  
  <!-- Footer -->
  <footer class="w3-row-padding w3-padding-32">
    <div class="w3-center">
      <p><b>문의</b> 이영선&lt;dudtjs960630@naver.com&gt;&nbsp;정주리&lt;jjeongjuri@naver.com&gt;</p>
      <p>구디아카데미</p>
    </div>
  </footer>
 
<!-- End page content -->
</div>

<script>
// Script to open and close sidebar
function w3_open() {
  document.getElementById("mySidebar").style.display = "block";
}
 
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
}
</script>

</body>
</html>