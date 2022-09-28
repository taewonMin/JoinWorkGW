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

<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
		<div class="block-header">
            <div class="row">
            	<div class="col-sm-5">
                	<h2 style="padding-left:10px;font-size:2em; font-family: S-CoreDream-6Bold"><i class="icon-note"></i>&nbsp;업무 상세 #${boardFormVO.dutyVO.dutyBoardId } </h2>
                </div>
                <div class="col-sm-7 " style="font-family: S-CoreDream-6Bold">
               		<div style="float:right;">
                    	<button type="button" class="btn btn-info" style="width:80px;" onclick="modify_go();">수정</button>
                    	<button type="button" onclick="history.go(-1);" class="btn btn-secondary" style="width:80px;">취소</button>
                	</div>
             	</div>
            </div>
        </div>
        <div class="row clearfix" style="font-family: S-CoreDream-4Regular">
            <div class="col-lg-12 col-md-12 col-sm-12">
            	<form:form commandName="boardFormVO" name="dutyModifyForm" action="${pageContext.request.contextPath }/board/duty/modify" enctype="multipart/form-data">
		          	<form:hidden path="dutyVO.dutyBoardId" />
		          	<form:hidden path="dutyVO.dutyBoardContent" id="dutyBoardContent"/>
		          	<form:hidden path="dutyVO.dutyBoardUpdaterId" value="${loginUser.empId }"/>
		          	<form:hidden path="dutyVO.empWriterId" value="${loginUser.empId }"/>
		          	<div id="fileUploadForm">
		          	</div>
		          	<div id="deleteFile">
		          	</div>
					
                 <div class="body">
                     <div class="row clearfix">
                      <div class="table-responsive" style="padding:5px 15px;">
						
						<table class="table table-hover m-b-0">
							<thead class="shadow-none p-3 mb-5 bg-light rounded">
								<tr>
									<td style="width:130px;">
										<strong>제목</strong>
									</td>
									<td colspan="5">
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<form:textarea path="dutyVO.dutyBoardTitle" style="width:100%;"/>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<strong>작성자</strong>
									</td>
									<td style="width:200px;">
										<div style="padding-left:15px;border-left: 1px dotted gray;">${boardFormVO.dutyVO.empName }</div>
									</td>
									<td style="width:160px;">
										<strong>수신자</strong>
										<a href="#largeModal" id="addManager" data-toggle="modal" data-target="#largeModal" style="margin-left:10px;"><i class="icon-note"></i>수정</a>
									</td>
									<td colspan="3">
										<div class="empFinish" style="padding-left:15px;border-left: 1px dotted gray;">
											<c:forEach items="${boardFormVO.dutyVO.dutyManagerList }" var="dutyManager" varStatus="status">
												<span id="${dutyManager.empId }" data-name="${dutyManager.empName }" data-pos="${dutyManager.officialName }" data-dept="${dutyManager.deptName }" data-state="${dutyManager.attendStName }">${dutyManager.empName }</span>
												<c:if test="${status.index < boardFormVO.dutyVO.dutyManagerList.size()-1 }">
												,&nbsp;
												</c:if>
											</c:forEach>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<strong>작성일자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											${boardFormVO.dutyVO.dutyBoardCreateDtStr }
										</div>
									</td>
									<td>
										<strong>완료날짜</strong>
									</td>
									<td style="width:200px;">
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<div class="input-group date" data-date-autoclose="true" data-provide="datepicker">
			                                 	<input type="text" name="dutyVO.dutyBoardEndDt" class="form-control" id="boardEndDt" placeholder="완료일자 선택" readonly="readonly"
			                                 	<c:if test="${!empty boardFormVO.dutyVO.searchDeadline }">
				                                 	value="${boardFormVO.dutyVO.searchDeadline }"
			                                 	</c:if> 
			                                 	>
				                                <div class="input-group-append">                                            
				                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
				                                </div>
			                                </div>
										</div>
									</td>
									<td style="width:130px;">
										<strong>조회수</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">${boardFormVO.dutyVO.dutyBoardReadcnt }</div>
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
												<c:if test="${!empty boardFormVO.dutyVO.dutyAttachList }">
													<c:forEach items="${boardFormVO.dutyVO.dutyAttachList }" var="dutyAttach" varStatus="status">
														<!-- 파일 입력 -->
						                                <span class="attach_${status.index }" style="font-weight: normal; margin-right:15px;">
						                                	<c:choose>
						                                		<c:when test="${dutyAttach.attachType eq 'JPG' || dutyAttach.attachType eq 'PNG' || dutyAttach.attachType eq 'GIF'}">
							                                		<i class="fa fa-file-photo-o"></i>
						                                		</c:when>
						                                		<c:otherwise>
							                                		<i class="fa fa-file-text-o"></i>
						                                		</c:otherwise>
						                                	</c:choose>
															&nbsp;${dutyAttach.attachName }
														</span>   
													</c:forEach>
												</c:if>
												<c:if test="${empty boardFormVO.dutyVO.dutyAttachList }">
													<span id="noFile" style="font-weight: normal;">없음</span>
												</c:if>
											</div>
											<div id="attachBox" style="display:none;">
												<button type="button" class="btn btn-primary" style="margin-bottom:5px;" onclick="myFileUpload();">파일 추가</button>
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
					                                    	<c:if test="${!empty boardFormVO.dutyVO.dutyAttachList }">
																<c:forEach items="${boardFormVO.dutyVO.dutyAttachList }" var="dutyAttach" varStatus="status">
							                                    	<tr>
							                                    		<td>
							                                    			<c:choose>
							                                    				<c:when test="${dutyAttach.attachType eq 'JPG' || dutyAttach.attachType eq 'PNG' || dutyAttach.attachType eq 'GIF'}">
								                                    				이미지
							                                    				</c:when>
							                                    				<c:otherwise>
								                                    				파일
							                                    				</c:otherwise>
							                                    			</c:choose>
							                                    		</td>
							                                    		<td style="font-weight: normal;">
																			${dutyAttach.attachName }
							                                    		</td>
							                                    		<td style="font-weight: normal;">
																			${dutyAttach.attachType }
							                                    		</td>
							                                    		<td style="font-weight: normal;">
							                                    			${dutyAttach.attachSize }
							                                    		</td>
							                                    		<td>
																			<i class="icon-close" data-id="${status.index }" data-attachId="${dutyAttach.attachId }" style="cursor: pointer;" onclick="removeEl(this)"></i>
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
										<div class="summernote">
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

<!-- Modal -->
<div class="modal fade" id="largeModal" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="title" id="largeModalLabel">업무 수신자 수정</h4>
            </div>
            <div class="modal-body">
            	<!-- 수신자 등록 폼 -->
            	<div style="width:300px;height: 300px;display:inline-block;">
		            <div class="body" style="padding: 6px;">
		                <ul class="nav nav-tabs">
		                    <li class="nav-item"><a class="nav-link show active" data-toggle="tab" href="#org">조직도</a></li>
		                </ul>
		                <div class="tab-content" style="padding: 0;">
							<!-- 조직도 -->
		                    <div class="tab-pane show active" id="org">
		                    	<div class="header" style=" height: 60px;margin-top:15px;">
				                    <input type="search" class="form-control" placeholder="이름/아이디/부서" style="display: inline-block; width: 75%;">
				                    <button type="button" class="btn btn-dark"><i class="icon-magnifier"></i></button>
			               		</div>
		                		<div class="body" style="overflow-y: scroll; height: 300px;">
		                			<div>
										<ul id="codeList" class="treeview">
											<li>JoinWork조직도
												<ul id="lvl0"></ul> 
											</li>
										</ul>
									</div>
		                		</div>
		                    </div>
		                </div>
		            </div>
	            </div>
            	<!-- 수신자 등록 폼 -->
            	<div style="width:calc( 100% - 305px );height: 300px;display:inline-block;top:0px;">
            		<div class="body" style="padding: 6px;">
            			<h4>업무 수신자 목록</h4>
            			<div class="tab-content" style="padding: 0;">
							<!-- 조직도 -->
		                    <div class="tab-pane show active" id="org">
		                    	<div class="header" style=" height: 60px;margin-top:15px;">
				                    <input type="search" id="selectEmpName" class="form-control" readonly="readonly" placeholder="이름/부서/상태" style="display: inline-block; width: 75%;">
				                    <input type="hidden" id="selectEmpId" >
				                    <button type="button" class="btn btn-dark" onclick="addEmpList();" style="width:20%;"><i class="fa fa-sort-desc"></i></button>
			               		</div>
		                		<div class="body" style="overflow-y: scroll; height: 300px;">
		                            <div class="table-responsive">
		                                <table class="table table-hover empListTable">
		                                    <thead>
		                                        <tr>
		                                            <th style="width:130px;">이름(직위)</th>
		                                            <th style="width:120px;">부서</th>
		                                            <th style="text-align: center;">상태</th>
		                                            <th class="deleteAllEmp" style="cursor: pointer;text-align: center;" onclick="removeAllElement();">
			                                        	<i class="fa fa-trash-o"></i>
													</th>
		                                        </tr>
		                                    </thead>
		                                    <tbody>
		                                        <tr class="noEmpList" style="text-align: center;">
		                                            <td colspan="4">선택된 수신자가 없습니다.</td>
		                                        </tr>
		                                    </tbody>
		                                </table>
		                            </div>
		                		</div>
		                    </div>
		                </div>
            		</div>
	            </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" onclick="finish();">수정</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>


<form name="temp">
</form>

<script type="text/javascript">
window.onload=function(){
	if($('input#boardEndDt').val() != ''){
		var endDate = $('input#boardEndDt').val().split('-');
		$('input#boardEndDt').val(endDate[1]+"/"+endDate[2]+"/"+endDate[0]);
	}
	$('div.note-editable').html('${boardFormVO.dutyVO.dutyBoardContent}');
	
	deptTrees();
	
	// 수신자 데이터 추가
	var tempForm = $('form[name="temp"] input');
	
	$('.noEmpList').css('display','none');
	
	$('.empFinish span').each(function(){
		var trTag =  '<tr class="id_'+$(this).attr('id')+'">'
					+"<td>"+$(this).attr('data-name')+'('+$(this).attr('data-pos')+')'+"</td>"
					+"<td>"+$(this).attr('data-dept')+"</td>"
					+'<td style="text-align: center;">'+$(this).attr('data-state')+"</td>"
					+'<td style="text-align: center;cursor:pointer;" onclick="removeElement(this);"><i class="icon-close"></i></td>'
					+"</tr>";
					
		$('.empListTable tbody').append(trTag);
		
		// temp form에 empId 추가
		var inputTag = '<input type="hidden" class="id_'+$(this).attr('id')+'" data-name="'+$(this).attr('data-name')+'" name="empId" value="'+$(this).attr('id')+'">';
		$('form[name="temp"]').append(inputTag);
	});
	
}

$("#codeList").treeview({collapsed: false});


//조직도 출력
function deptTrees(){
	$.ajax({
		type:"GET",
		url:"<c:url value='/orgList' />",
		contentType:"application/json",
	// 	data:dataSet,
		processData:true,
		success: function(data) {
			data.forEach(function(e, i) {
				var deptId = e.deptId;
				var deptName = e.deptName;
			    var deptSupId = e.deptSupId;
			    var position = e.position;
			    var empState = e.empState;
			    var level = 5;
			    var deptSupName = $('li[id="'+deptSupId+'"] a').eq(0).text();
			    var li = "";
			    if(e.level){
					level = e.level;
			    } 
			    if(position){
				    li = '<li onclick="empChecked(this);" data-deptId="'+deptSupId+'" data-name="'+deptName+" "+position+'" data-dept="'+deptSupName+'" data-state="'+(empState==null ? '' : empState)+'" ondblclick="addEmpList();" id="'+ deptId +'" lvl="'+level +'" class="myChecked" style="cursor:pointer" ><img src="<%=request.getContextPath() %>/resources/js/treeview/images/emp.png" >'+" "+ deptName + " "+e.position+'</li>';
			    }else{
			    	li = '<li id="'+ deptId +'" lvl="'+level +'"><a class="file code">'+ deptName +'</a></li>';
			    }
				
				
				// 1레벨은 그냥 추가
				// 다음 레벨부터는 상위 li의 클래스를 폴더로 바꾸고 자기 자신을 추가
			    if(level == 1) {
					$("#lvl0").append(li);
				} else {
					  var parentLi = $("li[id='"+ deptSupId +"']");
					  
					  parentLi.addClass("expandable lastExpandable");
				      var bUl = parentLi.children("ul");
			   		  
				      // 하위 그룹이 없으면 li로 추가
				      // 하위 그룹이 있으면 ul로 추가
				      if(bUl.length == 0) {
				    	  var div = "<div onclick='plusFromMinus(this);' class='hitarea expandable-hitarea lastExpandable-hitarea'></div>"
				          li = "<ul class='' style='display: none;'>" + li + "</ul>";
				          parentLi.append(div);
				          parentLi.append(li);
				          
				          return false;
				      } else {
				          if(position){
				        	  bUl.prepend(li);
				        	  return false;
				          }
				    	  bUl.append(li);
				      }
			     }
			});
		}
	});
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

function empChecked(obj) {
	//기존 체크된 css 및 클래스 정보 삭제
	$(".myChecked").css("background-color","");
	$("li").removeClass("myChecked");
	
	//새로 체크된 css 및 클래스 정보 갱신
	$(obj).addClass("myChecked");
	$(".myChecked").css("background-color","#17a2b8");
	
	$('#selectEmpName').val($(obj).text().trim());
}

// 업무 수신자 목록으로 추가
function addEmpList(){
	if($('#selectEmpName').val().trim()==""){
		alert("수신자를 선택하세요.");
		return;
	}
	var tempForm = $('form[name="temp"] input');
	var check=false;
	if(tempForm.length > 0){
		tempForm.each(function(index,item){
			if($(this).val() == $('.myChecked').attr('id')){
				alert('이미 수신자로 등록된 직원입니다.');
				check = true;
				return false;
			} 
		});
		if(check){
			return;
		}
	}
	
	$('.noEmpList').css('display','none');
	
	// 이름(직위) 분할
	var empName = $('.myChecked').attr('data-name').split(' ')[0];
	var empPos = $('.myChecked').attr('data-name').split(' ')[1];
	
	var trTag =  '<tr class="id_'+$('.myChecked').attr('id')+'">'
				+"<td>"+empName+'('+empPos+')'+"</td>"
				+"<td>"+$('.myChecked').attr('data-dept')+"</td>"
				+'<td style="text-align: center;">'+$('.myChecked').attr('data-state')+"</td>"
				+'<td style="text-align: center;cursor:pointer;" onclick="removeElement(this);"><i class="icon-close"></i></td>'
				+"</tr>";
	$('.empListTable tbody').append(trTag);
	
	// temp form에 empId 추가
	var inputTag = '<input type="hidden" class="id_'+$('.myChecked').attr('id')+'" data-name="'+empName+'" name="empId" value="'+$('.myChecked').attr('id')+'">';
	$('form[name="temp"]').append(inputTag);
}

// 업무 수신자 리스트에서 삭제
function removeElement(obj){
	var className= $(obj).closest('tr').attr('class');
	$('.'+className).remove();
	if($('.empListTable tbody').children().length==1){
		$('.noEmpList').css('display','');
	}
}

// 업무 수신자 리스트 전체 삭제
function removeAllElement(){
	var check = confirm('수신자 목록을 비우시겠습니까?');
	if(!check){
		return;
	}
	$('form[name="temp"]').children().remove();
	$('.empListTable tbody').children().each(function(index,item){
		if(index==0){
			return true;
		}
		$(this).remove();
	})
	$('.noEmpList').css('display','');
}

// 업무 수신자 추가 완료
function finish(){
	if($('.empListTable tbody').children().length==1){
		alert('수신자를 한 명 이상 선택하세요.');
		return;
	}
	$('.empFinish').text("");
	
	$('form[name="temp"]').children().each(function(index,item){
		var spanTag = '<span id="'+$(this).val()+'">'+$(this).attr('data-name')+'</span>';
		if(index < $('form[name="temp"]').children().length-1)
			spanTag += ", ";
		$('.empFinish').append(spanTag);
	});
	
	$('button[data-dismiss="modal"]').click();
}



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
var uuid = ${empty boardFormVO.dutyVO.dutyAttachList ? 0 : boardFormVO.dutyVO.dutyAttachList.size()};
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
function modify_go(){
	var modifyForm = $('form[name="dutyModifyForm"]')[0];
	
	if($.trim($('textarea[name="dutyVO.dutyBoardTitle"]').val())==""){
		alert('제목을 입력하세요.');
		$('textarea[name="dutyVO.dutyBoardTitle"]').focus();
		return;
	}
	
	if($.trim($('.note-editable').text())==""){
		alert('업무 내용을 입력하세요.');
		$('.note-editable').focus();
		return;
	}
	$('#dutyBoardContent').val($('.note-editable').html());
	$('input[name="dutyVO.dutyBoardEndDt"]').val($('#dutyBoardEndDt').val());

	// 수신자 추가
	$('.empFinish span').each(function(index,item){
		var empId = $(this).attr('id');
		var inputTag = $('<input>').attr({'type':'hidden','name':'dutyVO.empManagerList','value':empId});
		
		$(modifyForm).append(inputTag);
	});
	
	// 선택 안된 파일 지우기
	$('.attach_'+uuid).remove();
	
	var formData = new FormData(modifyForm);
	$.ajax({
		url:modifyForm.action,
		type:'post',
		data:formData,
		processData:false,
		contentType:false,
		success:function(){
			alert("글이 수정되었습니다.");
			
			$('input[name="dutyVO.empManagerList"]').each(function(){
				var empId = $(this).val();
				sendMessage('${pageContext.request.contextPath}',
							empId,
							'담당 업무가 수정되었습니다. 확인해주세요.',
							'${boardFormVO.dutyVO.dutyBoardTitle} #${boardFormVO.dutyVO.dutyBoardId}',
							'<c:url value="/board/duty/detail?dutyBoardId=${boardFormVO.dutyVO.dutyBoardId}"/>',
							'업무관리');
			});
			
			window.opener.location.reload(true);
			window.location.href='<c:url value="/board/duty/detail?dutyBoardId=${boardFormVO.dutyVO.dutyBoardId}"/>';
		},
		error:function(){
			alert("글 수정에 실패했습니다.");
			window.location.href='<c:url value="/board/duty/detail?dutyBoardId=${boardFormVO.dutyVO.dutyBoardId}" />';	
		}
	});
}

</script>