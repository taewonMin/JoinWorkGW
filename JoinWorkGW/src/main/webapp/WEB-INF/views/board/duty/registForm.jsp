
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script
	src="<%=request.getContextPath() %>/resources/js/treeview/jquery.cookie.js"></script>
<script
	src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.js"></script>
<script
	src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.edit.js"></script>
<script
	src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.async.js"></script>

<link rel="stylesheet"
	href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">
<style>
.formGroup {
	display: none;
}
.hiddenFillBtn:hover{background-color: #f4f7f6;}
</style>

<body>
<button type="button" class="btn hiddenFillBtn" onclick="presentationFill_1();" style="position:absolute;right:0;top:0;color:#f4f7f6; z-index: 100; border: 0px;">시연용버튼1</button>
<button type="button" class="btn hiddenFillBtn" onclick="presentationFill_2();" style="position:absolute;right:100px;top:0;color:#f4f7f6; z-index: 100; border: 0px;">시연용버튼2</button>
<button type="button" class="btn hiddenFillBtn" onclick="presentationFill_3();" style="position:absolute;right:200px;top:0;color:#f4f7f6; z-index: 100; border: 0px;">시연용버튼3</button>
<button type="button" class="btn" onclick="presentationFill_4();" style="position:absolute;right:1.5em;top:7.5em;color:#ffffff; z-index: 100; border: 0px;">시연용버튼4</button>
	<!-- Overlay For Sidebars -->
	<div id="main-content">
		<div class="container-fluid">
			<div class="block-header">
				<div class="row">
					<div class="col-sm-3">
						<h2
							style="padding-left: 10px; font-size: 2em; font-family: paybooc-Bold;">
							<i class="icon-note"></i>&nbsp;업무 작성
						</h2>
					</div>
					<div class="col-sm-9" style="font-family: S-CoreDream-4Regular">
						<div style="float: right;">
							<button type="button" class="btn btn-primary"
								style="width: 100px; font-size: 1.2em;" onclick="submit_go();">등록</button>
							<button type="button" onclick="window.close();"
								class="btn btn-secondary"
								style="width: 100px; font-size: 1.2em;">취소</button>
						</div>
					</div>
				</div>
			</div>

			<div class="row clearfix" style="font-family: S-CoreDream-4Regular">
				<div class="col-lg-12 col-md-12 col-sm-12">
					<div class="card">
						<div class="body">
							<form:form commandName="boardFormVO" name="boardRegistForm">
								<!-- 업무 지시 -->
								<form:hidden path="dutyVO.dutyBoardTitle" id="dutyBoardTitle" />
								<form:hidden path="dutyVO.dutyBoardContent"
									id="dutyBoardContent" />
								<form:hidden path="dutyVO.dutyBoardUpdaterId"
									value="${loginUser.empId }" />
								<form:hidden path="dutyVO.empWriterId"
									value="${loginUser.empId }" />
								<form:hidden path="dutyVO.dutyBoardEndDt" id="dutyBoardEndDt"/>
								<div id="fileUploadForm"></div>
								<div id="deleteFile"></div>
								<div class="row clearfix">
									<!-- 게시판 선택 -->
									<div class="col-md-3">
										<label>업무선택</label>
										<div class="form-group">
											<select id="selectBoard" class="form-control show-tick"
												onchange="changeCategory(this);">
												<option value="default">업무 선택</option>
												<option value="duty">업무 제안</option>
												<option value="issue">업무 이슈</option>
											</select>
										</div>
									</div>

									<!-- 본문 -->
									<div class="col-md-3 col-sm-12 formGroup noticeForm cacForm dutyForm issueForm ">
										<label class="boardWriter">작성자</label>
										<div class="form-group">
											<input type="text" readonly class="form-control"
												placeholder="" value="${loginUser.empName }">
										</div>
									</div>
									<div class="col-md-3 col-sm-12 formGroup issueForm">
										<label>관련 업무 번호(선택)</label>
										<div class="form-group">
											<input type="text" id="dutyBoardIdForIssue"
												class="form-control" placeholder="업무 글번호를 입력하세요."
												maxlength="6">
										</div>
									</div>
									<div class="col-md-3 col-sm-12 formGroup issueForm">
										<label>공개 여부 설정</label> <select id="issueOpenStForIssue"
											class="form-control show-tick">
											<option value="Y">공개</option>
											<option value="N">비공개</option>
										</select>
									</div>
									<div
										class="col-sm-12 formGroup noticeForm cacForm anonyForm dutyForm issueForm">
										<div class="form-group">
											<label class="boardTitle">제목</label> <input type="text"
												id="boardTitle" class="form-control" placeholder="">
										</div>
									</div>
									<div class="col-sm-12 formGroup dutyForm">
										<div class="col-sm-3" style="padding-left: 0;">
											<div class="form-group">
												<label>완료 기한</label>
												<div class="input-group date" data-date-autoclose="true"
													data-provide="datepicker">
													<input type="text" class="form-control" id="boardEndDt"
														placeholder="완료일자 선택" readonly="readonly">
													<div class="input-group-append">
														<button class="btn btn-outline-secondary" type="button">
															<i class="fa fa-calendar"></i>
														</button>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-sm-12 formGroup dutyForm">
										<div class="form-group">
											<label class="" style="margin-right: 15px;">수신자</label> <a
												href="#largeModal" id="addManager" data-toggle="modal"
												data-target="#managerModal"> + 수신자 추가하기</a><br>
											<div class="empFinish" id="myEmpFinish">
												<!-- 수신자 리스트 -->
											</div>
										</div>
									</div>
									<div class="col-sm-12 formGroup dutyForm">
										<div class="form-group">
											<label class="" style="margin-right: 15px;">참조자</label> <a
												href="#largeModal" id="addReceptioner" data-toggle="modal"
												data-target="#managerModal"> + 참조자 추가하기</a><br>
											<div class="empReception">
												<!-- 참조자 리스트 -->
											</div>
										</div>
									</div>
								</div>


								<div class="row clearfix">
									<!-- 파일 입력 -->
									<!-- 	                                <div class="col-12 formGroup noticeForm dutyForm"> -->
									<!-- 	                                    <input type="file" name="fileUploadCommand.uploadFile" class="dropify" style="height: 200px;"> -->
									<!-- 	                                    <div class="mt-3"></div> -->
									<!-- 	                                </div>       -->
									<div class="col-12 formGroup noticeForm dutyForm">
										<table class="table table-hover m-b-0">
											<thead class="shadow-none p-3 mb-5 bg-light rounded">
												<tr>
													<th style="width: 160px; vertical-align: top;"><i
														class="fa fa-download"></i> <strong>첨부파일</strong> <a
														href="javascript:void(0);" id="showFileWindow"
														style="margin-left: 10px; font-weight: normal;"
														onclick="toggleFileContent();"><i class="icon-note"></i>수정</a>
														<a href="javascript:void(0);" id="hideFileWindow"
														style="margin-left: 10px; font-weight: normal; display: none;"
														onclick="toggleFileContent();"><i class="fa fa-times"></i>
															닫기</a></th>
													<th colspan="5">
														<div
															style="padding-left: 15px; border-left: 1px dotted gray;">
															<div id="attachInline">
																<c:if
																	test="${!empty boardFormVO.dutyVO.dutyAttachList }">
																	<c:forEach
																		items="${boardFormVO.dutyVO.dutyAttachList }"
																		var="dutyAttach" varStatus="status">
																		<!-- 파일 입력 -->
																		<span class="attach_${status.index }"
																			style="font-weight: normal; margin-right: 15px;">
																			<c:choose>
																				<c:when
																					test="${dutyAttach.attachType eq '' || dutyAttach.attachType eq 'PNG' || dutyAttach.attachType eq 'GIF'}">
																					<i class="fa fa-file-photo-o"></i>
																				</c:when>
																				<c:otherwise>
																					<i class="fa fa-file-text-o"></i>
																				</c:otherwise>
																			</c:choose> &nbsp;${dutyAttach.attachName }
																		</span>
																	</c:forEach>
																</c:if>
																<c:if test="${empty boardFormVO.dutyVO.dutyAttachList }">
																	<span id="noFile" style="font-weight: normal;">없음</span>
																</c:if>
															</div>
															<div id="attachBox" style="display: none;">
																<button type="button" class="btn btn-primary"
																	style="margin-bottom: 5px;" onclick="myFileUpload();">파일
																	추가</button>
																<span class="float-right" style="margin: 15px 10px 0 0;">파일
																	개수 <span id="fileCount">${empty boardFormVO.dutyVO.dutyAttachList ? 0 : boardFormVO.dutyVO.dutyAttachList.size()}</span>/5
																</span>
																<div
																	style="border: 1px solid gray; height: 200px; overflow-y: scroll;">
																	<table class="table table-hover center-aligned-table"
																		style="margin-bottom: 0;">
																		<thead style="height: 50px;">
																			<tr>
																				<th style="width: 200px;">타입</th>
																				<th style="width: 300px;">파일명</th>
																				<th style="width: 200px;">확장자</th>
																				<th style="width: 200px;">용량</th>
																				<th style="width: 100px;"><i
																					class="fa fa-trash-o" style="cursor: pointer;"
																					onclick="removeAll();"></i></th>
																			</tr>
																		</thead>
																		<tbody id="appendTbody">
																			<!-- 파일 입력 -->
																			<c:if
																				test="${!empty boardFormVO.dutyVO.dutyAttachList }">
																				<c:forEach
																					items="${boardFormVO.dutyVO.dutyAttachList }"
																					var="dutyAttach" varStatus="status">
																					<tr>
																						<td><c:choose>
																								<c:when
																									test="${dutyAttach.attachType eq 'JPG' || dutyAttach.attachType eq 'PNG' || dutyAttach.attachType eq 'GIF'}">
											                                    				이미지
										                                    				</c:when>
																								<c:otherwise>
											                                    				파일
										                                    				</c:otherwise>
																							</c:choose></td>
																						<td style="font-weight: normal;">
																							${dutyAttach.attachName }</td>
																						<td style="font-weight: normal;">
																							${dutyAttach.attachType }</td>
																						<td style="font-weight: normal;">
																							${dutyAttach.attachSize }</td>
																						<td><i class="icon-close"
																							data-id="${status.index }"
																							data-attachId="${dutyAttach.attachId }"
																							style="cursor: pointer;" onclick="removeEl(this)"></i>
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
											</thead>
										</table>
									</div>

									<!-- 내용 입력 -->
									<div class="col-sm-12 formGroup noticeForm cacForm anonyForm dutyForm issueForm">
										<div class="summernote" id="summernote" style="height: 200px;"></div>
									</div>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!----------------------------------------------- 모달--------------------------------------------->
	<!-- Modal -->
	<div class="modal fade" id="managerModal" tabindex="-1" role="dialog"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="title" id="largeModalLabel">수신자 추가</h4>
				</div>
				<div class="modal-body">
					<!-- 모달 수신자 등록 폼 -->
					<div style="width: 300px; height: 300px; display: inline-block;">
						<div class="body" style="padding: 6px;">
							<ul class="nav nav-tabs">
								<li class="nav-item"><a class="nav-link show active"
									data-toggle="tab" href="#org">조직도</a></li>
							</ul>
							<div class="tab-content" style="padding: 0;">
								<!-- 조직도 -->
								<div class="tab-pane show active" id="org">
									<div class="header" style="height: 60px; margin-top: 15px;">
										<input oninput="searchOrg(this);" type="search"
											class="form-control" placeholder="이름으로 검색"
											style="display: inline-block; width: 75%;">
										<button type="button" class="btn btn-dark"
											onclick="searchOrg(this);">
											<i class="icon-magnifier"></i>
										</button>
									</div>
									<div class="body" style="overflow-y: scroll; height: 300px;">
										<div>
											<ul id="codeList" class="treeview">
												<!-- 										<i class="fa icon-action-redo" style="color:#383d41; cursor:pointer;"></i> -->
												<li>JoinWork조직도&nbsp
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
					<div
						style="width: calc(100% - 305px); height: 300px; display: inline-block; top: 0px;">
						<div class="body" style="padding: 6px;">
							<h4 id="myDutyList">수신자 목록</h4>
							<div class="tab-content" style="padding: 0;">
								<!-- 조직도 -->
								<div class="tab-pane show active" id="org">
									<div class="header" style="height: 60px; margin-top: 15px;">
										<input type="search" id="selectEmpName" class="form-control"
											readonly="readonly" placeholder="이름/부서/상태"
											style="display: inline-block; width: 75%;"> <input
											type="hidden" id="selectEmpId">
										<button type="button" class="btn btn-dark"
											onclick="addEmpList();" style="width: 20%;">
											<i class="fa fa-sort-desc"></i>
										</button>
									</div>
									<div class="body" style="overflow-y: scroll; height: 300px;">
										<div class="table-responsive">
											<table class="table table-hover empListTable">
												<thead>
													<tr>
														<th style="width: 130px;">이름/직위</th>
														<th style="width: 120px;">부서</th>
														<th style="text-align: center;">상태</th>
														<th class="deleteAllEmp"
															style="cursor: pointer; text-align: center;"
															onclick="removeAllElement();"><i
															class="fa fa-trash-o"></i></th>
													</tr>
												</thead>
												<tbody>
													<tr class="noEmpList"
														style="text-align: center; display: none;">
														<td colspan="4">선택된 수신자가 없습니다.</td>
													</tr>
													<tr class="noReceptionList"
														style="text-align: center; display: none;">
														<td colspan="4">선택된 참조자가 없습니다.</td>
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
					<button type="button" class="btn btn-primary" id="addEmp">추가</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal" id="closeModal">닫기</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Javascript -->


	<!-- 업무 이슈 -->
	<form name="issueRegistForm" method="post">
		<input type="hidden" name="issueBoardTitle" /> <input type="hidden"
			name="issueBoardContent" /> <input type="hidden"
			name="issueBoardUpdaterId" value="${loginUser.empId }" /> <input
			type="hidden" name="empId" value="${loginUser.empId }" /> <input
			type="hidden" name="dutyBoardId" /> <input type="hidden"
			name="issueOpenSt" />
	</form>

	<script>
window.onload = function(){
	deptTrees();
	if(${!empty boardFormVO.registParam}){
		
		// 이슈 폼
		if('${boardFormVO.registParam}' == 'issue'){
			$('#dutyBoardIdForIssue').val('${boardFormVO.dutyBoardId}');
			$('#boardTitle').val('#${boardFormVO.dutyBoardId}의 이슈 [${boardFormVO.dutyVO.dutyBoardTitle}]');
			$('#summernote').summernote('code', '<br>'
					+'<br>'
					+'<br>'
					+'<br>'
					+'<br>'
					+'<br>'
					+'<p>------------------------------</p>'
					+'<p>[업무제안 내용]</p>'
					+'${boardFormVO.dutyVO.dutyBoardContent}'
			);
		}
		$('select#selectBoard').val('${boardFormVO.registParam}');
		changeCategory(document.getElementById('selectBoard'));
	}
}

$("#codeList").treeview({collapsed: false});


// 게시판 그룹 변경시 입력 폼 설정
function changeCategory(obj){
	$('.formGroup').css('display','none');
	$('.boardTitle').text('제목');
	$('.'+obj.value+"Form").css("display",'block');
	
	if(obj.value=='duty'){
		$('.boardTitle').text('업무 제목');
	}
}

// 입력폼 수신자 삭제
function deleteElement(obj){
	console.log($('.'+$(obj).attr('class')));
	$('.'+$(obj).attr('data-class')).remove();
	$(obj).closest('div').remove();
}

//얍시로 숨겨놓기 시작
$("#addManager").click(function(){
	
	$("#largeModalLabel").html("수신자 추가");
	$("#myDutyList").html("수신자 목록");
	$("#managerModal").removeClass("receptionModal");
	$("#managerModal").addClass("managerModal");
	$(".noReceptionList").css("display","none");
	$(".noEmpList").css("display","");
	$(".myReceptioner").css("display","none");
	$(".myManager").css("display","");
	$(".icon-action-redo").css("display","none");
	
	
	if($(".myManager").length > 0){
		$(".noEmpList").css("display","none");
	}

});
$("#addReceptioner").click(function(){
	$("#largeModalLabel").html("참조자 추가");
	$("#myDutyList").html("참조자 목록");
	$("#managerModal").removeClass("managerModal");
	$("#managerModal").addClass("receptionModal");
	$(".noEmpList").css("display","none");
	$(".noReceptionList").css("display","");
	$(".myManager").css("display","none");
	$(".myReceptioner").css("display","");
	$(".icon-action-redo").css("display","");
	
	if($(".myReceptioner").length > 0){
		$(".noReceptionList").css("display","none");
	}

});

$("#addEmp").click(function(){
	if($(".managerModal").length > 0){//수신자 추가일 시
		$(".empManagerList").remove();
		
		var tempTag = "";
		for(var i = 0; i < $(".myManager").length; i++){
			tempTag += '<div style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
					+'<span>'+$(".myManager").eq(i).find("td").eq(0).text()+'</span>'
					+'<div class="hiddenId manager" style="display:none;" value="'+$(".myManager").eq(i).attr("value")+'"></div>'
					+'<i class="icon-close" style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
					+'</div>';
		}
		
		$(".empFinish").html(tempTag);
		$("tbody").find(".myManager").remove();
	}else{//참조자 추가일 시
		$(".empReceptionDeptList").remove();
		$(".empReceptionList").remove();
		
		var tempTag = "";
		for(var i = 0; i < $(".myReceptioner").length; i++){
			if($(".myReceptioner").eq(i).hasClass("myReceptionDept")){
				tempTag += '<div class="l-seagreen" style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
						+'<span>'+$(".myReceptioner").eq(i).find("td").eq(0).text()+'</span>'
						+'<div class="hiddenId receptionDept" style="display:none;" value="'+$(".myReceptioner").eq(i).attr("value")+'"></div>'
						+'<i class="icon-close" style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
						+'</div>';
				$(".empReception").html(tempTag);
			}else{
				tempTag += '<div style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
						+'<span>'+$(".myReceptioner").eq(i).find("td").eq(0).text()+'</span>'
						+'<div class="hiddenId receptioner" style="display:none;" value="'+$(".myReceptioner").eq(i).attr("value")+'"></div>'
						+'<i class="icon-close" style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
						+'</div>';
			}
		}
		$(".empReception").html(tempTag);
		$("tbody").find(".myReceptioner").remove();
	}
	
	$("#closeModal").click();
	
});
	




////숨겨놓기끝

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
			    var stName = e.empState;
			    var level = 5;
			    var deptSupName = $('li[id="'+deptSupId+'"] a').eq(0).text();
			    var li = "";
			    if(e.level){
					level = e.level;
			    } 
			    if(position){
			    	if(stName == '휴가중'){
				    	li = '<li onclick="empChecked(this);" data-deptId="'+deptSupId+'" data-name="'+deptName+" "+position+'" data-dept="'+deptSupName+'" data-state="'+(empState==null ? '' : empState)+'" ondblclick="addEmpList();" id="'+ deptId +'" lvl="'+level +'" class="myChecked" style="cursor:pointer" ><img src="<%=request.getContextPath() %>/resources/js/treeview/images/emp.png" >'+" "+ deptName + " "+e.position+'<span class="badge badge-warning">'+stName+'</span></li>';
			    	}else{
				    	li = '<li onclick="empChecked(this);" data-deptId="'+deptSupId+'" data-name="'+deptName+" "+position+'" data-dept="'+deptSupName+'" data-state="'+(empState==null ? '' : empState)+'" ondblclick="addEmpList();" id="'+ deptId +'" lvl="'+level +'" class="myChecked" style="cursor:pointer" ><img src="<%=request.getContextPath() %>/resources/js/treeview/images/emp.png" >'+" "+ deptName + " "+e.position+'</li>';
			    		
			    	}
			    }else{
			    	li = '<li id="'+ deptId +'" lvl="'+level +'"><a class="file code" style="cursor: pointer;" onclick="myClick(this);" >'+ deptName +'&nbsp&nbsp<i data-id="'+deptId+'" data-name="'+deptName+'" class="fa icon-action-redo addDept" style="color:#383d41; cursor:pointer;"></i></a></li>';
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

function myClick(obj){
	$(obj).parent().children("div").click();
}
//조직도 검색을 위한 함수입니다.
function searchOrg(obj){
	var keyword = $(obj).val();
	if(!keyword){//검색조건이 비어있으면 리턴
		$("#codeList")[0].scrollIntoView();
		$(".myChecked").css("background-color","");
		return false;
	}
	
	$("li:contains('"+keyword+"')").eq(2);
// 	console.log($("li:contains('"+keyword+"')"));
// 	console.log($("li:contains('"+keyword+"')").eq(2)[0]);
	
	var $plusIcon = $("li:contains('"+keyword+"')").eq(2).parent().parent().children("div");//한칸
	var $plusIcon2 = $("li:contains('"+keyword+"')").eq(3).parent().parent().children("div");//한칸이상
	
	if($("li:contains('"+keyword+"')").eq(2).attr("lvl") == 5){
		
		$($plusIcon).parent("li").removeClass("expandable lastExpandable");
		$($plusIcon).parent("li").addClass("collapsable lastCollapsable");
		$($plusIcon).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$($plusIcon).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$($plusIcon).parent("li").children("ul").css("display","block");
		
		$("li:contains('"+keyword+"')").eq(2)[0].scrollIntoView();
		$("li:contains('"+keyword+"')").eq(2)[0].click();
	}else{
		if($("li:contains('"+keyword+"')").eq(3)[0]){
			$($plusIcon2).parent("li").removeClass("expandable lastExpandable");
			$($plusIcon2).parent("li").addClass("collapsable lastCollapsable");
			$($plusIcon2).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
			$($plusIcon2).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
			$($plusIcon2).parent("li").children("ul").css("display","block");
			
			$("li:contains('"+keyword+"')").eq(3)[0].scrollIntoView();
			$("li:contains('"+keyword+"')").eq(3)[0].click();
		}
		
	}
	
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
	$(".myChecked").css("background-color","#2980b9");
	
	$('#selectEmpName').val($(obj).text().trim());
}

// 업무 수신자 목록으로 추가
function addEmpList(){
	if($('#selectEmpName').val().trim()==""){
		alert("수신자를 선택하세요.");
		return;
	}
	
	var trTag = "";
	
	if($(".managerModal").length > 0){//수신자 추가시 조건
		for(var i = 0; i < $(".myManager").length ; i++){
			var empId = $(".myManager").eq(i).attr("value");
			if($('.myChecked').attr('id') === empId){
				alert("이미 추가된 수신자입니다.");
				return false;
			}
		}
	
		trTag += '<tr class="id_'+$('.myChecked').attr('id')+' myManager" value="'+$('.myChecked').attr('id')+'">'
				+"<td>"+$('.myChecked').attr('data-name')+"</td>"
				+"<td>"+$('.myChecked').attr('data-dept')+"</td>"
				+'<td style="text-align: center;">'+$('.myChecked').attr('data-state')+"</td>"
				+'<td style="text-align: center;cursor:pointer;" onclick="removeElement(this);"><i class="icon-close"></i></td>'
				+"</tr>";
	}else{//참조자 추가시 조건
		for(var i = 0; i < $(".myReceptioner").length ; i++){
			var empId = $(".myReceptioner").eq(i).attr("value");
			if($('.myChecked').attr('id') === empId){
				alert("이미 추가된 참조자입니다.");
				return false;
			}
		}
		
		trTag +=  '<tr class="id_'+$('.myChecked').attr('id')+' myReceptioner" value="'+$('.myChecked').attr('id')+'">'
				+"<td>"+$('.myChecked').attr('data-name')+"</td>"
				+"<td>"+$('.myChecked').attr('data-dept')+"</td>"
				+'<td style="text-align: center;">'+$('.myChecked').attr('data-state')+"</td>"
				+'<td style="text-align: center;cursor:pointer;" onclick="removeElement(this);"><i class="icon-close"></i></td>'
				+"</tr>";
	}
	$('.empListTable tbody').append(trTag);
	if($(".myManager").length > 0){
		$(".noEmpList").css("display","none");
	}
	
	if($(".myReceptioner").length > 0){
		$(".noReceptionList").css("display","none");
	}
}


$(document).on("click",".addDept",function(){
// 	console.log($(this).attr("data-id"));
// 	console.log($(this).attr("data-name"));
	if(!confirm($(this).attr("data-name")+"을(를) 추가하시겠습니까?")){
		return false;
	}else{
		for(var i = 0; i < $(".myReceptionDept").length ; i++){
			var deptId = $(".myReceptionDept").eq(i).attr("value");
			if($(this).attr('data-id') === deptId){
				alert("이미 추가된 참조부서입니다.");
				return false;
			}
		}
		
		var tempTag = "";
		tempTag +='<tr class="myReceptioner myReceptionDept" value="'+$(this).attr("data-id")+'">'
				+"<td colspan='3' class='text-center'>"+$(this).attr("data-name")+"</td>"
				+'<td style="text-align: center;cursor:pointer;" onclick="removeElement(this);"><i class="icon-close"></i></td>'
				+"</tr>";
		$(".noReceptionList").css("display","none");
		$('.empListTable tbody').append(tempTag);
	}	
	
});




// 업무 수신자 리스트에서 삭제
function removeElement(obj){
	$(obj).closest('tr').remove();
	
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
// function finish(){
// 	if($('.empListTable tbody').children().length==1){
// 		alert('수신자를 한 명 이상 선택하세요.');
// 		return;
// 	}
// 	$('.empFinish').children().remove();
	
// 	$('form[name="temp"]').children().each(function(index,item){
// 		var divTag = '<div style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
// 					+'<span>'+$(this).attr('data-name')+'</span>'
// 					+'<i class="icon-close" data-class='+$(this).attr('class')+' style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
// 					+'</div>';
// 		$('.empFinish').append(divTag);
// 	});
	
// 	$('button[data-dismiss="modal"]').click();
// }

// 글 등록
function submit_go(){
	var boardCategory = $('#selectBoard').val();
	var form = document.boardRegistForm;
	
	if(boardCategory=='default'){
		alert('업무를 선택하세요.');
		return;
	}
	if($.trim($('#boardTitle').val())==""){
		alert('제목을 입력하세요.');
		$('#boardTitle').focus();
		return;
	}
	
	
	// 업무 제안
	if(boardCategory=='duty'){	
		if($('.empFinish').children().length==0){
			alert('수신자를 한 명 이상 선택하세요.');
			return;
		}
		if($.trim($('.note-editable').text())==""){
			alert('업무 내용을 입력하세요.');
			$('.note-editable').focus();
			return;
		}
	
		if($('#boardEndDt').val()==""){
			$('#dutyBoardEndDt').remove();
		}
		$('#dutyBoardTitle').val($('#boardTitle').val());
		$('#dutyBoardContent').val($('.note-editable').html());
		$('#dutyBoardEndDt').val($('#boardEndDt').val());
		
		// 수신자 추가
		for(var i = 0; i < $(".manager").length; i++){
			var empId = $(".manager").eq(i).attr('value');
			var inputTag1 = '<input class="empManagerList" type="hidden" name="dutyVO.empManagerList" value="'+empId+'"/>'
			$(form).append(inputTag1);
		}
		
		// 참조부서 추가
		if($('.receptionDept').length > 0){
			for(var i = 0; i < $(".receptionDept").length; i++){
				var deptId = $(".receptionDept").eq(i).attr('value');
				var inputTag2 = '<input class="empReceptionDeptList" type="hidden" name="dutyVO.empReceptionDeptList" value="'+deptId+'"/>'
				$(form).append(inputTag2);
			}
		}
		
		// 참조자 추가
		if($('.receptioner').length > 0){
			for(var i = 0; i < $(".receptioner").length; i++){	
				var empId = $(".receptioner").eq(i).attr('value');
				var inputTag3 = '<input class="empReceptionList" type="hidden" name="dutyVO.empReceptionList" value="'+empId+'"/>'
				
				$(form).append(inputTag3);
			};
		}
		form.encoding = 'multipart/form-data';
		form.action = "<c:url value='/board/duty/regist'/>";
	}
	// 업무 이슈 게시판
	else if(boardCategory=='issue'){
		if($.trim($('#dutyBoardIdForIssue').val())!=""){
			var checkNum = /[0-9]/;
			if(!checkNum.test($('#dutyBoardIdForIssue').val())){
				alert('업무 번호는 숫자만 입력 가능합니다.');
				$('#dutyBoardIdForIssue').focus();
				return;
			}
		}
		
		if($.trim($('.note-editable').text())==""){
			alert('이슈 내용을 입력하세요.');
			$('.note-editable').focus();
			return;
		}
		
		$('input[name="issueBoardTitle"]').val($('#boardTitle').val());
		$('input[name="issueBoardContent"]').val($('.note-editable').html());
		$('input[name="issueOpenSt"]').val($('#issueOpenStForIssue').val());
		
		if($.trim($('#dutyBoardIdForIssue').val())==""){
			$('input[name="dutyBoardId"]').remove();
		}else{
			$('input[name="dutyBoardId"]').val($('#dutyBoardIdForIssue').val());
		}
		
		form = document.issueRegistForm;
		form.action="<c:url value='/board/issue/regist'/>";
	}
	else{
		return;
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
			if(boardCategory=='issue'){
				alert("이슈가 등록되었습니다.");
				window.close();
				window.opener.location.href='<c:url value="/board/issue/list" />';
				
			}else if(boardCategory=='duty'){
				alert("업무가 등록되었습니다.");
				// 알림 전송
				$('input[name="dutyVO.empManagerList"]').each(function(index){
					var empId = $(this).val();
					(function(index){
// 						sendMessage(contextPath, receiverId, alarmTitle, alarmContent, alarmUrl, alarmCategory)
						sendMessage('${pageContext.request.contextPath}',
									empId,
									'새로운 업무가 등록되었습니다. 확인해주세요.',
									$('#boardTitle').val()+' #'+data,
									'${pageContext.request.contextPath}/board/duty/detail?dutyBoardId='+data,
									'업무관리');
					})(index);
				});
				if(window.opener.opener){//업무지시 버튼으로 열었을때는 3뎁스라 구분해야됨
					window.opener.opener.location.href='<c:url value="/board/duty/list" />';
					window.close();
				}else{
					window.opener.location.href='<c:url value="/board/duty/list" />';
					window.close();
				}
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
	
	if(!(extension == 'PNG' || extension == 'DOC' || extension == 'EXE' || extension == 'GIF' || extension == 'JAVA' || extension == 'JPG' || extension == 'PDF'|| extension == 'PPT'|| extension == 'TXT' || extension == 'XLSX'|| extension == 'ZIP' )){
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


</script>
<script> // 시연용
function presentationFill_1(){

	$("#boardTitle").val('어제 지시하신 업무 완료했습니다.');
	$("#boardEndDt").val('05/12/2021'); // 날짜
	$('#summernote').summernote('code', '<p>어제 지시하신 업무 완료했습니다.</p>');
	
}	
function presentationFill_2(){
	$("#boardTitle").val('불철주야팀 DBMS 변경 지시입니다.');
	$("#boardEndDt").val('05/12/2021'); // 날짜
	$('#summernote').summernote('code', '<p>불철주야팀 주도하에 DBMS를 오라클에서 MySQL로 변경해주세요.</p><p>완료기한은 5월 12일입니다.</p><p>첨부파일을 등록하였으니 참고하시기 바랍니다.</p>');
	
}
function presentationFill_3(){
	$("#boardTitle").val('불철주야팀 회의 일정 안내');
	$("#boardEndDt").val('05/14/2021'); // 날짜
	$('#summernote').summernote('code', '<p>예산 초과로 인해 품의서 결재가 반려되었습니다.</p><p>회의를 통해 예산 조정 해야합니다.</p><br><p>회의 일시 : 2021년 05월 14일 금요일 09:00 ~ 11:00 <br>회의 장소 : 분임토의 5실</p>');
	
}
function presentationFill_4(){
	$("#boardTitle").val('개발장비 긴급 구입 기안 요청');
	$("#boardEndDt").val('05/12/2021'); // 날짜
	$('#summernote').summernote('code', '<p>개발장비 노후로 인해 긴급 구입 요청합니다.</p><p>요청 결재선 : 김형민 사장님 (결재) - 민태원 부장님 (검토)</p><br><p>기안 시 제품 사양서 꼭 첨부 부탁드립니다.</p>');
	
}
</script>
</body>
