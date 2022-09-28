<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
#headDiv{
	float: left;
}
.whole{
	margin-top: 20px;
}
input.btn.float-right {
	margin-left: 10px;
	width: 20%;
}
.form-group.row{
	margin: 0px;
}
#registBody{
	padding: 0px 20px 30px 20px;
}
.form-control[readonly], .form-control{
	background-color: #ffffff;
}
nav.sidebar-nav ul.main-menu {
/* 	list-style-position: inside; */
	list-style: square inside;
}
.privateAddBook li{
	margin-left: 15px;
	padding: 5px 0px 5px;
}
.privateAddBook li:hover{
	background-color: #f1f1f1; 
	cursor: pointer;
}
strong{
	font-size: 1.1em;
}
#emptyDiv{
    display: flex;
    justify-content: center;
    height: 93px;
	
}
#emptySp{
	padding: 65px 15px;
	margin: auto;
	text-align: center;
}
#left-header{
	height: 4em;
}
.right-header{
    align-items: center;
	height: 4em;
}
.card-header .btn{
	float: right;
}
.form-group.row{
	padding: 15px 5px 15px 5px;
	width: 100%;
}
.inner-card{
	height: 20em;
}
label.col-sm-2{
	padding : 0px 10px 0px 10px;
	vertical-align: middle;
	margin: auto;
}
#registDiv1 .col-sm-10{
	padding: 15px 0px 15px 0px;
}
form{
	width: 100%;
	display: contents;
}
#emptyHeadDiv, #left-header, #modifyHeadDiv, #registHeadDiv {
    padding: 16px;
}
</style>
<!-- 메인 content -->
<input type="hidden" value="${codeAddId }" id="fixedCodeAddId"/>
<div class="container-fluid">
	<!-- 메인 content 넣는 곳 -->
	<div class="row clearfix">
        <div class="col-lg-12 whole">
            <div class="card">
                <div class="header">
                	<div id="headDiv">
	                    <h3>주소록 그룹생성</h3>
                	</div>
                	<button type="button" class="btn hiddenFillBtn" onclick="presentationFill_1();" style="position:absolute;right:33em;top:1.5em;color:#ffffff; z-index: 100; border: 0px;">시연용버튼1</button>
                    <input type="button" onclick="CloseWindow();" class="btn btn-secondary float-right" value="닫기">
                    <input type="button" onclick="regist_go();" class="btn btn-primary float-right" id="realRegistBtn" value="신규생성">
                </div>
                <br>
                <hr/>
                
                
                <div class="body"  id="registBody">
                	<div class="col-lg-6 col-md-12  float-left">
						<div class="card inner-card">
							<div class="card-header" id="left-header">
								<i class="fa fa-folder-o"></i><strong>&nbsp;&nbsp;개인주소록</strong>
							</div>
							<div class="tab-content p-l-0 p-r-0">
								<div class="tab-pane animated fadeIn active" id="private_AddBook_menu">
									<nav class="sidebar-nav">
										<ul class="main-menu metismenu privateAddBook" >
											<li onclick="showDetail('0');">전체주소록</li>
											<c:choose>
												<c:when test="${ !empty groupList }">
													<c:forEach items="${groupList }" var="group">
														<li onclick="showDetail('${group.addBookId}');">${group.addBookTitle }</li>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<li>생성된 그룹이 없습니다.</li>
												</c:otherwise>
											</c:choose>
										</ul>                        
									</nav>                    
								</div>             
							</div>
						
						</div>
					</div>
					<!-- 조회 및 등록 카드 -->
					<div class="col-lg-6 col-md-12 float-right">
						<div class="card inner-card">
						
							<!-- 상세조회 -->
							<div class="card-header right-header" id="emptyHeadDiv">
								<i class="icon-notebook"></i><strong>&nbsp;&nbsp;상세조회</strong>
								<input type="button" onclick="remove();" class="btn btn-sm btn-danger float-right" id="removeBtn"  style="display:none;" value="삭제">
								<input type="button" onclick="modify_go();" class="btn btn-sm btn-info float-right" id="modifyGoBtn"  style="display:none;" value="수정">
							</div>
							<div class="form-group row " id="emptyDiv" >
								<div class="col-sm-10 input-group input-group-sm ">
									<c:choose>
										<c:when test="${ !empty groupList }">
											<span id="emptySp" >좌측 메뉴에서 그룹 선택 시<br>상세정보가 표시됩니다.</span>
										</c:when>
										<c:otherwise>
											<span id="emptySp" >상단의 신규생성 버튼으로 <br>그룹을 생성할 수 있습니다.</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="form-group row " id="detailDiv" style="display: none;">
							<!-- 상세정보 조회 들어올 부분 -->
							</div>
							
							<!-- 등록 form -->
							<div class="card-header right-header" id="registHeadDiv" style="display:none;">
								<i class="fa fa-edit"></i><strong>&nbsp;&nbsp;그룹 생성</strong>
								<input type="button" onclick="cancel();" class="btn btn-sm btn-secondary float-right" id="cancelBtn" value="취소">
								<input type="button" onclick="regist();" class="btn btn-sm btn-info float-right" id="realRegistBtn"value="등록">
							</div>
							
							<div class="form-group row" style="display: none;" id="registDiv1">
								<form:form commandName="addBookVO" id="registForm" name="registForm" method="post" autocomplete="off">
									<div class="form-group row"  >
										<label class="col-sm-2 float-left" for="addBookTitleForRegist" >그룹명</label>
										<div class="col-sm-10 input-group input-group-sm ">
											<form:input path="addBookTitle" id="addBookTitleForRegist" class="form-control"/>
											<button type="button" class="btn btn-sm btn-info  float-right" onclick="checkName(this);">중복확인</button>
											<input type="hidden" value="0" id="dupleYNForRegist">
										</div>
									</div>
									<form:hidden path="codeAddId" id="codeAddIdForRegist"/>
								</form:form>
							</div>
							
							<!-- 수정 form -->
							<div class="card-header right-header" id="modifyHeadDiv" style="display: none;"> 
								<i class="fa fa-edit"></i><strong>&nbsp;&nbsp;그룹 수정</strong>
								<input type="button" onclick="cancel();" class="btn btn-sm btn-secondary float-right" id="cancelBtn2" value="취소">
								<input type="button" onclick="modify();" class="btn btn-sm btn-warning float-right" id="realRegistBtn" value="수정">
							</div>
							<div class="form-group row" style="display: none;" id="modifyDiv">
								<form:form commandName="addBookVO" id="modifyForm" name="modifyForm"  method="post" autocomplete="off">
									<div class="form-group row"  id="modifyDiv2">
										<label class="col-sm-2 float-left" for="addBookTitleForModify" >그룹명</label>
										<div class="col-sm-10 input-group input-group-sm ">
											<form:input path="addBookTitle" id="addBookTitleForModify" class="form-control" onchange="sameNameCheck(this);"/>
											<button type="button" class="btn btn-sm btn-info  float-right" onclick="checkName(this);">중복확인</button>
	                             			<input type="hidden" value="0" id="dupleYNForModify">
										</div>
									</div>
									<div class="form-group row"   id="modifyDiv3" >
										<label class="col-sm-2 float-left" for="addBookCount" >주소개수</label>
										<div class="col-sm-10 input-group input-group-sm ">
											<form:input path="addBookCount" id="addBookCountForModify" class="form-control" readonly="true"/>
										</div>
									</div>
									<form:hidden path="codeAddId" id="codeAddIdForModify"/>
									<form:hidden path="addBookId" id="addBookIdForModify"/>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script> // 리스트 상태
var addBookId = '';
var codeAddId = '';
window.onload=function(){
	codeAddId = $('#fixedCodeAddId').val();
	console.log("codeAddId >> " + codeAddId);
}
var detailResponse = ''; // 수정용 정보 셋팅을 위한 전역변수

function showDetail(input){
	addBookId = input;
	console.log('---- addBookId 심음 ---- 👇🏻');
	console.log(input);

	
// 	alert('showDetail 클릭');
	$('#emptyDiv').css('display','none');
	$('#registHeadDiv').css('display','none');
	$('#registGoBtn').css('display','none');
	$('#registDiv1').css('display','none');
	$('#modifyHeadDiv').css("display","none");
	$('#modifyDiv').css("display","none");
	$('#detailDiv').css('display','');
	$('#emptyHeadDiv').css("display","");
	$('#detailDiv').html('');
	// 생성폼 none
	if(input == 0){
		$('#removeBtn').css("display","none");
		$('#modifyGoBtn').css("display","none");
	}else{
		$('#removeBtn').css("display","");
		$('#modifyGoBtn').css("display","");
	}
	
	var sendData = {
		addBookId:addBookId
	}
	
	$.ajax({
		url:"<c:url value='groupDetail'/>",
		type:'post',
		data:sendData,
		dataType:'json',
		success:function(response){
			console.dir(response);
			detailResponse = response;
			var content = '<div class="form-group row"  id="detailDiv1">'
						 +'<label class="col-sm-2 float-left" for="addBookTitleForDetail" >그룹명</label>'
						 +'<div class="col-sm-10 input-group input-group-sm ">'
							 +'<input id="addBookTitleForDetail" class="form-control" readonly="true" value="'+ response.addBookTitle +'"/>'
						 +'</div>'
					 +'</div>'
					 +'<div class="form-group row"   id="detailDiv2" >'
						 +'<label class="col-sm-2 float-left" for="addBookCountForDetail" >주소개수</label>'
						 +'<div class="col-sm-10 input-group input-group-sm ">'
						 	+'<input id="addBookCountForDetail" class="form-control" readonly="true" value="'+ response.addBookCount +'"/>'
						 +'</div>'
					 +'</div>'
			
			
			$('#detailDiv').html(content);
		},
		error:function(request, status, error){
			alert('상세조회 중 오류가 발생했습니다./n관리자에게 문의바랍니다.');
			console.log("error >> " + error);
			$('#emptyDiv').css('display','');
			$('#modifyGoBtn').css('display','none');
		    $('#removeBtn').css('display','none');
			$('#detailDiv').html('');
			$('#detailDiv').css('display','none');
		}
	});
	
	
}

function remove(){
	var clickTitle = detailResponse.addBookTitle;
// 	console.log("remove에서 addBookId >> " + addBookId);
// 	console.log("remove에서 codeAddId >> " + codeAddId);
	if(confirm(clickTitle + ' 그룹을 삭제하시겠습니까?\n그룹에 포함된 주소록은 전체주소록 그룹으로 이동됩니다.')){
		var sendData = {
				addBookId:addBookId
				,codeAddId:codeAddId
		}
		
		$.ajax({
			url:"<c:url value='groupRemove'/>",
			type:'post',
			data:sendData,
			success:function(response){
				console.log(response);
				console.log(response == 'hasBook');
				if(response == 'hasBook'){
					alert("해당 그룹에 저장된 주소록을 전체주소록으로 이동 후 그룹을 삭제하였습니다.");
					window.opener.location.reload(true);
					location.reload(true);
					return;					
				}else if(response == 'emptyBook'){
					alert("주소록 그룹이 삭제되었습니다.");
					window.opener.location.reload(true);
					location.reload(true);
					return;					
				}else{
					alert("주소록 그룹 삭제 중 오류가 발생했습니다.\n관리자에게 문의바랍니다.");
					return false;					
				}
				// 그룹 리스트화면 보여주기. 그룹리스트 리로드 필요?
			},
			error:function(request, status, error){
				alert("주소록 그룹 삭제 중 오류가 발생했습니다.\n관리자에게 문의바랍니다.");
				console.log(error);
				if(window.opener)window.opener.location.reload(true);
				window.close();
			}
		});
	} // if문
}


</script>

<script> // 상세조회 상태

function modify_go(){
// 	alert('수정하러 화면 바꾸기');
	$('#emptyHeadDiv').css("display","none");
	$('#emptyDiv').css("display","none");
	$('#detailDiv').css('display','none');
	$('#registDiv1').css("display","none");
	$('#registHeadDiv').css("display","none");
	
	$('#modifyHeadDiv').css("display","");
	$('#modifyDiv').css("display","");
	
	$('#addBookTitleForModify').val(detailResponse.addBookTitle);
	$('#addBookCountForModify').val(detailResponse.addBookCount);
}

// 수정 시 같은 이름 사용할 경우 사용 가능하도록 함
function sameNameCheck(input){
	var addBookTitle = input.value;
	if(addBookTitle == detailResponse.addBookTitle){
		$('#dupleYNForModify').val(1);
	}
}

function modify(){
// 	console.log("modify 함수 안에서 codeAddId >> " + codeAddId);
	
	$('#addBookIdForModify').val(addBookId);
	var addBookIdForModify = $('#addBookIdForModify').val();
// 	console.log("addBookIdForModify >>" + addBookIdForModify );
	
 	var addBookTitle = $('#addBookTitleForModify').val();
	if(!addBookTitle) {
		alert('그룹명은 필수입니다.');
		return false;
	}
	
	var modifyForm = document.modifyForm;
	modifyForm.action = "<c:url value='groupModify'/>";
	
	var formData = new FormData(modifyForm);
	
	$.ajax({
		url:modifyForm.action,
		type:'post',
		data:formData,
		processData:false,
		contentType:false,
		success:function(response){
			if(response && response > 0){
				alert("주소록 그룹이 수정되었습니다.");
				location.reload(true);
			}else{
				alert("주소록 그룹 수정에 실패했습니다..");
			}
			// 그룹 리스트화면 보여주기. 그룹리스트 리로드 필요?
		},
		error:function(request, status, error){
			alert("주소록 그룹 수정에 실패했습니다..");
			console.log(error);
			if(window.opener)window.opener.location.reload(true);
			window.close();
		}
	});
	
}


</script>

<script> // 생성
function regist_go(){ // 생성하러 화면 바꾸기
	$('#emptyHeadDiv').css("display","none");
	$('#emptyDiv').css("display","none");
	$('#detailDiv').css('display','none');
	$('#modifyHeadDiv').css("display","none");
	$('#modifyDiv').css("display","none");
	
	$('#registDiv1').css("display","");
	$('#registHeadDiv').css("display","");
}

function checkName(input){
// 	console.dir(input.parentElement.children);
	
	var checkingName = input.parentElement.children[0];
	var dupleYN = input.parentElement.children[2].value;
// 	console.log('duple로 추정되는 ele id >>' + input.parentElement.children[2].id);
	
	if(!checkingName.value.trim()) {
		alert('그룹명 입력은 필수입니다.');
		return false;
	}
	
	var formData = '';
	
	if(checkingName.id == 'addBookTitleForRegist'){
		var registForm = document.registForm;
		formData = new FormData(registForm);
	}else if(checkingName.id == 'addBookTitleForModify'){
		if(checkingName.value == detailResponse.addBookTitle){
			alert('사용가능한 그룹명입니다.');
			return;
		}
		var modifyForm = document.modifyForm;
		formData = new FormData(modifyForm);
	}
	
	
	$.ajax({
		url: "<c:url value='checkGroupName'/>"
		,type: "post"
        ,data: formData
        ,processData:false
		,contentType:false
        ,success: function (response) {
//         	console.log(response);
			if(response > 0){
				alert('중복된 그룹명이 있습니다. 다시 입력해주세요.');
				input.parentElement.children[2].value = 0;
				return false;
			}else{
				alert('사용 가능한 그룹명입니다.');
				input.parentElement.children[2].value = 1;
			}
        }
        ,error: function(request, status, error){
			alert("중복검사 중 오류가 발생했습니다./n관리자에게 문의바랍니다.");
			console.log("error 발생 >> " +error);
        }
	});
}


function regist(){
// 	console.log("regist 함수 안에서 codeAddId >> " + codeAddId);
	$('#codeAddIdForRegist').val(codeAddId);
// 	console.log("임의로 심어준 regist의 codeAddId 히든인풋 값 >> "+$('#codeAddIdForRegist').val());

	var registForm = document.registForm;
	console.log('---registForm---');
	console.dir(registForm);
	console.log('---registForm end---');
	
	registForm.action = "<c:url value='groupRegist'/>";
	
	var formData = new FormData(registForm);
	
	var addBookTitle = $('#addBookTitleForRegist').val().trim();
	var dupleYN = $('#dupleYNForRegist').val();
	console.log("dupleYN >> " + dupleYN);
	
	if(!addBookTitle || addBookTitle == ""){
		alert("그룹명은 필수입니다.");
		return false;
	}else if(dupleYN == 0){
		alert('그룹명 중복확인은 필수입니다.');
		return false;
	}
	
	
	$.ajax({
		url:registForm.action,
		type:'post',
		data:formData,
		processData:false,
		contentType:false,
		success:function(response){
			if(response > 0){
				alert("주소록 그룹이 생성되었습니다.");
				if(window.opener) window.opener.location.reload(true);
				location.reload(true);
				// 생성한 주소록그룹 selected
			}else{
				alert("주소록 그룹 생성에 실패했습니다..");
				location.reload(true);			
			}
		},
		error:function(){
			alert("그룹생성 중 오류가 발생했습니다./n관리자에게 문의바랍니다.");
			location.reload(true);
		}
	});
}


function cancel(){
	$('#emptyHeadDiv').css("display","");
	$('#emptyDiv').css("display","");
	$('#detailDiv').css("display","none");
	$('#modifyGoBtn').css("display","none");
	$('#removeBtn').css("display","none");
	
	$('#registHeadDiv').css("display","none");
	$('#registDiv1').css("display","none");
	$('#addBookTitleForRegist').val('');
	$('#dupleYNForRegist').val(0);
	
	$('#modifyHeadDiv').css("display","none");
	$('#modifyDiv').css("display","none");
	$('#addBookTitleForModify').val('');
	$('#dupleYNForModify').val(0);
}

</script>
<script> //시연
function presentationFill_1(){
	$("#addBookTitleForRegist").val('거래처');
}	

</script>