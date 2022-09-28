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
</style>

<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
			<div class="row clearfix">
                <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
                    <h2><i class="fa fa-tasks"></i>&nbsp;이슈 목록</h2>
                    <hr>
                </div>
		 	</div>

            <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
                <div class="col-lg-12 col-md-12">
                    <div class="card">
                        <div class="body project_report">
                        	<button type="button" class="btn btn-light active" onclick="window.location.href='${pageContext.request.contextPath}/board/issue/list';">이슈</button>
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/milestone/list';">마일스톤</button>
                        	<button type="button" class="btn btn-light" onclick="window.location.href='${pageContext.request.contextPath}/board/project';">프로젝트</button>
                        	
                       		<label class="fancy-checkbox m-l-30">
                            	<input type="checkbox" data-parsley-multiple="checkbox" <c:if test="${boardFormVO.searchIssueVO.searchCondition eq 'w' && boardFormVO.searchIssueVO.searchKeyword eq loginUser.empName }">checked</c:if>  onchange="setSearchCondition(this);"/>
                                <span>내 이슈만 보기</span>
                            </label>
                        	
                        	<form:form commandName="boardFormVO" name="listForm">
                        		<form:hidden path="searchIssueVO.isOpen" />
                        		<form:hidden path="searchIssueVO.issueOpenSt" />
                        		<div style="margin-top:20px;">
								  	<form:select path="searchIssueVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
								    	<form:option value="tcw">전체</form:option>
									    <form:option value="t">제목</form:option>
									    <form:option value="c">내용</form:option>
									    <form:option value="w">작성자</form:option>
								  	</form:select>
									<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
		                        		<form:input path="searchIssueVO.searchKeyword" class="form-control" placeholder="Search here..." type="text" style="width: 500px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchIssueList);"/>
					                    <button type="button" class="btn btn-default" onclick="searchIssueList();"><i class="icon-magnifier"></i></button>
					                </div>				                
					                <div class="form-group" style="float:right;">
					                	<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
						                	<span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>
					                	</div>
						                <form:select path="searchIssueVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchIssueList(1);">
					       					<form:options items="${boardFormVO.searchIssueVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
					       				</form:select>
									</div>
                        		</div>
                        	
	                            <div class="table-responsive">
		                        	<ul class="nav nav-tabs" style="position:absolute;width:97.5%;z-index: 10;">
		                        		<c:choose>
		                        			<c:when test="${boardFormVO.searchIssueVO.isOpen eq 'open' }">
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="icon-info"></i> <span style="margin-left:5px;">${paginationInfo.totalRecordCount }</span> Open</a></li>
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${oppListCount}</span> Closed</a></li>
		                        			</c:when>
		                        			<c:otherwise>
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="open" onclick="changeCategory(this);"><i class="icon-info"></i> <span style="margin-left:5px;">${oppListCount}</span> Open</a></li>
								                <li class="nav-item" style="cursor:pointer;"><a class="nav-link" id="closed" onclick="changeCategory(this);"><i class="fa fa-check"></i> <span style="margin-left:5px;">${paginationInfo.totalRecordCount }</span> Closed</a></li>
		                        			</c:otherwise>
		                        		</c:choose>
						            </ul>
						            <div class="tab-content p-l-0 p-r-0 p-t-0">
						            	<!-- Open 이슈 -->
						                <div class="tab-pane animated fadeIn active">
			                                <table class="table table-hover js-basic-example table-custom m-b-0 no-footer" role="grid">
			                                	<thead>
			                                		<tr>
			                                			<th style="width:40%;"></th>
			                                			<th style="width:20%;">마일스톤</th>
			                                			<th style="width:20%;">작성자</th>
			                                			<th style="width:10%;">댓글</th>
			                                			<th style="width:10%;">조회수</th>
			                                		</tr>
			                                	</thead>
			                                    <tbody style="border:hidden;">
			                                    	<c:if test="${!empty issueList}">
				                                        <c:forEach items="${issueList }" var="issue">
						                                    <tr role="row">
					                                            <td class="project-title" style="padding:15px 30px;">
					                                            	<div>
						                                                <h6 style="display:inline-block;font-weight: bold;max-width: 400px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;vertical-align: middle;">
						                                                	<c:if test="${boardFormVO.searchIssueVO.isOpen eq 'open' }">
							                                                	<i class="icon-info" style="color:green;"></i>
						                                                	</c:if>
						                                                	<c:if test="${boardFormVO.searchIssueVO.isOpen eq 'closed' }">
							                                                	<i class="icon-check" style="color:red;"></i>
						                                                	</c:if>
						                                                	<span class="issueTitle" style="cursor:pointer;margin-left:5px;font-size:1.1em;" onclick="OpenWindow('${pageContext.request.contextPath }/board/issue/detail?issueBoardId=${issue.issueBoardId }', 'JoinWorkGW', 1200, 700);">${issue.issueBoardTitle }</span>
						                                                </h6>
						                                                <c:if test="${!empty issue.dutyBoardTitle }">
						                                                	<a href="javascript:OpenWindow('${pageContext.request.contextPath }/board/duty/detail?dutyBoardId=${issue.dutyBoardId }', '업무 상세', 900, 700);">
								                                                <span class="btn btn-secondary" style="padding: 0px 3px;margin-left:5px;">#${issue.dutyBoardId }</span>
						                                                	</a>
						                                                </c:if>
						                                                <c:if test="${issue.issueOpenSt eq 'N' }">
							                                                <span class="btn btn-secondary" style="padding: 0px 3px;margin-left:5px;">비공개</span>
						                                                </c:if>
					                                            	</div>
					                                                <span style="margin-left:25px;">#${issue.issueBoardId }</span>
					                                                <span style="margin-left:5px;">${issue.issueBoardCreateDt.split(" ")[0] }</span>
					                                            </td>
					                                            <td class="project-actions" style="max-width: 0px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;padding-right:50px;">
					                                            	${issue.milestoneName }
					                                            </td>
					                                            <td class="project-actions">
					                                            	<c:choose>
					                                            		<c:when test="${empty issue.empPicture }">
							                                            	<img src="<%=request.getContextPath() %>/resources/image/NO_IMAGE.png" data-toggle="tooltip" data-placement="top" title="" alt="Avatar" class="width45 rounded" data-original-title="${issue.empName }">
					                                            		</c:when>
					                                            		<c:otherwise>
					                                            			<div id="pictureView" style="display:inline-block;vertical-align:middle;margin-right:10px;background-image:url('${pageContext.request.contextPath}/admin/emp/getPicture?picture=${issue.empPicture}'); width: 45px; height: 45px;" class="rounded-circle avatar" data-toggle="tooltip" data-placement="top" data-original-title="${issue.empName }"></div>
					                                            			<div style="display:inline-block;vertical-align:middle;">
												                                <strong>${issue.empName } ${issue.officialName }</strong>
												                                <div>${issue.deptName } <span>${issue.teamName }</span></div>
												                            </div>
					                                            		</c:otherwise>
					                                            	</c:choose>
					                                            </td>
					                                            <td class="project-actions" style="font-size:1.3em;">
						                                            <c:if test="${issue.replyCount ne 0}">
						                                            	<i class="icon-bubble" style="margin-left:5px;"></i> ${issue.replyCount }
					                                            	</c:if>
					                                            </td>
					                                            <td class="project-actions" style="font-size:1.3em;">
					                                            	&nbsp;&nbsp;&nbsp;&nbsp;${issue.issueBoardReadcnt }
					                                            </td>
					                                        </tr>
				                                        
				                                        </c:forEach>
			                                    	</c:if>
			                                    	<!-- 검색결과가 없을때 -->
			                                    	<c:if test="${empty issueList }">
			                                    		<tr role="row">
				                                            <td class="project-title noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="8">검색 결과가 없습니다.</td>
			                                            </tr>
			                                    	</c:if>
		                                        </tbody>
			                                </table>
						                </div>
						                
						                <!-- Pagination -->
				                        <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
			                                <ul class="pagination" style="display: inline-block;">
			                                	<c:if test="${!empty issueList }">
				                                   	<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="searchIssueList" />
			                                	</c:if>
			                                </ul>
			                            </nav>
			                            <form:hidden path="searchIssueVO.pageIndex" />
						                
						            </div>
		                        </div>
	                        </form:form>
	                    </div>
	                </div>
	            </div>
            </div>
        </div>
</div>

<script>
window.onload=function(){
	$('#${boardFormVO.searchIssueVO.isOpen}').addClass('active');
	
	paginationCSS(${paginationInfo.currentPageNo},
			  ${paginationInfo.firstPageNoOnPageList},
			  ${paginationInfo.lastPageNoOnPageList},
			  ${paginationInfo.totalPageCount});
}

// open/closed 탭 변경시
function changeCategory(obj){
	$('input[name="searchIssueVO.isOpen"]').val($(obj).attr('id'));
	$('form[name="listForm"]').submit();
}

//검색 및 페이지네이션
function searchIssueList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm"]');
	$('input[name="searchIssueVO.pageIndex"]').val(pageNo);
	listForm.submit();
}

// 내 이슈만 보기
function setSearchCondition(obj){
	if($(obj).is(':checked')){
		$('select[name="searchIssueVO.searchCondition"]').val('w');
		$('input[name="searchIssueVO.searchKeyword"]').val('${loginUser.empName}');
		$('input[name="searchIssueVO.issueOpenSt"]').val('N');
	}else{
		$('select[name="searchIssueVO.searchCondition"]').val('tcw');
		$('input[name="searchIssueVO.searchKeyword"]').val('');
		$('input[name="searchIssueVO.issueOpenSt"]').val('Y');
	}
	searchIssueList();
}
</script>
