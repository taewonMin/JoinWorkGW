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
                   <h3 style="display:inline-block; font-family: S-CoreDream-6Bold">시스템 파일 설정</h3>
                   <span style="font-size: 1.3em;color: rgb(0,0,0,0.5);font-weight: bold;margin-left: 15px; font-family:S-CoreDream-4Regular ">파일을 클릭하여 내용을 수정할 수 있습니다.</span>
                   <div class="row clearfix" style="font-family: S-CoreDream-6Bold">
		                <div class="col-lg-12 col-md-12" style="margin-top:50px;">
		                	<c:forEach items="${fileList }" var="file">
			                	<button type="button" class="btn btn-outline-info fileShowBtn" data-name="${file.fileName }" data-time="${file.lastModified }" data-content="${file.fileContent }" style="width:300px;height:250px;font-size:1.5em;margin-right:15px;" onclick="openModifyWindow(this);">
			                		<div style="height:200px;padding-top:50px;">
				                		<i class="fa fa-file-text fa-3x" style="margin-bottom:15px;"></i><br>
				                		<span>${file.fileName }</span><br>
			                		</div>
			                		<div>
				                		<span class="float-right" style="font-size:0.8em;">${file.lastModified.split(' ')[0] }</span>
			                		</div>
		                		</button>
		                	</c:forEach>
			            </div>
			            <div id="modifyFileWindow" class="col-lg-12 col-md-12" style="margin-top:30px;display:none;">
			            	<div style="border-top: 2px solid rgb(0,0,0,0.2);padding-top:15px;">
					            <h4 style="display:inline-block;">파일이름</h4>
					            <span style="margin-left:15px;color:gray;">마지막 수정시간 : <strong>2021.04.15 09:12:13</strong></span>
					            <button type="button" class="btn btn-danger float-right" style="width:200px;" onclick="adminCheck();">수정</button>
					            <textarea rows="10" style="width:100%;margin-top:15px;padding:10px;">내용</textarea>
			            	</div>
			            </div>
		            </div>
                </div>
         	</div>
        </div>
    </div>
</div>

<script>
function openModifyWindow(obj){
	$('button.fileShowBtn').removeClass('active');
	$(obj).addClass('active');
	var fileName = $(obj).attr('data-name');
	var lastModified = $(obj).attr('data-time');
	var fileContent = $(obj).attr('data-content');
	
	$('#modifyFileWindow h4').text(fileName);
	$('#modifyFileWindow strong').text(lastModified);
	$('#modifyFileWindow textarea').val(fileContent);
	$('#modifyFileWindow').css('display','');
}

function adminCheck(){
	var adminPassCheck = "";
	while($.trim(adminPassCheck)==""){
		adminPassCheck = prompt('관리자 비밀번호를 입력하세요.');
	}
	
	$.ajax({
		url:'<c:url value="/admin/auth"/>',
		type:'post',
		data:{empId:'${loginUser.empId}',empPwd:adminPassCheck},
		success:function(msg){
			if(msg){
				alert(msg);
				return;
			}else{
				modifyFile();
			}
		},
		error:function(){
			alert('서버 에러 발생');
		}
	});
}

function modifyFile(){
	var fileName = $('#modifyFileWindow h4').text();
	var fileContent = $('#modifyFileWindow textarea').val();
	
	var check = confirm('설정 파일을 수정하면 치명적인 오류를 초래할 수 있습니다. 수정하시겠습니까?');
	if(!check) return;
	
	$.ajax({
		url:'<c:url value="/admin/resource/setting/modify"/>',
		type:'post',
		data:{fileName:fileName, fileContent:fileContent},
		success:function(){
			alert('설정 파일이 수정되었습니다.');
		},
		error:function(){
			alert('파일 수정 실패');
		}
	});
}
</script>