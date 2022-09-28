<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>


<head>
<title>:: 비밀번호 변경</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="description" content="Lucid Bootstrap 4x Admin Template">
<meta name="author" content="WrapTheme, design by: ThemeMakker.com">

<style>
#hiddenFillBtn:hover{background-color: #f4f7f6;}
</style>
</head>
<button type="button" class="btn btn-outline-light" id="hiddenFillBtn" onclick="presentationFill();" style="position:absolute;right:0;top:0;color:#f4f7f6; z-index: 100; border: 0px;">시연용버튼</button>
<body class="theme-blue" style="font-family: InfinitySans-RegularA1">


	<div style="text-align: center; margin: 100px;">
		<div class="card"
			style="width: 550px; padding-top: 20px; right: 30px">
			<div class="body">
				<div class="row clearfix">
					<div class="col-lg-12 col-md-12">
						<div style="margin-bottom: 40px;">
							<h6 style="font-size: 20px;">비밀번호 변경</h6>
							<p class="text-danger" style="font-size: 14px;">영문자, 숫자, 특수문자 최소 1개 포함 8 ~ 20 자리</p>
						</div>
						<div class="container-fluid">
							<div class="row" style="padding-bottom: 23px;">
								<div class="col-sm-3" >
									<p style="margin-top: 7px;">기존 비밀번호</p>
								</div>
								<div class="col-sm-9">
									<div class="form-group">
										<input type="password" id="oldPwd" class="form-control" placeholder="기존 비밀번호를 입력하세요">
									</div>
								</div>
							</div>
						</div>
						<div class="container-fluid">
							<div class="row" style="padding-bottom: 23px;">

								<div class="col-sm-3" >
									<p style="margin-top: 7px;">새 비밀번호</p>
								</div>
								<div class="col-sm-9">
									<div class="form-group">
										<input type="password" id="pwd1" class="form-control"  onclick="" placeholder="영문자,숫자,특수문자 최소 1개 포함 8 ~ 20 자리">
									</div>
									<div id="validatePwd" class="float-left">
										<span></span>
									</div>
								</div>
							</div>
						</div>
						<div class="container-fluid">
							<div class="row" style="padding-bottom: 23px;">
								<div class="col-sm-3" style="padding-right: 0px;">
									<p style="margin-top: 7px;">새 비밀번호 확인</p>
								</div>
								<div class="col-sm-9">
									<div class="form-group">
										<input type="password" id="pwd2" class="form-control" placeholder="새 비밀번호를 다시 한 번 입력해 주세요">
									</div>
									<div id="checkPwd1VsPwd2" class="float-left">
										<span></span>
									</div>
									
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-12 " >	
						<div class="float-right" style="padding-right: 15px;">
							<button class="btn btn-primary" data-type="success" onclick="updatePwd_go();">확인</button>
							<button class="btn btn-default" onclick="window.close();">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script src="<%=request.getContextPath()%>/resources/js/jquery-3.6.0.min.js"></script>

<script>

var flag_vaildate = false;
var flag_compare = false;


//유효성 검사
$(document).on("input","#pwd1",function(){
	var pwPattern = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+])(?!.*[^a-zA-z0-9$`~!@$!%*#^?&\\(\\)\-_=+]).{8,20}$/;
	var vaildateStr = "";
	var pwd1 = $("#pwd1").val();
	var pwd2 = $("#pwd2").val();
	var str = "";
	if(pwd2){
		if(pwd2 === pwd1 && pwd2 != ""){
			str = "<span></span>";
			flag_compare = true;
		}
		if(pwd2 !== pwd1){
			str = "<span style='color:red'>입력한 비밀번호가 서로 일치하지 않습니다.</span>";
			flag_compare = false;
		}
		$("#checkPwd1VsPwd2").html(str);
	}
	
	if(!pwPattern.test(pwd1)&& pwd1 != ""){
		vaildateStr = "<span style='color:red'>사용불가</span>";
		flag_vaildate = false;
	}else{
		vaildateStr = "<span style='color:blue'>안전</span>";
		flag_vaildate = true;
		if(pwd1.length >= 12){
			vaildateStr = "<span style='color:green'>매우안전</span>";
			flag_vaildate = true;
		}
	}
	
	if(pwd1 == ""){
		vaildateStr = "<span></span>";
		flag_vaildate = false;
	}
	$("#validatePwd").html(vaildateStr);
	
})

$(document).on("input","#pwd2",function(){
	var pwd1 = $("#pwd1").val();
	var pwd2 = $("#pwd2").val();
	str = "";
	
	if(pwd2 === pwd1 && pwd2 != ""){
		str = "<span></span>";
		flag_compare = true;
	}
	
	if(pwd2 !== pwd1){
		str = "<span style='color:red'>입력한 비밀번호가 서로 일치하지 않습니다.</span>";
		flag_compare = false;
	}
	$("#checkPwd1VsPwd2").html(str);
	
})


function updatePwd_go(){
	var msg = "";
	var empPwd = $("#oldPwd").val();
	var empVO = {"empPwd":empPwd}
	
	//모든 유효성 체크 후 DB에서 기존비밀번호 비교 
	if(flag_vaildate && flag_compare){
		$.ajax({
			type:"POST",
			url:'/JoinWorkGW/emp/compareEmpPwd',
			contentType:"application/json",
			async: false,
			data: JSON.stringify(empVO),
			success: function(data) {
				msg = data;
			},
			error: function(e) {
				console.log(e);
			}
		});
		
		if(msg === 'fail'){
			alert("기존 비밀번호와 다릅니다. 다시확인해주세요.");
			return false;
		}
		
	}else {
		alert("새로운 비밀번호의 유효성을 확인해주세요.");
		return false;
	}
	
	empVO.empPwd = $("#pwd2").val();
	$.ajax({
		type:"POST",
		url:'/JoinWorkGW/emp/updateEmpPwd',
		contentType:"application/json",
		async: false,
		data: JSON.stringify(empVO),
		success: function(data) {
			console.log(data);
		},
		error: function(e) {
			console.log(e);
		}
	});
	
	opener.parent.flag_empUpdate = true;
	opener.parent.checkEmpUdateYn();
	alert("비밀번호 변경이 완료되었습니다.");
	window.close();	
	
}




</script>
<script> // 시연용
function presentationFill(){

	$("#oldPwd").val('123456');
	$("#pwd1").val('ddit406');
	$("#pwd2").val('ddit406!');
	
}
</script>
</body>
</html>