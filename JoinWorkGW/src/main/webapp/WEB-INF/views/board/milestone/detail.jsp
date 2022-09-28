<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">
    
<jsp:include page="../issueSidebar.jsp" />

<style>
.columnList {
	position:absolute;
}
.columnList:hover{
	background-color: white !important;
    border-color: white white #dee2e6 !important;
}
.issueTitle:hover{
	color:#2980b9;
}
tr:hover{
	background-color: white;
}
</style>

<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
			<div class="row clearfix">
                <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
                    <h2><i class="fa fa-tasks"></i>&nbsp;마일스톤</h2>
                    <hr>
                </div>
		 	</div>

            <div class="row clearfix">
                <div class="col-lg-12 col-md-12" style="font-family: S-CoreDream-4Regular">
                    <div class="card">
                        <div class="body project_report">
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';" style="font-family: S-CoreDream-6Bold">이슈</button>
                        	<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';" style="font-family: S-CoreDream-6Bold">마일스톤</button>
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/project';" style="font-family: S-CoreDream-6Bold">프로젝트</button>
                        	
                        	<button type="button" class="btn btn-secondary float-right" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';" style="font-family: S-CoreDream-6Bold">목록</button>
                        	<button type="button" class="btn btn-primary float-right m-r-5" onclick="OpenWindow('${pageContext.request.contextPath }/board/registForm?category=업무이슈&milestoneId=${milestone.milestoneId }', '마일스톤 생성', 1000, 700);" style="font-family: S-CoreDream-6Bold">이슈 등록</button>
                        	<button type="button" class="btn btn-info float-right m-r-5" onclick="OpenWindow('${pageContext.request.contextPath }/board/milestone/modifyForm?milestoneId=${milestone.milestoneId }', '마일스톤 수정', 1000, 700);" style="font-family: S-CoreDream-6Bold">수정</button>
                        	<hr>
                        	
                        	<!-- 마일스톤 제목 -->
                           	<div style="margin-top:20px;">
                                <h4 style="width:90%;">
                                	<span style="margin-bottom:5px;font-weight: bold;vertical-align: middle;margin-left:5px;font-size:1.1em;">${milestone.milestoneName }</span>
                                </h4>
                           	</div>
                           	
                           	<!-- 진행률 -->
                      		<c:if test="${milestone.openIssueCount + milestone.closedIssueCount eq 0 }">
                            	<c:set var="percentage" value="0"></c:set>
                            </c:if>
                            <c:if test="${milestone.openIssueCount + milestone.closedIssueCount ne 0 }">
                            	<fmt:parseNumber var="percentage" value="${milestone.closedIssueCount/(milestone.openIssueCount + milestone.closedIssueCount)*100 }" integerOnly="true" />
                            </c:if>
                            <div class="progress progress-xs" style="height:10px;margin:15px 5px 10px;width:30%;background-color:rgb(0,0,0,0.2);">
                                <div class="progress-bar" role="progressbar" aria-valuenow="${percentage }" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage }%; height:10px;"></div>
                            </div>
                            <!-- 텍스트 -->
                           	<div style="font-size: 1.1em;">
                                <span style="margin-left:5px;">마감일
	                                <c:if test="${!empty milestone.milestoneEndDt }">
	                                 : <span style="font-size:1.1em;" class="deadline">${milestone.milestoneEndDt }</span>
	                                </c:if> 
	                                <c:if test="${empty milestone.milestoneEndDt }">
	                                	없음
	                                </c:if> 
                                </span>
                                <span style="margin-left:20px;"><strong style="font-size:1.1em;">${percentage }%</strong> 진행됨</span>
                           	</div>
                        	
                        	<!-- 이슈 리스트 -->
                        	<form:form commandName="milestoneVO" name="listForm">
                        		<form:hidden path="isOpen" id="isOpenForTab" />
	                            <div class="table-responsive" style="margin-top:20px;">
		                        	<ul class="nav nav-tabs">
		                        		<c:choose>
		                        			<c:when test="${milestone.isOpen eq 'open' }">
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="icon-info"></i> <span style="margin-left:5px;">${milestone.openIssueCount }</span> Open</a></li>
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${milestone.closedIssueCount}</span> Closed</a></li>
		                        			</c:when>
		                        			<c:otherwise>
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="icon-info"></i> <span style="margin-left:5px;">${milestone.openIssueCount }</span> Open</a></li>
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${milestone.closedIssueCount}</span> Closed</a></li>
		                        			</c:otherwise>
		                        		</c:choose>
						            </ul>
						            
						            <div class="tab-content p-l-0 p-r-0 p-t-0">
						            	<!-- 마일스톤 뷰-->
						                <div class="tab-pane animated fadeIn active">
			                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
			                                    <tbody style="border:hidden;">
			                                    	<c:if test="${!empty milestone.issueList}">
				                                        <c:forEach items="${milestone.issueList }" var="issue">
				                                        	<tr role="row">
					                                            <td class="project-title" style="padding:15px 30px;">
					                                            	<div style="margin-bottom:5px;">
						                                                <h6 style="display:inline-block;font-weight: bold;max-width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
						                                                	<c:if test="${milestoneVO.isOpen eq 'open' }">
							                                                	<i class="icon-info" style="color:green;"></i>
						                                                	</c:if>
						                                                	<c:if test="${milestoneVO.isOpen eq 'closed' }">
							                                                	<i class="icon-check" style="color:red;"></i>
						                                                	</c:if>
						                                                	<span class="issueTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId }', 'JoinWorkGW', 1200, 700);">${issue.issueBoardTitle }</span>
						                                                </h6>
						                                                <c:if test="${!empty issue.dutyBoardTitle }">
						                                                	<a href="javascript:OpenWindow('${pageContext.request.contextPath }/board/duty/detail?dutyBoardId=${issue.dutyBoardId }', '업무 상세', 900, 700);">
								                                                <span class="btn btn-secondary" style="padding: 0px 3px;margin-left:5px;">#${issue.dutyBoardId }</span>
						                                                	</a>
					                                                	</c:if>
					                                            	</div>
					                                                <span style="margin-left:25px;">#${issue.issueBoardId }</span>
					                                                <span style="margin-left:5px;">${issue.issueBoardCreateDt }</span>
					                                            </td>
					                                            <td class="project-actions" style="font-size:1.3em;">
						                                            <c:if test="${issue.replyCount ne 0}">
						                                            	<i class="icon-bubble" style="margin-left:5px;"></i> ${issue.replyCount }
					                                            	</c:if>
					                                            </td>
					                                        </tr>
				                                        </c:forEach>
			                                    	</c:if>
			                                    	<!-- 마일스톤이 없을때 -->
			                                    	<c:if test="${empty milestone.issueList }">
			                                    		<tr role="row">
				                                            <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;">마일스톤이 존재하지 않습니다.</td>
			                                            </tr>
			                                    	</c:if>
		                                        </tbody>
			                                </table>
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

<form name="modifyForm" action='<c:url value="/board/milestone/modify"/>' method='post'>
	<input type="hidden" name="milestoneId" />
	<input type="hidden" name="milestoneName" />
	<input type="hidden" name="milestoneEndDt" />
	<input type="hidden" name="milestoneSt" />
	<input type="hidden" name="isOpen" id ="isOpenForModify" />
</form>

<script>
window.onload=function(){
	$('#${milestone.isOpen}').addClass('active');
	
	var endDate = $('.deadline').text().split('/');
	$('.deadline').text(endDate[2]+"-"+endDate[0]+"-"+endDate[1]);
}

// open/closed 탭 변경시
function changeCategory(obj){
	$('#isOpenForTab').val($(obj).attr('id'));
	$('form[name="listForm"]').submit();
}

// 마일스톤 정보 수정
function modifyMilestone(milestoneId, milestoneSt){
	$('input[name="milestoneId"]').val(milestoneId);
	$('input[name="milestoneSt"]').val(milestoneSt);
	$('#isOpenForModify').val(milestoneSt == 'Y' ? 'open' : 'closed');
	
	document.modifyForm.submit();
}

// 마일스톤 삭제
function removeMilestone(milestoneId){
	if(!confirm('마일스톤을 삭제하시겠습니까?')){
		return;
	}
	
	$('input[name="milestoneId"]').val(milestoneId);
	
	document.modifyForm.action = '<c:url value="/board/milestone/remove"/>';
	document.modifyForm.submit();
}

</script>
