<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
</style>

<!-- 메인 content -->
<div class="container-fluid">
	<div class="row clearfix">
        <div class="col-lg-12">
            <div class="card" style="font-family: S-CoreDream-7ExtraBold">
                <div class="header">
               	   <span style="color: #a9a9a9;">메뉴 관리</span>
                   <h3>메뉴바 설정</h3>
                   <div class="box-container">
	                   	<div class="card" style="background-color: aliceblue;margin:20px 0;padding:10px;">
	                        <div class="header">
	                            <h5 style="font-weight: bold;">비활성화 설정</h5>
	                        </div>
	                        <div class="body">
	                            <div class="form-group">
		                        	<c:forEach items="${menuList }" var="menu">
		                            	<label class="fancy-checkbox">
	                                        <input type="checkbox" name="checkbox" data-parsley-errors-container="#error-checkbox" data-parsley-multiple="checkbox" <c:if test="${menu.mstate eq 'N'}">checked</c:if> />
	                                        <span>${menu.mname }</span>
	                                    </label>
		                        	</c:forEach>
	                            </div>
	                        </div>
	                   	</div>
	                   	<button type="button" class="btn btn-primary" style="float:right;" onclick="updateMenu();">변경사항 저장</button>
	                   	<div style="clear:both;"></div>
		            	<div style="border-top: 2px solid rgb(0,0,0,0.2);padding-top:15px;margin-top:30px;">
				            <h4>사용자 화면</h4>
				            <iframe src="${pageContext.request.contextPath }/common/home" style="width:100%;height:80vh;margin-top:15px;border:none;pointer-events:none;"></iframe>
		            	</div>
                   </div>
                </div>
         	</div>
        </div>
    </div>
</div>

<form name="menuForm">

</form>


<script>
function updateMenu(){
	var form = $('form[name="menuForm"]');
	form.children().remove();
	
	$('input[name="checkbox"]').each(function(){
		var value = "Y";
		if($(this).is(':checked')){
			value = "N";
		}
		var checkTag = $('<input>').attr({'type':'hidden','name':'menuList','value':value});
		form.append(checkTag);
	});
	
	var formData = new FormData(form[0]);
	$.ajax({
		url:'${pageContext.request.contextPath }/admin/menu/modify',
		type:'post',
		data:formData,
		contentType:false,
		processData:false,
		success:function(){
			alert('변경사항이 저장되었습니다.');
			$('iframe').attr('src','${pageContext.request.contextPath }/common/home');
		},
		error:function(){
			alert('메뉴 업데이트 실패');
		}
	});
}
</script>