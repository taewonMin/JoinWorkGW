<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/fullcalendar.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/bootstrap.min.css">
    <link rel="stylesheet" href='<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/select2.min.css' />
    <link rel="stylesheet" href='<%=request.getContextPath() %>/resources/fullcalendar/vendor/css/bootstrap-datetimepicker.min.css' />

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<%--     <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/fullcalendar/css/main.css"> --%>
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
/* body { */
/* 	padding: 0px 30px 30px 30px; */
/* } */
.form-header > div {
	margin-top: 20px;
}
.col-xs-12 {
	padding: 5px;
}
div#main-content{
    border: solid 1px rgba(0,0,0,.03);
    border-radius: 1%;
    background-color: #ffffff;
    padding: 0px 10px 10px;
    margin-top: 20px;
}
body{
    padding: 0px 30px 30px 30px;
    background-color: rgba(0,0,0,.03);
}
.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control{
	background-color: #ffffff;
}
#edit-participater{
	cursor: pointer;
}
</style>
<title>일정 등록</title>    
<body>
<div id="main-content">
	<div class="container-fluid"  style="font-family: S-CoreDream-4Regular">
		<form role="form" action="<%=request.getContextPath() %>/schedule/regist" method="post">
			<input type="hidden" name="saveToken" value="${scheduleCommand.saveToken }">
			<div class="form-header container-fluid-header">
				<h3 class="form-title"  style="font-family: S-CoreDream-6Bold">회의실 공지 등록</h3>
				<div>
					<button type="button" class="btn btn-primary" id="save-event" onclick="scheduleSave();">등록</button>
					<button type="button" class="btn btn-outline-secondary" onclick="javascript:window.close();">취소</button>
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-title">공지명</label>
					<input class="form-control" type="text" name="title" id="edit-title" required="required" />
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-start">시작일시</label>
					<c:if test="${ empty sendStart}">
						<input class="form-control" type="text" name="start" id="edit-start" />
					</c:if>
					<c:if test="${ !empty sendStart}">
						<input class="form-control" type="text" name="start" id="edit-start" value="${sendStart}" />
					</c:if>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-end">종료일시</label>
					<c:if test="${ empty sendEnd}">
						<input class="form-control" type="text" name="end" id="edit-end" />
					</c:if>
					<c:if test="${ not empty sendEnd}">
						<input class="form-control" type="text" name="end" id="edit-end" value="${sendEnd}" />
					</c:if>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-location">장소</label>
					<input class="form-control" type="text" name="location" id="edit-location" />
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-type">일정 그룹</label>
					<select class="form-control" type="text" name="type" id="edit-type" onchange="showDeptSelect();">
						<option value="S01">개인일정</option>
						<option value="S02">회사일정</option>
						<option value="S03">부서일정</option>
						<option value="S04">팀일정</option>
					</select>
				</div>
			</div>
			<div class="row" id="participaterDiv" style="display: none;">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-participater">참석자</label>
					<input class="form-control" type="text" name="participater"  id="edit-participater"  placeholder="클릭하여 참석자를 추가하세요."readonly="true" onclick="OpenWindow('selectParticipater','참석자선택','800','700');"/>
					<div class="form-control"  id="reception" style="display:none;">
					<!-- 추가한 참석자가 버튼으로 들어올 자리 -->
					</div>
				</div>
			</div>
			<div class="row" id="deptSelect" style="display: none;">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-type">부서</label>
					<input class="form-control" type="text" name="deptName"  id="edit-deptName" readonly="true" value="${deptList[0].deptName}"/>
					<input class="form-control" type="text" name="deptId"  id="edit-deptId" readonly="true" value="${deptList[0].deptId}" style="display: none;"/>
				</div>
			</div>
			<div class="row" id="teamSelect" style="display: none;">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-type">팀</label>
					<select class="form-control" type="text" name="teamId" id="edit-teamId">
						<c:choose>
							<c:when test="${teamList[0].deptId != null }">
								<c:forEach items="${teamList }" var="team">
									<option value="${team.deptId}">${team.deptName}</option>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<option value="">소속된 팀이 없습니다.</option>
							</c:otherwise>
						</c:choose>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-desc">설명</label>
					<textarea rows="4" cols="50" class="form-control" name="description" id="edit-desc"></textarea>
				</div>
			</div>
		</form>
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

</body>
<script>

function scheduleSave(){
	
	var saveToken = $('input[name="saveToken"]').val();
	console.log(saveToken);
	var selectGroup = $('#edit-type option:selected').val();
	
	var username = $('#scheduleWriterId');
	var formTitle = $('.form-title');
	var editTitle = $('#edit-title');
	var editStart = $('#edit-start');
	var editEnd = $('#edit-end');
	//------ 추가사항
	var editLocation = $('#edit-location');
	var editParticipater = $('#edit-participater'); // 배열
	var editDeptId = $('#edit-deptId');
	var editTeamId = $('#edit-teamId');
	//------ 추가사항
	var editType = $('#edit-type');
	var editColor = $('#edit-color');
	var editDesc = $('#edit-desc');
	
	//console.log(editImportant.val());
	
//     var reqStartDate = "${sendStart}";
//     var reqEndDate = "${sendEnd}";

	var editStart = $('#edit-start').val();
	var editEnd = $('#edit-end').val();
	
	console.log("포맷팅 전 >> " + editStart + " ~ " + editEnd);
	
// 	editStart = moment(editStart).format('YYYY-MM-DDTHH:mm');
// 	editEnd = moment(editEnd).format('YYYY-MM-DDTHH:mm');
	
// 	console.log("포맷팅 후 >> " + editStart + " ~ " + editEnd);
	
    
    var eventData = {
            title: editTitle.val()
           ,start: editStart
           ,end: editEnd
           ,important: false
           ,location: editLocation.val()
           ,participater: editParticipater.val()
           ,description: editDesc.val()
           ,type: $('#edit-type option:selected').val()
           ,username: username.val()
           ,backgroundColor: editColor.val()
           ,textColor: '#ffffff'
           ,deptId:editDeptId.val()
       	   ,teamId:editTeamId.val()
       	   ,saveToken:saveToken
	};
       
	
//     console.log(reqStartDate +" ~ " + reqEndDate +" 까지");
    
    if (editStart > editEnd) {
        alert('끝나는 날짜가 앞설 수 없습니다.');
        return false;
    }

    if (eventData.title === '') {
        alert('일정명은 필수입니다.');
        return false;
    }
    
    if(selectGroup == 'S03'){
    	if($('#edit-deptId option:selected').text() == '-부서 선택-'){
    		alert('부서일정 등록 시 부서 선택은 필수입니다.');
    		return false;
    	}
    }else if(selectGroup == 'S04'){
    	if($('#edit-teamId option:selected').text() == '-팀 선택-'){
    		alert('팀일정 등록 시 팀 선택은 필수입니다.');
    		return false;
    	}else if($('#edit-teamId option:selected').text() == '소속된 팀이 없습니다.'){
    		alert('소속팀이 없으면 팀일정 등록이 불가합니다.');
    		$('#deptSelect').css('display','none');
    		$('#teamSelect').css('display','none');
    		$('#edit-type').val('S01').focus();
    		return false;
    	}
    }
    
    if(editImportant.is(':checked')){
        eventData.important = true;
    }
    
    console.dir(JSON.stringify(eventData));
    
    //새로운 일정 저장
    $.ajax({
        type: "post"
       ,url: "<%=request.getContextPath()%>/schedule/regist"
       ,data: JSON.stringify(eventData)
       ,dataType:"json"
       ,contentType:"application/json;charset=utf-8"
       ,success: function () {
		
		
   });
    
}



</script>
