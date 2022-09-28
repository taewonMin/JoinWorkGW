<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- <jsp:include page="../sidebar.jsp" /> --%>
<head>
<script src="<%=request.getContextPath()%>/resources/templates/light/assets/bundles/libscripts.bundle.js"></script>
<script src="<%=request.getContextPath()%>/resources/templates/light/assets/bundles/vendorscripts.bundle.js"></script>
<script src="<%=request.getContextPath()%>/resources/templates/light/assets/bundles/mainscripts.bundle.js"></script>
<script src="<%=request.getContextPath()%>/resources/templates/assets/vendor/sweetalert/sweetalert.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/templates/light/assets/js/pages/ui/dialogs.js"></script>

</head>

<!-- MAIN CSS -->

<style>
.pagination {
	text-align: center;
}

#tr1 {
/* 	text-align: center; */
	padding-left: -10px;
}

tbody {
	text-align: center;
	"
}

.td2 {
	text-align: left;
}

.card{
/* 	text-align: center; */
	padding-bottom: 30px;
}

.button1{
	text-align: right;
    padding-right: 38px;
}

.body{	
    padding-top: 15px;
    padding-left: 17px;
    padding-right: 17px;	
}


</style>

<body>

	<!-- 메인 content -->
	<div id="main-content">
		<div class="container-fluid" style="font-family: S-CoreDream-4Regular" >
			<div class="row clearfix">
				<div class="col-12" style="margin-top: 2%; font-family: S-CoreDream-4Regular" >
					<h2>
						<i class="icon-envelope-letter"></i>&nbsp;경조사
						<button type="button" class="btn btn-secondary float-right" onclick="window.close('<%=request.getContextPath()%>/board/notice/list');"
							style="margin-right: 22px; font-family: S-CoreDream-4Regular" > 
							<i class="icon-close"></i> <span>닫기</span>
						</button>
						<c:if test="${loginUser.empId == cac.empWriterId }">
							<button class="btn btn-danger float-right m-r-5"
								data-type="confirm" onclick="remove_go();">
								<i class="fa fa-trash-o"></i> <span>삭제</span>
							</button>
							<button type="button" class="btn btn-info float-right m-r-5" onclick="modify_go();">
								<i class="fa fa-eraser"></i> <span>수정</span>
							</button>
						</c:if>
					</h2>
					<hr>
				</div>
			</div>
			<div class="div2">
				<div class="row clearfix">
					<div class="col-lg-12 col-md-12">
						<div class="card">
							<div class="body project_report">

								<div class="body">
									<div class="table-responsive">
										<table class="table table-hover m-b-0">
											<thead class="shadow-none p-3 mb-5 bg-light rounded">
								<tr>
									<td style="width:130px;">
										<h6 id="h6" style="font-weight: bold;">제목</h6>
									</td>
									<td colspan="5">
										<div style="padding-left:15px;border-left: 1px dotted gray;">${cac.cacBoardTitle }</div>
									</td>
								</tr>
								<tr>
									<td>
										<strong>행사시작일</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<fmt:parseDate value='${cac.cacStartDt}' var='cacStartDt1' pattern='yyyy-mm-dd'/>
											<fmt:formatDate value="${cacStartDt1}" pattern="yyyy-mm-dd"/>
										</div>
									</td>
									<td>
										<strong>행사종료일</strong>
									</td>
									<td colspan="3">
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<fmt:parseDate value='${cac.cacEndDt}' var='cacEndDt1' pattern='yyyy-mm-dd'/>
											<fmt:formatDate value="${cacEndDt1}" pattern="yyyy-mm-dd"/>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<strong>작성자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">${cac.empName }</div>
									</td>
									<td>
										<strong>작성일자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<fmt:parseDate value='${cac.cacBoardCreateDt}' var='cacBoardCreateDt1' pattern='yyyy-mm-dd'/>
											<fmt:formatDate value="${cacBoardCreateDt1}" pattern="yyyy-mm-dd"/>
										</div>
									</td>
									<td>
										<strong>조회수</strong>
									</td>
									<td>
										<div style="padding-left:15px; border-left: 1px dotted gray;">${cac.cacBoardReadcnt }</div>
									</td>
								</tr>
							</thead>
						</table>
							<!-- 내용 --> <label>  </label>
							<div class="form-group" >
								<div class="form-control"
									style="margin-top: 0px; margin-bottom: 0px; height: 350px; background-color: white;">
									${cac.cacBoardContent}
								</div>
							</div>
					</div>
				</div>
			</div>
			<div class="button1">
<!-- 								<button type="button" class="btn btn-outline-info" > -->
<!-- 									<i class="fa fa-paperclip" >링크복사</i> -->
<!-- 								</button> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<form:form commandName="boardFormVO" name="detailForm" action="${pageContext.request.contextPath }/board/cac/detail">
	<form:hidden path="cacVO.cacBoardId"/>
	<form:hidden path="cacVO.cacBoardTitle"/>
	<form:hidden path="cacVO.cacBoardContent"/>
	<form:hidden path="cacVO.empName"/>
	<form:hidden path="cacVO.cacBoardReadcnt"/>
	<form:hidden path="cacVO.cacBoardCreateDt"/>
	<form:hidden path="cacVO.cacStartDt"/>
	<form:hidden path="cacVO.cacEndDt"/>
</form:form>

<form:form commandName="boardFormVO" name="cacModifyForm" action="${pageContext.request.contextPath }/board/cac/modifyForm">
	<form:hidden path="cacVO.cacBoardId"/>
	<form:hidden path="cacVO.cacBoardTitle"/>
	<form:hidden path="cacVO.cacBoardContent"/>
	<form:hidden path="cacVO.empName"/>
	<form:hidden path="cacVO.cacBoardReadcnt"/>
	<form:hidden path="cacVO.cacBoardCreateDt"/>
	<form:hidden path="cacVO.cacStartDt"/>
	<form:hidden path="cacVO.cacEndDt"/>
</form:form>

<script>
//파일 다운로드
function fileDownload(obj){
	var fileForm = $('form[name="fileForm"]');
	$('input[name="attachId"]').val($(obj).attr('data-attachId'));
	$('input[name="fileUploadPath"]').val($(obj).attr('data-filePath'));
	fileForm.submit();
}

// 수정 페이지
function modify_go(){
	var cacModifyForm = document.detailForm;
	cacModifyForm.action = '${pageContext.request.contextPath }/board/cac/modifyForm';
	
	cacModifyForm.submit();
}

//게시글 삭제
function remove_go(){
	var check = confirm('글을 삭제하시겠습니까?');
	if(!check) return;
	
	var detailForm = document.detailForm;
	detailForm.action = '${pageContext.request.contextPath }/board/cac/remove';
	
	var form = new FormData(detailForm);
	
	$.ajax({
		url:detailForm.action,
		type:'post',
		data:form,
		processData:false,
		contentType:false,
		success:function(){
			alert('글이 삭제되었습니다.');
			window.opener.location.reload(true);
			window.close();
		},
		
		error:function(){
			alert('삭제 실패');
		}
	});
}

</script>
</body>