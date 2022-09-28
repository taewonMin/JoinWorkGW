<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
    
<jsp:include page="../issueSidebar.jsp" />

<style>
.issueManage{
	overflow-y: auto;
	padding:0 20px;
}
.issueCount {
	display: inline-block;
    border-radius: 50%;
    background-color: gray;
    width: 28px;
    height: 28px;
    text-align: center;
    line-height: 1.8em;
    vertical-align: middle;
    color: white;
    font-size: 1.2em;
}
h5.number {
    display: inline-block;
    margin-bottom: 0px;
    vertical-align: middle;
    margin-left:5px;
}
</style>

<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
			<div class="row clearfix">
                <div class="col-12" style="margin-top: 2%; font-family: 'S-CoreDream-6Bold">
                    <h2><i class="fa fa-clipboard"></i>&nbsp;프로젝트 관리</h2>
                    <hr>
                </div>
		 	</div>

            <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
                <div class="col-lg-9 col-md-12" style="padding-right:0px;">
                    <div class="card">
                        <div class="body project_report">
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';">이슈</button>
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';">마일스톤</button>
                        	<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/project';">프로젝트</button>
                        	<button type="button" class="btn " id="hiddenFillBtn" onclick="presentationFill_1();" style="position:absolute;right:10em;top:1.5em;color:#ffffff; z-index: 100; border: 0px;">시연용버튼1</button>
                        	<button type="button" class="btn btn-primary float-right m-r-10" style="width:100px;" onclick="saveProject(this);"><i class="fa fa-spinner fa-spin" style="display:none;"></i><span class='m-l-5'>저장</span></button>
	                    </div>
	                    
	                   	<div style="padding:10px 30px;">
		                    <span style="font-size:1.1em;">프로젝트 진행률</span>
	                   		<div class="progress-container m-t-15" style="">
	                           <div class="progress progress-xs" style="height:20px;background-color:rgb(0,0,0,0.2);">
	                               <div class="progress-bar" role="progressbar" aria-valuenow="86" aria-valuemin="0" aria-valuemax="100" style="width: 0%; height:20px;">
	                               </div>
	                               <span id="percentage" style="position: absolute;color: white;left: 50%;font-size: 1.1em;line-height: 1.5em;">0%</span>
	                           </div>
	                       	</div>
	                   	</div>
	                    
	                    <div class="row clearfix" style="margin:10px;">
	                    	<div class="top_counter col-lg-4 col-md-6">
	                    		<div class="card" style="height:80vh;background-color:#eee;">
			                        <div class="body">
			                        	<span class="issueCount">${empty todoList ? 0 : todoList.size() }</span>
		                                <h5 class="number">해야할 일</h5>
		                                <span class="fa fa-plus float-right fa-2x" style="cursor:pointer;" data-category="todo" onclick="showNewIssueForm(this);"></span>
		                                <div id="newIssueForm_todo" style="display:none;">
		                                	<div class="form-group" style="margin:20px 0 0;">
		                                		<input type="text" id="input_todo" class="form-control" placeholder="제목을 입력하세요.">
                                                <textarea rows="4" id="textarea_todo" style="max-height:10vh;margin-top:5px;" class="form-control no-resize" placeholder="이슈 내용을 입력하세요."></textarea>
                                                <div style="margin-top:10px;">
	                                                <button type="button" style="width:49%;" class="btn btn-primary" data-category="todo" onclick="createIssue(this);">생성</button>
	                                                <button type="button" style="width:49%;float:right;" class="btn btn-secondary" data-category="todo" onclick="cancelBtn(this);">취소</button>
                                                </div>
                                            </div>
		                                </div>
			                        </div>    
			                        <div class="issueManage" id="div_todo" style="height:70vh;">
			                            <div class="dd dd4" id="todo">
			                            	<c:if test="${!empty todoList }">
				                                <ol class="dd-list">
				                                	<c:forEach items="${todoList }" var="issue">
					                                    <li class="dd-item" id="${issue.issueBoardId }" style="cursor:pointer;"> 
					                                        <div class="dd-handle card" style="height:70vh;padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
				                                            	<div style="margin-bottom: -15px;">
					                                                <h6 style="display:inline-block;font-weight: bold;max-width: 85%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
					                                                	<c:if test="${issue.issueBoardSt eq 'Y' }">
						                                                	<i class="icon-info" style="color:green;"></i>
					                                                	</c:if>
					                                                	<c:if test="${issue.issueBoardSt eq 'N' }">
						                                                	<i class="icon-check" style="color:red;"></i>
					                                                	</c:if>
					                                                	<span class="issueTitle" style="font-size:1.1em;">${issue.issueBoardTitle }</span>
					                                                </h6>
				                                                	<c:if test="${!empty issue.dutyBoardTitle }">
						                                                <span class="btn btn-secondary" style="height:auto;padding: 0px 3px;font-size:0.8em;margin-left:5px;margin-top: -10px;">#${issue.dutyBoardId }</span>
				                                                	</c:if>
				                                            	</div>
				                                                <span>#${issue.issueBoardId }</span>
				                                                <span style="margin-left:5px;">${issue.issueBoardUpdateDt.split(" ")[0] }</span>
					                                        </div>
					                                        <i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;top: 15px;font-size: 1.5em;right: 20px;"></i>
					                                        <div class="user-account" style="position: absolute;top:0px;right:150px;">
						                                        <div class="dropdown">
												                    <ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px); font-family: InfinitySans-RegularA1">
												                    	<c:if test="${issue.issueBoardSt eq 'Y' }">
													                        <li data-id="${issue.issueBoardId }" data-st="N" data-title="${issue.issueBoardTitle }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="icon-pencil"></i><span>이슈 닫기</span></a></li>
												                    	</c:if>
												                    	<c:if test="${issue.issueBoardSt eq 'N' }">
													                        <li data-id="${issue.issueBoardId }" data-st="Y" data-title="${issue.issueBoardTitle }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="icon-pencil"></i><span>이슈 열기</span></a></li>
												                    	</c:if>
												                        <li><a href='javascript:void(0);' data-id="${issue.issueBoardId }" data-area="todo" onclick="removeIssue(this);"><i class="fa fa-trash-o" style="font-size:1.2em;"></i>이슈 삭제</a></li>
												                    </ul>
												                </div>
					                                        </div>
					                                    </li>
				                                	</c:forEach>
				                                	
				                                </ol>
				                    		</c:if>
				                    		<c:if test="${empty todoList }">
				                    		</c:if>
			                            </div>
			                        </div>
	                    		</div>
		                    </div>
	                    	<div class="top_counter col-lg-4 col-md-6">
	                    		<div class="card" style="height:80vh;background-color:#eee;">
			                        <div class="body">
			                            <span class="issueCount">${empty inprogressList ? 0 : inprogressList.size() }</span>
		                                <h5 class="number" style="display:inline-block;">진행중</h5>
		                                <span class="fa fa-plus float-right fa-2x" style="cursor:pointer;" data-category="inprogress" onclick="showNewIssueForm(this);"></span>
		                                <div id="newIssueForm_inprogress" style="display:none;">
		                                	<div class="form-group" style="margin:20px 0 0;">
		                                		<input type="text" id="input_inprogress" class="form-control" placeholder="제목을 입력하세요.">
                                                <textarea rows="4" id="textarea_inprogress" style="max-height:10vh;margin-top:5px;"  class="form-control no-resize" placeholder="이슈 내용을 입력하세요."></textarea>
                                                <div style="margin-top:10px;">
	                                                <button type="button" style="width:49%;" class="btn btn-primary" data-category="inprogress" onclick="createIssue(this);">생성</button>
	                                                <button type="button" style="width:49%;float:right;" class="btn btn-secondary" data-category="inprogress" onclick="cancelBtn(this);">취소</button>
                                                </div>
                                            </div>
		                                </div>
			                        </div>
			                        <div class="issueManage" id="div_inprogress" style="height:70vh;">
			                            <div class="dd dd4" id="inprogress">
			                            	<c:if test="${!empty inprogressList }">
				                                <ol class="dd-list">
				                                
				                                	<c:forEach items="${inprogressList }" var="issue">
					                                    <li class="dd-item" id="${issue.issueBoardId }" style="cursor:pointer;">
					                                        <div class="dd-handle card" style="height:70vh;padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
				                                            	<div style="margin-bottom: -15px;">
					                                                <h6 style="display:inline-block;font-weight: bold;max-width: 85%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
					                                                	<c:if test="${issue.issueBoardSt eq 'Y' }">
						                                                	<i class="icon-info" style="color:green;"></i>
					                                                	</c:if>
					                                                	<c:if test="${issue.issueBoardSt eq 'N' }">
						                                                	<i class="icon-check" style="color:red;"></i>
					                                                	</c:if>
					                                                	<span class="issueTitle" style="font-size:1.1em;">${issue.issueBoardTitle }</span>
					                                                </h6>
				                                                	<c:if test="${!empty issue.dutyBoardTitle }">
						                                                <span class="btn btn-secondary" style="height:auto;padding: 0px 3px;font-size:0.8em;margin-left:5px;margin-top: -10px;">#${issue.dutyBoardId }</span>
				                                                	</c:if>
				                                            	</div>
				                                                <span>#${issue.issueBoardId }</span>
				                                                <span style="margin-left:5px;">${issue.issueBoardUpdateDt.split(" ")[0] }</span>
					                                        </div>
					                                        <i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;top: 15px;font-size: 1.5em;right: 20px;"></i>
					                                        <div class="user-account" style="position: absolute;top:0px;right:150px;">
						                                        <div class="dropdown">
												                    <ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px); font-family: InfinitySans-RegularA1">
												                    	<c:if test="${issue.issueBoardSt eq 'Y' }">
													                        <li data-id="${issue.issueBoardId }" data-st="N" data-title="${issue.issueBoardTitle }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="icon-pencil"></i><span>이슈 닫기</span></a></li>
												                    	</c:if>
												                    	<c:if test="${issue.issueBoardSt eq 'N' }">
													                        <li data-id="${issue.issueBoardId }" data-st="Y" data-title="${issue.issueBoardTitle }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="icon-pencil"></i><span>이슈 열기</span></a></li>
												                    	</c:if>
												                        <li><a href='javascript:void(0);' data-id="${issue.issueBoardId }" data-area="inprogress" onclick="removeIssue(this);"><i class="fa fa-trash-o" style="font-size:1.2em;"></i>이슈 삭제</a></li>
												                    </ul>
												                </div>
					                                        </div>
					                                    </li>
				                                	</c:forEach>
				                                	
				                                </ol>
				                    		</c:if>
				                    		<c:if test="${empty inprogressList }">
				                    		</c:if>
			                            </div>
			                        </div>                        
	                    		</div>
		                    </div>
	                    	<div class="top_counter col-lg-4 col-md-6">
	                    		<div class="card" style="height:80vh;background-color:#eee;">
			                        <div class="body">
			                        	<span class="issueCount">${empty doneList ? 0 : doneList.size() }</span>
		                                <h5 class="number">완료</h5>
		                                <span class="fa fa-plus float-right fa-2x" style="cursor:pointer;" data-category="done" onclick="showNewIssueForm(this);"></span>
		                                <div id="newIssueForm_done" style="display:none;">
		                                	<div class="form-group" style="margin:20px 0 0;">
		                                		<input type="text" id="input_done" class="form-control" placeholder="제목을 입력하세요.">
                                                <textarea rows="4" id="textarea_done" style="max-height:10vh;margin-top:5px;" class="form-control no-resize" placeholder="이슈 내용을 입력하세요."></textarea>
                                                <div style="margin-top:10px;">
	                                                <button type="button" style="width:49%;" class="btn btn-primary" data-category="done" onclick="createIssue(this);">생성</button>
	                                                <button type="button" style="width:49%;float:right;" class="btn btn-secondary" data-category="done" onclick="cancelBtn(this);">취소</button>
                                                </div>
                                            </div>
		                                </div>
			                        </div>  
			                        <div class="issueManage" id="div_done" style="height:70vh;">
			                            <div class="dd dd4" id="done">
			                            	<c:if test="${!empty doneList }">
				                                <ol class="dd-list">
				                                
				                                	<c:forEach items="${doneList }" var="issue">
					                                    <li class="dd-item" id="${issue.issueBoardId }" style="cursor:pointer;">
					                                        <div class="dd-handle card" style="height:70vh;padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
				                                            	<div style="margin-bottom: -15px;">
					                                                <h6 style="display:inline-block;font-weight: bold;max-width: 85%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
					                                                	<c:if test="${issue.issueBoardSt eq 'Y' }">
						                                                	<i class="icon-info" style="color:green;"></i>
					                                                	</c:if>
					                                                	<c:if test="${issue.issueBoardSt eq 'N' }">
						                                                	<i class="icon-check" style="color:red;"></i>
					                                                	</c:if>
					                                                	<span class="issueTitle" style="font-size:1.1em;">${issue.issueBoardTitle }</span>
					                                                </h6>
				                                                	<c:if test="${!empty issue.dutyBoardTitle }">
						                                                <span class="btn btn-secondary" style="height:auto;padding: 0px 3px;font-size:0.8em;margin-left:5px;margin-top: -10px;">#${issue.dutyBoardId }</span>
				                                                	</c:if>
				                                            	</div>
				                                                <span>#${issue.issueBoardId }</span>
				                                                <span style="margin-left:5px;">${issue.issueBoardUpdateDt.split(" ")[0] }</span>
					                                        </div>
					                                        <i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;top: 15px;font-size: 1.5em;right: 20px;"></i>
					                                        <div class="user-account" style="position: absolute;top:0px;right:150px;">
						                                        <div class="dropdown">
												                    <ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px); font-family: InfinitySans-RegularA1">
												                    	<c:if test="${issue.issueBoardSt eq 'Y' }">
													                        <li data-id="${issue.issueBoardId }" data-st="N" data-title="${issue.issueBoardTitle }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="icon-pencil"></i><span>이슈 닫기</span></a></li>
												                    	</c:if>
												                    	<c:if test="${issue.issueBoardSt eq 'N' }">
													                        <li data-id="${issue.issueBoardId }" data-st="Y" data-title="${issue.issueBoardTitle }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="icon-pencil"></i><span>이슈 열기</span></a></li>
												                    	</c:if>
												                        <li><a href='javascript:void(0);' data-id="${issue.issueBoardId }" data-area="done" onclick="removeIssue(this);"><i class="fa fa-trash-o" style="font-size:1.2em;"></i>이슈 삭제</a></li>
												                    </ul>
												                </div>
					                                        </div>
					                                    </li>
				                                	</c:forEach>
				                                	
				                                </ol>
				                    		</c:if>
				                    		<c:if test="${empty doneList }">
				                    		</c:if>
			                            </div>
			                        </div>                      
	                    		</div>
		                    </div>
                        </div>
	                    
	                </div>
	            </div>
	            <div class="col-sm-3">
	            	<div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
		                <div class="col-lg-12 col-md-12">
		                    <div class="card" style="padding:30px 0 0 25px;">
		                    	<h3 style="margin-bottom:20px;display: inline-block">나의 이슈 목록</h3>
		                    	<span class="issueCount" style="margin-top: -13px;margin-left: 10px;">${empty noList ? 0 : noList.size() }</span>
		                    	
		                    	<div class="issueManage" id="div_free" style="padding:0px;">
			                    	<div class="dd dd4" id="free" style="height:80vh;overflow-y:auto;padding:0 20px 20px 0;">
			                    		<c:if test="${!empty noList }">
			                                <ol class="dd-list">
			                                
			                                	<c:forEach items="${noList }" var="issue">
				                                    <li class="dd-item" id="${issue.issueBoardId }" style="cursor:pointer;">
				                                        <div class="dd-handle card" style="height:70vh;padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);">
			                                            	<div style="margin-bottom: -15px;">
				                                                <h6 style="display:inline-block;font-weight: bold;max-width: 85%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
				                                                	<c:if test="${issue.issueBoardSt eq 'Y' }">
					                                                	<i class="icon-info" style="color:green;"></i>
				                                                	</c:if>
				                                                	<c:if test="${issue.issueBoardSt eq 'N' }">
					                                                	<i class="icon-check" style="color:red;"></i>
				                                                	</c:if>
				                                                	<span class="issueTitle" style="font-size:1.1em;">${issue.issueBoardTitle }</span>
				                                                </h6>
			                                                	<c:if test="${!empty issue.dutyBoardTitle }">
					                                                <span class="btn btn-secondary" style="height:auto;padding: 0px 3px;font-size:0.8em;margin-left:5px;margin-top: -10px;">#${issue.dutyBoardId }</span>
			                                                	</c:if>
			                                            	</div>
			                                                <span>#${issue.issueBoardId }</span>
			                                                <span style="margin-left:5px;">${issue.issueBoardUpdateDt.split(" ")[0] }</span>
				                                        </div>
				                                        <i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;top: 15px;font-size: 1.5em;right: 20px;"></i>
				                                        <div class="user-account" style="position: absolute;top:0px;right:150px;">
					                                        <div class="dropdown">
											                    <ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px); font-family: InfinitySans-RegularA1">
											                    	<c:if test="${issue.issueBoardSt eq 'Y' }">
												                        <li data-id="${issue.issueBoardId }" data-st="N" data-title="${issue.issueBoardTitle }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="icon-pencil"></i><span>이슈 닫기</span></a></li>
											                    	</c:if>
											                    	<c:if test="${issue.issueBoardSt eq 'N' }">
												                        <li data-id="${issue.issueBoardId }" data-st="Y" data-title="${issue.issueBoardTitle }" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="icon-pencil"></i><span>이슈 열기</span></a></li>
											                    	</c:if>
											                        <li><a href='javascript:void(0);' data-id="${issue.issueBoardId }" data-area="free" onclick="removeIssue(this);"><i class="fa fa-trash-o" style="font-size:1.2em;"></i>이슈 삭제</a></li>
											                    </ul>
											                </div>
				                                        </div>
				                                    </li>
			                                	</c:forEach>
			                                	
			                                </ol>
			                    		</c:if>
			                    		<c:if test="${empty noList }">
			                    		</c:if>
		                            </div>
		                    	</div>
		                    	
		                    </div>
	                    </div>
                    </div>
	            </div>
            </div>
        </div>
</div>

<form name="registIssueForm">
	<input type="hidden" name="issueBoardTitle">
	<input type="hidden" name="issueBoardContent">
	<input type="hidden" name="issueBoardUpdaterId" value="${loginUser.empId }">
	<input type="hidden" name="empId" value="${loginUser.empId }">
	<input type="hidden" name="issueOpenSt" value="Y">
	<input type="hidden" name="issueProjectSt">
</form>

<form name="modifyIssueForm">
	<input type="hidden" name="issueVO.issueBoardId">
	<input type="hidden" name="issueVO.issueBoardSt">
	<input type="hidden" name="issueVO.issueBoardTitle">
</form>

<script>
window.onload=function(){
	changePercentage();
	
	// 칸반보드 드래그 이벤트
	$('.issueManage').bind('DOMSubtreeModified', function(){
		if($(this).attr('id') == 'div_free'){
			$(this).prev('span').text($(this).find('li.dd-item').length);
		}else{
			$(this).prev('div').find('span').eq(0).text($(this).find('li.dd-item').length);
		}
		changePercentage();
	});
}

// 프로젝트 진행도 체크
function changePercentage(){
	var sum = 0;
	$('.issueCount').each(function(index){
		if(index < 3){
			sum += $(this).text()*1;
		}
	});
	
	var percentage = sum == 0 ? 0 : Math.floor($('.issueCount').eq(2).text()*1 / sum * 100);
	$('.progress-bar').css('width',percentage+"%");
	$('#percentage').text(percentage+'%');
}

// 현재 상태 저장
function saveProject(obj){
	
	$(obj).children('i').css('display','');
	$(obj).children('span').text('저장중..');
	
	var projectList = new Array();
	$('#todo').find('li').each(function(){
		var issueVO = {
			issueBoardId:$(this).attr("id"),
			issueProjectSt:'todo'
		};
		projectList.push(issueVO);
	});
	$('#inprogress').find('li').each(function(){
		var issueVO = {
			issueBoardId:$(this).attr("id"),
			issueProjectSt:'inprogress'
		};
		projectList.push(issueVO);
	});
	$('#done').find('li').each(function(){
		var issueVO = {
			issueBoardId:$(this).attr("id"),
			issueProjectSt:'done'
		};
		projectList.push(issueVO);
	});
	$('#free').find('li').each(function(){
		var issueVO = {
			issueBoardId:$(this).attr("id"),
			issueProjectSt:''
		};
		projectList.push(issueVO);
	});
	
	$.ajax({
		url:'<c:url value="/board/project/modify"/>',
		type:'post',
		data:JSON.stringify({projectList:projectList}),
		contentType:'application/json;charset=utf-8',
		success:function(){
			alert('저장되었습니다.');
			$(obj).children('i').css('display','none');
			$(obj).children('span').text('저장');
		},
		error:function(){
			alert('실패');
		}
		
	});
	
}

// 새 이슈 등록폼 보이기
function showNewIssueForm(obj){
	var category = $(obj).attr('data-category');
	
	if($(obj).hasClass('fa-plus')){	// 열기
		$(obj).removeClass('fa-plus');
		$(obj).addClass('fa-minus');
		
		console.log($('#'+category).children(':first'));
		if($('#'+category).children(':first').attr('class') == 'dd-empty'){	// 비어있으면
			$('#'+category).children(':first').css('min-height','50vh');
		}
		
		$('#newIssueForm_'+category).css('display','');
		$('#div_'+category).css('max-height','50vh');
	}else{	// 닫기
		$(obj).removeClass('fa-minus');
		$(obj).addClass('fa-plus');
		
		if($('#'+category).children(':first').attr('class') == 'dd-empty'){	// 비어있으면
			$('#'+category).children(':first').css('min-height','70vh');
		}
		
		$('#newIssueForm_'+category).css('display','none');
		$('#div_'+category).css('max-height','70vh');
	}
}

// 이슈 등록
function createIssue(obj){
	var category = $(obj).attr('data-category');
	var target = $('#'+category+' ol');
	
	var title = $('#input_'+category).val();
	var content = $('#textarea_'+category).val();
	
	if($.trim(title) == ''){
		alert('제목을 입력하세요.');
		$('#input_'+category).focus();
		return;
	}
	if($.trim(content) == ''){
		alert('내용을 입력하세요.');
		$('#textarea_'+category).focus();
		return;
	}
	
	$('input[name="issueBoardTitle"]').val(title);
	$('input[name="issueBoardContent"]').val(content);
	$('input[name="issueProjectSt"]').val(category);
	
	$.ajax({
		url:'<c:url value="/board/issue/regist"/>',
		type:'post',
		data:$('form[name="registIssueForm"]').serialize(),
		success:function(issueBoardId){
			var liTag =  '<li class="dd-item" id="'+issueBoardId+'" style="cursor:pointer;">'
							+'<div class="dd-handle card" style="height:70vh;padding:10px 20px;height:auto;color:black;border:1px solid rgb(0,0,0,0.2);background-color:#faebd7;">'
								+'<div style="margin-bottom: -10px;">'
									+'<h6 style="display:inline-block;font-weight: bold;max-width: 85%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">'
										+'<i class="icon-star" style="color:crimson;"></i>'
										+'<span class="issueTitle" style="margin-left:5px;font-size:1.1em;">'+title+'</span>'
									+'</h6>'
								+'</div>'
								+'<span style="margin-left:5px;">#'+issueBoardId+' 새로운 이슈</span>'
							+'</div>'
							+'<i class="fa fa-ellipsis-h" data-toggle="dropdown" aria-expanded="false" style="cursor: pointer;position: absolute;z-index: 10;top: 15px;font-size: 1.5em;right: 20px;"></i>'
							+'<div class="user-account" style="position: absolute;top:0px;right:150px;">'
								+'<div class="dropdown">'
									+'<ul class="dropdown-menu dropdown-menu-right account animated flipInY menuProfile" x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: -100px; padding:10px;transform: translate3d(89px, 42px, 0px); font-family: InfinitySans-RegularA1">'
										+'<li data-id="'+issueBoardId+'" data-st="N" data-title="'+title+'" onclick="modifyIssue(this);"><a href="javascript:void(0);"><i class="icon-pencil"></i><span>이슈 닫기</span></a></li>'
										+'<li><a href="javascript:void(0);" data-id="'+issueBoardId+'" data-area="todo" onclick="removeIssue(this);"><i class="fa fa-trash-o" style="font-size:1.2em;"></i>이슈삭제</a></li>'
									+'</ul>'
								+'</div>'
							+'</div>'
						+'</li>';
			if(target.length!=0){
				target.prepend(liTag);
			}else{
				$('#'+category+' .dd-empty').remove();
				$('#'+category).append($('<ol class="dd-list"></ol>'));
				$('#'+category+' ol').append(liTag);
			}
			
			$('#input_'+category).val("");
			$('#textarea_'+category).val("");
		}
	});
	
}

// 이슈등록 취소
function cancelBtn(obj){
	showNewIssueForm($('span[data-category="'+$(obj).attr('data-category')+'"]'));
}

// 이슈 상태 수정
function modifyIssue(obj){
	var issueBoardId = $(obj).attr('data-id');
	var issueBoardSt = $(obj).attr('data-st');
	var issueBoardTitle = $(obj).attr('data-title');
	
	$('input[name="issueVO.issueBoardId"]').val(issueBoardId);
	$('input[name="issueVO.issueBoardSt"]').val(issueBoardSt);
	$('input[name="issueVO.issueBoardTitle"]').val(issueBoardTitle);
	
	$.ajax({
		url:'<c:url value="/board/issue/modify"/>',
		type:'post',
		data:$('form[name="modifyIssueForm"]').serialize(),
		success:function(){
			$('li#'+issueBoardId+' i').eq(0).removeAttr('class');
			if(issueBoardSt == 'Y'){
				$('li#'+issueBoardId+' i').eq(0).addClass('icon-info');
				$('li#'+issueBoardId+' i').eq(0).css('color','green');
				$(obj).attr('data-st','N');
				$(obj).find('span').text('이슈 닫기');
			}else{
				$('li#'+issueBoardId+' i').eq(0).addClass('icon-check');
				$('li#'+issueBoardId+' i').eq(0).css('color','red');
				$(obj).attr('data-st','Y');
				$(obj).find('span').text('이슈 열기');
			}
		}
	})
}

// 이슈 삭제
function removeIssue(obj){
	
	var area = $(obj).attr('data-area');
	var issueBoardId = $(obj).attr('data-id');
	
	$.ajax({
		url:'<c:url value="/board/issue/remove"/>',
		type:'post',
		data:{issueBoardId:issueBoardId},
		success:function(){
			$('li#'+issueBoardId).remove();
			
			if($('div#'+area).find('li.dd-item').length == 0){
				$('div#'+area+' ol').remove();
				$('div#'+area).append('<div class="dd-empty"></div>');
			}
		}
	});
}
</script>
<script> //시연
function presentationFill_1(){
	$('#input_inprogress').val('새 이슈');
	$('#textarea_inprogress').val('새 이슈의 내용');
}	

</script>
