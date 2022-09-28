<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.cookie.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.edit.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.async.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<style>
#hiddenFillBtn:hover{
	background-color: #f4f7f6;
	color:#f4f7f6;
}
</style>
<button type="button" class="btn btn-outline-light" id="hiddenFillBtn" onclick="presentationFill();" style="position:absolute;right:25px;top:140px;color:#f4f7f6; z-index: 100; border: 0px;">시연용버튼</button>

<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
		<div class="block-header">
            <div class="row">
            	<div class="col-sm-5">
                	<h2 style="padding-left:10px;font-size:2em; font-family: S-CoreDream-4Regular"><i class="icon-note"></i>&nbsp;문서 작성</h2>
                </div>
                <div class="col-sm-7" >
               		<div style="float:right; font-family: S-CoreDream-4Regular">
                    	<button type="button" class="btn btn-primary" style="width:80px;" onclick="regist_go();">등록</button>
                    	<button type="button" onclick="javascript:window.close();" class="btn btn-secondary" style="width:80px;">취소</button>
                	</div>
             	</div>
            </div>
        </div>
        <div class="row clearfix" style="font-family: S-CoreDream-4Regular">
            <div class="col-lg-12 col-md-12 col-sm-12">
            	<form:form commandName="docFormVO" name="docModifyForm" action="${pageContext.request.contextPath }/doc/regist" enctype="multipart/form-data">
		          	<form:hidden path="docVO.docId"/>
		          	<form:hidden path="docVO.docContent" id="docContent"/>
		          	<form:hidden path="docVO.empWriterId" value="${loginUser.empId }"/>
		          	<div id="fileUploadForm">
		          	</div>
		          	<div id="deleteFile">
		          	</div>
					
                 <div class="body">
                     <div class="row clearfix">
                      <div class="table-responsive" style="padding:5px 15px;">
							<!-- 게시판 선택 -->
                        <div class="col-md-3" style="padding-left: 0px;">
                            <div class="form-group">                                        
                                
                                <form:select id="selectBoard"  path="docVO.docIndividualCheck" class="form-control show-tick">
									<form:option value="default" label="문서 분류를 선택해주세요" />
									<form:option value="myDoc" label="내 문서" />
									<form:option value="teamDoc" label="팀 문서" />
									<form:option value="deptDoc" label="부서 문서" />
									<form:option value="appDoc" label="결재 문서" />
								</form:select>
                            </div>
                           <div>
                                <form:select id="selectImportance"  path="docVO.docImportance" class="form-control show-tick">
									<form:option value="1" label="일반" />
									<form:option value="2" label="관심" />
									<form:option value="3" label="중요" />
								</form:select>
                           </div>
                        </div>
                        
						<table class="table table-hover m-b-0">
							<thead class="shadow-none p-3 mb-5 bg-light rounded">
							<!-- 게시판 선택 -->
								<tr>
		                        </tr>
								<tr>
									<td style="width:130px;">
										<strong>제목</strong>
									</td>
									<td colspan="5">
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<form:textarea path="docVO.docTitle" id="docTitle" style="width:100%;"></form:textarea>
										</div>
									</td>
								</tr>
								
								<tr>
									
									<td style="width:130px;">
										<strong>작성자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">${loginUser.empName }</div>
									</td>
									<td>
										<strong>작성일자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;" >
										<fmt:formatDate value="${docFormVO.docVO.docCreateDt }" pattern="yyyy-MM-dd"/>
<!-- 											<p id="date"> -->
										</div>
									</td>
								</tr>
								<tr>
									<th style="width:160px;vertical-align: top;">
										<i class="fa fa-download"></i>
										<strong>첨부파일</strong>
										<a href="javascript:void(0);" id="showFileWindow" style="margin-left:10px;font-weight: normal;" onclick="toggleFileContent();"><i class="icon-note"></i>수정</a>
										<a href="javascript:void(0);" id="hideFileWindow" style="margin-left:10px;font-weight: normal;display:none;" onclick="toggleFileContent();"><i class="fa fa-times"></i> 닫기</a>
									</th>
									<th colspan="5">
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<div id="attachInline">
													<span id="noFile" style="font-weight: normal;">없음</span>
											</div>
											<div id="attachBox" style="display:none;">
												<button type="button" class="btn btn-secondary" style="margin-bottom:5px;" onclick="myFileUpload();">파일 추가</button>
												<span class="float-right" style="margin:15px 10px 0 0;">파일 개수 <span id="fileCount">${empty boardFormVO.dutyVO.dutyAttachList ? 0 : boardFormVO.dutyVO.dutyAttachList.size()}</span>/5</span>
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
					                                    	<c:if test="${!empty docFormVO.docVO.docAttachList }">
																<c:forEach items="${docFormVO.docVO.docAttachList }" var="docAttach" varStatus="status">
							                                    	<tr>
							                                    		<td>
							                                    			<c:choose>
							                                    				<c:when test="${docAttach.attachType eq 'JPG' || docAttach.attachType eq 'PNG' || docAttach.attachType eq 'GIF'}">
								                                    				이미지
							                                    				</c:when>
							                                    				<c:otherwise>
								                                    				파일
							                                    				</c:otherwise>
							                                    			</c:choose>
							                                    		</td>
							                                    		<td style="font-weight: normal;">
																			${docAttach.attachName }
							                                    		</td>
							                                    		<td style="font-weight: normal;">
																			${docAttach.attachType }
							                                    		</td>
							                                    		<td style="font-weight: normal;">
							                                    			${docAttach.attachSize }
							                                    		</td>
							                                    		<td>
																			<i class="icon-close" data-id="${status.index }" data-attachId="${docAttach.attachId }" style="cursor: pointer;" onclick="removeEl(this)"></i>
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
								<!-- 내용 -->
								<tr>
									<th colspan="6" style="padding:15px;">
										<div class="summernote" id="summernote">
	                                    </div>
									</th>
								</tr>
							</thead>
						</table>
						</div>
					</div>
                 </div>
			</form:form>
            </div>
        </div>
	</div>
</div>

<script>
var today = new Date();
var year = today.getFullYear();
var month = today.getMonth()+1;
var day = today.getDate();
function tellMonth() {
	var date = document.getElementById("date");
	format.innerHTML = date;
	var format = year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+day.toString()).slice(-2));
}

</script>

<script type="text/javascript">

// 파일 첨부 창 보이기/닫기
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
var uuid = ${empty docFormVO.docVO.docAttachList ? 0 : docFormVO.docVO.docAttachList.size()};
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

// 파일 선택시
function myFileChange(){
	var inputFileTag = $("input[name='fileUploadCommand.uploadFile']");
	var filesLength = inputFileTag.length;
	
	var fileName = inputFileTag.eq(filesLength-1)[0].files[0].name;
	var extension = getExtensionOfFilename(fileName);
	var fileSize = (inputFileTag.eq(filesLength-1)[0].files[0].size)/1000 + "KB";
	var fileType;
	
	if(!(extension == 'PNG' || extension == 'DOC' || extension == 'EXE' || extension == 'GIF' || extension == 'JAVA' || extension == 'JPG' || extension == 'PDF'|| extension == 'PPT'|| extension == 'TXT' || extension == 'XLSX'|| extension == 'ZIP')){
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

// 파일 전체 삭제
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

// 수정
function regist_go(){
	var modifyForm = $('form[name="docModifyForm"]')[0];
	var docCategory = $('#selectBoard').val();

	if($.trim($('#docTitle').val())==""){
		alert('제목을 입력하세요.');
		$('#docVO.docTitle').focus();
		return;
	}else if($.trim($('.note-editable').text())==""){
		alert('업무 내용을 입력하세요.');
		$('.note-editable').focus();
		return;
	}else if(docCategory == 'default'){
		alert('문서 분류를 선택해주세요.');
		$('#selectBoard').focus();
		return;
	}
	
	$('#docContent').val($('.note-editable').text());

	
	
	// 선택 안된 파일 지우기
	$('.attach_'+uuid).remove();
	
	var formData = new FormData(modifyForm);
	
	for (var key of formData.keys()) {
		console.log(key);
	}

	for (var value of formData.values()) {
		console.log(value);
	}
	
	
	
	
	
	/*문서분류 선택 알림*/
	if($('#selectBoard').val() != "default" || $('#appendTbody').children().length <  1 ){
		
		$.ajax({
			url:modifyForm.action,
			type:'post',
			data:formData,
			processData:false,
			contentType:false,
			success:function(){
				alert("문서가  생성되었습니다.");
// 				window.location.href='<c:url value="/doc/mylist" />';	
				opener.location.reload();
				window.close();
			},
			error:function(){
				alert("문서 생성에실패했습니다.");
			}
		});
		
	}else{
		alert("문서 분류 혹은 첨부파일이 존재하지 않습니다");
	}
}

</script>
<script> // 시연용
function presentationFill(){
	$("#selectBoard option[value='myDoc']").attr("selected",true);
	$("#selectImportance option[value='3']").attr("selected",true);
	$("#docTitle").val("회계품의서 결재 관련 문서");
	$(".note-codable").val("회계품의서 결재 관련 문서입니다.");
	$('#summernote').summernote('code', '<p>회계품의서 결재 관련 문서입니다.</p><p>첨부파일을 등록하였으니 참고하시기 바랍니다.</p>');
	
}
</script>