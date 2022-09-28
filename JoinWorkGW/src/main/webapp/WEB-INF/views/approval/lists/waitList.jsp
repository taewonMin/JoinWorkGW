<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<body>
<%@ include file="../include/sidebar.jsp" %>
<div id="main-content">
	<div class="container-fluid" style="font-family: S-CoreDream-6Bold"">
		<!-- 메인 content 넣는 곳 -->
	    <div class="row clearfix">
                <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
                    <h2>결재 대기 문서</h2>
                    <hr>
                </div>
                <c:if test="${empty approvalList }">
	                <div class="col-12" style="font-family:S-CoreDream-6Bold" >
	                    <h5>결재 대기 문서가 없습니다.</h5>
	                </div>
                </c:if>
                
                <c:forEach items="${approvalList }" var="doc">
	                <div class="col-lg-3 col-md-12" >
	                    <div class="card myWithCard" style="cursor: pointer;" onclick='OpenWindow("<%=request.getContextPath()%>/approval/waitDocDetail?docId="+${doc.docId}+"", "결재문서" ,1000,900);' >
	                    <div class="row clearfix">
	                    	
		                        <div class="body" style="margin-left: 12px; ">
		                            <span class="badge badge-primary" style="margin-bottom: 8px; font-family:S-CoreDream-4Regular">결재 대기중</span>
		                            <span class="differentTime"></span>
		                            <div class="pricing-option" style="margin-left: 4px;">
		                            	<div class=waitListTitle style="font-family: S-CoreDream-6Bold">
		                                <h6 style="padding-top: 5px; ">${doc.approvalTitle}&nbsp&nbsp
		                                	<c:if test="${doc.attachCnt ne 0}">
		                                		<i class="fa fa-file-o fa-2x text-info" style="font-size: 18px;"></i>
		                                		<span>${doc.attachCnt}</span>
		                                	</c:if>
		                                </h6>
		                                </div>
		                                
		                                <div class="m-t-30 m-b-30" style="font-family:S-CoreDream-4Regular">
		                                    <h6>기안자 : ${doc.empDrafterName}&nbsp${doc.empDrafterOfficial} </h6>
		                                    <h6>기안일 : <span class="recommandDt" value="<fmt:formatDate value="${doc.approvalRecommandDt}" pattern="yyyy-MM-dd HH:mm:ss"/>"><fmt:formatDate value="${doc.approvalRecommandDt}" pattern="yyyy-MM-dd"/></span></h6>
		                                    <h6>결재양식 : ${doc.formName} </h6>
		                                </div>
		                            </div>
		                        </div>
		                     
		                   </div> 
	                    </div>
	                </div>
		  		</c:forEach>
		  		
		  </div>                 
	                    
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>

<script>
$(document).on("mouseover",".myWithCard",function(){
	$(this).css("opacity","0.5");
});
$(document).on("mouseout",".myWithCard",function(){
	$(this).css("opacity","1");
});


</script>

<!-- 시간관련 스크립트  -->
<script>

timeAlarm();
function timeAlarm() {
	var recommandDtLength = $(".recommandDt").length;
	for(var i = 0; i < recommandDtLength; i++){
		var tempDt = new Date($(".recommandDt").eq(i).attr("value"));
		var _differentTime = $(".recommandDt").eq(i).parent().parent().parent().parent().find(".differentTime");
		
		getTimeDefferFromCurrent(tempDt, _differentTime);
		
	}
}

function getTimeDefferFromCurrent(tempDt, target){
	var year = tempDt.getFullYear();
	var month = tempDt.getMonth()
	var date = tempDt.getDate();
	var hours = tempDt.getHours();
	var minutes = tempDt.getMinutes();
	var seconds = tempDt.getSeconds();
	
	recommandDt = new Date(year,month,date,hours,minutes,seconds,0);
	var currentDt = new Date();
	
	//차이 계산
	var differentDt = ( currentDt.getTime() - recommandDt.getTime() );
	
	var differentDay = differentDt/(24*60*60*1000);
	var differentHours = differentDt/(60*60*1000);
	var differentMinutes = differentDt/(60*1000);

	var fiveMinutesByMillisecond = (30*60*1000);
	var oneHourByMillisecond = (60*60*1000);
	var oneDayByMillisecond = (1*24*60*60*1000);

	
	if(differentDt < fiveMinutesByMillisecond){
// 		alert("5분 전");
		target.html("<span class='badge badge-danger'>방금 온 결재문서</span>");
		return;
		
	}
	
	if(differentDt < oneHourByMillisecond){
// 		alert("1시간 전");
		target.html(Math.floor(differentMinutes)+" 분 전");
		return;
		
	}
	
	if(differentDt < oneDayByMillisecond){
// 		alert("하루 전");
		target.html(Math.floor(differentHours)+" 시간 전");
		return;
	} 
	target.html(Math.floor(differentDay)+" 일 전");
}


</script>



</body>