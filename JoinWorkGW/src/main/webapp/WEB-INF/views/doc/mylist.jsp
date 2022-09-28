<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<jsp:include page="sidebar.jsp" />
  
<div id="main-content">
	<div class="container-fluid">
			<div class="row clearfix">
                <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
                    <h2><i class="fa fa-folder-open"></i>&nbsp;내 문서</h2>
                    <hr>
                </div>
		 	</div>

            <div class="row clearfix">
                <div class="col-lg-12 col-md-12">
                    <div class="card">
                        <div class="body project_report" style="font-family: S-CoreDream-7ExtraBold">
                         <form:form commandName="docFormVO" id="listForm" name="listForm">
                         
                        	<!-- 검색 조건 설정 -->
                        	<!-- 설정된 검색 조건 입력 폼 표시 -->
                        
							  	<form:select path="searchDocVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
							    	<form:option value="tcm">전체</form:option>
								    <form:option value="t">제목</form:option>
								    <form:option value="c">내용</form:option>
								    <form:option value="m">담당자</form:option>
							  	</form:select>
							  	<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
	                        		<form:input path="searchDocVO.searchKeyword" class="form-control" placeholder="Search here..." type="text" style="width: 218px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchDocList);"/>
				                    <button type="button" class="btn btn-default" onclick="searchDocList();"><i class="icon-magnifier"></i></button>
				                </div>
	                        	<div class="form-group" style="float:right;">
				                	<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
					                	<span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>
				                	</div>
					                <form:select path="searchDocVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchDocList(1);">
				       					<form:options items="${docFormVO.searchDocVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
				       				</form:select>
								</div>
				                
							<!-- 게시판 목록 -->
                            <div class="table-responsive">
                                <table class="table table-hover js-basic-example dataTable table-custom m-b-0 no-footer" id="DataTables_Table_0" role="grid" aria-describedby="DataTables_Table_0_info">
                                    <thead>
                                        <tr role="row">
                                        	<th class="sorting_desc" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-sort="descending" aria-label="Deadline: activate to sort column descending" style="width: 40px;text-align: center;">목차</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Project: activate to sort column ascending" style="width: 350px;">문서 제목</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Deadline: activate to sort column ascending" style="width: 100px;">작성 기간</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Deadline: activate to sort column ascending" style="width: 80px;">중요도</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Lead: activate to sort column ascending" style="width: 67px;">작성자</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Team: activate to sort column ascending" style="width: 100px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;분류</th>
                                        	<th class="sorting" tabindex="0" aria-controls="DataTables_Table_0" rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending" style="width: 80px;text-align: center;">첨부파일</th>
                                       	</tr>
                                    </thead>
                                    <tbody style="cursor: pointer;">
                                        <c:forEach items="${docMyList}" var="doc">
	                                    	<tr role="row" class="odd" onclick="OpenWindow('<%=request.getContextPath()%>/doc/detail?docId=${doc.docId }&docType=mylist', 'JoinWorkGW', 1000, 700);">
	                                            <td style="text-align:center;">${doc.docId}</td>
	                                            <td class="project-title sorting_1">
	                                                <h6 style="display:inline-block;font-weight: bold;">${doc.docTitle }</h6>
	                                            </td>
	                                                	
	                                            <td><fmt:formatDate value="${doc.docCreateDt  }" pattern="yyyy.MM.dd"/></td>
	                                            <td>
	                                           		<c:choose>
	                                           			<c:when test="${doc.docImportance eq '1'}"><span class="button btn btn-default">일반</span></c:when>
	                                           			<c:when test="${doc.docImportance eq '2'}"><span class="button btn btn-success">&nbsp;&nbsp;관심&nbsp;&nbsp;</span></c:when>
	                                           			<c:when test="${doc.docImportance eq '3'}"><span class="button btn btn-danger">&nbsp;&nbsp;중요&nbsp;&nbsp;</span></c:when>
	                                           		</c:choose>
	                                            </td>
	                                            <td>${doc.empName } ${doc.officialName }(${doc.deptName }/${doc.teamName })</td>
	                                            <td>
	                                           		<c:choose>
	                                           			<c:when test="${doc.docIndividualCheck eq 'P'}">&nbsp;&nbsp;개인문서</c:when>
	                                           			<c:when test="${doc.docIndividualCheck eq 'O'}">단체문서</c:when>
	                                           			<c:when test="${doc.docIndividualCheck eq 'SYS'}">결재문서</c:when>
	                                           		</c:choose>
	                                            </td>
	                                            <td style="text-align:center;">
	                                    			<i class="fa fa-file-text fa-2x text-info"></i>
	                                    		</td>
	                                        </tr>
                                    	
                                    </c:forEach>
                                    <c:if test="${empty docMyList}">
                                    	<tr>
                                            <td colspan="6" style="text-align: center;"><strong>문서가 존재하지 않습니다.</strong></td>
                                        </tr>
									</c:if> 
                                	</tbody>
                                </table>
	                        </div>
	                        
	                        <!-- Pagination -->
			                      <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:5px;">
	                                <ul class="pagination" style="display: inline-block;">
	                                   	<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchDocList" />
	                                </ul>
	                             </nav>
								<form:hidden path="searchDocVO.pageIndex" />
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
	
	paginationCSS(${paginationInfo.currentPageNo},
			  ${paginationInfo.firstPageNoOnPageList},
			  ${paginationInfo.lastPageNoOnPageList},
			  ${paginationInfo.totalPageCount});
}


</script>
<script>
function docMainGo() {
	location.href="<%=request.getContextPath()%>/doc/main";
}

function wirteDoc() {
	alert("현재 스크립트가 사이드바jsp안에 있으며 이동 예정 통합 글쓰기 기능");
	
}

//검색 및 페이지네이션
function searchDocList(pageNo){
	if(!pageNo){
		pageNo = 1;
	}
	var listForm = $('form[name="listForm"]');
	$('input[name="searchDocVO.pageIndex"]').val(pageNo);
	listForm.submit();
}

</script>

<script>
window.addEventListener('load', function() {
	var navBar = $('.myDocList'); 
	navBar.addClass('active');
	  });
</script>