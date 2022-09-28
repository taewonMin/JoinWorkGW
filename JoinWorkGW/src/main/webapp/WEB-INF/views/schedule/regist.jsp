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
body, div#main-content,.container-fluid, form{
    max-width: 49em;
}
.col-xs-12{
    width: 100%;
    max-width: 49em;
}
.form-control{
	width: 100%;
	
}
.hiddenFillBtn:hover{ background-color: #ffffff;}
</style>
<title>일정 등록</title>    
<body>
<div id="main-content">
	<div class="container-fluid"  style="font-family: S-CoreDream-4Regular">
		<form role="form" action="<%=request.getContextPath() %>/schedule/regist" method="post">
			<input type="hidden" name="saveToken" value="${scheduleCommand.saveToken }">
			<div class="form-header container-fluid-header">
				<h3 class="form-title"  style="font-family: S-CoreDream-6Bold">새 일정 등록</h3>
				<div>
					<button type="button" class="btn btn-outline-light hiddenFillBtn"  onclick="presentationFill_2();" style="position:absolute;right:17em;top:35px;color:#ffffff">시연용버튼 2</button>
					<button type="button" class="btn btn-outline-light hiddenFillBtn"  onclick="presentationFill();" style="position:absolute;right:140px;top:35px;color:#ffffff">시연용버튼</button>
					<button type="button" class="btn btn-primary" id="save-event" onclick="scheduleSave();">등록</button>
					<button type="button" class="btn btn-secondary" onclick="javascript:window.close();" style="border: 1px solid gray">취소</button>
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col-xs-12" style="margin: 0px 5px;">
					<input id="edit-important" type="checkbox" class="float-left" style="width: 25px; height: 25px;">
					<label class="col-xs-4" for="edit-important" style="padding: 7px 15px 0px;" >중요일정 설정</label>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					<label class="col-xs-4" for="edit-title">일정명</label>
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
						<c:if test='${loginUser.authId eq "a03" }'>
							<option value="S02">회사일정</option>
						</c:if>
						<c:if test='${loginUser.authId eq "a02" or loginUser.authId eq "a03"}'>
							<option value="S03">부서일정</option>
							<option value="S04">팀일정</option>
						</c:if>
					</select>
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
getContextPath('<%=request.getContextPath()%>');

function showDeptSelect(){
	var selectGroup = $('#edit-type option:selected').val();
	var loginUserDeptId = "${loginUser.deptId}";
	var loginUserTeamId = "${loginUser.teamId}";
	if(selectGroup == 'S03'){ // 부서
		$('#teamSelect').css('display','none');
		$('#deptSelect').css('display','');
		$('#edit-teamId').val("");
	}else if(selectGroup == 'S04'){ // 팀
		$('#deptSelect').css('display','none');
		$('#teamSelect').css('display','');
		$('#edit-deptId').val("");
	}else{
		$('#deptSelect').css('display','none');
		$('#teamSelect').css('display','none');
		$('#edit-teamId').val("");
		$('#edit-deptId').val("");
	}
}


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
	var editImportant = $('#edit-important');
	var editLocation = $('#edit-location');
	var editDeptId = $('#edit-deptId');
	var editTeamId = $('#edit-teamId');
	//------ 추가사항
	var editType = $('#edit-type');
	var editColor = $('#edit-color');
	var editDesc = $('#edit-desc');
	
	var editStart = $('#edit-start').val();
	var editEnd = $('#edit-end').val();
	
	
    
    var eventData = {
            title: editTitle.val()
           ,start: editStart
           ,end: editEnd
           ,important: false
           ,location: editLocation.val()
           ,description: editDesc.val()
           ,type: $('#edit-type option:selected').val()
           ,username: username.val()
           ,backgroundColor: editColor.val()
           ,textColor: '#ffffff'
           ,deptId:editDeptId.val()
       	   ,teamId:editTeamId.val()
       	   ,saveToken:saveToken
	};
       
	
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
    console.log(selectGroup + " , " + editTeamId.val());
    
    //새로운 일정 저장
    $.ajax({
        type: "post"
       ,url: "<%=request.getContextPath()%>/schedule/regist"
       ,data: JSON.stringify(eventData)
       ,dataType:"json"
       ,contentType:"application/json;charset=utf-8"
       ,success: function (response) {
			if(selectGroup == 'S02'){
				$(response.empList).each(function(index, item){
					var empId = item.empId;
					(function(index, item){
						sendMessage('${pageContext.request.contextPath}',
									empId,
									'새로운 회사 일정이 등록되었습니다. 확인해주세요.',
									editTitle.val(),
									'${pageContext.request.contextPath}/schedule/detail?scheduleId='+response.scheduleId,
									'일정관리');
					})(index, item);
				});
			}else if(selectGroup == 'S03'){
				$(response.empList).each(function(index, item){
					var empId = item.empId;
					(function(index, item){
						sendMessage('${pageContext.request.contextPath}',
									empId,
									'새로운 부서 일정이 등록되었습니다. 확인해주세요.',
									editTitle.val(),
									'${pageContext.request.contextPath}/schedule/detail?scheduleId='+response.scheduleId,
									'일정관리');
					})(index, item);
				});
			}else if(selectGroup == 'S04'){
				$(response.empList).each(function(index, item){
					var empId = item.empId;
					(function(index, item){
						sendMessage('${pageContext.request.contextPath}',
									empId,
									'새로운 팀 일정이 등록되었습니다. 확인해주세요.',
									editTitle.val(),
									'${pageContext.request.contextPath}/schedule/detail?scheduleId='+response.scheduleId,
									'일정관리');
					})(index, item);
				});
			}
			alert("일정이 등록되었습니다.");
			
			if(window.opener)  window.opener.location.reload();
			window.close();
       }
       ,error: function(request, status, error){
    	   console.log("error 발생 >> " + request +", "+ status+", "+error);
       }
   });
    
}



</script>
<script>//시연용
function presentationFill(){
	$('#edit-title').val('불철주야팀 회의');
	$('#edit-start').val('2021-05-14 09:00');
	$('#edit-end').val('2021-05-14 11:00');
	$('#edit-location').val('분임토의 5실');
	$('#edit-desc').val('불철주야팀 회의');
	
}
function presentationFill_2(){
	$('#edit-important').attr("checked","checked");
	$('#edit-title').val('휴가');
	$('#edit-start').val('2021-05-18 00:00');
	$('#edit-end').val('2021-05-21 23:55');
	$('#edit-desc').val('프로젝트 종료 일정에 맞춘 휴가');
	
}
</script>
