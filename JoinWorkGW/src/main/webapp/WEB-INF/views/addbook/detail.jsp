<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
label, div span, b, small{
	color:#000000;
	text-align: center;
}
.register-card-body{
	padding: 20px;
}
form > div.input-group {
	display: flex;
	justify-content: center;
}
div.mailbox-attachment-info{
	margin-top: 20px;
}
input {
	height: 35px !important; 
}
#openwindowHeader{
	margin: 20px 0px 20px 0px;
    font-size: 1.2em;
}
.form-control:disabled, .form-control[readonly]{	
	background-color: #e9ecef7d;
}
label.col-sm-2{
	font-size: 0.9em;
}
#pictureView1{
	background-position: center;
	background-size: cover;
	background-repeat: no-repeat;
}
#pictureView2{
	background-position: bottom;
	background-size: cover;
	background-repeat: no-repeat;

}
.card-header > .row {
	justify-content: flex-end;
}
.header-btn{
	margin-left: 15px;
}
</style>
<body>
<!-- 메인 content -->
<div class="container-fluid">
	<!-- 메인 content 넣는 곳 -->
	<section class="content register-page">
		<div class="register-box">
			<div id="openwindowHeader" style="font-family: S-CoreDream-6Bold">
				<a><b>주소록 상세조회</b></a>
			</div>
			<div class="card" style="font-family: S-CoreDream-6Bold">				
				<div class="card-header">
					<div class="row">	
						<c:if test="${flag eq 'private'}">
							<div class="float-right">
								<button type="button" id="modifyBtn" onclick="javascript:location.href='<%=request.getContextPath() %>/addbook/modifyForm?manageId=${addBookVO.manageId }';" class="btn btn-info header-btn">&nbsp;&nbsp;&nbsp;수 &nbsp;&nbsp;정&nbsp;&nbsp;&nbsp;</button>
							</div>
							<div class="float-right">
								<button type="button" id="removeBtn" onclick="remove_go();" class="btn btn-danger header-btn">&nbsp;&nbsp;&nbsp;삭 &nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;</button>
							</div>
						</c:if>							
						<div class="float-right">
							<button type="button" id="cancelBtn" onclick="CloseWindow();"
							class="btn btn-secondary float-right header-btn">&nbsp;&nbsp;&nbsp;닫 &nbsp;&nbsp;기&nbsp;&nbsp;&nbsp;</button>
						</div>
					</div>
				</div>	
			<!-- form start -->
				<div class="register-card-body">
					<c:if test="${ flag eq 'company' }">
						<div class="input-group mb-2">
							<div class="mailbox-attachments clearfix" id="pictureDiv" style="margin: auto;">
								<c:choose>
									<c:when test="${addBookVO.managePicture eq '없음'}">
										<div class="mailbox-attachment-icon has-img" id="pictureView1" style="height:14em; width:14em; background-image: url('<%=request.getContextPath()%>/resources/image/NO_IMAGE.png');"></div>
									</c:when>
									<c:otherwise>
										<div id="pictureView2" style="height:200px; width:140px; background-image: url('getPicture?picture=${addBookVO.managePicture }');"></div>
									</c:otherwise>
								</c:choose>
							</div>
							<br />
						</div>	
					</c:if>
					<form:form commandName="addBookVO" id="detailForm" name="detailForm" class="form-horizontal" autocomplete="off">
						<div class="form-group row">
							<label for="manageDisplayName" class="col-sm-2" style="font-size:0.9em;">
								이름
							</label>
							<div class="col-sm-10 input-group-sm">		
								<form:input path="manageDisplayName" id="manageDisplayName" class="form-control" readonly="true"/>						
							</div>
						</div>
						<div class="form-group row">
							<label for="manageHp" class="col-sm-2 control-label">전화번호</label>
							<div class="col-sm-10">	
								<form:input path="manageHp" id="manageHp" class="form-control" readonly="true"/>						
							</div>
						</div>
						<div class="form-group row">
							<label for="manageEmail" class="col-sm-2" style="font-size:0.9em;">이메일</label>
							<div class="col-sm-10 input-group-sm">
								<form:input path="manageEmail" class="form-control float-left" id="manageEmail" readonly="true"/>						
							</div>
						</div>
						<div class="form-group row">
							<label for="manageOfficialName" class="col-sm-2" style="font-size:0.9em;">
								직급
							</label>
							<div class="col-sm-10 input-group-sm">								
								<form:input path="manageOfficialName" class="form-control float-left" readonly="true"/>						
							</div>
						</div>
						
						<div class="form-group row">
							<label for="manageDeptName" class="col-sm-2" style="font-size:0.9em;" >
							 	부서명
							</label>	
							<div class="col-sm-10 input-group-sm">								
								<form:input path="manageDeptName" class="form-control float-left" readonly="true"/>						
							</div>
						</div>
						<div class="form-group row">
							<label for="addBookTitle" class="col-sm-2" style="font-size:0.9em;" >
								그룹
							</label>	
							<div class="col-sm-10 input-group input-group-sm">
								<form:input path="addBookTitle" class="form-control float-left" readonly="true"/>						
							</div>								
						</div>
						<c:if test="${flag eq 'private'}">
							<div class="form-group row">
								<label for="manageRemark" class="col-sm-2" style="font-size:0.9em;" >
								 	비고란
								</label>	
								<div class="col-sm-10 input-group-sm">	
									<c:choose>
										<c:when test="${!empty addBookVO.manageRemark }">
											<form:input path="manageRemark" class="form-control" readonly="true"/>						
										</c:when>
										<c:otherwise>
											<form:input path="manageRemark" value="없음" class="form-control" readonly="true"/>						
										</c:otherwise>
									</c:choose>							
								</div>
							</div>
						</c:if>
						<form:hidden path="manageId"/>
					</form:form>	
				</div><!-- register-card-body -->
			</div>
		</div>
	</section>		<!-- /.content -->
</div>

<script>

function remove_go(){
	// temp form에 empId 추가
// 	var inputTag = '<input type="hidden" name="loginUser">';
// 	console.dir(${loginUser});
// 	$('form[name="detailForm"]').append(inputTag);
	
	var manageDisplayName = '${addBookVO.manageDisplayName}';
	
	if(confirm(manageDisplayName+'을(를) 주소록에서 삭제하시겠습니까?')){
		
		var removeForm = document.detailForm;
		removeForm.action = "<c:url value='/addbook/remove'/>";
		
		var formData = new FormData(removeForm);
		
		$.ajax({
			url:removeForm.action,
			type:'post',
			data:formData,
			processData:false,
			contentType:false,
			success:function(response){
				if(response && response > 0){
					alert("주소록이 삭제되었습니다.");
				}else{
					alert("주소록 삭제에 실패했습니다..");
				}
				CloseWindow();
			},
			error:function(request, status, error){
				alert("주소록 삭제에 실패했습니다..");
				console.log(error);
				CloseWindow();
			}
		});
	}
}
</script>


</body>