<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 메인 content -->
<div class="container-fluid">
	<div class="row clearfix">
        <div class="col-lg-12">
            <div class="card">
                <div class="header">
               	   <span style="color: #a9a9a9; font-family: S-CoreDream-4Regular">업무시간 관리</span>
                   <h3 style="font-family: S-CoreDream-6Bold">업무시간 설정</h3>
                   <div class="box-container">
                   		<form name="timeForm" action="${pageContext.request.contextPath }/admin/time/modify">
		                   	<div class="card" style="background-color: aliceblue;margin:20px 0;padding:10px;">
		                        <div class="header" style="font-family: S-CoreDream-6Bold">
		                            <h5 style="font-weight: bold;">출근/퇴근/점심시간 설정</h5>
		                        </div>
		                        <div class="body" style="font-family: S-CoreDream-4Regular">
		                            <div class="form-group" style="padding:0 15px;">
			                            <h2>출근 시간</h2>
			                            <div class="form-group" style="margin-top:15px;">
			                            	<div class="row clearfix">
			                                    <div class="col-lg-3 col-md-6">
			                                        <div class="input-group mb-3">
			                                            <input type="time" class="form-control" name="attendTime" style="font-size:1.4em;" value="${time.attendTime }">
			                                        </div>
			                                    </div>
			                                </div>
			                            </div>
		                            </div>
		                            <div class="form-group" style="padding:0 15px;">
			                            <h2>점심 시간</h2>
			                            <div class="form-group" style="margin-top:15px;">
			                            	<div class="row clearfix">
			                                    <div class="col-lg-3 col-md-6">
			                                        <div class="input-group mb-3">
			                                            <input type="time" class="form-control" name="lunchStartTime" style="font-size:1.4em;" value="${time.lunchStartTime }">
			                                        </div>
			                                    </div>
			                                    <span style="font-size:2em;">~</span>
			                                    <div class="col-lg-3 col-md-6">
			                                        <div class="input-group mb-3">
			                                            <input type="time" class="form-control" name="lunchEndTime" style="font-size:1.4em;" value="${time.lunchEndTime }">
			                                        </div>
			                                    </div>
			                                </div>
			                            </div>
		                            </div>
		                            <div class="form-group" style="padding:0 15px;">
			                            <h2>퇴근 시간</h2>
			                            <div class="form-group" style="margin-top:15px;">
			                            	<div class="row clearfix">
			                                    <div class="col-lg-3 col-md-6">
			                                        <div class="input-group mb-3">
			                                            <input type="time" class="form-control" name="leavingTime" style="font-size:1.4em;" value="${time.leavingTime }">
			                                        </div>
			                                    </div>
			                                </div>
			                            </div>
		                            </div>
		                        </div>
		                   	</div>
		                   	<button type="button" class="btn btn-primary" style="float:right; font-family: S-CoreDream-6Bold" onclick="modifyTime();" >변경사항 저장</button>
		                   	<button type="reset" class="btn btn-dark" style="float:right;margin-right:15px; font-family: S-CoreDream-6Bold"><i class="fa fa-refresh"></i> <span>초기화</span></button>
		                   	<div style="clear:both;"></div>
	                   	</form>
                   </div>
                </div>
         	</div>
        </div>
    </div>
</div>

<script>
function modifyTime(){
	var form = $('form[name="timeForm"]')[0];
	$.ajax({
		url:form.action,
		type:'post',
		data:new FormData(form),
		contentType:false,
		processData:false,
		success:function(){
			alert('변경사항이 저장되었습니다.');
		},
		error:function(){
			alert('시간 저장 실패');
		}
	});
}
</script>