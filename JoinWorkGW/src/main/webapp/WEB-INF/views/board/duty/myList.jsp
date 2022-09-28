<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.noList:hover{
	background-color: white;
	cursor: default;
}
</style>

<jsp:include page="../issueSidebar.jsp" />

<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
			<div class="row clearfix">
                <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
                    <h2><i class="fa fa-navicon"></i>&nbsp;내 업무 목록</h2>
                    <hr>
                </div>
		 	</div>

            <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold">
                <div class="col-lg-12 col-md-12">
                    <div class="card">
                        <div class="body project_report">
                        <form:form commandName="boardFormVO" id="listForm" name="listForm">
                        	<!-- 검색 조건 설정 -->
                        	<h5 style="display:inline-block; font-weight: bold;">검색 조건</h5>
                        	<div class="alert alert-light" role="alert" style="display:inline-block;padding-top:0;margin-bottom:0;">
                        		<label class="fancy-checkbox">
                                    <input type="checkbox" id="checkboxDeadline" data="selectDeadline" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                                    <span>완료 기한(까지)</span>
                                </label>
                        		<label class="fancy-checkbox">
                                    <input type="checkbox" id="checkboxState" data="selectState" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                                    <span>진행 상태</span>
                                </label>
                                
								<!-- 리셋버튼 -->
								<label onclick="conditionReset();"  style="cursor: pointer;">
									<i class="fa fa-refresh"></i>&nbsp;&nbsp;검색 조건 초기화
								</label>
								
                                <div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
				                    [총 <fmt:formatNumber value="${paginationInfo.totalRecordCount }" type="number"/>개]
				                </div>
                        	</div>
                        	
                        	<!-- 설정된 검색 조건 입력 폼 표시 -->
                        	<div>
	                            <div class="input-group date selectDeadline myConditions" data-date-autoclose="true" data-provide="datepicker" style="font-size:1.2em;width:200px;margin-right:15px;float:left;display:none;">
	                                <form:input path="searchDutyVO.searchDeadline" id="inputSearchDeadline" type="text" class="form-control selectDeadline" placeholder="완료날짜 선택" readonly="true"/>
	                                <div class="input-group-append">                                            
	                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
	                                </div>
	                            </div>
							  	<form:select path="searchDutyVO.searchState" id="selectSearchState" class="form-control selectState myConditions" style="width:200px;font-size: 1.2em;margin-right:15px;float:left;display: none;">
							    	<form:option value="">진행 상태 선택</form:option>
							    	<form:option value="Y">진행중</form:option>
							    	<form:option value="N">종료</form:option>
							  	</form:select>
							  	<form:select path="searchDutyVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
							    	<form:option value="tcmn">전체</form:option>
								    <form:option value="t">제목</form:option>
								    <form:option value="c">내용</form:option>
								    <form:option value="m">담당자</form:option>
								    <form:option value="n">업무번호</form:option>
							  	</form:select>
	                        	<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
	                        		<form:input path="searchDutyVO.searchKeyword" class="form-control" placeholder="Search here..." type="text" style="width: 500px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchDutyList);"/>
				                    <button type="button" class="btn btn-default" onclick="searchDutyList();"><i class="icon-magnifier"></i></button>
				                </div>
				                
				                <div class="form-group" style="float:right;">
				                	<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
					                	<span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>
				                	</div>
					                <form:select path="searchDutyVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchDutyList(1);">
				       					<form:options items="${boardFormVO.searchDutyVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
				       				</form:select>
								</div>
                        	</div>
							
							<!-- 게시판 목록 -->
                            <div class="table-responsive">
                                <table class="table table-hover js-basic-example dataTable table-custom m-b-0 no-footer" id="DataTables_Table_0" role="grid" aria-describedby="DataTables_Table_0_info">
                                    <thead>
                                        <tr role="row">
                                        	<th class="sorting_desc" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-sort="descending" aria-label="Deadline: activate to sort column descending" style="width: 50px;text-align: center;">업무 번호</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Project: activate to sort column ascending" style="width: 300px;">업무 제목</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Deadline: activate to sort column ascending" style="width: 100px;">완료 기한</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Deadline: activate to sort column ascending" style="width: 80px;">진행 상태</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Lead: activate to sort column ascending" style="width: 67px;">팀장</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Team: activate to sort column ascending" style="width: 100px;">담당자</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending" style="width: 60px;text-align: center;">참조자</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending" style="width: 60px;text-align: center;">조회수</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Action: activate to sort column ascending" style="width: 60px;text-align: center;">클립</th>
                                       	</tr>
                                    </thead>
                                    <tbody style="cursor: pointer;">
                                    	<c:if test="${dutyList.size() > 0 }">
	                                        <c:forEach items="${dutyList }" var="duty">
	                                        <fmt:parseNumber value="${myToday.time - duty.dutyBoardCreateDt.time }" integerOnly="true" var="defferTime"/>
		                                    	<tr role="row" onclick="OpenWindow('<%=request.getContextPath()%>/board/duty/detail?dutyBoardId=${duty.dutyBoardId }', 'JoinWorkGW', 1000, 700);">
		                                            <td style="text-align:center;">${duty.dutyBoardId }</td>
		                                            <td class="project-title sorting_1">
		                                                	<span>${duty.dutyBoardTitle }</span>
		                                                	<c:if test="${defferTime <= (1000*60*5) }">
			                                                  	&nbsp<span class="badge badge-danger">방금전</span>
			                                                </c:if> 
		                                                </h6>
		                                                <c:if test="${duty.replyCount != 0 }">
			                                                <i class="icon-bubble text-info" style="margin-left:5px; font-size: 1.2em; font-weight: bold"><span class="m-l-5" 
			                                                	style="vertical-align: text-top; margin-left: 3px;"><fmt:formatNumber value="${duty.replyCount }" type="number"/></span></i>
		                                                </c:if>
		                                                <c:if test="${duty.attachCount ne 0}">
			                                    			<i class="fa fa-file-text fa-2x text-info" style="margin-left:5px; font-size: 1.2em; font-weight: bold"></i>
		                                            	</c:if>
		                                                <br>
		                                                <small>
			                                                <fmt:formatDate value="${duty.dutyBoardCreateDt }" pattern="yyyy.MM.dd"/>
		                                                </small>
		                                            </td>
		                                            <td>
		                                             ~ <fmt:formatDate value="${duty.dutyBoardEndDt }" pattern="yyyy.MM.dd"/>
		                                             
		                                             	<fmt:parseNumber value="${myToday.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
														<fmt:parseNumber value="${duty.dutyBoardEndDt.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
		                                            	<c:if test="${(endDate-strDate) < 3 && (endDate-strDate) >= 0 && duty.dutyBoardEndDt.getTime() >= today}">
	                                                  		<span class="badge badge-danger">마감임박</span>
	                                                  	</c:if>
		                                            </td>
		                                            <td>
		                                            	<c:choose>
		                                            		<c:when test="${duty.dutyBoardEndDt.getTime() >= today }">
				                                            	<span class="badge badge-success">진행중</span>
		                                            		</c:when>
		                                            		<c:otherwise>
				                                            	<span class="badge badge-danger">종료</span>
		                                            		</c:otherwise>
		                                            	</c:choose>
		                                            </td>
		                                            <td>
		                                            	<c:choose>
		                                            		<c:when test="${empty duty.empPicture }">
				                                            	<img src="<%=request.getContextPath() %>/resources/image/NO_IMAGE.png" data-toggle="tooltip" data-placement="top" title="" alt="Avatar" class="width35 rounded" data-original-title="${duty.empName }">
		                                            		</c:when>
		                                            		<c:otherwise>
				                                            	<img src="<%=request.getContextPath() %>/resources/image/memberProfile/${duty.empId }.jpg" data-toggle="tooltip" data-placement="top" title="" alt="Avatar" class="width35 rounded" data-original-title="${duty.empName }">
		                                            		</c:otherwise>
		                                            	</c:choose>
	                                            	</td>
		                                            <td>
		                                                <ul class="list-unstyled team-info">
		                                                	<c:forEach items="${duty.dutyManagerList }" var="dutyManager" varStatus="myStatus">
<%-- 		                                                		<c:choose> --%>
<%-- 		                                                			<c:when test="${empty dutyManager.empPicture }" > --%>
<%-- 					                                                    <li><img src="<%=request.getContextPath() %>/resources/image/NO_IMAGE.png" data-toggle="tooltip" data-placement="top" title="" data-original-title="${dutyManager.empName }"></li> --%>
<%-- 		                                                			</c:when> --%>
<%-- 		                                                			<c:otherwise> --%>
<%-- 			                                                			<li><img src="<%=request.getContextPath() %>/resources/image/memberProfile/${dutyManager.empId }.jpg" data-toggle="tooltip" data-placement="top" class="width35 rounded" title="" data-original-title="${dutyManager.empName }"></li> --%>
<%-- 		                                                			</c:otherwise> --%>
<%-- 		                                                		</c:choose> --%>
																<c:if test="${myStatus.count <= 3 }">
																	<c:choose>
																		<c:when test="${empty dutyManager.empPicture }" > 
						                                                    <li><img src="<%=request.getContextPath() %>/resources/image/NO_IMAGE.png" data-toggle="tooltip" data-placement="top" title="" data-original-title="${dutyManager.empName }"></li>
			                                                			</c:when>
			                                                			<c:otherwise>
				                                                			<li><img src="<%=request.getContextPath() %>/resources/image/memberProfile/${dutyManager.empId }.jpg" data-toggle="tooltip" data-placement="top" class="width35 rounded" title="" data-original-title="${dutyManager.empName }"></li>
			                                                			</c:otherwise>
																	</c:choose>
                                                            	</c:if>
                                                            	<c:if test="${myStatus.count == 4 }">
                                                            		<div style="width: 40px; border-radius: 50%; display: inline-block; margin: 0;padding: 0;">외 ${duty.dutyManagerList.size() - 3}명</div>
                                                            	</c:if>

		                                                	</c:forEach>                                                
		                                                </ul>
		                                            </td>
		                                            <td style="text-align:center;">
		                                            	${duty.deptCnt + duty.empCnt }명
		                                    		</td>
		                                    		<td style="text-align:center;">${duty.dutyBoardReadcnt }</td>
		                                            <td class="project-actions" style="text-align:center;">
		                                                <a href="javascript:void(0);" class="btn btn-sm btn-outline-success" data-context="info" data-message="업무번호가 클립보드에 복사되었습니다." data-position="bottom-right" onclick="copyClipboard('${duty.dutyBoardId}');showAlarm(this);OpenWindow('${pageContext.request.contextPath }/board/duty/registForm?registParam=issue&dutyBoardId=${duty.dutyBoardId }', '이슈 작성', 1000, 700);event.stopPropagation();"><i class="icon-paper-clip"></i></a>
		                                            </td>
		                                        </tr>
	                                        </c:forEach>
                                    	</c:if>
                                    	<c:if test="${dutyList.size() == 0 }">
                                    		<tr>
	                                            <td class="noList" style="text-align:center;font-size:1.2em;font-weight: bold;height:80px;" colspan="8">검색 결과가 없습니다.</td>
	                                        </tr>
                                    	</c:if>
                                	</tbody>
                                </table>
	                        </div>
	                        
	                        <!-- Pagination -->
	                        <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
                                <ul class="pagination" style="display: inline-block;">
                                   	<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchDutyList" />
                                </ul>
                            </nav>
                            <form:hidden path="searchDutyVO.pageIndex" />
						</form:form>
	                    </div>
	                </div>
	            </div>
            </div>
        </div>
</div>

<script>
window.onload=function(){
	// 정렬 아이콘 삭제
	var thList = $('tr[role="row"] > th');
	for(var i=0; i<thList.length; i++){
		thList.eq(i).removeClass();
	}
	
	// 검색 조건 체크박스 설정
	if($('#inputSearchDeadline').val()!=""){
		$('#checkboxDeadline').attr("checked",true);
		changeForm(document.getElementById('checkboxDeadline'));
	}
	if($('#selectSearchState').val()!=""){
		$('#checkboxState').attr("checked",true);
		changeForm(document.getElementById('checkboxState'));
	}
	
	paginationCSS(${paginationInfo.currentPageNo},
				  ${paginationInfo.firstPageNoOnPageList},
				  ${paginationInfo.lastPageNoOnPageList},
				  ${paginationInfo.totalPageCount});
}

// 검색 조건 설정 변화
function changeForm(obj){
	var searchCri = $(obj).attr('data');
	
	if($(obj).is(':checked')==true){
		$('.'+searchCri).css('display','');
	}else{
		$('.'+searchCri).css('display','none');
		$('.'+searchCri).val("");
	}
}

// 검색 및 페이지네이션
function searchDutyList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm"]');
	$('input[name="searchDutyVO.pageIndex"]').val(pageNo);
	listForm.submit();
}

// 검색조건 초기화
function conditionReset() {
	$('.myConditions').css("display","none");
	$('input#checkboxDeadline').prop('checked',false);
	$('input#checkboxState').prop('checked',false);
	$('input[name="searchDutyVO.searchKeyword"]').val("");
	$('select[name="searchDutyVO.searchCondition"]').val('tcmn');
	$('form[name="listForm"]').submit();
}
</script>