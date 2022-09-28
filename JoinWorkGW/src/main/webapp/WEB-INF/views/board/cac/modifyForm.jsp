<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<%-- <jsp:include page="../sidebar.jsp" /> --%>
<head>
<!-- VENDOR CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/assets/vendor/sweetalert/sweetalert.css"/>

<!-- MAIN CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/templates/light/assets/css/main.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/templates/light/assets/css/color_skins.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/templates/light/assets/fonts/font.css">

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
					</h2>
					<hr>
				</div>
			</div>
			<div class="div2">
				<div class="row clearfix">
					<div class="col-lg-12 col-md-12">
					<form:form commandName="boardFormVO" name="cacModifyForm" action="${pageContext.request.contextPath }/board/cac/modify">
						<form:hidden path="cacVO.cacBoardId" />
			          	<form:hidden path="cacVO.cacBoardContent" id="cacBoardContent"/>
			          	<form:hidden path="cacVO.cacBoardUpdaterId" value="${loginUser.empId }"/>
			          	<form:hidden path="cacVO.empName"/>
			          	<form:hidden path="cacVO.empWriterId" value="${loginUser.empId }"/>
			          	<div id="fileUploadForm">
			          	</div>
		          		<div id="deleteFile">
		          		</div>
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
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<form:textarea path="cacVO.cacBoardTitle" style="width: 100%; height: 35px; "/>
										</div>
									</td>
								</tr>
								<tr>
									<td >
										<strong>행사시작일</strong>
									</td>
<!-- 									<td> -->
<!-- 										<div style="padding-left:15px;border-left: 1px dotted gray;"> -->
<%-- 											<fmt:parseDate value='${cac.cacStartDt}' var='cacStartDt1' pattern='yyyy-mm-dd'/> --%>
<%-- 											<fmt:formatDate value="${cacStartDt1}" pattern="yyyy-mm-dd"/> --%>
<!-- 										</div> -->
<!-- 									</td> -->
										<td style="width:220px;">
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<div class="input-group date" data-date-autoclose="true" data-provide="datepicker" >
			                                 	<input type="text" name="cacVO.cacStartDt" class="form-control" id="cacStartDt"  readonly="readonly" value="${boardFormVO.cacVO.cacStartDt } "
			                                 	/>
				                                <div class="input-group-append">                                            
				                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
				                                </div>
			                                </div>
										</div>
									</td>
									<td>
										<strong>행사종료일</strong>
									</td>
<!-- 									<td colspan="3"> -->
<!-- 										<div style="padding-left:15px;border-left: 1px dotted gray;"> -->
<%-- 											<fmt:parseDate value='${cac.cacEndDt}' var='cacEndDt1' pattern='yyyy-mm-dd'/> --%>
<%-- 											<fmt:formatDate value="${cacEndDt1}" pattern="yyyy-mm-dd"/> --%>
<!-- 										</div> -->
<!-- 									</td> -->
									<td style="width:220px;" >
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<div class="input-group date" data-date-autoclose="true" data-provide="datepicker">
			                                 	<input type="text" name="cacVO.cacEndDt" class="form-control" id="cacEndDt"  readonly="readonly"
<%-- 													value="<fmt:parseDate value="${boardFormVO.cacVO.cacEndDt }" var='cacEndDt1' pattern="yyyy-mm-dd"/> --%>
<%-- 															<fmt:formatDate value="${cacEndDt1}" pattern="yyyy-mm-dd"/>"   --%>
														value="${boardFormVO.cacVO.cacEndDt }" />
													
				                                <div class="input-group-append">                                            
				                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
				                                </div>
			                                </div>
										</div>
									</td>
									<td colspan="2">
									</td>
								</tr>
								<tr>
									<td>
										<strong>작성자</strong>
									</td>															
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">${boardFormVO.cacVO.empName }</div>
									</td>
									<td>
										<strong>작성일자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">
<%-- 											<fmt:parseDate value='${boardFormVO.cacVO.cacBoardCreateDt}' var='cacBoardCreateDt1' pattern='yyyy-mm-dd'/> --%>
<%-- 											<fmt:formatDate value="${boardFormVO.cacVO.cacBoardCreateDt1}" pattern="yyyy-mm-dd"/> --%>
											<fmt:parseDate value="${boardFormVO.cacVO.cacBoardCreateDt }" var='cacBoardCreateDt1' pattern="yyyy-mm-dd"/>
											<fmt:formatDate value="${cacBoardCreateDt1}" pattern="yyyy-mm-dd"/>
											
<%-- 												${boardFormVO.cacVO.cacBoardCreateDt } --%>
										</div>
									</td>
									<td>
										<strong>조회수</strong>
									</td>
									<td>
										<div style="padding-left:15px; border-left: 1px dotted gray;">${boardFormVO.cacVO.cacBoardReadcnt }</div>
									</td>
								</tr>
								<tr>
									<th colspan="6" style="padding:15px;">
										<div class="summernote">${boardFormVO.cacVO.cacBoardContent }</div>
									</th>
								</tr>
										</thead>
									</table>
									<div class="modifySuccessbutton" style="text-align: center; margin-top: 7px;">
                           				<button class="btn btn-primary " data-type="success" onclick="modify_go();" >수정완료</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>

<%-- <form name="fileForm" action="${pageContext.request.contextPath }/common/getFile" method="post"> --%>
<!-- 	<input type="hidden" name="fileUploadPath"/> -->
<!-- 	<input type="hidden" name="attachId"/> -->
<%-- </form> --%>

<!--  
<script type="text/javascript">
    $('.input-group.date').datepicker({
        dateFormat: 'yyyy-mm-dd' 
   });
</script>
-->




<script>
window.onload=function(){
	var cacStartDt = $('input#cacStartDt').val().split(' ')[0].split('-');
	   $('input#cacStartDt').val(cacStartDt[1]+"/"+cacStartDt[2]+"/"+cacStartDt[0]);
	var cacEndDt = $('input#cacEndDt').val().split(' ')[0].split('-');
	   $('input#cacEndDt').val(cacEndDt[1]+"/"+cacEndDt[2]+"/"+cacEndDt[0]);
}


//열고 닫는 함수입니다.
function plusFromMinus(obj){
	if($(obj).hasClass("expandable-hitarea")){
		$(obj).parent("li").removeClass("expandable lastExpandable");
		$(obj).parent("li").addClass("collapsable lastCollapsable");
		$(obj).removeClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).addClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).parent("li").children("ul").css("display","block");
	}else{
		$(obj).parent("li").removeClass("collapsable lastCollapsable");
		$(obj).parent("li").addClass("expandable lastExpandable");
		$(obj).removeClass("hitarea collapsable-hitarea lastCollapsable-hitarea");
		$(obj).addClass("hitarea expandable-hitarea lastExpandable-hitarea");
		$(obj).parent("li").children("ul").css("display","none");
	}
}

//수정
function modify_go(){
	var modifyForm = $('form[name="cacModifyForm"]')[0];
	
	if($.trim($('textarea[name="cacVO.cacBoardTitle"]').val())==""){
		alert('제목을 입력하세요.');
		$('textarea[name="cacVO.cacBoardTitle"]').focus();
		return;
	}
	
	if($.trim($('.note-editable').text())==""){
		alert('내용을 입력하세요.');
		$('.note-editable').focus();
		return;
	}
	$('#cacBoardContent').val($('.note-editable').html());

	var formData = new FormData(modifyForm);
	$.ajax({
		url:modifyForm.action,
		type:'post',
		data:formData,
		processData:false,
		contentType:false,
		success:function(data){
			alert("글이 수정되었습니다.");
			
// 			$('input[name="noticeVO.empManagerList"]').each(function(){
// 				var empId = $(this).val();

			window.location.href='<c:url value="/board/cac/detail?cacBoardId=${boardFormVO.cacVO.cacBoardId}" />';	
		},
		error:function(){
			alert("글 수정에 실패했습니다.");
			window.location.href='<c:url value="/board/cac/detail?cacBoardId=${boardFormVO.cacVO.cacBoardId}" />';	
		}
	});
}

</script>



</body>
