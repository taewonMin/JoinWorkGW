
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>



<body>    
<jsp:include page="../boardSidebar.jsp" />

<!-- 메인 content -->
<div id="main-content" style="font-family: S-CoreDream-7ExtraBold">
   <div class="container-fluid">
      <!-- 메인 content 넣는 곳 -->
      <div class="row clearfix">
              <div class="col-12" style="margin-top: 2%;">
                  <h2 style="display:inline;font-family: S-CoreDream-6Bold; "><i class="fa fa-check-square-o"></i>&nbsp설문 게시판</h2>
                  <c:if test="${loginUser.empId eq '201006JW0205' }">
                  	<button class="float-right" style="font-family:paybooc-Bold; background-color: #2980b9; color: white; border: 0px; width: 10%; height: 3rem; border-radius: 5%;" onclick="OpenWindow('<%=request.getContextPath()%>/board/qt/registForm','설문 등록',1000,700);">설문 작성</button>
              	  </c:if>
              	<hr>
              </div>
          </div>
                
        <div class="row clearfix">
                <div class="col-12">
                   
                    <div class="card">
                     <form:form commandName="boardFormVO" id="listForm" name="listForm">  
                        <div class="body">
                           <!-- 검색 조건 설정 -->
                           <h5 style="display:inline-block; font-weight: bold;">검색 조건</h5>
                           <div class="alert alert-light" role="alert" style="display:inline-block;padding-top:0;margin-bottom:0;">
                           <label class="fancy-checkbox">
                                 <input type="checkbox" data="selectDt" id="dateCheckBox" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                                 <span>설문 날짜</span>
                           </label>
                           <label class="fancy-checkbox">
                                 <input type="checkbox" id="checkboxState" data="selectState" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                                 <span>진행 상태</span>
                           </label>
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
                                <form:input path="searchQtVO.searchDt" id="inputSearchDt" type="text" class="form-control" placeholder="설문종료날짜 선택" readonly="true"/>
                                <div class="input-group-append">                                            
                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
                                </div>
                            </div>
                           <form:select path="searchQtVO.searchState" id="selectSearchState" class="form-control selectState myConditions" style="width:200px;font-size: 1.2em;margin-right:15px;float:left;display: none;">
                            <form:option value="">설문 상태 선택</form:option>
                            <form:option value="Y">설문 진행중</form:option>
                            <form:option value="N">설문 종료</form:option>
                          </form:select>
                               
                          <form:select path="searchQtVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
                            <form:option value="ntm">전체</form:option>
                            <form:option value="n">설문번호</form:option>
                            <form:option value="t">제목</form:option>
                            <form:option value="m">작성자</form:option>
                          </form:select>
                              <div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
                                 <form:input path="searchQtVO.searchKeyword" class="form-control" placeholder="검색어를 입력하세요" type="text" style="width: 218px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchList);"/>
                                <button type="button" class="btn btn-default" onclick="searchList();"><i class="icon-magnifier"></i></button>
                            </div>
                            
                            <div class="form-group" style="float:right;">
                               <div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
                                  <span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>
                               </div>
                               <form:select path="searchQtVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchList(1);">
                                  <form:options items="${boardFormVO.searchQtVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
                               </form:select>
                        </div>
                           </div>       
                               
                               
                     			<!-- 리스트시작 -->
                               <div class="table-responsive">
                                   <table class="table table-hover m-b-0 c_list">
                                       <thead class="shadow-none p-3 mb-5 bg-light rounded">
                                           <tr>
                                               <th>설문번호</th>
                                               <th>제목</th>
                                               <th>기간</th>
                                               <th>작성자</th>
                                               <th class="text-center">조회수</th>
                                               <th>상태</th>
                                           </tr>
                                       </thead>
                                      <tbody style="cursor: pointer;">
                                      <fmt:parseNumber value="${today.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
                                          
                                          <c:forEach items="${qtList }" var="qt">
                                              <tr onclick="OpenWindow('<%=request.getContextPath()%>/board/qt/detail?qtBoardId=${qt.qtBoardId}', '설문 상세', 1000, 700);">
												  <fmt:parseNumber value="${today.time - qt.qtBoardCreateDt.time }" integerOnly="true" var="defferTime"/>
                                                  
                                                  <td><span>&nbsp&nbsp&nbsp${qt.qtBoardId}</span></td>
                                                  <td>
                                                  	<span>${qt.qtBoardTitle}</span>
                                                  	<c:if test="${defferTime <= (1000*60*30) }">
                                                  		&nbsp<span class="badge badge-danger">방금전</span>
                                                  	</c:if>
                                                  </td>
                                                  <td>
													
													<fmt:parseNumber value="${qt.qtBoardEndDt.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
                                                  	
                                                  	<fmt:formatDate value="${qt.qtBoardStartDt}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${qt.qtBoardEndDt}" pattern="yyyy-MM-dd"/>
				                                    
				                                    
                                                  	<c:if test="${(endDate-strDate) < 3 && (endDate-strDate) >= 0 && qt.qtBoardStYn == 'Y'}">
                                                  		<span class="badge badge-danger">마감임박</span>
                                                  	</c:if>

                                                  </td>
                                                  <td>${qt.empName }&nbsp${qt.officialName }</td>
                                                  <td class="text-center">${qt.qtBoardReadcnt }</td>
                                                  <c:if test="${qt.qtBoardStYn == 'Y'}">
                                                     <td><span class="badge badge-success">설문 진행중</span></td>
                                                  </c:if>
                                                  <c:if test="${qt.qtBoardStYn == 'N'}">
                                                     <td><span class="badge badge-default">설문 종료</span></td>
                                                  </c:if>
                                              </tr>
                                          </c:forEach>   
                                          <c:if test="${empty qtList}">
                                             <tr>
                                                  <td colspan="6" style="text-align: center;"><strong>해당 설문게시물이 존재하지 않습니다.</strong></td>
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
                           <form:hidden path="searchQtVO.pageIndex" />
                       </form:form>
                          
                    </div>
             </div>
        </div>
      
   </div>
</div>
<script>
window.onload = function() {
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
$('input[name="searchQtVO.pageIndex"]').val(pageNo);
   listForm.submit();
}

function conditionReset() {
   $("#resetBtn").click();
   $('.myConditions').css('display','none');
   $("input:checkbox:checked").click();
   $("#inputSearchDt").val("");
}






</script>
</body>