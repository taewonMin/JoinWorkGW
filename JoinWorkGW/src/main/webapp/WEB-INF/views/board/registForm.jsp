  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.cookie.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.edit.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.async.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">
<style>
.formGroup{
 	display:none; 
}
</style>
    
<body>
<!-- Overlay For Sidebars -->
    <div id="main-content">
        <div class="container-fluid">
            <div class="block-header">
                <div class="row">
                	<div class="col-sm-3" >
                    	<h2 style="padding-left:10px; font-size:2em ; font-family:paybooc-Bold ; "><i class="icon-note"></i>&nbsp;글작성 </h2>
                    </div>
                    <div class="col-sm-9" style="font-family: S-CoreDream-4Regular">
                   		<div style="float:right;">
                   			<button type="button" class="btn hiddenFillBtn" onclick="presentationFill_1();" style="position:absolute;right:18em;top:0;color:#f4f7f6; z-index: 100; border: 0px;">시연용버튼1</button>
                        	<button type="button" class="btn btn-primary" style="width:100px;font-size:1.2em;" onclick="submit_go();">등록</button>
                        	<button type="button" onclick="window.close();" class="btn btn-secondary" style="width:100px;font-size:1.2em;">취소</button>
                    	</div>
                 	</div>
                </div>
            </div>

            <div class="row clearfix" style="font-family: S-CoreDream-4Regular">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="card">
                        <div class="body">
	                        <form:form commandName="boardFormVO" name="boardRegistForm">
	                        	<form:hidden path="noticeVO.empWriterId" value="${loginUser.empId }"/>
	                        	<form:hidden path="noticeVO.noticeUpdaterId" value="${loginUser.empId }"/>
	                        	<form:hidden path="noticeVO.noticeContent" />
	                            <div class="row clearfix">
		                           	<!-- 게시판 선택 -->
		                             <div class="col-md-3">
		                                 <label>게시판선택</label>
		                                 <div class="form-group">                                        
		                                     <select id="selectBoard" class="form-control show-tick" onchange="changeCategory(this);">
		                                         <option value="default">게시판 선택</option>
		                                         <option value="notice">사내공지</option>
		                                         <option value="cac">경조사</option>
		                                         <option value="anony">익명게시판</option>
		                                     </select>
		                                 </div>
		                             </div>
		                             <!-- 본문 -->
		                             <div class="col-md-3 col-sm-12 formGroup noticeForm cacForm">
		                                 <label class="boardWriter">작성자</label>
		                                 <div class="form-group">
		                                     <input type="text" readonly class="form-control" placeholder="" value="${loginUser.empName }" >
		                                 </div>
		                             </div>
		                             <div class="col-md-3 col-sm-12 formGroup noticeForm">
		                                 <label class="noticeImportantYN">필독여부</label>
		                                 <div class="form-group">
		                                 	<div class="form-group noticeImportantYN">
		                                     	<select name="noticeVO.noticeImportantYN" id="selectNoticeYN" class="form-control show-tick">
		                                     		<option value="default">-필독여부-</option>
		                                     		<option value="Y">설정</option>
		                                     		<option value="N">해제</option>
		                                     	</select>
		                                 	</div>
		                                 </div>
		                             </div>
		                             <div class="col-md-3 col-sm-12 formGroup cacForm">
		                                 <label class="cacCategory">분류</label>
		                                 <div class="form-group">
		                                 	<div class="form-group cacCategory">
		                                     	<select name="cacCategory" id="selectCacboard" class="form-control show-tick" onchange="cacGroup(this);">
		                                     		<option value="default">-분류 선택-</option>
		                                     		<option value="결혼">결혼</option>
		                                     		<option value="부고">부고</option>
<!-- 		                                     		<option value="기타">기타</option> -->
		                                     	</select>
		                                 	</div>
		                                 </div>
		                             </div>
		                             <div class="col-sm-12 formGroup noticeForm cacForm anonyForm">
		                                 <div class="form-group">
		                                 <label class="boardTitle">제목</label>
		                                     <input type="text" name="noticeVO.noticeTitle" id="boardTitle" class="form-control" placeholder="">
		                                 </div>
		                             </div>
		                             <div class="col-md-3 col-sm-12 formGroup cacForm">
		                                 <div class="form-group">
		                                 <label>행사 시작 일자</label>
		                                 	<div class="input-group cacStartDate" data-date-autoclose="true" data-provide="datepicker">
			                                 	<input type="text" id="cacStartDate" class="form-control" placeholder="행사 시작일자 선택">
				                                <div class="input-group-append">                                            
				                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
				                                </div>
			                                </div>
		                                 </div>
		                                </div>
		                                <div class="col-md-3 col-sm-12 formGroup cacForm">
		                                 <label>행사 종료 일자</label>
		                                 <div class="form-group">
		                                 	<div class="input-group cacEndDate" data-date-autoclose="true" data-provide="datepicker">
			                                 	<input type="text" id="cacEndDate" class="form-control" placeholder="행사 종료일자 선택">
				                                <div class="input-group-append">                                            
				                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
				                                </div>
			                                </div>
		                                 </div>
		                             </div>
		                             <div class="col-sm-12 formGroup dutyForm">
			                             <div class="col-sm-3" style="padding-left:0;">
			                                 <div class="form-group">
			                                 <label>완료 기한</label>
			                                 	<div class="input-group date" data-date-autoclose="true" data-provide="datepicker">
				                                 	<input type="text" class="form-control" id="boardEndDt" placeholder="완료일자 선택" readonly="readonly">
					                                <div class="input-group-append">                                            
					                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
					                                </div>
				                                </div>
			                                 </div>
		                                 </div>
		                             </div>
	                            </div>
                               

	                            <div class="row clearfix">
	                            	<!-- 파일 입력 -->
	                                <div class="col-12 formGroup noticeForm">
	                                <label>파일 첨부</label>
	                                    <input type="file" name="fileUploadCommand.uploadFile" class="dropify" style="height: 200px;">
	                                    <div class="mt-3"></div>
	                                </div>      
	                                <!-- 경조사 내용 -->
	                                <div class="col-sm-12 formGroup cacForm" >
		                                <div class="alert alert-danger alert-dismissible" role="alert" style="font-family: S-CoreDream-6Bold ">
	                                		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
	                                		<i class="fa fa-exclamation-circle"></i> ※ 분류를 먼저 선택 후 다음의 예시에 따라 작성해 주세요 ※
	                            		</div>
	                            	</div>
	                                <!-- 내용 입력 -->                          
	                                <div class="col-sm-12 formGroup noticeForm cacForm anonyForm">
	                                    <div class="summernote"style="height: 200px;">
	                                	</div>
	                                </div>
	                            </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</div>

<form name="temp">
</form>


<form name="cacRegistForm" method="post">
	<input type="hidden" name="cacBoardTitle">
	<input type="hidden" name="cacBoardContent" >
	<input type="hidden" name="cacBoardUpdaterId" value="${loginUser.empId }">
	<input type="hidden" name="empWriterId" value="${loginUser.empId }">
	<input type="hidden" name="cacStartDt">
	<input type="hidden" name="cacEndDt">
	<input type="hidden" name="cacCategory">
</form>

<form name="anonyRegistForm" method="post">
	<input type="hidden" name="anonyBoardTitle">
	<input type="hidden" name="anonyBoardContent">
	<input type="hidden" name="anonyBoardUpdaterId" value="${loginUser.empId }">
	<input type="hidden" name="empWriterId" value="${loginUser.empId }">
</form>

<script>
// 경조사 글 양식 폼 출력
function cacGroup(obj){
	var category = $(obj).val();
	
	var content = '';
	if(category == '결혼'){
		content = '불철주야팀 장민수 사원이<br>'
				 +'소중한 인연을 만나 한 가정을 이루게 되었습니다.'
				 +'<br>많은 축복과 격려 부탁드리겠습니다!'
				 +'<br>'
				 +'<br>'
				 +'♥ 일     시 : 2021년 7월 3일(토요일)  오전 11:00'
				 +'<br>'
				 +'<br>'
				 +'♥ 장     소 : 금산군 GCC 웨딩홀'
				 +'<br>'
				 +'<br>'
				 +'♥ 연 락 처 : 장민수 과장(9310)'
				 +'<br>'
				 +'<br>'
				 +'※ 마음 전하실 곳 : 농협 351-0826-6649-33  장민수'
				 +'<br>';
	}else if(category == '부고'){
			content = '세무과 나문찬 팀장님의 빙부(故 오희종, 향년 93세)께서<br>'
				 +'<br>별세하셨음을 삼가 알려드립니다.'
				 +'<br>'
				 +'<br>'
				 +'○ 별 세 일 : 2021년 3월 24일'
				 +'<br>'
				 +'○ 빈    소 : 전북 익산시 원광대 장례문화원'
				 +'<br>'
				 +'○ 발    인 : 2021년 3월 26일(금)'
				 +'<br>'
				 +'○ 장    지 : 익산시 영모원'
				 +'<br>'
				 +'○ 연 락 처 : 나문찬 팀장 (6948)'
				 +'<br>'
				 +'※ 마음 전하실 곳 : 우리은행 1002-228-908820 송행정 '
				 +'<br>';		
			
	}
	
	$('.note-editable').html(content);
}

// 게시판 그룹 변경시 입력 폼 설정
function changeCategory(obj){
	$('.formGroup').css('display','none');
	$('.boardWriter').text('작성자');
	$('.boardTitle').text('제목');
	$('.note-editable').html("");
	$('.'+obj.value+"Form").css("display",'block');
}

// 글 등록
function submit_go(){
	var boardCategory = $('#selectBoard').val();
	var form = document.boardRegistForm;
	
	if(boardCategory=='default'){
		alert('게시판을 선택하세요.');
		return;
	}
	if($.trim($('#boardTitle').val())==""){
		alert('제목을 입력하세요.');
		$('#boardTitle').focus();
		return;
	}
	
	//사내공지
	if(boardCategory=='notice'){
		var noticeImportantYN = $('select[name="noticeVO.noticeImportantYN"]').val();
		if(noticeImportantYN == "default"){	//위에서 option value가 default일 경우에 해당할때
			alert('필독여부를 선택해주세요.');
			return;
		}
		
		$('input[name="noticeVO.noticeContent"]').val($('.note-editable').html());
		
		form.action = "<c:url value='/board/notice/regist'/>";
		form.encoding = "multipart/form-data";
	}
	//경조사
	else if(boardCategory=='cac'){
		if($.trim($('#selectCacboard').val())==""){
			alert('경조사 분류를 선택하세요.');
			$('#selectCacboard').focus();
			return;
		}
		if($.trim($('#cacStartDate').val())==""){
			alert('행사 시작일자를 설정하세요');
			$('#cacStartDate').focus();
			return;
		}
		if($.trim($('#cacEndDate').val())==""){
			alert('행사 종료일자를 설정하세요');
			$('#cacEndDate').focus();
			return;
		}
		
		form = document.cacRegistForm;
		
		var cacBoardTitle = $('#boardTitle').val();
		$('input[name="cacBoardTitle"]').val(cacBoardTitle);
		
		var boardContent = $('div.note-editable').html();
		$('input[name="cacBoardContent"]').val(boardContent);
		
		var cacStartDate = $('#cacStartDate').val();
		$('input[name="cacStartDt"]').val(cacStartDate);
		
		var cacEndDate = $('#cacEndDate').val();
		$('input[name="cacEndDt"]').val(cacEndDate);
		
		var cacCategory = $('#selectCacboard').val();
		$('input[name="cacCategory"]').val(cacCategory);
		
		form.action = "<c:url value='/board/cac/regist'/>";
	}
	
	//익명 게시판
	else if(boardCategory=='anony'){
		form = document.anonyRegistForm;
		var boardTitle = $('input#boardTitle').val();
		$('input[name="anonyBoardTitle"]').val(boardTitle);
		
		var boardContent = $('div.note-editable').html();
		$('input[name="anonyBoardContent"]').val(boardContent);
	
		form.action = "<c:url value='/board/anony/regist'/>";
	}
	
	// 글 등록
	var formData = new FormData(form);
	$.ajax({
		url:form.action,
		type:'post',
		data:formData,
		processData:false,
		contentType:false,
		dataType:"text",
		success:function(data){
			if(boardCategory=='notice'){
				alert("공지게시판에 글이 등록되었습니다.");
				window.close();
				window.opener.location.href='<c:url value="/board/notice/list" />';
				
			}else if(boardCategory=='cac'){
				alert("경조사게시판에 글이 등록되었습니다.");
				window.close();
				window.opener.location.href='<c:url value="/board/cac/list" />';
				
			}else if(boardCategory=='anony'){
				alert("익명게시판에 글이 등록되었습니다.");
				window.close();
				window.opener.location.href='<c:url value="/board/anony/list" />'
			}
		},
		error:function(){
			alert("글 등록에 실패했습니다.");
			window.opener.location.reload(true);
			window.close();
		}
	});
}
</script>
<script> //시연
function presentationFill_1(){
	$("#boardTitle").val('총무기획부 장민수 과장님 결혼식을 축하해주세요.');
	$("#cacStartDate").val('05/12/2021');
	$("#cacEndDate").val('05/12/2021');
}	

</script>
</body>
