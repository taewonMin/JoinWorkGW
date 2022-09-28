<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- REQUIRED SCRIPTS -->

<!-- template Javascript -->
<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/libscripts.bundle.js"></script>
<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/vendorscripts.bundle.js"></script>

<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/jvectormap.bundle.js"></script> <!-- JVectorMap Plugin Js -->
<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/morrisscripts.bundle.js"></script><!-- Morris Plugin Js -->
<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/knob.bundle.js"></script> <!-- Jquery Knob-->
<script src="<%=request.getContextPath() %>/resources/templates/assets/vendor/nestable/jquery.nestable.min.js"></script> <!-- Jquery Nestable -->

<script src="<%=request.getContextPath() %>/resources/templates/light/assets/bundles/mainscripts.bundle.js"></script>
<script src="<%=request.getContextPath() %>/resources/templates/light/assets/js/pages/ui/sortable-nestable.js"></script>

<script src="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script><!-- bootstrap datepicker Plugin Js --> 
<script src="<%=request.getContextPath() %>/resources/templates/assets/vendor/bootstrap-multiselect/bootstrap-multiselect.js"></script>
<script src="<%=request.getContextPath() %>/resources/templates/assets/vendor/dropify/js/dropify.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/templates/light/assets/js/pages/forms/dropify.js"></script>

<!-- 알림 창 -->
<script src="${pageContext.request.contextPath }/resources/templates/assets/vendor/toastr/toastr.js"></script>

<!-- summernote -->
<script src="${pageContext.request.contextPath }/resources/templates/assets/vendor/summernote/dist/summernote.js"></script>

<!-- common -->
<script src="${pageContext.request.contextPath }/resources/js/common.js?v=1"></script>

<!-- websocket -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script>
$(document).ready(function(){
	connectWs('<c:url value="/echo-ws"/>');
});
</script>