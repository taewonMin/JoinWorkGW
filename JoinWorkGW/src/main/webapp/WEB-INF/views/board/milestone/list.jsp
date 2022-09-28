<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
    
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
                <div class="col-12" style="margin-top: 2%; font-family: 'S-CoreDream-6Bold">
                    <h2><i class="icon-direction"></i>&nbsp;마일스톤</h2>
                    <hr>
                </div>
		 	</div>

            <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
                <div class="col-lg-12 col-md-12">
                    <div class="card">
                        <div class="body project_report">
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';">이슈</button>
                        	<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';">마일스톤</button>
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/project';">프로젝트</button>
                        	<button type="button" class="btn btn-primary float-right" onclick="OpenWindow('${pageContext.request.contextPath }/board/milestone/registForm', '마일스톤 생성', 1000, 700);">마일스톤 생성하기</button>
                        	
                        	<form:form commandName="milestoneVO" name="listForm" action="${pageContext.request.contextPath }/board/milestone/list">
                        		<form:hidden path="isOpen" id="isOpenForTab" />
	                            <div class="table-responsive" style="margin-top:20px;">
		                        	<ul class="nav nav-tabs">
		                        		<c:choose>
		                        			<c:when test="${milestoneVO.isOpen eq 'open' }">
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="icon-info"></i> <span style="margin-left:5px;">${milestoneList.size() }</span> Open</a></li>
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${oppListCount}</span> Closed</a></li>
		                        			</c:when>
		                        			<c:otherwise>
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="icon-info"></i> <span style="margin-left:5px;">${oppListCount}</span> Open</a></li>
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${milestoneList.size() }</span> Closed</a></li>
		                        			</c:otherwise>
		                        		</c:choose>
						            </ul>
						            <div class="tab-content p-l-0 p-r-0 p-t-0">
						            	<!-- 마일스톤 뷰-->
						                <div class="tab-pane animated fadeIn active">
			                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
			                                    <tbody style="border:hidden;">
			                                    	<c:if test="${!empty milestoneList}">
				                                        <c:forEach items="${milestoneList }" var="milestone">
						                                    <tr role="row">
					                                            <td class="project-title" style="padding:30px;width:50%;">
					                                            	<div>
						                                                <h6>
						                                                	<span data-openIssueCount="${milestone.openIssueCount }" data-closedIssueCount="${milestone.closedIssueCount }" data-milestoneId="${milestone.milestoneId }"
						                                                	 style="margin-bottom:5px;display:inline-block;font-weight: bold;max-width: 500px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="detailPage('${milestone.milestoneId}')">${milestone.milestoneName }</span>
						                                                </h6>
					                                            	</div>
					                                            	<div style="font-size: 1.1em;">
						                                                <span style="margin-left:5px;">마감일
						                                                <c:if test="${!empty milestone.milestoneEndDt }">
							                                                : ${milestone.milestoneEndDt.split(' ')[0] }
						                                                </c:if> 
						                                                <c:if test="${empty milestone.milestoneEndDt }">
						                                                	없음
						                                                </c:if> 
						                                                </span>
						                                                <span style="margin-left:10px;vertical-align: middle;"><i class="icon-clock"></i> <span class="lastUpdateDt">${milestone.milestoneUpdateDt }</span> 수정됨</span>
					                                            	</div>
					                                            </td>
					                                            <td class="project-title" style="padding:5px 30px;width:50%;">
					                                            	<!-- 진행률 -->
					                                            		<c:if test="${milestone.openIssueCount + milestone.closedIssueCount eq 0 }">
							                                            	<c:set var="percentage" value="0"></c:set>
					                                            		</c:if>
					                                            		<c:if test="${milestone.openIssueCount + milestone.closedIssueCount ne 0 }">
							                                            	<fmt:parseNumber var="percentage" value="${milestone.closedIssueCount/(milestone.openIssueCount + milestone.closedIssueCount)*100 }" integerOnly="true" />
					                                            		</c:if>
									                                <div class="progress progress-xs" style="height:10px;margin-top:5px;background-color:rgb(0,0,0,0.2);">
									                                    <div class="progress-bar" role="progressbar" aria-valuenow="${percentage }" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage }%; height:10px;">
									                                    </div>
									                                </div>
									                                <div style="margin-top: 5px;font-size:1.1em;">
									                                	<span><strong style="font-size:1.1em;">${percentage }%</strong> 진행됨</span>
									                                	<span style="margin-left:10px;"><strong style="font-size:1.1em;">${milestone.openIssueCount }</strong> Open</span>
									                                	<span style="margin-left:10px;"><strong style="font-size:1.1em;">${milestone.closedIssueCount }</strong> Closed</span>
									                                </div>
									                                <div style="margin-top: 10px;">
									                                	<span class="btn btn-info" style="height: 25px;padding: 0px 10px;font-size:1.1em;" onclick="OpenWindow('${pageContext.request.contextPath }/board/milestone/modifyForm?milestoneId=${milestone.milestoneId }', '마일스톤 수정', 1000, 700);">수정</span>
									                                	<c:if test="${milestone.milestoneSt eq 'Y' }">
										                                	<span class="btn btn-secondary" style="height: 25px;margin-left:10px;padding: 0px 10px;font-size:1.1em;" onclick="modifyMilestone('${milestone.milestoneId}','N');">종료</span>
									                                	</c:if>
									                                	<c:if test="${milestone.milestoneSt eq 'N' }">
										                                	<span class="btn btn-success" style="height: 25px;margin-left:10px;padding: 0px 10px;font-size:1.1em;" onclick="modifyMilestone('${milestone.milestoneId}','Y');">재시작</span>
									                                	</c:if>
									                                	<span class="btn btn-danger" style="height: 25px;margin-left:10px;padding: 0px 10px;font-size:1.1em;" onclick="removeMilestone('${milestone.milestoneId}');">삭제</span>
									                                </div>
					                                            </td>
					                                        </tr>
				                                        
				                                        </c:forEach>
			                                    	</c:if>
			                                    	<!-- 마일스톤이 없을때 -->
			                                    	<c:if test="${empty milestoneList }">
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
	<!-- detail 페이지 용 -->
	<input type="hidden" name="openIssueCount" />
	<input type="hidden" name="closedIssueCount" />
</form>

<script>
window.onload=function(){
	$('#${milestoneVO.isOpen}').addClass('active');
	
	$('.lastUpdateDt').each(function(){
		$(this).text(getTimeDefferFromCurrent(new Date($(this).text())));
	});
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
	
	$('input[name="openIssueCount"]').remove();
	$('input[name="closedIssueCount"]').remove();
	
	$('#isOpenForModify').val(milestoneSt == 'Y' ? 'open' : 'closed');
	
	document.modifyForm.submit();
}

// 마일스톤 삭제
function removeMilestone(milestoneId){
	if(!confirm('마일스톤을 삭제하시겠습니까?')){
		return;
	}
	
	$('input[name="milestoneId"]').val(milestoneId);
	$('input[name="openIssueCount"]').remove();
	$('input[name="closedIssueCount"]').remove();
	
	document.modifyForm.action = '<c:url value="/board/milestone/remove"/>';
	document.modifyForm.submit();
}

// 마일스톤 상세 페이지
function detailPage(milestoneId){
	document.listForm.action ='<c:url value="/board/milestone/detail?milestoneId='+milestoneId+'"/>';
	document.listForm.submit();
}
</script>
