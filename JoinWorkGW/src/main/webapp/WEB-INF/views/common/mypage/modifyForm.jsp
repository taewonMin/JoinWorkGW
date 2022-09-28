<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<title>:: 내정보 설정</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="description" content="Lucid Bootstrap 4x Admin Template">
<meta name="author" content="WrapTheme, design by: ThemeMakker.com">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">
<script src="<%=request.getContextPath()%>/resources/js/jquery-3.6.0.min.js"></script>

<style>
 
div.lb1{
	text-align: left;
}
</style>
    
</head>

<body class="theme-blue">

<div id="wrapper">
	<div class="vertical-align-wrap">
		<div class="vertical-align-middle auth-main">
			<div style="text-align: center; margin-top: 30px;">
				<div class="card float-left" style="width: 700px; padding: 30px; left: 130px;">
					<div class="head float-center" style="font-family: S-CoreDream-6Bold">
						<span class="" style="display: inline-block; font-size: 30px;    padding-left: 175px;">
							내정보
						</span>
						<span class="float-right" style="padding-right: 36px;">
							<button class="btn btn-primary" data-type="success" onclick="modify_go();">수정 완료</button>
							<button type="button" class="btn btn-dark" onclick="home_go();">홈으로</button>
						</span>
					</div>
					
					<form action="modify" id="modifyForm" name="modifyForm" method="post" enctype="multipart/form-data">
					<div class="body" style="font-family: S-CoreDream-4Regular">
					
						<div class="row clearfix" style="margin-right: 0px;">
							<div class="input-group col-md-12 float-center">
								<div class="col-md-4">
									<div class="form-group lb1">
										<label>사진</label> 
										<div class="" id="empPicture" style="height: 194px; width: 140px; margin: 0; margin-bottom:5px;"></div>
									</div>
									<div class="form-group lb1">
										<label>비밀번호&nbsp&nbsp&nbsp&nbsp<span id="checkPwd" style="color: red;"></span></label> 
										<button id="modifyPwdBtn" class="btn btn-primary" data-type="success" onclick="window.open('<%=request.getContextPath()%>/common/password/modifyForm', '비밀번호수정', 'width=700,height=650,left=600');" style="width: 141px;">비밀번호 변경</button>
									</div>
								</div>
								<div class="col-md-8" style="padding-right: 0;">
									<div class="row clearfix">
										<div class="col-6">
											<div class="form-group lb1">
												<label>이름</label><input type="text" class="form-control" name="empName" value="${empVO.empName}" readonly />
											</div>
										</div>
										<div class="col-6">
											<div class="form-group lb1">
												<label>상태설정</label>
													<select name="attendStId" class="form-control">
														<option value="1" ${empVO.attendStId eq '1'? 'selected' : '' }>정상출근</option>
														<option value="4" ${empVO.attendStId eq '4'? 'selected' : '' }>휴가중</option>
														<option value="5" ${empVO.attendStId eq '5'? 'selected' : '' }>외근</option>
														<option value="6" ${empVO.attendStId eq '6'? 'selected' : '' }>야근</option>
													</select>
												
											</div>
										</div>
									</div>
								    <div class="form-group lb1">
										<label>부서</label> 
										<input type="text" class="form-control" name="" value="${empVO.deptName }" readonly />
									</div>
									<div class="form-group lb1">
										<label>직위</label> 
										<input type="text" class="form-control" name="" value="${empVO.officialName }" readonly />
									</div>
									
									<div class="form-group lb1">
										<label>사번</label> <input type="text" class="form-control" required="" name="empId" value="${empVO.empId}" readonly />
									</div>
								</div>
								
								
							</div>
						</div>
							
							<div class="col-lg-12" >
	
								<div class="form-group lb1">
									<label>전화번호</label>
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"><i class="icon-screen-smartphone"></i></span> 
										</div>
											<input type="text" id=ssn class="form-control" name="empHp" required  value="${empVO.empHp}" placeholder="ex: 010-0000-0000" />
									</div>
								</div>
								
								<div class="form-group lb1">
									<label>이메일</label>
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"><i class="icon-envelope"></i></span>
										</div>
										<input type="text" class="form-control" required name="empEmail" value="${empVO.empEmail }" />
									</div>
								</div>
								<div class="form-group lb1"  >
									<label>주소</label>
									<div class="input-group" style="cursor: pointer;" onclick="sample6_execDaumPostcode();">
										<div class="input-group-prepend">
											<span class="input-group-text"><i class="icon-home"></i></span>
										</div>
										<input id="myAdd1" type="text" style="cursor: pointer;" class="form-control" required name="empAdd1" readonly  value="${empVO.empAdd1 }" />
									</div>
								</div>
								
								<div class="form-group lb1">
									<label>상세주소</label>
									<div class="input-group">
										<input id="myAdd2" maxlength="200" type="text" class="form-control" required name="empAdd2" value="${empVO.empAdd2 }" />
									</div>
								</div>
								
								<div class="form-group lb1">
									<label>*필수 서명 &nbsp&nbsp(png만 가능)</label>
									<div class="input-group" >
										<div class="input-group-prepend">
											<span class="input-group-text"><i class="fa fa-file-o"></i></span> 
										</div>									
										<input id="myFileName" type="text" class="form-control" name="empSign" style="cursor: pointer;" onclick="addEmpSign();" required readonly placeholder="서명 이미지를 첨부하세요">
										<input type="file" class="myEmpSign" onchange="myAddSignFile(this);" name="fileUploadCommand.uploadFile" style="display: none;"> 
									</div>
								</div>
							</div>
						</div>
						</form>
					</div>
				</div>
			</div>
	</div>
</div>





<!-- 다음 주소api -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
<script> 
var empId = '${loginUser.empId}';
getPicture(empId);

function getPicture(empId){
	var imageURL = "/JoinWorkGW/emp/getPicture?picture="+empId+".jpg";
	$('div#empPicture').css({'background-image':'url('+imageURL+')',
		'background-position':'center',
		'background-size':'cover',
		'background-repeat':'no-repeat'
	}).trigger("create");
}

//이 값이 true이고 수정 완료시 항상 로그인 화면으로(세션 초기화를 위해!!!)
var flag_empUpdate = false;
//최초 비밀번호 변경 여부
var flag_empUpdateYn = false;
checkEmpUdateYn();
function checkEmpUdateYn(){
	var msg = "";
	
	$.ajax({
		type:"POST",
		url:'/JoinWorkGW/emp/checkEmpUdateYn',
		contentType:"html/text",
		async: false,
		success: function(data) {
			msg = data;
		},
		error: function(e) {
			console.log(e);
		}
	});
	console.log(msg);
	
	//비밀번호 변경 필요할 시
	if(msg === 'fail'){
		$("#checkPwd").html("* 변경필요");
		alert("비밀번호 변경이 필요합니다.");
		window.open('/JoinWorkGW/common/password/modifyForm', '비밀번호수정', "width=700,height=650,left=600");
	}
	
	//비밀번호 변경 필요없을 시
	if(msg === 'success'){
		$("#checkPwd").html("");
		flag_empUpdateYn = true;
	}
	
}


//수정
function modify_go(){
	var msg = "";
	//사인 파일 있는지 없는지 체크
	$.ajax({
		type:"POST",
		url:"<c:url value='/emp/checkSignYn'/>",
		processData: false,  
		contentType: false,
		async: false,
		success: function(data) {
			msg = data;
		},
		error: function(e) {
			console.log(e);
		}
	});
	
	console.log(msg);
	
	if(msg == 'fail' && $(".myEmpSign")[0].files[0] === undefined){
		alert("첫 방문 시 사인을 필수로 등록하셔야 합니다.");
		$(".myEmpSign").click();
		return false;
	}
	
	
	
	var modifyForm = $("#modifyForm")[0];
	var uploadFiles = new FormData(modifyForm);
	if($(".myEmpSign")[0].files[0] !== undefined){
		$.ajax({
			type:"POST",
			url:"<c:url value='/emp/registSign'/>",
			processData: false,  
			contentType: false,
		 	data : uploadFiles,
			success: function(data) {
				console.log(data);
			},
			error: function(e) {
				console.log(e);
			}
		});
	}
	alert("수정이 완료되었습니다.");
	
	document.modifyForm.submit();
	
}




function home_go(){
	location.href = "<c:url value='/common/home' />";
}

function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if (data.userSelectedType === 'R') {
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("myAdd1").value = extraAddr;

            } else {
                document.getElementById("myAdd1").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
//             document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("myAdd1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("myAdd2").focus();
        }
    }).open();
}

//사인 파일관련
function addEmpSign(){
	$(".myEmpSign").click();
}

function myAddSignFile(obj) {
	if($(".myEmpSign")[0].files[0]){
		var empSign = $(obj)[0].files[0].name;
		
		var extension = getExtensionOfFilename(empSign);
		console.log(extension);
		
		if(!(extension == 'png')){
			alert("지원하지 않는 파일 형식입니다.");
			return false;
		}
		$("#myFileName").val(empSign);
	}else{
		$("#myFileName").val("");
		return false;
	}
}


//파일 확장자 추출 함수
function getExtensionOfFilename(filename) {
	 
    var _fileLen = filename.length;
 
    var _lastDot = filename.lastIndexOf('.');
 
    var _fileExt = filename.substring(_lastDot+1, _fileLen).toLowerCase();
 
    return _fileExt;
}


</script>
	
	
    
    


	
</body>
</html>