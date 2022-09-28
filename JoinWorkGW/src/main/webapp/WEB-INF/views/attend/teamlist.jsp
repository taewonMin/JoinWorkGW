<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<style>
<!--
#wrap{
    width:100%;
    height:100%;
    background:#000;
}
  
#wrap .box{ 
    width:300px;
    height:300px;
    margin:0 auto;
}
-->
</style>

<body>


<!-- Page Loader -->
<div class="page-loader-wrapper">
    <div class="loader">
        <div class="m-t-30"><img src="../assets/images/logo-icon.svg" width="48" height="48" alt="Lucid"></div>
        <p>Please wait...</p>        
    </div>
</div>

<!-- Overlay For Sidebars -->

<jsp:include page="sidebar.jsp" />



    <div id="main-content">
        <div class="container-fluid">
            <div class="block-header">
                <div class="row">
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <h2 style="font-family: S-CoreDream-6Bold"><a href="javascript:void(0);" class="btn btn-xs btn-link btn-toggle-fullwidth"><i class="fa fa-arrow-left"></i></a> 부서 근태 조회</h2>
                        <ul class="breadcrumb" style="font-family: S-CoreDream-4Regular">
                            <li class="breadcrumb-item"><a href="index.html"><i class="icon-home"></i></a></li>                            
                            <li class="breadcrumb-item">${deptName}</li>
                        </ul>
                    </div>            
                </div>
            </div>

            <div class="row clearfix ">
                   <div class="col-12" style="font-family: S-CoreDream-6Bold">
                       <div class="card mb-4">
							<div class="col-lg-6 col-md-4 col-sm-12 text-end " align="right">
                                     <button class="mb-0 mt-1 btn btn-default" onclick="setNowDate();">현재 날짜로</button>
                             <div class="d-md-inline-block d-none mx-2 text-start">
                                 <div class="float-start me-2">
                                    
                                     <button class="mb-0 mt-1 btn btn-default" onclick="beforMonth();"><i class="fa fa-angle-left fa-2x"></i> </button>
                                 </div>
                                 <span id="bh_visitors" class="float-end"></span>
                             </div>
                             <div class="d-xl-inline-block d-none mx-2 text-start">
                                 <div class="float-start me-2" style="text-align: center;">
                                     <br>
                                     <br>
                                     <h4 class="mb-0 mt-1 "id="year"></h4>
                                     <h4 class="mb-0 mt-1 "id="month"></h4>
                                 </div>
                                 <span id="bh_visits" class="float-end"></span>
                             </div>
							<div class="d-lg-inline-block d-none mx-2 text-start">
								<div class="float-start me-2">
									<button type="button" class="mb-0 mt-1 btn btn-default" onclick="nextMonth();"><i class="fa fa-angle-right fa-2x"></i></button>
								</div>
								<span id="bh_chats" class="float-end"></span>
							</div>
						</div>
	                    <div class="card">
	                    <div class="card-body" id="tablAttendence">
                        </div>
	                    </div>
					</div>
                </div>
            </div>
        </div>
    </div>
    

<!-- Javascript -->

</body>
<script>
var today = new Date();
var year = today.getFullYear();
var month = today.getMonth()+1;
var day = today.getDate();

function tellMonth() {
var inputMonth = document.getElementById("month");
inputMonth.innerHTML = month;

var format = year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+day.toString()).slice(-2));
}
tellMonth();

</script>
<script>

function setNowDate() {
	 tellMonth();
	 getAttendence();
}
/*근무 시간을 밀리세컨즈로 가져온다*/
var workStartTime =  Date();
function showStaus(){
		  $.ajax({
	          url : "<%=request.getContextPath()%>/attend/getStartTime",
	          type : "get",
	          data : {loginUser : "000802JW0002"},
	          success : function (data) {
	        	  var millis = parseInt(data.milllis)
	        	  var endMillis = data.endMilllis;
	        	  if ('N'!== endMillis) {
	        		  parseInt(endMillis);
	        	  }
	        	  sessionStorage.setItem("endMillis", endMillis);
	        	  sessionStorage.setItem("millis", millis);
	          },
	          error : function (data) {
	          }
	      });
		
}

/*받은 밀리세컨즈를 조건에 맞게 계산해서 시간으로 출력*/
setInterval(getTime, 1000);
function getTime(){
   var mill = sessionStorage.getItem("millis");
   var endMillis = sessionStorage.getItem("endMillis");
	if (endMillis ==='N' && mill > 0) {
		var time = ((Date.now() - mill)/1000);
		var hour = dateFormat(Math.floor(time/3600));
		var minute = dateFormat(Math.floor(time%3600/60));
		var second = dateFormat(Math.floor(time%3600%60));
		$('#worked').text(hour+":"+minute+":"+second);
	}else if(endMillis !=='N'){
		var time = ((endMillis - mill)/1000);
		var hour = dateFormat(Math.floor(time/3600));
		var minute = dateFormat(Math.floor(time%3600/60));
		var second = dateFormat(Math.floor(time%3600%60));
		$('#worked').text(hour+":"+minute+":"+second);
		$('#endWorked').text("근무중이 아닙니다");
	}else {
		$('#worked').text("00"+":"+"00"+":"+"00");
	}
}
function dateFormat(time){
   return time < 10 ? "0"+time : time;
}

window.onload=function(){
	getTime();
}
</script>


<script>
var today = new Date();
var year = today.getFullYear();
var month = today.getMonth()+1;
var day = today.getDate();
/*해당 월을 화면에 출력*/
function tellMonth() {
	var inputMonth = document.getElementById("month");
	var inputYear = document.getElementById("year");
	inputMonth.innerHTML = month;
	inputYear.innerHTML = year;
	var format = year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+day.toString()).slice(-2));
}
tellMonth();

/*다음 달을 화면에 출력*/
function nextMonth() {
	var statusMonth =document.getElementById( 'month' ).innerHTML;
	var statusYear =document.getElementById( 'year' ).innerHTML;
	statusMonth = parseInt(statusMonth)+1;	
	if (statusMonth == 13) {
		statusMonth = 1;
		statusYear = parseInt(statusYear)+1
	}
	
	var inputMonth = document.getElementById("month");
	inputMonth.innerHTML = statusMonth;
	var inputYear = document.getElementById("year");
	inputYear.innerHTML = statusYear;
	getAttendence();//해당 월 내용 가져오기
	
}

/*이전 달을 화면에 출력*/
function beforMonth() {
	var statusMonth =document.getElementById( 'month' ).innerHTML;
	var statusYear =document.getElementById( 'year' ).innerHTML;
	statusMonth = statusMonth-1;	
	if (statusMonth == 0) {
		statusMonth = 12;
		statusYear = parseInt(statusYear)-1
	}
	
	var inputMonth = document.getElementById("month");
	inputMonth.innerHTML = statusMonth;
	var inputYear = document.getElementById("year");
	inputYear.innerHTML = statusYear;
	getAttendence();//해당 월 내용 가져오기
}
</script>






<script> //해당 월의 출근 날들을 모두 가져오기
function getAttendence() {
	//월
	var month =document.getElementById( 'month' ).innerHTML;
	//년
	// var statusMonth =document.getElementById( 'year' ).innerHTML;
	
	
	$.ajax({
	    url : "<%=request.getContextPath()%>/attend/deptlist/data",
	    type : "POST",
	    data : {month : month , year : year},
	    success : function (result) {
	    	var html = jQuery('<div>').html(result);
	    	var contents = html.find("div#indexListAjax").html();
	    	$("#tablAttendence").html(contents); 
	    },
	    error : function (data) {
	        alert("실패");
	    }
	});
		
}


window.onload = function() {
	getAttendence();//해당 월 내용 가져오기
		
}	

</script>

