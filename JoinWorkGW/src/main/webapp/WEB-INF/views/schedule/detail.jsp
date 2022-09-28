<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/fullcalendar.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/bootstrap.min.css">
    <link rel="stylesheet" href='<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/select2.min.css' />
    <link rel="stylesheet" href='<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/bootstrap-datetimepicker.min.css' />

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/fullcalendar/css/main.css">
<title>일정 상세조회</title>
<style>
#main-content{
	margin: 0px;
}
*, ::after, ::before{
	box-sizing: border-box;
}
.container-fluid-header, .container-fluid-footer{
	display: flex;
	justify-content: space-between;
	padding-top: 15px;
}
body {
	padding: 0px 30px 30px 30px;
}
.form-header > div {
	margin-top: 20px;
}
.col-xs-12 {
	padding: 5px;
	width: 100%;
}
div#main-content{
    border: solid 1px rgba(0,0,0,.03);
    border-radius: 1%;
    background-color: #ffffff;
    padding: 0px 10px 10px;
    margin-top: 20px;
}
body, div#main-content,.container-fluid, form{
    max-width: 49em;
}
body{
    padding: 0px 30px 30px 30px;
    background-color: rgba(0,0,0,.03);
}
.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control{
	background-color: #ffffff;
}
.form-control{
	width: 100%;
	max-width: 49em;
	
}

.btn-info {
	color: #fff;
    background-color: #17a2b8;
    border-color: #17a2b8;
}
.btn-info:hover {
    color: #fff;
    background-color: #138496;
    border-color: #117a8b;
}

</style>
<body>
<div id="main-content" style="font-family: S-CoreDream-4Regular">
	<div class="container-fluid">
		<div class="">
			<div class="form-header container-fluid-header" style="font-family: S-CoreDream-6Bold">
				<h3 class="form-title">일정 상세조회</h3>
				<div>
					<c:if test="${loginUser.empId eq schedule.username }">
						<button type="button" class="btn btn-info" onclick="javascript:location.href='<%=request.getContextPath() %>/schedule/modifyForm?scheduleId=${param.scheduleId }';">수정</button>
						<button type="button" class="btn btn-danger" onclick="removeSchedule();">삭제</button>
					</c:if>
					<button type="button" class="btn btn-secondary" onclick="javascript:window.close();" style="border: 1px solid gray">닫기</button>
				</div>
			</div>
			<hr>				
			<!-- 로그인 사용자로 대체할 것 -->
			<input type="hidden" id="shceduleId" value="${schedule._id}"/>
			<c:if test="${schedule.important == 'true'}">
				<div class="row">
					<div class="col-xs-12">
						<label class="col-xs-4" style="color: red; font-size: 1.2em;">💥 중요일정 💥</label>
					</div>
				</div>
			</c:if>
			<div class="row">
				<div class="col-xs-12">
				<label class="col-xs-4" for="edit-title">일정명</label>
				<input class="form-control" type="text" name="edit-title" id="edit-title" required="required" value='${schedule.title }' readonly="true"/>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-start">시작일시</label>
					<input class="form-control" type="text" name="edit-start" id="edit-start" value='${schedule.start }' readonly="true"/>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-end">종료일시</label>
					<input class="form-control" type="text" name="edit-end" id="edit-end" value='${schedule.end }' readonly="true"/>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-location">장소</label>
					<input class="form-control" type="text" name="edit-location" id="edit-location" value='${schedule.location }' readonly="true"/>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-type">일정 그룹</label>
					<input class="form-control" type="text" name="edit-type" id="edit-type" readonly="true" value="${schedule.type}"/>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<span class="col-xs-4" for="edit-desc" style="font-weight: 600;">설명</span>
					<div class="form-control" id="edit-desc" style="margin: 25px 0;">${schedule.description }</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- fullCalendar 기본 js -->
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/moment.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/fullcalendar.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/ko.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/select2.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/bootstrap-datetimepicker.min.js"></script>

<!-- 공통 js -->
<script src="<%=request.getContextPath() %>/resources/js/common.js"></script>

<!-- fullCalendar 커스텀 js -->
<script src="<%=request.getContextPath() %>/resources/fullcalendar/js/main.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/js/addEvent.js"></script>
<script src="<%=request.getContextPath() %>/resources/fullcalendar/js/etcSetting.js"></script>

<script>
//삭제
function removeSchedule(){
	var fixedSchduleId = $('#shceduleId').val();
	console.log(fixedSchduleId);
	if(confirm('${schedule.title } 일정을 삭제하시겠습니까?')){
		var sendData = {
				scheduleId:fixedSchduleId		
		}
		console.log(sendData);
		$.ajax({
			type:"post"
	    	,url:"<%=request.getContextPath()%>/schedule/remove" 
	    	,data:sendData
	    	,success:function(response){
	    		console.log(response);
				if(response > 0){
					alert("일정이 삭제되었습니다.");
					if(window.opener)  window.opener.location.reload(true);
					window.close();
				}
	    	}
	    	,error:function(request, status, error){
	    		console.log("error 발생 >> " + request +", "+ status+", "+error);
	    	}	
		
		});
	}
}
</script>
</body>