<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  
<jsp:include page="sidebar.jsp" />  

<!-- 사이드바 -->


<style>
.tdStyle{
	display: inline-block;
	font-weight: bold;
	max-width: 150px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}
</style>
<body>
<!-- 메인 content -->
<div id="main-content">	
		  <div class="">
<!--                 통합 조회	 -->
				<div class="row clearfix">
		               <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold" >
		                   <h2 style="font-size: 2rem; padding-left: 15px;"><i class="icon-home"></i>&nbsp;문서 홈</h2> 
		                   <!-- color:#0B2161; -->
		                   <hr>
		               </div>
			 	</div>
                 <div class="card" style="font-family: S-CoreDream-4Regular">
                  <div class="header" style="padding-bottom: 0px;">
                  <a href="#"><h5>중요 문서</h5></a> 
             		</div>
                      <div class="body" style="padding-top: 0px;">
                          <div class="table-responsive">
                              <table class="table table-hover m-b-0 c_list">
                                  <thead>
                                      <tr>
                                          <th>등록일</th>
                                          <th style="min-width: 200px">제목</th>
                                          <th>내용</th>
                                          <th>작성자</th>
                                          <th style="padding-left: 22px;">중요도</th>
                                          <th>첨부파일</th>
                                          <th>조회수</th>
                                      </tr>
                                  </thead>
                                  <tbody style="cursor: pointer;">
                                  	<c:forEach items="${docAllList }" var="doc" varStatus="status">
		                                    	<c:if test="${status.count <6}">
		                                    		<c:if test="${doc.docImportance eq '3'}">
			                                        <tr role="row" class="odd" onclick="OpenWindow('<%=request.getContextPath()%>/doc/detail?docId=${doc.docId }&docType=deptlist', 'JoinWorkGW', 1000, 700);">
			                                            <td><fmt:formatDate value="${doc.docCreateDt  }" pattern="yyyy.MM.dd"/></td>
			                                            <td><span class="text-info tdStyle">${doc.docTitle }</span></td>
			                                            <td><span class="text-info tdStyle">${doc.docContent}</span></td>
			                                            <td><span>${doc.empName}(${doc.deptName}/${doc.teamName})</span></td>
			                                            <td>
			                                            	<c:choose>
			                                            		<c:when test="${doc.docImportance eq '3'}"><span class="button btn btn-danger">&nbsp;&nbsp;중요&nbsp;&nbsp;</span></c:when>
			                                            	</c:choose>
			                                            </td>
			                                            <td> &nbsp<i class="fa fa-save"></i></td>
			                                            <td><span class="badge badge-primary">${doc.docReadcnt }</span></td>
			                                        </tr>
			                                    </c:if>
			                                    </c:if>
		                            </c:forEach> 
                                   	<c:if test="${empty docMyList}">
                                    	<tr>
                                            <td colspan="6" style="text-align: center;"><strong>문서가 존재하지 않습니다.</strong></td>
                                        </tr>
									</c:if> 
                                  </tbody>
                              </table>
                          	</div>
                      	</div>
                  	</div>
                 </div>
                 
                 
<!-- 			복합 목록                  -->
		  <div class="row clearfix" style="font-family: S-CoreDream-4Regular">
                <div class="col-lg-6 col-md-12">
                	
                    <div class="card" style="height: 300px;">
	                    <div class="header" style="padding-bottom: 0px;">
		                   <a href="<%=request.getContextPath()%>/doc/mylist"><h5>내 개인 문서</h5></a> 
	               		</div>
	                        <div class="body" style="padding-top: 0px;">
	                            <div class="table-responsive">
	                                <table class="table table-hover m-b-0 c_list">
	                                    <thead>
	                                        <tr>
	                                            <th>등록일</th>
	                                            <th>제목</th>
	                                            <th>내용</th>
	                                            <th>작성자</th>
	                                            <th>조회수</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody style="cursor: pointer;">
		                                    <c:forEach items="${docMyList }" var="doc" varStatus="status">
		                                    	<c:if test="${status.count < 4}">
			                                        <tr role="row" class="odd" onclick="OpenWindow('<%=request.getContextPath()%>/doc/detail?docId=${doc.docId }&docType=deptlist', 'JoinWorkGW', 1000, 700);">
			                                            <td><fmt:formatDate value="${doc.docCreateDt  }" pattern="yyyy.MM.dd"/></td>
			                                            <td><span class="text-info tdStyle">${doc.docTitle }</span></td>
			                                            <td><span class="text-info tdStyle">${doc.docContent}</span></td>
			                                            <td><span>${doc.empName}(${doc.deptName}/${doc.teamName})</span></td>
			                                            <td><span class="badge badge-primary">${doc.docReadcnt }</span></td>
			                                        </tr>
			                                    </c:if>
		                                    </c:forEach> 
		                                    <c:if test="${empty docMyList}">
		                                    	<tr>
		                                            <td colspan="6" style="text-align: center;"><strong>문서가 존재하지 않습니다.</strong></td>
		                                        </tr>
		                                    </c:if>  
	                                        
	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
	                    </div>
                    <div class="card" style="height: 300px;">
	                    <div class="header" style="padding-bottom: 0px;">
		                     <a href="<%=request.getContextPath()%>/doc/teamlist"><h5>팀 문서</h5></a>
	               		</div>
	                        <div class="body" style="padding-top: 0px;">
	                            <div class="table-responsive">
	                                <table class="table table-hover m-b-0 c_list">
	                                    <thead>
	                                        <tr>
	                                            <th>등록일</th>
	                                            <th>제목</th>
	                                            <th>내용</th>
	                                            <th>작성자</th>
	                                            <th>조회수</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody style="cursor: pointer;">
		                                    <c:forEach items="${docMyTeamList }" var="doc" varStatus="status">
		                                    	<c:if test="${status.count < 4}">
			                                        <tr role="row" class="odd" onclick="OpenWindow('<%=request.getContextPath()%>/doc/detail?docId=${doc.docId }&docType=deptlist', 'JoinWorkGW', 1000, 700);">
			                                            <td><fmt:formatDate value="${doc.docCreateDt  }" pattern="yyyy.MM.dd"/></td>
			                                            <td><span class="text-info tdStyle">${doc.docTitle }</span></td>
			                                            <td><span class="text-info tdStyle">${doc.docContent}</span></td>
			                                            <td><span>${doc.empName}(${doc.deptName}/${doc.teamName})</span></td>
			                                            <td><span class="badge badge-primary">${doc.docReadcnt }</span></td>
			                                        </tr>
			                                    </c:if>
		                                    </c:forEach> 
		                                    <c:if test="${empty docMyTeamList}">
		                                    	<tr>
		                                            <td colspan="6" style="text-align: center;"><strong>문서가 존재하지 않습니다.</strong></td>
		                                        </tr>
		                                    </c:if>  
	                                        
	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <div class="col-lg-6 col-md-12">
                    <div class="card" style="height: 300px;">
                    <div class="header" style="padding-bottom: 0px;">
	                     <a href="<%=request.getContextPath()%>/doc/approvallist"><h5>결재 양식 문서</h5></a>
               		</div>
                         
                        <div class="body" style="padding-top: 0px;">
                            <div class="table-responsive">
                                <table class="table table-hover m-b-0 c_list">
                                    <thead>
                                        <tr>
                                            <th>등록일</th>
                                            <th>제목</th>
                                            <th>내용</th>
                                            <th>작성자</th>
                                            <th>조회수</th>
                                        </tr>
                                    </thead>
                                    <tbody style="cursor: pointer;">
                                    <c:forEach items="${docMyApprovalList }" var="doc">
                                        <tr onclick="OpenWindow('<%=request.getContextPath()%>/doc/detail?docId=${doc.docId }&docType=deptlist', 'JoinWorkGW', 1000, 700);">
                                            <td><fmt:formatDate value="${doc.docCreateDt }" pattern="yyyy-MM-dd"/></td>
                                            <td><span class="text-info tdStyle">${doc.docTitle }</span></td>
                                            <td><span class="text-info tdStyle">${doc.docContent}</span></td>
                                            <td><span>${doc.empName }(${doc.deptName}/${doc.teamName})</span></td>
                                            <td><span class="badge badge-primary">${doc.docReadcnt }</span></td>
<%--                                             <c:if test="" > --%>
<!--                                             <td><span class="badge badge-default">결재완료</span></td> -->
<%--                                             </c:if> --%>
<%--                                             <c:if test="" > --%>
<!--                                             <td><span class="badge-purple badge">결재반려</span></td> -->
<%--                                             </c:if> --%>
                                            
                                        </tr>
                                    </c:forEach>   
                                    <c:if test="">
                                    	<tr>
                                            <td colspan="6" style="text-align: center;"><strong>문서가 존재하지 않습니다.</strong></td>
                                        </tr>
		                            </c:if>    
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card" style="height: 300px;">
                    <div class="header" style="padding-bottom: 0px;">
	                    <a href="<%=request.getContextPath()%>/doc/deptlist"><h5>부서 문서</h5></a>
               		</div>
                         
                        <div class="body" style="padding-top: 0px;">
                            <div class="table-responsive">
                                <table class="table table-hover m-b-0 c_list">
                                    <thead>
                                        <tr>
                                            <th>등록일</th>
                                            <th>제목</th>
                                            <th>내용</th>
                                            <th>작성자</th>
                                            <th>조회수</th>
                                        </tr>
                                    </thead>
                                    <tbody style="cursor: pointer;">
		                                    <c:forEach items="${docMyDeptList }" var="doc" varStatus="status">
		                                    	<c:if test="${status.count < 4}">
			                                        <tr role="row" class="odd" onclick="OpenWindow('<%=request.getContextPath()%>/doc/detail?docId=${doc.docId }&docType=deptlist', 'JoinWorkGW', 1000, 700);">
			                                            <td><fmt:formatDate value="${doc.docCreateDt  }" pattern="yyyy.MM.dd"/></td>
			                                            <td><span class="text-info tdStyle">${doc.docTitle }</span></td>
			                                            <td><span class="text-info tdStyle">${doc.docContent}</span></td>
			                                            <td><span>${doc.empName}(${doc.deptName}/${doc.teamName})</span></td>
			                                            <td><span class="badge badge-primary">${doc.docReadcnt }</span></td>
			                                        </tr>
			                                    </c:if>
		                                    </c:forEach> 
		                                    <c:if test="${empty docMyDeptList}">
		                                    	<tr>
		                                            <td colspan="6" style="text-align: center;"><strong>문서가 존재하지 않습니다.</strong></td>
		                                        </tr>
		                                    </c:if>  
	                                        
	                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
	</div>


<script>
function docMainGo(){
	location.href="<%=request.getContextPath()%>/doc/main";
}


</script>
<script>
window.onload = function(){
	var navBar = $('.docHome'); 
	navBar.addClass('active');
	  }
</script>
</body>