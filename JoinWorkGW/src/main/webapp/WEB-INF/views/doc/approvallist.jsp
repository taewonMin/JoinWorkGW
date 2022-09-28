<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:include page="sidebar.jsp" />

<body>


            <div id="main-content">
                <div class="container-fluid">

                   <div class="row clearfix">
		                <div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-6Bold">
		                    <h2><i class="fa fa-navicon"></i>&nbsp;결재 문서</h2>
		                    <hr>
		                </div>
				 	</div>
                    <div class="row clearfix ">
                        <div class="col-12">
                            <div class="card mb-4" style="font-family: S-CoreDream-7ExtraBold">
                                <div class="card-body">
	                                 <div class="body project_report">
			                        	<!-- 검색 조건 설정 -->
			                        	
			                        	<!-- 설정된 검색 조건 입력 폼 표시 -->
			                        
										  	<select class="form-control selectSearch" style="width:130px;font-size: 1.2em;float:left;">
										    	<option>전체</option>
											    <option value="title">제목</option>
											    <option value="content">내용</option>
											    <option value="person">담당자</option>
										  	</select>
				                        	<div id="navbar-search" class="navbar-form search-form selectSearch" style="float:left;">
							                    <input value="" class="form-control" placeholder="Search here..." type="text" style="width: 218px;height:36px;padding-right: 40px;">
							                    <button type="button" class="btn btn-default"><i class="icon-magnifier"></i></button>
							                </div>
							                
							                <div class="form-group" style="float:right;">
												<select class="form-control" style="width:130px;font-size: 1.2em;">
											    	<option>폼옵션으로 변경</option>
											  	</select>
											</div>
			                        	</div>
                                    <table id="holidays_list" class="table table-hover">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th>목차</th>
                                                <th>결재 분류</th>
                                                <th>결재 문서 제목</th>
                                                <th>작성자</th>
                                                <th>첨부파일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                       		<tr role="row" class="odd">
	                                            <td>1</td>
	                                            <td>휴가</td>
	                                            <td class="project-title sorting_1">
	                                                <h6 style="display:inline-block;font-weight: bold;">휴가 결재 양식</h6>
	                                                <small>2021.04.04</small>
	                                            </td>
	                                            <td>(내사진)</td>
	                                            <td>
	                                    			<i class="fa fa-file-text fa-2x text-info"></i>
	                                    		</td>
	                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
</body>
<script>
function docMainGo() {
	location.href="<%=request.getContextPath()%>/doc/main";

}

function wirteDoc() {
	alert("현재 스크립트가 사이드바jsp안에 있으며 이동 예정 통합 글쓰기 기능");
	
}
</script>
<script>
window.onload = function(){
	var navBar = $('.docApprovalList'); 
	navBar.addClass('active');
	  }
	  
// window.addEventListener('load', function() {
// 	var navBar = $('.docDeptList'); 
// 	navBar.addClass('active');
// 	  });
	  
</script>