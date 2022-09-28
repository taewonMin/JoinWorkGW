    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/templates/light/assets/fonts/font.css">
    	
	
<!-- 사이드바 -->
<div id="left-sidebar" class="sidebar" style="border-right:2px solid rgb(0,0,0,0.1)">
   <div class="sidebar-scroll">
      <!-- 여기 사이드바 넣는곳 -->
      
      <div class="tab-pane animated fadeIn active" id="sub_menu">
             <br>
             <br>
             <nav class="sidebar-nav">
                 <ul class="main-menu metismenu">
                     <li class="reservationHome">
                         <a href="<c:url value="/reservation/main"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="fa fa-university" ></i> <span>회의실 예약</span></a>
                     </li>
                 </ul>
                 <ul class="main-menu metismenu">
                     <li class="reservationList">
                         <a href="<c:url value="/reservation/reservationList"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="icon-book-open" ></i> <span>예약 관리</span></a>
                     </li>
                 </ul>
             </nav>
             <nav class="sidebar-nav">
                 <ul class="main-menu metismenu">
                     <li class="reservationAdmin">
                         <a href="<c:url value="/reservation/adminMain"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="icon-key" ></i> <span>회의실 관리</span></a>
                     </li>
                     <li>
<%--                          <a href="<c:url value="/reservation/adminMylis"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="fa fa-check-square-o" ></i> <span>관리자 페이지</span></a> --%>
                     </li>
                 </ul>
             </nav>
         </div>
   </div>
</div>

<script>

</script>										