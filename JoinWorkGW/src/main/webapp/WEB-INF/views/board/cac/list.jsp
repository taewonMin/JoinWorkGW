<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../boardSidebar.jsp" />
<head>
<!-- VENDOR CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/chartist/css/chartist.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/chartist-plugin-tooltip/chartist-plugin-tooltip.css">
</head>

<style>

.pagination{
	text-align: center;
}

#tr1{
	text-align: center;
	padding-left: -10px;
}

tbody{
	text-align: center;"
}

.td2{
	text-align: left;
}
</style>

<body>

<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
			<div class="row clearfix" >
                <div class="col-12" style="margin-top: 2%;">
                    <h2 style="font-family: S-CoreDream-6Bold"><i class="icon-envelope-letter"></i>&nbsp;경조사</h2>
                    <hr>
                </div>
		 	</div>

            <div class="row clearfix" style="font-family: S-CoreDream-6Bold">
                <div class="col-lg-12 col-md-12">
                    <div class="card">
                        <div class="body project_report">
                        	<form:form commandName="boardFormVO" id="listForm" name="listForm">
                        			<!-- 검색 조건 설정 -->
		                           <h5 style="display:inline-block; font-weight: bold;">검색 조건</h5>
		                           <div class="alert alert-light" role="alert" style="display:inline-block;padding-top:0;margin-bottom:0;">
		                           <label class="fancy-checkbox">
		                                 <input type="checkbox" data="selectDt" id="dateCheckBox" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
		                                 <span>행사마감 날짜</span>
		                           </label>
		                           <label class="fancy-checkbox">
		                                 <input type="checkbox" id="checkboxState" data="selectState" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
		                                 <span>분류</span>
		                           </label>
                        	
									<!-- 리셋버튼 -->
	                                <button id="resetBtn" type="reset" class="btn btn-default" title="Refresh" style="display: none;"></button>
									<label onclick="conditionReset();"  style="cursor: pointer;">
										<i class="fa fa-refresh"></i>&nbsp&nbsp검색 조건 초기화
									</label>
									
	                                <div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
					                    [총 <fmt:formatNumber value="${paginationInfo.totalRecordCount }" type="number"/>개]
					                </div>
					                </div>
                        		<!-- 설정된 검색 조건 입력 폼 표시 -->
                        		<div>
	                        	    <div class="input-group date searchCri searchDt selectDt myConditions" data-date-autoclose="true" data-provide="datepicker" style="font-size:1.2em;width:200px;margin-right:15px;float:left;display:none;">
		                                <form:input path="searchCacVO.searchDt" id="inputSearchDt" type="text" class="form-control" placeholder="작성날짜 선택" readonly="true"/>
		                                <div class="input-group-append">                                            
		                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
		                                </div>
		                            </div>
                        			<form:select path="searchCacVO.searchState" id="selectSearchState" class="form-control selectState myConditions" style="width:200px;font-size: 1.2em;margin-right:15px;float:left;display: none;">
			                            <form:option value="">분류 선택</form:option>
			                            <form:option value="결혼">결혼</form:option>
			                            <form:option value="부고">부고</form:option>
<%-- 			                            <form:option value="기타">기타</form:option> --%>
		                            </form:select>
                        			
	                        		<form:select path="searchCacVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
								    	<form:option value="tcm">전체</form:option>
									    <form:option value="t">제목</form:option>
									    <form:option value="c">내용</form:option>
									    <form:option value="m">작성자</form:option>
								  	</form:select>
	                        		<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
		                        		<form:input path="searchCacVO.searchKeyword" class="form-control" placeholder="검색어를 입력하세요" type="text" style="width: 218px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchCacList);"/>
					                    <button type="button" class="btn btn-default" onclick="searchCacList();"><i class="icon-magnifier"></i></button>
					                </div>
					                
					                <div class="form-group" style="float:right;">
					                	<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
						                	<span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>
					                	</div>
						                <form:select path="searchCacVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchCacList(1);">
					       					<form:options items="${boardFormVO.searchCacVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
					       				</form:select>
									</div>
                        		</div>
		                        <div class="body" style="padding: 0;">
		                            <div class="table-responsive">
		                                <table class="table table-hover m-b-0">
											<thead class="shadow-none p-3 mb-5 bg-light rounded">
		                                        <tr id="tr1">
		                                            <th style="width:80px;">번호</th>                                            
		                                            <th>분류</th>
		                                            <th>제목</th>
		                                            <th>행사기간</th>
		                                            <th>작성자</th>
		                                            <th>작성일자</th>
		                                            <th>조회수</th>
		                                        </tr>
		                                    </thead>
		                                  	 <tbody>
		                                  	 	<c:forEach items="${cacList }" var="cac">
		                                  	 		<tr>
			                                            <td id="cacBoardId">${cac.cacBoardId }</td>
			                                            <c:if test="${cac.cacCategory eq '결혼'}">
				                                            <td id="cacCategory"><span class="badge badge-danger">${cac.cacCategory}</span></td>
			                                            </c:if>
			                                            <c:if test="${cac.cacCategory eq '부고'}">
				                                            <td id="cacCategory">
					                                            <span class="badge" style="color: black; border-color: black;">
																	   ${cac.cacCategory}
																</span>
															</td>
			                                            </c:if>
<%-- 		                                            	<c:if test="${cac.cacCategory eq '기타'}"> --%>
<!-- 			                                            <td id="cacCategory"> -->
<!-- 			                                            </td> -->
<%-- 			                                            </c:if> --%>
			                                            <td id="cacBoardTitle" style="text-align: left; padding-left: 80px; cursor: pointer;" onclick="OpenWindow('<%=request.getContextPath()%>/board/cac/detail?cacBoardId=${cac.cacBoardId }', '글 상세보기', 950, 850);">
			                                            	<b>${cac.cacBoardTitle} </b>
			                                            </td>
															<td>
																<fmt:parseDate value='${cac.cacStartDt}' var='cacStartDt1' pattern='yyyy-mm-dd'/> 
 																<fmt:formatDate value="${cacStartDt1}" pattern="yyyy-mm-dd"/> ~
 																<fmt:parseDate value='${cac.cacEndDt}' var='cacEndDt1' pattern='yyyy-mm-dd'/>
	 															<fmt:formatDate value="${cacEndDt1}" pattern="yyyy-mm-dd"/>
 															</td>	
			                                            <td id="empWriterId">${cac.empName}</td>
			                                            <td id="cacBoardCreateDt">
			                                            	<fmt:parseDate value='${cac.cacBoardCreateDt}' var='cacBoardCreateDt1' pattern='yyyy-mm-dd'/>
															<fmt:formatDate value="${cacBoardCreateDt1}" pattern="yyyy-mm-dd"/>
														</td>
			                                            <td id="cacBoardReadcnt">${cac.cacBoardReadcnt}</td>
		                                        	</tr>
		                                        </c:forEach>
		                                        <c:if test="${cacList.size() == 0 }">
                                    			  <tr>
	                                                  <td colspan="7" style="text-align: center;"><strong>해당 게시물이 존재하지 않습니다.</strong></td>
	                                              </tr>
                                    			</c:if>
		                                   </tbody>
		                                </table>
		                            </div>
		                        </div>
							<!-- Pagination -->
	                        <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
                                <ul class="pagination" style="display: inline-block;">
                                   	<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchCacList" />
                                </ul>
                            </nav>
                            <form:hidden path="searchCacVO.pageIndex" />
						</form:form>
			           </div>
	                </div>
	            </div>
            </div>
        </div>
</div>
</body>

<script>
window.onload=function(){
	// 정렬 아이콘 삭제
	var thList = $('tr[role="row"] > th');
	for(var i=0; i<thList.length; i++){
		thList.eq(i).removeClass();
	}
	
	// 검색 조건 체크박스 설정
	if($('#inputSearchDt').val()!=""){
		$('#dateCheckBox').attr("checked",true);
		changeForm(document.getElementById('dateCheckBox'));
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
function searchCacList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm"]');
	$('input[name="searchCacVO.pageIndex"]').val(pageNo);
	listForm.submit();
}

//검색조건 초기화
function conditionReset() {
	$("#resetBtn").click();
	$('.myConditions').css("display","none");
	$('input#searchCacVO.searchKeyword').val("");
	$("input:checkbox:checked").click();
	$("#inputSearchDt").val("");
}
</script>



