
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<jsp:include page="sidebar.jsp" />

<style>
#hiddenFillBtn:hover{ background-color: #ffffff;}
</style>
<body>

<!-- <div id="left-sidebar" class="sidebar" style="border-right:2px solid rgb(0,0,0,0.1)"> -->

<!-- 	<div> -->
<!-- 		<div class="body"> -->
<!-- 			<div class=""><i class=" "></i> </div> -->
<!-- 				<div class="content"> -->
<!-- 					<div class="text">&nbsp;&nbsp;&nbsp;  -->
<!-- 						<h4><i class="fa  fa-clock-o fa-1x"></i> 근무 시간</h4> -->
<!-- 						<div class="body"> -->
<!--                             <div class="content" style="text-align: center;"> -->
<!--                                <div><h3 class=" align-center" style="font-size:2.5em;  color:#3672ff;" id="worked"></h3></div> -->
<!--                                <small style="color: red;" id="endWorked"></small> -->
<!--                             </div> -->
<!--                         </div> -->
<!-- 					</div> -->
<!-- 				<h5 class="근무시간"></h5> -->
<!-- 				</div> -->
<!-- 				<hr> -->
<!-- 				<div class="tab-content"> -->
<!-- 					<div class="row clearfix"> -->
<!-- 						<div class="col-6"> -->
<!-- 							<button type="button" class="btn btn-success" onclick="insertStartWork();" id="workStartButton" style="width: 100px;" ><i class="fa fa-check-circle"></i> <span>출근하기</span></button> -->
<!-- 						</div> -->
<!-- 						<div class="col-6" style="padding-left: 5px;"> -->
<!-- 							<button type="button" class="btn btn-danger" onclick="insertEndWork();" id="workEndButton" style="width: 100px;"><i class="fa fa-home"></i> <span>퇴근하기</span></button> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 		</div> -->
<!-- 	</div> -->

<!--             <div class="tab-content p-l-0 p-r-0"> -->
<!--                 <div class="tab-pane animated fadeIn active" id="project_menu"> -->
<!--                     <nav class="sidebar-nav"> -->
<!--                         <ul class="main-menu metismenu"> -->
<%--                             <li ><a href="<%=request.getContextPath()%>/attend/mylist"><i class="icon-user"></i>내 근태 조회</a></li> --%>
<%--                             <li ><a href="<%=request.getContextPath()%>/attend/teamlist"><i class="icon-users"></i>팀 근태 조회</a></li> --%>
<%--                             <li ><a href="<%=request.getContextPath()%>/attend/deplist"><i class="icon-users"></i>부서 근태 조회</a></li> --%>
<!--                         </ul>                         -->
<!--                     </nav>                     -->
               
<!--                 </div>              -->
<!--             </div>   -->

<!-- 	</div> -->


<!--                     근태 목록 -->
            <div id="main-content">
                <div class="container-fluid">

                    <div class="row">
                        <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold;">
                            <h2 class="" style="font-size: 2rem;" >
                            	<i class="fa icon-clock"></i>&nbsp근태 관리
                            </h2>
                            <hr>
                        </div>
                    </div>
                    <div class="row clearfix ">
                        <div class="col-8" style="padding-right: 0px;">
                        	<form:form commandName="attendenceFormVO" id="listForm" name="listForm"> 
							<form:hidden path="searchAttendceVO.searchYear" id="searchYear"/>
							<form:hidden path="searchAttendceVO.searchMonth" id="searchMonth"/>
                            <div class="card mb-4" style="font-family: S-CoreDream-6Bold" >
									<div class="row clearfix ">
										<div class="col-7" style="height: 126px;">
											<!-- 검색 조건 설정 -->
				                           <h5 style="display:inline-block; font-weight: bold;margin-left: 20px;margin-top: 12px;">검색 조건</h5>
				                           <br>
				                           <div class="alert alert-light" role="alert" style="display:inline-block;padding-top:0;margin-bottom:0;">
				                           <label class="fancy-checkbox">
				                                 <input type="checkbox" checked="checked" data="selectDt" id="dateCheckBox" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
				                                 <span>날짜 선택</span>
				                           </label>
				                           <label class="fancy-checkbox">
				                                 <input type="checkbox" checked="checked" id="checkboxState" data="selectState" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
				                                 <span>지각 여부</span>
				                           </label>
					                        <button id="resetBtn" type="reset" class="btn btn-default" title="Refresh" style="display: none;"></button>
					                        <label onclick="conditionReset();"  style="cursor: pointer;">
					                           <i class="fa fa-refresh"></i>&nbsp&nbsp검색 조건 초기화
					                        </label>
				                            <div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
				                                [총 <fmt:formatNumber value="${paginationInfo.totalRecordCount }" type="number"/>개]
				                            </div>
				                           </div>
				                           <div class="input-group date searchCri searchDt selectDt myConditions" data-date-autoclose="true" data-provide="datepicker" style="margin-left: 20px;font-size:1.2em;width:200px;float:left;">
				                                <form:input path="searchAttendceVO.searchDt" id="inputSearchDt" type="text" class="form-control" placeholder="날짜 선택" readonly="true"/>
				                                <div class="input-group-append">                                            
				                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
				                                </div>
				                            </div>
				                           <form:select path="searchAttendceVO.searchState" id="selectSearchState" class="form-control selectState myConditions" style="width:200px;font-size: 1.2em;margin-right:15px;float:left;margin-left:20px;">
				                            <form:option value="">지각 여부  선택</form:option>
				                            <form:option value="정상출근">정상출근</form:option>
				                            <form:option value="지각">지각</form:option>
				                          </form:select>
				                          <br>
				                          <button onclick="searchList();" type="button" class="btn btn-outline-secondary" style="margin-left:20px;">검색</button>
			                           </div>
			                           
			                           
			                           
			                           <div class="col-5">
				                           <div class="form-group" style="float:left;">
				                           		<div class="text-end " align="right" style="font-family: S-CoreDream-6Bold">
					                                <button class="mb-0 mt-1 btn btn-default" onclick="setNowDate();">현재 날짜로</button>
					                                <div class="d-md-inline-block d-none mx-2 text-start" style="display: inline-block;">
					                                    <div class="float-start me-2">
					                                        <button class="mb-0 mt-1 btn btn-default" onclick="beforMonth();"><i class="fa fa-angle-left fa-2x"></i> </button>
					                                    </div>
					                                    <span id="bh_visitors" class="float-end"></span>
					                                </div>
					                                <div class="d-xl-inline-block d-none mx-2 text-start" style="display: inline-block;">
					                                    <div class="float-start me-2" >
					                                        <br>
					                                        <br>
					                                        <h4 class="mb-0 mt-1 "id="year" style="display: inline-block;">${searchAttendceVO.searchYear }</h4><h4 style="display: inline-block;">년</h4> 
					                                        <h4 class="mb-0 mt-1 "id="month" style="display: inline-block;">${searchAttendceVO.searchMonth }</h4>&nbsp<h4 style="display: inline-block;">월</h4>
					                                    </div>
					                                    <span id="bh_visits" class="float-end"></span>
					                                </div>
					                                <div class="d-lg-inline-block d-none mx-2 text-start" style="display: inline-block;">
					                                    <div class="float-start me-2">
					                                        <button type="button" class="mb-0 mt-1 btn btn-default" onclick="nextMonth();"><i class="fa fa-angle-right fa-2x"></i></button>
					                                    </div>
					                                    <span id="bh_chats" class="float-end"></span>
					                                </div>
					                            </div>
				                        	</div>
			                           
			                           </div>
			                           
			                        </div>
									
								<!-- 설정된 검색 조건 입력 폼 표시 -->
                           <div>
                            
                            
                            
                        	
                           </div>	
                                <div class="card-body" id="tablAttendence" style="font-family: S-CoreDream-6Bold">
                                   <div id="indexListAjax">

									 <table id="holidays_list" class="table table-hover">
										<thead class="thead-dark">
										    <tr>
										        <th>날짜</th>
										        <th>출근시간</th>
										        <th>퇴근시간</th>
										        <th>상태</th>
										        <th>지각사유</th>
										    </tr>
										</thead>
									<!-- 근태 바디 -->
										<tbody class="attendBody">
											<c:choose>
												<c:when test="${!empty dataMap.attendenceList}">
													<c:forEach items="${dataMap.attendenceList }" var="attendence">
															<c:if test="${attendence.attendStName eq '지각' }">
																<tr style="cursor: pointer;" onclick="inputReasonBox(this);">
															</c:if>
															<c:if test="${attendence.attendStName ne '지각' }">
																<tr>
															</c:if>
															<td class="myAttendDt">
																<fmt:formatDate value="${attendence.historyAttendTime }" pattern="yyyy-MM-dd"/>
															</td>
															<td>
																<c:choose>
																	<c:when test="${!empty attendence.historyAttendTime }"> <fmt:formatDate value="${attendence.historyAttendTime }" pattern="HH:mm:ss"/> </c:when>
																	<c:when test="${empty attendence.historyAttendTime}"> - </c:when>
																</c:choose>
															</td>
															<td>
																<c:choose>
																	<c:when test="${!empty attendence.historyLeavingTime }"> <fmt:formatDate value="${attendence.historyLeavingTime }" pattern="HH:mm:ss"/> </c:when>
																	<c:when test="${empty attendence.historyLeavingTime}"> - </c:when>
																</c:choose>
															</td>
															<td>
																<c:if test="${attendence.attendStName ne '정상출근' }">
																	<span class="badge badge-danger">${attendence.attendStName}</span>
																</c:if>
																<c:if test="${attendence.attendStName eq '정상출근' }">
																	<span class="badge badge-success">${attendence.attendStName}</span>
																</c:if>
															</td>
															<td style="max-width: 130px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis; width: 130px;">
																<c:choose>
																	<c:when test="${attendence.historyReason eq 'none' or attendence.historyReason eq '없음' or attendence.historyReason eq null}">
																	 <span class="myReason" >-</span>
																	</c:when>
																	<c:otherwise>
																		<span class="myReason" >${attendence.historyReason}</span>
																	</c:otherwise>
																</c:choose>
															</td>
														</tr>
													</c:forEach>
												</c:when>
												<c:when test="${empty dataMap.attendenceList}">
													<tr>
														<td></td>
														<td></td>
														<td style="text-align: center;">해당 월의 근태정보가 없습니다.</td>
														<td></td>
													</tr>
												</c:when>
											</c:choose>
										</tbody>
									</table>
								</div>
                                </div>
                            <!-- Pagination -->
	                           <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
	                               <ul class="pagination" style="display: inline-block;">
	                                     <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchList" />
	                               </ul>
	                           </nav>
                            <form:hidden path="searchAttendceVO.pageIndex" />
                            </form:form>
                            </div>
                        </div>
                        
                        
                        
                        
                        
						<!-- 통계시작 -->
                        <div class="col-4">
                            <div class="card" style="margin-bottom: 13px;">
                            	<div class="row clearfix">
                            		<div class="col-6" style="padding-right: 0px;">
		                            	<div class="chart chart1" data-percent="${(dataMap.attendenceList[0].nomalCnt/(dataMap.attendenceList[0].nomalCnt + dataMap.attendenceList[0].lateCnt))*100 }" style="margin-top: 24px;padding-left: 10px;">
		                            	</div>
	                            	</div>
	                            	<div class="col-6" style="font-family: S-CoreDream-6Bold;">
	                            		<table id="holidays_list" class="table table-hover">
	                            			<tbody>
											    <tr>
											    	<td colspan="2" style="height: 70px;border-top: 0;background-color: #343a40;color: #fff;">이달의 근태통계</td>
											    </tr>
	                            				<tr>
	                            					<td style="height: 70px;">
		                            					<i class="fa fa-square" style="color: #2980b9;" ></i>
		                            					정상출근 일수
	                            					</td>
	                            					<td>${dataMap.attendenceList[0].nomalCnt }</td>
	                            				</tr>
	                            				<tr>
	                            					<td style="height: 70px;">
	                            						<i class="fa fa-square" style="color: #ccc;" ></i>
	                            						지각 일수
	                            					</td>
	                            					<td>${dataMap.attendenceList[0].lateCnt }</td>
	                            				</tr>
	                            				<tr>
	                            				<c:set value="${(dataMap.attendenceList[0].nomalCnt/(dataMap.attendenceList[0].nomalCnt + dataMap.attendenceList[0].lateCnt))*100 }" var="persentage" />
	                            					<td style="height: 70px;">정상출근률</td>
	                            					<td>
	                            					<c:if test="${(dataMap.attendenceList[0].nomalCnt + dataMap.attendenceList[0].lateCnt) ne 0}">
	                            						<fmt:formatNumber value="${persentage-(persentage%1)}" type="number"/>%
	                            					</c:if>
	                            					<c:if test="">
	                            						
	                            					</c:if>
	                            				</tr>
	                            			</tbody>
	                            		</table>
	                            	</div>
                            	</div>
                            	
                         	</div>
                           	<div class="card mb-4">
								<div class="header m-t-8" style="padding-bottom: 0px; ">
									<h2 style="font-family: S-CoreDream-6Bold">
										<span >
											<p style="display: inline-block;padding-bottom: 0; margin-bottom: 0;font-size: 1.3rem;">지각 사유 작성</p>
											<button type="button" class="btn btn-outline-light" id="hiddenFillBtn" onclick="presentationFill();" style="position:absolute;right:4em;top:0px;z-index:100;color:#ffffff">시연용버튼</button>
											<button class="btn btn-primary float-right" type="button" onclick="reasonSubmit_go();">제출</button>
											<br>
											<small style="font-family: S-CoreDream-4Regular;display: inline-block;">
												* 각 팀장 또는 부서장이 확인할 수 있습니다.
											</small>
											<br><br>
											<span >
												지각일 : <input id="lateDt" type="date" readonly="readonly" style="border: 0;">
											</span>
										</span>
									</h2>
								</div>
								<div class="body widget newsletter mt-2" style="padding-top: 5px; font-family: S-CoreDream-6Bold">
									<textarea id="reasonArea" class="form-control" rows="5" cols="30" placeholder="지각 사유 작성란" style="height: 310px;"></textarea>
								</div>
                           	</div>
                        </div>
                    </div>
                </div>
            </div>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/chart/easypiechart.js"></script>
<script>


$("li .active").removeClass("active");
$("#myList").addClass("active");


function inputReasonBox(obj){
	var attendDt = $(obj).find(".myAttendDt").text().trim();
	var reason = $(obj).find(".myReason").text().trim();
	
	$("#lateDt").val(attendDt);
	
	if(reason == '-'){
		reason = '';
	}
	if(reason){
		$("#reasonArea").val(reason);
	}else{
		$("#reasonArea").val('');
	}
}

function reasonSubmit_go(){
	var reasonArea = $("#reasonArea").val().trim();
	var lateDt = $("#lateDt").val();
	var attendenceVO = {}; 
	
	console.log(reasonArea);
	if(!reasonArea){
		alert("제출사유를 적어주세요.");
		return false;
	}
	$(".myAttendDt:contains('"+lateDt+"')").parent().find(".myReason").text(reasonArea);
	
	attendenceVO.empId = '${loginUser.empId}';
	attendenceVO.historyAttendTime = $(".myAttendDt:contains('"+lateDt+"')").parent().find(".myAttendDt").text().trim();
	attendenceVO.historyReason = reasonArea;
	
	console.log(attendenceVO);
	$.ajax({
		url:"modifyReason",
		type:'post',
		data:JSON.stringify(attendenceVO),
		processData:false,
		contentType:"application/json",
		success:function(data){
			console.log(data);
		}
	})
	
	
	
	
	alert("사유 제출 완료");
}


window.onload = function() {
		getAttendence();//해당 월 내용 가져오기
		showStaus();//페이지 켜질때 근무시간 계산시작하게하기
		getTime();
	   // 검색 조건 체크박스 설정
		if($('#inputSearchDt').val()!=""){
			$('#dateCheckBox').attr("checked",true);
			changeForm(document.getElementById('dateCheckBox'));
		}
		if($('#selectSearchState').val()!=""){
			$('#checkboxState').attr("checked",true);
			changeForm(document.getElementById('checkboxState'));
		}
	   
	   
	   paginationCSS(${paginationInfo.currentPageNo},
	           ${paginationInfo.firstPageNoOnPageList},
	           ${paginationInfo.lastPageNoOnPageList},
	           ${paginationInfo.totalPageCount});

}

function changeForm(obj){
   var searchCri = $(obj).attr('data');
   
   if($(obj).is(':checked')==true){
      $('.'+searchCri).css('display','');
   }else{
      $('.'+searchCri).css('display','none');
      $('.'+searchCri).val("");
   }
}

// 검색 및 페이지네이션
function searchList(pageNo){
   if(!pageNo){
      pageNo = 1;
   }
   var listForm = $('form[name="listForm"]');
$('input[name="searchAttendceVO.pageIndex"]').val(pageNo);
   listForm.submit();
}

function conditionReset() {
   $("#resetBtn").click();
   $('.myConditions').css('display','none');
   $("input:checkbox:checked").click();
   $("#inputSearchDt").val("");
}



</script>

<!-- 차트만드는 스크립트 -->
<script>
$('.chart1').easyPieChart({
    barColor: '#2980b9',  //차트가 그려질 색
    trackColor: '#ccc',  // 차트가 그려지는 트랙의 기본 배경색(chart1 의 회색부분)
    scaleColor: '#fff', // 차트 테두리에 그려지는 기준선 (chart2	의 테두리 선)
    lineCap: 'butt', // 차트 선의 모양 chart1 butt / chart2 round / chart3 square
    lineWidth: 30, // 차트 선의 두께
    size: 250, // 차트크기
    animate: 1000, // 그려지는 시간 
    onStart: $.noop,
    onStop: $.noop
  });
</script>
<script>
function setNowDate() {
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	var day = today.getDate();
	
	$("#searchYear").val(year);
	$("#searchMonth").val(month);
	searchList();
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

</script>

<script> 
/*근무 시간 입력*/
function insertStartWork(){
	  $.ajax({
          url : "<%=request.getContextPath()%>/attend/insertStartWork",
          type : "get",
          data : {loginUser : "000802JW0002"},
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


</script>

<script>
/*출근 누르면 출근 버튼 사라지게하기*/
function workingStaus(){
	  $.ajax({
          url : "<%=request.getContextPath()%>/attend/insertStartWork",
          type : "get",
          success : function (result) {hideWorkStartButton(); },
          error : function (data) { }
      });
}
function hideWorkStartButton() {
	$('#workStartButton').parent().remove();
	$('#workEndButton').removeClass('col-6');
	$('#workEndButton').parent().addClass('col-12');
	$('#workEndButton').css("width","232px");
}

/*퇴근시간 입력*/
function insertEndWork(){
// 	alert("time end");
	 $.ajax({
         url : "<%=request.getContextPath()%>/attend/insertEndWork",
         type : "get",
         data : {loginUser : "000802JW0002"},
         success : function (data) {
             alert("퇴근 시간이 입력되었습니다");
             location.reload();
         },
         error : function (data) {
             alert("실패");
         }
     });
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
// tellMonth();

/*다음 달을 화면에 출력*/
function nextMonth() {
	var statusMonth =document.getElementById( 'month' ).innerHTML;
	var statusYear =document.getElementById( 'year' ).innerHTML;
	statusMonth = parseInt(statusMonth)+1;	
	if (statusMonth == 13) {
		statusMonth = 1;
		statusYear = parseInt(statusYear)+1
	}
	
	$("#searchYear").val(statusYear);
	$("#searchMonth").val(statusMonth);
	
	searchList();
	
	$("#month").html(statusMonth);
	$("#year").html(statusYear);
	
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
	
	$("#searchYear").val(statusYear);
	$("#searchMonth").val(statusMonth);
	searchList();
	
	$("#month").html(statusMonth);
	$("#year").html(statusYear);
}

</script>

<script>
/*년과 월을 받아서 가공 및 넘겨주는 함수*/
function getAttendence() {
	var minMonth = document.getElementById( 'month' ).innerHTML;
	var maxMonth = parseInt(minMonth)+1;
	var minYear = document.getElementById( 'year' ).innerHTML;
	var maxYear = parseInt(minYear);
	
	if(maxMonth>12){
		maxMonth =1;
		maxYear = maxYear+1;  
	}else if (maxMonth<1) {
		maxMonth =12;
		maxYear = maxYear-1;  
	}
	
// 	alert(minMonth+"/"+maxMonth+" / "+minYear+" / "+maxYear);
	
/*해당 월의 모든 근태 리스트 가져오기*/
// 	$.ajax({
<%-- 	    url : "<%=request.getContextPath()%>/attend/mylist/data", --%>
// 	    type : "POST",
// 	    data : {minMonth : minMonth, maxMonth : maxMonth , minYear : minYear, maxYear : maxYear },
// 	    success : function (result) {
// 	    	var html = jQuery('<div>').html(result);
// 	    	var contents = html.find("div#indexListAjax").html();
// 	    	$("#tablAttendence").html(contents); 
// 	    },
// 	    error : function (data) {
// 	        alert("실패");
// 	    }
// 	});

}
</script>
<script>//시연용
function presentationFill(){
	$('#reasonArea').val('출근길 교통체증으로 인해 지각했습니다. 죄송합니다.');
}
</script>