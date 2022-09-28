<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
	text-align: center;
}

.td2{
/* 	text-align: left;  */
/* 	padding-left: 80px; */
}

.num{
	width:80px;
}


</style> 

<body>

<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
		<div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold ">
			<div class="col-12" style="margin-top: 2%;">
				<h2 style="font-family: S-CoreDream-6Bold"><i class="fa fa-comments-o"></i>&nbsp;익명 게시판</h2>
			    <hr>
			</div>
		</div>
		<div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold;">
			<div class="col-lg-12 col-md-12">
				<div class="card">
					<div class="body project_report">
						<form:form commandName="boardFormVO" id="listForm" name="listForm">
							<!-- 리셋버튼 -->
							<button id="resetBtn" type="reset" class="btn btn-default" title="Refresh" style="display: none;"></button>
							<label onclick="conditionReset();"  style="cursor: pointer;">
								<i class="fa fa-refresh"></i>&nbsp&nbsp검색 조건 초기화
							</label>
							
							<div style="display:inline-block;margin:5px 15px;font-size: 1.2em;color:gray;">
								[총 <fmt:formatNumber value="${paginationInfo.totalRecordCount }" type="number"/>개]
							</div>
							<!-- 설정된 검색 조건 입력 폼 표시 -->
							<div>
								<form:select path="searchAnonyVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
									<form:option value="tc">전체</form:option>
									<form:option value="t">제목</form:option>
									<form:option value="c">내용</form:option>
									<form:option value="r">댓글내용</form:option>
								</form:select>
								<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
									<form:input path="searchAnonyVO.searchKeyword" class="form-control" placeholder="검색어를 입력하세요" type="text" style="width: 218px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchList);"/>
									<button type="button" class="btn btn-default" onclick="searchList();"><i class="icon-magnifier"></i></button>
								</div>
								<div class="form-group" style="float:right;">
									<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
										<span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>-
									</div>
									<form:select path="searchAnonyVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchList(1);">
										<form:options items="${boardFormVO.searchAnonyVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
									</form:select>
								</div>
							</div>
							<!-- 게시판 목록 -->
							<div class="body">
								<div class="table-responsive">
									<table class="table table-hover m-b-0">
										<thead class="shadow-none p-3 mb-5 bg-light rounded">
											<tr id="tr1">
												<th class="num" style="width: 105px; text-align: center;">번호</th>                                            
												<th class="title" style="width: 300px;">제목</th>
												<th>작성일자</th>
												<th>조회수</th>
											</tr>
										</thead>
										<tbody style="cursor: pointer;">
											<c:if test="${!empty anonyList }">
												<c:forEach items="${anonyList }" var="anony">
													<tr role="row" onclick="OpenWindow('<%=request.getContextPath()%>/board/anony/detail?anonyBoardId=${anony.anonyBoardId }', 'JoinWorkGW', 800, 700);">
														<td id="anonyBoardId" style="text-align:center;">${anony.anonyBoardId}</td>
														<td id="anonyBoardTitle" style="width: 60%;text-align: left; padding-left: 100px;">
															<span style="width: 300px;">${anony.anonyBoardTitle }</span>
															<c:if test="${defferTime <= (1000*60*5) }">
																&nbsp<span class="badge badge-danger">방금전</span>
															</c:if>
															<c:if test="${anony.anonyReplyList.size() > 0 }">
																<i class="icon-bubble text-info" style="margin-left:5px; font-size: 1.2em; font-weight: bold">
																	<span class="m-l-5" style="vertical-align: text-top; margin-left: 3px;">
																		<fmt:formatNumber value="${anony.anonyReplyList.size() }" type="number"/>
																	</span>
																</i>
															</c:if>
														</td>
														<td>
															<fmt:formatDate value="${anony.anonyBoardCreateDt }" pattern="yyyy.MM.dd"/>
														</td>
														<td style="text-align:center;">${anony.anonyBoardReadcnt }</td>
													</tr>
												</c:forEach>
											</c:if>
											<c:if test="${empty anonyList }">
												<tr>
													<td style="text-align: center;"><strong>해당 내용이 없습니다.</strong></td>
												</tr>
											</c:if>
										</tbody>
									</table>
								</div>
							</div>
							<!-- Pagination -->
							<nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
								<ul class="pagination" style="display: inline-block;">
									<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchList" />
								</ul>
							</nav>
							<form:hidden path="searchAnonyVO.pageIndex" />
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
function searchList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm"]');
	$('input[name="searchAnonyVO.pageIndex"]').val(pageNo);
	listForm.submit();
}

// 검색조건 초기화
function conditionReset() {
	$("#resetBtn").click();
	$('.myConditions').css("display","none");
	$('input#searchAnonyVO.searchKeyword').val("");
	$("input:checkbox:checked").click();
	$("#inputSearchDt").val("");
}
</script>
