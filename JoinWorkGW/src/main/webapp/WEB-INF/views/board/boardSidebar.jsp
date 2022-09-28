<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/templates/light/assets/fonts/font.css">
    
<!-- 사이드바 -->
<div id="left-sidebar" class="sidebar" style="border-right:2px solid rgb(0,0,0,0.1)">
   <div class="sidebar-scroll">
      <!-- 여기 사이드바 넣는곳 -->
      <div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 20px;text-align: center;">
            <button style="font-family:paybooc-Bold; background-color: #2980b9; color: white; border: 0px; width: 80%; height: 3rem; border-radius: 5%; margin: 4% 0;" onclick="OpenWindow('<%=request.getContextPath()%>/board/registForm', '글 등록', 1000, 700);">글 작성</button>
         </div>
      
      <div class="tab-pane animated fadeIn active" id="sub_menu">
             <nav class="sidebar-nav">
                 <ul class="main-menu metismenu">
                     <li id="li_notice">
                         <a href="<c:url value="/board/notice/list"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="fa fa-bullhorn" ></i> <span>사내공지</span></a>
                     </li>
                     <li id="li_cac">
                         <a href="<c:url value="/board/cac/list"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="icon-envelope-letter" ></i> <span>경조사</span></a>
                     </li>
                     <li id="li_anony">
                         <a href="<c:url value="/board/anony/list"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="fa fa-comments-o" ></i> <span>익명 게시판</span></a>
                     </li>
                     <li id="li_qt">
                         <a href="<c:url value="/board/qt/list"/>" style="font-family: InfinitySans-RegularA1; font-size: 23px;"><i class="fa fa-check-square-o" ></i> <span>설문 게시판</span></a>
                     </li>
                 </ul>
             </nav>
         </div>
   </div>
</div>

<script>

</script>