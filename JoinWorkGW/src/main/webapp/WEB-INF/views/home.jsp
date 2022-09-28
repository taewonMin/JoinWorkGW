<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>


<!-- 풀켈린더 -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/fullcalendar.min.css" />
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/moment.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/fullcalendar.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/ko.js"></script> 
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/select2.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/bootstrap-datetimepicker.min.js"></script>

<script src="<%=request.getContextPath() %>/resources/js/common.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/js/main.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/js/addEvent.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/js/etcSetting.js"></script>




<style>
#calendar {
    width: 300px;
    margin: 0 auto;
    font-size: 10px;
}
.fc-toolbar {
    font-size: 2px;
    width: 350px;
}
.fc-toolbar h2 {
    font-size: 12px;
    white-space: normal !important;
}
/* click +2 more for popup */
.fc-more-cell a {
    display: block;
/*     width: 95%;  */
    margin: 1px auto 0 auto;
    border-radius: 3px;
    background: grey;
    color: transparent;
    overflow: hidden;
    height: 4px;
}
.fc-more-popover {
/*     width: 100px; */
}
.fc-view-month .fc-event, .fc-view-agendaWeek .fc-event, .fc-content {
    font-size: 0;
/*     overflow: hidden; */
    height: 2px;
}
.fc-view-agendaWeek .fc-event-vert {
    font-size: 0;
    overflow: hidden;
    width: 2px !important;
}
.fc-agenda-axis {
    width: 20px !important;
    font-size: 5px;
}



/* .fc-button-content { */
/*     padding: 0; */
/* } */
.fc-content-skeleton table{
   width: 100%;   
}
.fc-month-view{
   overflow-y: scroll;
}
.fc-view-container{
   width: 397px;
}
.fc-view{
   overflow: hidden;
   margin-left: 41px;
}

.fc-left{
   margin-left: 41px;
}



.CurrIcon, .CurrTemp{
    display: inline-block;
    font-size: 2rem;
    text-align: center;
}
.CurrIcon{
    margin-right: 2px;
}
.City{
    font-size: 1.2rem;
    text-align: center;
}
.fc-day{
   text-align: center;
}
#displayAndHiddenOrg{
	border: 1px solid #2980b9;
	background-color: #2980b9;
	color: #ffffff;
	width: 15%;
	text-align: center;
	font-weight: bold;
	display: flex;
	justify-content: space-between;
	left: 24px;
}
#hiddenMenu {
	width: 17.8em;
}
.commonModal-content {
    right: 78.6%;
}
.fancy-checkbox input[type="checkbox"]+span:before{
	width:20px;
	height:20px;
}
.issueTitle:hover{
	color:#5c8ed4;
}
.fa-sort-down:before, .fa-sort-desc:before, .dd4 .dd-item > button[data-action="collapse"]:before, .dd4 .dd-item > button:before{
	content:"";
}
</style>
<body>


<div id="main-content" style="width: 100%;">
   <div class="container-fluid" >
      <!-- 메인 content 넣는 곳 -->
      
        <form:form commandName="homeFormVO" id="homeForm" name="homeForm">
        <div class="row clearfix">
         <!-- 왼쪽줄 시작 -->
            <div class="col-2">
               <div class="card" id="profileCard" style="font-family: InfinitySans-RegularA1">
               		<ul class="nav nav-tabs" style="font-family: InfinitySans-RegularA1">
		                <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#profile_menu" onclick="changeSettingMode(this);">프로필</a></li>
		                <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#setting_menu" onclick="changeSettingMode(this);">대시보드 설정</a></li>
		            </ul>
		            <div class="tab-content p-l-0 p-r-0">
			            <div class="tab-pane animated fadeIn active" id="profile_menu" style="height:47vh;">
	                        <div class="body text-center">
								<c:choose>
									<c:when test="${!empty loginUser.empPicture}">
										<div class="profile-image m-b-15" id="userPictureDiv" style="background-image: url('getPicture?picture=${loginUser.empPicture }'); height: 250px; width: 75%; border-radius: 50%"></div>
									</c:when>
									<c:otherwise>
										<div class="profile-image m-b-15" id="userPictureDiv" style='background-image: url("<%=request.getContextPath() %>/resources/image/NO_IMAGE.png"); height: 12em; width:70%;'></div>
									</c:otherwise>
								</c:choose>
	                            
	                            <div style="margin-top:25px;">
	                                <h4 class="m-b-0" style="margin: 10px;">
	                                   <strong>${loginUser.empName }&nbsp;${loginUser.officialName }</strong>
	                                </h4>
	                                <c:choose>
		                                <c:when test="${!empty loginUser.teamName }">
			                                <span style="font-size:1.5em;">${loginUser.teamName }</span>
		                                </c:when>
		                                <c:otherwise>
			                                <span style="font-size:1.5em;">${loginUser.deptName }</span>
		                                </c:otherwise>
	                                </c:choose>
	                            </div>
	                            <div class="m-t-15" style="font-size:1.1em;">
	                               <div>
	                               		결재할 문서 : ${homeFormVO.waitDocCnt } &nbsp;
	                               		<a href="<%=request.getContextPath() %>/approval/lists/waitList">
	                               			<i class="icon-share-alt"></i>
	                               		</a>
	                               </div>
	                               
	                               <div id="scheduleFormDiv">
	                               		오늘의 일정 : ${homeFormVO.scheduleList1.size()} &nbsp;
	                               		<a href="<%=request.getContextPath() %>/schedule/main?from=home">
		                               		<i class="icon-share-alt"></i>
	                               		</a>
	                               </div>
	                            </div>                            
	                        </div>
	                    </div>
	                    
	                    <div class="tab-pane animated fadeIn" id="setting_menu" style="height:47vh;padding:0 15px;">
	                    	<h5 style="display:inline-block;">개인 대시보드 설정</h5>
	                    	<a data-toggle="popover" data-trigger="hover" data-placement="left" data-html="true" data-content="내 대시보드에 표시할 항목을 3개까지 선택할 수 있습니다.<br/>선택한 항목이 3개 이하일 경우 기본값으로 설정됩니다." style="cursor:pointer;font-family: InfinitySans-RegularA1" data-original-title="" title="">
								<i class="fa fa-question-circle" style="font-size: 1.5em;margin-left:5px;"></i>
							</a>
							
							<!-- 대시보드 설정화면 -->
							<div style="margin-top:10px;">
								<h6>업무관리</h6>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl" name="dashboardDuty" <c:if test="${!empty homeFormVO.dashboardVO.dashboardDuty}">checked</c:if>>
		                            <span>업무제안 목록</span>
		                        </label>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl defaultDashboard" name="dashboardIssue" <c:if test="${!empty homeFormVO.dashboardVO.dashboardIssue}">checked</c:if>>
		                            <span>업무이슈 목록</span>
		                        </label>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl" name="dashboardProject" <c:if test="${!empty homeFormVO.dashboardVO.dashboardProject}">checked</c:if>>
		                            <span>프로젝트 관리</span>
		                        </label>
							</div>
							<div style="margin-top:10px;">
								<h6>전자결재</h6>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl" name="dashboardApproval" <c:if test="${!empty homeFormVO.dashboardVO.dashboardApproval}">checked</c:if>>
		                            <span>결재대기문서 | 기안문서</span>
		                        </label>
							</div>
							<div style="margin-top:10px;">
								<h6>시설예약</h6>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl defaultDashboard" name="dashboardReservation" <c:if test="${!empty homeFormVO.dashboardVO.dashboardReservation}">checked</c:if>>
		                            <span>회의실 예약 현황</span>
		                        </label>
							</div>
							<div style="margin-top:10px;">
								<h6>게시판</h6>
								<label class="fancy-checkbox">
		                            <input type="checkbox" class="dashboardEl defaultDashboard" name="dashboardBoard" <c:if test="${!empty homeFormVO.dashboardVO.dashboardBoard}">checked</c:if>>
		                            <span>사내공지 | 경조사</span>
		                        </label>
							</div>
							<button type="button" class="btn btn-primary" style="width:100%;margin-top:15px;" onclick="saveDashboard(this);">저장</button>
	                    </div>
                    </div>
               </div>
               
               <div class="card" style="font-family: S-CoreDream-4Regular">
                  <div class="head text-center" style="margin-top: 20px;">
                     <h2>근태관리</h2>
                     <span><fmt:formatDate value="${homeFormVO.attendenceVO.sysDate}" pattern="yyyy-MM-dd"/></span>
                     <h4 style="margin-top: 10px;"><i class="fa  fa-clock-o fa-1x"></i> 근무 시간</h4>
                     <div class="body" style="margin: 0;padding: 0;">
                         <div class="content" style="text-align: center;">
                            <div><h3 class=" align-center" style="font-size:2.3em;  color:#3672ff; font-family: S-CoreDream-6Bold" id="worked"></h3></div>
                            <small style="color: red;" id="endWorked"></small>
                         </div>
                     </div>
                     
                  </div>
                        <div class="body">
                            <div class="text-center">
                                <h4 class="m-b-0">
                                   <strong>${homeFormVO.attendenceVO.attendStName}</strong>
                                </h4>
                            </div>
                            <div class="m-t-25">
                               <div class="row clearfix">
                           <div class="col-lg-6" id="startWork">
                               <button onclick="insertStartWork(this);" type="button" class="btn btn-primary" style="width: 100%;"><i class="fa fa-check-circle"></i>출근하기</button>
                           </div>
                           <div class="col-lg-6" id="endWork">
                               <button onclick="insertEndWork(this);" type="button" class="btn btn-secondary" style="width: 100%;"><i class="fa fa-home"></i>퇴근하기</button>
                           </div>
                        </div>
                            </div>                            
                       <div class="m-t-15"  style="font-family: GoyangDeogyang;">
                        <div class="row clearfix" style="margin-bottom: 5px; ">
                           <div class="col-lg-6">
                              <span>출근시간</span>
                           </div>
                           <div class="col-lg-6">
                              <c:if test="${not empty homeFormVO.attendenceVO.historyAttendTime}">
                                 <span><fmt:formatDate value="${homeFormVO.attendenceVO.historyAttendTime}" pattern="HH:mm:ss"/></span>
                              </c:if>
                              <c:if test="${empty homeFormVO.attendenceVO.historyAttendTime}">
                                 <span>미등록</span>
                              </c:if>
                           </div>
                        </div>
                        <div class="row clearfix" style="margin-bottom: 5px;">
                           <div class="col-lg-6">
                              <span>퇴근시간</span>
                           </div>
                           <div class="col-lg-6">
                              <c:if test="${not empty homeFormVO.attendenceVO.historyLeavingTime}">
                                 <span><fmt:formatDate value="${homeFormVO.attendenceVO.historyLeavingTime}" pattern="HH:mm:ss"/></span>
                              </c:if>
                              <c:if test="${empty homeFormVO.attendenceVO.historyLeavingTime}">
                                 <span>미등록</span>
                              </c:if>
                           </div>
                        </div>
                        <div class="row clearfix" style="margin-bottom: 30px;">
                           <div class="col-lg-6">
                              <span>필요근무시간</span>
                           </div>
                           <div class="col-lg-6 attendTime" >
                              <c:if test="${not empty attendenceVO.weeklyAttendMilliSec}">
                                 <c:if test="${attendenceVO.excessYN eq 'N'}">
                                 <span id="weeklyDefferTime" value="${attendenceVO.weeklyAttendMilliSec}">${attendenceVO.weeklyResult}</span><span> </span>
                                 </c:if>
                                 <c:if test="${attendenceVO.excessYN eq 'Y'}">
                                 <span id="weeklyDefferTime" value="${attendenceVO.weeklyAttendMilliSec}">0시간 0분</span>&nbsp;<span></span>
                                 <br><span class="badge badge-info" style="margin: 0;">초과근무 중</span><br><span class="excessTime"></span>
                                 </c:if>
                              </c:if>
                           </div>
                        </div>
                            </div>                            
                        </div>
               </div>
               
               <div class="card text-center" style="font-family: GoyangIlsan">
                  <h2 style="margin-top: 20px;">오늘날씨</h2>
                  <div class="head text-center" style="margin-top: 20px; margin-bottom: 20px;">
                     <div class = 'weather'>
                         <div class="CurrIcon"></div> 
                         <div class="CurrTemp"></div>
                         <div class="City" style="font-size: 27px;"></div>
                     </div>
                  </div>
               </div>
            </div>
            
         <!-- 왼쪽줄 끝 -->   
            
         <!-- 가운데줄 시작 -->
            <div class="col-7" style="padding:0px;">
            <div class="dd dd4">
	            <ol class="dd-list">
					<li class="dd-item" id="dashboardBoard" data-order="${homeFormVO.dashboardVO.dashboardBoard }" <c:if test="${empty homeFormVO.dashboardVO.dashboardBoard}">style="display:none;"</c:if>>
		               <div class="card">
		                  <div class="header" style="padding-bottom:0px;font-family: GoyangIlsan ">
		                          <h3 style="display:inline-block;">
		                              게시판
		                          </h3>
		                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
		                        </div>
		                           <div class="body">
		                               <div class="row clearfix">
		                           <div class="col-6" style="font-family: S-CoreDream-4Regular">
		                              <div class="head">
		                                 <h5>
		                                    사내공지
		                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/board/notice/list'">
		                                            <i class="fa fa-sign-in"></i>
		                                         </span>
		                                 </h5>
		                              </div>
		                               <div class="table-responsive" style="overflow:hidden;">
		                                         <table class="table table-hover m-b-0 c_list">
		                                             <thead>
		                                                 <tr>
		                                                     <th>게시날짜</th>
		                                                     <th>제목</th>
		                                                     <th>작성자</th>
		                                                     <th>조회수</th>
		                                                 </tr>
		                                             </thead>
		                                             <tbody style="cursor: pointer;">
		                                                <c:if test="${not empty homeFormVO.nomalNoticeList}">
		                                                   <c:forEach items="${homeFormVO.nomalNoticeList}" var="notice" varStatus="status">
		                                                      <c:if test="${status.count < 6}">
		                                                         <tr onclick="OpenWindow('<%=request.getContextPath()%>/board/notice/detail?noticeId=${notice.noticeId }', '글 상세보기', 800, 700);">
		                                                              <td><fmt:formatDate value="${notice.noticeCreateDt}" pattern="yyyy-MM-dd"/></td>
		                                                              <c:choose>
		                                                                 <c:when test="${notice.noticeImportantYN eq 'Y'}">
		                                                                    <td><span style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><span class="badge badge-danger">필독</span>${notice.noticeTitle}</span></td>
		                                                                 </c:when>
		                                                      <c:otherwise>
		                                                         <td><span style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${notice.noticeTitle}</span></td>
		                                                      </c:otherwise>
		                                                              </c:choose>
		                                                              <td><span>${notice.empName}&nbsp;${notice.officialName}</span></td>
		                                                              <td><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${notice.noticeReadcnt}</span></td>
		                                                          </tr>
		                                                       </c:if>
		                                                   </c:forEach>
		                                                </c:if>
		                                                
		                                                 <c:if test="${empty homeFormVO.nomalNoticeList}">
		                                                   <tr>
		                                                        <td colspan="6" style="text-align: center;"><strong>해당 공지가 존재하지 않습니다.</strong></td>
		                                                    </tr>
		                                                </c:if>
		                                             </tbody>
		                                         </table>
		                                     </div>
		                           </div>
		                           <div class="col-6"  style="font-family: S-CoreDream-4Regular">
		                              <div class="head">
		                                 <h5>
		                                    경조사
		                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/board/cac/list'">
		                                            <i class="fa fa-sign-in"></i>
		                                         </span>
		                                 </h5>
		                              </div>
		                               <div class="table-responsive" style="overflow: hidden;">
		                                         <table class="table table-hover m-b-0 c_list">
		                                             <thead>
		                                                 <tr>
		                                                     <th>분류</th>
		                                                     <th>제목</th>
		                                                     <th>시작 날짜</th>
		                                                     <th>종료 날짜</th>
		                                                     <th>작성자</th>
		                                                 </tr>
		                                             </thead>
		                                             <tbody style="cursor: pointer;">
		                                                <c:if test="${not empty homeFormVO.cacList}">
		                                                   <c:forEach items="${homeFormVO.cacList}" var="cac" varStatus="status">
		                                                      <c:if test="${status.count < 6}">
		                                                         <tr onclick="OpenWindow('<%=request.getContextPath()%>/board/cac/detail?cacBoardId=${cac.cacBoardId }', '글 상세보기', 950, 850);">
		                                                              <c:choose>
		                                                                 <c:when test="${cac.cacCategory eq '부고'}">
		                                                                    <td><span class="badge badge-dark">부고</span></td>
		                                                                 </c:when>
		                                                                 <c:when test="${cac.cacCategory eq '결혼'}">
		                                                                    <td><span class="badge badge-warning">결혼</span></td>
		                                                                 </c:when>
		                                                      <c:otherwise>
		                                                                    <td><span class="badge badge-secondary">기타</span></td>
		                                                      </c:otherwise>
		                                                              </c:choose>
		                                                              <td><span style="display: inline-block;font-weight: bold;max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${cac.cacBoardTitle}</span></td>
		                                                              <td>${cac.cacStartDt}</td>
		                                                              <td>${cac.cacEndDt}</td>
		                                                              <td><span>${cac.empName}&nbsp;${cac.officialName}</span></td>
		                                                          </tr>
		                                                       </c:if>
		                                                   </c:forEach>
		                                                </c:if>
		                                             
		                                                 <c:if test="${empty homeFormVO.cacList}">
		                                                   <tr>
		                                                        <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
		                                                    </tr>
		                                                </c:if>
		                                             </tbody>
		                                         </table>
		                                     </div>
			                           </div>
			                         </div>
			                               
		                           </div>
		                       </div>
					</li>
					<li class="dd-item" id="dashboardDuty" data-order="${homeFormVO.dashboardVO.dashboardDuty }" <c:if test="${empty homeFormVO.dashboardVO.dashboardDuty}">style="display:none;"</c:if>>
                       <div class="card">
                       <div class="header"  style="padding-bottom:0px;font-family: GoyangIlsan">
                          <h3 style="display: inline-block;">
                             업무제안 목록
                          </h3>
                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
                          <span style="cursor: pointer;font-size: 1.8em;vertical-align: middle;margin-left: 5px;" onclick="location.href='<%=request.getContextPath()%>/board/duty/list'">
                             <i class="fa fa-sign-in"></i>
                          </span>
                        </div>
                           <div class="body" style="padding-top:10px;font-family: S-CoreDream-4Regular">
                               <div class="table-responsive">
                                      <table class="table table-hover m-b-0 c_list">
                                       <thead>
                                           <tr>
                                               <th>업무번호</th>
                                               <th>업무제목</th>
                                               <th>완료 기한</th>
                                               <th>진행 상태</th>
                                               <th>팀장</th>
                                               <th>담당자</th>
                                           </tr>
                                       </thead>
                                       <tbody style="cursor: pointer;">
                                          <c:if test="${not empty homeFormVO.dutyList}">
                                              <c:forEach items="${homeFormVO.dutyList }" var="duty" varStatus="status">
                                                 <c:if test="${status.count < 6}">
                                                   <tr role="row" onclick="OpenWindow('<%=request.getContextPath()%>/board/duty/detail?dutyBoardId=${duty.dutyBoardId }', 'JoinWorkGW', 1000, 700);">
                                                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${duty.dutyBoardId }</td>
                                                        <td class="project-title sorting_1">
                                                            <h6 style="display:inline-block;font-weight: bold;max-width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;margin-bottom:3px;">${duty.dutyBoardTitle }</h6>
                                                            <c:if test="${duty.replyCount != 0 }">
                                                               <i class="icon-bubble text-info" style="margin-left:5px; font-weight: bold"><span class="m-l-5" style="font-weight: bold;"><fmt:formatNumber value="${duty.replyCount }" type="number"/></span></i>
                                                            </c:if>
                                                            <br>
                                                            <span>
	                                                            <fmt:formatDate value="${duty.dutyBoardCreateDt }" pattern="yyyy.MM.dd"/>
                                                            </span>
                                                        </td>
                                                        <td>
                                                        <c:if test="${!empty duty.dutyBoardEndDt }">
                                                         ~ <fmt:formatDate value="${duty.dutyBoardEndDt }" pattern="yyyy.MM.dd"/>
                                                        </c:if>
                                                         <fmt:parseNumber value="${myToday.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
														 <fmt:parseNumber value="${duty.dutyBoardEndDt.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
				                                    
	                                                  	<c:if test="${(endDate-strDate) < 3 && (endDate-strDate) >= 0 && duty.dutyBoardEndDt.getTime() >= today}">
	                                                  		<span class="badge badge-danger">마감임박</span>
	                                                  	</c:if>
                                                         
                                                        </td>
                                                        <td>
                                                           <c:choose>
                                                              <c:when test="${empty duty.dutyBoardEndDt || duty.dutyBoardEndDt.getTime() >= today }">
                                                                 <span class="badge badge-success">진행중</span>
                                                              </c:when>
                                                              <c:otherwise>
                                                                 <span class="badge badge-danger">종료</span>
                                                              </c:otherwise>
                                                           </c:choose>
                                                        </td>
                                                        <td>
                                                           <div class="dutyEmpImg" value="${duty.empId}" data-toggle="tooltip" data-placement="top" title="" data-original-title="${duty.empName }" style="width: 40px;height: 40px; border-radius: 50%; display: inline-block; margin: 0;padding: 0;"></div>
                                                        </td>
                                                        <td>
                                                            <c:forEach items="${duty.dutyManagerList }" var="dutyManager" varStatus="myStatus">
                                                            	<c:if test="${myStatus.count <= 3 }">
                                                           			<div class="dutyManagerEmpImg" value="${dutyManager.empId}" data-toggle="tooltip" data-placement="top" title="" data-original-title="${dutyManager.empName }" style="width: 40px;height: 40px; border-radius: 50%; display: inline-block; margin: 0;padding: 0;"></div>
                                                            	</c:if>
                                                            	<c:if test="${myStatus.count == 4 }">
                                                            		<div style="width: 40px; border-radius: 50%; display: inline-block; margin: 0;padding: 0;">외 ${duty.dutyManagerList.size() - 3}명</div>
                                                            	</c:if>
                                                            </c:forEach>                                                
                                                        </td>
                                                    </tr>
                                                 </c:if>
                                              </c:forEach>
                                          </c:if>
                                       
                                       
                                          <c:if test="${empty homeFormVO.dutyList}">
                                             <tr>
                                                  <td colspan="6" style="text-align: center;"><strong>해당 업무게시물이 존재하지 않습니다.</strong></td>
                                              </tr>
                                          </c:if>
                                       </tbody>
                                   </table>
                               </div>
                           </div>
                       </div>
					</li>
					<li class="dd-item" id="dashboardReservation" data-order="${homeFormVO.dashboardVO.dashboardReservation }" <c:if test="${empty homeFormVO.dashboardVO.dashboardReservation}">style="display:none;"</c:if>>
                       <div class="card">
                       <div class="header" style="padding-bottom:0px;font-family: GoyangIlsan">
                          <h3 style="display:inline-block;">
                             회의실 예약 현황
                          </h3>
                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
                          <span style="cursor: pointer;font-size: 1.8em;vertical-align: middle;margin-left: 5px;" onclick="location.href='<%=request.getContextPath()%>/reservation/reservationList'">
                             <i class="fa fa-sign-in"></i>
                          </span>
                        </div>
                        <div class="body" style="padding-top:10px;font-family: S-CoreDream-4Regular">
                        	<h5 id="today" style="margin-left: 50px;margin-bottom: 20px;"></h5>
                        	<i class="fa fa-angle-left fa-4x" style="position:absolute;left:20px;top:170px;cursor: pointer;" onclick="prevTime();"></i>
                        	<i class="fa fa-angle-right fa-4x" style="position:absolute;right:20px;top:170px;cursor: pointer;" onclick="nextTime();"></i>
                        	<div style="width:width: calc(100% - 80px);overflow: hidden;margin:0 40px;">
	                            <ul id="meetroomReservationTime" style="padding:0px;width:2420px;">
	                            	<c:forEach begin="8" end="17" var="time">
		                                <li style="display:inline-block;width:220px;border: 1px solid rgb(0,0,0,0.2);border-radius:15px;padding: 10px;height: 20vh;">
		                                    <h5><fmt:formatNumber value="${time }" pattern="00" />:00 ~ <fmt:formatNumber value="${time+1 }" pattern="00" />:00</h5>
		                                    <div class="reservationList" style="height:15vh;overflow-y: auto;">
			                                    
		                                    </div>
		                                </li>
	                            	</c:forEach>
	                            </ul>						
                        	</div>
	                    </div>
							                        
                       </div>
					</li>
					<li class="dd-item" id="dashboardIssue" data-order="${homeFormVO.dashboardVO.dashboardIssue }" <c:if test="${empty homeFormVO.dashboardVO.dashboardIssue}">style="display:none;"</c:if>>
                       <div class="card">
	                       <div class="header" style="padding-bottom:0px;font-family: GoyangIlsan">
	                          <h3 style="display:inline-block;">
	                             업무이슈 목록
	                          </h3>
	                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
	                          <span style="cursor: pointer;font-size: 1.8em;vertical-align: middle;margin-left: 5px;" onclick="location.href='<%=request.getContextPath()%>/board/issue/list'">
	                             <i class="fa fa-sign-in"></i>
	                          </span>
	                        </div>
	                       <div class="row clearfix" style="margin:10px;">
		                       <div class="col-lg-6 col-md-6" style="padding:10px 20px;font-family: S-CoreDream-4Regular">
	                               <div class="table-responsive">
			                        	<ul class="nav nav-tabs" style="position:absolute;width:93%;z-index: 10;">
							                <li class="nav-item" style="cursor:pointer;"><a class="nav-link active" data-toggle="tab" href="#openIssueList"><i class="icon-info"></i> Open</a></li>
							                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" data-toggle="tab" href="#closedIssueList"><i class="fa fa-check"></i> Closed</a></li>
							            </ul>
							            <div class="tab-content p-l-0 p-r-0 p-t-0">
							            	<!-- Open 이슈 -->
							                <div class="tab-pane animated fadeIn active" id="openIssueList">
				                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
				                                	<thead>
				                                		<tr>
				                                			<th style="width:60%;"></th>
				                                			<th style="width:40%;">작성자</th>
				                                		</tr>
				                                	</thead>
				                                    <tbody style="border:hidden;">
				                                    	<c:if test="${!empty homeFormVO.openIssueList}">
					                                        <c:forEach items="${homeFormVO.openIssueList }" var="issue" varStatus="status">
					                                        	<c:if test="${status.index < 5 }">
								                                    <tr role="row" class="issueList" style="cursor: pointer;" data-id="${issue.issueBoardId }" onclick="showIssueHistory(this);">
							                                            <td class="project-title" style="padding:15px;">
							                                            	<div>
								                                                <h6 style="display:inline-block;font-weight: bold;max-width: 200px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
								                                                	<i class="icon-info" style="color:green;"></i>
								                                                	<span class="issueTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId }', '이슈 상세보기', 1200, 700);">${issue.issueBoardTitle }</span>
								                                                </h6>
								                                                <c:if test="${issue.replyCount ne 0}">
									                                            	<i class="icon-bubble" style="margin-left:5px;"></i> ${issue.replyCount }
								                                            	</c:if>
							                                            	</div>
							                                                <span style="margin-left:25px;">#${issue.issueBoardId }</span>
							                                                <span style="margin-left:5px;">${issue.issueBoardCreateDt.split(" ")[0] }</span>
							                                            </td>
							                                            <td class="project-actions">
							                                            	<c:choose>
							                                            		<c:when test="${empty issue.empPicture }">
									                                            	<img src="<%=request.getContextPath() %>/resources/image/NO_IMAGE.png" data-toggle="tooltip" data-placement="top" title="" alt="Avatar" class="width45 rounded" data-original-title="${issue.empName }">
							                                            		</c:when>
							                                            		<c:otherwise>
							                                            			<div id="pictureView" style="display:inline-block;vertical-align:middle;margin-right:10px;background-image:url('${pageContext.request.contextPath}/emp/getPicture?picture=${issue.empPicture}'); width: 45px; height: 45px;" class="rounded-circle avatar" data-toggle="tooltip" data-placement="top" data-original-title="${issue.empName }"></div>
							                                            			<div style="display:inline-block;vertical-align:middle;">
														                                <strong>${issue.empName } ${issue.officialName }</strong>
														                                <div>${issue.deptName } <span>${issue.teamName }</span></div>
														                            </div>
							                                            		</c:otherwise>
							                                            	</c:choose>
							                                            </td>
							                                        </tr>
					                                        	</c:if>
					                                        
					                                        </c:forEach>
				                                    	</c:if>
				                                    	<!-- 목록이 없을때 -->
				                                    	<c:if test="${empty homeFormVO.openIssueList }">
				                                    		<tr role="row">
					                                            <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="2">등록된 이슈가 없습니다.</td>
				                                            </tr>
				                                    	</c:if>
			                                        </tbody>
				                                </table>
							                </div>
							                
							                <!-- Closed 이슈 -->
							                <div class="tab-pane animated fadeIn" id="closedIssueList">
				                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
				                                	<thead>
				                                		<tr>
				                                			<th style="width:60%;"></th>
				                                			<th style="width:40%;">작성자</th>
				                                		</tr>
				                                	</thead>
				                                    <tbody style="border:hidden;">
				                                    	<c:if test="${!empty homeFormVO.closedIssueList}">
					                                        <c:forEach items="${homeFormVO.closedIssueList }" var="issue" varStatus="status">
					                                        	<c:if test="${status.index < 5 }">
								                                    <tr role="row" class="issueList" style="cursor: pointer;" data-id="${issue.issueBoardId }" onclick="showIssueHistory(this);">
							                                            <td class="project-title" style="padding:15px;">
							                                            	<div>
								                                                <h6 style="display:inline-block;font-weight: bold;max-width: 200px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
								                                                	<i class="icon-check" style="color:red;"></i>
								                                                	<span class="issueTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId }', '이슈 상세보기', 1200, 700);">${issue.issueBoardTitle }</span>
								                                                </h6>
								                                                <c:if test="${issue.replyCount ne 0}">
									                                            	<i class="icon-bubble" style="margin-left:5px;"></i> ${issue.replyCount }
								                                            	</c:if>
							                                            	</div>
							                                                <span style="margin-left:25px;">#${issue.issueBoardId }</span>
							                                                <span style="margin-left:5px;">${issue.issueBoardCreateDt.split(" ")[0] }</span>
							                                            </td>
							                                            <td class="project-actions">
							                                            	<c:choose>
							                                            		<c:when test="${empty issue.empPicture }">
									                                            	<img src="<%=request.getContextPath() %>/resources/image/NO_IMAGE.png" data-toggle="tooltip" data-placement="top" title="" alt="Avatar" class="width45 rounded" data-original-title="${issue.empName }">
							                                            		</c:when>
							                                            		<c:otherwise>
							                                            			<div id="pictureView" style="display:inline-block;vertical-align:middle;margin-right:10px;background-image:url('${pageContext.request.contextPath}/admin/emp/getPicture?picture=${issue.empPicture}'); width: 45px; height: 45px;" class="rounded-circle avatar" data-toggle="tooltip" data-placement="top" data-original-title="${issue.empName }"></div>
							                                            			<div style="display:inline-block;vertical-align:middle;">
														                                <strong>${issue.empName } ${issue.officialName }</strong>
														                                <div>${issue.deptName } <span>${issue.teamName }</span></div>
														                            </div>
							                                            		</c:otherwise>
							                                            	</c:choose>
							                                            </td>
							                                        </tr>
					                                        	</c:if>
					                                        
					                                        </c:forEach>
				                                    	</c:if>
				                                    	<!-- 목록이 없을때 -->
				                                    	<c:if test="${empty homeFormVO.closedIssueList }">
				                                    		<tr role="row">
					                                            <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="2">등록된 이슈가 없습니다.</td>
				                                            </tr>
				                                    	</c:if>
			                                        </tbody>
				                                </table>
							                </div>
							            </div>
			                        </div>
		                       </div>
		                       <div class="col-lg-6 col-md-6 issueHistory" style="padding:10px 20px;font-family: S-CoreDream-4Regular">
		                       		<div style="text-align:center;margin-top:150px;font-size:1.3em;">
			                       		<strong>히스토리를 조회할 이슈를 선택하세요.</strong>
		                       		</div>
		                       		<!-- 히스토리 뷰 -->
		                       </div>
	                       </div>
                       </div>
					</li>
					<li class="dd-item" id="dashboardProject" data-order="${homeFormVO.dashboardVO.dashboardProject }" <c:if test="${empty homeFormVO.dashboardVO.dashboardProject}">style="display:none;"</c:if>>
                       <div class="card">
                       <div class="header" style="padding-bottom:0px;font-family: GoyangIlsan">
                          <h3 style="display:inline-block;">
                             프로젝트 관리
                          </h3>
                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
                          <span style="cursor: pointer;font-size: 1.8em;vertical-align: middle;margin-left: 5px;" onclick="location.href='<%=request.getContextPath()%>/board/project'">
                             <i class="fa fa-sign-in"></i>
                          </span>
                        </div>
                        	<c:if test="${homeFormVO.todoList.size()+homeFormVO.inprogressList.size()+homeFormVO.doneList.size() eq 0 }">
                        		<c:set value="0" var="percentage"/>
                        	</c:if>
                        	<c:if test="${homeFormVO.todoList.size()+homeFormVO.inprogressList.size()+homeFormVO.doneList.size() ne 0 }">
	                        	<fmt:parseNumber value="${Math.floor(homeFormVO.doneList.size()/(homeFormVO.todoList.size()+homeFormVO.inprogressList.size()+homeFormVO.doneList.size())*100)}" integerOnly="true" var="percentage"/>
                        	</c:if>
                           <div class="body" style="padding:0 30px;font-family: S-CoreDream-4Regular">
		                   		<div class="progress-container m-t-10">
		                           <div class="progress progress-xs" style="height:15px;background-color:rgb(0,0,0,0.2);text-align: center;display: block;">
		                               <div class="progress-bar" role="progressbar" aria-valuenow="86" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%; height:15px;border-radius:2px;">
		                               </div>
		                               <span id="percentage" style="color: white;font-size: 1.1em;line-height: 1.2em;position: absolute;top:71px;">${percentage}%</span>
		                           </div>
		                       	</div>
                           </div>
                           
                           <div>
                           		<div class="row clearfix" style="margin:10px; padding-bottom:10px; font-family:S-CoreDream-4Regular ">
			                    	<div class="top_counter col-lg-4 col-md-6" style="border-right: 1px solid rgb(0,0,0,0.2);">
			                    		<div style="height:40vh;">
					                        <div class="body" style="padding:10px;">
				                                <h5 style="display:inline-block;">해야할 일</h5>
					                        	<span style="font-size:1.3em;margin-left:5px;">[${empty homeFormVO.todoList ? 0 : homeFormVO.todoList.size() }개]</span>
					                        </div>    
					                        <div style="height: 33vh;overflow-y: auto;padding: 0 10px;">
				                            	<c:if test="${!empty homeFormVO.todoList }">
				                                	<c:forEach items="${homeFormVO.todoList }" var="issue">
				                                        <div class="card" style="height:70vh;padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
			                                            	<div style="margin-bottom: -15px;">
				                                                <h6 style="display:inline-block;font-weight: bold;max-width:100%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
				                                                	<c:if test="${issue.issueBoardSt eq 'Y' }">
					                                                	<i class="icon-info" style="color:green;"></i>
				                                                	</c:if>
				                                                	<c:if test="${issue.issueBoardSt eq 'N' }">
					                                                	<i class="icon-check" style="color:red;"></i>
				                                                	</c:if>
				                                                	<span class="issueTitle" style="font-size:1.1em;cursor:pointer;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId}', '이슈 상세보기',1200,900);">${issue.issueBoardTitle }</span>
				                                                </h6>
			                                                	<c:if test="${!empty issue.dutyBoardTitle }">
					                                                <span class="btn btn-secondary" style="height:auto;padding: 0px 3px;font-size:0.8em;margin-left:5px;margin-top: -10px;">#${issue.dutyBoardId }</span>
			                                                	</c:if>
			                                            	</div>
			                                            	<div style="margin-top:8px;margin-left:5px;">
				                                                <span>#${issue.issueBoardId }</span>
				                                                <span style="margin-left:5px;">${issue.issueBoardUpdateDt.split(" ")[0] }</span>
			                                            	</div>
				                                        </div>
				                                	</c:forEach>
					                    		</c:if>
					                    		<c:if test="${empty homeFormVO.todoList }">
						                    		<div style="text-align: center;padding:20px;">
						                    			<strong style="font-size:1.2em;">이슈가 없습니다.</strong>
						                    		</div>
					                    		</c:if>
					                        </div>
			                    		</div>
				                    </div>
			                    	<div class="top_counter col-lg-4 col-md-6" style="border-right: 1px solid rgb(0,0,0,0.2);">
			                    		<div style="height:40vh;">
					                        <div class="body" style="padding:10px;">
				                                <h5 style="display:inline-block;">진행중</h5>
					                        	<span style="font-size:1.3em;margin-left:5px;">[${empty homeFormVO.inprogressList ? 0 : homeFormVO.inprogressList.size() }개]</span>
					                        </div>    
					                        <div style="height: 33vh;overflow-y: auto;padding: 0 10px;">
				                            	<c:if test="${!empty homeFormVO.inprogressList }">
				                                	<c:forEach items="${homeFormVO.inprogressList }" var="issue">
				                                        <div class="card" style="height:70vh;padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
			                                            	<div style="margin-bottom: -15px;">
				                                                <h6 style="display:inline-block;font-weight: bold;max-width:100%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
				                                                	<c:if test="${issue.issueBoardSt eq 'Y' }">
					                                                	<i class="icon-info" style="color:green;"></i>
				                                                	</c:if>
				                                                	<c:if test="${issue.issueBoardSt eq 'N' }">
					                                                	<i class="icon-check" style="color:red;"></i>
				                                                	</c:if>
				                                                	<span class="issueTitle" style="font-size:1.1em;cursor: pointer;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId}', '이슈 상세보기',1200,900);">${issue.issueBoardTitle }</span>
				                                                </h6>
			                                                	<c:if test="${!empty issue.dutyBoardTitle }">
					                                                <span class="btn btn-secondary" style="height:auto;padding: 0px 3px;font-size:0.8em;margin-left:5px;margin-top: -10px;">#${issue.dutyBoardId }</span>
			                                                	</c:if>
			                                            	</div>
			                                            	<div style="margin-top:8px;margin-left:5px;">
				                                                <span>#${issue.issueBoardId }</span>
				                                                <span style="margin-left:5px;">${issue.issueBoardUpdateDt.split(" ")[0] }</span>
			                                            	</div>
				                                        </div>
				                                	</c:forEach>
					                    		</c:if>
					                    		<c:if test="${empty homeFormVO.inprogressList }">
					                    			<div style="text-align: center;padding:20px;">
						                    			<strong style="font-size:1.2em;">이슈가 없습니다.</strong>
						                    		</div>
					                    		</c:if>
					                        </div>
			                    		</div>
				                    </div>
			                    	<div class="top_counter col-lg-4 col-md-6">
			                    		<div style="height:40vh;">
					                        <div class="body" style="padding:10px;">
				                                <h5 style="display:inline-block;">완료</h5>
					                        	<span style="font-size:1.3em;margin-left:5px;">[${empty homeFormVO.doneList ? 0 : homeFormVO.doneList.size() }개]</span>
					                        </div>    
					                        <div style="height: 33vh;overflow-y: auto;padding: 0 10px;">
				                            	<c:if test="${!empty homeFormVO.doneList }">
				                                	<c:forEach items="${homeFormVO.doneList }" var="issue">
				                                        <div class="card" style="height:70vh;padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
			                                            	<div style="margin-bottom: -15px;">
				                                                <h6 style="display:inline-block;font-weight: bold;max-width:100%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
				                                                	<c:if test="${issue.issueBoardSt eq 'Y' }">
					                                                	<i class="icon-info" style="color:green;"></i>
				                                                	</c:if>
				                                                	<c:if test="${issue.issueBoardSt eq 'N' }">
					                                                	<i class="icon-check" style="color:red;"></i>
				                                                	</c:if>
				                                                	<span class="issueTitle" style="font-size:1.1em;cursor: pointer;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId}', '이슈 상세보기',1200,900);">${issue.issueBoardTitle }</span>
				                                                </h6>
			                                                	<c:if test="${!empty issue.dutyBoardTitle }">
					                                                <span class="btn btn-secondary" style="height:auto;padding: 0px 3px;font-size:0.8em;margin-left:5px;margin-top: -10px;">#${issue.dutyBoardId }</span>
			                                                	</c:if>
			                                            	</div>
			                                            	<div style="margin-top:8px;margin-left:5px;">
				                                                <span>#${issue.issueBoardId }</span>
				                                                <span style="margin-left:5px;">${issue.issueBoardUpdateDt.split(" ")[0] }</span>
			                                            	</div>
				                                        </div>
				                                	</c:forEach>
					                    		</c:if>
					                    		<c:if test="${empty homeFormVO.doneList }">
					                    			<div style="text-align: center;padding:20px;">
						                    			<strong style="font-size:1.2em;">이슈가 없습니다.</strong>
						                    		</div>
					                    		</c:if>
					                        </div>
			                    		</div>
				                    </div>
                        		</div>
                           </div>
                       </div>
					</li>
					
					<li class="dd-item" id="dashboardApproval" data-order="${homeFormVO.dashboardVO.dashboardApproval }" <c:if test="${empty homeFormVO.dashboardVO.dashboardApproval}">style="display:none;"</c:if>>
		               <div class="card">
		                  <div class="header" style="padding-bottom:0px;font-family: GoyangIlsan ">
		                          <h3 style="display:inline-block;">
		                             전자결재
		                          </h3>
		                          <span class="dd-handle" style="display:none;font-size:1.5em;cursor:pointer;float:right;color: gray;padding: 0px;background-color: white;line-height: 0;height: auto;margin:0px;"><i class="icon-cursor-move"></i></span>
		                        </div>
		                           <div class="body">
		                               <div class="row clearfix">
		                           <div class="col-6" style="font-family: S-CoreDream-4Regular">
		                              <div class="head">
		                                 <h5>
		                                    결재대기문서
		                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/waitList'">
	                                            <i class="fa fa-sign-in"></i>
	                                         </span>
		                                 </h5>
		                              </div>
			                            <div class="table-responsive" style="overflow: hidden;">
			                                <table class="table table-hover m-b-0 c_list">
			                                    <thead>
			                                        <tr>
			                                            <th>상신날짜</th>
			                                            <th>사용 양식</th>
			                                            <th>기안서 제목</th>
			                                            <th>결재상태</th>
			                                        </tr>
			                                    </thead>
			                                    <tbody style="cursor: pointer;">
			                                    	<c:if test="${not empty homeFormVO.waitDocList }">
					                                    <c:forEach items="${homeFormVO.waitDocList}" var="doc" varStatus="status">
					                                    <fmt:parseNumber value="${today - doc.approvalRecommandDt.time }" integerOnly="true" var="defferTime"/>
					                                    	<c:if test="${status.count < 5}">
						                                        <tr onclick='OpenWindow("${pageContext.request.contextPath }/approval/waitDocDetail?docId=${doc.docId}", "결재문서" ,900,900);'>
						                                            <td><fmt:formatDate value="${doc.approvalRecommandDt}" pattern="yyyy-MM-dd"/></td>
						                                            <td><span style="display: inline-block;max-width: 80px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${doc.formName}</span></td>
						                                            <td>
						                                            	<span class="text-info" style="display: inline-block;font-weight: bold;max-width: 120px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
						                                            		${doc.approvalTitle}
						                                            	</span>
						                                            	<c:if test="${defferTime <= (1000*60*30) }">
					                                                  		&nbsp;<span class="badge badge-danger">방금전</span>
					                                                  	</c:if>
						                                            </td>
						                                            <td><span class="badge badge-primary">결재대기</span></td>
						                                        </tr>
						                                    </c:if>
					                                    </c:forEach> 
			                                    	</c:if>
				                                    <c:if test="${empty homeFormVO.waitDocList}">
				                                    	<tr>
				                                            <td colspan="4" style="text-align: center;"><strong>결재 대기문서가 존재하지 않습니다.</strong></td>
				                                        </tr>
				                                    </c:if>  
			                                        
			                                    </tbody>
			                                </table>
			                            </div>
		                           </div>
		                           <div class="col-6"  style="font-family: S-CoreDream-4Regular">
		                              <div class="head">
		                                 <h5>
		                                    기안문서
		                                    <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/draftList'">
	                                            <i class="fa fa-sign-in"></i>
	                                         </span>
		                                 </h5>
		                              </div>
		                               <div class="table-responsive" style="overflow: hidden;">
		                                <table class="table table-hover m-b-0 c_list">
		                                    <thead>
		                                        <tr>
		                                            <th>상신날짜</th>
		                                            <th>사용 양식</th>
		                                            <th>기안서 제목</th>
		                                            <th>결재상태</th>
		                                        </tr>
		                                    </thead>
		                                    <tbody style="cursor: pointer;">
		                                    	<c:if test="${!empty homeFormVO.draftList }">
				                                    <c:forEach items="${homeFormVO.draftList }" var="doc" varStatus="status">
				                                    	<fmt:parseNumber value="${today - doc.approvalRecommandDt.time }" integerOnly="true" var="defferTime"/>
				                                    	<c:if test="${status.count < 5}">
					                                        <tr onclick='OpenWindow("${pageContext.request.contextPath }/approval/completeDocDetail?docId=${doc.docId}", "결재문서" ,900,900);'>
					                                            <td><fmt:formatDate value="${doc.approvalRecommandDt}" pattern="yyyy-MM-dd"/></td>
					                                            <td><span style="display: inline-block;max-width: 80px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${doc.formName}</span></td>
					                                            <td>
					                                            	<span class="text-info" style="display: inline-block;font-weight: bold;max-width: 120px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${doc.approvalTitle}</span>
					                                            	<c:if test="${defferTime <= (1000*60*30) }">
				                                                  		&nbsp;<span class="badge badge-danger">방금전</span>
				                                                  	</c:if>
					                                            </td>
					                                            <c:if test="${doc.approvalSt eq 1 }" >
					                                            	<td><span class="badge badge-success">결재진행중</span></td>
					                                            </c:if>
					                                            <c:if test="${doc.approvalSt eq 2 }" >
					                                            	<td><span class="badge badge-default">결재완료</span></td>
					                                            </c:if>
					                                            <c:if test="${doc.approvalSt eq 3 }" >
					                                            	<td><span class="badge-purple badge">결재반려</span></td>
					                                            </c:if>
					                                        </tr>
				                                        </c:if>
				                                    </c:forEach>   
		                                    	</c:if>
		                                        <c:if test="${empty homeFormVO.draftList}">
			                                    	<tr>
			                                            <td colspan="4" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
			                                        </tr>
			                                    </c:if>
		                                    </tbody>
		                                </table>
		                            </div>
			                           </div>
			                         </div>
			                               
		                           </div>
		                       </div>
					</li>
	            </ol>
            </div>
            
                       
                       
                       
               </div>
               <!-- 가운데줄 끝 -->
               
               <!-- 오른쪽줄 시작 -->
               <div class="col-3">
                  <div class="card">
                           <div class="header"  style="padding-bottom:0px;font-family: GoyangIlsan">
                          <h5>
                             공지사항<span class="badge badge-danger" style="font-family: S-CoreDream-4Regular">필독</span>
                             <span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/board/notice/list'">
                                <i class="fa fa-sign-in"></i>
                             </span>
                          </h5>
                        </div>
                           <div class="body" style="font-family: S-CoreDream-4Regular">
                               <div class="table-responsive" style="overflow-x: hidden;">
                                   <table class="table table-hover m-b-0 c_list">
                                       <thead>
                                           <tr>
                                               <th>날짜</th>
                                               <th>제목</th>
                                               <th>작성자</th>
                                           </tr>
                                       </thead>
                                       <tbody style="cursor: pointer;">
                                          <c:if test="${not empty homeFormVO.noticeList}">
                                             <c:forEach items="${homeFormVO.noticeList}" var="notice" varStatus="status">
                                                <c:if test="${status.count < 4}">
                                                   <tr onclick="OpenWindow('<%=request.getContextPath()%>/board/notice/detail?noticeId=${notice.noticeId }', '글 상세보기', 800, 700);">
                                                        <td><fmt:formatDate value="${notice.noticeCreateDt}" pattern="yyyy-MM-dd"/></td>
                                                        <td><span style="display:inline-block;font-weight: bold;max-width: 130px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">${notice.noticeTitle}</span></td>
                                                        <td><span>${notice.empName}&nbsp;${notice.officialName}</span></td>
                                                    </tr>
                                                 </c:if>
                                             </c:forEach>
                                          </c:if>
                                       
                                           <c:if test="${empty homeFormVO.noticeList}">
                                             <tr>
                                                  <td colspan="6" style="text-align: center;"><strong>해당 공지사항이 존재하지 않습니다.</strong></td>
                                              </tr>
                                          </c:if>
                                       </tbody>
                                   </table>
                               </div>
                           </div>
                  </div>
                  
                  <div class="card" style="height: 440px;">
                            <div class="header text-center" style="font-family: GoyangIlsan">
                               <h5 style="display: inline-block; margin-left: 100px;">일정관리</h5>
                               <span class="float-right" style="margin-right: 25px;"><i class="fa fa-circle" style="color: pink;"></i>일정표시</span>
                           </div>
                           <div id="calendar" style="margin: 0; padding: 0; font-family: GoyangDeogyang">
                           </div>
                  </div>
                  
                  <div class="card" style="font-family: S-CoreDream-4Regular">
                           <div class="body">
                              <div class="row clearfix list1">
                                    <div class="myShowHiddenDiv col-12">
                                       <span class="float-right">
                                          <span style="background-color: pink; border-radius: 50%;padding: 0 5px 0 5px; margin-right: 3px;" >${homeFormVO.scheduleList1.size()}</span>
                                          <span class="showHiddenBtn" style="cursor: pointer;"><i class="fa fa-plus"></i></span>
                                       </span>
                                    </div>
                              <div class="col-3 text-center">
                                 <span class="oneDate"></span>&nbsp;
                                 <span class="oneDayName"></span>
                                    </div>
                              <div class="col-9 scheduleList1">
                                 <c:forEach items="${homeFormVO.scheduleList1}" var="schedule" varStatus="status">
<%--                                     <c:if test="${status.count == 4}"> --%>
<!--                                        <i class="fa fa-sort-desc moreSchedule"></i> -->
<%--                                     </c:if> --%>
                                    <c:if test="${status.count >= 2 }">
                                       <div class="hiddenSchedule" style="display: none;">
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i>${schedule.scheduleTitle }</strong><br>
                                          <span>
                                             ${schedule.scheduleStartDt } ~
                                             ${schedule.scheduleEndDt }
                                          </span><br>
                                       </div>   
                                    </c:if>
                                    <c:if test="${status.count < 2 }">
                                       <div>
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i>${schedule.scheduleTitle }</strong><br>
                                          <span>
                                             ${schedule.scheduleStartDt } ~ ${schedule.scheduleEndDt }
                                          </span><br><br>
                                       </div>
                                    </c:if>
                                 </c:forEach>
                                 <c:if test="${empty homeFormVO.scheduleList1}">
                                          <tr>
                                               <td colspan="6" style="text-align: center;"><strong>해당 일정이 존재하지 않습니다.</strong></td>
                                           </tr>
                                       </c:if>
                                    </div>
                              </div>
                           </div>
                  </div>
                  
                  <div class="card" style="font-family: S-CoreDream-4Regular">
                           <div class="body ">
                              <div class="row clearfix list2">
                                 <div class="myShowHiddenDiv col-12">
                                    <span class="float-right">
                                       <span style="background-color: pink; border-radius: 50%;padding: 0 5px 0 5px; margin-right: 3px;" >${homeFormVO.scheduleList2.size()}</span>
                                       <span class="showHiddenBtn" style="cursor: pointer;"><i class="fa fa-plus"></i></span>
                                    </span>
                                 </div>
                              
                           <div class="col-3 text-center">
                              <span class="twoDate"></span>&nbsp;
                              <span class="twoDayName"></span>
                                 </div>
                           <div class="col-9 scheduleList2" >
                             <c:forEach items="${homeFormVO.scheduleList2}" var="schedule" varStatus="status">
                                 <c:if test="${status.count == 4}">
                                       <i class="fa fa-sort-desc moreSchedule"></i>
                                    </c:if>
                                    <c:if test="${status.count >= 2 }">
                                       <div class="hiddenSchedule" style="display: none;">
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i>${schedule.scheduleTitle }</strong><br>
                                          <span>
                                             ${schedule.scheduleStartDt } ~
                                             ${schedule.scheduleEndDt }
                                          </span><br>
                                       </div>   
                                    </c:if>
                                    <c:if test="${status.count < 2 }">
                                       <div>
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i>${schedule.scheduleTitle }</strong><br>
                                          <span>
                                             ${schedule.scheduleStartDt } ~ ${schedule.scheduleEndDt }
                                          </span><br><br>
                                       </div>
                                    </c:if>
                              </c:forEach>
                              <c:if test="${empty homeFormVO.scheduleList2}">
                                          <tr>
                                               <td colspan="6" style="text-align: center;"><strong>해당 일정이 존재하지 않습니다.</strong></td>
                                           </tr>
                                       </c:if>
                                 </div>
                              </div>
                           </div>
                  </div>
                  
                  <div class="card"  style="font-family: S-CoreDream-4Regular">
                           <div class="body ">
                              <div class="row clearfix list3">
                                 <div class="myShowHiddenDiv col-12">
                                    <span class="float-right">
                                       <span style="background-color: pink; border-radius: 50%;padding: 0 5px 0 5px; margin-right: 3px;" >${homeFormVO.scheduleList3.size()}</span>
                                       <span class="showHiddenBtn" style="cursor: pointer;"><i class="fa fa-plus"></i></span>
                                    </span>
                                 </div>
                              
                           <div class="col-3 text-center">
                              <span class="threeDate"></span>&nbsp;
                              <span class="threeDayName"></span>
                                 </div>
                           <div class="col-9 scheduleList3">
                              <c:forEach items="${homeFormVO.scheduleList3}" var="schedule" varStatus="status">
                                 <c:if test="${status.count == 4}">
                                       <i class="fa fa-sort-desc moreSchedule"></i>
                                    </c:if>
                                    <c:if test="${status.count >= 2 }">
                                       <div class="hiddenSchedule" style="display: none;">
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i>${schedule.scheduleTitle }</strong><br>
                                          <span>
                                             ${schedule.scheduleStartDt } ~
                                             ${schedule.scheduleEndDt }
                                          </span><br>
                                       </div>   
                                    </c:if>
                                    <c:if test="${status.count < 2 }">
                                       <div>
                                          <strong style="display: inline-block;font-weight: bold;max-width: 240px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><i class="fa fa-check-circle"></i>${schedule.scheduleTitle }</strong><br>
                                          <span>
                                             ${schedule.scheduleStartDt } ~ ${schedule.scheduleEndDt }
                                          </span><br><br>
                                       </div>
                                    </c:if>
                              </c:forEach>
                              <c:if test="${empty homeFormVO.scheduleList3}">
                                          <tr>
                                               <td colspan="6" style="text-align: center;"><strong>해당 일정이 존재하지 않습니다.</strong></td>
                                           </tr>
                                       </c:if>
                                 </div>
                              </div>
                           </div>
                  </div>
               </div>
               <!-- 오른쪽줄 끝 -->
               
         </div>
         </form:form>
     </div>
</div>

<form name="dashboardForm">
</form>

<!-- 조직도 -->
<script>
window.onload = function(){
	// 대시보드 순서 변경
	var orderList = new Array();
	$('.dd-item').each(function(){
		if($(this).css('display') != 'none'){
			var dashboardVO = {};
			var id = $(this).attr('id');
			var order = $(this).attr('data-order');
			dashboardVO.id = id;
			dashboardVO.order = order;
			orderList.push(dashboardVO);
		}
	});
	// 정렬
	var sortingField = "order";
	orderList.sort(function(a, b) { // 오름차순
	    return a[sortingField] - b[sortingField];
	});
	// 재배치
	$('#'+orderList[1].id).insertAfter('#'+orderList[0].id);
	$('#'+orderList[2].id).insertAfter('#'+orderList[1].id);
	
	// 회의실 예약 현황 현재 날짜 표시
	var now = new Date();
	var month = (now.getMonth()+1).toString().length == 1 ? '0'+ (now.getMonth()+1) : (now.getMonth()+1) ;
	var date = now.getDate().toString().length == 1 ? '0'+now.getDate() : now.getDate();
	var day = now.getDay();
	var dayArr = ['일','월','화','수','목','금','토'];
	$('#today').text(month+'/'+date+' '+dayArr[day]+'요일');
	
	// 회의실 예약 현황 표시
	<c:forEach items="${homeFormVO.reservationList}" var="meetroom">
		var startIndex = ${Integer.parseInt(meetroom.reservationStartTime) - 8};
		var endIndex = ${Integer.parseInt(meetroom.reservationEndTime) - 8};
		
		for(var i=startIndex; i<endIndex; i++){
			var reservation = '';
			if(i+8 <= now.getHours()){
				reservation = '<i class="fa fa-check"></i>'; 
			}else{
				reservation = '<i class="fa fa-calendar"></i>'; 
			}
			reservation += '<a href="javascript:OpenWindow(\'<%=request.getContextPath()%>/reservation/reservationDetail?meetRoomVO.meetRoomReservationId=${meetroom.meetRoomReservationId}\', \'JoinWorkGW\', 1000, 700);" class="m-l-5" style="cursor:pointer;color:black;"><span>${meetroom.meetRoomName} / ${meetroom.meetRoomNo} (${meetroom.deptName})</span></a><br>';
							 
			$('.reservationList').eq(i).closest('li').css('background-color','antiquewhite');
			$('.reservationList').eq(i).append(reservation);
		}
	</c:forEach>
	
	
   $(".fc-day-number").removeAttr("data-goto");
   getTime();
   showStaus();//페이지 켜질때 근무시간 계산시작하게하기
   
   // 대시보드 설정 변경시
   $('.dashboardEl').change(function(){
	  if($(this).is(':checked')){
		  $('#'+$(this).attr('name')).css('display','');
	  }else{
		  $('#'+$(this).attr('name')).css('display','none');
	  }
   });
}
<%@ include file="home_js.jsp"  %>



</script>
<!-- 근태 -->
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

//출근
/*근무 시간 입력*/
function insertStartWork(obj){
  $.ajax({
         url : "<%=request.getContextPath()%>/attend/insertStartWork",
         type : "get",
         dataType:"text",
         success : function (result) {
             alert(result);
             location.reload();
         },
         error : function (data) {
             alert("실패");
         }
     });
	  
}


//퇴근
/*퇴근시간 입력*/
function insertEndWork(){
	 $.ajax({
         url : "<%=request.getContextPath()%>/attend/insertEndWork",
         type : "get",
         success : function (data) {
             alert("퇴근 시간이 입력되었습니다");
             location.reload();
         },
         error : function (data) {
             alert("실패");
         }
     });
}

// 대시보드 설정탭 클릭시
function changeSettingMode(obj){
	if($(obj).attr('href') == '#setting_menu'){
		$('.dd-handle').css('display','');
	}else{
		$('.dd-handle').css('display','none');
	}
}

// 대시보드 설정 저장
function saveDashboard(obj){
	if($('.dashboardEl:checked').length > 3){
		alert('대시보드에 표시할 항목은 최대 3개까지만 가능합니다.');
		return;
	}else if($('.dashboardEl:checked').length < 3){
		alert('선택된 항목이 3개 미만일 경우 기본값으로 설정됩니다.');
		
		var cnt = $('.dashboardEl:checked').length;
		$('.defaultDashboard').each(function(){
			if(cnt == 3) return false;
			if($(this).is(':checked') == false){
				$(this).prop('checked',true);
				$('#'+$(this).attr('name')).css('display','');
				cnt++;
			}
		});
	}
	$(obj).text(' 저장중..');
	$(obj).prepend($('<i class="fa fa-spinner fa-spin"></i>'));
	
	var form = $('form[name="dashboardForm"]');
	form.children().remove();
	
	var order = 1;
	$('.dd-item').each(function(){
		if($(this).css('display') != 'none'){
			var inputTag = $('<input>').attr({'type':'hidden','name':$(this).attr('id'),'value':order++});
		}else{
			var inputTag = $('<input>').attr({'type':'hidden','name':$(this).attr('id'),'value':''});
		}
		
		form.append(inputTag);
	});
	
	form.append($('<input>').attr({'type':'hidden','name':'empId','value':'${loginUser.empId}'}));
	
	$.ajax({
		url:'<c:url value="/common/saveDashboard"/>',
		type:'post',
		data:form.serialize(),
		success:function(){
			alert('설정이 저장되었습니다.');
			$(obj).text('저장');
		}
	});
}


// 업무이슈 목록 클릭시
function showIssueHistory(obj){
	$('.issueList').css('background-color','');
	$(obj).css('background-color','beige');
	
	$('.issueHistory').children().remove();
	
	$.ajax({
		url:'<c:url value="/board/issue/reply/list"/>',
		type:'post',
		data:{issueBoardId:$(obj).attr('data-id')},
		success:function(issueReplyList){
			var history = '';
			
			if(issueReplyList.length > 0){
				history = '<div class="animated fadeIn" style="padding:0 10px;height:45vh;overflow-y:auto;">';
				
				for(var i=0; i<issueReplyList.length; i++){
					var issueReply = issueReplyList[i];
					
					if(issueReply.replyGroupCode == 1){	// 댓글
						history += '<div class="timeline-item dark">'
								  	+'<span class="date">'+getTimeDefferFromCurrent(new Date(issueReply.replyCreateDt))+'</span>'
								  	+'<h6 style="font-weight:bold;">댓글이 등록되었습니다.</h6>'
								  	+'<div class="media" style="margin-top:10px;margin-bottom:0px;">'
								  		+'<img class="media-object rounded width40 mr-3" src="${pageContext.request.contextPath}/admin/emp/getPicture?picture='+issueReply.empPicture+'" alt="">'
								  		+'<div class="media-body">'
								  			+'<h6 class="mb-0">'+issueReply.empName+'</h6>'
								  			+'<p style="margin:5px 0px 0px;">'+issueReply.replyContent+'</p>'
							  			+'</div>'
						  			+'</div>'
	  				  			  +'</div>';
					}else if(issueReply.replyGroupCode == 2){	// 공지
						history += '<div class="timeline-item warning">'
									+'<span class="date">'+getTimeDefferFromCurrent(new Date(issueReply.replyCreateDt))+'</span>'
									+'<h6 style="font-weight:bold;">'+issueReply.replyContent.split("@")[0]+'</h6>'
									+'<p style="margin:5px 0px 0px;">'+issueReply.replyContent.split("@")[1]+'</p>'
								  +'</div>';
					}else if(issueReply.replyGroupCode == 3){	// 이슈 재진행
						history += '<div class="timeline-item green">'
									+'<span class="date">'+getTimeDefferFromCurrent(new Date(issueReply.replyCreateDt))+'</span>'
									+'<h6 style="font-weight:bold;">이슈 재시작</h6>'
									+'<p style="margin:5px 0px 0px;">'+issueReply.empName+'님이 이슈를 다시 진행시켰습니다.</p>'
									+'</div>';
					}else if(issueReply.replyGroupCode == 4){	// 이슈 종료
						history += '<div class="timeline-item danger">'
									+'<span class="date">'+getTimeDefferFromCurrent(new Date(issueReply.replyCreateDt))+'</span>'
									+'<h6 style="font-weight:bold;">이슈 종료</h6>'
									+'<p style="margin:5px 0px 0px;">'+issueReply.empName+'님이 이슈를 종료시켰습니다.</p>'
								  +'</div>';
					}
				}
				history += '</div>';
			}else{ // 히스토리가 없으면
				history += '<div class="animated fadeIn" style="text-align:center;margin-top:150px;font-size:1.3em;">'
							+'<strong>해당 이슈의 히스토리가 없습니다.</strong>'
						  +'</div>';
			}
			
			$('.issueHistory').append(history);
		}
	});
}


var meetroomFlag = 0;
var distance = 900;
// 회의실 예약시간 이전버튼
function prevTime(){
	var move = meetroomFlag == 2 ? distance : distance-500;
	if(meetroomFlag > 0){
		meetroomFlag--;
		$('#meetroomReservationTime').animate({
			marginLeft : $('#meetroomReservationTime').css('margin-left').split('px')[0]*1 + move+"px"
		});
	}
}

// 회의실 예약시간 다음버튼
function nextTime(){
	var move = meetroomFlag == 0 ? distance : distance-500;
	if(meetroomFlag < 2){
		meetroomFlag++;
		$('#meetroomReservationTime').animate({
			marginLeft : $('#meetroomReservationTime').css('margin-left').split('px')[0]*1 - move+"px"
		});
	}
	
}
</script>

</body>