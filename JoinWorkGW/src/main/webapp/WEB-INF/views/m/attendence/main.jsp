<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<title>JoinWork Attendence</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet" type="text/css">
<style>
body {font-family: "Raleway", Arial, sans-serif}
.w3-row img {margin-bottom: -8px}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<body>

<!-- !PAGE CONTENT! -->
<div class="w3-content" style="max-width:1500px">

  <!-- Header -->
  <header class="w3-container w3-xlarge w3-padding-24">
    <a href="#" class="w3-left w3-button w3-white">Attendence</a>
    <a href="<c:url value='m/approval/main'/>" class="w3-right w3-button w3-white">Approval</a>
    <a class="w3-right w3-button w3-white" href="javascript:sessionStorage.clear();window.location.href='${pageContext.request.contextPath }/common/logout';">logOut</a>
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
  <h2>Attendence Care</h2>
  <!--  큐알 생성 -->
   <p><a href="#" onclick="javascript:qr_code_create()" class="w3-button w3-xxlarge w3-black">QR코드 생성</a></p>
   
   <p><a href="#menu" class="w3-button w3-xxlarge w3-black">내 근무 확인</a></p>
   
  <img src="/w3images/boy.jpg" class="w3-image w3-padding-32" width="300" height="300">
  
  <br>
</footer>

</body>
<script>
	function qr_code_create(){
	    $.ajax({
	           type : "GET",
	           url : "<c:url value='makeQr'/>",
	           data:{"loginUser": "dfdf"},
	           success : function(){                      
	                alert("생성 완성! 화면을 캡쳐해주세요");
	                location.href="<%=request.getContextPath()%>/m/attendence/QrImg";
	           },
	           error:function(xhr,status,error){ 
	               alert("$");
	               alert("error\nxhr : " + xhr + ", status : " + status + ", error : " + error);
	           }
	       });
	}
</script>
</html>
