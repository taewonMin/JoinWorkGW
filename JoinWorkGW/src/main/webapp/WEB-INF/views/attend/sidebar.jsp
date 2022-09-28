<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!-- 사이드바 -->
<div id="left-sidebar" class="sidebar" style="border-right:2px solid rgb(0,0,0,0.1)">

	<div>
		<div class="body" style="font-family: S-CoreDream-4Regular">
				<div class="content">
					<div class="text">&nbsp;&nbsp;&nbsp; 
						<h4 class="text-center"><i class="fa  icon-hourglass"></i>&nbsp근무 시간</h4>
						<div class="body">
                            <div class="content" style="text-align: center;">
                               <div><h3 class=" align-center" style="font-size:2.5em;  color:#3672ff; font-family: S-CoreDream-6Bold" id="worked"></h3></div>
                               <small style="color: red;" id="endWorked"></small>
                            </div>
                        </div>
					</div>
				</div>
				<hr>
				<div class="tab-content">
					<div class="row clearfix">
						<div class="col-6">
						<button type="button" class="btn btn-success" onclick="insertStartWork();" id="workStartButton" style="width: 100px;" ><i class="fa fa-check-circle"></i> <span>출근하기</span></button>
						</div>
						<div class="col-6" style="padding-left: 5px;">
							<button type="button" class="btn btn-danger" onclick="insertEndWork();" id="workEndButton" style="width: 100px;"><i class="fa fa-home"></i> <span>퇴근하기</span></button>
						</div>
					</div>
				</div>
		</div>
	</div>

            <div class="tab-content p-l-0 p-r-0" style="font-family: InfinitySans-RegularA1">
                <div class="tab-pane animated fadeIn active" id="project_menu">
                    <nav class="sidebar-nav">
                        <ul class="main-menu metismenu collapse in">
                            <li class=""><a href="<%=request.getContextPath()%>/attend/mylist" style="font-size: 18px;"><i class="icon-user" style="font-size: 18px;"></i>내 근태 조회</a></li>
                            <li class=""><a href="<%=request.getContextPath()%>/attend/deplist" style="font-size: 18px;"><i class="icon-users" style="font-size: 18px;" ></i>부서 근태 조회</a></li>
                        </ul>                        
                    </nav>                    
               
                </div>             
            </div>  

	</div>


