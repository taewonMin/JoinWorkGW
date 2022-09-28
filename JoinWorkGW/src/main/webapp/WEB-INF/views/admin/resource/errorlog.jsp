<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 메인 content -->
<div class="container-fluid">
	<div class="row clearfix">
        <div class="col-lg-12">
            <div class="card">
                <div class="header">
               	   <span style="color: #a9a9a9; font-family: S-CoreDream-4Regular">자원 관리</span><br>
                   <h3 style="display:inline-block; font-family: S-CoreDream-6Bold">에러 로그 조회</h3>
                   <span style="font-size: 1.3em;color: rgb(0,0,0,0.5);font-weight: bold;margin-left: 15px; font-family: S-CoreDream-4Regular">에러 로그 파일은 3개월간 저장됩니다.</span>
                   <div class="row clearfix">
		                <div class="col-lg-12 col-md-12">
		                    <div class="card" style="font-family: S-CoreDream-6Bold">
		                        <div class="body">
		                        	<div class="table-responsive">
				                        <table class="table table-hover js-basic-example dataTable table-custom table-striped m-b-0 c_list">
				                            <thead class="thead-dark">
				                                <tr>
				                                    <th>날짜</th>
				                                    <th>HTTP상태코드</th>
				                                    <th>에러종류</th>
				                                    <th>에러내용</th>
				                                </tr>
				                            </thead>
				                            <tbody>
				                            	<c:forEach items="${errorLogList}" var="log">
				                            		<c:if test="${fn:length(log.split(',')[1]) > 10}">
						                                <tr>
						                                    <td>${log.split(',')[1] }</td>
						                                    <td>${log.split(',')[2] }</td>
						                                    <td>${log.split(',')[3].split(':')[0] }</td>
						                                    <td>${log.split(',')[3].split(':')[1] }</td>
						                                </tr>
				                            		</c:if>
				                                </c:forEach>
				                            </tbody>
				                        </table>
				                    </div>
			                    </div>
			                </div>
			            </div>
		            </div>
                </div>
         	</div>
        </div>
    </div>
</div>

<form name="fileForm" action='<c:url value="/common/getFile" />' method="post">
	<input type="hidden" name="fileUploadPath" value="${fileName }">
</form>

<script>
window.onload=function(){
	$('.dataTables_length').append($('<a href="#" onclick="fileDownload();" style="font-size:1.2em;margin-left:15px;"><i class="fa fa-download" ></i> 에러 로그 파일 다운로드</a>'))
}

function fileDownload(){
	$('form[name="fileForm"]').submit();
}
</script>