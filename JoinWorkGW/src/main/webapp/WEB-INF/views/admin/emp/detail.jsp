<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<style>
label, div > span, b{
	color:#000000;
	text-align: center;
}
h4{
	color:#000000;
}
/* .register-card-body{ */
/* 	padding: 20px; */
/* } */
form > div.input-group {
	display: flex;
	justify-content: center;
}
div.mailbox-attachment-info{
/* 	margin-top: 20px; */
}

#card-header-div{
	display: flex;
	justify-content: space-between;
}
.form-control:disabled, .form-control[readonly]{
	background-color: #ffffff;
}
#buttonDiv{
	display: flex;
	justify-content: flex-end;
}
#cancelBtn, #modifyDept, #modifyOfficial {
	margin-left: 10px;
	padding: 5px;
}
#pictureView{
	background-position: center;
	background-size: cover;
	background-repeat: no-repeat;
	margin: 20px auto 40px;
}
#openwindowHeader{
	margin: 20px 0px 20px 0px;
    font-size: 1.2em;
}
#pictureUploadLabel{
	width: 100%;
	background-color: #0000004a;
	cursor: pointer;
    position: relative;
    top: 169px;
    padding: 5px 0px;
    color:#f0f0f0;
}
button.uploadBtn{
	position: relative;
	width: 100%;
	top: 162px;
}
div.container-fluid{
	padding: 15px;
}
.modal-header{
	display: block;
	justify-content: space-between;
    align-content: space-around;
    align-items: center;
    padding: 20px 10px 10px;
}

</style>
<body>
<!-- 메인 content -->
<div class="container-fluid">
	<!-- 모달 -->
	<a id="officialViewModal" href="#officialModal" data-toggle="modal" data-target="#officialModal" style="display: none;"></a>
	<a id="deptViewModal" href="#deptModal" data-toggle="modal" data-target="#deptModal" style="display: none;"></a>
	<a id="authViewModal" href="#authModal" data-toggle="modal" data-target="#authModal" style="display: none;"></a>
	<!-- 메인 content 넣는 곳 -->
	<section class="content register-page">
		<div class="register-box">
<!-- 			<div id="openwindowHeader"> -->
<!--     			<a><b>직원 상세조회</b></a> -->
<!--   			</div> -->
			<!-- form start -->
			<div class="card" style=" font-family: S-CoreDream-4Regular;">				
				<div class="register-card-body">
					<div class="card-header">
						<div class="row" id="card-header-div">	
							<h4 class="col-sm-4">직원 상세조회</h4>	
							<div class="col-sm-8" id="buttonDiv">
								<button type="button" id="modifyAuth" onclick="modifyAuth_go('${emp.authId}');" class="btn btn-info">권한 변경</button>
								<button type="button" id="modifyOfficial" onclick="modifyOfficial_go('${emp.codeOfficialId}');" class="btn btn-info">직급 변경</button>
								<button type="button" id="modifyDept" onclick="modifyDept_go('${emp.deptId}');" class="btn btn-info">부서 변경</button>
								<button type="button" id="cancelBtn" onclick="javascript:window.close();" class="btn btn-secondary">
									&nbsp;&nbsp;&nbsp;닫 &nbsp;&nbsp;기&nbsp;&nbsp;&nbsp;
								</button>
							
							</div>						
						</div>
					</div>
					<div class="card-body">
						<form role="form" class="form-horizontal" action="regist.do" method="post" readonly>						
							<div class="input-group mb-2">
								<div class="mailbox-attachments clearfix" style="text-align: center;">
									<c:choose>
										<c:when test="${!empty emp.empPicture}">
											<div class="mailbox-attachment-icon has-img" id="pictureView" style="background-image: url('getPicture?picture=${emp.empPicture }'); height: 200px; width: 140px;">
												<label id="pictureUploadLabel" for="inputFile">사진 선택</label>
												<button type="button" class="btn btn-info btn-sm btn-append uploadBtn" onclick="upload_go();">사진 저장</button>											
											</div>
										</c:when>
										<c:otherwise>
											<div class="mailbox-attachment-icon has-img" id="pictureView" style='background-image: url("<%=request.getContextPath() %>/resources/image/NO_IMAGE.png"); height: 14em; width: 14em;'>
												<label id="pictureUploadLabel" for="inputFile">사진 선택</label>
												<button type="button" class="btn btn-outline-info btn-sm btn-append uploadBtn" onclick="upload_go();">사진 저장</button>											
											</div>
										</c:otherwise>
									</c:choose>
									<input id="picture" class="form-control" type="hidden" name="empPicture" />
								</div>
								<br />
							</div>	
							<div class="form-group row">
								<label for="empId" class="col-sm-2">아이디</label>	
								<div class="col-sm-10 input-group input-group-sm">
									<input value="${emp.empId}" type="text" class="form-control" id="empId" readonly >
								</div>								
							</div>
							<div class="form-group row">
								<label for="empName" class="col-sm-2">
									이름
								</label>
								<div class="col-sm-10 input-group-sm">								
									<input class="form-control" value="${emp.empName}" type="text" class="form-control" id="empName" readonly />
								</div>
								
							</div>
							<div class="form-group row">
								<label for="empHp" class="col-sm-2 control-label">전화번호</label>
								<div class="col-sm-10">	
									<div class="input-group">
										<c:choose>
											<c:when test="${!empty emp.empHp }">
												<input style="width:68px;" value="${emp.empHp }" type="text" class="form-control float-left" readonly />
											</c:when>
											<c:otherwise>
												<input style="width:68px;" value="없음" type="text" class="form-control float-left" readonly/>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label for="codeOfficialId" class="col-sm-2 control-label">직급</label>
								<div class="col-sm-10">	
									<div class="input-group-sm">
										<c:choose>
											<c:when test="${!empty emp.officialName }">
												<input type="text" id="officialName" value="${emp.officialName }" class="form-control" readonly>
											</c:when>
											<c:otherwise>
												<input type="text" id="officialName" value="없음" class="form-control" readonly>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label for="empEmail" class="col-sm-2">이메일</label>
								<div class="col-sm-10 input-group-sm emailDiv">
									<c:choose>
										<c:when test="${!empty emp.empEmail }">
											<input value="${emp.empEmail}" type="text" class="form-control  float-left" id="empEmail" readonly="true">
										</c:when>
										<c:otherwise>
											<input value="없음" type="text" class="form-control  float-left" id="empEmail" readonly>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="form-group row">
								<label for="authId" class="col-sm-2" >부서</label>	
								<div class="col-sm-10 input-group input-group-sm">
									<input value="${emp.deptName }" type="text" class="form-control" id="authId" readonly>
								</div>								
							</div>
							<div class="form-group row">
								<label for="empSupId" class="col-sm-2" >직속상관</label>	
								<div class="col-sm-10 input-group input-group-sm">
									<c:choose>
										<c:when test="${!empty emp.empSupId }">
											<input value="${emp.empSupId }" type="text" class="form-control" id="empSupId" readonly>
										</c:when>
										<c:otherwise>
											<input value="없음" type="text" class="form-control" id="empSupId" readonly>
										</c:otherwise>
									</c:choose>
								</div>								
							</div>
							<div class="form-group row">
								<label for="empSt" class="col-sm-2">상태</label>	
								<div class="col-sm-10 input-group input-group-sm">
									<input value="${emp.empSt == 1 ? '활성':'비활성'}" type="text" class="form-control" id="empSt" disabled>
								</div>								
							</div>
							<div class="form-group row">
								<label for="authId" class="col-sm-2">권한</label>	
								<div class="col-sm-10 input-group input-group-sm">
									<input value="${emp.authName}" type="text" class="form-control" id="authName" disabled>
									<input value="${emp.authId}" type="hidden" class="form-control" id="authId" disabled>
								</div>								
							</div>
						</form>	
					</div>				
				</div><!-- register-card-body -->
			</div>
		</div>
	</section>		<!-- /.content -->
</div>

<!--직급변경 모달창 -->
<div class="modal fade" id="officialModal" tabindex="-1" role="dialog" style="font-family: InfinitySans-RegularA1">
	<div class="modal-dialog" role="document">
		<div class="modal-content" >
			<div class="modal-header" style="display: block; text-align: center;">
				<h4 class="title float-left" id="officialModalLabel">직급 변경</h4>
				<button type="button" class="btn float-right" data-dismiss="modal" style="vertical-align: bottom;">X</button>
			</div>
			<div class="modal-body" id="modalBodyForOfficial" style="padding: 20px;"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal" style="margin: auto;" onclick="modifyOfficial();">저장</button>
			</div>
		</div>
	</div>
</div>

<!--부서변경 모달창 -->
<div class="modal fade" id="deptModal" tabindex="-1" role="dialog" style="font-family: InfinitySans-RegularA1">
	<div class="modal-dialog" role="document">
		<div class="modal-content" >
			<div class="modal-header" style="display: block; text-align: center;">
				<h4 class="title float-left" id="deptModalLabel">부서 변경</h4>
				<button type="button" class="btn float-right" data-dismiss="modal" style="vertical-align: bottom;">X</button>
			</div>
			<div class="modal-body" id="modalBodyForDept" style="padding: 20px;"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal" style="margin: auto;" onclick="modifyDept();">저장</button>
			</div>
		</div>
	</div>
</div>

<!--권한 변경 모달창 -->
<div class="modal fade" id="authModal" tabindex="-1" role="dialog" style="font-family: InfinitySans-RegularA1">
	<div class="modal-dialog" role="document">
		<div class="modal-content" >
			<div class="modal-header" style="display: block; text-align: center;">
				<h4 class="title float-left" id="authModalLabel">권한 변경</h4>
				<button type="button" class="btn float-right" data-dismiss="modal" style="vertical-align: bottom;">X</button>
			</div>
			<div class="modal-body" id="modalBodyForAuth" style="padding: 20px;"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal" style="margin: auto;" onclick="modifyAuth();">저장</button>
			</div>
		</div>
	</div>
</div>



<form role="imageForm" action="common/setPicture" method="post" enctype="multipart/form-data">
	<input id="inputFile" name="pictureFile" type="file" class="form-control" onchange="fileChange_go(this);" style="display:none;">
	<input id="oldFile" type="hidden" name="oldPicture" />
	<input type="hidden" name="checkUpload" value="0" />
	<input type="hidden" name="fileEmpId" value="${param.empId }"/> 	
</form>

<script src="<%=request.getContextPath() %>/resources/js/jquery-3.6.0.min.js"></script>


<script>

//사진 변경
function fileChange_go(input){
	
	$('input[name="checkUpload"]').val(0);
	
	if(input.files && input.files[0]){ // 있으면
		var fileValue = $(input).val().split("\\");
		var fileName = fileValue[fileValue.length-1];
		var fileType = fileName.split(".")[1].toUpperCase();
		
		if(!(fileType == 'PNG' || fileType == 'JPG' || fileType == 'JPEG')){
			alert('이미지 파일(jpg, jpeg, png)만 선택해주세요.');
			return;
		}else if(input.files[0].size > 1024 * 1024 * 1){
			alert('사진 용량은 1MB 이하만 가능합니다.');
			return;
		}
		
		
		var reader = new FileReader();
		reader.onload = function(e){
			$('#pictureView').css('background-image', 'url('+e.target.result+')'); 
		}
		reader.readAsDataURL(input.files[0]);
	}
	
	
	
}


function upload_go(){
	
	var fileEle = $('input[name="pictureFile"]');
	
	if(!fileEle.val() || fileEle.val() == ''){
		alert('사진을 선택하세요.');
		fileEle.click();
		return;
	
	}
	
	//form 태그 양식을 객체화	
	var form = new FormData($('form[role="imageForm"]')[0]);
	
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/emp/setPicture",
		data:form,
		type:'post',
		processData:false,
		contentType:false,
		success:function(data){
			//업로드 확인변수 세팅
			$('input[name="checkUpload"]').val(1);
			
			//저장된 파일명 저장.
			$('input#oldFile').val(data); // 변경시 삭제될 파일명
			$('form[role="form"]  input[name="empPicture"]').val(data);
			
			alert("사진이 업로드 되었습니다.");
			if(window.opener) window.opener.location.reload(true);
			location.reload(true);
		},
		error:function(error){
			alert("현재 사진 업로드가 불가합니다.\n 관리자에게 연락바랍니다.");
		}
	});
}


function modifyOfficial_go(targetId) {
	var codeOfficialId = targetId;
	console.log(codeOfficialId);
	
	$.ajax({
		type:"POST",
		url:"<c:url value='getOfficial'/>",
		contentType:"application/json",
	 	data : codeOfficialId,
// 		processData:true,
		success: function(data) {
// 			console.dir(data);
			var content = '<div class="input-group">' 
						 +'<label for="modalOfficialId" class="float-left" style="margin:auto;">직급</label>';
			content 	+= '<select name="modalOfficialId" id="modalOfficialId" class="form-control float-right" style="width:75px;margin: 10px;">'
							 	 +'<option value="">--선택--</option>';
			for(var idx = 0; idx < data.length ; idx++){
				if(data[idx].codeId == codeOfficialId){
					content 	   += '<option value="' + data[idx].codeId + '" selected>'+ data[idx].codeName +'</option>';
				}else{
					content 	   += '<option value="' + data[idx].codeId + '">'+ data[idx].codeName +'</option>';
				}
				
			}
			content += 	'</select>'
						+'</div>';
			
			$("#modalBodyForOfficial").html(content);
			
		},
		error: function(request, status, e) {
			console.log("request : " + request + ", status : " + status + ", e : " + e);
		}
	});
// 	$("#viewModal").click();
	$("#officialViewModal").click();
}

function modifyOfficial(){
	var codeOfficialId = $('#modalOfficialId option:selected').val();
	var empId = '${emp.empId}';
	console.log(codeOfficialId);
	console.log(empId);
	
	var sendData = {
			codeOfficialId:codeOfficialId
			,empId:empId
	}
	
	console.log(sendData);
	
	$.ajax({
		url:'<c:url value="modifyOfficial"/>'
	  ,data:JSON.stringify(sendData)
	  ,type:'post'
	  ,dataType:'text'
	  ,contentType:"application/json;charset=utf-8"
	  ,success:function(response){
		  console.log(response);
		  if(response > 0){
			  alert('직급이 수정되었습니다.');
			  if(window.opener)window.opener.location.reload(true);
			  location.reload(true);
		  }else{
			  alert('수정 중 오류 발생');
			  location.reload(true);
		  }
		  
	  }
	  ,error:function(request, status, error){
		  console.log(error);
	  }
	});
	
}

function modifyDept_go(targetId){
	var deptId = targetId;
	console.log(deptId);
	
	$.ajax({
		type:"POST",
		url:"<c:url value='getDept'/>",
		contentType:"application/json",
	 	data : deptId,
// 		processData:true,
		success: function(data) {
			console.dir(data);
			var content = '<div class="input-group">' 
						 +'<label for="modalDeptId" class="float-left" style="margin:auto;">부서</label>';
			content 	+= '<select name="modalDeptId" id="modalDeptId" class="form-control float-right" style="width:75px;margin: 10px;">'
							 	 +'<option value="">--선택--</option>';
			for(var idx = 0; idx < data.length ; idx++){
				if(data[idx].deptId == deptId){
					content 	   += '<option value="' + data[idx].deptId + '" selected>'+ data[idx].deptName +'</option>';
				}else{
					content 	   += '<option value="' + data[idx].deptId + '">'+ data[idx].deptName +'</option>';
				}
				
			}
			content += 	'</select>'
						+'</div>';
			
			$("#modalBodyForDept").html(content);
			
		},
		error: function(request, status, e) {
			console.log("request : " + request + ", status : " + status + ", e : " + e);
		}
	});
	$("#deptViewModal").click();
}

function modifyDept(){
	var deptId = $('#modalDeptId option:selected').val();
	var empId = '${emp.empId}';
	console.log(deptId);
	console.log(empId);
	
	var sendData = {
			deptId:deptId
			,empId:empId
	}
	
	console.log(sendData);
	
	$.ajax({
		url:'<c:url value="modifyDept"/>'
	  ,data:JSON.stringify(sendData)
	  ,type:'post'
	  ,dataType:'text'
	  ,contentType:"application/json;charset=utf-8"
	  ,success:function(response){
		  console.log(response);
		  if(response > 0){
			  alert('부서가 수정되었습니다.');
			  if(window.opener)window.opener.location.reload(true);
			  location.reload(true);
		  }else{
			  alert('수정 중 오류 발생');
			  location.reload(true);
		  }
		  
	  }
	  ,error:function(request, status, error){
		  console.log(error);
	  }
	});
	
}
function modifyAuth_go(targetId){
	var authId = targetId;
	console.log(authId);
	
	$.ajax({
		type:"POST",
		url:"<c:url value='getAuth'/>",
		contentType:"application/json",
	 	data : authId,
// 		processData:true,
		success: function(data) {
			console.dir(data);
			var content = '<div class="input-group">' 
						 +'<label for="modalAuthId" class="float-left" style="margin:auto;">권한</label>';
			content 	+= '<select name="modalDeptId" id="modalAuthId" class="form-control float-right" style="width:75px;margin: 10px;">'
							 	 +'<option value="">권한없음</option>';
			for(var idx = 0; idx < data.length ; idx++){
				if(data[idx].authId == authId){
					content 	   += '<option value="' + data[idx].authId + '" selected>'+ data[idx].authKoName +'</option>';
				}else{
					content 	   += '<option value="' + data[idx].authId + '">'+ data[idx].authKoName +'</option>';
				}
				
			}
			content += 	'</select>'
						+'</div>';
			
			$("#modalBodyForAuth").html(content);
			
		},
		error: function(request, status, e) {
			console.log("request : " + request + ", status : " + status + ", e : " + e);
		}
	});
	$("#authViewModal").click();
}

function modifyAuth(){
	var authId = $('#modalAuthId option:selected').val();
	var empId = '${emp.empId}';
	console.log(authId);
	console.log(empId);
	
	var sendData = {
			authId:authId
			,empId:empId
	}
	
	console.log(sendData);
	
	$.ajax({
		url:'<c:url value="modifyAuth"/>'
	  ,data:JSON.stringify(sendData)
	  ,type:'post'
	  ,dataType:'text'
	  ,contentType:"application/json;charset=utf-8"
	  ,success:function(response){
		  console.log(response);
		  if(response > 0){
			  alert('권한이 수정되었습니다.');
			  if(window.opener)window.opener.location.reload(true);
			  location.reload(true);
		  }else{
			  alert('수정 중 오류 발생');
			  location.reload(true);
		  }
		  
	  }
	  ,error:function(request, status, error){
		  console.log(error);
	  }
	});
	
}
</script>


</body>