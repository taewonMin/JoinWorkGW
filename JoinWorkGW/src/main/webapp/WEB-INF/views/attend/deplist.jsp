<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<jsp:include page="sidebar.jsp" />

<body>
<!-- 근태 목록 -->
<a id="viewDeptModal" href="#deptModal" data-toggle="modal" data-target="#deptModal" style="display: none;"></a>
            <div id="main-content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold;">
                            <h2 class="" style="font-size: 2rem;" >
                            	<i class="fa icon-clock"></i>&nbsp부서 근태 관리 &nbsp<small style="font-size: 60%;">${dataMap.deptName }</small>
                            </h2>
                            <hr>
                        </div>
                    </div>
                    <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
                        <div class="col-8" style="padding-right: 0px;" id="centerView">
                        	<form:form commandName="attendenceFormVO" id="listForm" name="listForm"> 
							<form:hidden path="searchAttendceVO.sysDate" id="sysDate" />
                            <div class="card mb-4" >
									<div class="row clearfix">
										<div class="col-7 rightView" style="height:140px;">
											<!-- 검색 조건 설정 -->
				                           <h5 style="display:inline-block; font-weight: bold;margin-left: 20px;margin-top: 12px;">
				                           		검색 조건
				                           </h5>
				                           <br>
				                           <div class="row clearfix">
				                               <div class="col-12">
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
					                           </div>
					                           <div class="col-12">
						                           <div class="input-group date searchCri searchDt selectDt myConditions" data-date-autoclose="true" data-provide="datepicker" style="margin-left: 20px;font-size:1.2em;width:150px;float:left;">
						                                <form:input path="searchAttendceVO.searchDt" id="inputSearchDt" type="text" class="form-control" placeholder="날짜 선택" readonly="true" />
						                                <div class="input-group-append">                                            
						                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
						                                </div>
						                            </div>
						                           <form:select path="searchAttendceVO.searchState" id="selectSearchState" class="form-control selectState myConditions" style="width:120px;font-size: 1.2em;float:left;margin-left:20px;">
						                            <form:option value="">상태선택</form:option>
						                            <form:option value="정상출근">정상출근</form:option>
						                            <form:option value="지각">지각</form:option>
						                          </form:select>
						                          <form:select path="searchAttendceVO.searchCondition" class="form-control selectSearch" style="margin-left: 20px;width:110px;font-size: 1.2em;float:left;">
						                            <form:option value="on">전체</form:option>
						                            <form:option value="o">직책</form:option>
						                            <form:option value="n">사원명</form:option>
						                          </form:select>
						                          <div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;margin-left: 20px;">
					                                 <form:input path="searchAttendceVO.searchKeyword" class="form-control" placeholder="Search here..." type="text" style="width: 143px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchList);"/>
					                                 <button type="button" class="btn btn-default" onclick="searchList();"><i class="icon-magnifier"></i></button>
					                              </div>
					                          </div>
					                       </div>
				                          
			                           </div>
			                           
			                           
			                           
			                           <div class="col-5" style="padding-top: 13px;" id="changeCol-5">
			                           	   <select id="changeDayAndMonth" onchange="changeDayMonth(this);" class="form-control float-right" style="width: 130px;display: inline;margin-right: 20px;">
				                           		<option value="일별">일별 리스트</option>
				                           		<option value="월별">월별 리스트</option>
				                           </select>
			                           	   <div id="stSet" class="float-right"  style="display: none;font-size: 1.2rem;margin-right: 20px;margin-top: 5px;">
				                           	   <i class="icon-check" style="color: green;"></i>&nbsp정상출근&nbsp&nbsp
				                           	   <i class="icon-check" style="color: red;"></i>&nbsp지각&nbsp&nbsp
				                           	   <i class="icon-close" style="color: black;"></i>&nbsp결근&nbsp&nbsp
				                           	   <i class="icon-close" style="color: yellow;"></i>&nbsp외근&nbsp&nbsp
			                           	   </div>
				                           <div class="form-group rightView" style="float:left; margin: 0;">
				                           		<div class="text-end " style="font-family: S-CoreDream-6Bold">
				                           			<div class="row">
				                           				<div class="col-12" style="padding-left: 23px;">
					                                		<button class="mb-0 mt-1 btn btn-default" onclick="setNowDate();">현재 날짜로</button>
					                                	</div>
					                                	<div class="col-12">
							                                <div class="d-xl-inline-block d-none mx-2 text-start" style="display: inline-block;">
							                                    <div class="float-start me-2" >
							                                        <h4 class="mb-0 mt-1 "id="myDt" value="<fmt:formatDate value="${searchAttendceVO.sysDate }" pattern="yyyy/MM/dd"/>" style="display: inline-block;">
							                                        	<fmt:formatDate value="${searchAttendceVO.sysDate }" pattern="yyyy년MM월dd일"/>
							                                        </h4>
							                                    </div>
							                                    <span id="bh_visits" class="float-end"></span>
							                                </div>
							                             </div>
						                             </div>
					                            </div>
				                        	</div>
			                           
			                           </div>
			                           
			                        </div>
									
								<!-- 설정된 검색 조건 입력 폼 표시 -->
                           <div>
                            
                        	
                           </div>	
                                <div class="card-body" id="dayView" style="font-family: S-CoreDream-6Bold">
                                   <div id="indexListAjax">

									 <table id="holidays_list" class="table table-hover">
										<thead class="thead-dark">
										    <tr>
										        <th>사원명</th>
										        <th>출근일</th>
										        <th>퇴근일</th>
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
															<td class="myAttendDt" style="display: none;">
																<fmt:formatDate value="${attendence.historyAttendTime }" pattern="yyyy-MM-dd"/>
															</td>
															<td>
																${attendence.empName }&nbsp${attendence.officialName }
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
																	 <span class="myReason">-</span>
																	</c:when>
																	<c:otherwise>
																		<span class="myReason">${attendence.historyReason}</span>
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
								
								<!-- 월별조회 시작 -->
                                <div class="card-body" id="tablAttendence" style="display: none;">
	                        	</div>
                                
                                
                            <!-- Pagination -->
	                           <nav class="rightView" aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
	                               <ul class="pagination" style="display: inline-block;">
	                                     <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchList" />
	                               </ul>
	                           </nav>
                            <form:hidden path="searchAttendceVO.pageIndex" />
                            </form:form>
                            </div>
                        </div>
                        
                        
						<!-- 통계시작 -->
                        <div class="col-4 rightView" >
                            <div class="card" style="margin-bottom: 13px;">
                            	<div class="row clearfix">
	                            	<div class="col-12" style="font-family: S-CoreDream-6Bold;">
	                            		<table id="holidays_list" class="table table-hover">
	                            			<tbody>
											    <tr>
											    	<td  style="height: 70px;border-top: 0;background-color: #343a40;color: #fff;border-radius: 0.25rem 0 0 0.25rem;">
											    		<span>부서 근태통계</span>
											    	</td>
											    	<td  style="height: 70px;border-top: 0;background-color: #343a40;color: #fff;border-radius: 0 0.25rem 0.25rem 0;margin-top: 23px;">
											    		<span class="float-right">단위(명)</span>
											    	</td>
											    </tr>
	                            				<tr onclick="deptChecked('정상');" style="cursor: pointer;">
	                            					<td style="height: 70px; width: 25%;">
		                            					<i class="fa fa-square" style="color: #2980b9;" ></i>
		                            					정상출근자
	                            					</td>
	                            					<td>
		                            					<div class="progress" >
					                                    	<div class="progress-bar" role="progressbar" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100" style="width: ${dataMap.nomalCnt/dataMap.deptTotCnt*100}%; background-color: #2980b9;">
					                                    		<span>${dataMap.nomalCnt }</span>
					                                    	</div>
					                                    </div>
	                            					
	                            						
	                            					</td>
	                            				</tr>
	                            				<tr onclick="deptChecked('지각');" style="cursor: pointer;" >
	                            					<td style="height: 70px;">
	                            						<i class="fa fa-square" style="color: red;" ></i>
	                            							지각자
	                            					</td>
	                            					<td>
		                            					 <div class="progress" >
					                                    	<div class="progress-bar" role="progressbar" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100" style="width: ${dataMap.lateCnt/dataMap.deptTotCnt*100}%; background-color: red;">
					                                    		<span>${dataMap.lateCnt }</span>
					                                    	</div>
					                                    </div>
	                            						
	                            					</td>
	                            				</tr>
	                            				<tr onclick="deptChecked('기타');" style="cursor: pointer;" >
	                            					<td style="height: 70px;">
	                            						<i class="fa fa-square" style="color: #ccc;" ></i>
	                            							기타
	                            					</td>
	                            					<td>
		                            					 <div class="progress" >
					                                    	<div class="progress-bar" role="progressbar" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100" style="width: ${(dataMap.deptTotCnt-dataMap.nomalCnt-dataMap.lateCnt)/dataMap.deptTotCnt*100}%; background-color: #ccc;">
					                                    		<span>${dataMap.deptTotCnt - dataMap.nomalCnt - dataMap.lateCnt }</span>
					                                    	</div>
					                                    </div>
	                            					</td>
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
											<p style="display: inline-block;padding-bottom: 0; margin-bottom: 0;font-size: 1.3rem;">지각 사유</p>
											<br>
											<small style="font-family: S-CoreDream-4Regular;display: inline-block;">
											</small>
											<br><br>
											<span >
												지각일 : <input id="lateDt" type="date" readonly="readonly" style="border: 0;">
											</span>
										</span>
									</h2>
								</div>
								<div class="body widget newsletter mt-2" style="padding-top: 5px; font-family: S-CoreDream-6Bold">
									<textarea id="reasonArea" class="form-control" rows="5" cols="30" placeholder="지각 사유란" style="height: 310px;" disabled="disabled"></textarea>
								</div>
                           	</div>
                        </div>
                    </div>
                </div>
            </div>
            
<!--부서상세 모달창 -->
<div class="modal fade" id="deptModal" tabindex="-1" role="dialog" style="font-family: InfinitySans-RegularA1">
	<div class="modal-dialog" role="document">
	    <div class="modal-content" style="width:600px; height: 500px;">
	        	<div class="modal-header" style="display: block; text-align: center;">
	            	<h4 class="title" id="defaultModalLabel">부서 상세조회</h4>
	        	</div>
		        <div class="modal-body" style="overflow-y: scroll;">
					<table class="table table-hover js-basic-example table-custom m-b-0 c_list">
						<thead class="thead-dark">
						    <tr>
						        <th>이름</th>
						        <th>직급</th>
						        <th>부서/팀</th>
						        <th>연락처</th>
						    </tr>
						</thead>
						<tbody class="myAppendTbody">
							<!-- 부서원들 정보 들어갈자리 -->
							<c:forEach items="${dataMap.attendenceNopagingList }" var="attendence">
								<c:choose>
									<c:when test="${attendence.attendStName eq '정상출근' }"><tr class="nomal deptView" style="display: none;"></c:when>
									<c:when test="${attendence.attendStName eq '지각' }"><tr class="late deptView" style="display: none;"></c:when>
									<c:otherwise>
									<tr class="other deptView" style="display: none;">
									</c:otherwise>
								</c:choose>
								
								   <td>${attendence.empName}</td>
								   <td>${attendence.officialName}</td>
								   <td>${dataMap.deptName}</td>
								   <td>${attendence.empHp}</td>
								</tr>
							</c:forEach>
						</tbody>
		 			</table>
		       </div>
	          <div class="modal-footer">
	              <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	          </div>
	      </div>
	</div>
</div>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<!-- 부서근태 전용 -->
<script>
$("li .active").removeClass("active");
$("#deptList").addClass("active");



function changeDayMonth(obj){
	var value = $("#changeDayAndMonth option:selected").val();
	
	if(value === '일별'){
		$("#dayView").css("display","block");
		$("#tablAttendence").css("display","none");
		$("#centerView").removeClass("col-12");
		$("#centerView").addClass("col-8");
		$(".rightView").css("display","block");
		$("#changeCol-5").removeClass("col-12");
		$("#changeCol-5").addClass("col-5");
		$("#stSet").css("display","none");
	}else if(value === '월별'){
		$("#dayView").css("display","none");
		$("#tablAttendence").css("display","block");
		$("#centerView").removeClass("col-8");
		$("#centerView").addClass("col-12");
		$(".rightView").css("display","none");
		$("#changeCol-5").removeClass("col-5");
		$("#changeCol-5").addClass("col-12");
		$("#stSet").css("display","block");
	}
		
}

function deptChecked(st){//st= {정상,지각,기타}
	$(".deptView").css("display",'none');
	if(st == '정상'){
		$(".nomal").css("display","");
	}else if(st == '지각'){
		$(".late").css("display","");
		
	}else{
		$(".other").css("display","");
	}
	
	
	$("#viewDeptModal").click();
}

</script>


<script>
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

// function settingSysDt(){
// 	var today = new Date();
// 	var year = today.getFullYear();
// 	var month = ("0"+(today.getMonth()+1)).slice(-2);
// 	var day = ("0"+today.getDate()).slice(-2);
// 	$("#inputSearchDt").val(month+"/"+day+"/"+year);
// }

// 검색 및 페이지네이션
function searchList(pageNo){
   if(!pageNo){
      pageNo = 1;
   }
   
   if(!$("#inputSearchDt").val()){
		var today = new Date();
		var year = today.getFullYear();
		var month = ("0"+(today.getMonth()+1)).slice(-2);
		var day = ("0"+today.getDate()).slice(-2);
		$("#inputSearchDt").val(month+"/"+day+"/"+year);
   }
   $("#sysDate").val($("#inputSearchDt").val());
   
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

</script>
<script>

function setNowDate() {
	var today = new Date();
	var year = today.getFullYear();
	var month = ("0"+(today.getMonth()+1)).slice(-2);
	var day = ("0"+today.getDate()).slice(-2);
	$("#inputSearchDt").val(month+"/"+day+"/"+year);
	
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
          success : function (result) {hideWorkStartButton();},
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



</script>

<script>
/*년과 월을 받아서 가공 및 넘겨주는 함수*/
function getAttendence() {
// 	var minMonth = document.getElementById( 'month' ).innerHTML;
// 	var maxMonth = parseInt(minMonth)+1;
// 	var minYear = document.getElementById( 'year' ).innerHTML;
// 	var maxYear = parseInt(minYear);
	
// 	if(maxMonth>12){
// 		maxMonth =1;
// 		maxYear = maxYear+1;  
// 	}else if (maxMonth<1) {
// 		maxMonth =12;
// 		maxYear = maxYear-1;  
// 	}
	
	$.ajax({
	    url : "<%=request.getContextPath()%>/attend/deptlist/data",
	    type : "POST",
	    data : {month : "5" , year : "2021"},
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
</script>