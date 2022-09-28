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
#hiddenFillBtn:hover{ background-color: #f7f7f7;}
</style>
<body>
<!-- 메인 content -->
<div class="container-fluid" style="font-family: S-CoreDream-4Regular">
	<!-- 메인 content 넣는 곳 -->
	<section class="content register-page">
		<div class="register-box">
			<div id="openwindowHeader">
				<c:choose>
					<c:when test="${flag eq 'regist'}">
						<a><b>주소록 등록</b></a>
					</c:when>				
					<c:otherwise>
						<a><b>주소록 수정</b></a>
					</c:otherwise>				
				</c:choose>
			</div>
			<div class="card">				
				<div class="card-header">
					<div class="row">	
						<c:choose>
							<c:when test="${flag eq 'regist'}">
								<div class="col-sm-6">
									<button type="button" id="registBtn" onclick="regist_go();" class="btn btn-primary">&nbsp;&nbsp;&nbsp;등 &nbsp;&nbsp;록&nbsp;&nbsp;&nbsp;</button>
								</div>
							</c:when>						
							<c:otherwise>
									<div class="col-sm-6">
										<button type="button" id="modifyBtn" onclick="modify_go();" class="btn btn-info">&nbsp;&nbsp;&nbsp;수 &nbsp;&nbsp;정&nbsp;&nbsp;&nbsp;</button>
									</div>
							</c:otherwise>							
						</c:choose>		
						<div class="col-sm-6">
							<button type="button" class="btn btn-outline-light" id="hiddenFillBtn" onclick="presentationFill();" style="position:absolute;right:150px;top:0px;color:#f7f7f7">시연용버튼</button>
							<button type="button" id="cancelBtn" onclick="CloseWindow();"
							class="btn btn-secondary float-right">&nbsp;&nbsp;&nbsp;취 &nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;</button>
						</div>
					</div>
				</div>	
			<!-- form start -->
				<!-- 등록 폼 -->
				<div class="register-card-body">
					<c:choose>
						<c:when test="${flag eq 'regist'}">
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
											<form:select id="registHpSel" path="manageHp" cssClass="form-control float-left" style="width:75px;" multiple="false">
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
										<form:input id="registOfficialName" path="manageOfficialName" class="form-control float-left"/>						
									</div>
								</div>
								
								<div class="form-group row">
									<label for="manageDeptName" class="col-sm-2" style="font-size:0.9em;" >
									 	부서명
									</label>	
									<div class="col-sm-10 input-group-sm">								
										<form:input id="registDeptName" path="manageDeptName" class="form-control float-left"/>						
									</div>
								</div>
								<div class="form-group row">
									<label for="addBookId" class="col-sm-2" style="font-size:0.9em;" >
										그룹
									</label>	
									<div class="col-sm-10 input-group input-group-sm">
										<form:select path="addBookId" class="form-control float-left" style="width:75px;">
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
										<form:input path="manageRemark" id="registRemark"  class="form-control"/>						
									</div>
								</div>
								<form:hidden path="saveToken"/>
							</form:form>	
						</c:when>
						<c:otherwise>
							<!-- 수정 폼 -->
							<form:form commandName="addBookFormVO.addBookRegistCommand" id="modifyForm" name="modifyForm" class="form-horizontal" autocomplete="off">
								<form:hidden path="manageId"/>
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
									<div class="col-sm-10 input-group-sm">		
										<div class="input-group">
									<form:select path="manageHp[0]" cssClass="form-control float-left" style="width:75px;" multiple="false">
										<form:option value="">-선택-</form:option>
										<form:option value="010">010</form:option>
										<form:option value="011">011</form:option>
										<form:option value="017">017</form:option>
										<form:option value="018">018</form:option>
									</form:select>
									<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-&nbsp;</label>										
									<form:input path="manageHp[1]" class="form-control float-left" style="width:68px;"/>						
									<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-</label>
									<form:input path="manageHp[2]" class="form-control float-right" style="width:68px;"/>						
								</div>
									</div>
								</div>
								<div class="form-group row">
									<label for="manageEmail" class="col-sm-2" style="font-size:0.9em;">이메일</label>
									<div class="col-sm-10 input-group-sm manageEmailDiv">
										<form:input path="manageEmail[0]" class="form-control float-left" id="manageEmail"/>						
										<span id="manageEmailSp">@</span>
										<form:select path="manageEmail[1]" class="form-control  float-right" multiple="false" id="manageEmailSel">
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
										<form:input path="manageOfficialName" class="form-control float-left" />						
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
									<label for="addBookId" class="col-sm-2" style="font-size:0.9em;" >
										그룹
									</label>	
									<div class="col-sm-10 input-group input-group-sm">
										<form:select path="addBookId" class="form-control float-left" style="width:75px;">
											<form:option value="">전체주소록</form:option>
											<form:options items="${groupList }" itemValue="addBookId" itemLabel="addBookTitle" />
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
						</c:otherwise>
					</c:choose>
									
				</div><!-- register-card-body -->
			</div>
		</div>
	</section>		<!-- /.content -->
</div>

<script> // 등록

function regist_go(){
	
	var manageDisplayName = $('#manageDisplayName').val();
	if(!manageDisplayName) {
		alert('이름은 필수입니다.');
		return false;
	}
	
	var registForm = document.registForm;
	registForm.action = "<c:url value='/addbook/regist'/>";
	
	var formData = new FormData(registForm);
	
	console.dir(registForm);
	
	$.ajax({
		url:registForm.action,
		type:'post',
		data:formData,
		processData:false,
		contentType:false,
		success:function(response){
			if(response && response == 1){
				alert("주소록이 등록되었습니다.");
				window.opener.parent.location.href='<c:url value="/addbook/list" />';
				window.close();
			}else{
				alert("주소록 등록에 실패했습니다..");
				window.opener.parent.location.href='<c:url value="/addbook/list" />';
				window.close();
			}
		},
		error:function(request, status, error){
			alert("주소록 등록에 실패했습니다..");
			console.log(error);
			window.close();
		}
	});
	

}
</script>

<script> // 저장

function modify_go(){
	
	var manageDisplayName = $('#manageDisplayName').val();
	if(!manageDisplayName) {
		alert('이름은 필수입니다.');
		return false;
	}
	
	var modifyForm = document.modifyForm;
	modifyForm.action = "<c:url value='/addbook/modify'/>";
	
	var formData = new FormData(modifyForm);
	console.log('--- key value 찍기 ---');
	for (var key of formData.keys()) {
	  console.log(key);
	}
	for (var value of formData.values()) {
	  console.log(value);
	}
	console.log('--- key value 찍기 끝 ---');
	
	$.ajax({
		url:modifyForm.action,
		type:'post',
		data:formData,
		processData:false,
		contentType:false,
		success:function(response){
			if(response && response == 1){
				alert("주소록이 수정되었습니다.");
				if(window.opener) window.opener.location.reload(true);
			}else{
				alert("주소록 수정에 실패했습니다..");
			}
			location.href='<c:url value="/addbook/detail?manageId=${addBookFormVO.addBookRegistCommand.manageId}" />';
		},
		error:function(request, status, error){
			alert("주소록 수정에 실패했습니다..");
			console.log(error);
			window.close();
		}
	});
}
</script>
<script>//시연용
function presentationFill(){
	$('#manageDisplayName').val('김지완');
	$('#registHpSel option[value="010"]').attr("selected",true);
	$('input[name="AddBookRegistCommand.manageHp"]').each(function(idx){
		$(this).val("1234");
	});
	$('#manageEmail').val('yeongdae0710');
	$('#manageEmailSel option[value="gmail.com"]').attr("selected",true);
	$('#registOfficialName').val('대리');
	$('#registDeptName').val('영업부');
	$('#registRemark').val('대덕개발');
	
}
</script>

</body>