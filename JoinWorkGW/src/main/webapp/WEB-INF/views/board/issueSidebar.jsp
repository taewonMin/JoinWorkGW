<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/templates/light/assets/fonts/font.css">
<style>
.sidebar-nav .metismenu ul a::before{
	content:'';
}

</style>


<!-- 사이드바 -->
<div id="left-sidebar" class="sidebar" style="border-right:2px solid rgb(0,0,0,0.1)">
   <div class="sidebar-scroll">
      <!-- 여기 사이드바 넣는곳 -->
      <div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 20px;text-align: center;">
            <button style="font-family:paybooc-Bold; background-color: #2980b9; color: white; border: 0px; width: 80%; height: 3rem; border-radius: 5%; margin: 4% 0;" onclick="OpenWindow('<%=request.getContextPath()%>/board/duty/registForm', '업무 작성', 1000, 700);">업무 작성</button>
      </div>
      
      <div class="tab-pane animated fadeIn active" id="sub_menu">
             <nav class="sidebar-nav">
                 <ul class="main-menu metismenu">
                     <li id="li_duty">
	                     <a href="#Blog" class="has-arrow" aria-expanded="false" style="font-family: S-CoreDream-4Regular; font-size: 23px;"><i class="fa fa-folder-open-o" style="font-size: 23px;"></i> <span>업무관리</span></a>
	                     <ul aria-expanded="false" class="collapse" style="font-size:1.3em;">
	                         <li><a id="a_list" href="<c:url value="/board/duty/list"/>" style="padding-left:40px;font-size:1.1em; font-family: InfinitySans-RegularA1"><i class="fa fa-th-list" style="font-size:1.1em;"></i>업무목록</a></li>
	                         <li><a id="a_receive" href="<c:url value="/board/duty/list?dutyType=receive"/>" style="padding-left:40px;font-size:1.1em; font-family: InfinitySans-RegularA1 "><i class="icon-envelope-letter" style="font-size:1.1em;"></i>받은 업무목록</a></li>
	                         <li><a id="a_send" href="<c:url value="/board/duty/list?dutyType=send"/>" style="padding-left:40px;font-size:1.1em; font-family: InfinitySans-RegularA1 "><i class="fa fa-send-o" style="font-size:1.1em;"></i>보낸 업무목록</a></li>
	                         <li><a id="a_reception" href="<c:url value="/board/duty/list?dutyType=reception"/>" style="padding-left:40px;font-size:1.1em; font-family: InfinitySans-RegularA1"><i class="fa fa-chain" style="font-size:1.1em;"></i>참조 업무목록</a></li>
	                     </ul>    
                     </li>
                     <li id="li_issue">
                         <a href="#Blog" class="has-arrow" aria-expanded="false" style="font-family: S-CoreDream-4Regular; font-size: 23px;"><i class="fa fa-files-o" style="font-size: 23px;"></i> <span>이슈관리</span></a>
                         <ul aria-expanded="false" class="collapse" style="font-size:1.3em;">
	                         <li><a id="a_issue" style="padding-left:40px;font-size:1.1em; font-family: InfinitySans-RegularA1" href="<c:url value="/board/issue/list"/>"><i class="fa fa-th-list" style="font-size:1.1em;"></i>이슈목록</a></li>
	                         <li><a id="a_milestone" style="padding-left:40px;font-size:1.1em; font-family: InfinitySans-RegularA1;" href="<c:url value="/board/milestone/list"/>"><i class="icon-direction" style="font-size:1.1em;"></i>마일스톤</a></li>
	                         <li><a id="a_project" style="padding-left:40px;font-size:1.1em; font-family: InfinitySans-RegularA1" href="<c:url value="/board/project"/>"><i class="fa fa-clipboard" style="font-size:1.1em;"></i>프로젝트</a></li>
	                     </ul>
                     </li>
                 </ul>
             </nav>
         </div>
   </div>
</div>