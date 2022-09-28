<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.cookie.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.edit.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/treeview/jquery.treeview.async.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<!-- 메인 content -->
<div id="main-content">
	<div class="container-fluid">
		<div class="block-header">
            <div class="row">
            	<div class="col-sm-5">
                	<h2 style="padding-left:10px;font-size:2em; font-family: S-CoreDream-4Regular"><i class="icon-note"></i>&nbsp;공지 작성</h2>
                </div>
                <div class="col-sm-7" >
               		<div style="float:right; font-family: S-CoreDream-4Regular">
                    	<button type="button" class="btn btn-primary" style="width:80px;" onclick="regist_go();">등록</button>
                    	<button type="button" onclick="window.close();" class="btn btn-secondary" style="width:80px;">취소</button>
                	</div>
             	</div>
            </div>
        </div>
        <div class="row clearfix" style="font-family: S-CoreDream-4Regular">
            <div class="col-lg-12 col-md-12 col-sm-12">
            	<form:form commandName="meetRoomFormVO" name="noticeModifyForm" action="${pageContext.request.contextPath }/reservation/registNotice" enctype="multipart/form-data">
		          	<form:hidden path="reservationNoticeVO.reservationNoticeId"/>
		          	<form:hidden path="reservationNoticeVO.reservationNoticeContent" id="noticeContent"/>
		          	<form:hidden path="reservationNoticeVO.empId" value="${loginUser.empId }"/>
		          	<form:hidden path="reservationNoticeVO.reservationNoticeCreateDate" id="noticeDate"/>
                 <div class="body">
                     <div class="row clearfix">
                      <div class="table-responsive" style="padding:5px 15px;">
                        
						<table class="table table-hover m-b-0">
							<thead class="shadow-none p-3 mb-5 bg-light rounded">
							<!-- 게시판 선택 -->
								<tr>
		                        </tr>
								<tr>
									<td style="width:130px;">
										<strong>제목</strong>
									</td>
									<td colspan="5">
										<div style="padding-left:15px;border-left: 1px dotted gray;">
											<form:textarea class="form-control" path="reservationNoticeVO.reservationNoticeTitle" style="width:100%;"></form:textarea>
<!-- 											 class="form-control" type="text" name="title" id="edit-title" required="required"  -->
										</div>
									</td>
								</tr>
								
								<tr>
									
									<td style="width:130px;">
										<strong>작성자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;">관리자</div>
									</td>
									<td>
										<strong>작성일자</strong>
									</td>
									<td>
										<div style="padding-left:15px;border-left: 1px dotted gray;" >
											<p id="date">
										</div>
									</td>
								</tr>
								<!-- 내용 -->
								<tr>
									<th colspan="6" style="padding:15px;">
										<div class="summernote">
	                                    </div>
									</th>
								</tr>
							</thead>
						</table>
						</div>
					</div>
                 </div>
			</form:form>
            </div>
        </div>
	</div>
</div>

<script>
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	var day = today.getDate();
	var format = year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+day.toString()).slice(-2));
	$('#date').text(format);
	
</script>


<script>

function regist_go(){
	var modifyForm = $('form[name="noticeModifyForm"]')[0];
	if($.trim($('.note-editable').text())==""){
		alert('공지 내용을 입력하세요.');
		$('.note-editable').focus();
		return;
	}
	$('#noticeContent').val($('.note-editable').text());
	$('#noticeDate').val($('#date').text());
	
	
	var formData = new FormData(modifyForm);
		
		$.ajax({
			url:modifyForm.action,
			type:'post',
			data:formData,
			processData:false,
			contentType:false,
			success:function(){
				alert("글이 생성되었습니다.");
				opener.location.reload();
				window.close();
			},
			error:function(){
				alert("글 생성에실패했습니다.");
			}
		});
		
}

</script>