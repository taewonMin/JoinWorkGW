<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<jsp:include page="sidebar.jsp" />


<style>
.columnList {
	position:absolute;
}
.columnList:hover{
	background-color: white !important;
    border-color: white white #dee2e6 !important;
}
.roomTitle:hover{
	color:#2980b9;
}
tr:hover{
	background-color: white;
}
</style>

<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
			<div class="row clearfix">
                <div class="col-12" style="margin-top: 2%; font-family: 'S-CoreDream-6Bold">
                    <h2><i class="fa fa-tasks"></i>&nbsp;예약 내역 조회</h2>
                    <hr>
                </div>
		 	</div>
		 	
			<div id="dateCompare" style="display: none;"></div>
					<div>
						<c:choose>
							<c:when test="${type eq 'user' }"><h3>나의 예약</h3></c:when>
							<c:when test="${type eq 'dept' }"><h3>부서 예약</h3></c:when>
						</c:choose>
					</div>
			<div class="row clearfix">
						<c:set value="0" var="index"/>			
			            <c:forEach items="${reservationList}" var="todayReservation" varStatus="status">
			            	
			            	<c:if test="${todayReservation.reservationDate eq compareDate}">
				            	<c:if test="${index <4 }">
								<c:set value="${index+1 }" var="index"/>			
					                <div class="col-lg-3 col-md-6 col-sm-12">
					                    <div class="card" style="cursor:pointer;">
					                        <div class="body text-left pro-img" onclick="OpenWindow('${pageContext.request.contextPath }/reservation/reservationDetail?meetRoomVO.meetRoomReservationId=${todayReservation.meetRoomReservationId }', 'JoinWorkGW', 1200, 700);">
					                            <p><strong style="color: red;">${todayReservation.reservationDate}</strong>시간 :${todayReservation.reservationStartTime }시 ~ ${todayReservation.reservationEndTime }시</p>
					                            <p><strong>장소 : ${todayReservation.meetRoomName}</strong>(${todayReservation.meetRoomNo })</p>
					                            <p><strong>목적 : </strong>${todayReservation.meetRoomDetail }</p>
					                            <div class="project_progress">
					                                <div class="progress progress-xs">
					                                    <div class="progress-bar l-green" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
					                                        <span class="sr-only">100% Complete</span>
					                                    </div>
					                                </div>
					                            </div>
					                           		<br>
					                            <div class="align-items-center d-flex">
													<img alt="" src="getPicture?picture=${todayReservation.meetRoomAttachPath}" style="width: 338px;height: 150px;">
					                            </div>
					                        </div>
					                    </div>
					                </div>
				            	</c:if>
			            	</c:if>
			            </c:forEach>
			                               	
            </div>
	
	
<!-- 	내 예약 조회/ 부서 예약 조회 -->
            <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
                <div class="col-lg-6 col-md-6">
                    <div class="card">
                        <div class="body project_report" style="height: 950px;">
                    	<div style=" margin-left: 12px;"><h4 id="reservationType">예약</h4></div>
<!--                     	 -->
						<form:form commandName="meetRoomFormVO" name="listForm">
                        		<form:hidden path="searchMeetRoomVO.isType" id="isReservationType"/>
                        		<div style="margin-top:20px;">
								  	<form:select path="searchMeetRoomVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
								    	<form:option value="tcm">전체</form:option>
									    <form:option value="t">회의실명</form:option>
									    <form:option value="c">내용</form:option>
									    <form:option value="m">작성자</form:option>
								  	</form:select>
									<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
		                        		<form:input path="searchMeetRoomVO.searchKeyword" class="form-control" placeholder="Search here..." type="text" style="width: 200px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchMeetRoomList);"/>
					                    <button type="button" class="btn btn-default" onclick="searchMeetRoomList();"><i class="icon-magnifier"></i></button>
					                </div>				                
					                <div class="form-group" style="float:right;">
					                	<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
						                	<span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>
					                	</div>
						                <form:select path="searchMeetRoomVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchMeetRoomList(1);">
					       					<form:options items="${meetRoomFormVO.searchMeetRoomVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
					       				</form:select>
									</div>
                        		</div>
<!--                         	예약탭 -->
	                            <div class="table-responsive" >
	                        	<ul class="nav nav-tabs" style="position:absolute;width:97.5%;z-index: 10;">
	                            	<c:choose>
		                            		<c:when test = "${type == 'user' }" >
								                <li class="nav-item " style="cursor:pointer;"><a class="nav-link active" id="user" onclick="changeCategory(this);"> <span style="margin-left:5px;"></span>나의 예약</a></li>
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="dept" onclick="changeCategory(this);"> <span style="margin-left:5px;"></span> 부서 예약</a></li>
		                            		</c:when>
		                            		<c:when test = "${type == 'dept' }" >
								                <li class="nav-item " style="cursor:pointer;"><a class="nav-link " id="user" onclick="changeCategory(this);"> <span style="margin-left:5px;"></span>나의 예약</a></li>
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link active" id="dept" onclick="changeCategory(this);"> <span style="margin-left:5px;"></span> 부서 예약</a></li>
		                            		</c:when>
	                            	</c:choose>
						            </ul>
						            <div class="tab-content p-l-0 p-r-0 p-t-0">
						            	<!-- Open 이슈 -->
						                <div class="tab-pane animated fadeIn active">
			                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
			                                	<thead>
			                                		<tr>
			                                			<th style="width:40%;"></th>
			                                			<th style="width:20%;">예약 위치</th>
			                                			<th style="width:20%;">예약자</th>			                               
			                                		</tr>
			                                	</thead>
			                                	
			                                	
			                                	
			                                    <tbody style="border:hidden;">
			                                    	<c:if test="${!empty reservationList}">
			                                    	
			                                    		 <c:forEach items="${reservationList }" var="room">
				                                        	<c:if test="${room.reservationDate eq compareDate}">
					                                        	 <tr role="row">
						                                            <td class="project-title" style="padding:15px 30px;">
						                                            	<div>
							                                                <h6 style="display:inline-block;font-weight: bold;max-width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
							                                                	<span class="roomTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="OpenWindow('${pageContext.request.contextPath }/reservation/reservationDetail?meetRoomVO.meetRoomReservationId=${room.meetRoomReservationId }', 'JoinWorkGW', 1200, 700);">${room.meetRoomDetail }</span>
							                                                </h6>
							                                                <c:if test="${room.meetRoomReservationId ne 0 }">
							                                                	<c:if test="${room.reservationDate eq compareDate}">
									                                                <span class="btn btn-outline-danger" style="padding: 0px 3px;margin-left:5px;">오늘</span>
							                                                	</c:if>
							                                                </c:if>
							                                                <c:if test="${room.meetRoomReservationId eq 1 }">
								                                                <span class="btn btn-outline-secondary" style="padding: 0px 3px;margin-left:5px;">사용완료</span>
							                                                </c:if>
						                                            	</div>
						                                                <span style="margin-left:25px;">날짜 :${room.reservationDate }  </span>
						                                                <span style="margin-left:5px;">시간 :${room.reservationStartTime }시 ~ ${room.reservationEndTime }시</span>
						                                            </td>
						                                            <td class="project-actions" style="max-width: 0px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;padding-right:50px;">
						                                            	${room.meetRoomName } / ${room.meetRoomNo} 
						                                            </td>
						                                            <td class="project-actions">
				                                            			<div style="display:inline-block;vertical-align:middle;">
											                                <strong>${room.empName } ${room.officialName }</strong>
											                                <div>${room.deptName } <span>${room.teamName }</span></div>
											                            </div>
						                                            </td>
						                                        </tr>
				                                        	</c:if>
				                                        </c:forEach>
				                                        
				                                        <c:forEach items="${reservationList }" var="room">
				                                        	<c:if test="${room.reservationDate ne compareDate}">
				                                        		 <tr role="row">
						                                            <td class="project-title" style="padding:15px 30px;">
						                                            	<div>
							                                                <h6 style="display:inline-block;font-weight: bold;max-width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
							                                                	<span class="roomTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="OpenWindow('${pageContext.request.contextPath }/reservation/reservationDetail?meetRoomVO.meetRoomReservationId=${room.meetRoomReservationId }', 'JoinWorkGW', 1200, 700);">${room.meetRoomDetail }</span>
							                                                </h6>
							                                                <c:if test="${room.meetRoomReservationId ne 0 }">
							                                                	<c:if test="${room.reservationDate eq compareDate}">
									                                                <span class="btn btn-outline-danger" style="padding: 0px 3px;margin-left:5px;">오늘</span>
							                                                	</c:if>
							                                                </c:if>
							                                                <c:if test="${room.meetRoomReservationId eq 1 }">
								                                                <span class="btn btn-outline-secondary" style="padding: 0px 3px;margin-left:5px;">사용완료</span>
							                                                </c:if>
						                                            	</div>
						                                                <span style="margin-left:25px;">날짜 :${room.reservationDate }  </span>
						                                                <span style="margin-left:5px;">시간 :${room.reservationStartTime }시 ~ ${room.reservationEndTime }시</span>
						                                            </td>
						                                            <td class="project-actions" style="max-width: 0px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;padding-right:50px;">
						                                            	${room.meetRoomName } / ${room.meetRoomNo} 
						                                            </td>
						                                            <td class="project-actions">
				                                            			<div style="display:inline-block;vertical-align:middle;">
											                                <strong>${room.empName } ${room.officialName }</strong>
											                                <div>${room.deptName } <span>${room.teamName }</span></div>
											                            </div>
						                                            </td>
						                                        </tr>
				                                        	</c:if>
				                                        </c:forEach>
			                                    	
			                                    	</c:if>
			                                    	<!-- 검색결과가 없을때 -->
			                                    	<c:if test="${empty reservationList }">
			                                    		<tr role="row">
				                                            <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="8">검색 결과가 없습니다.</td>
			                                            </tr>
			                                    	</c:if>
		                                        </tbody>
			                                </table>
						                </div>
						                
						                <!-- Pagination -->
				                        <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
			                                <ul class="pagination" style="display: inline-block;">
			                                	<c:if test="${!empty reservationList }">
				                                   	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="searchMeetRoomList" />
			                                	</c:if>
			                                </ul>
			                            </nav>
			                            <form:hidden path="searchMeetRoomVO.pageIndex" />
						                
						            </div>
		                        </div>
	                        </form:form>
<!-- 	                         -->
	                    </div>
	                </div>
	                
	            </div>


	            
<!-- 	          	회의실의 공자사항과 / 회의실 민원을 접수하는 곳 -->
                <div class="col-lg-6 col-md-6">
                    <div class="card">
                        <div class="body project_report" >
                    	<div style=" margin-left: 12px;"><h4 id="reservationType">공지</h4></div>
<!--                     	 -->
						<form:form commandName="meetRoomFormVO" name="listForm2">
                        		<form:hidden path="searchReservationNoticeVO.isType" id="isReservationNoticeType"/>
                        		<div style="margin-top:20px;">
								  	<form:select path="searchReservationNoticeVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
								    	<form:option value="tc">전체</form:option>
									    <form:option value="t">제목</form:option>
									    <form:option value="c">내용</form:option>
								  	</form:select>
									<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
		                        		<form:input path="searchReservationNoticeVO.searchKeyword" class="form-control" placeholder="Search here..." type="text" style="width: 200px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchReservationNoticeList);"/>
					                    <button type="button" class="btn btn-default" onclick="searchReservationNoticeList();"><i class="icon-magnifier"></i></button>
					                </div>				                
					                <div class="form-group" style="float:right;">
					                	<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
						                	<span>${paginationInfo2.currentPageNo} </span>/<span> ${paginationInfo2.totalPageCount} 페이지 중</span>
					                	</div>
						                <form:select path="searchReservationNoticeVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchReservationNoticeList(1);">
					       					<form:options items="${meetRoomFormVO.searchReservationNoticeVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
					       				</form:select>
									</div>
                        		</div>
<!--                         	예약탭 -->
	                            <div class="table-responsive">
						            <div class="tab-content p-l-0 p-r-0 p-t-0">
						            	<!-- Open 이슈 -->
						                <div class="tab-pane animated fadeIn active">
						                	<ul class="nav nav-tabs" style="position:absolute;width:97.5%;z-index: 10;">
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link active" id="complain" > <span style="margin-left:5px;"></span> 공지사항</a></li>
								            </ul>
			                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
			                                	<thead>
			                                		<tr>
			                                			<th style="width:40%;"></th>
			                                			<th style="width:20%;">작성 날짜</th>
			                                			<th style="width:20%;">작성자</th>			                               
			                                		</tr>
			                                	</thead>
			                                    <tbody style="border:hidden;">
			                                    	<c:if test="${!empty reservationNoticeList}">
				                                        <c:forEach items="${reservationNoticeList }" var="notice">
						                                    <tr role="row">
					                                            <td class="project-title" style="padding:15px 30px;">
					                                            	<div>
						                                                <h6 style="display:inline-block;font-weight: bold;max-width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">	
						                                                	<span class="roomTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="OpenWindow('${pageContext.request.contextPath }/reservation/reservationNoticeDetail?reservationNoticeVO.reservationNoticeId=${notice.reservationNoticeId}', 'JoinWorkGW', 1200, 700);">${notice.reservationNoticeTitle }</span>
						                                                </h6>
					                                            	</div>
					                                                <span style="margin-left:25px;">${notice.reservationNoticeContent }  </span>
					                                            </td>
					                                            <td class="project-actions" style="max-width: 0px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;padding-right:50px;">
					                                            	${notice.reservationNoticeCreateDate }
					                                            </td>
					                                            <td class="project-actions">
			                                            			<div style="display:inline-block;vertical-align:middle;">
										                                <strong>관리자</strong>
										                            </div>
					                                            </td>
					                                        </tr>
				                                        </c:forEach>
			                                    	</c:if>
			                                    	<!-- 검색결과가 없을때 -->
			                                    	<c:if test="${empty reservationNoticeList }">
			                                    		<tr role="row">
				                                            <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="8">검색 결과가 없습니다.</td>
			                                            </tr>
			                                    	</c:if>
		                                        </tbody>
			                                </table>
						                </div>
						                
						                <!-- Pagination -->
				                        <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
			                                <ul class="pagination" style="display: inline-block;">
			                                	<c:if test="${!empty reservationNoticeList }">
				                                   	<ui:pagination paginationInfo="${paginationInfo2}" type="image" jsFunction="searchReservationNoticeList" />
			                                	</c:if>
			                                </ul>
			                            </nav>
			                            <form:hidden path="searchReservationNoticeVO.pageIndex" />
						                
						            </div>
		                        </div>
	                        </form:form>
<!-- 	                         -->
	                    </div>
	                </div>
                    <div class="card">
                        <div class="body project_report">
                    	<div style=" margin-left: 12px;"><h4 id="reservationType">민원</h4></div>
<!--                     	 -->
						<form:form commandName="meetRoomFormVO" name="listForm3">
                        		<div style="margin-top:20px;">
								  	<form:select path="searchReservationComplainVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
								    	<form:option value="tcw">전체</form:option>
									    <form:option value="t">제목</form:option>
									    <form:option value="c">내용</form:option>
									    <form:option value="w">작성자</form:option>
								  	</form:select>
									<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
		                        		<form:input path="searchReservationComplainVO.searchKeyword" class="form-control" placeholder="Search here..." type="text" style="width: 200px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchReservationComplainList);"/>
					                    <button type="button" class="btn btn-default" onclick="searchReservationComplainList();"><i class="icon-magnifier"></i></button>
					                </div>				                
					                <div class="form-group" style="float:right;">
					                	<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
						                	<span>${paginationInfo3.currentPageNo} </span>/<span> ${paginationInfo3.totalPageCount} 페이지 중</span>
					                	</div>
						                <form:select path="searchReservationComplainVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchReservationComplainList(1);">
					       					<form:options items="${meetRoomFormVO.searchReservationComplainVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
					       				</form:select>
									</div>
                        		</div>
<!--                         	예약탭 -->
	                            <div class="table-responsive">
		                        	<ul class="nav nav-tabs" style="position:absolute;width:97.5%;z-index: 10;">
						                <li class="nav-item" style="cursor:pointer;"><a class="nav-link active" id="complain"> <span style="margin-left:5px;"></span> 보낸 민원</a></li>
						            </ul>
						            <div class="tab-content p-l-0 p-r-0 p-t-0">
						            	<!-- Open 이슈 -->
						                <div class="tab-pane animated fadeIn active">
			                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
			                                	<thead>
			                                		<tr>
			                                			<th style="width:40%;"></th>
			                                			<th style="width:20%;">작성 날짜</th>
			                                			<th style="width:20%;">삭제</th>			                               
			                                		</tr>
			                                	</thead>
			                                	
			                                	
			                                	
			                                    <tbody style="border:hidden;">
			                                    	<c:if test="${!empty complainList}">
				                                        <c:forEach items="${complainList }" var="complain">
						                                    <tr role="row">
					                                            <td class="project-title" style="padding:15px 30px;">
					                                            	<div>
						                                                <h6 style="display:inline-block;font-weight: bold;max-width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
						                                                	<span class="complainTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="OpenWindow('${pageContext.request.contextPath}/reservation/complain/detail?complainId=${complain.complainId}','민원상세창',500,400);">${complain.complainContent}</span>
						                                                </h6>
					                                            	</div>
					                                                <span style="margin-left:25px;">${complain.complainTitle }  </span>
					                                            </td>
					                                            <td class="project-actions" style="max-width: 0px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;padding-right:50px;">
					                                            	${complain.complainCreateDate }
					                                            </td>
					                                            <td class="project-actions">
			                                            			<div style="display:inline-block;vertical-align:middle;">
										                                <input type="button"  class="btn btn-outline-danger" value="삭제" onclick="remove_go(${complain.complainId })"/>
										                            </div>
					                                            </td>
					                                        </tr>
				                                        </c:forEach>
			                                    	</c:if>
			                                    	<!-- 검색결과가 없을때 -->
			                                    	<c:if test="${empty complainList }">
			                                    		<tr role="row">
				                                            <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="8">검색 결과가 없습니다.</td>
			                                            </tr>
			                                    	</c:if>
		                                        </tbody>
			                                </table>
						                </div>
						                
						                <!-- Pagination -->
				                        <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
			                                <ul class="pagination" style="display: inline-block;">
			                                	<c:if test="${!empty complainList }">
				                                   	<ui:pagination paginationInfo="${paginationInfo3}" type="image" jsFunction="searchReservationComplainList" />
			                                	</c:if>
			                                </ul>
			                            </nav>
			                            <form:hidden path="searchReservationComplainVO.pageIndex" />
						                
						            </div>
		                        </div>
	                        </form:form>
<!-- 	                         -->
	                    </div>
	                </div>
	                
	                
	                
	            </div>
             
            </div>
            
        </div>
</div>

<%-- <form name="modifyForm" action='<c:url value="/board/milestone/modify"/>' method='post'> --%>
<!-- 	<input type="hidden" name="milestoneId" /> -->
<!-- 	<input type="hidden" name="milestoneName" /> -->
<!-- 	<input type="hidden" name="milestoneEndDt" /> -->
<!-- 	<input type="hidden" name="milestoneSt" /> -->
<!-- 	<input type="hidden" name="isOpen" id ="isOpenForModify" /> -->
<!-- 	<!-- detail 페이지 용 --> -->
<!-- 	<input type="hidden" name="openIssueCount" /> -->
<!-- 	<input type="hidden" name="closedIssueCount" /> -->
<%-- </form> --%>

 <script>
window.addEventListener('load', function() {
	var navBar = $('.reservationList'); 
	navBar.addClass('active');
	  });
</script>

<script>
//예약관련
//open/closed 탭 변경시 (예약관련 관련)
function changeCategory(obj){
	$('#isReservationType').val($(obj).attr('id'));
	$('form[name="listForm"]').submit();
}



window.onload=function(){
	/*선택된 타입 활성화*/
	$('#${MeetRoomFormVO.searchMeetRoomVO.isOpen}').addClass('active');
	/*페이지 네이숀*/
	paginationCSS(${paginationInfo.currentPageNo},
			  ${paginationInfo.firstPageNoOnPageList},
			  ${paginationInfo.lastPageNoOnPageList},
			  ${paginationInfo.totalPageCount});
}






//예약 - 검색 및 페이지네이션 
function searchMeetRoomList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm"]');
	$('input[name="searchMeetRoomVO.pageIndex"]').val(pageNo);
	listForm.submit();
}
//공지 - 검색 및 페이지네이션 
function searchReservationNoticeList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm2"]');
	$('input[name="searchReservationNoticeVO.pageIndex"]').val(pageNo);
	listForm.submit();
}
//민원 - 검색 및 페이지네이션 
function searchReservationComplainList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm3"]');
	$('input[name="searchReservationComplainVO.pageIndex"]').val(pageNo);
	listForm.submit();
}

// 내 이슈만 보기
function setSearchCondition(obj){
	if($(obj).is(':checked')){
		$('select[name="searchMeetRoomVO.searchCondition"]').val('w');
		$('input[name="searchMeetRoomVO.searchKeyword"]').val('${loginUser.empName}');
		$('input[name="searchMeetRoomVO.issueOpenSt"]').val('N');
	}else{
		$('select[name="searchMeetRoomVO.searchCondition"]').val('tcw');
		$('input[name="searchMeetRoomVO.searchKeyword"]').val('');
		$('input[name="searchMeetRoomVO.issueOpenSt"]').val('Y');
	}
	searchIssueList();
}
</script>



<script>
//공지사항과 민원
//open/closed 탭 변경시 (예약관련 관련)
function changeCategory2(obj){
	$('#isReservationNoticeType').val($(obj).attr('id'));
	$('form[name="listForm2"]').submit();
}



function remove_go(removeId) {
	var check = confirm('민원을 삭제하시겠습니까?');
	if(!check) return;
	
	$.ajax({
		url: "<c:url value='/reservation/reservationComplainRemove'/>",
		type:'post',
		data:{"removeId":removeId},
		success:function(){
			alert('글이 삭제되었습니다.');
			location.reload();
			
		},
		error:function(){
			alert('삭제 실패');
		}
	});
}



// 내 내것만 보기
function setSearchCondition(obj){
	if($(obj).is(':checked')){
		$('select[name="searchMeetRoomVO.searchCondition"]').val('w');
		$('input[name="searchMeetRoomVO.searchKeyword"]').val('${loginUser.empName}');
		$('input[name="searchMeetRoomVO.issueOpenSt"]').val('N');
	}else{
		$('select[name="searchMeetRoomVO.searchCondition"]').val('tcw');
		$('input[name="searchMeetRoomVO.searchKeyword"]').val('');
		$('input[name="searchMeetRoomVO.issueOpenSt"]').val('Y');
	}
	searchIssueList();
}
</script>
<script>
function getDate() {
var today = new Date();
var year = today.getFullYear();
var month = today.getMonth()+1;
var day = today.getDate();
var format = year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+day.toString()).slice(-2));
$('#dateCompare').text(format);
$('#dateCompare').val(format);
}
</script>
