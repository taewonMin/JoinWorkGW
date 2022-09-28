<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	if('${msg}'){
		alert('시스템 관리자 권한이 없습니다.');
	}else{
		alert('관리자 권한이 없습니다.');
	}
	history.go(-1);
</script>
