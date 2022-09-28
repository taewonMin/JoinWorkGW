<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<title>${meetRoomVO.meetRoomName } 회의실 </title>
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
#modifyBtn{
	display: none;
}
</style>

<body>
<div id="main-content">
	<div class="container-fluid" style="font-family: S-CoreDream-4Regular	">
			<div class="form-header container-fluid-header">
				<h3 class="form-title">${meetRoomVO.meetRoomName } 회의실</h3>
				<div>
					<c:if test="${loginUser.empId == meetRoomVO.empId}">
						<button type="button" id="modifyBtn" onclick="javascript:location.href='<%=request.getContextPath() %>/reservation/modifyForm?meetRoomId=${meetRoomVO.meetRoomId}';" class="btn btn-info header-btn">&nbsp;&nbsp;&nbsp;수 &nbsp;&nbsp;정&nbsp;&nbsp;&nbsp;</button>
						<button type="button" class="btn btn-danger" onclick="removeRoom();">삭제</button>
					</c:if>
					
					<button type="button" class="btn btn-secondary" onclick="window.close();">닫기</button>
				</div>
			</div>
			<hr>	
		<div class="row">
			<div class="col-md-4">
				<form:form commandName="meetRoomFormVO" id="detailForm" name="detailForm" class="form-horizontal" autocomplete="off">
				<form:hidden path="meetRoomVO.meetRoomId" />
				<form:hidden path="meetRoomVO.meetRoomReservationId"  />
				<form:hidden path="meetRoomVO.empId"/>
				</form:form>
				<div class="row">
					<div class="col-xs-12">
					<label class="col-xs-12" for="edit-title">예약자 </label>
						<div class="col-sm-12 input-group-sm">		
							${meetRoomVO.empName }(${meetRoomVO.teamName})
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
					<label class="col-xs-12" for="edit-title">부서명</label>
						<div class="col-sm-12 input-group-sm">
							${meetRoomVO.deptName} 		
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
					<label class="col-xs-12" for="edit-title">예약정보</label>
						<div class="col-sm-12 input-group-sm">
							${meetRoomVO.meetRoomName } (${meetRoomVO.meetRoomCapacity } 인)/${meetRoomVO.meetRoomNo }		
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
					<label class="col-xs-12" for="edit-title">예약 날짜</label>
						<div class="col-sm-12 input-group-sm" style="color: red;">
							${meetRoomVO.reservationDate } / ${meetRoomVO.reservationStartTime }시 ~ ${meetRoomVO.reservationEndTime }시		
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<label class="col-xs-4" for="edit-end">내용</label>
						<div class="col-sm-10 input-group-sm">		
							<form:textarea path="meetRoomVO.meetRoomDetail" id="meetRoomContent" class="form-control" rows="4" cols="40" readonly="true"/>						
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-8">
<%-- 				<div class="mailbox-attachment-icon has-img" id="pictureView" style="background-image: url('getPicture?picture=${meetRoomVO.meetRoomAttachPath}');"></div> --%>
				<img alt="" src="getPicture?picture=${meetRoomVO.meetRoomAttachPath}" style="width: 550px;border-top-width: 10px;margin-top: 50px;">
			</div>
		</div>				
	</div>
</div>

<script type="text/javascript">
function removeRoom(){
	
	var meetRoomId = '${meetRoomVO.meetRoomId}';
	
	if(confirm('해당 회의실을 삭제하시겠습니까?')){
		var detailForm = $('form[name="detailForm"]')[0];
		var formData = new FormData(detailForm);
		
		$.ajax({
			url:"<c:url value='/reservation/reservationRemove'/>",
			type:'post',
			data:formData,
			processData:false,
			contentType:false,
			success:function(response){
				if(response && response > 0){
					alert("회의실이 삭제되었습니다.");
				}else{
					alert("회의실 삭제에 실패했습니다..");
				}
				CloseWindow();
			},
			error:function(request, status, error){
				alert("삭제에 실패했습니다..");
				console.log(error);
				CloseWindow();
			}
		});
	}
}


</script>
