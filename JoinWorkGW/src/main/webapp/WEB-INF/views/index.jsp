<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
 	<c:if test="${empty loginUser}" >
		location.href="<%=request.getContextPath()%>/common/loginForm";
 	</c:if>
 	<c:if test="${!empty loginUser}" >
 		<c:if test="${!empty myCurrentParameter}" >
 			location.href="${myCurrentURL}?docId=${myCurrentParameter}";
 		</c:if>
 		<c:if test="${empty myCurrentParameter}" >
	 		location.href="<%=request.getContextPath()%>/common/home";
		</c:if>
	</c:if>
</script>