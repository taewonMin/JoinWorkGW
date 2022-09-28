<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<style>
label, div span, b, small{
	color:#000000;
	text-align: center;
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

#empEmail, #empEmailSel{
	width:46%;
	height: 26px;
}
#empRegnoSp{
	padding: 1%;
}
#empEmailSp{
	margin-left: 17px;
}
#pictureView{
	height: 200px; 
	width: 140px; 
	border: 1px solid #b5b5b566; 
	margin: 20px auto 40px;
	background-position: center;
	background-size: cover;
	background-repeat: no-repeat;
}
.form-control {
	height: 35px !important; 
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
#cancelBtn, #registBtn{
	margin-left: 10px;
	padding: 5px;
}
#essentialSpan{
	color:red;
	margin: 5px 0 0 0 ;
}
.form-control[readonly]{
	background-color: #ffffff;
}
td.day{
	width: 24px;
}
.datepicker-days{
    padding: 0 10px 0 12px;
    text-align: center;
}
#hiddenFillBtn:hover {
	background-color: #f7f7f7;
}
</style>
<body>


<!-- 메인 content -->
<div class="container-fluid">
	<!-- 메인 content 넣는 곳 -->
	<section class="content register-page">
		<div class="register-box">
			<!-- form start -->
			<div class="card">		
				<div class="register-card-body">
					<div class="card-header" style="font-family: S-CoreDream-4Regular">
						<div class="row">								
						 	<h4 class="col-sm-6" style="color:#000000; margin: auto; float:left;">직원 등록</h4>	
							<div class="col-sm-6">
								<button type="button" class="btn btn-outline-light" id="hiddenFillBtn" onclick="presentationFill();" style="position:absolute;right:13em;top:0px;color:#f7f7f7">시연용버튼</button>
								<button type="button" id="cancelBtn" onclick="CloseWindow();" class="btn btn-secondary float-right">&nbsp;&nbsp;&nbsp;취 &nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;</button>
								<button type="button" id="registBtn" onclick="regist_go();" class="btn btn-info float-right">&nbsp;&nbsp;&nbsp;등 &nbsp;&nbsp;록&nbsp;&nbsp;&nbsp;</button>
							</div>
						</div>
					</div>	
					<div class="card-body" style="font-family: S-CoreDream-4Regular">	
						<form role="form" name="registForm" class="form-horizontal" action="admin/emp/regist" method="post" autocomplete="off">
							<div class="input-group mb-2">
								<div class="mailbox-attachments clearfix" style="text-align: center;">
									<div class="mailbox-attachment-icon has-img" id="pictureView">
										<label id="pictureUploadLabel" for="inputFile">사진 선택</label>
										<button type="button" class="btn btn-info btn-sm btn-append uploadBtn" onclick="upload_go();">업로드</button>											
									</div>
									<div class="mailbox-attachment-info">
	<!-- 										<input id="inputFileName" class="form-control" type="text" name="tempPicture" disabled/> -->
										<input id="picture" class="form-control" type="hidden" name="empPicture" />
										<small style="color:red;">사원번호 생성 후 프로필사진을 등록해주세요.</small>
										<br/>
									</div>
								</div>
								<br />
							  </div>	
							<div class="form-group row" >
								<label for="empCreateDt" class="col-sm-2" style="font-size:0.9em;">
									입사일자<span id="essentialSpan">*</span>
								</label>
								<div class="col-sm-10 input-group-sm date">								
<!-- 									<input class="form-control" name="empCreateDt" type="date" id="empCreateDt" /> -->
<!-- 									<input type="date" class="form-control" name="empCreateDt" id="empCreateDt"/> -->
									<div class="input-group date" data-date-autoclose="true" data-provide="datepicker">
		                                <input id="empCreateDt" name="empCreateDt" placeholder="입사일자 선택" type="text" class="form-control" readonly="readonly" value="">
		                                <div class="input-group-append">                                            
		                                    <button class="btn btn-secondary" type="button"><i class="fa fa-calendar"></i></button>
		                                </div>
		                            </div>
								</div>
							</div>
						  <div class="form-group row">
								<label for="empId" class="col-sm-2" style="font-size:0.9em;" >
								 	아이디<span id="essentialSpan">&nbsp;*</span>
							 	</label>	
								<div class="col-sm-10 input-group input-group-sm">
									<input style="display: none;" name="empId" type="text" class="form-control" id="empId" placeholder="사원번호 생성버튼을 클릭하세요.">
									<button type="button" onclick="getEmpId();"  id="empIdBtn" class="btn btn-info btn-block btn-append">사원번호 생성</button>
								</div>								
							</div>
							<div class="form-group row">
								<label for="empName" class="col-sm-2" style="font-size:0.9em;">
									이름<span id="essentialSpan">&nbsp;*</span>
								</label>
								<div class="col-sm-10 input-group-sm">								
									<input class="form-control" name="empName" type="text" class="form-control" id="empName" maxlength="4" placeholder="4자 이하로 입력해주세요." />
								</div>
								
							</div>
							<div class="form-group row">
								<label for="empRegno" class="col-sm-2" style="font-size:0.9em; padding: 0px 10px;">
									주민등록번호<span id="essentialSpan">&nbsp;*</span>
								</label>
								<div class="col-sm-10 input-group-sm regnoDiv">								
									<input class="form-control float-left" name="empRegno" type="text" style="width:48%;" maxlength="6" class="form-control  float-left" id="empRegno1" placeholder="앞자리 6자리"/>
									<label id="empRegnoSp" class="float-left" style="padding: 0; text-align: center;" >&nbsp;-</label>
	<!-- 								<span id="empRegnoSp">-</span> -->
									<input class="form-control float-right" name="empRegno" type="password" style="width:48%;" maxlength="7" class="form-control float-right" id="empRegno2" placeholder="뒷자리 7자리" />
								</div>
								
							</div>
							<div class="form-group row">
								<label for="empHp" class="col-sm-2 control-label">전화번호</label>
								<div class="col-sm-10">	
									<div class="input-group">
										<select style="width:75px;" name="empHp" id="empHp" class="form-control float-left">
											<option value="">-선택-</option>
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="017">017</option>
											<option value="018">018</option>
										</select>							
										<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-&nbsp;</label>										
										<input style="width:68px;" name="empHp" type="text" maxlength="4" class="form-control float-left" />
										<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-</label>
										<input style="width:68px;" name="empHp" type="text" maxlength="4" class="form-control float-right" />						
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label for="codeOfficialId" class="col-sm-2 control-label">직책<span id="essentialSpan">&nbsp;*</span></label>
								<div class="col-sm-10">	
									<div class="input-group-sm">
										<select name="codeOfficialId" id="codeOfficialId" class="form-control float-left" style="width:75px;">
											<option value="">--선택--</option>
											<c:forEach items="${officialList }" var="code">
												<option value="${code.codeId}">${code.codeName }</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label for="empEmail" class="col-sm-2" style="font-size:0.9em;">이메일</label>
								<div class="col-sm-10 input-group-sm emailDiv">
									<input name="empEmail" type="text" class="form-control  float-left" maxlength="15" id="empEmail">
									<span id="empEmailSp">@</span>
									<select name="empEmail" id="empEmailSel" class="form-control  float-right">
											<option value="">-선택-</option>
											<option value="naver.com">naver.com</option>
											<option value="daum.net">daum.net</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="gmail.com">gmail.com</option>
											<option value="hotmail.com">hotmail.com</option>
											<option value="dreamwiz.com">dreamwiz.com</option>
											<option value="freechal.com">freechal.com</option>
											<option value="hanmir.com">hanmir.com</option>
									</select>	
								</div>
							</div>
						  <div class="form-group row">
								<label for="deptId" class="col-sm-2" style="font-size:0.9em;" >
								 	부서<span id="essentialSpan">*</span>
								</label>	
								<div class="col-sm-10 input-group input-group-sm">
									<select name="deptId" id="deptId" class="form-control float-left" style="width:75px;">
										<option value="">--선택--</option>
										<c:forEach items="${deptList }" var="dept">
											<option value="${dept.deptId }">${dept.deptName }</option>
										</c:forEach>
									</select>
								</div>								
							</div>
							<input style="display: none;" name="empPwd" type="password" class="form-control" id="empPwd">
						</form>		
					</div>			
				</div><!-- register-card-body -->
			</div>
		</div>
	</section>		<!-- /.content -->
</div>

<form role="imageForm" action="admin/emp/setPicture" method="post" enctype="multipart/form-data">
	<input id="inputFile" name="pictureFile" type="file" class="form-control" onchange="fileChange_go(this);" style="display:none;">
	<input id="oldFile" type="hidden" name="oldPicture" value="" />
	<input type="hidden" name="checkUpload" value="0" />	
	<input type="hidden" name="fileEmpId"/>
</form>

<script src="<%=request.getContextPath() %>/resources/fullcalendar/vendor/js/moment.min.js"></script>

<script> // 프로필사진 미리보기 & 업로드

// 미리보기
function fileChange_go(input){
	if(!$('#empId').val()){
		$('#inputFile').val('');
		alert('사원번호 생성 후 프로필사진을 등록해주세요.');
		
		return;
	}
	
	$('input[name="checkUpload"]').val(0);
	
	if(input.files && input.files[0]){ // 있으면
		var fileValue = $(input).val().split("\\");
		var fileName = fileValue[fileValue.length-1];
		//console.log("fileValue >> " + fileValue + ", fileName >> "+ fileName);
		//console.log("용량(byte) >> " + input.files[0].size);
		var fileType = fileName.split(".")[1].toUpperCase();
		//console.log("fileType >> " + fileType);
		
		if(!(fileType == 'PNG' || fileType == 'JPG' || fileType == 'JPEG')){
			alert('이미지 파일(jpg, jpeg, png)만 선택해주세요.');
			return;
		}else if(input.files[0].size > 1024 * 1024 * 1){
			alert('사진 용량은 1MB 이하만 가능합니다.');
			return;
		}
		
		$('#inputFileName').val(fileName);
		
		var reader = new FileReader();
		reader.onload = function(e){
			$('#pictureView').css('background-image', 'url('+e.target.result+')'); 
			//console.log("e.target.result >>" + e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}


//업로드
function upload_go(){
	if($('input[name="pictureFile"]').val() == ""){
		alert('사진을 선택하세요.');
		$('input[name="pictureFile"]').click();
		return;
	
	}
	
	var form = new FormData($('form[role="imageForm"]')[0]);
	
	console.dir($('form[role="imageForm"]')[0]);
	
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/emp/setPicture"
		,data:form
		,type:'post'
		,processData:false
		,contentType:false
		,success:function(result){
			//console.log('result >> ' + result);
			$('input[name="checkUpload"]').val(1);
			
			$('input#oldFile').val(result); // 변경시 삭제될 파일명?
			$('form[role="form"] input[name="empPicture"]').val(result);
// 			console.log('DB에 저장할 이름 >> ' + result);
			
			alert('사진이 업로드 되었습니다.');
		}
		,error:function(request, status, error){
			alert("사진 업로드에 실패했습니다.");
			console.log("error >> " + error);
		}		
	});
	
}


</script>

<script> // 사번생성
function getEmpId(){
	//alert('사번생성 클릭');
	var empCreateDate = $('#empCreateDt').val()
	var fomattingDate = moment(empCreateDate).format('YYYY-MM-DD');
	var sendData = {empCreateDt:fomattingDate}; // yyyy-MM-dd 
	
// 	console.log(fomattingDate);
	
	if(!empCreateDate){
		alert('입사일자 입력 후 생성 가능합니다.');
		return false;
	}
	var empId = '';
	$.ajax({
        url: "<%=request.getContextPath()%>/admin/emp/createid"
		,type: "post"
        ,data: sendData
        //,dataType:"text"
        //,contentType:"text/html;charset=utf-8"
        ,success: function (response) {
// 			console.log("응답 >> "+response);
			empId = response;
			$('#empId').css('display','').val(empId);
			$('#empIdBtn').css('display','none');
			$('input[name="fileEmpId"]').val(empId);
        }
        ,error: function(request, status, error){
     	   console.log("error 발생 >> " +error);
        }
	});
	
}
</script>



<script>

document.querySelector('#empRegno1').addEventListener('blur',function(){
	//alert('블러이벤트 발생!');
	var empRegno1 = $('#empRegno1').val();
// 	console.log(empRegno1);
	$('input[name="empPwd"]').val(empRegno1); // regno의 앞자리
// 	console.log($('input[name="empPwd"]').val());
	
});

function regist_go(){
	var checkUpload = $('input[name="checkUpload"]').val();
	
	
	// ----- 정규식 패턴 --- 
	var numberReg = /[0-9]/;
	var koreanReg = /[가-힣]/;
	var engNumReg = /[\w]/;
	
	
	// ----- 정규식 패턴 --- 
	
	var empName = $('#empName').val().trim();
	
	
	var empRegno = new Array();
	var empRegnoArr = $('input[name="empRegno"]').each(function(idx){
		empRegno[idx] = $(this).val().trim();
	});

	
	var codeOfficialId = $('#codeOfficialId option:selected');
	
	
	var deptId = $('#deptId option:selected');
	
	
	
	var empHp = new Array();
		empHp[0] = $('#empHp option:selected').val();
	var empHpArr = $('input[name="empHp"]').each(function(idx){
		empHp[idx+1] = $(this).val().trim();
	});
	

	
	var empEmail = new Array();
		empEmail[0] = $('#empEmail').val().trim();
		empEmail[1] = $('#empEmailSel option:selected').val();
	
	if(checkUpload == 0){
		alert('사진 업로드는 필수입니다.');
		return false;
	}else if(empName.length == 0){
		alert('이름은 필수입니다.');
		return false;
	}else if(!(koreanReg.test(empName))){
		console.log(empName); // 이름 한글로 잘 찍었는데 오류남.
		alert('이름은 한글만 4글자 이하로 입력할 수 있습니다.');	
		return false;
	}else if(!(numberReg.test(empRegno[0]) && numberReg.test(empRegno[1]))){
		alert('주민번호는 숫자만 입력해주세요.');
		return false;
	}else if(empRegno[0].length != 6){
		alert('주민번호 앞자리는 6자리로 입력해주세요.');
		return false;
	}else if(empRegno[1].length != 7){
		alert('주민번호 뒷자리는 7자리로 입력해주세요.');
		return false;
	}else if(!codeOfficialId.val()){
		alert('직책 선택은 필수입니다.');
		return false;
	}else if(!deptId.val()){
		alert('부서 선택은 필수입니다.');
		return false;
	}else if(empHp[0]){
		if(!(numberReg.test(empHp[1]) && numberReg.test(empHp[1]))){
			alert("전화번호는 숫자만 입력해주세요.");
			return false;
		}
	}else if(empEmail[1]){ 
		if(!engNumReg.test(empEmail[0])){
		alert("이메일은 영문 또는 숫자만 입력해주세요.");
		return false;
		}
	}else if(empEmail[0] && !empEmail[1]){
		alert('이메일 입력 시 도메인을 선택해주세요.');
		return false;
	}
		
	
	
	var registData = {
		empId : $('input[name="empId"]').val()
		,empName : $('input[name="empName"]').val()
		,empPwd : $('input[name="empPwd"]').val()
		,empRegno : empRegno	// 배열
		,empHp : empHp			// 배열
		,empPicture : $('input[name="empPicture"]').val()
		,deptId : $('#deptId').val() // select
		,empCreateDt : $('input[name="empCreateDt"]').val()
		,codeOfficialId : $('#codeOfficialId option:selected').val() // select
		,empEmail : empEmail // 일반input + select
		,authId : $('input[name="authId"]').val()
	}
	
	console.log("---- registData ----");
	console.log(registData);
	console.log("---- registData End----");
	
	$.ajax({
		 type: "post"
	     ,url: "<%=request.getContextPath()%>/admin/emp/regist"
	     ,data: JSON.stringify(registData)
	     ,dataType:"text"
	     ,contentType:"application/json;charset=utf-8"
	     ,success: function (response) {
	  	   console.log("응답 >> "+response);
	  	   var resultArr = response.split(",");
	  	   //console.log(resultArr[0] + " >> 0번방");
	  	   if(resultArr[0]=== "SUCCESS"){
	  		   alert("직원 등록이 완료되었습니다.");
	  		   CloseWindow();
	  	   }
	     }
	     ,error: function(request, status, error){
	  	   console.log("error 발생 >> " +error);
	     }
	});

}
</script>
<script> // 시연용
function presentationFill(){
// 	alert('클릭');
	$('#empName').val('김신혜');
	$('input[name="empRegno"]').each(function(idx){
		if(idx == 1){
			$(this).val('1234567');
		}
	});
	$('#codeOfficialId  option[value="O01"]').attr("selected",true);
	$('select[name="empHp"] option[value="010"]').attr("selected",true);
	$('input[name="empHp"]').each(function(idx){
		$(this).val('7979');
	});
	$('#empEmail').val('ksh7979');
	$('select[name="empEmail"] option[value="gmail.com"]').attr("selected",true);
	$('#deptId option[value="d01"]').attr("selected",true);
}
</script>

</body>