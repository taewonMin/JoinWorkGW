<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!-- 사이드바 -->
<div id="left-sidebar" class="sidebar" style="border-right:2px solid rgb(0,0,0,0.1)">
	<div class="sidebar-scroll">
		<!-- 여기 사이드바 넣는곳 -->
		
         <div class="tab-content p-l-0 p-r-0 text-align" style="font-size: 25px; ">
         	<button onclick="OpenWindow('<%=request.getContextPath()%>/doc/registForm', '글 등록', 1000, 700);" style="background-color: #2980b9; color: white; border: 0px; width: 14rem; height: 3.8rem; margin-left: 3.5%; border-radius: 5%; margin-top: 4%; font-family: InfinitySans-RegularA1">문서 작성</button>
         </div>
         
         <div class="tab-content p-l-0 p-r-0" style="font-family: InfinitySans-RegularA1">
                <div class="tab-pane animated fadeIn active" id="project_menu">
                    <nav class="sidebar-nav">
                        <ul class="main-menu metismenu" style="font-size: 20px;">
                            <li class="docHome"><a href="<%=request.getContextPath()%>/doc/main" style="font-size: 18px;"><i class="icon-home" style="font-size: 20px;"></i>문서 홈</a></li>
                            <li class="myDocList"><a href="<%=request.getContextPath()%>/doc/mylist" style="font-size: 18px;"><i class="icon-drawer" style="font-size: 20px;"></i>개인 문서 관리</a></li>
                            <li class="docTeamList"><a href="<%=request.getContextPath()%>/doc/teamlist" style="font-size: 18px;"><i class="icon-drawer" style="font-size: 20px;"></i>팀문서 관리 </a></li>
                            <li class="docDeptList"><a href="<%=request.getContextPath()%>/doc/deptlist" style="font-size: 18px;"><i class="icon-drawer" style="font-size: 20px;"></i>부서 문서 관리</a></li>
                            <li class="docApprovalList"><a href="<%=request.getContextPath()%>/doc/approvallist" style="font-size: 18px;"><i class="icon-docs" style="font-size: 20px;"></i>결재 문서 조회</a></li>
                        </ul>                        
                    </nav>                    
                </div>             
         </div>  
	</div>
</div>
