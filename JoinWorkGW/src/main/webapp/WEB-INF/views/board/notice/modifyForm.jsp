<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <jsp:include page="../sidebar.jsp" /> --%>
<head>
<!-- VENDOR CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/sweetalert/sweetalert.css"/>

<!-- MAIN CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/templates/light/assets/css/main.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/templates/light/assets/css/color_skins.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/templates/light/assets/fonts/font.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/templates/light/assets/bundles/libscripts.bundle.js"></script>
<script src="<%=request.getContextPath()%>/resources/templates/light/assets/bundles/vendorscripts.bundle.js"></script>
<script src="<%=request.getContextPath()%>/resources/templates/light/assets/bundles/mainscripts.bundle.js"></script>
<script src="<%=request.getContextPath()%>/resources/templates/assets/vendor/sweetalert/sweetalert.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/templates/light/assets/js/pages/ui/dialogs.js"></script>

</head>

<!-- MAIN CSS -->

<style>
.pagination {
	text-align: center;
}

#tr1 {
/* 	text-align: center; */
	padding-left: -10px;
}

tbody {
	text-align: center;
	"
}

.td2 {
	text-align: left;
}

.card{
/* 	text-align: center; */
	padding-bottom: 30px;
}

.button1{
	text-align: right;
    padding-right: 38px;
}

.body{	
    padding-top: 15px;
    padding-left: 17px;
    padding-right: 17px;	

}


</style>

<body>

	<!-- 메인 content -->
	<div id="main-content">
		<div class="container-fluid" style="font-family: S-CoreDream-4Regular" >
			<div class="row clearfix">
				<div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-4Regular" >
					<h2>
						<i class="fa fa-bullhorn"></i>&nbsp;사내공지
					</h2>
					<hr>
				</div>
			</div>
			<div class="div2">
				<div class="row clearfix">
					<div class="col-lg-12 col-md-12">
					<form:form commandName="boardFormVO" name="noticeModifyForm" action="${pageContext.request.contextPath }/board/notice/modify" enctype="multipart/form-data">
						<form:hidden path="noticeVO.noticeId" />
			          	<form:hidden path="noticeVO.noticeContent" id="noticeContent"/>
			          	<form:hidden path="noticeVO.noticeUpdaterId" value="${loginUser.empId }"/>
			          	<form:hidden path="noticeVO.empWriterId" value="${loginUser.empId }"/>
			          	<div id="fileUploadForm">
			          	</div>
		          		<div id="deleteFile">
		          		</div>
						<div class="card">
							<div class="body project_report">

								<div class="body">
									<div class="table-responsive">
										<table class="table table-hover m-b-0">
											<thead class="shadow-none p-3 mb-5 bg-light rounded">
								<tr>
									<td style="width:130px;">
										<h6 id="h6" style="font-weight: bold;">제목</h6>
									</td>
									<td colspan="5">
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<form:textarea path="noticeVO.noticeTitle" style="width: 100%; height: 30px; "/>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<strong>작성일자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">
										
											<fmt:formatDate value="${boardFormVO.noticeVO.noticeCreateDt }" pattern="yyyy-MM-dd"/>
<%-- 											<fmt:parseDate value='${notice.noticeCreateDt}' var='noticeCreateDt1' pattern='yyyy-mm-dd'/> --%>
<%-- 											<fmt:formatDate value="${noticeCreateDt1}" pattern="yyyy-mm-dd"/> --%>
										</div>
										
									</td>
									<td>
										<strong>작성자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">${boardFormVO.noticeVO.empName }</div>
									</td>
									<td>
										<strong>조회수</strong>
									</td>
									<td>
										<div style="padding-left:15px; border-left: 1px dotted gray;">${boardFormVO.noticeVO.noticeReadcnt }</div>
									</td>
								</tr>
								<tr>
									<th style="width: 15%;">
										<i class="fa fa-download"></i>
										<strong>첨부파일</strong>
										<a href="javascript:void(0);" id="showFileWindow" style="margin-left:10px;font-weight: normal;" onclick="toggleFileContent();"><i class="icon-note"></i>수정</a>
										<a href="javascript:void(0);" id="hideFileWindow" style="margin-left:10px;font-weight: normal;display:none;" onclick="toggleFileContent();"><i class="fa fa-times"></i> 닫기</a>
									</th>
									<th colspan="5">
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<div id="attachInline">
												<c:if test="${!empty boardFormVO.noticeVO.noticeAttachList }">
													<c:forEach items="${boardFormVO.noticeVO.noticeAttachList }" var="noticeAttach" varStatus="status">
														<!-- 파일 입력 -->
						                                <span class="attach_${status.index }" style="font-weight: normal; margin-right:15px;">
						                                	<c:choose>
						                                		<c:when test="${noticeAttach.attachType eq 'JPG' || noticeAttach.attachType eq 'PNG' || noticeAttach.attachType eq 'GIF'}">
							                                		<i class="fa fa-file-photo-o"></i>
						                                		</c:when>
						                                		<c:otherwise>
							                                		<i class="fa fa-file-text-o"></i>
						                                		</c:otherwise>
						                                	</c:choose>
															&nbsp;${noticeAttach.attachName }
														</span>   
													</c:forEach>
												</c:if>
												<c:if test="${empty boardFormVO.noticeVO.noticeAttachList }">
													<span id="noFile" style="font-weight: normal;">없음</span>
												</c:if>
											</div>
											<div id="attachBox" style="display:none;">
												<button type="button" class="btn btn-secondary" style="margin-bottom:5px;" onclick="myFileUpload();">파일 추가</button>
												<span class="float-right" style="margin:15px 10px 0 0;">파일 개수 <span id="fileCount">${empty boardFormVO.noticeVO.noticeAttachList ? 0 : boardFormVO.noticeVO.noticeAttachList.size()}</span>/5</span>
												<div style="border:1px solid gray;height:200px;overflow-y: scroll;">
													<table class="table table-hover center-aligned-table" style="margin-bottom: 0;">
														<thead style="height:50px;">
															<tr>
																<th style="width:200px;">타입</th>
																<th style="width:300px;">파일명</th>
																<th style="width:200px;">확장자</th>
																<th style="width:200px;">용량</th>
																<th style="width:100px;"><i class="fa fa-trash-o" style="cursor: pointer;" onclick="removeAll();"></i></th>
															</tr>
														</thead>
					                                    <tbody id="appendTbody">
															<!-- 파일 입력 -->
					                                    	<c:if test="${!empty boardFormVO.noticeVO.noticeAttachList }">
																<c:forEach items="${boardFormVO.noticeVO.noticeAttachList }" var="noticeAttach" varStatus="status">
							                                    	<tr>
							                                    		<td>
							                                    			<c:choose>
							                                    				<c:when test="${noticeAttach.attachType eq 'JPG' || noticeAttach.attachType eq 'PNG' || noticeAttach.attachType eq 'GIF'}">
								                                    				이미지
							                                    				</c:when>
							                                    				<c:otherwise>
								                                    				파일
							                                    				</c:otherwise>
							                                    			</c:choose>
							                                    		</td>
							                                    		<td style="font-weight: normal;">
																			${noticeAttach.attachName }
							                                    		</td>
							                                    		<td style="font-weight: normal;">
																			${noticeAttach.attachType }
							                                    		</td>
							                                    		<td style="font-weight: normal;">
							                                    			${noticeAttach.attachSize }
							                                    		</td>
							                                    		<td>
																			<i class="icon-close" data-id="${status.index }" data-attachId="${noticeAttach.attachId }" style="cursor: pointer;" onclick="removeEl(this)"></i>
							                                    		</td>
							                                    	</tr>
																</c:forEach>
															</c:if>
						                                </tbody>	
					                                </table>
												</div>
											</div>
										</div>
									</th>
								</tr>
								<tr>
									<th colspan="6" style="padding:15px;">
										<div class="summernote">${boardFormVO.noticeVO.noticeContent }</div>
									</th>
								</tr>
							</thead>
						</table>
							<div class="modifySuccessbutton" style="text-align: center; margin-top: 5px;">
                           		<button type="button" class="btn btn-primary " data-type="success" onclick="modify_go();" >수정완료</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form:form>
		</div>
	</div>
</div>
</div>
</div>

<script>
//파일 첨부 창 보이기/닫기
function toggleFileContent() {
	if($("#hideFileWindow").css("display") == "none"){	// 수정창 열기
		$("#showFileWindow").css("display","none");
		$("#hideFileWindow").css("display","");
		
		$('#attachInline').css('display','none');
		$('#attachBox').css('display','');
	}
	else{	// 수정창 닫기
		$("#hideFileWindow").css("display","none");
		$("#showFileWindow").css("display","");
		
		$('#attachInline').css('display','');
		$('#attachBox').css('display','none');
	}
}

//파일 다운로드
function fileDownload(obj){
	var fileForm = $('form[name="fileForm"]');
	$('input[name="attachId"]').val($(obj).attr('data-attachId'));
	$('input[name="fileUploadPath"]').val($(obj).attr('data-filePath'));
	fileForm.submit();
}

//열고 닫는 함수입니다.
function plusFromMinus(obj){
	if($(obj).hasClass("expandable-hitarea")){
		$(obj).parent("li").removeClass("expandable lastExpandable");
		$(obj).parent("li").addClass("collapsable lastCollapsable");
		$(obj).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).parent("li").children("ul").css("display","block");
	}else{
		$(obj).parent("li").removeClass("collapsable lastCollapsable");
		$(obj).parent("li").addClass("expandable lastExpandable");
		$(obj).removeClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).addClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).parent("li").children("ul").css("display","none");
	}
}

//파일 첨부 창 보이기/닫기
function toggleFileContent() {
	if($("#hideFileWindow").css("display") == "none"){	// 수정창 열기
		$("#showFileWindow").css("display","none");
		$("#hideFileWindow").css("display","");
		
		$('#attachInline').css('display','none');
		$('#attachBox').css('display','');
	}
	else{	// 수정창 닫기
		$("#hideFileWindow").css("display","none");
		$("#showFileWindow").css("display","");
		
		$('#attachInline').css('display','');
		$('#attachBox').css('display','none');
	}
}

//파일 삭제용 고유 아이디
var uuid = ${empty boardFormVO.noticeVO.noticeAttachList ? 0 : boardFormVO.noticeVO.noticeAttachList.size()};
// 파일 업로드 버튼 클릭시
function myFileUpload() {
	if($('#appendTbody').children().length == 5){
		alert('파일은 5개까지만 첨부할 수 있습니다.');
		return;
	}
	
	// 선택 안된 파일 지우기
	$('.attach_'+uuid).remove();
	
	var input = $('<input>').attr({"type":"file",'class':'attach_'+uuid,"name":"fileUploadCommand.uploadFile",'onchange':'myFileChange();'}).css('display','none');
	$("#fileUploadForm").append(input);
	
	// 파일 선택
	var inputFileTag = $("input[name='fileUploadCommand.uploadFile']");
	inputFileTag.eq(inputFileTag.length-1).click();
}

//파일 선택시
function myFileChange(){
	var inputFileTag = $("input[name='fileUploadCommand.uploadFile']");
	var filesLength = inputFileTag.length;
	
	var fileName = inputFileTag.eq(filesLength-1)[0].files[0].name;
	var extension = getExtensionOfFilename(fileName);
	var fileSize = (inputFileTag.eq(filesLength-1)[0].files[0].size)/1000 + "KB";
	var fileType;
	
	if(!(extension == 'PNG' || extension == 'DOC' || extension == 'DOCX'|| extension == 'EXE' || extension == 'GIF' || extension == 'JAVA' || extension == 'JPG' || extension == 'PDF'|| extension == 'PPT' || extension == 'PPTX'|| extension == 'TXT' || extension == 'XLSX'|| extension == 'ZIP')){
		alert("지원하지 않는 파일 형식입니다.");
		inputFileTag.eq(filesLength-1).remove();
		return;
	}
	if(extension == 'PNG' || extension == 'GIF' || extension == 'JPG'){
		fileType = '이미지';
	}else{
		fileType = '파일';
	}
	
	// 파일 업로드 창에 표시하기
	var fileTag = '<tr>'
				 +'<td>'+fileType+'</td>'
				 +'<td style="font-weight: normal;">'+fileName+'</td>'
				 +'<td style="font-weight: normal;">'+extension+'</td>'
				 +'<td style="font-weight: normal;">'+fileSize+'</td>'
				 +'<td><i class="icon-close" data-id="'+uuid+'" style="cursor: pointer;" onclick="removeEl(this)"></i></td>'
				 +'</tr>';
	$('#appendTbody').append(fileTag);
	
	// 닫기상태 창에 표시하기
	var sumnail = '<span class="attach_'+uuid+'" style="font-weight: normal; margin-right:15px;">'
				 +(fileType=='이미지' ? '<i class="fa fa-file-photo-o"></i>' : '<i class="fa fa-file-text-o"></i>') 
			 	 +'&nbsp;'+fileName
				 +'</span>';
	$('#attachInline').append(sumnail);
	
	// 파일개수 수정
	$('#fileCount').text($('#appendTbody').children().length);
	
	$('#noFile').remove();
	
	uuid++;
}

//파일 확장자 추출 함수
function getExtensionOfFilename(filename) {
	 
    var _fileLen = filename.length;
 
    var _lastDot = filename.lastIndexOf('.');
 
    var _fileExt = filename.substring(_lastDot+1, _fileLen).toUpperCase();
 
    return _fileExt;
}

//파일 전체 삭제
function removeAll(){
	if($('#appendTbody').children().length == 0) return;
	
	var check = confirm('파일을 전부 삭제하시겠습니까?');
	if(!check) return;
	
	$("input[name='fileUploadCommand.uploadFile']").remove();
	$('#appendTbody').children().each(function(){
		if($(this).find('i').attr('data-attachId')){
			$('#deleteFile').append('<input type="hidden" name="fileUploadCommand.deleteFileIds" style="display:none;" value="'+$(this).find('i').attr('data-attachId')+'"/>');
		}
		$(this).remove();
	});
	
	$('#attachInline').children().remove();
	$('#attachInline').append('<span id="noFile" style="font-weight: normal;">없음</span>');
	
	// 파일개수 수정
	$('#fileCount').text(0);
}

// 선택 파일 삭제
function removeEl(obj){
	var check = confirm('파일을 삭제하시겠습니까?');
	if(!check) return;

	if($(obj).attr('data-attachId')){
		$('#deleteFile').append('<input type="hidden" name="fileUploadCommand.deleteFileIds" style="display:none;" value="'+$(obj).attr('data-attachId')+'"/>');
	}
	
	$(obj).closest('tr').remove();
	$(".attach_"+$(obj).attr('data-id')).remove();
	
	// 파일개수 수정
	$('#fileCount').text($('#appendTbody').children().length);
}

//수정 sweetAlert
// $(function () {
//     $('.js-sweetalert').on('click', function () {
//         var type = $(this).data('type');
//         if (type === 'basic') {
//             showBasicMessage();
//         }
        
//         else if (type === 'confirm') {
//             showConfirmMessage();
//         }
//     });
// });

//수정
function modify_go(){
	var modifyForm = $('form[name="noticeModifyForm"]')[0];
	
	if($.trim($('textarea[name="noticeVO.noticeTitle"]').val())==""){
		alert('제목을 입력하세요.');
		$('textarea[name="noticeVO.noticeTitle"]').focus();
		return;
	}
	
	if($.trim($('.note-editable').text())==""){
		alert('내용을 입력하세요.');
		$('.note-editable').focus();
		return;
	}
	$('#noticeContent').val($('.note-editable').html());

	// 선택 안된 파일 지우기
	$('.attach_'+uuid).remove();
	
	var formData = new FormData(modifyForm);
	
	$.ajax({
		url:modifyForm.action,
		type:'post',
		data:formData,
		processData:false,
		contentType:false,
		success:function(data){
			alert("글이 수정되었습니다.");
			
// 			$('input[name="noticeVO.empManagerList"]').each(function(){
// 				var empId = $(this).val();

			window.location.href='<c:url value="/board/notice/detail?noticeId=${boardFormVO.noticeVO.noticeId}" />';	
		},
		error:function(){
			alert("글 수정에 실패했습니다.");
			window.location.href='<c:url value="/board/notice/detail?noticeId=${boardFormVO.noticeVO.noticeId}" />';	
		}
	});
}

</script>


</body>
			