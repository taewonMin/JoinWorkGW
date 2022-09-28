<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<body>
<%@ include file="../include/sidebar.jsp" %>
<div id="main-content" >
	<div class="container-fluid" >
		<!-- 메인 content 넣는 곳 -->
          <div class="row clearfix" >
	           <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold" >
	               <h2>모든 결재 문서</h2>
	               <hr>
	           </div>
          </div>
                
		  <div class="row clearfix" style="font-family: S-CoreDream-7ExtraBold" >
                <div class="col-12" >
                	
                    <div class="card" >
	                  <form:form commandName="approvalFormVO" id="listForm" name="listForm">  
	                     <div class="body">
	                     	<!-- 검색 조건 설정 -->
                        	<h5 style="display:inline-block; font-weight: bold;">검색 조건</h5>
                        	<div class="alert alert-light" role="alert" style="display:inline-block;padding-top:0;margin-bottom:0;">
                        		<label class="fancy-checkbox">
                                    <input type="checkbox" data="selectDt" id="dateCheckBox" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                                    <span>기안 날짜</span>
                                </label>
                        		<label class="fancy-checkbox">
                                    <input type="checkbox" id="checkboxState" data="selectState" data-parsley-multiple="checkbox" onchange="changeForm(this);"/>
                                    <span>결재 상태</span>
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
	                                <form:input path="searchApprovalVO.searchDt" id="inputSearchDt" type="text" class="form-control" placeholder="완료날짜 선택" readonly="true"/>
	                                <div class="input-group-append">                                            
	                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
	                                </div>
	                            </div>
	                            <form:select path="searchApprovalVO.searchState" id="selectSearchState" class="form-control selectState myConditions" style="width:200px;font-size: 1.2em;margin-right:15px;float:left;display: none;">
							    	<form:option value="">결재 상태 선택</form:option>
							    	<form:option value="1">결재 진행중</form:option>
							    	<form:option value="2">결재 완료</form:option>
							    	<form:option value="3">결재 반려</form:option>
							  	</form:select>
	                            
							  	<form:select path="searchApprovalVO.searchCondition" class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
							    	<form:option value="ftd">전체</form:option>
								    <form:option value="f">양식</form:option>
								    <form:option value="t">제목</form:option>
								    <form:option value="d">문서번호</form:option>
							  	</form:select>
	                        	<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
	                        		<form:input path="searchApprovalVO.searchKeyword" class="form-control" placeholder="Search here..." type="text" style="width: 218px;height:36px;padding-right: 40px;" onkeypress="checkEnter(searchList);"/>
				                    <button type="button" class="btn btn-default" onclick="searchList();"><i class="icon-magnifier"></i></button>
				                </div>
				                
				                <div class="form-group" style="float:right;">
				                	<div style="display: inline-block;float:left;font-size: 1.2em;margin:6px 20px 0 0">
					                	<span>${paginationInfo.currentPageNo} </span>/<span> ${paginationInfo.totalPageCount} 페이지 중</span>
				                	</div>
					                <form:select path="searchApprovalVO.pageUnit" class="form-control" style="width:130px;font-size: 1.2em;" onchange="searchList(1);">
				       					<form:options items="${approvalFormVO.searchApprovalVO.pageUnitSelector}" itemValue="pageUnitValue" itemLabel="pageUnitLabel"/>
				       				</form:select>
								</div>
                        	</div>       
	                            
	                            
							<!-- 리스트시작 -->
	                            <div class="table-responsive" style="overflow: inherit;">
	                                <table class="table table-hover m-b-0 c_list">
	                                    <thead>
	                                        <tr>
	                                            <th>상신날짜</th>
	                                            <th>사용 양식</th>
	                                            <th>기안서 제목</th>
	                                            <th>첨부</th>
	                                            <th>문서번호</th>
	                                            <th>결재상태</th>
											</tr>
										</thead>
	                                   <tbody style="cursor: pointer;">
		                                    <c:forEach items="${approvalList }" var="doc">
<%-- 				                                    <tr onclick='OpenWindow("<%=request.getContextPath()%>/approval/completeDocDetail?docId="+${doc.docId}+"", "결재문서" ,1000,900);'> --%>
	                                          
	                                            	<c:set var="loop_flag1" value="false"/>
	                                            	<c:forEach items="${dataMap.waitDocs }" var="waitDoc">
                                          		    		<c:if test="${not loop_flag1}">
				                                            <c:if test="${waitDoc.docId eq doc.docId }" >
							                                    <tr onclick='OpenWindow("<%=request.getContextPath()%>/approval/waitDocDetail?docId="+${doc.docId}+"", "결재문서" ,1000,900);'>
				                                            	<c:set var="loop_flag1" value="true"/>
				                                            </c:if>
			                                            </c:if>
		                                            </c:forEach>
		                                            <c:if test="${not loop_flag1}" >
					                                    <tr onclick='OpenWindow("<%=request.getContextPath()%>/approval/completeDocDetail?docId="+${doc.docId}+"", "결재문서" ,1000,900);'>
		                                            </c:if>
		                                            
		                                            <td><fmt:formatDate value="${doc.approvalRecommandDt}" pattern="yyyy-MM-dd"/></td>
		                                            <td><span>${doc.formName}</span></td>
		                                            <td><span class="text-info">${doc.approvalTitle}</span></td>
		                                            <td>
			                                            <c:if test="${doc.attachCnt ne 0}">
			                                            	&nbsp<i class="fa fa-save"></i>&nbsp&nbsp${doc.attachCnt}
			                                            </c:if>
		                                            </td>
		                                            <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp${doc.docId}</td>
		                                            
	                                            		
			                                           <c:if test="${doc.approvalSt eq 1 }" >
			                                            	<c:set var="loop_flag2" value="false"/>
			                                            	<c:forEach items="${dataMap.waitDocs }" var="waitDoc">
	                                           		    		<c:if test="${not loop_flag2}">
						                                            <c:if test="${waitDoc.docId eq doc.docId }" >
						                                            	<td><span class="badge badge-info">결재대기중</span></td>
						                                            	<c:set var="loop_flag2" value="true"/>
						                                            </c:if>
					                                            </c:if>
				                                            </c:forEach>
				                                            <c:if test="${not loop_flag2}" >
				                                            	<td><span class="badge badge-success">결재진행중</span></td>
				                                            </c:if>
			                                            </c:if>
			                                            <c:if test="${doc.approvalSt eq 2 }" >
			                                            	<td><span class="badge badge-default">결재완료</span></td>
			                                            </c:if>
			                                            <c:if test="${doc.approvalSt eq 3 }" >
			                                            	<td><span class="badge-purple badge">결재반려</span></td>
			                                            </c:if>
		                                            
		                                        </tr>
		                                    </c:forEach>   
		                                    <c:if test="${empty approvalList}">
		                                    	<tr>
		                                            <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
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
                           <form:hidden path="searchApprovalVO.pageIndex" />
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
	$('input[name="searchApprovalVO.pageIndex"]').val(pageNo);
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


