<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<style>
</style>

<!-- 메인 content -->
<div class="container-fluid">
	<div class="row clearfix">
        <div class="col-lg-12">
            <div class="card">
                <div class="header">
               	   <span style="color: #a9a9a9; font-family: S-CoreDream-4Regular">전자결재</span>
                   <h3 style="font-family: S-CoreDream-6Bold">결재 양식 등록</h3>
                   
		            <button type="button" class="btn btn-info float-right" style="width:100px; font-family: S-CoreDream-6Bold" onclick="" >초기화</button>
		            <button type="button" class="btn btn-info float-right" style="width:100px; font-family: S-CoreDream-6Bold" onclick="applyForm_go();">양식제출</button>
                </div>
                <div class="body">
                   <div class="box-container">
		            	<div style="border-top: 2px solid rgb(0,0,0,0.2);padding-top:15px;margin-top:30px; font-family: S-CoreDream-6Bold">
				            <h4 >사용자 화면</h4>
		            	</div>
		            	
		            	
						<!-- summernote시작 -->
		            	<div class="summernote" style="height: 700px;">
		            	
		            	<div id="11">
		            	</div>
		            	
		            	<div id="22">
		            	</div>
		            	
		            	
		            	
		            	
		            	
	                    </div>          	
		            	<!-- summernote끝 -->
		            	
		            	
		            	
		            	
						
                   </div>
                </div> 
         	</div>
        </div>
    </div>
</div>






<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
   


<script>

$(document).click(function(){
	console.log($(this));
})











// function applyForm_go() {
// 	console.log($('div .note-editable').html());
// }












</script>