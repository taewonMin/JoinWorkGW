<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/templates/light/assets/fonts/font.css">

<body>
<!-- Overlay For Sidebars -->
    <div id="main-content">
        <div class="container-fluid">
            <div class="block-header">
                <div class="row" >
                	<div class="col-sm-3" >
                    	<h2 style="padding-left:10px; font-size:2em ; font-family:paybooc-Bold ; "><i class="icon-note"></i>&nbsp;마일스톤 
                    		<c:if test="${milestoneVO.milestoneId eq 0 }">
                    			생성
                    		</c:if>
                    		<c:if test="${milestoneVO.milestoneId ne 0 }">
                    			수정
                    		</c:if>
                    	</h2>
                    </div>
                    <div class="col-sm-9" >
                   		<div style="float:right;">
                   			<c:if test="${milestoneVO.milestoneId eq 0 }">
	                        	<button type="button" class="btn btn-primary" style="width:100px;font-size:1.2em;" onclick="registMilestone();">등록</button>
                   			</c:if>
                   			<c:if test="${milestoneVO.milestoneId ne 0}">
	                        	<button type="button" class="btn btn-primary" style="width:100px;font-size:1.2em; font-family: S-CoreDream-6Bold" onclick="modifyMilestone();">저장</button>
	                        	<c:if test="${milestoneVO.milestoneSt eq 'Y' }">
		                        	<button type="button" class="btn btn-danger" style="width:150px;font-size:1.2em; font-family: S-CoreDream-6Bold" onclick="changeMilestone();">마일스톤 종료</button>
	                        	</c:if>
	                        	<c:if test="${milestoneVO.milestoneSt eq 'N' }">
		                        	<button type="button" class="btn btn-success" style="width:150px;font-size:1.2em; font-family: S-CoreDream-6Bold" onclick="changeMilestone();">마일스톤 재시작</button>
	                        	</c:if>
                   			</c:if>
                        	<button type="button" onclick="window.close();" class="btn btn-secondary" style="width:100px;font-size:1.2em; font-family: S-CoreDream-6Bold">취소</button>
                    	</div>
                 	</div>
                </div>
            </div>

			<form:form commandName="milestoneVO" name="registForm">
				<form:hidden path="milestoneId" />
	            <div class="row clearfix">
	                <div class="col-lg-12 col-md-12 col-sm-12" style="font-family: S-CoreDream-4Regular">
	                    <div class="card">
	                        <div class="body">
	                            <div class="row clearfix">
		                             
		                             <!-- 본문 -->
		                             <div class="col-md-3 col-sm-12">
		                                 <label>작성자</label>
		                                 <div class="form-group">
		                                    <form:hidden path="empId" readonly="true" class="form-control" value="${loginUser.empId }" />
		                                    <form:input path="empName" readonly="true" class="form-control" value="${loginUser.empName }" />
		                                 </div>
		                             </div>
									 <div class="col-sm-12" style="display: block;">
		                                 <div class="form-group">
		                                 <label>마일스톤 이름</label>
	                                     	<form:input path="milestoneName" class="form-control" />
		                                 </div>
		                             </div>
		                             
		                             <div class="col-sm-4">
	                                 	<div class="form-group">
	                                 		<label>마감 기한(선택)</label>
	                                 		<div class="input-group date" data-date-autoclose="true" data-provide="datepicker">
				                                <form:input path="milestoneEndDt" class="form-control" placeholder="마감기한 선택" readonly="true"/>
				                                <div class="input-group-append">                                            
				                                    <button class="btn btn-outline-secondary" type="button"><i class="fa fa-calendar"></i></button>
				                                </div>
			                                </div>
	                                 	</div>
	                                 </div>
	                            </div>
	                               
	                        </div>
	                    </div>
	                </div>
	            </div>
            </form:form>
        </div>
	</div>

<script>
// 등록
function registMilestone(){
	$.ajax({
		url:'<c:url value="/board/milestone/regist"/>',
		type:'post',
		data:$('form[name="registForm"]').serialize(),
		success:function(){
			alert('마일스톤이 생성되었습니다.');
			window.opener.location.href='${pageContext.request.contextPath}/board/milestone/list';
			window.close();
		},
		error:function(){
			alert('등록 실패');
		}
	});
}

// 수정
function modifyMilestone(){
	$.ajax({
		url:'<c:url value="/board/milestone/modify"/>',
		type:'post',
		data:$('form[name="registForm"]').serialize(),
		success:function(){
			alert('마일스톤이 수정되었습니다.');
			window.opener.location.href='${pageContext.request.contextPath}/board/milestone/list?isOpen='+('${milestoneVO.milestoneSt}' == 'Y' ? 'open' : 'closed');
			window.close();
		},
		error:function(){
			alert('등록 실패');
		}
	});
}

// 종료/재시작
function changeMilestone(){
	$.ajax({
		url:'<c:url value="/board/milestone/modify"/>',
		type:'post',
		data:{milestoneId:'${milestoneVO.milestoneId}',milestoneSt:('${milestoneVO.milestoneSt}' == 'Y' ? 'N' : 'Y')},
		success:function(){
			window.opener.location.href='${pageContext.request.contextPath}/board/milestone/list?isOpen='+('${milestoneVO.milestoneSt}' == 'Y' ? 'closed' : 'open');
			window.close();
		},
		error:function(){
			alert('등록 실패');
		}
	});
}
</script>
</body>
