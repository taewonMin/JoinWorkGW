<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<jsp:include page="sidebar.jsp" />
 
<style>
.highlight{
    background-color: #f8f9fa;
    padding: 20px;
}
.highlight pre code {
    font-size: inherit;
    color: #212529;
}
.nt {
    color: #2f6f9f;
}
.na {
    color: #4f9fcf;
}
.s {
    color: #d44950;
}
pre.prettyprint {
    background-color: #eee;
    border: 0px;
    margin: 0;        
    padding: 20px;
    text-align: left;
}

.atv,
.str {
    color: #05AE0E;
}

.tag,
.pln,
.kwd {
    color: #3472F7;
}

.atn {
    color: #2C93FF;
}

.pln {
    color: #333;
}

.com {
    color: #999;
}
#hiddenFillBtn:hover{
	background-color: #ffffff;
}

</style>
<body>
<button type="button" class="btn btn-outline-light" id="hiddenFillBtn" onclick="presentationFill();" style="position:absolute;right:25px;top:160px;color:#ffffff; z-index: 100; border: 0px;width:100px;height:50px;"></button>
<div id="main-content" class="profilepage_1">
        <div class="container-fluid">
            <div class="block-header">
                <div class="row">
                    <div class="col-lg-6 col-md-8 col-sm-12">
                        <h2 style="font-family: S-CoreDream-6Bold; font-size: 30px;" ><a href="javascript:void(0);" class=""><i class="fa fa-home" style="font-size: 30px;" ></i></a> 관리자 회의실 관리</h2>
                    </div>            
                </div>
            </div>

            <div class="row clearfix">
                <div class="col-lg-4 col-md-12">
                    <div class="card">
                        <div class="body">
                        	<div class="row">
	                            <h5 style="font-family: S-CoreDream-4Regular" class="col-md-10">공지사항 </h5> 
                        	</div>
                            <div class="body" style="font-family: S-CoreDream-6Bold">
	                            <div class="table-responsive" style="overflow-x: hidden;">
	                                <table class="table table-hover m-b-0 c_list">
										<thead>
											<tr>
												<th>날짜</th>
												<th>제목</th>
											</tr>
										</thead>
										<tbody style="cursor: pointer;">
											<c:forEach items="${reservationNoticeList}" var="notice" varStatus="status">
		                                    	<c:if test="${status.count <5}">
		                                    	 <tr role="row" class="odd" onclick="OpenWindow('<%=request.getContextPath()%>/reservation/reservationNoticeDetail?reservationNoticeVO.reservationNoticeId=${notice.reservationNoticeId}', 'JoinWorkGW', 1000, 700);">
		                                            <td>${notice.reservationNoticeCreateDate }</td>
		                                            <td style="text-overflow: ellipsis;">${notice.reservationNoticeTitle }</td>
		                                    	 </tr>
		                                    	</c:if>
		                                    </c:forEach>
		                                    <c:if test="${empty reservationNoticeList}">
		                                    	<tr>
	                                        		<td colspan="6" style="text-align: center;"><strong>공지가  존재하지 않습니다.</strong></td>
				                            	</tr>
		                                    </c:if>
										</tbody>
									</table>
	                            </div>
	                        </div>
                            
                        <button class="btn btn-primary" style="font-family: S-CoreDream-4Regular" onclick="OpenWindow('${pageContext.request.contextPath }/reservation/noticeRegistForm', 'JoinWorkGW', 1200, 700);">공지사항 작성</button></div>
                    </div>
                    
                    
                    <div class="card">
                        <div class="body" style="font-family: S-CoreDream-6Bold">
                        	<h5 style="font-family: S-CoreDream-4Regular">들어온 민원</h5>
                       		<div class="table-responsive" style="overflow-x: hidden;">
									<table class="table table-hover m-b-0 c_list">
										<thead>
											<tr>
												<th>날짜</th>
												<th>민원내용</th>
											</tr>
										</thead>
										<tbody style="cursor: pointer;">
											<c:forEach items="${complainList}" var="complain" varStatus="status">
		                                    	<c:if test="${status.count <5}">
		                                    	 <tr role="row" class="odd" onclick="OpenWindow('${pageContext.request.contextPath}/reservation/complain/detail?complainId=${complain.complainId}','민원상세창',500,400);">
		                                            <td>${complain.complainCreateDate }</td>
		                                            <td>
			                                            <span style="display: inline-block;font-weight: bold;max-width: 280px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
			                                            ${complain.complainContent }
			                                            </span>
		                                            </td>
		                                    	 </tr>
		                                    	</c:if>
		                                    </c:forEach>
		                                    <c:if test="${empty complainList}">
		                                    	<tr>
	                                        		<td colspan="6" style="text-align: center;"><strong>민원이  존재하지 않습니다.</strong></td>
				                            	</tr>
		                                    </c:if>
										</tbody>
									</table>
	                                </table>
	                            </div>
                        </div>
                    </div>
<!--                     회의실 활성화 비활성화 하는 곳 -->
					<div class="card">
						<form:form commandName="meetRoomFormVO" id="listForm" name="listForm">
						<div class="row">
						  <div class="header col-12" style="padding-bottom: 0px; font-family: S-CoreDream-4Regular; padding-left: 40px;">
							<h4>회의실 현황 </h4>
						  </div>
						  <div class="col-12" style="font-family: S-CoreDream-6Bold">
								<form:select path="searchMeetRoomVO.searchCondition" class="form-control selectSearch" style="width:80px;font-size: 1.2em;float:left;margin-left: 10px;">
							    	<form:option value="tcm">전체</form:option>
								    <form:option value="t">회의실 명</form:option>
								    <form:option value="c">내용</form:option>
							  	</form:select>
							  	<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
	                        		<form:input path="searchMeetRoomVO.searchKeyword" class="form-control" placeholder="Search here..." type="text" style="width: 218px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchMeetRoomList);"/>
				                    <button type="button" class="btn btn-default" onclick="searchMeetRoomList();"><i class="icon-magnifier"></i></button>
				                </div>
	                        	<div class="form-group" style="float:right;">
					                <form:select path="searchMeetRoomVO.pageUnit" class="form-control" style="width:110px;font-size: 1.2em;margin-right: 10px;" onchange="searchMeetRoomList(1);">
				       					<form:options items="${meetRoomFormVO.searchMeetRoomVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
				       				</form:select>
								</div>
							</div>
							<div class="col-12" style="font-family: S-CoreDream-6Bold">
								<div class="header" style="text-align: right;padding-bottom: 0px;padding-top: 0px;margin-top: 0px;">
									<form:input path="searchMeetRoomVO.meetRoomSt" type="submit" value="사용중인회의실" class="btn btn-primary" style="border-right-width: 0px; margin-right: 10px;"></form:input>
									<form:input path="searchMeetRoomVO.meetRoomSt" type="submit" value="비활성회의실" class="btn btn-danger" style="border-right-width: 0px; margin-right: 10px;"></form:input>
<!-- 									<button type="button" onclick="getRomList(Y);" class="btn btn-primary"style="border-right-width: 0px; margin-right: 10px;">사용중인회의실</button> -->
<!-- 									<button type="button" onclick="getRomList(N);" class="btn btn-danger">비활성 회의실</button> -->
								</div>
							</div>	
						 </div>
						<div class="body" style="padding-top: 0px; font-family: S-CoreDream-6Bold">
							<hr>
							<div class="w_user"></div>
								
								<ul class="right_chat list-unstyled mb-0">
									<c:forEach items="${meetRoomList}" var="room">
									<li class="online">
										<a href="javascript:void(0);">
											<div class="media">
												
												<div class="media-body">
													<span class="name">${room.meetRoomName}
														<c:choose>
															<c:when test="${room.meetRoomSt eq 'Y'}"><span class="badge badge-primary">활성화</span></c:when>
															<c:when test="${room.meetRoomSt eq 'N'}"><span class="badge badge-danger">비활성화</span></c:when>
														</c:choose>
													</span>
													<span class="message">${room.meetRoomCapacity}인용/${room.meetRoomContent}</span>
													<img alt="" src="getPicture?picture=${meetRoomVO.meetRoomAttachPath}" style="width: 50px;border-top-width: 10px;margin-top: 50px;">
												</div>
												<div>
													<button type="button" class="btn btn-outline-secondary" onclick="OpenWindow('<%=request.getContextPath()%>/reservation/detail?meetRoomId=${room.meetRoomId}', 'JoinWorkGW', 1000, 700);">조회</button>
												</div>
											</div>
										</a>
									</li>
									</c:forEach>	
								</ul>
						</div>
						
						<!-- Pagination -->
			                      <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
	                                <ul class="pagination" style="display: inline-block;">
	                                   	<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchMeetRoomList" />
	                                </ul>
	                             </nav>
								<form:hidden path="searchMeetRoomVO.pageIndex" />
							</form:form>
					</div>
                </div>
                
<!--                 회의실 생성 -->
                <div class="col-lg-8 col-md-12">
                    <div class="card" style="padding-top: 0px;">
						<div class="header" style="padding-bottom: 5px;">
							<h4 style="font-family: S-CoreDream-4Regular">회의실 생성</h4>
						</div>
						<div class="body" style="padding-top: 10px; font-family: S-CoreDream-4Regular">
							<form:form  commandName="meetRoomFormVO" name="meetRoomModifyForm"  enctype="multipart/form-data" id="registRoom">
								<form:hidden path="meetRoomVO.meetRoomId"/>
								<div class="form-group">
									
									<form:input path="meetRoomVO.meetRoomName" class="form-control roomName" style="width: 100%;margin-bottom: 5px" placeholder="회의실 명 "></form:input>
									<form:input class="form-control roomNo" path="meetRoomVO.meetRoomNo" style="width: 100%;margin-bottom: 5px" placeholder="회의실 호"></form:input>
									<p style="color: red;margin-bottom: 0px;">*숫자만 입력해주세요</p>		
									<form:input class="form-control roomCapacity" path="meetRoomVO.meetRoomCapacity" style="width: 100%;" placeholder="수용 가능 인원" value="" id="Capacity"></form:input>
									<p style="color: red;margin-bottom: 0px;">*100자 내로 적어주세요</p>	
									<form:textarea id="text" name="text" class="form-control roomContent" path="meetRoomVO.meetRoomContent" style="height: 150px;" placeholder="회의실 정보 작성"></form:textarea>
									
								</div>
								<p style="color: red;margin-bottom: 0px;">*이미지는 필수입니다</p>							
								<div>
									<form:input type="file" name="fileUploadCommand.uploadFile" class="dropify image"  style="height: 200px;"  path="fileUploadCommand.uploadFile"/>
<!-- 									<input type="file" name="fileUploadCommand.uploadFile" class="dropify"  style="height: 200px;"> -->
								</div>
							</form:form>
								<div >
									<button  type="button" class="btn btn-primary" onclick="regist_go();" style="margin-top: 5px; width: 100%;">회의실 생성</button>
								</div>
						</div>
					
					
					
					</div>
                    <div class="card">
                        <div class="body" style="font-family: S-CoreDream-6Bold">
                        
							<c:forEach items="${reservationList  }" var="reservation" varStatus="status">
								<c:if test="${status.count <8}">
									<div class="timeline-item green" onclick="OpenWindow('<%=request.getContextPath()%>/reservation/reservationDetail?meetRoomVO.meetRoomReservationId=${reservation.meetRoomReservationId}', 'JoinWorkGW', 1000, 700);">
		                                <span class="date">${reservation.meetRoomName }(${reservation.meetRoomNo })</span>
		                                <h6>${reservation.meetRoomDetail }</h6>
		                                <span>직원 : <a href="javascript:void(0);" title="Fidel Tonn">${reservation.empName }</a><span class="badge badge-primary">${reservation.empId }</span></span>
		                                <span>사용 시간 : ${reservation.reservationDate }/ ${reservation.reservationStartTime }시 ~ ${reservation.reservationEndTime }시</span>
		                            </div> 
								</c:if>
							</c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
 </body>
 
 
 <script>
window.addEventListener('load', function() {
	var navBar = $('.reservationAdmin'); 
	navBar.addClass('active');
	/*회의실 내용 제거*/
	$("#registRoom")[0].reset(); 
	$("#dropify").val()
	$(".dropify-filename-inner").text("");
	$(".dropify-render").text("");
	  });
</script>
 
 <script>
 //회의실 등록(내일 조건 값이 비면 안됨 이미지 없으면 안됨 호수에 이상한거  넣으면 안됨 인원에 글자 들어가면 안됨 이미지 말고 이상한 파일이면 안됨)
 function regist_go(){
		var regex= /^[0-9]/g; // 숫자 정규식
	 
		var roomName =$(".roomName").val();
		var roomNo =$(".roomNo").val();
		var roomCapacity= $(".roomCapacity").val();
		var roomContent= $(".roomContent").val();
		var image= $(".image").val();
		
		
		if (roomName == ""||roomName.length >20) {
			alert("회의실 이름을 적어주세요");
			return;
		}else if (roomNo == "" || roomNo.length >20) {
			alert("몇호인지 입력해주세요");
			return;
		}else if (!regex.test(roomCapacity) || roomCapacity <= 0 || roomCapacity >= 99) {
			alert("수용인원은 숫만 입력해주세요");
			return;
		}else if (roomContent == "" || roomContent.length >100) {
			alert('내용을 입력해주세요');
		}else if (image == null || image == "") {
			alert("이미지는 필수입니다");
			return;
		}
		
		var modifyForm = $('form[name="meetRoomModifyForm"]')[0];
		modifyForm.action = "<c:url value='/reservation/regist'/>";
		var formData = new FormData(modifyForm);
			$.ajax({
				url:modifyForm.action,
				type:'post',
				data: formData,
				processData:false,
				contentType:false,
				success:function(){
					alert("생성에 성공하였습니다");
					
					location.reload();
				},
				error:function(){
					alert("오류가  발생했습니다. 연결이 유실됩니다");
					
				}
			});
			
	}
 
 
 //검색 및 페이지네이션
function searchMeetRoomList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm"]');
	$('input[name="searchMeetRoomVO.pageIndex"]').val(pageNo);
	listForm.submit();
}
 //회의실 리스트
  function getRomList(){
		$.ajax({
				url: "<c:url value='/reservation/roomList'/>",
				type:'get',
				processData:false,
				contentType:false,
				success:function(){},
				error:function(){}
			});
	}
  function notUseRoomList(){
		$.ajax({
				url: "<c:url value='/reservation/notUseRoomList'/>",
				type:'get',
				processData:false,
				contentType:false,
				success:function(){
					
				},
				error:function(){}
			});
	}
 
 
  
  window.onload=function(){
	  $('#Capacity').val('');
		// 정렬 아이콘 삭제
		var thList = $('tr[role="row"] > th');
		for(var i=0; i<thList.length; i++){
			thList.eq(i).removeClass();
		}

		paginationCSS(${paginationInfo.currentPageNo},
				  ${paginationInfo.firstPageNoOnPageList},
				  ${paginationInfo.lastPageNoOnPageList},
				  ${paginationInfo.totalPageCount});
	}
  
  
 

 </script>
<script> // 시연용
function presentationFill(){
// 	alert('클릭');

	$(".roomName").val("분임토의 5실");
	$(".roomNo").val("406호");
	$(".roomCapacity").val("25");
	$(".roomContent").val("노트북/모니터/키보드/마우스/빔프로젝터/에어컨");
	
}
</script>
