<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<style>
.milestone:hover {
	cursor: pointer;
	color: #2980b9;
}
.pictureView{
	border-radius: 50%;
	border: 1px solid gray; 
	margin: 0px 20px 0px 0px;
	background-position: center;
	background-size: cover;
	background-repeat: no-repeat;
}
</style>

<!-- 메인 content -->
<div id="main-content" >
	<div class="container-fluid" >
		<form:form commandName="boardFormVO" name="detailForm" method="post">
			<form:hidden path="issueVO.issueBoardId"/>
			<form:hidden path="issueVO.issueBoardContent"/>
			<form:hidden path="issueVO.issueBoardSt"/>
			<div class="block-header">
	            <div class="row">
	            	<div class="col-sm-9" style="width:80%;">
	                	<h2 class="detailMode" style="padding-left:10px; font-size:2.5em; font-family:S-CoreDream-6Bold ">
	                	<span id="spanIssueBoardTitle" style="word-wrap:break-word;">${issue.issueBoardTitle }</span> #${issue.issueBoardId } </h2>
	                	<form:input path="issueVO.issueBoardTitle" class="modifyMode" style="width:100%;padding-left:10px;font-size:2em;display:none;" />
	                	<div style="font-family: S-CoreDream-4Regular">
                			<span class="openIssueBadge" <c:if test="${issue.issueBoardSt eq 'N' }">style="display:none;"</c:if>>
	 	 	              		<span class="badge badge-success" style="font-size:1.2em;margin: 10px 10px 0px;">
		                			<i class="icon-info" style="color:#22af46;vertical-align: middle;"></i>
		                			<span style="line-height: 1.2em;vertical-align: middle;">Open</span>
	                			</span>
                			</span>
                			<span class="closedIssueBadge" <c:if test="${issue.issueBoardSt eq 'Y' }">style="display:none;"</c:if>>
	 	 	              		<span class="badge badge-danger" style="font-size:1.2em;margin: 10px 10px 0px;">
		                			<i class="icon-check" style="color:red;vertical-align: middle;"></i>
		                			<span style="line-height: 1.2em;vertical-align: middle;">Closed</span>
	                			</span>
                			</span>
                			<div style="display:inline;font-size:1.2em;vertical-align: middle;">
	                			<strong>${issue.empName } |</strong>
	                			<span style="margin-left:5px;"> ${issue.issueBoardCreateDt.split(" ")[0] } </span>
	                			<span style="margin-left:5px;">•</span>
	                			<span style="margin-left:5px;">댓글 <span id="issueReplyCount">${issue.replyCount }</span></span>
	                			<span class="detailMode">
	                				<span id="spanIssueOpenSt" <c:if test="${issue.issueOpenSt eq 'Y' }">style="display:none;"</c:if> >
			                			<span style="margin-left:5px;">•</span>
			                			<span style="margin-left:5px;">비공개</span>
	                				</span>
	                			</span>
	                			<span class="modifyMode m-l-15" style="display:none;">
	                				<select name="issueVO.issueOpenSt">
	                					<option <c:if test="${issue.issueOpenSt eq 'Y' }">selected</c:if> value="Y">공개</option>
	                					<option <c:if test="${issue.issueOpenSt eq 'N' }">selected</c:if> value="N">비공개</option>
	                				</select>
	                			</span>
                			</div>
	                	</div>
	                </div>
	                <div class="col-sm-3">
	               		<div style="float:right;">
	               			<c:if test="${loginUser.empId == issue.empId }">
		                    	<button type="button" class="btn btn-info detailMode" style="width:80px;font-family: S-CoreDream-6Bold;" onclick="changeMode('제목');">수정</button>
		                    	<button type="button" class="btn btn-danger detailMode" style="width:80px;font-family: S-CoreDream-6Bold;" onclick="removeIssue();">삭제</button>
		                    	<button type="button" class="btn btn-primary modifyMode" style="width:80px;display:none;" onclick="saveIssue('제목');">저장</button>
	               			</c:if>
	                    	<button type="button" onclick="window.close();" class="btn btn-secondary detailMode" style="width:80px; font-family: S-CoreDream-6Bold">닫기</button>
	                    	<button type="button" onclick="changeMode('제목');" class="btn btn-secondary modifyMode" style="width:80px;display:none;">취소</button>
	                	</div>
	             	</div>
	            </div>
	        </div>
	        
	        <div class="row clearfix" style="font-family: S-CoreDream-4Regular">
                <div class="col-lg-9">
                    <div class="card">
                        <div class="body">
                        	
                        	<ul id="replyHistory" class="right_chat list-unstyled mb-0" style="border-bottom:2px solid rgb(0,0,0,0.2);">
                       			<!-- 이슈 내용 -->
                        		<li class="online" style="clear:both;border:1.5px solid rgb(0,0,0,0.2);border-radius:15px;">
	                                <div class="media" style="margin:0px;border-bottom:1px solid rgb(0,0,0,0.2);padding:10px 20px;">
	                                	<div  class="rounded-circle avatar pictureView" style="background-image:url('${pageContext.request.contextPath}/admin/emp/getPicture?picture=${issue.empPicture }');width: 60px; height: 60px;"></div>
	                                    <div class="media-body" style="margin-top: 7px;">
	                                        <strong class="name" style="font-size:1.2em;display:inline;vertical-align: middle;">${issue.empName }</strong>
	                                        <span class="badge badge-default" style="color:black;border-color: black;">작성자</span>
	                                        <br>
	                                        <span class="message issueDate" style="font-size:1.1em;"></span>
	                                    </div>
	                                </div>
	                                <div style="padding:20px;">
	                                	<div class="row">
	                                		<div class="col-lg-10">
		                                        <span id="spanIssueBoardContent" class="detailModeContent" style="font-size:1.1em;">${issue.issueBoardContent }</span>
	                                		</div>
	                                		<div class="col-lg-2">
	                                			<c:if test="${loginUser.empId == issue.empId }">
			                                    	<a href="javascript:void(0);" class="btn btn-sm btn-outline-info detailModeContent float-right" title="수정" onclick="changeMode('내용');"><i class="icon-pencil"></i></a>
			                                    </c:if>
	                                		</div>
	                                	</div>
	                                	<div class="row modifyModeContent" style="display:none;">
	                                		<div class="col-lg-12">
		                                        <div class="summernote" id="summernote" >${issue.issueBoardContent }</div>
		                                        <div class="m-t-10" style="float:right;">
				                                    <button type="button" class="btn btn-primary" style="width: 60px;" onclick="saveIssue('내용');">저장</button>
				                                    <button type="button" class="btn btn-secondary" style="width: 60px;" onclick="changeMode('내용');" >취소</button>
		                                        </div>
	                                		</div>
	                                	</div>
	                                </div>
		                        </li>
		                        
		                        
		                        
		                        <!-- 댓글 및 알림 -->
		                        <c:forEach items="${issueReplyList }" var="issueReply" varStatus="status">
		                        	<!-- 댓글 -->
		                        	<c:if test="${issueReply.replyGroupCode eq 1 }">
		                        		<!-- 처음이 댓글일 경우 -->
		                        		<c:if test="${status.index eq 0 }">
		                        			<li class="replyBridge" style="clear:both;border-left:1px solid black;height:30px;margin-left:30px;">
		                        			</li>
		                        		</c:if>
				                        <li id="li_${issueReply.replyId }" class="online" style="clear:both;border:1.5px solid rgb(0,0,0,0.2);border-radius:15px;">
			                                <div class="media" style="margin:0px;border-bottom:1px solid rgb(0,0,0,0.2);padding:10px 20px;">
			                                    <div  class="rounded-circle avatar pictureView" style="background-image:url('${pageContext.request.contextPath}/admin/emp/getPicture?picture=${issueReply.empPicture }');width: 60px; height: 60px;"></div>
			                                    <div class="media-body" style="margin-top: 7px;">
			                                        <strong class="name" style="font-size:1.2em;display:inline;vertical-align: middle;">${issueReply.empName }</strong>
			                                        <c:if test="${issueReply.empWriterId == issue.empId }">
				                                        <span class="badge badge-default" style="color:black;border-color: black;">작성자</span>
			                                        </c:if>
			                                        <br>
			                                        <span class="message replyDate" data-createDt="${issueReply.replyCreateDt }" style="font-size:1.1em;"></span>                                                
			                                    </div>
			                                </div>
			                                <div style="padding:20px;">
		                                        <div id="replyForm_${issueReply.replyId }" style="width:90%;display:inline-block;">
			                                        <span id="spanIssueReplyContent_${issueReply.replyId }" class="detailModeReply_${issueReply.replyId }" style="font-size:1.1em;">${issueReply.replyContent }</span>
			                                        <!-- 댓글 수정창 -->
			                                        <div class="modifyModeReply_${issueReply.replyId }" style="display:none;">
				                                        <div class="summernote">${issueReply.replyContent }</div>
				                                        <div class="m-t-10" style="float:right;">
						                                    <button type="button" class="btn btn-primary" style="width: 60px;" onclick="modifyReply(${issueReply.replyId});">저장</button>
						                                    <button type="button" class="btn btn-secondary" style="width: 60px;" onclick="changeMode('댓글','${issueReply.replyId }');" >취소</button>
				                                        </div>
				                                	</div>
			                                	</div>
			                                	<div class="detailModeReply_${issueReply.replyId }" style="display:inline;float:right;">
			                                		<c:if test="${issueReply.empWriterId == loginUser.empId }">
					                                    <a href="javascript:void(0);" class="btn btn-sm btn-outline-info" title="수정" onclick="changeMode('댓글','${issueReply.replyId }');"><i class="icon-pencil"></i></a>
			                                            <a href="javascript:void(0);" class="btn btn-sm btn-outline-danger" title="삭제" onclick="removeReply(${issueReply.replyId});"><i class="icon-trash"></i></a>
			                                		</c:if>
			                                	</div>                                           
			                                </div>
				                        </li>
				                        <!-- 마지막이 댓글이거나 다음 요소가 댓글일 경우 -->
				                        <c:if test="${status.index eq issueReplyList.size()-1 || issueReplyList.get(status.index+1).replyGroupCode eq 1}">
		                        			<li class="replyBridge" style="clear:both;border-left:1px solid black;height:30px;margin-left:30px;">
		                        			</li>
		                        		</c:if>
		                        	</c:if>
		                        	
		                        	<!-- 공지 -->
		                        	<c:if test="${issueReply.replyGroupCode eq 2 }">
		                        		<li class="left float-left" style="margin-bottom:0px;width:100%;">
				                            <div class="timeline-item black" style="margin-left:30px;">
				                                <span class="date replyDate" data-createDt="${issueReply.replyCreateDt }"></span>
				                                <h5 style="font-weight:bold;">${issueReply.replyContent.split("@")[0] }</h5>
				                                <p style="margin:5px 0px 0px;">${issueReply.replyContent.split("@")[1] }</p>
				                            </div>        
				                        </li>
				                        <li style="clear:both;"></li>
		                        	</c:if>
		                        	
		                        	<!-- 이슈 재진행 -->
		                        	<c:if test="${issueReply.replyGroupCode eq 3 }">
		                        		<li class="left float-left" style="border-top:2px solid #86c541;margin-bottom:0px;width:100%;">
				                            <div class="timeline-item green" style="margin-left:30px;">
				                                <span class="date replyDate" data-createDt="${issueReply.replyCreateDt }"></span>
				                                <h5 style="font-weight:bold;">이슈 재시작</h5>
				                                <p style="margin:5px 0px 0px;">${loginUser.empName }님이 이슈를 다시 진행시켰습니다.</p>
				                            </div>        
				                        </li>
				                        <li style="clear:both;"></li>
		                        	</c:if>
		                        	
		                        	<!-- 이슈 종료 -->
		                        	<c:if test="${issueReply.replyGroupCode eq 4 }">
		                        		<li class="left float-left closedHistory" style="border-bottom:2px solid #ee2558;width:100%; <c:if test='${status.index+1 == issueReplyList.size() || issueReplyList.get(status.index+1).replyGroupCode ne 2 }'>margin-bottom:30px;</c:if>">
				                            <div class="timeline-item danger" style="margin-left:30px;">
				                                <span class="date replyDate" data-createDt="${issueReply.replyCreateDt }"></span>
				                                <h5 style="font-weight:bold;">이슈 종료</h5>
				                                <p style="margin:5px 0px 0px;">${loginUser.empName }님이 이슈를 종료시켰습니다.</p>
				                            </div>
				                        </li>
				                        <li class="closedHistory" style="clear:both;"></li>
		                        	</c:if>
		                        </c:forEach>
		                        
		                        <!-- 히스토리가 없으면 -->
		                        <c:if test="${empty issueReplyList }">
	                       			<li class="replyBridge" style="clear:both;border-left:1px solid black;height:30px;margin-left:30px;">
	                       			</li>
	                       		</c:if>
		                        
                        	</ul>
                        
			           		<!-- 댓글 등록 -->
			           		<div class="body openIssueBadge" style="<c:if test="${issue.issueBoardSt eq 'N' }">display:none;</c:if>background-color: #eee;margin-top:15px;">
			                    <div class="form-group">
			                    	<div class="summernote" id="replySummernote"></div>
			                    </div>
			                    <div class="align-right">
			                    	<c:if test="${issue.empId == loginUser.empId }">
				                        <button type="button" class="btn btn-danger" onclick="saveIssue('이슈상태','N');">이슈 종료</button>
			                    	</c:if>
			                    	<button type="button" class="btn hiddenFillBtn" onclick="presentationFill_1();" style="position:absolute;right:15em;bottom:3em;color:#eeeeee; z-index: 100; border: 0px;">시연용버튼1</button>
			                        <button type="button" class="btn btn-primary" onclick="registIssueReply(1);" >댓글 등록</button>
			                	</div>
			                </div>
			                <!-- 이슈 재진행 -->
			                <div class="closedIssueBadge" <c:if test="${issue.issueBoardSt eq 'Y' }">style="display:none;"</c:if>>
				                <button type="button" class="btn btn-success float-right" style="margin-top:10px;" onclick="saveIssue('이슈상태','Y');">이슈 재진행</button>
				                <div style="clear:both;"></div>
			                </div>
                        </div>
                    </div>
                </div>
                
                <!-- 우측 사이드바 -->
                <div class="col-lg-3" style="padding-left:0px;">
                    <div class="m-b-10 card">
                        <div class="body">
                        	<div <c:if test="${loginUser.empId == issue.empId }">class="milestone" onclick="changeMode('업무번호');"</c:if> >
	                        	<strong>관련 업무</strong>
	                        	<i class="icon-settings float-right"></i>
                        	</div>
                        	<div class="m-t-10 detailModeTask">
	                        	<span id="spanDutyBoardId" class="btn btn-secondary" style="height: 18px;padding: 0px 3px;font-size:0.8em;<c:if test="${empty issue.dutyBoardTitle }">display:none;</c:if>" onclick="OpenWindow('${pageContext.request.contextPath }/board/duty/detail?dutyBoardId=${issue.dutyBoardId }', '업무 상세', 900, 700);"># ${issue.dutyBoardId }</span>
	                        	<span id="spanNoDutyBoardId" class="m-r-5" style="vertical-align:middle;<c:if test="${!empty issue.dutyBoardTitle || issue.dutyBoardId eq '0' }">display:none;</c:if>">#${issue.dutyBoardId }</span>
                        		<span id="spanDutyBoardTitle" style="max-width:75%;vertical-align:middle;display:inline-block;overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
                        			<c:if test="${!empty issue.dutyBoardTitle }">
                        				${issue.dutyBoardTitle }
                        			</c:if>
                        			<c:if test="${empty issue.dutyBoardTitle }">
		                        		관련 업무가 없습니다.
                        			</c:if>
                        		</span>
                        	</div>
                        	<!-- 업무 수정창 -->
                        	<div class="m-t-5 modifyModeTask" style="display:none;">
                        		<form:input path="issueVO.dutyBoardId" style="width:100%;margin-top:5px;margin-bottom:5px;"/>
                        		<button type="button" class="btn btn-primary" style="width: 49%;font-size: 0.9em;padding: 5px;" onclick="saveIssue('업무번호');">저장</button>
                        		<button type="button" class="btn btn-secondary" style="width: 49%;font-size: 0.9em;padding: 5px;" onclick="changeMode('업무번호');">취소</button>
                        	</div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="body">
                        	<div <c:if test="${loginUser.empId == issue.empId }">class="milestone" onclick="changeMode('마일스톤');"</c:if> >
	                        	<strong>마일스톤</strong>
	                        	<i class="icon-settings float-right"></i>
                        	</div>
                        	<div class="detailModeMilestone">
	                        	<!-- 진행률 -->
	                       		<c:if test="${!empty issue.milestoneName }">
	                         		<fmt:parseNumber var="percentage" value="${issue.closedIssueCount/(issue.openIssueCount + issue.closedIssueCount)*100 }" integerOnly="true" />
		                        	<div class="progress-container m-t-15">
		                                <div class="progress progress-xs" style="height:10px;background-color:rgb(0,0,0,0.2);">
		                                    <div class="progress-bar" role="progressbar" aria-valuenow="86" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%; height:10px;">
		                                    </div>
		                                </div>
		                            </div>
	                       		</c:if>
	                            <!-- 마일스톤 이름 -->
	                            <div style="margin-top:10px;">
	                            	<c:if test="${!empty issue.milestoneName }">
		                            	<span>${issue.milestoneName }</span>
	                            	</c:if>
	                            	<c:if test="${empty issue.milestoneName }">
		                            	<span>등록된 마일스톤이 없습니다.</span>
	                            	</c:if>
	                            </div>
                        	</div>
                        	<!-- 마일스톤 수정폼 -->
                        	<div class="modifyModeMilestone" style="display:none;margin-top:10px;">
                        		<select name="issueVO.milestoneId" style="padding:5px;" onchange="saveIssue('마일스톤');">
                        			<option style="padding:5px;" value="-1">-- 마일스톤 선택 --</option>
                        			<c:forEach items="${milestoneList }" var="milestone">
                        				<option style="padding:5px;" data-openIssueCount="${milestone.openIssueCount }" data-closedIssueCount="${milestone.closedIssueCount }" <c:if test="${issue.milestoneId eq milestone.milestoneId }">selected</c:if> value="${milestone.milestoneId }">${milestone.milestoneName }</option>
                        			</c:forEach>
                        			<option style="padding:5px;" disabled="disabled">------------------------------</option>
                        			<option style="padding:5px;" value="0">마일스톤 삭제</option>
                        		</select>
                        	</div>
                        </div>
                    </div>
                </div>
                
                
            </div>
         </form:form>
         
         
	</div>
</div>


<form name="replyRegistForm">
	<input type="hidden" name="issueBoardId" value="${issue.issueBoardId }"/>
	<input type="hidden" name="empWriterId" value="${loginUser.empId }"/>
	<input type="hidden" name="replyContent" />
	<input type="hidden" name="replyGroupCode" />
</form>

<script type="text/javascript">
window.onload=function(){
	$('.note-editable').css('height','150');
	
	// 시간 포맷 변경
	$('.issueDate').text(getTimeDefferFromCurrent(new Date('${issue.issueBoardCreateDt}')));
	$('.replyDate').each(function(){
		$(this).text(getTimeDefferFromCurrent(new Date($(this).attr('data-createDt'))));
	});
	
	// 마일스톤 설정
	milestoneManager = $('select[name="issueVO.milestoneId"] option:checked');
}

var jsIssueReplyVO = {
		replyGroupCode:0,
		milestoneId:'${issue.milestoneId}'
}

// 이전 마일스톤
var milestoneManager;

// 이슈 제목 수정버튼 클릭
function changeMode(category, replyId){
	if(category=='제목'){
		if($('.detailMode').css('display')=='block'){
			$('.detailMode').css('display','none');
			$('.modifyMode').css('display','');
		}else{
			$('.detailMode').css('display','');
			$('.modifyMode').css('display','none');
		}
	}else if(category=='내용'){
		if($('.detailModeContent').css('display')=='inline'){
			$('.detailModeContent').css('display','none');
			$('.modifyModeContent').css('display','');
		}else{
			$('.detailModeContent').css('display','');
			$('.modifyModeContent').css('display','none');
		}
	}else if(category=='업무번호'){
		if($('.detailModeTask').css('display')=='block'){
			$('.detailModeTask').css('display','none');
			$('.modifyModeTask').css('display','');
		}else{
			$('.detailModeTask').css('display','');
			$('.modifyModeTask').css('display','none');
		}
	}else if(category=='댓글'){
		if($('.detailModeReply_'+replyId).css('display')=='inline'){
			$('.detailModeReply_'+replyId).css('display','none');
			$('.modifyModeReply_'+replyId).css('display','');
			$('#replyForm_'+replyId).css('width','100%');
		}else{
			$('.detailModeReply_'+replyId).css('display','');
			$('.modifyModeReply_'+replyId).css('display','none');
			$('#replyForm_'+replyId).css('width','90%');
		}
	}else if(category=='이슈상태'){
		if($('.openIssueBadge').css('display')=='inline'){
			$('.openIssueBadge').css('display','none');
			$('.closedIssueBadge').css('display','');
		}else{
			$('.openIssueBadge').css('display','');
			$('.closedIssueBadge').css('display','none');
		}
	}else if(category=='마일스톤'){
		if($('.detailModeMilestone').css('display')=='block'){
			$('.detailModeMilestone').css('display','none');
			$('.modifyModeMilestone').css('display','');
		}else{
			$('.detailModeMilestone').css('display','');
			$('.modifyModeMilestone').css('display','none');
		}
	}
	
}

//히스토리 뷰 추가
function addHistory(issueReplyVO){
	var replyTag;
	if(issueReplyVO.replyGroupCode==1){	// 댓글
		replyTag = '<li id="li_'+issueReplyVO.replyId+'" class="online animated fadeIn" style="clear:both;border:1.5px solid rgb(0,0,0,0.2);border-radius:15px;">'
				  	+'<div class="media" style="margin:0px;border-bottom:1px solid rgb(0,0,0,0.2);padding:10px 20px;">'
				  		+'<div class="rounded-circle avatar pictureView" style="background-image:url(\'${pageContext.request.contextPath}/admin/emp/getPicture?picture='+issueReplyVO.empPicture+'\');width: 60px; height: 60px;"></div>'
				  		+'<div class="media-body" style="margin-top: 7px;">'
				  			+'<strong class="name" style="font-size:1.2em;display:inline;vertical-align: middle;">'+issueReplyVO.empName+'</strong>';
				  			if(issueReplyVO.empWriterId=='${issue.empId}'){
				  				replyTag += '<span class="badge badge-default" style="color:black;border-color: black;">작성자</span><br>';
				  			}
			replyTag +=		 	 '<span class="message replyDate" style="font-size:1.1em;">'+getTimeDefferFromCurrent(new Date(issueReplyVO.replyCreateDt))+'</span>'
				  		+'</div>'
				  	+'</div>'
				  	+'<div style="padding:20px;">'
				  		+'<div id="replyForm_'+issueReplyVO.replyId+'" style="width:90%;display:inline-block;">'
				  			+'<span id="spanIssueReplyContent_'+issueReplyVO.replyId+'" class="detailModeReply_'+issueReplyVO.replyId+'" style="font-size:1.1em;">'+issueReplyVO.replyContent+'</span>'
				  			+'<div class="modifyModeReply_'+issueReplyVO.replyId+'" style="display:none;">'
				  				+'<div class="summernote">'+issueReplyVO.replyContent+'</div>'
				  				+'<div class="m-t-10" style="float:right;">'
				  					+'<button type="button" class="btn btn-info" style="width: 60px;margin-right:3px;" onclick="modifyReply('+issueReplyVO.replyId+');">저장</button>'
				  					+'<button type="button" class="btn btn-outline-secondary" style="width: 60px;" onclick="changeMode(\'댓글\',\''+issueReplyVO.replyId+'\');" >취소</button>'
				  				+'</div>'
				  			+'</div>'
				  		+'</div>'
			        +'<div class="detailModeReply_'+issueReplyVO.replyId+'" style="display:inline;float:right;">';
			        if(issueReplyVO.empWriterId == '${loginUser.empId}'){
			        	replyTag +='<a href="javascript:void(0);" style="margin-right:3px" class="btn btn-sm btn-outline-success" title="수정" onclick="changeMode(\'댓글\',\''+issueReplyVO.replyId+'\');"><i class="icon-pencil"></i></a>'
			        			  +'<a href="javascript:void(0);" class="btn btn-sm btn-outline-danger" title="삭제" onclick="removeReply('+issueReplyVO.replyId+');"><i class="icon-trash"></i></a>';
			        }
			replyTag +=  '</div>'  
			     	+'</div>'  
			        +'</li>'
			        +'<li class="replyBridge" style="clear:both;border-left:1px solid black;height:30px;margin-left:30px;">'  
			        +'</li>';
	}else if(issueReplyVO.replyGroupCode==2){	// 공지
		if($('ul#replyHistory li').last().attr('class') == 'closedHistory'){
			replyTag = '<li class="left float-left animated fadeIn" style="margin-top:-30px;margin-bottom:0px;width:100%;">';
		}else{
			replyTag = '<li class="left float-left animated fadeIn" style="margin-bottom:0px;width:100%;">';
		}
			replyTag   +='<div class="timeline-item black" style="margin-left:30px;">'
				  		+'<span class="date">'+getTimeDefferFromCurrent(new Date(issueReplyVO.replyCreateDt))+'</span>'
				  		+'<h5 style="font-weight:bold;">'+issueReplyVO.replyContent.split("@")[0]+'</h5>'
				  		+'<p style="margin:5px 0px 0px;">'+issueReplyVO.replyContent.split("@")[1]+'</p>'
				  	+'</div>'
				  +'</li>'
				  +'<li style="clear:both;"></li>';
		if($('ul#replyHistory li').last().attr('class') == 'replyBridge'){
			$('ul#replyHistory li').last().remove();
		}
	}else if(issueReplyVO.replyGroupCode==3){	// 이슈 재진행
		replyTag = '<li class="left float-left animated fadeIn" style="border-top:2px solid #86c541;margin-bottom:0px;width:100%;">'
				  	+'<div class="timeline-item green" style="margin-left:30px;">'
				  		+'<span class="date">'+getTimeDefferFromCurrent(new Date())+'</span>'
				  		+'<h5 style="font-weight:bold;">이슈 재시작</h5>'
				 		+'<p style="margin:5px 0px 0px;">${loginUser.empName }님이 이슈를 다시 진행시켰습니다.</p>'
				  	+'</div> '
				  +'</li>'
				  +'<li style="clear:both;"></li>';
		if($('ul#replyHistory li').last().attr('class') == 'replyBridge'){
			$('ul#replyHistory li').last().remove();
		}
	}else if(issueReplyVO.replyGroupCode==4){	// 이슈 종료
		replyTag = '<li class="left float-left animated fadeIn closedHistory" style="border-bottom:2px solid #ee2558;margin-bottom:30px;width:100%;';
					if($('ul#replyHistory li').last().attr('class')!='closedHistory'){
						replyTag += 'margin-bottom:30px;';
					}
		replyTag 	+= '">'
				  	+'<div class="timeline-item danger" style="margin-left:30px;">'
				  		+'<span class="date">'+getTimeDefferFromCurrent(new Date())+'</span>'
				  		+'<h5 style="font-weight:bold;">이슈 종료</h5>'
				  		+'<p style="margin:5px 0px 0px;">${loginUser.empName }님이 이슈를 종료시켰습니다.</p>'
			  		+'</div>'
		     	  +'</li>'
		     	  +'<li class="closedHistory" style="clear:both;"></li>';
		if($('ul#replyHistory li').last().attr('class') == 'replyBridge'){
			$('ul#replyHistory li').last().remove();
		}
	}
	$('ul#replyHistory').append(replyTag);
}

// 이슈 제목/내용/상태 변경   
function saveIssue(category, issueSt){
	if(category=='업무번호'){
		if(!$.isNumeric($('input[name="issueVO.dutyBoardId"]').val()) || $('input[name="issueVO.dutyBoardId"]').val().substr(0,1) == "0"){
			alert('업무 번호는 숫자만 입력 가능합니다.');
			$('input[name="issueVO.dutyBoardId"]').focus();
			return;
		}
		if($('input[name="issueVO.dutyBoardId"]').val().length > 8){
			alert('업무번호는 8자리 이하로 입력해야 합니다.');
			$('input[name="issueVO.dutyBoardId"]').focus();
			return;
		}
	}
	if(category=='이슈상태'){
		$('input[name="issueVO.issueBoardSt"]').val(issueSt);
	}
	if(category=='마일스톤'){
		var value = $('select[name="issueVO.milestoneId"]').val();
		
		if(value == '-1' || jsIssueReplyVO.milestoneId == value){
			$('select[name="issueVO.milestoneId"]').val("-1");
			return;
		}
		
		if(value == '0'){
			if(!confirm('마일스톤을 삭제하시겠습니까?')){
				$('select[name="issueVO.milestoneId"]').val("-1");
				return;
			}
		}
		
		// 이전 마일스톤 데이터 변경
		if(milestoneManager.attr('data-openIssueCount')){	// 마일스톤이 있었으면
			var tempOpenIssueCount = milestoneManager.attr('data-openIssueCount')*1;
			var tempClosedIssueCount = milestoneManager.attr('data-closedIssueCount')*1;
			
			// 이전 마일스톤의 이슈개수 변경
			if($('input[name="issueVO.issueBoardSt"]').val() == 'Y'){	// 현재 이슈가 open이면
				milestoneManager.attr('data-openIssueCount',tempOpenIssueCount-1);
			}else{	// 현재 이슈가 closed이면
				milestoneManager.attr('data-closedIssueCount',tempClosedIssueCount-1);
			}
		}
		
		// 현재 선택한 마일스톤으로 변경
		milestoneManager = $('select[name="issueVO.milestoneId"] option:checked');
	}
	
	$('input[name="issueVO.issueBoardContent"]').val($('.note-editable').html());
	$.ajax({
		url:"<c:url value='/board/issue/modify'/>",
		type:'post',
		data:$('form[name="detailForm"]').serialize(),
		success:function(dutyBoardTitle){
			var msg = category;
			if(category=='업무번호' || category=='이슈상태'){
				msg += '가';
			}else{
				msg += '이';
			}
			alert(msg+' 수정되었습니다.');
			
			if(category=='제목'){
				$('#spanIssueBoardTitle').text($('input[name="issueVO.issueBoardTitle"]').val());
				if($('select[name="issueVO.issueOpenSt"]').val() == 'Y'){
					$('#spanIssueOpenSt').css('display','none');
				}else{
					$('#spanIssueOpenSt').css('display','inline');
				}
			}else if(category=='내용'){
				$('#spanIssueBoardContent').html($('input[name="issueVO.issueBoardContent"]').val());
			}else if(category=='업무번호'){
				if(dutyBoardTitle){	// 업무 번호가 존재하는 경우 연결
					$('#spanDutyBoardId').text('# '+$('input[name="issueVO.dutyBoardId"]').val());
					$('#spanDutyBoardId').css('display','');
					$('#spanDutyBoardId').on('click',function(){
						OpenWindow('${pageContext.request.contextPath }/board/duty/detail?dutyBoardId='+$('input[name="issueVO.dutyBoardId"]').val(), '업무 상세', 900, 700);
						window.location.reload(true);
					});
					$('#spanNoDutyBoardId').css('display','none');
					$('#spanDutyBoardTitle').text($.trim(dutyBoardTitle));
				}else{
					$('#spanDutyBoardId').css('display','none');
					$('#spanNoDutyBoardId').text('#'+$('input[name="issueVO.dutyBoardId"]').val());
					$('#spanNoDutyBoardId').css('display','');
					$('#spanDutyBoardTitle').text('관련 업무가 없습니다.');
				}
			}else if(category=='이슈상태'){
				var openIssueCount = 0;
				var closedIssueCount = 0;
				// 마일스톤이 있으면
				if(milestoneManager.attr('data-openIssueCount')){
					openIssueCount = milestoneManager.attr('data-openIssueCount')*1;
					closedIssueCount = milestoneManager.attr('data-closedIssueCount')*1;
				}
				if(issueSt == 'N'){	// 이슈 종료
					jsIssueReplyVO.replyGroupCode = 4;
					
					// 마일스톤이 있으면 이슈개수 변경
					if(milestoneManager.attr('data-openIssueCount')){
						milestoneManager.attr('data-openIssueCount',openIssueCount-1);
						milestoneManager.attr('data-closedIssueCount',closedIssueCount+1);
					}
				}else{	// 이슈 재진행
					jsIssueReplyVO.replyGroupCode = 3;
				
					// 마일스톤이 있으면 이슈개수 변경
					if(milestoneManager.attr('data-openIssueCount')){
						milestoneManager.attr('data-openIssueCount',openIssueCount+1);
						milestoneManager.attr('data-closedIssueCount',closedIssueCount-1);
					}
				}
				var percentage = Math.floor(milestoneManager.attr('data-closedIssueCount')*1/(milestoneManager.attr('data-openIssueCount')*1 + milestoneManager.attr('data-closedIssueCount')*1)*100);
				$('.progress-bar').css('width',percentage+'%');
				
				// 히스토리 등록
				registIssueReply(jsIssueReplyVO.replyGroupCode);
				
				window.opener.location.reload(true);
			}else if(category=='마일스톤'){
				jsIssueReplyVO.milestoneId = $('select[name="issueVO.milestoneId"]').val();
				jsIssueReplyVO.replyGroupCode = 2;
				
				registIssueReply(jsIssueReplyVO.replyGroupCode);
				
				// 마일스톤 뷰 수정
				$('.detailModeMilestone').children().remove();
				var milestoneView = ''; 
				if(jsIssueReplyVO.milestoneId == 0){	// 마일스톤 삭제
					milestoneView += '<div style="margin-top:10px;">'
										+'<span>등록된 마일스톤이 없습니다.</span>'
									+'</div>';
				}else{	// 마일스톤 등록
					var openCount = milestoneManager.attr('data-openIssueCount')*1;
					var closedCount = milestoneManager.attr('data-closedIssueCount')*1;
					// 옮겨진 마일스톤의 이슈개수 변경
					if($('input[name="issueVO.issueBoardSt"]').val() == 'Y'){	// 현재이슈가 open 상태이면
						milestoneManager.attr('data-openIssueCount',openCount+1);
					}else{	// 현재이슈가 closed 상태이면
						milestoneManager.attr('data-closedIssueCount',closedCount+1);
					}
					
					var percentage = Math.floor(milestoneManager.attr('data-closedIssueCount')*1/(milestoneManager.attr('data-openIssueCount')*1+milestoneManager.attr('data-closedIssueCount')*1)*100);
					milestoneView += '<div class="progress-container m-t-15">'
										+'<div class="progress progress-xs" style="height:10px;background-color:rgb(0,0,0,0.2);">'
								   			+'<div class="progress-bar" role="progressbar" aria-valuenow="86" aria-valuemin="0" aria-valuemax="100" style="width: '+percentage+'%; height:10px;"></div>'
							   			+'</div>'
								   	+'</div>'
								   	+'<div style="margin-top:10px;">'
								   		+'<span>'+$('select[name="issueVO.milestoneId"] option:checked').text()+'</span>'
								   	+'</div>';
				}
				$('.detailModeMilestone').append(milestoneView);
				
				if($('select[name="issueVO.milestoneId"]').val() == 0){
					$('select[name="issueVO.milestoneId"]').val("-1");
				}
			}
			changeMode(category);
			window.opener.location.reload(true);
		},
		error:function(){
			alert('제목 수정 실패');
		}
	});
}

// 댓글 및 히스토리 등록
function registIssueReply(replyGroupCode){
	var replyRegistView;
	
	if(replyGroupCode==1){	// 댓글
		replyRegistView = $('.note-editable').last();
		if($.trim(replyRegistView.text())==""){
			alert('내용을 입력하세요.');
			replyRegistView.focus();
			return;
		}
		
		$('input[name="replyContent"]').val(replyRegistView.html());
	}else if(replyGroupCode==2){	// 공지
		
		var value = $('select[name="issueVO.milestoneId"]').val();
		var content = '마일스톤 변경@';
		if(value == 0){	// 삭제
			content += '<p style="margin-bottom:0px;">${loginUser.empName }님이 현재 이슈를 <strong><a href="javascript:void(0);">${issue.milestoneName}</a></strong> 마일스톤에서 삭제하였습니다.</p>';
		}else{ // 등록
			content += '<p style="margin-bottom:0px;">${loginUser.empName }님이 현재 이슈를 <strong><a href="javascript:void(0);">'+$('select[name="issueVO.milestoneId"] option:checked').text()+'</a></strong> 마일스톤으로 변경하였습니다.</p>';
		}
		
		$('input[name="replyContent"]').val(content);
	}else if(replyGroupCode==3){	// 이슈 재진행
		$('input[name="replyContent"]').val('이슈 재진행');
	}else if(replyGroupCode==4){	// 이슈 종료
		$('input[name="replyContent"]').val('이슈 종료');
	}
	
	$('input[name="replyGroupCode"]').val(replyGroupCode);
	
	$.ajax({
		url:"<c:url value='/board/issue/reply/regist'/>",
		type:'post',
		data:$('form[name="replyRegistForm"]').serialize(),
		success:function(issueReplyVO){
			// 히스토리 뷰 추가
			addHistory(issueReplyVO);
			
			if(replyGroupCode==1){
				// 댓글 수 증가
				$('#issueReplyCount').text($('#issueReplyCount').text()*1+1);
				
				replyRegistView.text("");
				
				$('.summernote').summernote({
					tabsize: 2,
			        height: 150,
			        toolbar: [
			          ['style', ['style']],
			          ['font', ['bold', 'underline', 'clear']],
			          ['color', ['color']],
			          ['para', ['ul', 'ol', 'paragraph']],
			          ['table', ['table']],
			          ['view', ['fullscreen', 'codeview', 'help']]
			        ]
				});
			}
			
		},
		error:function(){
			alert('댓글 등록이 실패했습니다.');
		}
	});
}

// 댓글 수정
function modifyReply(replyId){
	var textarea = $('.modifyModeReply_'+replyId+' .note-editable');
	if($.trim(textarea.text()) == ""){
		alert('내용을 입력하세요.');
		textarea.focus();
		return;
	}
	
	$.ajax({
		url:'<c:url value="/board/issue/reply/modify"/>',
		type:'post',
		data:{'replyId':replyId,'replyContent':textarea.html()},
		success:function(){
			alert('댓글이 수정되었습니다.');
			$('#spanIssueReplyContent_'+replyId).html(textarea.html());
			
			changeMode('댓글',replyId);
		},
		error:function(){
			alert('댓글 수정 실패');
		}
	});
}

// 댓글 삭제
function removeReply(replyId){
	var chk = confirm('댓글을 삭제하시겠습니까?');
	if(!chk) return;
	
	$.ajax({
		url:'<c:url value="/board/issue/reply/remove"/>',
		type:'post',
		data:{'replyId':replyId},
		success:function(){
			alert('댓글이 삭제되었습니다.');
			
			// 댓글 삭제
			if($('#li_'+replyId).next().attr('class') == 'replyBridge'){
				$('#li_'+replyId).next().remove();
			}
			if($('#li_'+replyId).prev().attr('class') == 'replyBridge'){
				$('#li_'+replyId).prev().remove();
			}
			$('#li_'+replyId).remove();
			
			// 댓글 수 감소
			$('#issueReplyCount').text($('#issueReplyCount').text()*1-1);
		},
		error:function(){
			alert('댓글 삭제 실패');
		}
	});
}

// 이슈 삭제
function removeIssue(){
	var check = confirm('이슈를 삭제하시겠습니까?');
	if(!check) return;
	
	$.ajax({
		url:"<c:url value='/board/issue/remove'/>",
		type:'post',
		data:$('form[name="detailForm"]').serialize(),
		success:function(){
			alert('이슈가 삭제되었습니다.');
			window.opener.location.reload(true);
			window.close();
		},
		error:function(){
			alert('삭제 실패');
		}
	});
}
</script>
<script> //시연
function presentationFill_1(){
	$('#replySummernote').summernote('code', '<p>해결되었습니다. 감사합니다.</p>');
}	

</script>