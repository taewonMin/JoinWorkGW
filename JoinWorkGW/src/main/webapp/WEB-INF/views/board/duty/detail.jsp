<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>


<style>
.attachList {
   cursor: pointer;
   font-weight: normal;
}
.attachList:hover {
   color: blue;
   text-decoration: underline;
}
</style>

<!-- 메인 content -->
<a id="viewModal" href="#defaultModal" data-toggle="modal" data-target="#defaultModal" style="display: none;"></a>
<a id="viewDeptModal" href="#deptModal" data-toggle="modal" data-target="#deptModal" style="display: none;"></a>

<div id="main-content" >
   <div class="container-fluid" >
      <form:form commandName="boardFormVO" name="detailForm" action="${pageContext.request.contextPath }/board/duty/detail">
         <form:hidden path="dutyVO.pageIndex"/>
         <form:hidden path="dutyVO.dutyBoardId" />
         <form:hidden path="dutyVO.dutyBoardTitle"/>
         <form:hidden path="dutyVO.dutyBoardContent"/>
         <form:hidden path="dutyVO.empName"/>
         <form:hidden path="dutyVO.dutyBoardReadcnt"/>
         <form:hidden path="dutyVO.searchDeadline"/>
         <form:hidden path="dutyVO.dutyBoardCreateDtStr"/>
         <c:forEach items="${duty.dutyManagerList }" var="dutyManager" varStatus="status">
            <form:hidden path="dutyVO.dutyManagerList[${status.index }].empId" value="${dutyManager.empId }" class="alarmReceiver"/>
            <form:hidden path="dutyVO.dutyManagerList[${status.index }].empName" value="${dutyManager.empName }"/>
            <form:hidden path="dutyVO.dutyManagerList[${status.index }].attendStName" value="${dutyManager.attendStName }"/>
            <form:hidden path="dutyVO.dutyManagerList[${status.index }].deptName" value="${dutyManager.deptName }"/>
            <form:hidden path="dutyVO.dutyManagerList[${status.index }].officialName" value="${dutyManager.officialName }"/>
         </c:forEach>
         <c:forEach items="${duty.dutyAttachList }" var="dutyAttach" varStatus="status">
            <form:hidden path="dutyVO.dutyAttachList[${status.index }].attachId" value="${dutyAttach.attachId }" />
            <form:hidden path="dutyVO.dutyAttachList[${status.index }].attachPath" value="${dutyAttach.attachPath }" />
            <form:hidden path="dutyVO.dutyAttachList[${status.index }].attachName" value="${dutyAttach.attachName }" />
            <form:hidden path="dutyVO.dutyAttachList[${status.index }].attachType" value="${dutyAttach.attachType }" />
            <form:hidden path="dutyVO.dutyAttachList[${status.index }].attachSize" value="${dutyAttach.attachSize }" />
         </c:forEach>
         
         <div class="block-header">
               <div class="row">
                  <div class="col-sm-8">
                      <h2 style="padding-left:10px;font-size:2em;font-family: S-CoreDream-6Bold"><i class="icon-note"></i>&nbsp;업무 상세 #${duty.dutyBoardId } </h2>
                   </div>
                   <div class="col-sm-4" style="font-family: S-CoreDream-6Bold">
                        <div style="float:right;">
                           <c:if test="${loginUser.empId == duty.empWriterId }">
	                           	<c:if test="${duty.modifiable eq 'Y' }">
	                            	<button type="button" class="btn btn-info" style="width:80px;" onclick="modify_go();">수정</button>
	                           	</c:if>
	                            <button type="button" class="btn btn-danger" style="width:80px;" onclick="remove_go();">삭제</button>
                           </c:if>
                          <button type="button" onclick="window.close();" class="btn btn-secondary" style="width:80px;">닫기</button>
                      </div>
                   </div>
               </div>
               <div style="padding:5px 15px 0 15px">
               	<c:set value="0" var="readCount"/>
               	<strong>
	                 <c:forEach items="${duty.dutyManagerList }" var="dutyManager" varStatus="status">
	                 	<c:if test="${dutyManager.readSt eq 'Y' }">
	                 		<c:if test="${readCount eq 0 }">
	                 		[
	                 		</c:if>
	                 		${dutyManager.empName }&nbsp;
	                 		<c:set value="${readCount + 1 }" var="readCount" />
	                 	</c:if>
	                 </c:forEach>
	                 <c:if test="${readCount ne 0}">
	                		읽음 ]
	               	 </c:if>
                </strong>
               </div>
           </div>
           <div class="row clearfix" style="font-family: S-CoreDream-4Regular">
               <div class="col-lg-12 col-md-12 col-sm-12">
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
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">${duty.dutyBoardTitle }</div>
                              </td>
                           </tr>
                           <tr>
                              <td>
                                 <strong>작성자</strong>
                              </td>
                              <td style="width:200px;">
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">
									<button type="button" class="btn btn-outline-secondary" id="${duty.empWriterId }" onclick="empChecked(this);">${duty.empName }</button>
								 </div>
                              </td>
                              <td style="width:130px;">
                                 <strong>수신자</strong>
                              </td>
                              <td colspan="3">
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">
                                    <c:forEach items="${duty.dutyManagerList }" var="dutyManager" varStatus="status">							
                                       <button type="button" class="btn btn-outline-secondary" id="${dutyManager.empId }" onclick="empChecked(this);">${dutyManager.empName }</button>
                                    </c:forEach>
                                 </div>
                              </td>
                           </tr>
                           <tr>
                              <td>
                                 <strong>참조자</strong>
                              </td>
                              <td colspan="5">
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">
                                 	<c:choose>
                                 		<c:when test="${empty duty.receptionDeptList && empty duty.receptionList }">
                                 			<span style="font-weight: normal;">없음</span>
                                 		</c:when>
                                 		<c:otherwise>
											<c:forEach items="${duty.receptionDeptList }" var="receptionDept">
												<button type="button" class="btn btn-outline-dark" onclick="deptChecked(this);" id="${receptionDept.deptId }" >${receptionDept.deptName }</button> 
											</c:forEach>
											<c:forEach items="${duty.receptionList }" var="receptioner">
												<button type="button" class="btn btn-outline-secondary" id="${receptioner.empId }" onclick="empChecked(this);">${receptioner.empName }</button>
											</c:forEach>
                                 		</c:otherwise>
                                 	</c:choose>
                                 </div>
                              </td>
                           </tr>
                           
                           
                           <tr>
                              <td>
                                 <strong>작성일자</strong>
                              </td>
                              <td>
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">
                                    <fmt:formatDate value="${duty.dutyBoardCreateDt }" pattern="yyyy-MM-dd"/>
                                 </div>
                              </td>
                              <td>
                                 <strong>완료날짜</strong>
                              </td>
                              <td style="width:200px;">
                                 <div style="padding-left:15px;border-left: 1px dotted gray;" id="searchDeadline">
                                 	<c:if test="${!empty duty.dutyBoardEndDt }">
	                                    <fmt:formatDate value="${duty.dutyBoardEndDt }" pattern="yyyy-MM-dd"/>
                                 	</c:if>
                                 	<c:if test="${empty duty.dutyBoardEndDt }">
                                 		<span>없음</span>
                                 	</c:if>
                                 </div>
                              </td>
                              <td style="width:130px;">
                                 <strong>조회수</strong>
                              </td>
                              <td>
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">${duty.dutyBoardReadcnt }</div>
                              </td>
                           </tr>
                           <tr>
                              <th>
                                 <i class="fa fa-download"></i>
                                 <strong>첨부파일</strong>
                              </th>
                              <th colspan="5">
                                 <div style="padding-left:15px;border-left: 1px dotted gray;">
                                    <c:if test="${duty.dutyAttachList.size() > 0 }">
                                       <c:forEach items="${duty.dutyAttachList }" var="dutyAttach">
                                          <span class="attachList" data-attachId="${dutyAttach.attachId }" data-filePath="${dutyAttach.attachPath }" onclick="fileDownload(this);" style="font-weight: normal; margin-right:15px;">
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
                                    <c:if test="${duty.dutyAttachList.size() == 0 }">
                                       <span style="font-weight: normal;">없음</span>
                                    </c:if>
                                 </div>
                              </th>
                           </tr>
                           <!-- 내용 -->
                           <tr>
                              <th colspan="6" style="padding:15px;">
                                 ${duty.dutyBoardContent }
                              </th>
                           </tr>
                        </thead>
                     </table>
                     </div>
                  </div>
                    </div>
               </div>
           </div>
         </form:form>
         
         
        <!-- 댓글 -->
        <div class="card" style="font-family: S-CoreDream-4Regular">
            <div class="body">
                 <span style="font-weight: bold;">댓글 ${paginationInfo.totalRecordCount}</span>
                 <!-- 댓글 등록 -->
                 <div class="body" style="background-color: #eee;margin-top:15px;">
                    <div class="form-group">
                       <textarea id="replyContent" rows="3" class="form-control no-resize" placeholder="업무에 대한 댓글을 남기세요."></textarea>
                    </div>
                    <div class="post-toolbar-b align-right">
                    	<button type="button" class="btn hiddenFillBtn" onclick="presentationFill_1();" style="position:absolute;right:7em;top:12em;color:#eeeeee; z-index: 100; border: 0px;">시연용버튼1</button>
                        <button class="btn btn-primary" onclick="registDutyReply();">등록</button>
                   </div>
                </div>
                <c:if test="${duty.dutyReplyList.size() == 0 }">
                   <hr>
                   <div style="height:70px;text-align: center;padding:10px;">
                      <span>등록된 댓글이 없습니다.</span>
                   </div>
                </c:if>
                <c:if test="${duty.dutyReplyList.size() > 0 }">
                   <c:forEach items="${duty.dutyReplyList }" var="dutyReply">
                      <hr>
                      <div class="container-fluid" id="replyList_${dutyReply.replyId }">
                         <div class="row">
                            <div class="col-12">
                                 <p style="font-weight: bold;margin-bottom:5px;display:inline-block;">${dutyReply.empName }</p>
                                 <span style="color:gray;font-size: revert;padding-left:10px;margin-left:10px;border-left:1px solid gray;"><fmt:formatDate value="${dutyReply.replyUpdateDt }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                 <c:if test="${loginUser.empId == dutyReply.empWriterId }">
                                    <div class="float-right">
                                        <a href="javascript:void(0);" onclick="modifyReplyForm(${dutyReply.replyId},'${dutyReply.replyContent }');"><i class="fa fa-edit"></i> 수정</a>
                                        <a href="javascript:void(0);" style="margin-left:10px;" onclick="removeReply(${dutyReply.replyId});"><i class="fa fa-trash-o"></i> 삭제</a>
                                    </div>
                
                                 </c:if>
                                 <h6 style="margin-bottom:5px;">${dutyReply.replyContent }</h6>
                             </div>
                         </div>
                      </div>
                   </c:forEach>
                    <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:15px;">
                         <ul class="pagination" style="display: inline-block;">
                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchDutyReplyList" />
                         </ul>
                     </nav>
                </c:if>
            </div>
        </div>
   </div>
</div>

<!--직원상세 모달창 -->
<div class="modal fade" id="defaultModal"  tabindex="-1" role="dialog" style="font-family: InfinitySans-RegularA1;">
	<div class="modal-dialog" role="document">
	    <div class="modal-content" style="width:290px;">
	        <div class="modal-header" style="display: block; text-align: center;">
	            <h4 class="title" id="defaultModalLabel">직원 상세조회</h4>
	        </div>
	        <div class="modal-body">
	                  <div class="body text-center">
	                      <div class="chart easy-pie-chart-1 user-photo" id="empPicture" style="width: 100px;height: 100px; border-radius: 50%;"></div>
	                        <h5 id="modalName"></h5>
	                        <h5 id="modalEmail"></h5>
	                        <h5 id="modalHp"></h5>
	                        <button class="btn btn-success" style="width: 76%;" onclick="dutyIndication(this);">업무 제안</button>
	                    </div>
	          </div>
	          <div class="modal-footer">
	              <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	          </div>
	      </div>
	</div>
</div>

<!--부서상세 모달창 -->
<div class="modal fade" id="deptModal" tabindex="-1" role="dialog" style="font-family: InfinitySans-RegularA1">
	<div class="modal-dialog" role="document">
	    <div class="modal-content" style="width:600px; height: 500px;">
	        	<div class="modal-header" style="display: block; text-align: center;">
	            	<h4 class="title" id="defaultModalLabel">부서 상세조회</h4>
	        	</div>
		        <div class="modal-body" style="overflow-y: scroll;">
					<table class="table table-hover js-basic-example dataTable table-custom table-striped m-b-0 c_list">
						<thead class="thead-dark">
						    <tr>
						        <th>이름</th>
						        <th>직급</th>
						        <th>부서/팀</th>
						        <th>연락처</th>
						        <th>업무제안</th>
						    </tr>
						</thead>
						<tbody class="myAppendTbody">
							<!-- 부서원들 정보 들어갈자리 -->
						</tbody>
		 			</table>
		       </div>
	          <div class="modal-footer">
	              <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	          </div>
	      </div>
	</div>
</div>





<form name="fileForm" action="${pageContext.request.contextPath }/common/getFile" method="post">
   <input type="hidden" name="fileUploadPath"/>
   <input type="hidden" name="attachId"/>
</form>

<form name="replyRegistForm">
   <input type="hidden" name="dutyReplyVO.dutyBoardId" value="${duty.dutyBoardId }" />
   <input type="hidden" name="dutyReplyVO.empWriterId" value="${loginUser.empId }"/>
   <input type="hidden" name="dutyReplyVO.replyContent" />
</form>

<script type="text/javascript">
window.onload=function(){
   	paginationCSS(
		   ${paginationInfo.currentPageNo},
           ${paginationInfo.firstPageNoOnPageList},
           ${paginationInfo.lastPageNoOnPageList},
           ${paginationInfo.totalPageCount});
}

// 파일 다운로드
function fileDownload(obj){
   var fileForm = $('form[name="fileForm"]');
   $('input[name="attachId"]').val($(obj).attr('data-attachId'));
   $('input[name="fileUploadPath"]').val($(obj).attr('data-filePath'));
   fileForm.submit();
}

// 댓글 등록
function registDutyReply(){
   if($.trim($('textarea#replyContent').val())==""){
      alert('내용을 입력하세요.');
      $('textarea#replyContent').focus();
      return;
   }
   
   $('input[name="dutyReplyVO.replyContent"]').val($('textarea#replyContent').val());
   
   $.ajax({
      url:'<c:url value="/board/duty/reply/regist"/>',
      type:'post',
      data:$('form[name="replyRegistForm"]').serialize(),
      success:function(){
         alert('댓글 등록 완료');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 등록이 실패했습니다.');
      }
   });
}

// 댓글 수정창 표시
function modifyReplyForm(replyId, replyContent){
   if($('#replyListModify_'+replyId).children().length>0){
      return;
   }
   var modifyForm = '<div id="replyListModify_'+replyId+'" class="body" style="background-color: #eee;margin-top:15px;">'
                   +'<div class="form-group">'
                         +'<textarea id="replyContent" rows="3" class="form-control no-resize">'+replyContent+'</textarea>'
                   +'</div>'
                   +'<div class="post-toolbar-b align-right">'
                       +'<button class="btn btn-info" onclick="modifyReply('+replyId+');">수정</button>'
                       +'<button style="margin-left:5px;" class="btn btn-secondary" onclick="modifyCancel('+replyId+');">취소</button>'
                  +'</div>'
               +'</div>'
   $('#replyList_'+replyId).append(modifyForm);
}

// 댓글 수정
function modifyReply(replyId){
   var textarea = $('#replyListModify_'+replyId+' textarea');
   if($.trim(textarea.val()) == ""){
      alert('내용을 입력하세요.');
      textarea.focus();
      return;
   }
   
   $.ajax({
      url:'<c:url value="/board/duty/reply/modify"/>',
      type:'post',
      data:{'replyId':replyId,'replyContent':textarea.val()},
      success:function(){
         alert('댓글이 수정되었습니다.');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 수정 실패');
         window.location.reload(true);
      }
   });
}

// 댓글 수정 취소
function modifyCancel(replyId){
   $('#replyListModify_'+replyId).remove();
}

// 댓글 삭제
function removeReply(replyId){
   var chk = confirm('댓글을 삭제하시겠습니까?');
   if(!chk) return;
   
   $.ajax({
      url:'<c:url value="/board/duty/reply/remove"/>',
      type:'post',
      data:{'replyId':replyId},
      success:function(){
         alert('댓글이 삭제되었습니다.');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 삭제 실패');
      }
   });
}

// 댓글 페이지네이션
function searchDutyReplyList(pageNo){
   if(!pageNo){
      pageNo = 1;
   }
   var detailForm = document.detailForm;
   $('input[name="dutyVO.pageIndex"]').val(pageNo);
   detailForm.submit();
}

// 수정 페이지
function modify_go(){
   var dutyModifyForm = document.detailForm;
   dutyModifyForm.action = '${pageContext.request.contextPath }/board/duty/modifyForm';
   
   $('input[name="dutyVO.searchDeadline"]').val('<fmt:formatDate value="${duty.dutyBoardEndDt }" pattern="yyyy-MM-dd"/>');
   $('input[name="dutyVO.dutyBoardCreateDtStr"]').val('<fmt:formatDate value="${duty.dutyBoardCreateDt }" pattern="yyyy-MM-dd"/>');
   
   dutyModifyForm.submit();
}

// 게시글 삭제
function remove_go(){
   var check = confirm('업무 제안글을 삭제하시겠습니까?');
   if(!check) return;
   
   var detailForm = document.detailForm;
   detailForm.action = '${pageContext.request.contextPath }/board/duty/remove';
   
   var form = new FormData(detailForm);
   
   $.ajax({
      url:detailForm.action,
      type:'post',
      data:form,
      processData:false,
      contentType:false,
      success:function(){
         alert('글이 삭제되었습니다.');
         
         $('.alarmReceiver').each(function(){
            var empId = $(this).val();
            sendMessage('${pageContext.request.contextPath}',
                     empId,
                     '담당 업무가 삭제되었습니다.',
                     '${duty.dutyBoardTitle } #${duty.dutyBoardId}',
                     '',
                     '업무관리');
         });
         
         window.opener.location.reload(true);
         window.close();
      },
      error:function(){
         alert('삭제 실패');
      }
   });
}
</script>

<script>
// 직원상세정보
function empChecked(obj) {
	var empId = $(obj).attr("id");
	
	$.ajax({
		type:"POST",
		url:"<c:url value='/emp/getEmp'/>",
		contentType:"application/json",
	 	data : empId,
		processData:true,
		success: function(data) {
			var attendStName = data.attendStName;
			var deptName = data.deptName;
			var empEmail = data.empEmail;
			var empHp = data.empHp;
			var officialName = data.officialName;
			var empName = data.empName;
			var empId = data.empId;
			var stSpan = "";
			
			$("#defaultModalLabel").html(deptName);
			$("#modalName").html(empName+' '+officialName);
			$("#modalName").attr("value",empName+' '+officialName);
			$("#modalName").attr("data-empId",empId);
			$("#modalEmail").html(empEmail);
			$("#modalHp").html(empHp);
			if(attendStName === '휴가중'){
				stSpan = "&nbsp<span class='badge badge-warning'>"+attendStName+"</span>";
			}else{
				stSpan = "&nbsp<span class='badge badge-success'>"+attendStName+"</span>";
			}
			$("#modalName").append(stSpan);
			
			getModalPicture(empId);
		},
		error: function(e) {
			console.log(e);
		}
	});
	$("#viewModal").click();
}
// 직원사진
function getModalPicture(empId){
	var imageURL = "/JoinWorkGW/emp/getPicture?picture="+empId+".jpg";
	$('div#empPicture').css({'background-image':'url('+imageURL+')',
		'background-position':'center',
		'background-size':'cover',
		'background-repeat':'no-repeat'
	}).trigger("create");
}

function deptChecked(obj){
	var deptId = $(obj).attr("id");
	
	$.ajax({
		type:"POST",
		url:"<%=request.getContextPath()%>/emp/getDeptDetail",
		contentType:"application/json",
		data: deptId,
		async:false,
		processData:true,
		success: function(data) {
			$(".myAppendTbody").html("");
			console.log(data);
			OpenModalDeptDetail(data);
		},
		error: function(e){
			alert("부서조회중 에러발생!");
		}
	});
	
	$("#viewDeptModal").click();
}

function OpenModalDeptDetail(data){
	var str = "";
	console.log(data);
	console.log(data.length);
	
	for(var i = 0;i < data.length ; i++){                
		str +="	<tr>";
	    str +="    <td>";
	    str +="       "+data[i].empName+"";
	    str +="    </td>";
	    str +="    <td>"+data[i].officialPositionName+"</td>";
	    str +="    <td>"+data[i].deptName+"</td>";
	    str +="    <td>"+data[i].empHp+"</td>";
	    str +="    <td><button type='button' class='btn btn-outline-secondary' data-empName='"+data[i].empName+" "+data[i].officialPositionName+"' id='"+data[i].empId+"' onclick='dutyIndicationByDept(this);'>제안</button></td>";
	    str +="</tr>";
	    $(".myAppendTbody").append(str); 
	    str = "";
	}
}

function dutyIndication(obj){
	var empName = $(obj).parent().find("#modalName").attr("value");
	var empId = $(obj).parent().find("#modalName").attr("data-empId");
	
 	var openWin = window.open('/JoinWorkGW/board/duty/registForm?registParam=duty', '업무 작성', "width=1000, height=700");
	
	var tempTag = "";
	
	tempTag += '<div style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
			+'<span>'+empName+'</span>'
			+'<div class="hiddenId manager" style="display:none;" value="'+empId+'"></div>'
			+'<i class="icon-close" style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
			+'</div>';
			
	setTimeout(function(){
		console.log(openWin.document.getElementById("myEmpFinish"));
		openWin.document.getElementById("myEmpFinish").innerHTML = tempTag;
	},600)
}

function dutyIndicationByDept(obj){
	var empName = $(obj).attr("data-empName");
	var empId = $(obj).attr("id");
	
 	var openWin = window.open('/JoinWorkGW/board/duty/registForm?registParam=duty', '업무 작성', "width=1000, height=700");
	
	var tempTag = "";
	
	tempTag += '<div style="border:1px solid #ced4da;border-radius: 0.25rem;padding:10px 15px;width:150px;display:inline-block;">'
			+'<span>'+empName+'</span>'
			+'<div class="hiddenId manager" style="display:none;" value="'+empId+'"></div>'
			+'<i class="icon-close" style="float:right;cursor:pointer;margin-top:5px;" onclick="deleteElement(this);"></i>'
			+'</div>';
			
	setTimeout(function(){
		console.log(openWin.document.getElementById("myEmpFinish"));
		openWin.document.getElementById("myEmpFinish").innerHTML = tempTag;
	},600)
}




</script>
<script> //시연
function presentationFill_1(){
	$("#replyContent").val('네. 확인했습니다.');
}	

</script>

