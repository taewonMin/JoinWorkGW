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
.emailDiv, .regnoDiv{
	style="display:flex;
	justify-content:space-between;"
}

#manageEmail, #manageEmailSel{
	width:46%;
	height: 26px;
}
#manageEmailSp{
	margin-left: 15px;
}
.form-control {
	height: 35px !important; 
}
#openwindowHeader{
	margin: 20px 0px 20px 0px;
    font-size: 1.2em;
}
</style>
<body>
<!-- 메인 content -->
<div class="container-fluid" >
	<!-- 메인 content 넣는 곳 -->
	<section class="content register-page">
		<div class="register-box">
			<div id="openwindowHeader">
				<a><b>주소록 등록</b></a>
			</div>
			<div class="card">				
				<div class="card-header">
					<div class="row">								
						<div class="col-sm-6">
							<button type="button" id="registBtn" onclick="regist_go();" class="btn btn-primary">등록</button>
						</div>
						<div class="col-sm-6">
							<button type="button" id="cancelBtn" onclick="CloseWindow();"
							class="btn btn-secondary float-right">&nbsp;&nbsp;&nbsp;취 &nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;</button>
						</div>
					</div>
				</div>	
			<!-- form start -->
				<div class="register-card-body">
					<form:form commandName="addBookFormVO.AddBookRegistCommand" id="registForm" name="registForm" class="form-horizontal" autocomplete="off">
						<div class="form-group row">
							<label for="manageDisplayName" class="col-sm-2" style="font-size:0.9em;">
								이름
							</label>
							<div class="col-sm-10 input-group-sm">		
								<form:input path="manageDisplayName" id="manageDisplayName" class="form-control" placeholder="4자 이하로 입력해주세요."/>						
							</div>
						</div>
						<div class="form-group row">
							<label for="manageHp" class="col-sm-2 control-label">전화번호</label>
							<div class="col-sm-10">	
								<div class="input-group">
									<form:select path="manageHp" cssClass="form-control float-left" style="width:75px;" multiple="false">
										<form:option value="">-선택-</form:option>
										<form:option value="010">010</form:option>
										<form:option value="011">011</form:option>
										<form:option value="017">017</form:option>
										<form:option value="018">018</form:option>
									</form:select>
									<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-&nbsp;</label>										
									<form:input path="manageHp" class="form-control float-left" style="width:68px;"/>						
									<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-</label>
									<form:input path="manageHp" class="form-control float-right" style="width:68px;"/>						
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="manageEmail" class="col-sm-2" style="font-size:0.9em;">이메일</label>
							<div class="col-sm-10 input-group-sm manageEmailDiv">
								<form:input path="manageEmail" class="form-control float-left" id="manageEmail"/>						
								<span id="manageEmailSp">@</span>
								<form:select path="manageEmail" class="form-control  float-right" multiple="false" id="manageEmailSel">
									<form:option value="">-선택-</form:option>
									<form:option value="naver.com">naver.com</form:option>
									<form:option value="daum.net">daum.net</form:option>
									<form:option value="hanmail.net">hanmail.net</form:option>
									<form:option value="gmail.com">gmail.com</form:option>
									<form:option value="hotmail.com">hotmail.com</form:option>
									<form:option value="dreamwiz.com">dreamwiz.com</form:option>
									<form:option value="freechal.com">freechal.com</form:option>
									<form:option value="hanmir.com">hanmir.com</form:option>
								</form:select>
							</div>
						</div>
						<div class="form-group row">
							<label for="manageOfficialName" class="col-sm-2" style="font-size:0.9em;">
								직급
							</label>
							<div class="col-sm-10 input-group-sm">								
								<form:input path="manageOfficialName" class="form-control float-left"/>						
							</div>
						</div>
						
						<div class="form-group row">
							<label for="manageDeptName" class="col-sm-2" style="font-size:0.9em;" >
							 	부서명
							</label>	
							<div class="col-sm-10 input-group-sm">								
								<form:input path="manageDeptName" class="form-control float-left"/>						
							</div>
						</div>
						<div class="form-group row">
							<label for="addBookTitle" class="col-sm-2" style="font-size:0.9em;" >
								그룹
							</label>	
							<div class="col-sm-10 input-group input-group-sm">
								<form:select path="addBookTitle" class="form-control float-left" style="width:75px;">
									<form:option value="">전체주소록</form:option>
									<form:options items="${groupList }" itemValue="addBookId" itemLabel="addBookTitle"/>
								</form:select>
							</div>								
						</div>
						<div class="form-group row">
							<label for="manageRemark" class="col-sm-2" style="font-size:0.9em;" >
							 	비고란
							</label>	
							<div class="col-sm-10 input-group-sm">								
								<form:input path="manageRemark" class="form-control"/>						
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


function regist_go(){
	
	var manageDisplayName = $('#manageDisplayName').val();
	if(!manageDisplayName) {
		alert('이름은 필수입니다.');
		return false;
	}
	
	var registForm = document.registForm;
	registForm.action = "<%=request.getContextPath()%>/addbook/regist";
	
	var formData = new FormData(registForm);
	console.dir(formData);
	
	$.ajax({
		url:registForm.action,
		type:'post',
		data:formData,
		processData:false,
		contentType:false,
		success:function(){
			alert("주소록이 등록되었습니다.");
			window.close();
			window.opener.parent.location.href='<c:url value="/addbook/list" />';
		},
		error:function(){
			alert("주소록 등록에 실패했습니다..");
// 			if(window.opener)window.opener.location.reload(true);
			window.close();
		}
	});
	

}
</script>


</body>