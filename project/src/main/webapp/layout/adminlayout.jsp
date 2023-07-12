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
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
</style>
<sitemesh:write property="head" />
</head>
<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large" style="z-index:4">
  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i> &nbsp;Menu</button>
  <a href="/project/restaurant/restaurantList">
  	<span class="w3-bar-item w3-right" style="color:white;">MAIN</span>
  </a>
</div>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s4">
			<c:if test="${user.fileurl != null&& ! user.fileurl.trim().equals('')}">
				<img src="file/${user.fileurl}" class="w3-circle w3-margin-right" style="width:66px">
			</c:if>
			<c:if test="${user.fileurl == null || user.fileurl.trim().equals('')}">
				<img src="${path}\image\orangeprofile.jpg" class="w3-circle w3-margin-right" style="width:66px">
			</c:if>

    </div>
    <div class="w3-col s8 w3-bar">
    <a href="userinfo?userId=${user.userId}"  class="w3-bar-item w3-button">
      <span>관리자, <strong>${sessionScope.loginUser.nickname }</strong></span>

      <i class="fa fa-cog"></i></a>
    </div>
  </div>
  <hr>
  <div class="w3-container">
  </div>
  <div class="w3-bar-block">
    <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>&nbsp; Close Menu</a>
    <a href="/project/admin/list" class="w3-bar-item w3-button w3-padding "><i class="fa fa-users fa-fw"></i>&nbsp; 회원리스트</a>
    <a href="/project/admin/restaurantlist" class="w3-bar-item w3-button w3-padding "><i class="fa fa-users fa-fw"></i>&nbsp; 가게리스트</a>
    <a href="/project/admin/adminlist"class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i>&nbsp; 관리자리스트</a>
    <a href="/project/admin/add" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i>&nbsp; 관리자추가</a>

  </div>
</nav>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
  <header class="w3-container" style="padding-top:22px">
    
  </header>


 
  <sitemesh:write property="body" />
  
  <!-- Footer -->
  <footer class="w3-container w3-padding-16 w3-light-grey">
    	<p><b>문의</b> 이영선&lt;dudtjs960630@naver.com&gt;&nbsp;정주리&lt;jjeongjuri@naver.com&gt;</p>
      <p>구디아카데미</p>
  </footer>

  <!-- End page content -->
</div>

<script>
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");

// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
    overlayBg.style.display = "none";
  } else {
    mySidebar.style.display = 'block';
    overlayBg.style.display = "block";
  }
}

// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = "none";
  overlayBg.style.display = "none";
}
</script>

</body>
</html>