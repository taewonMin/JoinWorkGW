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
</style>
<body>
<!-- 메인 content -->
<div class="container-fluid">
	<!-- 메인 content 넣는 곳 -->
	<section class="content register-page">
		<div class="register-box">
			<div id="openwindowHeader">
				<a><b>주소록 수정</b></a>
			</div>
			<div class="card">				
				<div class="card-header">
					<div class="row">								
						<div class="col-sm-6">
							<button type="button" id="saveBtn" onclick="save_go();" class="btn btn-info">저장</button>
						</div>
						<div class="col-sm-6">
							<button type="button" id="cancelBtn" onclick="CloseWindow();"
							class="btn btn-secondary float-right">&nbsp;&nbsp;&nbsp;닫 &nbsp;&nbsp;기&nbsp;&nbsp;&nbsp;</button>
						</div>
					</div>
				</div>	
			<!-- form start -->
				<div class="register-card-body">
					<form:form commandName="addBookVO" id="modifyForm" name="modifyForm" class="form-horizontal" autocomplete="off">
						<div class="form-group row">
							<label for="manageDisplayName" class="col-sm-2" style="font-size:0.9em;">
								이름
							</label>
							<div class="col-sm-10 input-group-sm">		
								<form:input path="manageDisplayName" id="manageDisplayName" class="form-control" />						
							</div>
						</div>
						<div class="form-group row">
							<label for="manageHp" class="col-sm-2 control-label">전화번호</label>
							<div class="col-sm-10">	
								<form:input path="manageHp" id="manageHp" class="form-control" />						
							</div>
						</div>
						<div class="form-group row">
							<label for="manageEmail" class="col-sm-2" style="font-size:0.9em;">이메일</label>
							<div class="col-sm-10 input-group-sm">
								<form:input path="manageEmail" class="form-control float-left" id="manageEmail" />						
							</div>
						</div>
						<div class="form-group row">
							<label for="manageOfficialName" class="col-sm-2" style="font-size:0.9em;">
								직급
							</label>
							<div class="col-sm-10 input-group-sm">								
								<form:input path="manageOfficialName" class="form-control float-left" />						
							</div>
						</div>
						
						<div class="form-group row">
							<label for="manageDeptName" class="col-sm-2" style="font-size:0.9em;" >
							 	부서명
							</label>	
							<div class="col-sm-10 input-group-sm">								
								<form:input path="manageDeptName" class="form-control float-left" />						
							</div>
						</div>
						<div class="form-group row">
							<label for="addBookTitle" class="col-sm-2" style="font-size:0.9em;" >
								그룹
							</label>	
							<div class="col-sm-10 input-group input-group-sm">
								<form:input path="addBookTitle" class="form-control float-left" />						
							</div>								
						</div>
						<div class="form-group row">
							<label for="manageRemark" class="col-sm-2" style="font-size:0.9em;" >
							 	비고란
							</label>	
							<div class="col-sm-10 input-group-sm">								
								<form:input path="manageRemark" class="form-control" />						
							</div>
						</div>
						<form:hidden path="saveToken"/>
					</form:form>	
				</div><!-- register-card-body -->
			</div>
		</div>
	</section>		<!-- /.content -->
</div>

<script>

function save_go(){
	
alert('저장버튼 클릭');
	var modifyForm = $();

}
</script>


</body>