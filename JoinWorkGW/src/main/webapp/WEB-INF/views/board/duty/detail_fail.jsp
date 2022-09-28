<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
window.onload=function(){
	
	alert('삭제된 게시글입니다.');
	
	$.ajax({
		url:'<c:url value="/common/alarm/remove"/>',
		type:'post',
		data:{empReaderId:'${loginUser.empId}',alarmId:'${alarmId}'},
		success:function(){
			window.opener.location.reload(true);
			close();
		},
		error:function(){
			alert('알림 삭제 실패');
		}
	});
}
</script>
