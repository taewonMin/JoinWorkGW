<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  
<body>
<%@ include file="include/sidebar.jsp" %>



<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
		<!-- 메인 content 넣는 곳 -->
		  <div class="row clearfix" >
                <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
<!--                     <h2>전자 결재</h2> -->
                     <h2 style="font-family: S-CoreDream-6Bold"><i class="icon-note" ></i>&nbsp;전자 결재</h2>
                    <hr>
                </div>
                <c:if test="${not empty dataMap.forms }">
	                <div class="col-12 saveForms" style="font-family: S-CoreDream-4Regular">
	                    <h5>자주 쓰는 양식</h5>
	                </div>
                </c:if>
                
                <c:forEach items="${dataMap.forms }" var="form">
                <div class="col-lg-3 col-md-12 saveForm" style="font-family: InfinitySans-RegularA1;padding-right: 5px;">
                    <div class="card pricing3">
                        <div class="body">
                            <div class="pricing-option">
                                <i class="fa fa-file-o"></i>
                                <h5 style="padding-top: 5px;">${form.formName}</h5>
                                <hr>
                                <div class="m-t-30 m-b-30">
                                    <h6>양식번호 : ${form.formId}&nbsp&nbsp&nbsp</h6>
                                    <h6>양식분류 : ${form.formSupName}</h6>
                                </div>
                                <a href="javascript:void(0);" class="btn btn-outline-success" onclick="OpenWindow('docDetail?formId=${form.formId}','결재양식',900,900);">양식선택</a>
                                <a href="javascript:void(0);" class="btn btn-outline-danger" onclick="removeSaveForm(this);" value="${form.formId}">양식삭제</a>
                            </div>
                        </div>
                    </div>
                </div>
		  		</c:forEach>
		  		
		  </div> 
		  
		  <div class="row clearfix " style="font-family: S-CoreDream-4Regular" >
                <div class="col-lg-6 col-md-12" style="padding-right: 4px;">
                	
                    <div class="card" >
	                    <div class="header">
		                    <h5 >
		                    	결재 대기 문서
		                    	<span class="float-right" style="cursor: pointer; " onclick="location.href='<%=request.getContextPath()%>/approval/lists/waitList'">
		                    		<i class="fa fa-sign-in"></i>
		                    	</span>
		                    </h5>
		                    
	               		</div>
	                        <div class="body">
	                            <div class="table-responsive" style="overflow: hidden;">
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
		                                    <c:forEach items="${dataMap.docs }" var="doc" varStatus="status">
		                                    <fmt:parseNumber value="${today.time - doc.approvalRecommandDt.time }" integerOnly="true" var="defferTime"/>
		                                    	<c:if test="${status.count < 4}">
		                                    		<c:if test="${doc.approvalEmergencyYn eq 'Y' }">
			                                        	<tr class="xl-pink" onclick='OpenWindow("waitDocDetail?docId="+${doc.docId}+"", "결재문서" ,900,900);'>
			                                        </c:if>
			                                        <c:if test="${doc.approvalEmergencyYn ne 'Y' }">
			                                        	<tr onclick='OpenWindow("waitDocDetail?docId="+${doc.docId}+"", "결재문서" ,900,900);'>
			                                        </c:if>
			                                            <td><fmt:formatDate value="${doc.approvalRecommandDt}" pattern="yyyy-MM-dd"/></td>
			                                            <td><span>${doc.formName}</span></td>
			                                            <td>
			                                            	<c:if test="${doc.approvalEmergencyYn eq 'Y' }">
				                                            	<span class="text-info" style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
				                                            		[긴급]&nbsp${doc.approvalTitle}
				                                            	</span>
			                                            	</c:if>
			                                            	<c:if test="${doc.approvalEmergencyYn ne 'Y' }">
			                                            		<span class="text-info" style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">
				                                            		${doc.approvalTitle}
				                                            	</span>
			                                            	</c:if>
			                                            	
			                                            	<c:if test="${defferTime <= (1000*60*30) }">
		                                                  		&nbsp<span class="badge badge-danger">방금전</span>
		                                                  	</c:if>
			                                            </td>
			                                            <td>
			                                            <c:if test="${doc.attachCnt != 0}">
			                                            &nbsp<i class="fa fa-save">&nbsp&nbsp${doc.attachCnt }</i>
			                                            </c:if>
			                                            </td>
			                                            <td>${doc.docId}</td>
			                                            <td><span class="badge badge-primary">결재대기</span></td>
			                                        </tr>
			                                    </c:if>
		                                    </c:forEach> 
		                                    <c:if test="${empty dataMap.docs}">
		                                    	<tr>
		                                            <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
		                                        </tr>
		                                    </c:if>  
	                                        
	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
	                    </div>
                    <div class="card">
	                    <div class="header">
		                    <h5>
		                    	기안 문서함
		                    	<span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/draftList'">
		                    		<i class="fa fa-sign-in"></i>
		                    	</span>
		                    </h5>
	               		</div>
	                        <div class="body">
	                            <div class="table-responsive" style="overflow: hidden;">
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
		                                    <c:forEach items="${dataMap.draftDocs }" var="doc" varStatus="status">
		                                    	<fmt:parseNumber value="${today.time - doc.approvalRecommandDt.time }" integerOnly="true" var="defferTime"/>
		                                    	<c:if test="${status.count < 4}">
			                                        <tr onclick='OpenWindow("<%=request.getContextPath()%>/approval/completeDocDetail?docId="+${doc.docId}+"", "결재문서" ,900,900);'>
			                                            <td><fmt:formatDate value="${doc.approvalRecommandDt}" pattern="yyyy-MM-dd"/></td>
			                                            <td><span>${doc.formName}</span></td>
			                                            <td>
			                                            	<span class="text-info" style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${doc.approvalTitle}</span>
			                                            	<c:if test="${defferTime <= (1000*60*30) }">
		                                                  		&nbsp<span class="badge badge-danger">방금전</span>
		                                                  	</c:if>
			                                            </td>
			                                            <td>
			                                            <c:if test="${doc.attachCnt != 0}">
			                                            &nbsp<i class="fa fa-save">&nbsp&nbsp${doc.attachCnt }</i>
			                                            </c:if>
			                                            </td>
			                                            <td>${doc.docId}</td>
			                                            <c:if test="${doc.approvalSt eq 1 }" >
			                                            <td><span class="badge badge-success">결재진행중</span></td>
			                                            </c:if>
			                                            <c:if test="${doc.approvalSt eq 2 }" >
			                                            <td><span class="badge badge-default">결재완료</span></td>
			                                            </c:if>
			                                            <c:if test="${doc.approvalSt eq 3 }" >
			                                            <td><span class="badge-purple badge">결재반려</span></td>
			                                            </c:if>
			                                            
			                                        </tr>
		                                        </c:if>
		                                    </c:forEach>   
	                                        <c:if test="${empty dataMap.draftDocs}">
		                                    	<tr>
		                                            <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
		                                        </tr>
		                                    </c:if>
	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="card">
                    <div class="header">
	                    <h5>
	                    	수신 문서함
	                    	<span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/receptionList'">
	                    		<i class="fa fa-sign-in"></i>
	                    	</span>
	                    </h5>
               		</div>
                         
                        <div class="body">
                            <div class="table-responsive" style="overflow: hidden;">
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
                                    <c:forEach items="${dataMap.receptionDocs }" var="doc" varStatus="status">
                                    <fmt:parseNumber value="${today.time - doc.approvalRecommandDt.time }" integerOnly="true" var="defferTime"/>
                                    	<c:if test="${status.count < 4}">
	                                        <tr onclick='OpenWindow("<%=request.getContextPath()%>/approval/completeDocDetail?docId="+${doc.docId}+"", "결재문서" ,900,900);'>
	                                            <td><fmt:formatDate value="${doc.approvalRecommandDt}" pattern="yyyy-MM-dd"/></td>
	                                            <td>
	                                            	<span>${doc.formName}</span>
	                                            	<c:if test="${defferTime <= (1000*60*30) }">
                                                  		&nbsp<span class="badge badge-danger">방금전</span>
                                                  	</c:if>
	                                            </td>
	                                            <td><span class="text-info" style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${doc.approvalTitle}</span></td>
	                                            <td>
	                                            <c:if test="${doc.attachCnt != 0}">
	                                            &nbsp<i class="fa fa-save">&nbsp&nbsp${doc.attachCnt }</i>
	                                            </c:if>
	                                            </td>
	                                            <td>${doc.docId}</td>
	                                            <td><span class="badge badge-info">수신</span></td>
	                                        </tr>
	                                    </c:if>
                                    </c:forEach>   
                                    <c:if test="${empty dataMap.receptionDocs}">
                                    	<tr>
                                            <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
                                        </tr>
		                            </c:if>     
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
	                    
	                    
                    </div>
                    <div class="col-lg-6 col-md-12" style="padding-right: 4px;">
                    <div class="card">
                    <div class="header">
	                    <h5>
	                    	결재 종료 문서
	                    	<span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/completeList'">
	                    		<i class="fa fa-sign-in"></i>
	                    	</span>
	                    </h5>
               		</div>
                         
                        <div class="body">
                            <div class="table-responsive" style="overflow: hidden;">
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
                                    <c:forEach items="${dataMap.completeDocs }" var="doc" varStatus="status">
                                    	<fmt:parseNumber value="${today.time - doc.approvalRecommandDt.time }" integerOnly="true" var="defferTime"/>
                                    	<c:if test="${status.count < 4}">
	                                        <tr onclick='OpenWindow("completeDocDetail?docId="+${doc.docId}+"", "결재문서" ,900,900);'>
	                                            <td><fmt:formatDate value="${doc.approvalRecommandDt}" pattern="yyyy-MM-dd"/></td>
	                                            <td><span>${doc.formName}</span></td>
	                                            <td>
	                                            	<span class="text-info" style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${doc.approvalTitle}</span>
	                                            	<c:if test="${defferTime <= (1000*60*30) }">
                                                  		&nbsp<span class="badge badge-danger">방금전</span>
                                                  	</c:if>
	                                            </td>
	                                            <td>
	                                            <c:if test="${doc.attachCnt != 0}">
	                                            &nbsp<i class="fa fa-save">&nbsp&nbsp${doc.attachCnt }</i>
	                                            </c:if>
	                                            </td>
	                                            <td>${doc.docId}</td>
	                                            <c:if test="${doc.approvalSt eq 2 }" >
	                                            <td><span class="badge badge-default">결재완료</span></td>
	                                            </c:if>
	                                            <c:if test="${doc.approvalSt eq 3 }" >
	                                            <td><span class="badge-purple badge">결재반려</span></td>
	                                            </c:if>
	                                            
	                                        </tr>
	                                    </c:if>
                                    </c:forEach>   
                                    <c:if test="${empty dataMap.completeDocs}">
                                    	<tr>
                                            <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
                                        </tr>
		                            </c:if>    
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                    <div class="header">
	                    <h5>
	                    	임시 저장함
	                    	<span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/tempList'">
	                    		<i class="fa fa-sign-in"></i>
	                    	</span>
	                    </h5>
               		</div>
                         
                        <div class="body">
                            <div class="table-responsive" style="overflow: hidden;">
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
                                    <c:forEach items="${dataMap.tempDocs }" var="doc" varStatus="status">
                                    	<fmt:parseNumber value="${today.time - doc.approvalRecommandDt.time }" integerOnly="true" var="defferTime"/>
                                    	<c:if test="${status.count < 4}">
	                                        <tr onclick="OpenWindow('docDetail?docId=${doc.docId}&from=temp','결재양식',900,900);">
	                                            <td><fmt:formatDate value="${doc.approvalRecommandDt}" pattern="yyyy-MM-dd"/></td>
	                                            <td><span>${doc.formName}</span></td>
	                                            <td>
	                                            	<span class="text-info" style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${doc.approvalTitle}</span>
	                                            	<c:if test="${defferTime <= (1000*60*30) }">
                                                  		&nbsp<span class="badge badge-danger">방금전</span>
                                                  	</c:if>
	                                            </td>
	                                            <td>
	                                            <c:if test="${doc.attachCnt != 0}">
	                                            &nbsp<i class="fa fa-save">&nbsp&nbsp${doc.attachCnt }</i>
	                                            </c:if>
	                                            </td>
	                                            <td>${doc.docId}</td>
	                                            <td><span class="badge badge-warning">임시저장</span></td>
	                                        </tr>
	                                    </c:if>
                                    </c:forEach>   
                                    <c:if test="${empty dataMap.tempDocs}">
                                    	<tr>
                                            <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
                                        </tr>
		                            </c:if>     
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                    <div class="header">
	                    <h5>
	                    	참조 문서함
	                    	<span class="float-right" style="cursor: pointer;" onclick="location.href='<%=request.getContextPath()%>/approval/lists/referList'">
	                    		<i class="fa fa-sign-in"></i>
	                    	</span>
	                    </h5>
               		</div>
                         
                        <div class="body">
                            <div class="table-responsive" style="overflow: hidden;">
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
                                    <c:forEach items="${dataMap.referDocs }" var="doc" varStatus="status">
                                    	<fmt:parseNumber value="${today.time - doc.approvalRecommandDt.time }" integerOnly="true" var="defferTime"/>
                                    	<c:if test="${status.count < 4}">
	                                        <tr onclick='OpenWindow("<%=request.getContextPath()%>/approval/completeDocDetail?docId="+${doc.docId}+"", "결재문서" ,900,900);'>
	                                            <td><fmt:formatDate value="${doc.approvalRecommandDt}" pattern="yyyy-MM-dd"/></td>
	                                            <td><span>${doc.formName}</span></td>
	                                            <td>
	                                            	<span class="text-info" style="display: inline-block;font-weight: bold;max-width: 155px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${doc.approvalTitle}</span>
	                                            	<c:if test="${defferTime <= (1000*60*30) }">
                                                  		&nbsp<span class="badge badge-danger">방금전</span>
                                                  	</c:if>
	                                            </td>
	                                            <td>
	                                            <c:if test="${doc.attachCnt != 0}">
	                                            &nbsp<i class="fa fa-save">&nbsp&nbsp${doc.attachCnt }</i>
	                                            </c:if>
	                                            </td>
	                                            <td>${doc.docId}</td>
	                                            <td><span class="badge badge-info">참조</span></td>
	                                        </tr>
	                                    </c:if>
                                    </c:forEach>   
                                    <c:if test="${empty dataMap.referDocs}">
                                    	<tr>
                                            <td colspan="6" style="text-align: center;"><strong>해당 결재문서가 존재하지 않습니다.</strong></td>
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
</div>


<script>


function removeSaveForm(obj){
	var saveForm = $(obj).parent().parent().parent().parent();
	var formId = $(obj).attr("value");
	saveForm.remove();
	
	if(!$("div").hasClass("saveForm")){
		$(".saveForms").remove();
	}
	console.log(formId);
	$.ajax({
		type:"POST",
		url:"removeSaveForm",
		contentType:"application/json",
	 	data : formId,
		processData:true,
		success: function(data) {
			console.log("성공");
			
		},
		error: function(e) {
			console.log(e);
		}
	
	});
	window.location.reload();	
	
	
}



</script>




</body>