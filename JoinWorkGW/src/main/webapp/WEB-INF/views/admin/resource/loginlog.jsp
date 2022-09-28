<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- 메인 content -->
<div class="container-fluid">
	<div class="row clearfix">
        <div class="col-lg-12">
            <div class="card">
                <div class="header">
               	   <span style="color: #a9a9a9; font-family: S-CoreDream-4Regular">자원 관리</span><br>
                   <h3 style="display:inline-block; font-family: S-CoreDream-6Bold">사용자 로그인 기록</h3>
                   <span style="font-size: 1.3em;color: rgb(0,0,0,0.5);font-weight: bold;margin-left: 15px; font-family: S-CoreDream-4Regular ">최근 3개월간 로그인 기록을 조회할 수 있습니다.</span>
                   <div class="row clearfix">
		                <div class="col-lg-12 col-md-12">
		                    <div class="card" style="font-family: S-CoreDream-6Bold">
		                        <div class="body">
		                        	<div class="table-responsive">
				                        <table class="table table-hover js-basic-example dataTable table-custom table-striped m-b-0 c_list">
				                            <thead class="thead-dark">
				                                <tr>
				                                    <th>최근접속날짜</th>
				                                    <th>사원번호</th>
				                                    <th>접속IP주소</th>
				                                    <th>결과</th>
				                                </tr>
				                            </thead>
				                            <tbody>
				                            	<c:forEach items="${loginLogList}" var="log">
				                            	
					                                <tr>
					                                    <td>${log.split(',')[1] }</td>
					                                    <td>${log.split(',')[2] }</td>
					                                    <td>${log.split(',')[3] }</td>
					                                    <td>${log.split(',')[4] }</td>
					                                </tr>
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

<form name="fileForm" action='<c:url value="/common/getFile"/>' method="post">
	<input type="hidden" name="fileUploadPath" value="${fileName }">
</form>

<script>
window.onload=function(){
	$('.dataTables_length').append($('<a href="#" onclick="fileDownload();" style="font-size:1.2em;margin-left:15px;"><i class="fa fa-download" ></i> 로그인 기록 다운로드</a>'))
}

function fileDownload(){
	$('form[name="fileForm"]').submit();
}
</script>