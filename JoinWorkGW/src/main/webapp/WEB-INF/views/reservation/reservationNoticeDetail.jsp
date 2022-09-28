<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">


<style>
.attachList {
	cursor: pointer;
	font-weight: normal;
}
.attachList:hover {
	color: blue;
	text-decoration: underline;
}
</style>

<!-- 메인 content -->
<div id="main-content" >
	<div class="container-fluid" >
			<form:form commandName="meetRoomFormVO" name="detailForm" action="${pageContext.request.contextPath }/reservation/noticeDeatil">
				<form:hidden path="reservationNoticeVO.reservationNoticeId" value="${noticeVO.reservationNoticeId}" />
			<div class="block-header">
	            <div class="row">
	            	<div class="col-sm-5">
	                	<h2 style="padding-left:10px;font-size:2em; font-family: S-CoreDream-6Bold"><i class="icon-drawer" style="font-size: 20px; "></i>&nbsp;시설예약 공지</h2>
	                </div>
	                <div class="col-sm-7" style="font-family: S-CoreDream-6Bold">
	               		<div style="float:right;">
	               			<c:if test="${loginUser.empId == noticeVO.empId }">
		                    	<button type="button" class="btn btn-danger" style="width:80px;" onclick="remove_go();">삭제</button>
	               			</c:if>
	                    	<button type="button" onclick="window.close();" class="btn btn-secondary" style="width:80px;">닫기</button>
	                	</div>
	             	</div>
	            </div>
	        </div>
	        <div class="row clearfix">
	            <div class="col-lg-12 col-md-12 col-sm-12" style="font-family: S-CoreDream-6Bold">
	                 <div class="body">
	                     <div class="row clearfix">
	                      <div class="table-responsive" style="padding:5px 15px;">
	                      	
							<table class="table table-hover m-b-0">
								<thead class="shadow-none p-3 mb-5 bg-light rounded">
									<tr>
										<td style="width:130px;">
											<strong>제목</strong>
										</td>
										
										<td colspan="7">
											<div style="padding-left:15px;border-left: 1px dotted gray;">${noticeVO.reservationNoticeTitle }</div>
										</td>
									</tr>
									<tr>
										<td>
											<strong>작성자</strong>
										</td>
										<td style="width:200px;">
											<div style="padding-left:15px;border-left: 1px dotted gray;">관리자</div>
										</td>
										<td style="width:130px;">
											<strong>작성일자</strong>
										</td>
										<td colspan="3">
											<div style="padding-left:15px;border-left: 1px dotted gray;">
												${noticeVO.reservationNoticeCreateDate }
											</div>
										</td>
									</tr>
									<!-- 내용 -->
									<tr>
										<th colspan="8" style="padding:15px; font-family: S-CoreDream-4Regular">
										내용 : <br>
											${noticeVO.reservationNoticeContent }
										</th>
									</tr>
								</thead>
							</table>
							</div>
						</div>
	                 </div>
	            </div>
	        </div>
	        </form:form>
	</div>
</div>




<script type="text/javascript">



// 게시글 삭제
function remove_go(){
	var check = confirm('문서를 삭제하시겠습니까?');
	if(!check) return;
	
	var detailForm = document.detailForm;
	detailForm.action = '${pageContext.request.contextPath }/reservation/reservationNoticeRemove';
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