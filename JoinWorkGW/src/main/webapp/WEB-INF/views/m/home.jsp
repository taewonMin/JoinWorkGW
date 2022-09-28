<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<title>JoinWork home</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet" type="text/css">
<style>
body {font-family: "Raleway", Arial, sans-serif}
.w3-row img {margin-bottom: -8px}
</style>
<body>

<!-- !PAGE CONTENT! -->
<div class="w3-content" style="max-width:1500px">

  <!-- Header -->
  <header class="w3-container w3-xlarge w3-padding-24">
    <a href="<c:url value='attendence/main'/>" class="w3-left w3-button w3-white">Attendence</a>
    <a href="<c:url value='approval/main'/>" class="w3-right w3-button w3-white">Approval</a>
  </header>

  <!-- Photo Grid -->
  <div class="w3-row">
    <div class="w3-half">
    </div>
    
	
    <div class="w3-half">
    </div>
  </div>
  
<!-- End Page Content -->
</div>

<!-- Footer / About Section -->
<footer class="w3-light-grey w3-padding-64 w3-center" id="about">
  <h2>JoinWork Main</h2>
  <!--  큐알 생성 -->
   <p><a href="#" onclick="javascript:qr_code_create()" class="w3-button w3-xxlarge w3-black"> 결재 관리</a></p>
   
   <p><a href="#menu" class="w3-button w3-xxlarge w3-black">근태 관리</a></p>
   
  <img src="/w3images/boy.jpg" class="w3-image w3-padding-32" width="300" height="300">
  
  <br>
</footer>
 
</body>
<script>
	
</script>
</html>
